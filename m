Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeEURgW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:36:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45280 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbeEURgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:36:13 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com, darrick.wong@oracle.com,
        kernel@lists.collabora.co.uk, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 02/15] nls: Wrap charset field access
Date: Mon, 21 May 2018 14:36:04 -0300
Message-Id: <20180521173617.31625-3-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which will simplify further patches.  No behavior changes intended.

<smpl>

@@
struct nls_table *c;
@@

- c->charset
+ nls_charset_name(c)

</smpl>

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 drivers/staging/ncpfs/ioctl.c | 13 +++++++------
 fs/befs/linuxvfs.c            |  4 ++--
 fs/cifs/cifs_unicode.c        |  6 +++---
 fs/cifs/cifsfs.c              |  2 +-
 fs/cifs/connect.c             |  2 +-
 fs/fat/inode.c                |  6 ++++--
 fs/hfs/super.c                |  6 ++++--
 fs/hfsplus/options.c          |  2 +-
 fs/isofs/inode.c              |  5 +++--
 fs/jfs/jfs_unicode.c          |  2 +-
 fs/jfs/super.c                |  3 ++-
 fs/nls/nls_base.c             |  2 +-
 fs/ntfs/inode.c               |  2 +-
 fs/ntfs/super.c               |  6 +++---
 fs/ntfs/unistr.c              |  5 +++--
 fs/udf/super.c                |  3 ++-
 include/linux/nls.h           |  5 +++++
 17 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/ncpfs/ioctl.c b/drivers/staging/ncpfs/ioctl.c
index d378b98cd7b6..e5066d0761fe 100644
--- a/drivers/staging/ncpfs/ioctl.c
+++ b/drivers/staging/ncpfs/ioctl.c
@@ -231,21 +231,22 @@ ncp_get_charsets(struct ncp_server* server, struct ncp_nls_ioctl __user *arg)
 
 	memset(&user, 0, sizeof(user));
 	mutex_lock(&server->root_setup_lock);
-	if (server->nls_vol && server->nls_vol->charset) {
-		len = strlen(server->nls_vol->charset);
+	if (server->nls_vol && nls_charset_name(server->nls_vol)) {
+		len = strlen(nls_charset_name(server->nls_vol));
 		if (len > NCP_IOCSNAME_LEN)
 			len = NCP_IOCSNAME_LEN;
-		strncpy(user.codepage, server->nls_vol->charset, len);
+		strncpy(user.codepage, nls_charset_name(server->nls_vol), len);
 		user.codepage[len] = 0;
 	}
 
 	if (NCP_IS_FLAG(server, NCP_FLAG_UTF8))
 		strcpy(user.iocharset, "utf8");
-	else if (server->nls_io && server->nls_io->charset) {
-		len = strlen(server->nls_io->charset);
+	else if (server->nls_io && nls_charset_name(server->nls_io)) {
+		len = strlen(nls_charset_name(server->nls_io));
 		if (len > NCP_IOCSNAME_LEN)
 			len = NCP_IOCSNAME_LEN;
-		strncpy(user.iocharset,	server->nls_io->charset, len);
+		strncpy(user.iocharset,
+				nls_charset_name(server->nls_io), len);
 		user.iocharset[len] = 0;
 	}
 	mutex_unlock(&server->root_setup_lock);
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index da8049a0dfb6..a45a7e299f5d 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -562,7 +562,7 @@ befs_utf2nls(struct super_block *sb, const char *in,
 
 conv_err:
 	befs_error(sb, "Name using character set %s contains a character that "
-		   "cannot be converted to unicode.", nls->charset);
+		   "cannot be converted to unicode.", nls_charset_name(nls));
 	befs_debug(sb, "<--- %s", __func__);
 	kfree(result);
 	return -EILSEQ;
@@ -642,7 +642,7 @@ befs_nls2utf(struct super_block *sb, const char *in,
 
 conv_err:
 	befs_error(sb, "Name using character set %s contains a character that "
-		   "cannot be converted to unicode.", nls->charset);
+		   "cannot be converted to unicode.", nls_charset_name(nls));
 	befs_debug(sb, "<--- %s", __func__);
 	kfree(result);
 	return -EILSEQ;
diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
index 3b5d48433f23..ca0a514ddad6 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -156,7 +156,7 @@ cifs_mapchar(char *target, const __u16 *from, const struct nls_table *cp,
 
 surrogate_pair:
 	/* convert SURROGATE_PAIR and IVS */
-	if (strcmp(cp->charset, "utf8"))
+	if (strcmp(nls_charset_name(cp), "utf8"))
 		goto unknown;
 	len = utf16s_to_utf8s(from, 3, UTF16_LITTLE_ENDIAN, target, 6);
 	if (len <= 0)
@@ -271,7 +271,7 @@ cifs_strtoUTF16(__le16 *to, const char *from, int len,
 	wchar_t wchar_to; /* needed to quiet sparse */
 
 	/* special case for utf8 to handle no plane0 chars */
-	if (!strcmp(codepage->charset, "utf8")) {
+	if (!strcmp(nls_charset_name(codepage), "utf8")) {
 		/*
 		 * convert utf8 -> utf16, we assume we have enough space
 		 * as caller should have assumed conversion does not overflow
@@ -530,7 +530,7 @@ cifsConvertToUTF16(__le16 *target, const char *source, int srclen,
 				goto ctoUTF16;
 
 			/* convert SURROGATE_PAIR */
-			if (strcmp(cp->charset, "utf8") || !wchar_to)
+			if (strcmp(nls_charset_name(cp), "utf8") || !wchar_to)
 				goto unknown;
 			if (*(source + i) & 0x80) {
 				charlen = utf8_to_utf32(source + i, 6, &u);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 32cdea67bbfd..dfdbdfdb0ad1 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -389,7 +389,7 @@ cifs_show_nls(struct seq_file *s, struct nls_table *cur)
 	/* Display iocharset= option if it's not default charset */
 	def = load_nls_default();
 	if (def != cur)
-		seq_printf(s, ",iocharset=%s", cur->charset);
+		seq_printf(s, ",iocharset=%s", nls_charset_name(cur));
 	unload_nls(def);
 }
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a726f524fb84..628542dc127a 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3092,7 +3092,7 @@ compare_mount_options(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 	    old->mnt_dir_mode != new->mnt_dir_mode)
 		return 0;
 
-	if (strcmp(old->local_nls->charset, new->local_nls->charset))
+	if (strcmp(nls_charset_name(old->local_nls), nls_charset_name(new->local_nls)))
 		return 0;
 
 	if (old->actimeo != new->actimeo)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index ffbbf0520d9e..4145f572aec9 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -934,10 +934,12 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",allow_utime=%04o", opts->allow_utime);
 	if (sbi->nls_disk)
 		/* strip "cp" prefix from displayed option */
-		seq_printf(m, ",codepage=%s", &sbi->nls_disk->charset[2]);
+		seq_printf(m, ",codepage=%s",
+			   &nls_charset_name(sbi->nls_disk)[2]);
 	if (isvfat) {
 		if (sbi->nls_io)
-			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
+			seq_printf(m, ",iocharset=%s",
+				   nls_charset_name(sbi->nls_io));
 
 		switch (opts->shortname) {
 		case VFAT_SFN_DISPLAY_WIN95 | VFAT_SFN_CREATE_WIN95:
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 173876782f73..b16ca01180a5 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -151,9 +151,11 @@ static int hfs_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->session >= 0)
 		seq_printf(seq, ",session=%u", sbi->session);
 	if (sbi->nls_disk)
-		seq_printf(seq, ",codepage=%s", sbi->nls_disk->charset);
+		seq_printf(seq, ",codepage=%s",
+			   nls_charset_name(sbi->nls_disk));
 	if (sbi->nls_io)
-		seq_printf(seq, ",iocharset=%s", sbi->nls_io->charset);
+		seq_printf(seq, ",iocharset=%s",
+			   nls_charset_name(sbi->nls_io));
 	if (sbi->s_quiet)
 		seq_printf(seq, ",quiet");
 	return 0;
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 047e05c57560..2d6644465566 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -230,7 +230,7 @@ int hfsplus_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->session >= 0)
 		seq_printf(seq, ",session=%u", sbi->session);
 	if (sbi->nls)
-		seq_printf(seq, ",nls=%s", sbi->nls->charset);
+		seq_printf(seq, ",nls=%s", nls_charset_name(sbi->nls));
 	if (test_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags))
 		seq_puts(seq, ",nodecompose");
 	if (test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index bc258a4402f6..f8c45b455ff9 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -516,8 +516,9 @@ static int isofs_show_options(struct seq_file *m, struct dentry *root)
 
 #ifdef CONFIG_JOLIET
 	if (sbi->s_nls_iocharset &&
-	    strcmp(sbi->s_nls_iocharset->charset, CONFIG_NLS_DEFAULT) != 0)
-		seq_printf(m, ",iocharset=%s", sbi->s_nls_iocharset->charset);
+	    strcmp(nls_charset_name(sbi->s_nls_iocharset), CONFIG_NLS_DEFAULT) != 0)
+		seq_printf(m, ",iocharset=%s",
+			   nls_charset_name(sbi->s_nls_iocharset));
 #endif
 	return 0;
 }
diff --git a/fs/jfs/jfs_unicode.c b/fs/jfs/jfs_unicode.c
index 11b00906cdf1..36f08688eae6 100644
--- a/fs/jfs/jfs_unicode.c
+++ b/fs/jfs/jfs_unicode.c
@@ -92,7 +92,7 @@ static int jfs_strtoUCS(wchar_t * to, const unsigned char *from, int len,
 				jfs_err("jfs_strtoUCS: char2uni returned %d.",
 					charlen);
 				jfs_err("charset = %s, char = 0x%x",
-					codepage->charset, *from);
+					nls_charset_name(codepage), *from);
 				return charlen;
 			}
 		}
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1b9264fd54b6..1f4542e94261 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -736,7 +736,8 @@ static int jfs_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->flag & JFS_DISCARD)
 		seq_printf(seq, ",discard=%u", sbi->minblks_trim);
 	if (sbi->nls_tab)
-		seq_printf(seq, ",iocharset=%s", sbi->nls_tab->charset);
+		seq_printf(seq, ",iocharset=%s",
+			   nls_charset_name(sbi->nls_tab));
 	if (sbi->flag & JFS_ERR_CONTINUE)
 		seq_printf(seq, ",errors=continue");
 	if (sbi->flag & JFS_ERR_PANIC)
diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 52ccd34b1e79..e5d083b6e2b2 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -277,7 +277,7 @@ static struct nls_table *find_nls(char *charset)
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
 	for (nls = tables; nls; nls = nls->next) {
-		if (!strcmp(nls->charset, charset))
+		if (!strcmp(nls_charset_name(nls), charset))
 			break;
 		if (nls->alias && !strcmp(nls->alias, charset))
 			break;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 1c1ee489284b..0a9d615a247d 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2313,7 +2313,7 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_printf(sf, ",fmask=0%o", vol->fmask);
 		seq_printf(sf, ",dmask=0%o", vol->dmask);
 	}
-	seq_printf(sf, ",nls=%s", vol->nls_map->charset);
+	seq_printf(sf, ",nls=%s", nls_charset_name(vol->nls_map));
 	if (NVolCaseSensitive(vol))
 		seq_printf(sf, ",case_sensitive");
 	if (NVolShowSystemFiles(vol))
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index bb7159f697f2..1c68c33e9816 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -224,7 +224,7 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 				}
 				ntfs_error(vol->sb, "NLS character set %s not "
 						"found. Using previous one %s.",
-						v, old_nls->charset);
+					   v, nls_charset_name(old_nls));
 				nls_map = old_nls;
 			} else /* nls_map */ {
 				unload_nls(old_nls);
@@ -274,7 +274,7 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 					"on remount.");
 			return false;
 		} /* else (!vol->nls_map) */
-		ntfs_debug("Using NLS character set %s.", nls_map->charset);
+		ntfs_debug("Using NLS character set %s.", nls_charset_name(nls_map));
 		vol->nls_map = nls_map;
 	} else /* (!nls_map) */ {
 		if (!vol->nls_map) {
@@ -285,7 +285,7 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 				return false;
 			}
 			ntfs_debug("Using default NLS character set (%s).",
-					vol->nls_map->charset);
+				   nls_charset_name(vol->nls_map));
 		}
 	}
 	if (mft_zone_multiplier != -1) {
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index e0a5f33441df..a30911979a55 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -297,7 +297,7 @@ int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
 	if (wc_len < 0) {
 		ntfs_error(vol->sb, "Name using character set %s contains "
 				"characters that cannot be converted to "
-				"Unicode.", nls->charset);
+				"Unicode.", nls_charset_name(nls));
 		i = -EILSEQ;
 	} else /* if (o >= NTFS_MAX_NAME_LEN) */ {
 		ntfs_error(vol->sb, "Name is too long (maximum length for a "
@@ -386,7 +386,8 @@ retry:			wc = nls_uni2char(nls, le16_to_cpu(ins[i]),
 conversion_err:
 	ntfs_error(vol->sb, "Unicode name contains characters that cannot be "
 			"converted to character set %s.  You might want to "
-			"try to use the mount option nls=utf8.", nls->charset);
+			"try to use the mount option nls=utf8.",
+			nls_charset_name(nls));
 	if (ns != *outs)
 		kfree(ns);
 	if (wc != -ENAMETOOLONG)
diff --git a/fs/udf/super.c b/fs/udf/super.c
index f73239a9a97d..95686faeb2ac 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -378,7 +378,8 @@ static int udf_show_options(struct seq_file *seq, struct dentry *root)
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_UTF8))
 		seq_puts(seq, ",utf8");
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP) && sbi->s_nls_map)
-		seq_printf(seq, ",iocharset=%s", sbi->s_nls_map->charset);
+		seq_printf(seq, ",iocharset=%s",
+			   nls_charset_name(sbi->s_nls_map));
 
 	return 0;
 }
diff --git a/include/linux/nls.h b/include/linux/nls.h
index 5073ecd57279..cacbcd7d63e6 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -72,6 +72,11 @@ static inline int nls_char2uni(const struct nls_table *table,
 	return table->char2uni(rawstring, boundlen, uni);
 }
 
+static inline const char *nls_charset_name(const struct nls_table *table)
+{
+	return table->charset;
+}
+
 static inline unsigned char nls_tolower(struct nls_table *t, unsigned char c)
 {
 	unsigned char nc = t->charset2lower[c];
-- 
2.17.0
