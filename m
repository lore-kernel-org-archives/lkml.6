Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeCIKvN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:51:13 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36559 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeCIKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:51:11 -0500
X-Google-Smtp-Source: AG47ELtDOwUIGhvCGccGkJsZoB14mvPPFxCzHM83KTJUuzUFn5Y2FWlzLAPf/6iEWU8xvXZCow4zTQ==
From: Geliang Tang <geliangtang@gmail.com>
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: use crypto compress API
Date: Fri,  9 Mar 2018 18:51:07 +0800
Message-Id: <fee4d34acb0daffe56ab774612e4208b73f4f859.1520592053.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the pstore compression part, we use zlib/lzo/lz4/lz4hc/842
compression algorithm API to implement pstore compression backends. But
there are many repeat codes in these implementations. This patch uses
crypto compress API to simplify these codes.

1) rewrite allocate_buf_for_compression, free_buf_for_compression,
pstore_compress, pstore_decompress functions using crypto compress API.
2) drop compress, decompress, allocate, free functions in pstore_zbackend,
and add zbufsize function to get each different compress buffer size.
3) use late_initcall to call ramoops_init later, to make sure the crypto
subsystem has already initialized.
4) use 'unsigned int' type instead of 'size_t' in pstore_compress,
pstore_decompress functions' length arguments.
5) rename 'zlib' to 'deflate' to follow the crypto API's name
convention.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/pstore/Kconfig    |  33 ++--
 fs/pstore/platform.c | 413 ++++++++-------------------------------------------
 fs/pstore/ram.c      |   2 +-
 3 files changed, 80 insertions(+), 368 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index e4e22026c7a1..26f1c0fcada3 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -12,51 +12,46 @@ config PSTORE
 	   If you don't have a platform persistent store driver,
 	   say N.
 
-config PSTORE_ZLIB_COMPRESS
-	bool "ZLIB compression"
+config PSTORE_DEFLATE_COMPRESS
+	bool "DEFLATE compression"
 	default y
 	depends on PSTORE
-	select ZLIB_DEFLATE
-	select ZLIB_INFLATE
+	select CRYPTO_DEFLATE
 	help
-	  This option enables ZLIB compression algorithm support.
+	  This option enables DEFLATE compression algorithm support.
 
 config PSTORE_LZO_COMPRESS
 	bool "LZO compression"
 	depends on PSTORE
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
+	select CRYPTO_LZO
 	help
 	  This option enables LZO compression algorithm support.
 
 config PSTORE_LZ4_COMPRESS
 	bool "LZ4 compression"
 	depends on PSTORE
-	select LZ4_COMPRESS
-	select LZ4_DECOMPRESS
+	select CRYPTO_LZ4
 	help
 	  This option enables LZ4 compression algorithm support.
 
 config PSTORE_LZ4HC_COMPRESS
 	bool "LZ4HC compression"
 	depends on PSTORE
-	select LZ4HC_COMPRESS
-	select LZ4_DECOMPRESS
+	select CRYPTO_LZ4HC
 	help
 	  This option enables LZ4HC (high compression) mode algorithm.
 
 config PSTORE_842_COMPRESS
 	bool "842 compression"
 	depends on PSTORE
-	select 842_COMPRESS
-	select 842_DECOMPRESS
+	select CRYPTO_842
 	help
 	  This option enables 842 compression algorithm support.
 
 config PSTORE_COMPRESS
 	def_bool y
 	depends on PSTORE
-	depends on PSTORE_ZLIB_COMPRESS || PSTORE_LZO_COMPRESS ||	\
+	depends on PSTORE_DEFLATE_COMPRESS || PSTORE_LZO_COMPRESS ||	\
 		   PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||	\
 		   PSTORE_842_COMPRESS
 
@@ -69,12 +64,12 @@ choice
 	  the kernel command line.
 
 	  Currently, pstore has support for 5 compression algorithms:
-	  zlib, lzo, lz4, lz4hc and 842.
+	  deflate, lzo, lz4, lz4hc and 842.
 
-	  The default compression algorithm is zlib.
+	  The default compression algorithm is deflate.
 
-	config PSTORE_ZLIB_COMPRESS_DEFAULT
-		bool "zlib" if PSTORE_ZLIB_COMPRESS=y
+	config PSTORE_DEFLATE_COMPRESS_DEFAULT
+		bool "deflate" if PSTORE_DEFLATE_COMPRESS=y
 
 	config PSTORE_LZO_COMPRESS_DEFAULT
 		bool "lzo" if PSTORE_LZO_COMPRESS=y
@@ -93,7 +88,7 @@ endchoice
 config PSTORE_COMPRESS_DEFAULT
 	string
 	depends on PSTORE_COMPRESS
-	default "zlib" if PSTORE_ZLIB_COMPRESS_DEFAULT
+	default "deflate" if PSTORE_DEFLATE_COMPRESS_DEFAULT
 	default "lzo" if PSTORE_LZO_COMPRESS_DEFAULT
 	default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT
 	default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 06e3b280c3a5..1d40b4588d68 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -28,18 +28,13 @@
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pstore.h>
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS
-#include <linux/zlib.h>
-#endif
 #ifdef CONFIG_PSTORE_LZO_COMPRESS
 #include <linux/lzo.h>
 #endif
 #if defined(CONFIG_PSTORE_LZ4_COMPRESS) || defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
 #include <linux/lz4.h>
 #endif
-#ifdef CONFIG_PSTORE_842_COMPRESS
-#include <linux/sw842.h>
-#endif
+#include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
@@ -85,25 +80,10 @@ static char *compress =
 #endif
 
 /* Compression parameters */
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS
-#define COMPR_LEVEL 6
-#define WINDOW_BITS 12
-#define MEM_LEVEL 4
-static struct z_stream_s stream;
-#endif
-#if defined(CONFIG_PSTORE_LZO_COMPRESS)   || \
-    defined(CONFIG_PSTORE_LZ4_COMPRESS)   || \
-    defined(CONFIG_PSTORE_LZ4HC_COMPRESS) || \
-    defined(CONFIG_PSTORE_842_COMPRESS)
-static unsigned char *workspace;
-#endif
+static struct crypto_comp *tfm;
 
 struct pstore_zbackend {
-	int (*compress)(const void *in, void *out, size_t inlen, size_t outlen);
-	int (*decompress)(void *in, void *out, size_t inlen, size_t outlen);
-	void (*allocate)(void);
-	void (*free)(void);
-
+	int (*zbufsize)(size_t size);
 	const char *name;
 };
 
@@ -162,77 +142,12 @@ bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 }
 EXPORT_SYMBOL_GPL(pstore_cannot_block_path);
 
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS
-/* Derived from logfs_compress() */
-static int compress_zlib(const void *in, void *out, size_t inlen, size_t outlen)
+#ifdef CONFIG_PSTORE_DEFLATE_COMPRESS
+static int zbufsize_deflate(size_t size)
 {
-	int err, ret;
-
-	ret = -EIO;
-	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
-						MEM_LEVEL, Z_DEFAULT_STRATEGY);
-	if (err != Z_OK)
-		goto error;
-
-	stream.next_in = in;
-	stream.avail_in = inlen;
-	stream.total_in = 0;
-	stream.next_out = out;
-	stream.avail_out = outlen;
-	stream.total_out = 0;
-
-	err = zlib_deflate(&stream, Z_FINISH);
-	if (err != Z_STREAM_END)
-		goto error;
-
-	err = zlib_deflateEnd(&stream);
-	if (err != Z_OK)
-		goto error;
-
-	if (stream.total_out >= stream.total_in)
-		goto error;
-
-	ret = stream.total_out;
-error:
-	return ret;
-}
-
-/* Derived from logfs_uncompress */
-static int decompress_zlib(void *in, void *out, size_t inlen, size_t outlen)
-{
-	int err, ret;
-
-	ret = -EIO;
-	err = zlib_inflateInit2(&stream, WINDOW_BITS);
-	if (err != Z_OK)
-		goto error;
-
-	stream.next_in = in;
-	stream.avail_in = inlen;
-	stream.total_in = 0;
-	stream.next_out = out;
-	stream.avail_out = outlen;
-	stream.total_out = 0;
-
-	err = zlib_inflate(&stream, Z_FINISH);
-	if (err != Z_STREAM_END)
-		goto error;
-
-	err = zlib_inflateEnd(&stream);
-	if (err != Z_OK)
-		goto error;
-
-	ret = stream.total_out;
-error:
-	return ret;
-}
-
-static void allocate_zlib(void)
-{
-	size_t size;
 	size_t cmpr;
 
-	switch (psinfo->bufsize) {
+	switch (size) {
 	/* buffer range for efivars */
 	case 1000 ... 2000:
 		cmpr = 56;
@@ -252,287 +167,61 @@ static void allocate_zlib(void)
 		break;
 	}
 
-	big_oops_buf_sz = (psinfo->bufsize * 100) / cmpr;
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (big_oops_buf) {
-		size = max(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
-			zlib_inflate_workspacesize());
-		stream.workspace = kmalloc(size, GFP_KERNEL);
-		if (!stream.workspace) {
-			pr_err("No memory for compression workspace; skipping compression\n");
-			kfree(big_oops_buf);
-			big_oops_buf = NULL;
-		}
-	} else {
-		pr_err("No memory for uncompressed data; skipping compression\n");
-		stream.workspace = NULL;
-	}
-
-}
-
-static void free_zlib(void)
-{
-	kfree(stream.workspace);
-	stream.workspace = NULL;
-	kfree(big_oops_buf);
-	big_oops_buf = NULL;
-	big_oops_buf_sz = 0;
+	return (size * 100) / cmpr;
 }
 #endif
 
 #ifdef CONFIG_PSTORE_LZO_COMPRESS
-static int compress_lzo(const void *in, void *out, size_t inlen, size_t outlen)
+static int zbufsize_lzo(size_t size)
 {
-	int ret;
-
-	ret = lzo1x_1_compress(in, inlen, out, &outlen, workspace);
-	if (ret != LZO_E_OK) {
-		pr_err("lzo_compress error, ret = %d!\n", ret);
-		return -EIO;
-	}
-
-	return outlen;
-}
-
-static int decompress_lzo(void *in, void *out, size_t inlen, size_t outlen)
-{
-	int ret;
-
-	ret = lzo1x_decompress_safe(in, inlen, out, &outlen);
-	if (ret != LZO_E_OK) {
-		pr_err("lzo_decompress error, ret = %d!\n", ret);
-		return -EIO;
-	}
-
-	return outlen;
-}
-
-static void allocate_lzo(void)
-{
-	big_oops_buf_sz = lzo1x_worst_compress(psinfo->bufsize);
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (big_oops_buf) {
-		workspace = kmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
-		if (!workspace) {
-			pr_err("No memory for compression workspace; skipping compression\n");
-			kfree(big_oops_buf);
-			big_oops_buf = NULL;
-		}
-	} else {
-		pr_err("No memory for uncompressed data; skipping compression\n");
-		workspace = NULL;
-	}
-}
-
-static void free_lzo(void)
-{
-	kfree(workspace);
-	kfree(big_oops_buf);
-	big_oops_buf = NULL;
-	big_oops_buf_sz = 0;
+	return lzo1x_worst_compress(size);
 }
 #endif
 
 #if defined(CONFIG_PSTORE_LZ4_COMPRESS) || defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
-static int decompress_lz4(void *in, void *out, size_t inlen, size_t outlen)
-{
-	int ret;
-
-	ret = LZ4_decompress_safe(in, out, inlen, outlen);
-	if (ret < 0) {
-		/*
-		 * LZ4_decompress_safe will return an error code
-		 * (< 0) if decompression failed
-		 */
-		pr_err("LZ4_decompress_safe error, ret = %d!\n", ret);
-		return -EIO;
-	}
-
-	return ret;
-}
-
-static void free_lz4(void)
-{
-	kfree(workspace);
-	kfree(big_oops_buf);
-	big_oops_buf = NULL;
-	big_oops_buf_sz = 0;
-}
-#endif
-
-#ifdef CONFIG_PSTORE_LZ4_COMPRESS
-static int compress_lz4(const void *in, void *out, size_t inlen, size_t outlen)
-{
-	int ret;
-
-	ret = LZ4_compress_default(in, out, inlen, outlen, workspace);
-	if (!ret) {
-		pr_err("LZ4_compress_default error; compression failed!\n");
-		return -EIO;
-	}
-
-	return ret;
-}
-
-static void allocate_lz4(void)
-{
-	big_oops_buf_sz = LZ4_compressBound(psinfo->bufsize);
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (big_oops_buf) {
-		workspace = kmalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
-		if (!workspace) {
-			pr_err("No memory for compression workspace; skipping compression\n");
-			kfree(big_oops_buf);
-			big_oops_buf = NULL;
-		}
-	} else {
-		pr_err("No memory for uncompressed data; skipping compression\n");
-		workspace = NULL;
-	}
-}
-#endif
-
-#ifdef CONFIG_PSTORE_LZ4HC_COMPRESS
-static int compress_lz4hc(const void *in, void *out,
-			  size_t inlen, size_t outlen)
+static int zbufsize_lz4(size_t size)
 {
-	int ret;
-
-	ret = LZ4_compress_HC(in, out, inlen, outlen,
-			      LZ4HC_DEFAULT_CLEVEL, workspace);
-	if (!ret) {
-		pr_err("LZ4_compress_HC error; compression failed!\n");
-		return -EIO;
-	}
-
-	return ret;
-}
-
-static void allocate_lz4hc(void)
-{
-	big_oops_buf_sz = LZ4_compressBound(psinfo->bufsize);
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (big_oops_buf) {
-		workspace = kmalloc(LZ4HC_MEM_COMPRESS, GFP_KERNEL);
-		if (!workspace) {
-			pr_err("No memory for compression workspace; skipping compression\n");
-			kfree(big_oops_buf);
-			big_oops_buf = NULL;
-		}
-	} else {
-		pr_err("No memory for uncompressed data; skipping compression\n");
-		workspace = NULL;
-	}
+	return LZ4_compressBound(size);
 }
 #endif
 
 #ifdef CONFIG_PSTORE_842_COMPRESS
-static int compress_842(const void *in, void *out, size_t inlen, size_t outlen)
-{
-	int ret;
-	unsigned int size;
-
-	if (outlen > UINT_MAX)
-		return -EIO;
-	size = outlen;
-
-	ret = sw842_compress(in, inlen, out, &size, workspace);
-	if (ret) {
-		pr_err("sw842_compress error; compression failed!\n");
-		return ret;
-	}
-
-	return size;
-}
-
-static int decompress_842(void *in, void *out, size_t inlen, size_t outlen)
+static int zbufsize_842(size_t size)
 {
-	int ret;
-	unsigned int size;
-
-	if (outlen > UINT_MAX)
-		return -EIO;
-	size = outlen;
-
-	ret = sw842_decompress(in, inlen, out, &size);
-	if (ret) {
-		pr_err("sw842_decompress error, ret = %d!\n", ret);
-		return ret;
-	}
-
 	return size;
 }
-
-static void allocate_842(void)
-{
-	big_oops_buf_sz = psinfo->bufsize;
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (big_oops_buf) {
-		workspace = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
-		if (!workspace) {
-			kfree(big_oops_buf);
-			big_oops_buf = NULL;
-		}
-	} else {
-		pr_err("No memory for uncompressed data; skipping compression\n");
-		workspace = NULL;
-	}
-}
-
-static void free_842(void)
-{
-	kfree(workspace);
-	kfree(big_oops_buf);
-	big_oops_buf = NULL;
-	big_oops_buf_sz = 0;
-}
 #endif
 
 static const struct pstore_zbackend *zbackend __ro_after_init;
 
 static const struct pstore_zbackend zbackends[] = {
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS
+#ifdef CONFIG_PSTORE_DEFLATE_COMPRESS
 	{
-		.compress	= compress_zlib,
-		.decompress	= decompress_zlib,
-		.allocate	= allocate_zlib,
-		.free		= free_zlib,
-		.name		= "zlib",
+		.zbufsize	= zbufsize_deflate,
+		.name		= "deflate",
 	},
 #endif
 #ifdef CONFIG_PSTORE_LZO_COMPRESS
 	{
-		.compress	= compress_lzo,
-		.decompress	= decompress_lzo,
-		.allocate	= allocate_lzo,
-		.free		= free_lzo,
+		.zbufsize	= zbufsize_lzo,
 		.name		= "lzo",
 	},
 #endif
 #ifdef CONFIG_PSTORE_LZ4_COMPRESS
 	{
-		.compress	= compress_lz4,
-		.decompress	= decompress_lz4,
-		.allocate	= allocate_lz4,
-		.free		= free_lz4,
+		.zbufsize	= zbufsize_lz4,
 		.name		= "lz4",
 	},
 #endif
 #ifdef CONFIG_PSTORE_LZ4HC_COMPRESS
 	{
-		.compress	= compress_lz4hc,
-		.decompress	= decompress_lz4,
-		.allocate	= allocate_lz4hc,
-		.free		= free_lz4,
+		.zbufsize	= zbufsize_lz4,
 		.name		= "lz4hc",
 	},
 #endif
 #ifdef CONFIG_PSTORE_842_COMPRESS
 	{
-		.compress	= compress_842,
-		.decompress	= decompress_842,
-		.allocate	= allocate_842,
-		.free		= free_842,
+		.zbufsize	= zbufsize_842,
 		.name		= "842",
 	},
 #endif
@@ -540,37 +229,65 @@ static const struct pstore_zbackend zbackends[] = {
 };
 
 static int pstore_compress(const void *in, void *out,
-			   size_t inlen, size_t outlen)
+			   unsigned int inlen, unsigned int outlen)
 {
-	if (zbackend)
-		return zbackend->compress(in, out, inlen, outlen);
-	else
-		return -EIO;
+	int ret;
+
+	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
+	if (ret) {
+		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
+		return ret;
+	}
+
+	return outlen;
 }
 
-static int pstore_decompress(void *in, void *out, size_t inlen, size_t outlen)
+static int pstore_decompress(void *in, void *out,
+			     unsigned int inlen, unsigned int outlen)
 {
-	if (zbackend)
-		return zbackend->decompress(in, out, inlen, outlen);
-	else
-		return -EIO;
+	int ret;
+
+	ret = crypto_comp_decompress(tfm, in, inlen, out, &outlen);
+	if (ret) {
+		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+		return ret;
+	}
+
+	return outlen;
 }
 
 static void allocate_buf_for_compression(void)
 {
-	if (zbackend) {
-		zbackend->allocate();
-	} else {
-		pr_err("allocate compression buffer error!\n");
+	if (!zbackend)
+		return;
+
+	if (!crypto_has_comp(zbackend->name, 0, 0)) {
+		pr_err("No %s compression\n", zbackend->name);
+		return;
+	}
+
+	big_oops_buf_sz = zbackend->zbufsize(psinfo->bufsize);
+	if (big_oops_buf_sz <= 0)
+		return;
+
+	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+	if (!big_oops_buf)
+		return;
+
+	tfm = crypto_alloc_comp(zbackend->name, 0, 0);
+	if (IS_ERR_OR_NULL(tfm)) {
+		kfree(big_oops_buf);
+		big_oops_buf = NULL;
 	}
 }
 
 static void free_buf_for_compression(void)
 {
-	if (zbackend)
-		zbackend->free();
-	else
-		pr_err("free compression buffer error!\n");
+	if (!IS_ERR_OR_NULL(tfm))
+		crypto_free_comp(tfm);
+	kfree(big_oops_buf);
+	big_oops_buf = NULL;
+	big_oops_buf_sz = 0;
 }
 
 /*
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 7125b398d312..49b2bc114868 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -938,7 +938,7 @@ static int __init ramoops_init(void)
 	ramoops_register_dummy();
 	return platform_driver_register(&ramoops_driver);
 }
-postcore_initcall(ramoops_init);
+late_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
-- 
2.14.1
