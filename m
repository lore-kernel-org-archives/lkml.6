Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeEURhg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:37:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeEURgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:36:40 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com, darrick.wong@oracle.com,
        kernel@lists.collabora.co.uk, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 06/15] nls: Add support for multiple versions of an encoding
Date: Mon, 21 May 2018 14:36:08 -0300
Message-Id: <20180521173617.31625-7-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NLS charsets wanting to use this feature can implement the load_create()
hook, which creates a nls_table for that specific encoding version.  The
charset code is responsible for freeing the table memory when the module
is removed.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 fs/nls/nls_core.c   | 43 +++++++++++++++++++++++++++++++++++++------
 include/linux/nls.h |  4 ++++
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/fs/nls/nls_core.c b/fs/nls/nls_core.c
index f4f91f5870ba..989f5ac48a50 100644
--- a/fs/nls/nls_core.c
+++ b/fs/nls/nls_core.c
@@ -19,10 +19,27 @@
 extern struct nls_charset default_charset;
 static struct nls_charset *charsets = &default_charset;
 static DEFINE_SPINLOCK(nls_lock);
-static struct nls_table *nls_load_table(struct nls_charset *charset)
+
+static struct nls_table *nls_load_table(struct nls_charset *charset,
+					const char *version)
 {
-	/* For now, return the default table, which is the first one found. */
-	return charset->tables;
+	struct nls_table *tbl;
+
+	if (!charset->load_table) {
+		/* If there is no table_create, only 1 table is
+		 * supported and it must have been loaded
+		 * statically.
+		 */
+		return charset->tables;
+	}
+
+	tbl = charset->load_table(version);
+	if (!tbl) {
+		/* Invalid version */
+		return ERR_PTR(-EINVAL);
+	}
+
+	return tbl;
 }
 
 int __register_nls(struct nls_charset *nls, struct module *owner)
@@ -76,21 +93,35 @@ static struct nls_charset *find_nls(char *charset)
 			break;
 	}
 	if (nls && !try_module_get(nls->owner))
-		nls = NULL;
+		nls = ERR_PTR(-EBUSY);
 	spin_unlock(&nls_lock);
 	return nls;
 }
 
-struct nls_table *load_nls(char *charset)
+struct nls_table *load_nls_version(char *charset, char *version)
 {
 	struct nls_charset *nls_charset;
 
 	nls_charset = try_then_request_module(find_nls(charset),
 					      "nls_%s", charset);
 	if (!nls_charset)
+		return ERR_PTR(-EINVAL);
+
+	return nls_load_table(nls_charset, version);
+}
+EXPORT_SYMBOL(load_nls_version);
+
+struct nls_table *load_nls(char *charset)
+{
+	struct nls_table *table = load_nls_version(charset, NULL);
+
+	/* Pre-versioned load_nls() didn't return error pointers. Let's
+	 * keep the abi for now to prevent breakage.
+	 */
+	if (IS_ERR(table))
 		return NULL;
 
-	return nls_load_table(nls_charset);
+	return table;
 }
 
 void unload_nls(struct nls_table *nls)
diff --git a/include/linux/nls.h b/include/linux/nls.h
index cdc95cd9e5d4..3766fbe6efc3 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -30,6 +30,8 @@ struct nls_ops {
 
 struct nls_table {
 	const struct nls_charset *charset;
+	unsigned int version;
+
 	const struct nls_ops *ops;
 	const unsigned char *charset2lower;
 	const unsigned char *charset2upper;
@@ -42,6 +44,7 @@ struct nls_charset {
 	struct module *owner;
 	struct nls_table *tables;
 	struct nls_charset *next;
+	struct nls_table *(*load_table)(const char *version);
 };
 
 /* this value hold the maximum octet of charset */
@@ -58,6 +61,7 @@ enum utf16_endian {
 extern int __register_nls(struct nls_charset *, struct module *);
 extern int unregister_nls(struct nls_charset *);
 extern struct nls_table *load_nls(char *);
+extern struct nls_table *load_nls_version(char *charset, char *version);
 extern void unload_nls(struct nls_table *);
 extern struct nls_table *load_nls_default(void);
 #define register_nls(nls) __register_nls((nls), THIS_MODULE)
-- 
2.17.0
