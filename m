Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeEURjC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:39:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45402 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753722AbeEURg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:36:59 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com, darrick.wong@oracle.com,
        kernel@lists.collabora.co.uk, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 09/15] nls: Add optional normalization and casefold hooks
Date: Mon, 21 May 2018 14:36:11 -0300
Message-Id: <20180521173617.31625-10-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 include/linux/nls.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/nls.h b/include/linux/nls.h
index 72698d524b42..efd3712f0e81 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -4,6 +4,7 @@
 
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/errno.h>
 
 /* Unicode has changed over the years.  Unicode code points no longer
  * fit into 16 bits; as of Unicode 5 valid code points range from 0
@@ -38,7 +39,12 @@ struct nls_ops {
 				   unsigned int c);
 	unsigned char (*uppercase)(const struct nls_table *charset,
 				   unsigned int c);
-
+	int (*casefold)(const struct nls_table *charset,
+			const unsigned char *str, size_t len,
+			unsigned char **folded);
+	int (*normalize)(const struct nls_table *charset,
+			 const unsigned char *str, size_t len,
+			 unsigned char **normalized);
 };
 
 struct nls_table {
@@ -156,6 +162,26 @@ static inline int nls_strnicmp(struct nls_table *t, const unsigned char *s1,
 	return nls_strncasecmp(t, s1, len, s2, len);
 }
 
+static inline int nls_casefold(const struct nls_table *charset,
+			       const unsigned char *str, size_t len,
+			       unsigned char **folded)
+{
+	if (charset->ops->casefold)
+		return charset->ops->casefold(charset, str, len, folded);
+
+	return -ENOTSUPP;
+}
+
+static inline int nls_normalize(const struct nls_table *charset,
+				const unsigned char *str, size_t len,
+				unsigned char **normalized)
+{
+	if (charset->ops->normalize)
+		return charset->ops->normalize(charset, str, len, normalized);
+
+	return -ENOTSUPP;
+}
+
 /*
  * nls_nullsize - return length of null character for codepage
  * @codepage - codepage for which to return length of NULL terminator
-- 
2.17.0
