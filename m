Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbeCGA60 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 19:58:26 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43778 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933100AbeCGA6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 19:58:24 -0500
X-Google-Smtp-Source: AG47ELsluEhQm0hEegwwW20C8E4/eJpvm4WFXV3GkpkTuFxVD+rJ+9gbhCmNRbYBMTKrYYV8FIPmmQ==
Date: Tue, 6 Mar 2018 16:58:21 -0800
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH -next] pstore: Select compression at runtime
Message-ID: <20180307005821.GA7118@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow for easier build test coverage and run-time testing, this allows
multiple compression algorithms to be built into pstore. Still only one
is supported to operate at a time (which can be selected at build time
or at boot time, similar to how LSMs are selected).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/Kconfig    |  96 +++++++++++++++++++++++++-----------
 fs/pstore/platform.c | 137 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 149 insertions(+), 84 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 898abafea7a5..e4e22026c7a1 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -12,55 +12,93 @@ config PSTORE
 	   If you don't have a platform persistent store driver,
 	   say N.
 
-choice
-        prompt "Choose compression algorithm"
-        depends on PSTORE
-        default PSTORE_ZLIB_COMPRESS
-        help
-          This option chooses compression algorithm.
-
-	  Currently, pstore has support for 5 compression algorithms:
-	  zlib, lzo, lz4, lz4hc and 842.
-
-	  The default compression algorithm is zlib.
-
 config PSTORE_ZLIB_COMPRESS
-        bool "ZLIB"
-        select ZLIB_DEFLATE
-        select ZLIB_INFLATE
-        help
-          This option enables ZLIB compression algorithm support.
+	bool "ZLIB compression"
+	default y
+	depends on PSTORE
+	select ZLIB_DEFLATE
+	select ZLIB_INFLATE
+	help
+	  This option enables ZLIB compression algorithm support.
 
 config PSTORE_LZO_COMPRESS
-        bool "LZO"
-        select LZO_COMPRESS
-        select LZO_DECOMPRESS
-        help
-          This option enables LZO compression algorithm support.
+	bool "LZO compression"
+	depends on PSTORE
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+	help
+	  This option enables LZO compression algorithm support.
 
 config PSTORE_LZ4_COMPRESS
-        bool "LZ4"
-        select LZ4_COMPRESS
-        select LZ4_DECOMPRESS
-        help
-          This option enables LZ4 compression algorithm support.
+	bool "LZ4 compression"
+	depends on PSTORE
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+	help
+	  This option enables LZ4 compression algorithm support.
 
 config PSTORE_LZ4HC_COMPRESS
-	bool "LZ4HC"
+	bool "LZ4HC compression"
+	depends on PSTORE
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
 	help
 	  This option enables LZ4HC (high compression) mode algorithm.
 
 config PSTORE_842_COMPRESS
-	bool "842"
+	bool "842 compression"
+	depends on PSTORE
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 	help
 	  This option enables 842 compression algorithm support.
 
+config PSTORE_COMPRESS
+	def_bool y
+	depends on PSTORE
+	depends on PSTORE_ZLIB_COMPRESS || PSTORE_LZO_COMPRESS ||	\
+		   PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||	\
+		   PSTORE_842_COMPRESS
+
+choice
+	prompt "Default pstore compression algorithm"
+	depends on PSTORE_COMPRESS
+	help
+	  This option chooses the default active compression algorithm.
+	  This change be changed at boot with "pstore.compress=..." on
+	  the kernel command line.
+
+	  Currently, pstore has support for 5 compression algorithms:
+	  zlib, lzo, lz4, lz4hc and 842.
+
+	  The default compression algorithm is zlib.
+
+	config PSTORE_ZLIB_COMPRESS_DEFAULT
+		bool "zlib" if PSTORE_ZLIB_COMPRESS=y
+
+	config PSTORE_LZO_COMPRESS_DEFAULT
+		bool "lzo" if PSTORE_LZO_COMPRESS=y
+
+	config PSTORE_LZ4_COMPRESS_DEFAULT
+		bool "lz4" if PSTORE_LZ4_COMPRESS=y
+
+	config PSTORE_LZ4HC_COMPRESS_DEFAULT
+		bool "lz4hc" if PSTORE_LZ4HC_COMPRESS=y
+
+	config PSTORE_842_COMPRESS_DEFAULT
+		bool "842" if PSTORE_842_COMPRESS=y
+
 endchoice
 
+config PSTORE_COMPRESS_DEFAULT
+	string
+	depends on PSTORE_COMPRESS
+	default "zlib" if PSTORE_ZLIB_COMPRESS_DEFAULT
+	default "lzo" if PSTORE_LZO_COMPRESS_DEFAULT
+	default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT
+	default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT
+	default "842" if PSTORE_842_COMPRESS_DEFAULT
+
 config PSTORE_CONSOLE
 	bool "Log kernel console messages"
 	depends on PSTORE
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index df54dd87598a..dab7fa8f6122 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -77,6 +77,12 @@ static DEFINE_SPINLOCK(pstore_lock);
 struct pstore_info *psinfo;
 
 static char *backend;
+static char *compress =
+#ifdef CONFIG_PSTORE_COMPRESS_DEFAULT
+		CONFIG_PSTORE_COMPRESS_DEFAULT;
+#else
+		NULL;
+#endif
 
 /* Compression parameters */
 #ifdef CONFIG_PSTORE_ZLIB_COMPRESS
@@ -84,7 +90,11 @@ static char *backend;
 #define WINDOW_BITS 12
 #define MEM_LEVEL 4
 static struct z_stream_s stream;
-#else
+#endif
+#if defined(CONFIG_PSTORE_LZO_COMPRESS)   || \
+    defined(CONFIG_PSTORE_LZ4_COMPRESS)   || \
+    defined(CONFIG_PSTORE_LZ4HC_COMPRESS) || \
+    defined(CONFIG_PSTORE_842_COMPRESS)
 static unsigned char *workspace;
 #endif
 
@@ -268,14 +278,6 @@ static void free_zlib(void)
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;
 }
-
-static const struct pstore_zbackend backend_zlib = {
-	.compress	= compress_zlib,
-	.decompress	= decompress_zlib,
-	.allocate	= allocate_zlib,
-	.free		= free_zlib,
-	.name		= "zlib",
-};
 #endif
 
 #ifdef CONFIG_PSTORE_LZO_COMPRESS
@@ -329,14 +331,6 @@ static void free_lzo(void)
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;
 }
-
-static const struct pstore_zbackend backend_lzo = {
-	.compress	= compress_lzo,
-	.decompress	= decompress_lzo,
-	.allocate	= allocate_lzo,
-	.free		= free_lzo,
-	.name		= "lzo",
-};
 #endif
 
 #if defined(CONFIG_PSTORE_LZ4_COMPRESS) || defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
@@ -396,14 +390,6 @@ static void allocate_lz4(void)
 		workspace = NULL;
 	}
 }
-
-static const struct pstore_zbackend backend_lz4 = {
-	.compress	= compress_lz4,
-	.decompress	= decompress_lz4,
-	.allocate	= allocate_lz4,
-	.free		= free_lz4,
-	.name		= "lz4",
-};
 #endif
 
 #ifdef CONFIG_PSTORE_LZ4HC_COMPRESS
@@ -438,14 +424,6 @@ static void allocate_lz4hc(void)
 		workspace = NULL;
 	}
 }
-
-static const struct pstore_zbackend backend_lz4hc = {
-	.compress	= compress_lz4hc,
-	.decompress	= decompress_lz4,
-	.allocate	= allocate_lz4hc,
-	.free		= free_lz4,
-	.name		= "lz4hc",
-};
 #endif
 
 #ifdef CONFIG_PSTORE_842_COMPRESS
@@ -508,30 +486,58 @@ static void free_842(void)
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;
 }
-
-static const struct pstore_zbackend backend_842 = {
-	.compress	= compress_842,
-	.decompress	= decompress_842,
-	.allocate	= allocate_842,
-	.free		= free_842,
-	.name		= "842",
-};
 #endif
 
-static const struct pstore_zbackend *zbackend =
-#if defined(CONFIG_PSTORE_ZLIB_COMPRESS)
-	&backend_zlib;
-#elif defined(CONFIG_PSTORE_LZO_COMPRESS)
-	&backend_lzo;
-#elif defined(CONFIG_PSTORE_LZ4_COMPRESS)
-	&backend_lz4;
-#elif defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
-	&backend_lz4hc;
-#elif defined(CONFIG_PSTORE_842_COMPRESS)
-	&backend_842;
-#else
-	NULL;
+static const struct pstore_zbackend *zbackend __ro_after_init;
+
+static const struct pstore_zbackend zbackends[] = {
+#ifdef CONFIG_PSTORE_ZLIB_COMPRESS
+	{
+		.compress	= compress_zlib,
+		.decompress	= decompress_zlib,
+		.allocate	= allocate_zlib,
+		.free		= free_zlib,
+		.name		= "zlib",
+	},
+#endif
+#ifdef CONFIG_PSTORE_LZO_COMPRESS
+	{
+		.compress	= compress_lzo,
+		.decompress	= decompress_lzo,
+		.allocate	= allocate_lzo,
+		.free		= free_lzo,
+		.name		= "lzo",
+	},
 #endif
+#ifdef CONFIG_PSTORE_LZ4_COMPRESS
+	{
+		.compress	= compress_lz4,
+		.decompress	= decompress_lz4,
+		.allocate	= allocate_lz4,
+		.free		= free_lz4,
+		.name		= "lz4",
+	},
+#endif
+#ifdef CONFIG_PSTORE_LZ4HC_COMPRESS
+	{
+		.compress	= compress_lz4hc,
+		.decompress	= decompress_lz4,
+		.allocate	= allocate_lz4hc,
+		.free		= free_lz4,
+		.name		= "lz4hc",
+	},
+#endif
+#ifdef CONFIG_PSTORE_842_COMPRESS
+	{
+		.compress	= compress_842,
+		.decompress	= decompress_842,
+		.allocate	= allocate_842,
+		.free		= free_842,
+		.name		= "842",
+	},
+#endif
+	{ }
+};
 
 static int pstore_compress(const void *in, void *out,
 			   size_t inlen, size_t outlen)
@@ -553,7 +559,6 @@ static int pstore_decompress(void *in, void *out, size_t inlen, size_t outlen)
 static void allocate_buf_for_compression(void)
 {
 	if (zbackend) {
-		pr_info("using %s compression\n", zbackend->name);
 		zbackend->allocate();
 	} else {
 		pr_err("allocate compression buffer error!\n");
@@ -1022,5 +1027,27 @@ static void pstore_timefunc(struct timer_list *unused)
 			  jiffies + msecs_to_jiffies(pstore_update_ms));
 }
 
+static int __init pstore_init(void)
+{
+	const struct pstore_zbackend *step;
+
+	if (!compress)
+		return 0;
+
+	for (step = zbackends; step->name; step++) {
+		if (!strcmp(compress, step->name)) {
+			zbackend = step;
+			pr_info("using %s compression\n", zbackend->name);
+			break;
+		}
+	}
+
+	return 0;
+}
+module_init(pstore_init);
+
+module_param(compress, charp, 0444);
+MODULE_PARM_DESC(compress, "Pstore compression to use");
+
 module_param(backend, charp, 0444);
 MODULE_PARM_DESC(backend, "Pstore backend to use");
-- 
2.7.4


-- 
Kees Cook
Pixel Security
