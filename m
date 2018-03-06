Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeCFXS2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:18:28 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33859 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbeCFXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:18:27 -0500
X-Google-Smtp-Source: AG47ELvhJO4MPgyMsi3Ax6jea7wP3OXr85nOurKbJmZ8NJkYID5Xrw/RZ6CppixJJYjyL4tRzziZRg==
Date: Tue, 6 Mar 2018 15:18:24 -0800
From: Kees Cook <keescook@chromium.org>
To: Geliang Tang <geliangtang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next] pstore: Avoid size casts for 842 compression
Message-ID: <20180306231824.GA7853@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of casting, make sure we don't end up with giant values and just
perform regular assignments with unsigned int instead of re-cast size_t.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 19aaefeb052f..df54dd87598a 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -452,27 +452,37 @@ static const struct pstore_zbackend backend_lz4hc = {
 static int compress_842(const void *in, void *out, size_t inlen, size_t outlen)
 {
 	int ret;
+	unsigned int size;
 
-	ret = sw842_compress(in, inlen, out, (unsigned int *)&outlen, workspace);
+	if (outlen > UINT_MAX)
+		return -EIO;
+	size = outlen;
+
+	ret = sw842_compress(in, inlen, out, &size, workspace);
 	if (ret) {
 		pr_err("sw842_compress error; compression failed!\n");
 		return ret;
 	}
 
-	return outlen;
+	return size;
 }
 
 static int decompress_842(void *in, void *out, size_t inlen, size_t outlen)
 {
 	int ret;
+	unsigned int size;
 
-	ret = sw842_decompress(in, inlen, out, (unsigned int *)&outlen);
+	if (outlen > UINT_MAX)
+		return -EIO;
+	size = outlen;
+
+	ret = sw842_decompress(in, inlen, out, &size);
 	if (ret) {
 		pr_err("sw842_decompress error, ret = %d!\n", ret);
 		return ret;
 	}
 
-	return outlen;
+	return size;
 }
 
 static void allocate_842(void)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
