Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49iduSKK+BeSUlFClTI04mcLu3TV3hBRj/6B3etlZpFzLZukbY8QbdvmQiP0Sg51iUHtcKs
ARC-Seal: i=1; a=rsa-sha256; t=1523399831; cv=none;
        d=google.com; s=arc-20160816;
        b=BBmPTxKjyC2tRFMv5xCQ6u7Q8FY2DN07GRPelyNE/yOFndS8CIWCEWsbNOGSFBtxA6
         mz1o+uk3CxImuBchSUxXpxHRLqAD/IdY+pUGA+tUt20Y38SfYX8oyqg9hlVpcM1M4dvE
         hWZpG7fKWhfUzeijBQrYdyHck32EL7sZtRdC01NhmV864pezwK9FH/WMNUsPv1Q6AZMt
         MMZLlV/BsOJhlAWs/DnE7rwfdm60RxKD7ObuHzy2veebe+IDVjUuyd2Y4/5EuO2cS0Rx
         A4SMJFvHshS53oLNSuh2CM0D9Lty3UgVFpmjP8mtJ8X68PLUY9inGZjGiYg5g97qrkMP
         JJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e+6Aqe5Y7UoZxpRKVE3lwyIPAYEeLGLtmBgMsDqss5Y=;
        b=iImqWdvaNn2gIaGIavpaSdH3VGk6qxoCG8K8CWjvIs2lf7sY0F6F2erIEW/VtCQgvf
         E9BCTm5ezthbo0piHnaNyLwI4zYS8LNzxHxhuD19q4yoOZoJGOKRqlXy/LnN3CI2Rhcj
         Lmk6E5mERVKIzwB5Hk8GKS1rAkdNMZB71hFUNL+G3350/qzd7u7cGJE7lIkLxoPsyisS
         BMjcxsI1awTV7Te/P9e6G+6d+aOlc6WshX+Tkf5w5EVQfBl8eDpEW/lrp67Y1Atu/SxN
         RjD2flH5aNPbg6PzYfELdiO36lREXI+yqs9FXRDu7XRn3op2JcmMnQUrFiLxlQ3ekXgz
         EOGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Biener <rguenther@suse.de>,
	Jakub Jelinek <jakub@gcc.gnu.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 079/138] crypto: aes-generic - build with -Os on gcc-7+
Date: Wed, 11 Apr 2018 00:24:29 +0200
Message-Id: <20180410212911.294522896@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400077202338175?=
X-GMAIL-MSGID: =?utf-8?q?1597400501602142045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 148b974deea927f5dbb6c468af2707b488bfa2de ]

While testing other changes, I discovered that gcc-7.2.1 produces badly
optimized code for aes_encrypt/aes_decrypt. This is especially true when
CONFIG_UBSAN_SANITIZE_ALL is enabled, where it leads to extremely
large stack usage that in turn might cause kernel stack overflows:

crypto/aes_generic.c: In function 'aes_encrypt':
crypto/aes_generic.c:1371:1: warning: the frame size of 4880 bytes is larger than 2048 bytes [-Wframe-larger-than=]
crypto/aes_generic.c: In function 'aes_decrypt':
crypto/aes_generic.c:1441:1: warning: the frame size of 4864 bytes is larger than 2048 bytes [-Wframe-larger-than=]

I verified that this problem exists on all architectures that are
supported by gcc-7.2, though arm64 in particular is less affected than
the others. I also found that gcc-7.1 and gcc-8 do not show the extreme
stack usage but still produce worse code than earlier versions for this
file, apparently because of optimization passes that generally provide
a substantial improvement in object code quality but understandably fail
to find any shortcuts in the AES algorithm.

Possible workarounds include

a) disabling -ftree-pre and -ftree-sra optimizations, this was an earlier
   patch I tried, which reliably fixed the stack usage, but caused a
   serious performance regression in some versions, as later testing
   found.

b) disabling UBSAN on this file or all ciphers, as suggested by Ard
   Biesheuvel. This would lead to massively better crypto performance in
   UBSAN-enabled kernels and avoid the stack usage, but there is a concern
   over whether we should exclude arbitrary files from UBSAN at all.

c) Forcing the optimization level in a different way. Similar to a),
   but rather than deselecting specific optimization stages,
   this now uses "gcc -Os" for this file, regardless of the
   CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE/SIZE option. This is a reliable
   workaround for the stack consumption on all architecture, and I've
   retested the performance results now on x86, cycles/byte (lower is
   better) for cbc(aes-generic) with 256 bit keys:

			-O2     -Os
	gcc-6.3.1	14.9	15.1
	gcc-7.0.1	14.7	15.3
	gcc-7.1.1	15.3	14.7
	gcc-7.2.1	16.8	15.9
	gcc-8.0.0	15.5	15.6

This implements the option c) by enabling forcing -Os on all compiler
versions starting with gcc-7.1. As a workaround for PR83356, it would
only be needed for gcc-7.2+ with UBSAN enabled, but since it also shows
better performance on gcc-7.1 without UBSAN, it seems appropriate to
use the faster version here as well.

Side note: during testing, I also played with the AES code in libressl,
which had a similar performance regression from gcc-6 to gcc-7.2,
but was three times slower overall. It might be interesting to
investigate that further and possibly port the Linux implementation
into that.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83651
Cc: Richard Biener <rguenther@suse.de>
Cc: Jakub Jelinek <jakub@gcc.gnu.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_CRYPTO_TWOFISH_COMMON) += t
 obj-$(CONFIG_CRYPTO_SERPENT) += serpent_generic.o
 CFLAGS_serpent_generic.o := $(call cc-option,-fsched-pressure)  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=79149
 obj-$(CONFIG_CRYPTO_AES) += aes_generic.o
+CFLAGS_aes_generic.o := $(call cc-ifversion, -ge, 0701, -Os) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83356
 obj-$(CONFIG_CRYPTO_AES_TI) += aes_ti.o
 obj-$(CONFIG_CRYPTO_CAMELLIA) += camellia_generic.o
 obj-$(CONFIG_CRYPTO_CAST_COMMON) += cast_common.o
