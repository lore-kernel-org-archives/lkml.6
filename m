Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/2jfa1eA2vZy5+UPJeCm/Vb5JJ07nBHjXYxMDNeIQ1xg1oQzwRJt3Ws+o2+xX6lJusJUTd
ARC-Seal: i=1; a=rsa-sha256; t=1523022244; cv=none;
        d=google.com; s=arc-20160816;
        b=pUFZWx4h/LMP7OuVjjft04ajEPHn3IdiMWWCdZ4gRWclQ8b0htk+skLHuV3UyeLvPo
         NukF+cjH7k2wa0m672o90YyxcmdeFp2PjrA1xbtMCz/sCJhM1+X4GI1JBuzZWxavTuEU
         TOx4g71y8Q0gLYdI1XQE5w9u/k28fimRvJD0W/LtN/o4hzMrU9a7740AJSnQ+IAqNygQ
         tmu+nSwHZXY8+EwyR+maY8LoSFx54pcsgLVx+arT5zSD8G8G2gq5pQWixaAK/lqRHnuX
         jzWjTBLhqbVS8MQuvy7lHmOEt09iu0Ej7vSaH8Vq/4IcbgiCC2rqI8SsD5901vCctSsR
         A16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SyrrKe6+ZO2hrXLIkcRcCsufgLBTUByUUU4mu/hTKPM=;
        b=OzFQKKglFrJsMdP/QMchtlXBPEpc4x7+FBUOb+7BGryuuAxyLxx5S67w0om25OUnCK
         nHbldi0oylvEpwnqgYc82kGlnjgD6CGFu0fLfd70tFZfwqMeb0k3MMT5dwNEZ7RIGqe7
         RICVdQIAB0qkiWsYeciyplArBNnZy5+XAOZwuEXwYeOFHBXoNs3mRazCQTLf63WHByQy
         SScX47m9amxpB7Q20poQ4VUBLDW/m/x5fd/Hq+Yt4uHxxH/ipyZKCNN/j6CGPhGq9w+O
         UiP0bho0F422C2hLHnFxsBoynw79MqtWfpc8gNmNHC3bmOpxFQN1d8MlJh/HiU4QSlmt
         Vxyw==
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
Subject: [PATCH 4.15 57/72] crypto: arm,arm64 - Fix random regeneration of S_shipped
Date: Fri,  6 Apr 2018 15:24:32 +0200
Message-Id: <20180406084353.304522312@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004287599299415?=
X-GMAIL-MSGID: =?utf-8?q?1597004573252220451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -58,6 +58,7 @@ CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_
 $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+ifdef REGENERATE_ARM64_CRYPTO
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -66,5 +67,6 @@ $(src)/sha256-core.S_shipped: $(src)/sha
 
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
+endif
 
 .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
