Return-Path: <jmoreira@suse.de>
X-Google-Smtp-Source: AIpwx4+l5oU+NTfgSHwOuNk2jyC6NLkxU/QtR+LjjS0P7aiWlX+1CTDbM0+ped3nB8fM/TzCRiv+
ARC-Seal: i=1; a=rsa-sha256; t=1523765762; cv=none;
        d=google.com; s=arc-20160816;
        b=azZI1kwrHTAEVTRBTA8zJG+ClRxLnX8JcaZudGHuHFFG/TuhqVDtfHucP4/aRJBeb8
         yjVIxtwbX+PgvtEM3jsRrDQ/QD/Xicep+OHWMAu7nHDdBa62r1T1jMbVFDzgEDrQRoXK
         AOBz+Wvzj/O+IB9kAWQLJ/v+mjDUDvAEepmbEetEXAsoEQUICb9RxEBh1fL9A8fwBolV
         5XMtQBhXb/kUx0HwR2ZZYCgzR8KmD6J6SgQpITnsXIanXDtrsTNotI3R3RyvbVV77ptQ
         dklTXLnmc/ssdO+gEP8XAQPl5TrVEr0EGZLYX6FHDnCxJIGBr3ZUqjSVkK4fVdMI6tN/
         L7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=J9nll+MTAC8n6h3xzqiXGBYmpo6DYg0bFAcGfSuiGWk=;
        b=mUI5/4cPwGFwAgDa46IwxOlXac2MivKF+jwh3ewpxuxu2Jf6rhP0HOugOQhmooo+Ah
         Z7ycPV6xi7XbWxWKgDLN/M62r4WwThyYAc3l3FY3fpGNqBZVBAOuD6EEOMKNLQqWHi6p
         WC1OfI59kyPL7bBhNYHcyUCUk1Pm6ECvfS6MxFJiWJabO2axTbKpnnVInmhqqyrp7p39
         EKQePZg2IX28q0a1XMyE9GI7VE8/j/tGvllB1um86/PNTFYRwmUKILi90hZM09l4C+vd
         LOxkNw76UDx1L/1q6NYlnXjBM2AUoyF9SyRLxb5DF0M1jkDyP/FK/IvnS8/2hjaTjzgG
         HtdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
From: Joao Moreira <jmoreira@suse.de>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	gregkh@linuxfoundation.org,
	keescook@chromium.org
Subject: [PATCH 3/4] x86/crypto: serpent: Fix function prototypes
Date: Sun, 15 Apr 2018 01:15:41 -0300
Message-Id: <20180415041542.5364-4-jmoreira@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180415041542.5364-1-jmoreira@suse.de>
References: <20180415041542.5364-1-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597784208557964686?=
X-GMAIL-MSGID: =?utf-8?q?1597784208557964686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Convert the use of 'struct serpent_ctx *' to 'void *' in prototypes of
functions which are referenced through 'struct common_glue_func_entry',
making their prototypes match those of this struct and, consequently,
turning them compatible with CFI requirements.

Whenever needed, cast 'void *' to 'struct serpent_ctx *'.

Signed-off-by: João Moreira <jmoreira@suse.de>
---
 arch/x86/crypto/serpent_avx2_glue.c        | 14 ++++++--------
 arch/x86/crypto/serpent_avx_glue.c         | 19 ++++++++-----------
 arch/x86/include/asm/crypto/serpent-avx.h  | 25 +++++++++++--------------
 arch/x86/include/asm/crypto/serpent-sse2.h | 30 ++++++++++++------------------
 4 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 870f6d812a2d..17d89b4521ac 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -27,18 +27,16 @@
 #define SERPENT_AVX2_PARALLEL_BLOCKS 16
 
 /* 16-way AVX2 parallel cipher functions */
-asmlinkage void serpent_ecb_enc_16way(struct serpent_ctx *ctx, u8 *dst,
-				      const u8 *src);
-asmlinkage void serpent_ecb_dec_16way(struct serpent_ctx *ctx, u8 *dst,
-				      const u8 *src);
+asmlinkage void serpent_ecb_enc_16way(void *ctx, u8 *dst, const u8 *src);
+asmlinkage void serpent_ecb_dec_16way(void *ctx, u8 *dst, const u8 *src);
 asmlinkage void serpent_cbc_dec_16way(void *ctx, u128 *dst, const u128 *src);
 
 asmlinkage void serpent_ctr_16way(void *ctx, u128 *dst, const u128 *src,
 				  le128 *iv);
-asmlinkage void serpent_xts_enc_16way(struct serpent_ctx *ctx, u8 *dst,
-				      const u8 *src, le128 *iv);
-asmlinkage void serpent_xts_dec_16way(struct serpent_ctx *ctx, u8 *dst,
-				      const u8 *src, le128 *iv);
+asmlinkage void serpent_xts_enc_16way(void *ctx, u8 *dst, const u8 *src,
+				      le128 *iv);
+asmlinkage void serpent_xts_dec_16way(void *ctx, u8 *dst, const u8 *src,
+				      le128 *iv);
 
 static const struct common_glue_ctx serpent_enc = {
 	.num_funcs = 3,
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 6f778d3daa22..0d234458a734 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -41,28 +41,25 @@
 #include <asm/crypto/glue_helper.h>
 
 /* 8-way parallel cipher functions */
-asmlinkage void serpent_ecb_enc_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src);
+asmlinkage void serpent_ecb_enc_8way_avx(void *ctx, u8 *dst, const u8 *src);
 EXPORT_SYMBOL_GPL(serpent_ecb_enc_8way_avx);
 
-asmlinkage void serpent_ecb_dec_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src);
+asmlinkage void serpent_ecb_dec_8way_avx(void *ctx, u8 *dst, const u8 *src);
 EXPORT_SYMBOL_GPL(serpent_ecb_dec_8way_avx);
 
-asmlinkage void serpent_cbc_dec_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src);
+asmlinkage void serpent_cbc_dec_8way_avx(void *ctx, u8 *dst, const u8 *src);
 EXPORT_SYMBOL_GPL(serpent_cbc_dec_8way_avx);
 
-asmlinkage void serpent_ctr_8way_avx(struct serpent_ctx *ctx, u8 *dst,
+asmlinkage void serpent_ctr_8way_avx(void *ctx, u8 *dst,
 				     const u8 *src, le128 *iv);
 EXPORT_SYMBOL_GPL(serpent_ctr_8way_avx);
 
-asmlinkage void serpent_xts_enc_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
+asmlinkage void serpent_xts_enc_8way_avx(void *ctx, u8 *dst, const u8 *src,
+					 le128 *iv);
 EXPORT_SYMBOL_GPL(serpent_xts_enc_8way_avx);
 
-asmlinkage void serpent_xts_dec_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
+asmlinkage void serpent_xts_dec_8way_avx(void *ctx, u8 *dst, const u8 *src,
+					 le128 *iv);
 EXPORT_SYMBOL_GPL(serpent_xts_dec_8way_avx);
 
 void __serpent_crypt_ctr(void *ctx, u128 *dst, const u128 *src, le128 *iv)
diff --git a/arch/x86/include/asm/crypto/serpent-avx.h b/arch/x86/include/asm/crypto/serpent-avx.h
index c958b7bd0fcb..c92cb0cc1f8b 100644
--- a/arch/x86/include/asm/crypto/serpent-avx.h
+++ b/arch/x86/include/asm/crypto/serpent-avx.h
@@ -17,20 +17,17 @@ struct serpent_xts_ctx {
 	struct serpent_ctx crypt_ctx;
 };
 
-asmlinkage void serpent_ecb_enc_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src);
-asmlinkage void serpent_ecb_dec_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src);
-
-asmlinkage void serpent_cbc_dec_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src);
-asmlinkage void serpent_ctr_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-				     const u8 *src, le128 *iv);
-
-asmlinkage void serpent_xts_enc_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
-asmlinkage void serpent_xts_dec_8way_avx(struct serpent_ctx *ctx, u8 *dst,
-					 const u8 *src, le128 *iv);
+asmlinkage void serpent_ecb_enc_8way_avx(void *ctx, u8 *dst, const u8 *src);
+asmlinkage void serpent_ecb_dec_8way_avx(void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void serpent_cbc_dec_8way_avx(void *ctx, u8 *dst, const u8 *src);
+asmlinkage void serpent_ctr_8way_avx(void *ctx, u8 *dst, const u8 *src,
+				     le128 *iv);
+
+asmlinkage void serpent_xts_enc_8way_avx(void *ctx, u8 *dst, const u8 *src,
+					 le128 *iv);
+asmlinkage void serpent_xts_dec_8way_avx(void *ctx, u8 *dst, const u8 *src,
+					 le128 *iv);
 
 extern void __serpent_crypt_ctr(void *ctx, u128 *dst, const u128 *src,
 				le128 *iv);
diff --git a/arch/x86/include/asm/crypto/serpent-sse2.h b/arch/x86/include/asm/crypto/serpent-sse2.h
index 1a345e8a7496..69b14fda1f4c 100644
--- a/arch/x86/include/asm/crypto/serpent-sse2.h
+++ b/arch/x86/include/asm/crypto/serpent-sse2.h
@@ -14,22 +14,19 @@ asmlinkage void __serpent_enc_blk_4way(struct serpent_ctx *ctx, u8 *dst,
 asmlinkage void serpent_dec_blk_4way(struct serpent_ctx *ctx, u8 *dst,
 				     const u8 *src);
 
-static inline void serpent_enc_blk_xway(struct serpent_ctx *ctx, u8 *dst,
-					const u8 *src)
+static inline void serpent_enc_blk_xway(void *ctx, u8 *dst, const u8 *src)
 {
-	__serpent_enc_blk_4way(ctx, dst, src, false);
+	__serpent_enc_blk_4way((struct serpent_ctx *) ctx, dst, src, false);
 }
 
-static inline void serpent_enc_blk_xway_xor(struct serpent_ctx *ctx, u8 *dst,
-					    const u8 *src)
+static inline void serpent_enc_blk_xway_xor(void *ctx, u8 *dst, const u8 *src)
 {
-	__serpent_enc_blk_4way(ctx, dst, src, true);
+	__serpent_enc_blk_4way((struct serpent_ctx *) ctx, dst, src, true);
 }
 
-static inline void serpent_dec_blk_xway(struct serpent_ctx *ctx, u8 *dst,
-					const u8 *src)
+static inline void serpent_dec_blk_xway(void *ctx, u8 *dst, const u8 *src)
 {
-	serpent_dec_blk_4way(ctx, dst, src);
+	serpent_dec_blk_4way((struct serpent_ctx *) ctx, dst, src);
 }
 
 #else
@@ -41,22 +38,19 @@ asmlinkage void __serpent_enc_blk_8way(struct serpent_ctx *ctx, u8 *dst,
 asmlinkage void serpent_dec_blk_8way(struct serpent_ctx *ctx, u8 *dst,
 				     const u8 *src);
 
-static inline void serpent_enc_blk_xway(struct serpent_ctx *ctx, u8 *dst,
-				   const u8 *src)
+static inline void serpent_enc_blk_xway(void *ctx, u8 *dst, const u8 *src)
 {
-	__serpent_enc_blk_8way(ctx, dst, src, false);
+	__serpent_enc_blk_8way((struct serpent_ctx *) ctx, dst, src, false);
 }
 
-static inline void serpent_enc_blk_xway_xor(struct serpent_ctx *ctx, u8 *dst,
-				       const u8 *src)
+static inline void serpent_enc_blk_xway_xor(void *ctx, u8 *dst, const u8 *src)
 {
-	__serpent_enc_blk_8way(ctx, dst, src, true);
+	__serpent_enc_blk_8way((struct serpent_ctx *) ctx, dst, src, true);
 }
 
-static inline void serpent_dec_blk_xway(struct serpent_ctx *ctx, u8 *dst,
-				   const u8 *src)
+static inline void serpent_dec_blk_xway(void *ctx, u8 *dst, const u8 *src)
 {
-	serpent_dec_blk_8way(ctx, dst, src);
+	serpent_dec_blk_8way((struct serpent_ctx *) ctx, dst, src);
 }
 
 #endif
-- 
2.12.0
