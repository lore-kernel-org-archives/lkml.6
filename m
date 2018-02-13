Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933449AbeBMGks (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:40:48 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40560 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933360AbeBMGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:40:46 -0500
X-Google-Smtp-Source: AH8x224CbDojBNSFEeBjLkBSxiwklXZnfNGtD9m1omDbOrluRnEI/2u+hJPpX6MAukf2zyoalwlDJA==
From: Geliang Tang <geliangtang@gmail.com>
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] pstore: add lz4hc and 842 compression support
Date: Tue, 13 Feb 2018 14:40:39 +0800
Message-Id: <fbf029c2c9c5071c9e91b8b6f036d7659f3f8b78.1518503420.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <6f60cb1c9a62abde779cdf45b772118192086491.1518356301.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pstore has supported three compression algorithms: zlib,
lzo and lz4. This patch added two more compression algorithms: lz4hc
and 842.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
Changes in v4:
 -842 compress is not work in patch v3 since big_oops_buf_sz is too big.
  change big_oops_buf_sz from psinfo->bufsize * 2 to psinfo->bufsize.
Changes in v3:
 -fix outlen in 842
Changes in v2:
 -fix checkpatch.pl WARNING:
  please write a paragraph that describes the config symbol fully
---
 fs/pstore/Kconfig    |  25 +++++++++
 fs/pstore/platform.c | 147 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 154 insertions(+), 18 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index b42e5bd6d8ff..cf97a3ecdce0 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -39,6 +39,31 @@ config PSTORE_LZ4_COMPRESS
         select LZ4_DECOMPRESS
         help
           This option enables LZ4 compression algorithm support.
+
+config PSTORE_LZ4HC_COMPRESS
+	bool "LZ4HC"
+	select LZ4HC_COMPRESS
+	select LZ4_DECOMPRESS
+	help
+	  This option enables LZ4 high compression mode algorithm.
+
+	  Currently, pstore has supported five compression algorithms:
+	  zlib, lzo, lz4, lz4hc and 842.
+
+	  The default compression algorithm is zlib.
+
+config PSTORE_842_COMPRESS
+	bool "842"
+	select 842_COMPRESS
+	select 842_DECOMPRESS
+	help
+	  This option enables 842 compression algorithm support.
+
+	  Currently, pstore has supported five compression algorithms:
+	  zlib, lzo, lz4, lz4hc and 842.
+
+	  The default compression algorithm is zlib.
+
 endchoice
 
 config PSTORE_CONSOLE
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index c3129b131e4d..19aaefeb052f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -34,9 +34,12 @@
 #ifdef CONFIG_PSTORE_LZO_COMPRESS
 #include <linux/lzo.h>
 #endif
-#ifdef CONFIG_PSTORE_LZ4_COMPRESS
+#if defined(CONFIG_PSTORE_LZ4_COMPRESS) || defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
 #include <linux/lz4.h>
 #endif
+#ifdef CONFIG_PSTORE_842_COMPRESS
+#include <linux/sw842.h>
+#endif
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
@@ -336,6 +339,33 @@ static const struct pstore_zbackend backend_lzo = {
 };
 #endif
 
+#if defined(CONFIG_PSTORE_LZ4_COMPRESS) || defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
+static int decompress_lz4(void *in, void *out, size_t inlen, size_t outlen)
+{
+	int ret;
+
+	ret = LZ4_decompress_safe(in, out, inlen, outlen);
+	if (ret < 0) {
+		/*
+		 * LZ4_decompress_safe will return an error code
+		 * (< 0) if decompression failed
+		 */
+		pr_err("LZ4_decompress_safe error, ret = %d!\n", ret);
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static void free_lz4(void)
+{
+	kfree(workspace);
+	kfree(big_oops_buf);
+	big_oops_buf = NULL;
+	big_oops_buf_sz = 0;
+}
+#endif
+
 #ifdef CONFIG_PSTORE_LZ4_COMPRESS
 static int compress_lz4(const void *in, void *out, size_t inlen, size_t outlen)
 {
@@ -350,29 +380,54 @@ static int compress_lz4(const void *in, void *out, size_t inlen, size_t outlen)
 	return ret;
 }
 
-static int decompress_lz4(void *in, void *out, size_t inlen, size_t outlen)
+static void allocate_lz4(void)
+{
+	big_oops_buf_sz = LZ4_compressBound(psinfo->bufsize);
+	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+	if (big_oops_buf) {
+		workspace = kmalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
+		if (!workspace) {
+			pr_err("No memory for compression workspace; skipping compression\n");
+			kfree(big_oops_buf);
+			big_oops_buf = NULL;
+		}
+	} else {
+		pr_err("No memory for uncompressed data; skipping compression\n");
+		workspace = NULL;
+	}
+}
+
+static const struct pstore_zbackend backend_lz4 = {
+	.compress	= compress_lz4,
+	.decompress	= decompress_lz4,
+	.allocate	= allocate_lz4,
+	.free		= free_lz4,
+	.name		= "lz4",
+};
+#endif
+
+#ifdef CONFIG_PSTORE_LZ4HC_COMPRESS
+static int compress_lz4hc(const void *in, void *out,
+			  size_t inlen, size_t outlen)
 {
 	int ret;
 
-	ret = LZ4_decompress_safe(in, out, inlen, outlen);
-	if (ret < 0) {
-		/*
-		 * LZ4_decompress_safe will return an error code
-		 * (< 0) if decompression failed
-		 */
-		pr_err("LZ4_decompress_safe error, ret = %d!\n", ret);
+	ret = LZ4_compress_HC(in, out, inlen, outlen,
+			      LZ4HC_DEFAULT_CLEVEL, workspace);
+	if (!ret) {
+		pr_err("LZ4_compress_HC error; compression failed!\n");
 		return -EIO;
 	}
 
 	return ret;
 }
 
-static void allocate_lz4(void)
+static void allocate_lz4hc(void)
 {
 	big_oops_buf_sz = LZ4_compressBound(psinfo->bufsize);
 	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
 	if (big_oops_buf) {
-		workspace = kmalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);
+		workspace = kmalloc(LZ4HC_MEM_COMPRESS, GFP_KERNEL);
 		if (!workspace) {
 			pr_err("No memory for compression workspace; skipping compression\n");
 			kfree(big_oops_buf);
@@ -384,7 +439,59 @@ static void allocate_lz4(void)
 	}
 }
 
-static void free_lz4(void)
+static const struct pstore_zbackend backend_lz4hc = {
+	.compress	= compress_lz4hc,
+	.decompress	= decompress_lz4,
+	.allocate	= allocate_lz4hc,
+	.free		= free_lz4,
+	.name		= "lz4hc",
+};
+#endif
+
+#ifdef CONFIG_PSTORE_842_COMPRESS
+static int compress_842(const void *in, void *out, size_t inlen, size_t outlen)
+{
+	int ret;
+
+	ret = sw842_compress(in, inlen, out, (unsigned int *)&outlen, workspace);
+	if (ret) {
+		pr_err("sw842_compress error; compression failed!\n");
+		return ret;
+	}
+
+	return outlen;
+}
+
+static int decompress_842(void *in, void *out, size_t inlen, size_t outlen)
+{
+	int ret;
+
+	ret = sw842_decompress(in, inlen, out, (unsigned int *)&outlen);
+	if (ret) {
+		pr_err("sw842_decompress error, ret = %d!\n", ret);
+		return ret;
+	}
+
+	return outlen;
+}
+
+static void allocate_842(void)
+{
+	big_oops_buf_sz = psinfo->bufsize;
+	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+	if (big_oops_buf) {
+		workspace = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
+		if (!workspace) {
+			kfree(big_oops_buf);
+			big_oops_buf = NULL;
+		}
+	} else {
+		pr_err("No memory for uncompressed data; skipping compression\n");
+		workspace = NULL;
+	}
+}
+
+static void free_842(void)
 {
 	kfree(workspace);
 	kfree(big_oops_buf);
@@ -392,12 +499,12 @@ static void free_lz4(void)
 	big_oops_buf_sz = 0;
 }
 
-static const struct pstore_zbackend backend_lz4 = {
-	.compress	= compress_lz4,
-	.decompress	= decompress_lz4,
-	.allocate	= allocate_lz4,
-	.free		= free_lz4,
-	.name		= "lz4",
+static const struct pstore_zbackend backend_842 = {
+	.compress	= compress_842,
+	.decompress	= decompress_842,
+	.allocate	= allocate_842,
+	.free		= free_842,
+	.name		= "842",
 };
 #endif
 
@@ -408,6 +515,10 @@ static const struct pstore_zbackend *zbackend =
 	&backend_lzo;
 #elif defined(CONFIG_PSTORE_LZ4_COMPRESS)
 	&backend_lz4;
+#elif defined(CONFIG_PSTORE_LZ4HC_COMPRESS)
+	&backend_lz4hc;
+#elif defined(CONFIG_PSTORE_842_COMPRESS)
+	&backend_842;
 #else
 	NULL;
 #endif
-- 
2.14.1
