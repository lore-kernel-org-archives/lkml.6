Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbeEBTje (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:39:34 -0400
Received: from mail.monom.org ([188.138.9.77]:57106 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEBTj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:39:29 -0400
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.126-rt142
Date: Wed, 02 May 2018 21:33:17 +0200
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com
Message-Id: <20180502193926.91E0F500E0A@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.126-rt142 stable release.

This release contains -rt changes only. It contains patches I
identified which were missing in the v4.4-rt tree. There are sill a
few more missing, which I haven't included into the release candidate
for review. Meanwhile Greg was busy and therefore I decided to release
the current queue before updating to latest v4.4 stable tree. After
that I'll post the missing patches for review.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: e650c36988747f830716cb8bf51452f53832c850

Or to build 4.4.126-rt142 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.126.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.126-rt142.patch.xz


You can also build from 4.4.126-rt141 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.126-rt141-rt142.patch.xz

Enjoy!
   Daniel

Changes from v4.4.126-rt141:
---
Daniel Wagner (1):
      Linux 4.4.126-rt142

Sebastian Andrzej Siewior (4):
      locking: add types.h
      mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
      arm*: disable NEON in kernel mode
      crypto: limit more FPU-enabled sections

Steven Rostedt (VMware) (1):
      Revert "memcontrol: Prevent scheduling while atomic in cgroup code"

Thomas Gleixner (1):
      timer: Invoke timer_start_debug() where it makes sense

---
 arch/arm/Kconfig                           |  2 +-
 arch/arm64/crypto/Kconfig                  | 14 +++++++-------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 20 ++++++++++++++++++++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 19 +++++++++++++++++++
 arch/x86/crypto/cast6_avx_glue.c           | 24 +++++++++++++++++++-----
 arch/x86/crypto/chacha20_glue.c            |  8 +++++---
 arch/x86/crypto/serpent_avx2_glue.c        | 19 +++++++++++++++++++
 arch/x86/crypto/serpent_avx_glue.c         | 23 +++++++++++++++++++----
 arch/x86/crypto/serpent_sse2_glue.c        | 23 +++++++++++++++++++----
 arch/x86/crypto/twofish_avx_glue.c         | 27 +++++++++++++++++++++++++--
 arch/x86/include/asm/fpu/api.h             |  1 +
 arch/x86/kernel/fpu/core.c                 | 12 ++++++++++++
 include/linux/spinlock_types_raw.h         |  2 ++
 kernel/time/timer.c                        |  4 ++--
 localversion-rt                            |  2 +-
 mm/memcontrol.c                            |  7 ++-----
 mm/slub.c                                  |  1 +
 17 files changed, 174 insertions(+), 34 deletions(-)
---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 79c4603e9453..5e054a0c4b25 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2119,7 +2119,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI
+	depends on NEON && AEABI && !PREEMPT_RT_BASE
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 2cf32e9887e1..cd71b3432720 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -10,41 +10,41 @@ if ARM64_CRYPTO
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH (for GCM chaining mode) using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AEAD
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_ABLK_HELPER
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ABLK_HELPER
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index d84456924563..c54536d9932c 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -206,6 +206,20 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       camellia_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+}
+#else
+static void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -221,16 +235,19 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_ecb_enc_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -251,16 +268,19 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	if (nbytes >= CAMELLIA_AESNI_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_ecb_dec_16way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_AESNI_PARALLEL_BLOCKS;
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 93d8f295784e..a1666a58eee5 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -210,6 +210,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void camellia_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	camellia_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAMELLIA_BLOCK_SIZE;
@@ -225,10 +240,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_enc_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_enc_blk(ctx->ctx, srcdst, srcdst);
@@ -249,10 +266,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= CAMELLIA_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		camellia_dec_blk_2way(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * CAMELLIA_PARALLEL_BLOCKS;
 		nbytes -= bsize * CAMELLIA_PARALLEL_BLOCKS;
 	}
+	camellia_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		camellia_dec_blk(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index fca459578c35..9eb469b9836a 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -205,19 +205,33 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void cast6_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	cast6_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void cast6_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = CAST6_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * CAST6_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
 		cast6_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		cast6_fpu_end_rt(ctx);
 		return;
 	}
-
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__cast6_encrypt(ctx->ctx, srcdst, srcdst);
 }
@@ -228,10 +242,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * CAST6_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = cast6_fpu_begin(ctx->fpu_enabled, nbytes);
 		cast6_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		cast6_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/chacha20_glue.c b/arch/x86/crypto/chacha20_glue.c
index 722bacea040e..0e3eb53a87cd 100644
--- a/arch/x86/crypto/chacha20_glue.c
+++ b/arch/x86/crypto/chacha20_glue.c
@@ -80,22 +80,24 @@ static int chacha20_simd(struct blkcipher_desc *desc, struct scatterlist *dst,
 
 	crypto_chacha20_init(state, crypto_blkcipher_ctx(desc->tfm), walk.iv);
 
-	kernel_fpu_begin();
-
 	while (walk.nbytes >= CHACHA20_BLOCK_SIZE) {
+		kernel_fpu_begin();
+
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				rounddown(walk.nbytes, CHACHA20_BLOCK_SIZE));
+		kernel_fpu_end();
 		err = blkcipher_walk_done(desc, &walk,
 					  walk.nbytes % CHACHA20_BLOCK_SIZE);
 	}
 
 	if (walk.nbytes) {
+		kernel_fpu_begin();
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				walk.nbytes);
+		kernel_fpu_end();
 		err = blkcipher_walk_done(desc, &walk, 0);
 	}
 
-	kernel_fpu_end();
 
 	return err;
 }
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 6d198342e2de..0954bae9a995 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -184,6 +184,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+       bool fpu_enabled = ctx->fpu_enabled;
+
+       if (!fpu_enabled)
+               return;
+       serpent_fpu_end(fpu_enabled);
+       ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
@@ -199,10 +214,12 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_encrypt(ctx->ctx, srcdst, srcdst);
@@ -223,10 +240,12 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	}
 
 	while (nbytes >= SERPENT_PARALLEL_BLOCKS * bsize) {
+		kernel_fpu_resched();
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
 		srcdst += bsize * SERPENT_PARALLEL_BLOCKS;
 		nbytes -= bsize * SERPENT_PARALLEL_BLOCKS;
 	}
+	serpent_fpu_end_rt(ctx);
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
 		__serpent_decrypt(ctx->ctx, srcdst, srcdst);
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 5dc37026c7ce..8c812a05a084 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -218,16 +218,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_ecb_enc_8way_avx(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
@@ -241,10 +256,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_ecb_dec_8way_avx(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index 3643dd508f45..1ef09f8b5cc7 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -187,16 +187,31 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void serpent_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	serpent_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void serpent_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = SERPENT_BLOCK_SIZE;
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_enc_blk_xway(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
@@ -210,10 +225,10 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 	struct crypt_priv *ctx = priv;
 	int i;
 
-	ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
-
 	if (nbytes == bsize * SERPENT_PARALLEL_BLOCKS) {
+		ctx->fpu_enabled = serpent_fpu_begin(ctx->fpu_enabled, nbytes);
 		serpent_dec_blk_xway(ctx->ctx, srcdst, srcdst);
+		serpent_fpu_end_rt(ctx);
 		return;
 	}
 
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index b7a3904b953c..de00fe24927e 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -218,6 +218,21 @@ struct crypt_priv {
 	bool fpu_enabled;
 };
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static void twofish_fpu_end_rt(struct crypt_priv *ctx)
+{
+	bool fpu_enabled = ctx->fpu_enabled;
+
+	if (!fpu_enabled)
+		return;
+	twofish_fpu_end(fpu_enabled);
+	ctx->fpu_enabled = false;
+}
+
+#else
+static void twofish_fpu_end_rt(struct crypt_priv *ctx) { }
+#endif
+
 static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 {
 	const unsigned int bsize = TF_BLOCK_SIZE;
@@ -228,12 +243,16 @@ static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_enc_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		kernel_fpu_resched();
 		twofish_enc_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
 
+	twofish_fpu_end_rt(ctx);
 	nbytes %= bsize * 3;
 
 	for (i = 0; i < nbytes / bsize; i++, srcdst += bsize)
@@ -250,11 +269,15 @@ static void decrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
 
 	if (nbytes == bsize * TWOFISH_PARALLEL_BLOCKS) {
 		twofish_ecb_dec_8way(ctx->ctx, srcdst, srcdst);
+		twofish_fpu_end_rt(ctx);
 		return;
 	}
 
-	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3)
+	for (i = 0; i < nbytes / (bsize * 3); i++, srcdst += bsize * 3) {
+		kernel_fpu_resched();
 		twofish_dec_blk_3way(ctx->ctx, srcdst, srcdst);
+	}
+	twofish_fpu_end_rt(ctx);
 
 	nbytes %= bsize * 3;
 
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 1429a7c736db..85428df40a22 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -24,6 +24,7 @@ extern void __kernel_fpu_begin(void);
 extern void __kernel_fpu_end(void);
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
+extern void kernel_fpu_resched(void);
 extern bool irq_fpu_usable(void);
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d25097c3fc1d..67ae18aeaf8b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -149,6 +149,18 @@ void kernel_fpu_end(void)
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
+void kernel_fpu_resched(void)
+{
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	if (should_resched(PREEMPT_OFFSET)) {
+		kernel_fpu_end();
+		cond_resched();
+		kernel_fpu_begin();
+	}
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_resched);
+
 /*
  * CR0::TS save/restore functions:
  */
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index edffc4d53fc9..03235b475b77 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 #define __LINUX_SPINLOCK_TYPES_RAW_H
 
+#include <linux/types.h>
+
 #if defined(CONFIG_SMP)
 # include <asm/spinlock_types.h>
 #else
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a8246d79cb5a..6b322aea1c46 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -838,8 +838,6 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 	if (!ret && pending_only)
 		goto out_unlock;
 
-	debug_activate(timer, expires);
-
 	new_base = get_target_base(base, pinned);
 
 	if (base != new_base) {
@@ -854,6 +852,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 			base = switch_timer_base(timer, base, new_base);
 	}
 
+	debug_activate(timer, expires);
+
 	timer->expires = expires;
 	internal_add_timer(base, timer);
 
diff --git a/localversion-rt b/localversion-rt
index 09a4d4e4f010..234720dc343d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt141
+-rt142
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 493b4986d5dc..56f67a15937b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1925,17 +1925,14 @@ static void drain_local_stock(struct work_struct *dummy)
  */
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock;
-	int cpu = get_cpu_light();
-
-	stock = &per_cpu(memcg_stock, cpu);
+	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
 
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-	put_cpu_light();
+	put_cpu_var(memcg_stock);
 }
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index b183c5271607..b3626ab324fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3026,6 +3026,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return i;
 error:
 	local_irq_enable();
+	free_delayed(&to_free);
 	slab_post_alloc_hook(s, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
