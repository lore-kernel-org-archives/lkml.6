Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+yYaUvnY2+B3AZxgqYH+f2MvAGSRTSRiGX5PPot1YqvzyJMQm59LC2bxK7Os7j+u6fkTne
ARC-Seal: i=1; a=rsa-sha256; t=1523022282; cv=none;
        d=google.com; s=arc-20160816;
        b=yj3MguNpMGVq1cXb3rq8jvCdKF+rp7PB0PViB7Ha/02v8weY28Ulaywt7KrkJBn4UW
         PK4e+ahyXgv+3z/zrOzMsfg2GcJ/GbbnJyPSlCmjlt88VkdWGVKiTbgWecGs5FbND6gw
         B4YcFYM4YwH+W91kVvxoVgjiXhzi40WvgwiyRjBtMRQv8X3QevXVL6mJPxBc3aBjlJwK
         JirZColar+UxsN9P2dX1cinaW077bGloBXSNeSSUVOJeOd266VLjfIyR7UUIB7EAKekC
         6xCaNBlJNGvatVcLqKDkZqwu4F+hIDPZj/SmTCUcqy8K4fUgNFWmZKc15qDqrmJrwW5J
         8RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KYCSfmdnJ8QgEZDE98OmS1svufEPbHxjnZa2MKrzVHw=;
        b=ItGb8iulPECJyPrkSflPXgppGbg/9PP70WIPwx3yTdgbNNHcNBIptp8PhprHRAVCxq
         2g9t2SI9Mfs2/mwdqN5J9+IZxJ8JAIKq5tEBLoI9kXYh29dG92GQTCKsFMI9BChQmwgN
         zicuVNBq9qobJrj5s5m2JwK/vC/pZnudN2TvpJmaw+eS+Up+3hKOVwakzJcSDIUggw3B
         mOSOjxczKJt211rjuQ68b77412T82ghHE6q5PP4nB31/GK9MT2iyWiWPDrdJkfkr5du4
         Nxvf00hZQ0vT41fiy+is2LBDYDiy34Ja+++Xz6gEl2hqJGgXTwgAqvIH7SRkbmwF9i+D
         yPmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leonard Crestez <leonard.crestez@nxp.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.16 19/31] crypto: arm,arm64 - Fix random regeneration of S_shipped
Date: Fri,  6 Apr 2018 15:24:44 +0200
Message-Id: <20180406084343.595788923@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004287599299415?=
X-GMAIL-MSGID: =?utf-8?q?1597004612100233196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 6aaf49b495b446ff6eec0ac983f781ca0dc56a73 upstream.

The decision to rebuild .S_shipped is made based on the relative
timestamps of .S_shipped and .pl files but git makes this essentially
random. This means that the perl script might run anyway (usually at
most once per checkout), defeating the whole purpose of _shipped.

Fix by skipping the rule unless explicit make variables are provided:
REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.

This can produce nasty occasional build failures downstream, for example
for toolchains with broken perl. The solution is minimally intrusive to
make it easier to push into stable.

Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/crypto/Makefile   |    2 ++
 arch/arm64/crypto/Makefile |    2 ++
 2 files changed, 4 insertions(+)

--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -54,6 +54,7 @@ crct10dif-arm-ce-y	:= crct10dif-ce-core.
 crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
 chacha20-neon-y := chacha20-neon-core.o chacha20-neon-glue.o
 
+ifdef REGENERATE_ARM_CRYPTO
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
@@ -62,5 +63,6 @@ $(src)/sha256-core.S_shipped: $(src)/sha
 
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
 	$(call cmd,perl)
+endif
 
 .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -67,6 +67,7 @@ CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_
 $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+ifdef REGENERATE_ARM64_CRYPTO
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -75,5 +76,6 @@ $(src)/sha256-core.S_shipped: $(src)/sha
 
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
+endif
 
 .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
