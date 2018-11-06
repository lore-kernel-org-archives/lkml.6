Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3D20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PASrzV5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE3D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeKGH0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:26:37 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:23633 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeKGH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:26:37 -0500
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 02:26:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=144087; q=dns/txt;
  s=iport; t=1541541543; x=1542751143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gJwfHvqoGZXogbfLXMGZn1bO1iGKHwMcbx5IQhUKROQ=;
  b=PASrzV5enYJh1XAQbAL0XEw0y1gOJusoDfqzrkweahCjgvRRh/c1ElJd
   JbRU6iQ+MmCC3MdSi2JOtv6lVjuwUG7a31qjJYUDxgm32FSrJvH/1ns4J
   0/tqOaiTBht/nlD6oK9IU79wQiSok9BgtfxM8uOvghsaNZ120DqWNxBza
   c=;
X-IronPort-AV: E=Sophos;i="5.54,473,1534809600"; 
   d="scan'208";a="477670121"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 21:49:31 +0000
Received: from sjc-ads-9485.cisco.com (sjc-ads-9485.cisco.com [10.30.212.249])
        by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id wA6LnV0a023395;
        Tue, 6 Nov 2018 21:49:31 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Nikunj Kela <nkela@cisco.com>, xe-linux-external@cisco.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: implement mount option to configure endianness
Date:   Tue,  6 Nov 2018 13:49:26 -0800
Message-Id: <20181106214928.40020-1-nkela@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.212.249, sjc-ads-9485.cisco.com
X-Outbound-Node: alln-core-1.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the endianness of the JFSS2 filesystem to be
specified by mount option 'force_endian=big|little|native'. If
endianness is not specified, it defaults to 'native' endianness
thus retaining the existing behavior.

Some architectures benefit from having a single known endianness
of JFFS2 filesystem (for data, not executables) independent of the
endianness of the processor (ARM processors can be switched to either
endianness at run-time).

We have boards that are shipped with BE jffs2 and BE kernel. We are
now migrating to LE kernel. This mount option helps us in mounting
BE jffs2 on LE kernel.

Cc: xe-linux-external@cisco.com
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 fs/jffs2/acl.c         |  30 ++++---
 fs/jffs2/debug.c       |  62 ++++++-------
 fs/jffs2/dir.c         |  94 ++++++++++----------
 fs/jffs2/erase.c       |   8 +-
 fs/jffs2/file.c        |  48 +++++------
 fs/jffs2/fs.c          |  90 +++++++++----------
 fs/jffs2/gc.c          | 192 ++++++++++++++++++++---------------------
 fs/jffs2/jffs2_fs_sb.h |   1 +
 fs/jffs2/nodelist.h    | 115 +++++++++++++++---------
 fs/jffs2/nodemgmt.c    |  10 +--
 fs/jffs2/read.c        |  48 +++++------
 fs/jffs2/readinode.c   | 118 ++++++++++++-------------
 fs/jffs2/scan.c        | 190 ++++++++++++++++++++--------------------
 fs/jffs2/summary.c     | 183 ++++++++++++++++++++-------------------
 fs/jffs2/summary.h     |  20 +++--
 fs/jffs2/super.c       |  30 +++++++
 fs/jffs2/wbuf.c        |  36 ++++----
 fs/jffs2/write.c       | 164 +++++++++++++++++------------------
 fs/jffs2/xattr.c       |  90 +++++++++----------
 19 files changed, 804 insertions(+), 725 deletions(-)

diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 093ffbd82395..e27a5b029215 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -52,7 +52,8 @@ static int jffs2_acl_count(size_t size)
 	}
 }
 
-static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
+static struct posix_acl *jffs2_acl_from_medium(struct jffs2_sb_info *c,
+						void *value, size_t size)
 {
 	void *end = value + size;
 	struct jffs2_acl_header *header = value;
@@ -65,7 +66,7 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 		return NULL;
 	if (size < sizeof(struct jffs2_acl_header))
 		return ERR_PTR(-EINVAL);
-	ver = je32_to_cpu(header->a_version);
+	ver = je32_to_cpu(c, header->a_version);
 	if (ver != JFFS2_ACL_VERSION) {
 		JFFS2_WARNING("Invalid ACL version. (=%u)\n", ver);
 		return ERR_PTR(-EINVAL);
@@ -86,8 +87,8 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 		entry = value;
 		if (value + sizeof(struct jffs2_acl_entry_short) > end)
 			goto fail;
-		acl->a_entries[i].e_tag = je16_to_cpu(entry->e_tag);
-		acl->a_entries[i].e_perm = je16_to_cpu(entry->e_perm);
+		acl->a_entries[i].e_tag = je16_to_cpu(c, entry->e_tag);
+		acl->a_entries[i].e_perm = je16_to_cpu(c, entry->e_perm);
 		switch (acl->a_entries[i].e_tag) {
 			case ACL_USER_OBJ:
 			case ACL_GROUP_OBJ:
@@ -102,7 +103,7 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 					goto fail;
 				acl->a_entries[i].e_uid =
 					make_kuid(&init_user_ns,
-						  je32_to_cpu(entry->e_id));
+						  je32_to_cpu(c, entry->e_id));
 				break;
 			case ACL_GROUP:
 				value += sizeof(struct jffs2_acl_entry);
@@ -110,7 +111,7 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 					goto fail;
 				acl->a_entries[i].e_gid =
 					make_kgid(&init_user_ns,
-						  je32_to_cpu(entry->e_id));
+						  je32_to_cpu(c, entry->e_id));
 				break;
 
 			default:
@@ -125,7 +126,8 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 	return ERR_PTR(-EINVAL);
 }
 
-static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
+static void *jffs2_acl_to_medium(struct jffs2_sb_info *c,
+				const struct posix_acl *acl, size_t *size)
 {
 	struct jffs2_acl_header *header;
 	struct jffs2_acl_entry *entry;
@@ -137,21 +139,21 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
 			GFP_KERNEL);
 	if (!header)
 		return ERR_PTR(-ENOMEM);
-	header->a_version = cpu_to_je32(JFFS2_ACL_VERSION);
+	header->a_version = cpu_to_je32(c, JFFS2_ACL_VERSION);
 	e = header + 1;
 	for (i=0; i < acl->a_count; i++) {
 		const struct posix_acl_entry *acl_e = &acl->a_entries[i];
 		entry = e;
-		entry->e_tag = cpu_to_je16(acl_e->e_tag);
-		entry->e_perm = cpu_to_je16(acl_e->e_perm);
+		entry->e_tag = cpu_to_je16(c, acl_e->e_tag);
+		entry->e_perm = cpu_to_je16(c, acl_e->e_perm);
 		switch(acl_e->e_tag) {
 			case ACL_USER:
-				entry->e_id = cpu_to_je32(
+				entry->e_id = cpu_to_je32(c,
 					from_kuid(&init_user_ns, acl_e->e_uid));
 				e += sizeof(struct jffs2_acl_entry);
 				break;
 			case ACL_GROUP:
-				entry->e_id = cpu_to_je32(
+				entry->e_id = cpu_to_je32(c,
 					from_kgid(&init_user_ns, acl_e->e_gid));
 				e += sizeof(struct jffs2_acl_entry);
 				break;
@@ -197,7 +199,7 @@ struct posix_acl *jffs2_get_acl(struct inode *inode, int type)
 		rc = do_jffs2_getxattr(inode, xprefix, "", value, rc);
 	}
 	if (rc > 0) {
-		acl = jffs2_acl_from_medium(value, rc);
+		acl = jffs2_acl_from_medium(JFFS2_SB_INFO(inode->i_sb), value, rc);
 	} else if (rc == -ENODATA || rc == -ENOSYS) {
 		acl = NULL;
 	} else {
@@ -214,7 +216,7 @@ static int __jffs2_set_acl(struct inode *inode, int xprefix, struct posix_acl *a
 	int rc;
 
 	if (acl) {
-		value = jffs2_acl_to_medium(acl, &size);
+		value = jffs2_acl_to_medium(JFFS2_SB_INFO(inode->i_sb), acl, &size);
 		if (IS_ERR(value))
 			return PTR_ERR(value);
 	}
diff --git a/fs/jffs2/debug.c b/fs/jffs2/debug.c
index 9d26b1b9fc01..22a115518354 100644
--- a/fs/jffs2/debug.c
+++ b/fs/jffs2/debug.c
@@ -787,50 +787,50 @@ __jffs2_dbg_dump_node(struct jffs2_sb_info *c, uint32_t ofs)
 		return;
 	}
 
-	printk(JFFS2_DBG "magic:\t%#04x\n", je16_to_cpu(node.u.magic));
-	printk(JFFS2_DBG "nodetype:\t%#04x\n", je16_to_cpu(node.u.nodetype));
-	printk(JFFS2_DBG "totlen:\t%#08x\n", je32_to_cpu(node.u.totlen));
-	printk(JFFS2_DBG "hdr_crc:\t%#08x\n", je32_to_cpu(node.u.hdr_crc));
+	printk(JFFS2_DBG "magic:\t%#04x\n", je16_to_cpu(c, node.u.magic));
+	printk(JFFS2_DBG "nodetype:\t%#04x\n", je16_to_cpu(c, node.u.nodetype));
+	printk(JFFS2_DBG "totlen:\t%#08x\n", je32_to_cpu(c, node.u.totlen));
+	printk(JFFS2_DBG "hdr_crc:\t%#08x\n", je32_to_cpu(c, node.u.hdr_crc));
 
 	crc = crc32(0, &node.u, sizeof(node.u) - 4);
-	if (crc != je32_to_cpu(node.u.hdr_crc)) {
+	if (crc != je32_to_cpu(c, node.u.hdr_crc)) {
 		JFFS2_ERROR("wrong common header CRC.\n");
 		return;
 	}
 
-	if (je16_to_cpu(node.u.magic) != JFFS2_MAGIC_BITMASK &&
-		je16_to_cpu(node.u.magic) != JFFS2_OLD_MAGIC_BITMASK)
+	if (je16_to_cpu(c, node.u.magic) != JFFS2_MAGIC_BITMASK &&
+		je16_to_cpu(c, node.u.magic) != JFFS2_OLD_MAGIC_BITMASK)
 	{
 		JFFS2_ERROR("wrong node magic: %#04x instead of %#04x.\n",
-			je16_to_cpu(node.u.magic), JFFS2_MAGIC_BITMASK);
+			je16_to_cpu(c, node.u.magic), JFFS2_MAGIC_BITMASK);
 		return;
 	}
 
-	switch(je16_to_cpu(node.u.nodetype)) {
+	switch(je16_to_cpu(c, node.u.nodetype)) {
 
 	case JFFS2_NODETYPE_INODE:
 
 		printk(JFFS2_DBG "the node is inode node\n");
-		printk(JFFS2_DBG "ino:\t%#08x\n", je32_to_cpu(node.i.ino));
-		printk(JFFS2_DBG "version:\t%#08x\n", je32_to_cpu(node.i.version));
+		printk(JFFS2_DBG "ino:\t%#08x\n", je32_to_cpu(c, node.i.ino));
+		printk(JFFS2_DBG "version:\t%#08x\n", je32_to_cpu(c, node.i.version));
 		printk(JFFS2_DBG "mode:\t%#08x\n", node.i.mode.m);
-		printk(JFFS2_DBG "uid:\t%#04x\n", je16_to_cpu(node.i.uid));
-		printk(JFFS2_DBG "gid:\t%#04x\n", je16_to_cpu(node.i.gid));
-		printk(JFFS2_DBG "isize:\t%#08x\n", je32_to_cpu(node.i.isize));
-		printk(JFFS2_DBG "atime:\t%#08x\n", je32_to_cpu(node.i.atime));
-		printk(JFFS2_DBG "mtime:\t%#08x\n", je32_to_cpu(node.i.mtime));
-		printk(JFFS2_DBG "ctime:\t%#08x\n", je32_to_cpu(node.i.ctime));
-		printk(JFFS2_DBG "offset:\t%#08x\n", je32_to_cpu(node.i.offset));
-		printk(JFFS2_DBG "csize:\t%#08x\n", je32_to_cpu(node.i.csize));
-		printk(JFFS2_DBG "dsize:\t%#08x\n", je32_to_cpu(node.i.dsize));
+		printk(JFFS2_DBG "uid:\t%#04x\n", je16_to_cpu(c, node.i.uid));
+		printk(JFFS2_DBG "gid:\t%#04x\n", je16_to_cpu(c, node.i.gid));
+		printk(JFFS2_DBG "isize:\t%#08x\n", je32_to_cpu(c, node.i.isize));
+		printk(JFFS2_DBG "atime:\t%#08x\n", je32_to_cpu(c, node.i.atime));
+		printk(JFFS2_DBG "mtime:\t%#08x\n", je32_to_cpu(c, node.i.mtime));
+		printk(JFFS2_DBG "ctime:\t%#08x\n", je32_to_cpu(c, node.i.ctime));
+		printk(JFFS2_DBG "offset:\t%#08x\n", je32_to_cpu(c, node.i.offset));
+		printk(JFFS2_DBG "csize:\t%#08x\n", je32_to_cpu(c, node.i.csize));
+		printk(JFFS2_DBG "dsize:\t%#08x\n", je32_to_cpu(c, node.i.dsize));
 		printk(JFFS2_DBG "compr:\t%#02x\n", node.i.compr);
 		printk(JFFS2_DBG "usercompr:\t%#02x\n", node.i.usercompr);
-		printk(JFFS2_DBG "flags:\t%#04x\n", je16_to_cpu(node.i.flags));
-		printk(JFFS2_DBG "data_crc:\t%#08x\n", je32_to_cpu(node.i.data_crc));
-		printk(JFFS2_DBG "node_crc:\t%#08x\n", je32_to_cpu(node.i.node_crc));
+		printk(JFFS2_DBG "flags:\t%#04x\n", je16_to_cpu(c, node.i.flags));
+		printk(JFFS2_DBG "data_crc:\t%#08x\n", je32_to_cpu(c, node.i.data_crc));
+		printk(JFFS2_DBG "node_crc:\t%#08x\n", je32_to_cpu(c, node.i.node_crc));
 
 		crc = crc32(0, &node.i, sizeof(node.i) - 8);
-		if (crc != je32_to_cpu(node.i.node_crc)) {
+		if (crc != je32_to_cpu(c, node.i.node_crc)) {
 			JFFS2_ERROR("wrong node header CRC.\n");
 			return;
 		}
@@ -839,20 +839,20 @@ __jffs2_dbg_dump_node(struct jffs2_sb_info *c, uint32_t ofs)
 	case JFFS2_NODETYPE_DIRENT:
 
 		printk(JFFS2_DBG "the node is dirent node\n");
-		printk(JFFS2_DBG "pino:\t%#08x\n", je32_to_cpu(node.d.pino));
-		printk(JFFS2_DBG "version:\t%#08x\n", je32_to_cpu(node.d.version));
-		printk(JFFS2_DBG "ino:\t%#08x\n", je32_to_cpu(node.d.ino));
-		printk(JFFS2_DBG "mctime:\t%#08x\n", je32_to_cpu(node.d.mctime));
+		printk(JFFS2_DBG "pino:\t%#08x\n", je32_to_cpu(c, node.d.pino));
+		printk(JFFS2_DBG "version:\t%#08x\n", je32_to_cpu(c, node.d.version));
+		printk(JFFS2_DBG "ino:\t%#08x\n", je32_to_cpu(c, node.d.ino));
+		printk(JFFS2_DBG "mctime:\t%#08x\n", je32_to_cpu(c, node.d.mctime));
 		printk(JFFS2_DBG "nsize:\t%#02x\n", node.d.nsize);
 		printk(JFFS2_DBG "type:\t%#02x\n", node.d.type);
-		printk(JFFS2_DBG "node_crc:\t%#08x\n", je32_to_cpu(node.d.node_crc));
-		printk(JFFS2_DBG "name_crc:\t%#08x\n", je32_to_cpu(node.d.name_crc));
+		printk(JFFS2_DBG "node_crc:\t%#08x\n", je32_to_cpu(c, node.d.node_crc));
+		printk(JFFS2_DBG "name_crc:\t%#08x\n", je32_to_cpu(c, node.d.name_crc));
 
 		node.d.name[node.d.nsize] = '\0';
 		printk(JFFS2_DBG "name:\t\"%s\"\n", node.d.name);
 
 		crc = crc32(0, &node.d, sizeof(node.d) - 8);
-		if (crc != je32_to_cpu(node.d.node_crc)) {
+		if (crc != je32_to_cpu(c, node.d.node_crc)) {
 			JFFS2_ERROR("wrong node header CRC.\n");
 			return;
 		}
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index f20cff1194bb..3ae79533606c 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -201,7 +201,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	if (ret)
 		goto fail;
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(c, ri->ctime));
 
 	jffs2_free_raw_inode(ri);
 
@@ -326,13 +326,13 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	f = JFFS2_INODE_INFO(inode);
 
 	inode->i_size = targetlen;
-	ri->isize = ri->dsize = ri->csize = cpu_to_je32(inode->i_size);
-	ri->totlen = cpu_to_je32(sizeof(*ri) + inode->i_size);
-	ri->hdr_crc = cpu_to_je32(crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
+	ri->isize = ri->dsize = ri->csize = cpu_to_je32(c, inode->i_size);
+	ri->totlen = cpu_to_je32(c, sizeof(*ri) + inode->i_size);
+	ri->hdr_crc = cpu_to_je32(c, crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
 
 	ri->compr = JFFS2_COMPR_NONE;
-	ri->data_crc = cpu_to_je32(crc32(0, target, targetlen));
-	ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
+	ri->data_crc = cpu_to_je32(c, crc32(0, target, targetlen));
+	ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
 
 	fn = jffs2_write_dnode(c, f, ri, target, targetlen, ALLOC_NORMAL);
 
@@ -392,19 +392,19 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	dir_f = JFFS2_INODE_INFO(dir_i);
 	mutex_lock(&dir_f->sem);
 
-	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
-	rd->totlen = cpu_to_je32(sizeof(*rd) + namelen);
-	rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
+	rd->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rd->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
+	rd->totlen = cpu_to_je32(c, sizeof(*rd) + namelen);
+	rd->hdr_crc = cpu_to_je32(c, crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
 
-	rd->pino = cpu_to_je32(dir_i->i_ino);
-	rd->version = cpu_to_je32(++dir_f->highest_version);
-	rd->ino = cpu_to_je32(inode->i_ino);
-	rd->mctime = cpu_to_je32(JFFS2_NOW());
+	rd->pino = cpu_to_je32(c, dir_i->i_ino);
+	rd->version = cpu_to_je32(c, ++dir_f->highest_version);
+	rd->ino = cpu_to_je32(c, inode->i_ino);
+	rd->mctime = cpu_to_je32(c, JFFS2_NOW());
 	rd->nsize = namelen;
 	rd->type = DT_LNK;
-	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
-	rd->name_crc = cpu_to_je32(crc32(0, dentry->d_name.name, namelen));
+	rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
+	rd->name_crc = cpu_to_je32(c, crc32(0, dentry->d_name.name, namelen));
 
 	fd = jffs2_write_dirent(c, dir_f, rd, dentry->d_name.name, namelen, ALLOC_NORMAL);
 
@@ -418,7 +418,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(c, rd->mctime));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -489,8 +489,8 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	/* but ic->pino_nlink is the parent ino# */
 	f->inocache->pino_nlink = dir_i->i_ino;
 
-	ri->data_crc = cpu_to_je32(0);
-	ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
+	ri->data_crc = cpu_to_je32(c, 0);
+	ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
 
 	fn = jffs2_write_dnode(c, f, ri, NULL, 0, ALLOC_NORMAL);
 
@@ -535,19 +535,19 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	dir_f = JFFS2_INODE_INFO(dir_i);
 	mutex_lock(&dir_f->sem);
 
-	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
-	rd->totlen = cpu_to_je32(sizeof(*rd) + namelen);
-	rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
+	rd->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rd->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
+	rd->totlen = cpu_to_je32(c, sizeof(*rd) + namelen);
+	rd->hdr_crc = cpu_to_je32(c, crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
 
-	rd->pino = cpu_to_je32(dir_i->i_ino);
-	rd->version = cpu_to_je32(++dir_f->highest_version);
-	rd->ino = cpu_to_je32(inode->i_ino);
-	rd->mctime = cpu_to_je32(JFFS2_NOW());
+	rd->pino = cpu_to_je32(c, dir_i->i_ino);
+	rd->version = cpu_to_je32(c, ++dir_f->highest_version);
+	rd->ino = cpu_to_je32(c, inode->i_ino);
+	rd->mctime = cpu_to_je32(c, JFFS2_NOW());
 	rd->nsize = namelen;
 	rd->type = DT_DIR;
-	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
-	rd->name_crc = cpu_to_je32(crc32(0, dentry->d_name.name, namelen));
+	rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
+	rd->name_crc = cpu_to_je32(c, crc32(0, dentry->d_name.name, namelen));
 
 	fd = jffs2_write_dirent(c, dir_f, rd, dentry->d_name.name, namelen, ALLOC_NORMAL);
 
@@ -561,7 +561,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(c, rd->mctime));
 	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
@@ -627,7 +627,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	c = JFFS2_SB_INFO(dir_i->i_sb);
 
 	if (S_ISBLK(mode) || S_ISCHR(mode))
-		devlen = jffs2_encode_dev(&dev, rdev);
+		devlen = jffs2_encode_dev(c, &dev, rdev);
 
 	/* Try to reserve enough space for both node and dirent.
 	 * Just the node will do for now, though
@@ -653,13 +653,13 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 
 	f = JFFS2_INODE_INFO(inode);
 
-	ri->dsize = ri->csize = cpu_to_je32(devlen);
-	ri->totlen = cpu_to_je32(sizeof(*ri) + devlen);
-	ri->hdr_crc = cpu_to_je32(crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
+	ri->dsize = ri->csize = cpu_to_je32(c, devlen);
+	ri->totlen = cpu_to_je32(c, sizeof(*ri) + devlen);
+	ri->hdr_crc = cpu_to_je32(c, crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
 
 	ri->compr = JFFS2_COMPR_NONE;
-	ri->data_crc = cpu_to_je32(crc32(0, &dev, devlen));
-	ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
+	ri->data_crc = cpu_to_je32(c, crc32(0, &dev, devlen));
+	ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
 
 	fn = jffs2_write_dnode(c, f, ri, (char *)&dev, devlen, ALLOC_NORMAL);
 
@@ -704,22 +704,22 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	dir_f = JFFS2_INODE_INFO(dir_i);
 	mutex_lock(&dir_f->sem);
 
-	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
-	rd->totlen = cpu_to_je32(sizeof(*rd) + namelen);
-	rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
+	rd->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rd->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
+	rd->totlen = cpu_to_je32(c, sizeof(*rd) + namelen);
+	rd->hdr_crc = cpu_to_je32(c, crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
 
-	rd->pino = cpu_to_je32(dir_i->i_ino);
-	rd->version = cpu_to_je32(++dir_f->highest_version);
-	rd->ino = cpu_to_je32(inode->i_ino);
-	rd->mctime = cpu_to_je32(JFFS2_NOW());
+	rd->pino = cpu_to_je32(c, dir_i->i_ino);
+	rd->version = cpu_to_je32(c, ++dir_f->highest_version);
+	rd->ino = cpu_to_je32(c, inode->i_ino);
+	rd->mctime = cpu_to_je32(c, JFFS2_NOW());
 	rd->nsize = namelen;
 
 	/* XXX: This is ugly. */
 	rd->type = (mode & S_IFMT) >> 12;
 
-	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
-	rd->name_crc = cpu_to_je32(crc32(0, dentry->d_name.name, namelen));
+	rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
+	rd->name_crc = cpu_to_je32(c, crc32(0, dentry->d_name.name, namelen));
 
 	fd = jffs2_write_dirent(c, dir_f, rd, dentry->d_name.name, namelen, ALLOC_NORMAL);
 
@@ -733,7 +733,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(c, rd->mctime));
 
 	jffs2_free_raw_dirent(rd);
 
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 83b8f06b4a64..3b993221ab4f 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -423,14 +423,14 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
 
 		struct kvec vecs[1];
 		struct jffs2_unknown_node marker = {
-			.magic =	cpu_to_je16(JFFS2_MAGIC_BITMASK),
-			.nodetype =	cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER),
-			.totlen =	cpu_to_je32(c->cleanmarker_size)
+			.magic =	cpu_to_je16(c, JFFS2_MAGIC_BITMASK),
+			.nodetype =	cpu_to_je16(c, JFFS2_NODETYPE_CLEANMARKER),
+			.totlen =	cpu_to_je32(c, c->cleanmarker_size)
 		};
 
 		jffs2_prealloc_raw_node_refs(c, jeb, 1);
 
-		marker.hdr_crc = cpu_to_je32(crc32(0, &marker, sizeof(struct jffs2_unknown_node)-4));
+		marker.hdr_crc = cpu_to_je32(c, crc32(0, &marker, sizeof(struct jffs2_unknown_node)-4));
 
 		vecs[0].iov_base = (unsigned char *) &marker;
 		vecs[0].iov_len = sizeof(marker);
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 7d8654a1472e..1258f92f3b38 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -164,24 +164,24 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		mutex_lock(&f->sem);
 		memset(&ri, 0, sizeof(ri));
 
-		ri.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-		ri.nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-		ri.totlen = cpu_to_je32(sizeof(ri));
-		ri.hdr_crc = cpu_to_je32(crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
-
-		ri.ino = cpu_to_je32(f->inocache->ino);
-		ri.version = cpu_to_je32(++f->highest_version);
-		ri.mode = cpu_to_jemode(inode->i_mode);
-		ri.uid = cpu_to_je16(i_uid_read(inode));
-		ri.gid = cpu_to_je16(i_gid_read(inode));
-		ri.isize = cpu_to_je32(max((uint32_t)inode->i_size, pageofs));
-		ri.atime = ri.ctime = ri.mtime = cpu_to_je32(JFFS2_NOW());
-		ri.offset = cpu_to_je32(inode->i_size);
-		ri.dsize = cpu_to_je32(pageofs - inode->i_size);
-		ri.csize = cpu_to_je32(0);
+		ri.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+		ri.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+		ri.totlen = cpu_to_je32(c, sizeof(ri));
+		ri.hdr_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
+
+		ri.ino = cpu_to_je32(c, f->inocache->ino);
+		ri.version = cpu_to_je32(c, ++f->highest_version);
+		ri.mode = cpu_to_jemode(c, inode->i_mode);
+		ri.uid = cpu_to_je16(c, i_uid_read(inode));
+		ri.gid = cpu_to_je16(c, i_gid_read(inode));
+		ri.isize = cpu_to_je32(c, max((uint32_t)inode->i_size, pageofs));
+		ri.atime = ri.ctime = ri.mtime = cpu_to_je32(c, JFFS2_NOW());
+		ri.offset = cpu_to_je32(c, inode->i_size);
+		ri.dsize = cpu_to_je32(c, pageofs - inode->i_size);
+		ri.csize = cpu_to_je32(c, 0);
 		ri.compr = JFFS2_COMPR_ZERO;
-		ri.node_crc = cpu_to_je32(crc32(0, &ri, sizeof(ri)-8));
-		ri.data_crc = cpu_to_je32(0);
+		ri.node_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(ri)-8));
+		ri.data_crc = cpu_to_je32(c, 0);
 
 		fn = jffs2_write_dnode(c, f, &ri, NULL, 0, ALLOC_NORMAL);
 
@@ -278,12 +278,12 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 	}
 
 	/* Set the fields that the generic jffs2_write_inode_range() code can't find */
-	ri->ino = cpu_to_je32(inode->i_ino);
-	ri->mode = cpu_to_jemode(inode->i_mode);
-	ri->uid = cpu_to_je16(i_uid_read(inode));
-	ri->gid = cpu_to_je16(i_gid_read(inode));
-	ri->isize = cpu_to_je32((uint32_t)inode->i_size);
-	ri->atime = ri->ctime = ri->mtime = cpu_to_je32(JFFS2_NOW());
+	ri->ino = cpu_to_je32(c, inode->i_ino);
+	ri->mode = cpu_to_jemode(c, inode->i_mode);
+	ri->uid = cpu_to_je16(c, i_uid_read(inode));
+	ri->gid = cpu_to_je16(c, i_gid_read(inode));
+	ri->isize = cpu_to_je32(c, (uint32_t)inode->i_size);
+	ri->atime = ri->ctime = ri->mtime = cpu_to_je32(c, JFFS2_NOW());
 
 	/* In 2.4, it was already kmapped by generic_file_write(). Doesn't
 	   hurt to do it again. The alternative is ifdefs, which are ugly. */
@@ -308,7 +308,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			inode->i_size = pos + writtenlen;
 			inode->i_blocks = (inode->i_size + 511) >> 9;
 
-			inode->i_ctime = inode->i_mtime = ITIME(je32_to_cpu(ri->ctime));
+			inode->i_ctime = inode->i_mtime = ITIME(je32_to_cpu(c, ri->ctime));
 		}
 	}
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index eab04eca95a3..f24a01b0e70d 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -51,7 +51,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	   it out again with the appropriate data attached */
 	if (S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)) {
 		/* For these, we don't actually need to read the old node */
-		mdatalen = jffs2_encode_dev(&dev, inode->i_rdev);
+		mdatalen = jffs2_encode_dev(c, &dev, inode->i_rdev);
 		mdata = (char *)&dev;
 		jffs2_dbg(1, "%s(): Writing %d bytes of kdev_t\n",
 			  __func__, mdatalen);
@@ -92,48 +92,48 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	mutex_lock(&f->sem);
 	ivalid = iattr->ia_valid;
 
-	ri->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	ri->nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-	ri->totlen = cpu_to_je32(sizeof(*ri) + mdatalen);
-	ri->hdr_crc = cpu_to_je32(crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
+	ri->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	ri->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+	ri->totlen = cpu_to_je32(c, sizeof(*ri) + mdatalen);
+	ri->hdr_crc = cpu_to_je32(c, crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
 
-	ri->ino = cpu_to_je32(inode->i_ino);
-	ri->version = cpu_to_je32(++f->highest_version);
+	ri->ino = cpu_to_je32(c, inode->i_ino);
+	ri->version = cpu_to_je32(c, ++f->highest_version);
 
-	ri->uid = cpu_to_je16((ivalid & ATTR_UID)?
+	ri->uid = cpu_to_je16(c, (ivalid & ATTR_UID)?
 		from_kuid(&init_user_ns, iattr->ia_uid):i_uid_read(inode));
-	ri->gid = cpu_to_je16((ivalid & ATTR_GID)?
+	ri->gid = cpu_to_je16(c, (ivalid & ATTR_GID)?
 		from_kgid(&init_user_ns, iattr->ia_gid):i_gid_read(inode));
 
 	if (ivalid & ATTR_MODE)
-		ri->mode = cpu_to_jemode(iattr->ia_mode);
+		ri->mode = cpu_to_jemode(c, iattr->ia_mode);
 	else
-		ri->mode = cpu_to_jemode(inode->i_mode);
+		ri->mode = cpu_to_jemode(c, inode->i_mode);
 
 
-	ri->isize = cpu_to_je32((ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
-	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
-	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
-	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
+	ri->isize = cpu_to_je32(c, (ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
+	ri->atime = cpu_to_je32(c, I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
+	ri->mtime = cpu_to_je32(c, I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
+	ri->ctime = cpu_to_je32(c, I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
 
-	ri->offset = cpu_to_je32(0);
-	ri->csize = ri->dsize = cpu_to_je32(mdatalen);
+	ri->offset = cpu_to_je32(c, 0);
+	ri->csize = ri->dsize = cpu_to_je32(c, mdatalen);
 	ri->compr = JFFS2_COMPR_NONE;
 	if (ivalid & ATTR_SIZE && inode->i_size < iattr->ia_size) {
 		/* It's an extension. Make it a hole node */
 		ri->compr = JFFS2_COMPR_ZERO;
-		ri->dsize = cpu_to_je32(iattr->ia_size - inode->i_size);
-		ri->offset = cpu_to_je32(inode->i_size);
+		ri->dsize = cpu_to_je32(c, iattr->ia_size - inode->i_size);
+		ri->offset = cpu_to_je32(c, inode->i_size);
 	} else if (ivalid & ATTR_SIZE && !iattr->ia_size) {
 		/* For truncate-to-zero, treat it as deletion because
 		   it'll always be obsoleting all previous nodes */
 		alloc_type = ALLOC_DELETION;
 	}
-	ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
+	ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
 	if (mdatalen)
-		ri->data_crc = cpu_to_je32(crc32(0, mdata, mdatalen));
+		ri->data_crc = cpu_to_je32(c, crc32(0, mdata, mdatalen));
 	else
-		ri->data_crc = cpu_to_je32(0);
+		ri->data_crc = cpu_to_je32(c, 0);
 
 	new_metadata = jffs2_write_dnode(c, f, ri, mdata, mdatalen, alloc_type);
 	if (S_ISLNK(inode->i_mode))
@@ -146,12 +146,12 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 		return PTR_ERR(new_metadata);
 	}
 	/* It worked. Update the inode */
-	inode->i_atime = ITIME(je32_to_cpu(ri->atime));
-	inode->i_ctime = ITIME(je32_to_cpu(ri->ctime));
-	inode->i_mtime = ITIME(je32_to_cpu(ri->mtime));
-	inode->i_mode = jemode_to_cpu(ri->mode);
-	i_uid_write(inode, je16_to_cpu(ri->uid));
-	i_gid_write(inode, je16_to_cpu(ri->gid));
+	inode->i_atime = ITIME(je32_to_cpu(c, ri->atime));
+	inode->i_ctime = ITIME(je32_to_cpu(c, ri->ctime));
+	inode->i_mtime = ITIME(je32_to_cpu(c, ri->mtime));
+	inode->i_mode = jemode_to_cpu(c, ri->mode);
+	i_uid_write(inode, je16_to_cpu(c, ri->uid));
+	i_gid_write(inode, je16_to_cpu(c, ri->gid));
 
 
 	old_metadata = f->metadata;
@@ -276,13 +276,13 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	if (ret)
 		goto error;
 
-	inode->i_mode = jemode_to_cpu(latest_node.mode);
-	i_uid_write(inode, je16_to_cpu(latest_node.uid));
-	i_gid_write(inode, je16_to_cpu(latest_node.gid));
-	inode->i_size = je32_to_cpu(latest_node.isize);
-	inode->i_atime = ITIME(je32_to_cpu(latest_node.atime));
-	inode->i_mtime = ITIME(je32_to_cpu(latest_node.mtime));
-	inode->i_ctime = ITIME(je32_to_cpu(latest_node.ctime));
+	inode->i_mode = jemode_to_cpu(c, latest_node.mode);
+	i_uid_write(inode, je16_to_cpu(c, latest_node.uid));
+	i_gid_write(inode, je16_to_cpu(c, latest_node.gid));
+	inode->i_size = je32_to_cpu(c, latest_node.isize);
+	inode->i_atime = ITIME(je32_to_cpu(c, latest_node.atime));
+	inode->i_mtime = ITIME(je32_to_cpu(c, latest_node.mtime));
+	inode->i_ctime = ITIME(je32_to_cpu(c, latest_node.ctime));
 
 	set_nlink(inode, f->inocache->pino_nlink);
 
@@ -337,9 +337,9 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 			goto error;
 		}
 		if (f->metadata->size == sizeof(jdev.old_id))
-			rdev = old_decode_dev(je16_to_cpu(jdev.old_id));
+			rdev = old_decode_dev(je16_to_cpu(c, jdev.old_id));
 		else
-			rdev = new_decode_dev(je32_to_cpu(jdev.new_id));
+			rdev = new_decode_dev(je32_to_cpu(c, jdev.new_id));
 
 	case S_IFSOCK:
 	case S_IFIFO:
@@ -441,14 +441,14 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 
 	memset(ri, 0, sizeof(*ri));
 	/* Set OS-specific defaults for new inodes */
-	ri->uid = cpu_to_je16(from_kuid(&init_user_ns, current_fsuid()));
+	ri->uid = cpu_to_je16(c, from_kuid(&init_user_ns, current_fsuid()));
 
 	if (dir_i->i_mode & S_ISGID) {
-		ri->gid = cpu_to_je16(i_gid_read(dir_i));
+		ri->gid = cpu_to_je16(c, i_gid_read(dir_i));
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else {
-		ri->gid = cpu_to_je16(from_kgid(&init_user_ns, current_fsgid()));
+		ri->gid = cpu_to_je16(c, from_kgid(&init_user_ns, current_fsgid()));
 	}
 
 	/* POSIX ACLs have to be processed now, at least partly.
@@ -468,12 +468,12 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 		return ERR_PTR(ret);
 	}
 	set_nlink(inode, 1);
-	inode->i_ino = je32_to_cpu(ri->ino);
-	inode->i_mode = jemode_to_cpu(ri->mode);
-	i_gid_write(inode, je16_to_cpu(ri->gid));
-	i_uid_write(inode, je16_to_cpu(ri->uid));
+	inode->i_ino = je32_to_cpu(c, ri->ino);
+	inode->i_mode = jemode_to_cpu(c, ri->mode);
+	i_gid_write(inode, je16_to_cpu(c, ri->gid));
+	i_uid_write(inode, je16_to_cpu(c, ri->uid));
 	inode->i_atime = inode->i_ctime = inode->i_mtime = current_time(inode);
-	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode->i_mtime));
+	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(c, I_SEC(inode->i_mtime));
 
 	inode->i_blocks = 0;
 	inode->i_size = 0;
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 9ed0f26cf023..6183458d6bd9 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -632,28 +632,28 @@ static int jffs2_garbage_collect_pristine(struct jffs2_sb_info *c,
 		goto out_node;
 
 	crc = crc32(0, node, sizeof(struct jffs2_unknown_node)-4);
-	if (je32_to_cpu(node->u.hdr_crc) != crc) {
+	if (je32_to_cpu(c, node->u.hdr_crc) != crc) {
 		pr_warn("Header CRC failed on REF_PRISTINE node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
-			ref_offset(raw), je32_to_cpu(node->u.hdr_crc), crc);
+			ref_offset(raw), je32_to_cpu(c, node->u.hdr_crc), crc);
 		goto bail;
 	}
 
-	switch(je16_to_cpu(node->u.nodetype)) {
+	switch(je16_to_cpu(c, node->u.nodetype)) {
 	case JFFS2_NODETYPE_INODE:
 		crc = crc32(0, node, sizeof(node->i)-8);
-		if (je32_to_cpu(node->i.node_crc) != crc) {
+		if (je32_to_cpu(c, node->i.node_crc) != crc) {
 			pr_warn("Node CRC failed on REF_PRISTINE data node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
-				ref_offset(raw), je32_to_cpu(node->i.node_crc),
+				ref_offset(raw), je32_to_cpu(c, node->i.node_crc),
 				crc);
 			goto bail;
 		}
 
-		if (je32_to_cpu(node->i.dsize)) {
-			crc = crc32(0, node->i.data, je32_to_cpu(node->i.csize));
-			if (je32_to_cpu(node->i.data_crc) != crc) {
+		if (je32_to_cpu(c, node->i.dsize)) {
+			crc = crc32(0, node->i.data, je32_to_cpu(c, node->i.csize));
+			if (je32_to_cpu(c, node->i.data_crc) != crc) {
 				pr_warn("Data CRC failed on REF_PRISTINE data node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
 					ref_offset(raw),
-					je32_to_cpu(node->i.data_crc), crc);
+					je32_to_cpu(c, node->i.data_crc), crc);
 				goto bail;
 			}
 		}
@@ -661,10 +661,10 @@ static int jffs2_garbage_collect_pristine(struct jffs2_sb_info *c,
 
 	case JFFS2_NODETYPE_DIRENT:
 		crc = crc32(0, node, sizeof(node->d)-8);
-		if (je32_to_cpu(node->d.node_crc) != crc) {
+		if (je32_to_cpu(c, node->d.node_crc) != crc) {
 			pr_warn("Node CRC failed on REF_PRISTINE dirent node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
 				ref_offset(raw),
-				je32_to_cpu(node->d.node_crc), crc);
+				je32_to_cpu(c, node->d.node_crc), crc);
 			goto bail;
 		}
 
@@ -676,10 +676,10 @@ static int jffs2_garbage_collect_pristine(struct jffs2_sb_info *c,
 
 		if (node->d.nsize) {
 			crc = crc32(0, node->d.name, node->d.nsize);
-			if (je32_to_cpu(node->d.name_crc) != crc) {
+			if (je32_to_cpu(c, node->d.name_crc) != crc) {
 				pr_warn("Name CRC failed on REF_PRISTINE dirent node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
 					ref_offset(raw),
-					je32_to_cpu(node->d.name_crc), crc);
+					je32_to_cpu(c, node->d.name_crc), crc);
 				goto bail;
 			}
 		}
@@ -688,7 +688,7 @@ static int jffs2_garbage_collect_pristine(struct jffs2_sb_info *c,
 		/* If it's inode-less, we don't _know_ what it is. Just copy it intact */
 		if (ic) {
 			pr_warn("Unknown node type for REF_PRISTINE node at 0x%08x: 0x%04x\n",
-				ref_offset(raw), je16_to_cpu(node->u.nodetype));
+				ref_offset(raw), je16_to_cpu(c, node->u.nodetype));
 			goto bail;
 		}
 	}
@@ -770,7 +770,7 @@ static int jffs2_garbage_collect_metadata(struct jffs2_sb_info *c, struct jffs2_
 	if (S_ISBLK(JFFS2_F_I_MODE(f)) ||
 	    S_ISCHR(JFFS2_F_I_MODE(f)) ) {
 		/* For these, we don't actually need to read the old node */
-		mdatalen = jffs2_encode_dev(&dev, JFFS2_F_I_RDEV(f));
+		mdatalen = jffs2_encode_dev(c, &dev, JFFS2_F_I_RDEV(f));
 		mdata = (char *)&dev;
 		jffs2_dbg(1, "%s(): Writing %d bytes of kdev_t\n",
 			  __func__, mdatalen);
@@ -810,26 +810,26 @@ static int jffs2_garbage_collect_metadata(struct jffs2_sb_info *c, struct jffs2_
 		ilen = JFFS2_F_I_SIZE(f);
 
 	memset(&ri, 0, sizeof(ri));
-	ri.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	ri.nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-	ri.totlen = cpu_to_je32(sizeof(ri) + mdatalen);
-	ri.hdr_crc = cpu_to_je32(crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
-
-	ri.ino = cpu_to_je32(f->inocache->ino);
-	ri.version = cpu_to_je32(++f->highest_version);
-	ri.mode = cpu_to_jemode(JFFS2_F_I_MODE(f));
-	ri.uid = cpu_to_je16(JFFS2_F_I_UID(f));
-	ri.gid = cpu_to_je16(JFFS2_F_I_GID(f));
-	ri.isize = cpu_to_je32(ilen);
-	ri.atime = cpu_to_je32(JFFS2_F_I_ATIME(f));
-	ri.ctime = cpu_to_je32(JFFS2_F_I_CTIME(f));
-	ri.mtime = cpu_to_je32(JFFS2_F_I_MTIME(f));
-	ri.offset = cpu_to_je32(0);
-	ri.csize = cpu_to_je32(mdatalen);
-	ri.dsize = cpu_to_je32(mdatalen);
+	ri.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	ri.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+	ri.totlen = cpu_to_je32(c, sizeof(ri) + mdatalen);
+	ri.hdr_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
+
+	ri.ino = cpu_to_je32(c, f->inocache->ino);
+	ri.version = cpu_to_je32(c, ++f->highest_version);
+	ri.mode = cpu_to_jemode(c, JFFS2_F_I_MODE(f));
+	ri.uid = cpu_to_je16(c, JFFS2_F_I_UID(f));
+	ri.gid = cpu_to_je16(c, JFFS2_F_I_GID(f));
+	ri.isize = cpu_to_je32(c, ilen);
+	ri.atime = cpu_to_je32(c, JFFS2_F_I_ATIME(f));
+	ri.ctime = cpu_to_je32(c, JFFS2_F_I_CTIME(f));
+	ri.mtime = cpu_to_je32(c, JFFS2_F_I_MTIME(f));
+	ri.offset = cpu_to_je32(c, 0);
+	ri.csize = cpu_to_je32(c, mdatalen);
+	ri.dsize = cpu_to_je32(c, mdatalen);
 	ri.compr = JFFS2_COMPR_NONE;
-	ri.node_crc = cpu_to_je32(crc32(0, &ri, sizeof(ri)-8));
-	ri.data_crc = cpu_to_je32(crc32(0, mdata, mdatalen));
+	ri.node_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(ri)-8));
+	ri.data_crc = cpu_to_je32(c, crc32(0, mdata, mdatalen));
 
 	new_fn = jffs2_write_dnode(c, f, &ri, mdata, mdatalen, ALLOC_GC);
 
@@ -855,24 +855,24 @@ static int jffs2_garbage_collect_dirent(struct jffs2_sb_info *c, struct jffs2_er
 	uint32_t alloclen;
 	int ret;
 
-	rd.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rd.nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
+	rd.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rd.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
 	rd.nsize = strlen(fd->name);
-	rd.totlen = cpu_to_je32(sizeof(rd) + rd.nsize);
-	rd.hdr_crc = cpu_to_je32(crc32(0, &rd, sizeof(struct jffs2_unknown_node)-4));
+	rd.totlen = cpu_to_je32(c, sizeof(rd) + rd.nsize);
+	rd.hdr_crc = cpu_to_je32(c, crc32(0, &rd, sizeof(struct jffs2_unknown_node)-4));
 
-	rd.pino = cpu_to_je32(f->inocache->ino);
-	rd.version = cpu_to_je32(++f->highest_version);
-	rd.ino = cpu_to_je32(fd->ino);
+	rd.pino = cpu_to_je32(c, f->inocache->ino);
+	rd.version = cpu_to_je32(c, ++f->highest_version);
+	rd.ino = cpu_to_je32(c, fd->ino);
 	/* If the times on this inode were set by explicit utime() they can be different,
 	   so refrain from splatting them. */
 	if (JFFS2_F_I_MTIME(f) == JFFS2_F_I_CTIME(f))
-		rd.mctime = cpu_to_je32(JFFS2_F_I_MTIME(f));
+		rd.mctime = cpu_to_je32(c, JFFS2_F_I_MTIME(f));
 	else
-		rd.mctime = cpu_to_je32(0);
+		rd.mctime = cpu_to_je32(c, 0);
 	rd.type = fd->type;
-	rd.node_crc = cpu_to_je32(crc32(0, &rd, sizeof(rd)-8));
-	rd.name_crc = cpu_to_je32(crc32(0, fd->name, rd.nsize));
+	rd.node_crc = cpu_to_je32(c, crc32(0, &rd, sizeof(rd)-8));
+	rd.name_crc = cpu_to_je32(c, crc32(0, fd->name, rd.nsize));
 
 	ret = jffs2_reserve_space_gc(c, sizeof(rd)+rd.nsize, &alloclen,
 				JFFS2_SUMMARY_DIRENT_SIZE(rd.nsize));
@@ -957,15 +957,15 @@ static int jffs2_garbage_collect_deletion_dirent(struct jffs2_sb_info *c, struct
 				continue;
 			}
 
-			if (je16_to_cpu(rd->nodetype) != JFFS2_NODETYPE_DIRENT)
+			if (je16_to_cpu(c, rd->nodetype) != JFFS2_NODETYPE_DIRENT)
 				continue;
 
 			/* If the name CRC doesn't match, skip */
-			if (je32_to_cpu(rd->name_crc) != name_crc)
+			if (je32_to_cpu(c, rd->name_crc) != name_crc)
 				continue;
 
 			/* If the name length doesn't match, or it's another deletion dirent, skip */
-			if (rd->nsize != name_len || !je32_to_cpu(rd->ino))
+			if (rd->nsize != name_len || !je32_to_cpu(c, rd->ino))
 				continue;
 
 			/* OK, check the actual name now */
@@ -979,7 +979,7 @@ static int jffs2_garbage_collect_deletion_dirent(struct jffs2_sb_info *c, struct
 
 			jffs2_dbg(1, "Deletion dirent at %08x still obsoletes real dirent \"%s\" at %08x for ino #%u\n",
 				  ref_offset(fd->raw), fd->name,
-				  ref_offset(raw), je32_to_cpu(rd->ino));
+				  ref_offset(raw), je32_to_cpu(c, rd->ino));
 			kfree(rd);
 
 			return jffs2_garbage_collect_dirent(c, jeb, f, fd);
@@ -1036,23 +1036,23 @@ static int jffs2_garbage_collect_hole(struct jffs2_sb_info *c, struct jffs2_eras
 				ret, readlen);
 			goto fill;
 		}
-		if (je16_to_cpu(ri.nodetype) != JFFS2_NODETYPE_INODE) {
+		if (je16_to_cpu(c, ri.nodetype) != JFFS2_NODETYPE_INODE) {
 			pr_warn("%s(): Node at 0x%08x had node type 0x%04x instead of JFFS2_NODETYPE_INODE(0x%04x)\n",
 				__func__, ref_offset(fn->raw),
-				je16_to_cpu(ri.nodetype), JFFS2_NODETYPE_INODE);
+				je16_to_cpu(c, ri.nodetype), JFFS2_NODETYPE_INODE);
 			return -EIO;
 		}
-		if (je32_to_cpu(ri.totlen) != sizeof(ri)) {
+		if (je32_to_cpu(c, ri.totlen) != sizeof(ri)) {
 			pr_warn("%s(): Node at 0x%08x had totlen 0x%x instead of expected 0x%zx\n",
 				__func__, ref_offset(fn->raw),
-				je32_to_cpu(ri.totlen), sizeof(ri));
+				je32_to_cpu(c, ri.totlen), sizeof(ri));
 			return -EIO;
 		}
 		crc = crc32(0, &ri, sizeof(ri)-8);
-		if (crc != je32_to_cpu(ri.node_crc)) {
+		if (crc != je32_to_cpu(c, ri.node_crc)) {
 			pr_warn("%s: Node at 0x%08x had CRC 0x%08x which doesn't match calculated CRC 0x%08x\n",
 				__func__, ref_offset(fn->raw),
-				je32_to_cpu(ri.node_crc), crc);
+				je32_to_cpu(c, ri.node_crc), crc);
 			/* FIXME: We could possibly deal with this by writing new holes for each frag */
 			pr_warn("Data in the range 0x%08x to 0x%08x of inode #%u will be lost\n",
 				start, end, f->inocache->ino);
@@ -1067,16 +1067,16 @@ static int jffs2_garbage_collect_hole(struct jffs2_sb_info *c, struct jffs2_eras
 		}
 	} else {
 	fill:
-		ri.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-		ri.nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-		ri.totlen = cpu_to_je32(sizeof(ri));
-		ri.hdr_crc = cpu_to_je32(crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
-
-		ri.ino = cpu_to_je32(f->inocache->ino);
-		ri.version = cpu_to_je32(++f->highest_version);
-		ri.offset = cpu_to_je32(start);
-		ri.dsize = cpu_to_je32(end - start);
-		ri.csize = cpu_to_je32(0);
+		ri.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+		ri.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+		ri.totlen = cpu_to_je32(c, sizeof(ri));
+		ri.hdr_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
+
+		ri.ino = cpu_to_je32(c, f->inocache->ino);
+		ri.version = cpu_to_je32(c, ++f->highest_version);
+		ri.offset = cpu_to_je32(c, start);
+		ri.dsize = cpu_to_je32(c, end - start);
+		ri.csize = cpu_to_je32(c, 0);
 		ri.compr = JFFS2_COMPR_ZERO;
 	}
 
@@ -1088,15 +1088,15 @@ static int jffs2_garbage_collect_hole(struct jffs2_sb_info *c, struct jffs2_eras
 	else
 		ilen = JFFS2_F_I_SIZE(f);
 
-	ri.mode = cpu_to_jemode(JFFS2_F_I_MODE(f));
-	ri.uid = cpu_to_je16(JFFS2_F_I_UID(f));
-	ri.gid = cpu_to_je16(JFFS2_F_I_GID(f));
-	ri.isize = cpu_to_je32(ilen);
-	ri.atime = cpu_to_je32(JFFS2_F_I_ATIME(f));
-	ri.ctime = cpu_to_je32(JFFS2_F_I_CTIME(f));
-	ri.mtime = cpu_to_je32(JFFS2_F_I_MTIME(f));
-	ri.data_crc = cpu_to_je32(0);
-	ri.node_crc = cpu_to_je32(crc32(0, &ri, sizeof(ri)-8));
+	ri.mode = cpu_to_jemode(c, JFFS2_F_I_MODE(f));
+	ri.uid = cpu_to_je16(c, JFFS2_F_I_UID(f));
+	ri.gid = cpu_to_je16(c, JFFS2_F_I_GID(f));
+	ri.isize = cpu_to_je32(c, ilen);
+	ri.atime = cpu_to_je32(c, JFFS2_F_I_ATIME(f));
+	ri.ctime = cpu_to_je32(c, JFFS2_F_I_CTIME(f));
+	ri.mtime = cpu_to_je32(c, JFFS2_F_I_MTIME(f));
+	ri.data_crc = cpu_to_je32(c, 0);
+	ri.node_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(ri)-8));
 
 	ret = jffs2_reserve_space_gc(c, sizeof(ri), &alloclen,
 				     JFFS2_SUMMARY_INODE_SIZE);
@@ -1111,7 +1111,7 @@ static int jffs2_garbage_collect_hole(struct jffs2_sb_info *c, struct jffs2_eras
 		pr_warn("Error writing new hole node: %ld\n", PTR_ERR(new_fn));
 		return PTR_ERR(new_fn);
 	}
-	if (je32_to_cpu(ri.version) == f->highest_version) {
+	if (je32_to_cpu(c, ri.version) == f->highest_version) {
 		jffs2_add_full_dnode_to_inode(c, f, new_fn);
 		if (f->metadata) {
 			jffs2_mark_node_obsolete(c, f->metadata->raw);
@@ -1129,8 +1129,8 @@ static int jffs2_garbage_collect_hole(struct jffs2_sb_info *c, struct jffs2_eras
 	 */
 	D1(if(unlikely(fn->frags <= 1)) {
 			pr_warn("%s(): Replacing fn with %d frag(s) but new ver %d != highest_version %d of ino #%d\n",
-				__func__, fn->frags, je32_to_cpu(ri.version),
-				f->highest_version, je32_to_cpu(ri.ino));
+				__func__, fn->frags, je32_to_cpu(c, ri.version),
+				f->highest_version, je32_to_cpu(c, ri.ino));
 	});
 
 	/* This is a partially-overlapped hole node. Mark it REF_NORMAL not REF_PRISTINE */
@@ -1355,27 +1355,27 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 
 		comprtype = jffs2_compress(c, f, writebuf, &comprbuf, &datalen, &cdatalen);
 
-		ri.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-		ri.nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-		ri.totlen = cpu_to_je32(sizeof(ri) + cdatalen);
-		ri.hdr_crc = cpu_to_je32(crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
-
-		ri.ino = cpu_to_je32(f->inocache->ino);
-		ri.version = cpu_to_je32(++f->highest_version);
-		ri.mode = cpu_to_jemode(JFFS2_F_I_MODE(f));
-		ri.uid = cpu_to_je16(JFFS2_F_I_UID(f));
-		ri.gid = cpu_to_je16(JFFS2_F_I_GID(f));
-		ri.isize = cpu_to_je32(JFFS2_F_I_SIZE(f));
-		ri.atime = cpu_to_je32(JFFS2_F_I_ATIME(f));
-		ri.ctime = cpu_to_je32(JFFS2_F_I_CTIME(f));
-		ri.mtime = cpu_to_je32(JFFS2_F_I_MTIME(f));
-		ri.offset = cpu_to_je32(offset);
-		ri.csize = cpu_to_je32(cdatalen);
-		ri.dsize = cpu_to_je32(datalen);
+		ri.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+		ri.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+		ri.totlen = cpu_to_je32(c, sizeof(ri) + cdatalen);
+		ri.hdr_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(struct jffs2_unknown_node)-4));
+
+		ri.ino = cpu_to_je32(c, f->inocache->ino);
+		ri.version = cpu_to_je32(c, ++f->highest_version);
+		ri.mode = cpu_to_jemode(c, JFFS2_F_I_MODE(f));
+		ri.uid = cpu_to_je16(c, JFFS2_F_I_UID(f));
+		ri.gid = cpu_to_je16(c, JFFS2_F_I_GID(f));
+		ri.isize = cpu_to_je32(c, JFFS2_F_I_SIZE(f));
+		ri.atime = cpu_to_je32(c, JFFS2_F_I_ATIME(f));
+		ri.ctime = cpu_to_je32(c, JFFS2_F_I_CTIME(f));
+		ri.mtime = cpu_to_je32(c, JFFS2_F_I_MTIME(f));
+		ri.offset = cpu_to_je32(c, offset);
+		ri.csize = cpu_to_je32(c, cdatalen);
+		ri.dsize = cpu_to_je32(c, datalen);
 		ri.compr = comprtype & 0xff;
 		ri.usercompr = (comprtype >> 8) & 0xff;
-		ri.node_crc = cpu_to_je32(crc32(0, &ri, sizeof(ri)-8));
-		ri.data_crc = cpu_to_je32(crc32(0, comprbuf, cdatalen));
+		ri.node_crc = cpu_to_je32(c, crc32(0, &ri, sizeof(ri)-8));
+		ri.data_crc = cpu_to_je32(c, crc32(0, comprbuf, cdatalen));
 
 		new_fn = jffs2_write_dnode(c, f, &ri, comprbuf, cdatalen, ALLOC_GC);
 
diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 778275f48a87..ef28e28cb6d4 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -39,6 +39,7 @@ struct jffs2_mount_opts {
 	 * latter users to write to the file system if the amount if the
 	 * available space is less then 'rp_size'. */
 	unsigned int rp_size;
+	unsigned int endian;
 };
 
 /* A struct for the overall file system control.  Pointers to
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271f3770..a51d2481bfee 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -27,47 +27,79 @@
 #include "os-linux.h"
 #endif
 
-#define JFFS2_NATIVE_ENDIAN
+#define JFFS2_ENDIAN_NATIVE 0
+#define JFFS2_ENDIAN_LITTLE 1
+#define JFFS2_ENDIAN_BIG 2
 
 /* Note we handle mode bits conversion from JFFS2 (i.e. Linux) to/from
    whatever OS we're actually running on here too. */
 
-#if defined(JFFS2_NATIVE_ENDIAN)
-#define cpu_to_je16(x) ((jint16_t){x})
-#define cpu_to_je32(x) ((jint32_t){x})
-#define cpu_to_jemode(x) ((jmode_t){os_to_jffs2_mode(x)})
-
-#define constant_cpu_to_je16(x) ((jint16_t){x})
-#define constant_cpu_to_je32(x) ((jint32_t){x})
-
-#define je16_to_cpu(x) ((x).v16)
-#define je32_to_cpu(x) ((x).v32)
-#define jemode_to_cpu(x) (jffs2_to_os_mode((x).m))
-#elif defined(JFFS2_BIG_ENDIAN)
-#define cpu_to_je16(x) ((jint16_t){cpu_to_be16(x)})
-#define cpu_to_je32(x) ((jint32_t){cpu_to_be32(x)})
-#define cpu_to_jemode(x) ((jmode_t){cpu_to_be32(os_to_jffs2_mode(x))})
-
-#define constant_cpu_to_je16(x) ((jint16_t){__constant_cpu_to_be16(x)})
-#define constant_cpu_to_je32(x) ((jint32_t){__constant_cpu_to_be32(x)})
-
-#define je16_to_cpu(x) (be16_to_cpu(x.v16))
-#define je32_to_cpu(x) (be32_to_cpu(x.v32))
-#define jemode_to_cpu(x) (be32_to_cpu(jffs2_to_os_mode((x).m)))
-#elif defined(JFFS2_LITTLE_ENDIAN)
-#define cpu_to_je16(x) ((jint16_t){cpu_to_le16(x)})
-#define cpu_to_je32(x) ((jint32_t){cpu_to_le32(x)})
-#define cpu_to_jemode(x) ((jmode_t){cpu_to_le32(os_to_jffs2_mode(x))})
-
-#define constant_cpu_to_je16(x) ((jint16_t){__constant_cpu_to_le16(x)})
-#define constant_cpu_to_je32(x) ((jint32_t){__constant_cpu_to_le32(x)})
-
-#define je16_to_cpu(x) (le16_to_cpu(x.v16))
-#define je32_to_cpu(x) (le32_to_cpu(x.v32))
-#define jemode_to_cpu(x) (le32_to_cpu(jffs2_to_os_mode((x).m)))
-#else
-#error wibble
-#endif
+static inline jint16_t
+cpu_to_je16(struct jffs2_sb_info *c, u16 x)
+{
+	if (c->mount_opts.endian  == JFFS2_ENDIAN_LITTLE)
+		return ((jint16_t){cpu_to_le16(x)});
+	else if (c->mount_opts.endian  == JFFS2_ENDIAN_BIG)
+		return ((jint16_t){cpu_to_be16(x)});
+	else
+		return ((jint16_t){x});
+}
+
+static inline jint32_t
+cpu_to_je32(struct jffs2_sb_info *c, u32 x)
+{
+	if (c->mount_opts.endian  == JFFS2_ENDIAN_LITTLE)
+		return ((jint32_t){cpu_to_le32(x)});
+	else if (c->mount_opts.endian  == JFFS2_ENDIAN_BIG)
+		return ((jint32_t){cpu_to_be32(x)});
+	else
+		return ((jint32_t){x});
+}
+
+static inline jmode_t
+cpu_to_jemode(struct jffs2_sb_info *c, u32 x)
+{
+	if (c->mount_opts.endian  == JFFS2_ENDIAN_LITTLE)
+		return ((jmode_t){cpu_to_le32(os_to_jffs2_mode(x))});
+	else if (c->mount_opts.endian  == JFFS2_ENDIAN_BIG)
+		return ((jmode_t){cpu_to_be32(os_to_jffs2_mode(x))});
+	else
+		return ((jmode_t){os_to_jffs2_mode(x)});
+}
+
+
+static inline u16
+je16_to_cpu(struct jffs2_sb_info *c, jint16_t x)
+{
+	if (c->mount_opts.endian  == JFFS2_ENDIAN_LITTLE)
+		return le16_to_cpu(x.v16);
+	else if (c->mount_opts.endian  == JFFS2_ENDIAN_BIG)
+		return be16_to_cpu(x.v16);
+	else
+		return ((x).v16);
+}
+
+static inline u32
+je32_to_cpu(struct jffs2_sb_info *c, jint32_t x)
+{
+	if (c->mount_opts.endian  == JFFS2_ENDIAN_LITTLE)
+		return le32_to_cpu(x.v32);
+	else if (c->mount_opts.endian  == JFFS2_ENDIAN_BIG)
+		return be32_to_cpu(x.v32);
+	else
+		return ((x).v32);
+}
+
+static inline u32
+jemode_to_cpu(struct jffs2_sb_info *c, jmode_t x)
+{
+	if (c->mount_opts.endian  == JFFS2_ENDIAN_LITTLE)
+		return le32_to_cpu(jffs2_to_os_mode((x).m));
+	else if (c->mount_opts.endian  == JFFS2_ENDIAN_BIG)
+		return be32_to_cpu(jffs2_to_os_mode((x).m));
+	else
+		return jffs2_to_os_mode((x).m);
+}
 
 /* The minimal node header size */
 #define JFFS2_MIN_NODE_HEADER sizeof(struct jffs2_raw_dirent)
@@ -141,7 +173,7 @@ static inline struct jffs2_inode_cache *jffs2_raw_ref_to_ic(struct jffs2_raw_nod
 /* Dirent nodes should be REF_PRISTINE only if they are not a deletion
    dirent. Deletion dirents should be REF_NORMAL so that GC gets to
    throw them away when appropriate */
-#define dirent_node_state(rd)	( (je32_to_cpu((rd)->ino)?REF_PRISTINE:REF_NORMAL) )
+#define dirent_node_state(c, rd)	( (je32_to_cpu((c), (rd)->ino)?REF_PRISTINE:REF_NORMAL) )
 
 /* NB: REF_PRISTINE for an inode-less node (ref->next_in_ino == NULL) indicates
    it is an unknown node of type JFFS2_NODETYPE_RWCOMPAT_COPY, so it'll get
@@ -313,13 +345,14 @@ static inline int jffs2_blocks_use_vmalloc(struct jffs2_sb_info *c)
 
 #define PAD(x) (((x)+3)&~3)
 
-static inline int jffs2_encode_dev(union jffs2_device_node *jdev, dev_t rdev)
+static inline int jffs2_encode_dev(struct jffs2_sb_info *c,
+				union jffs2_device_node *jdev, dev_t rdev)
 {
 	if (old_valid_dev(rdev)) {
-		jdev->old_id = cpu_to_je16(old_encode_dev(rdev));
+		jdev->old_id = cpu_to_je16(c, old_encode_dev(rdev));
 		return sizeof(jdev->old_id);
 	} else {
-		jdev->new_id = cpu_to_je32(new_encode_dev(rdev));
+		jdev->new_id = cpu_to_je32(c, new_encode_dev(rdev));
 		return sizeof(jdev->new_id);
 	}
 }
diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index a7bbe879cfc3..32c362464ba6 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -766,18 +766,18 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 			ref_offset(ref), retlen);
 		goto out_erase_sem;
 	}
-	if (PAD(je32_to_cpu(n.totlen)) != PAD(freed_len)) {
+	if (PAD(je32_to_cpu(c, n.totlen)) != PAD(freed_len)) {
 		pr_warn("Node totlen on flash (0x%08x) != totlen from node ref (0x%08x)\n",
-			je32_to_cpu(n.totlen), freed_len);
+			je32_to_cpu(c, n.totlen), freed_len);
 		goto out_erase_sem;
 	}
-	if (!(je16_to_cpu(n.nodetype) & JFFS2_NODE_ACCURATE)) {
+	if (!(je16_to_cpu(c, n.nodetype) & JFFS2_NODE_ACCURATE)) {
 		jffs2_dbg(1, "Node at 0x%08x was already marked obsolete (nodetype 0x%04x)\n",
-			  ref_offset(ref), je16_to_cpu(n.nodetype));
+			  ref_offset(ref), je16_to_cpu(c, n.nodetype));
 		goto out_erase_sem;
 	}
 	/* XXX FIXME: This is ugly now */
-	n.nodetype = cpu_to_je16(je16_to_cpu(n.nodetype) & ~JFFS2_NODE_ACCURATE);
+	n.nodetype = cpu_to_je16(c, je16_to_cpu(c, n.nodetype) & ~JFFS2_NODE_ACCURATE);
 	ret = jffs2_flash_write(c, ref_offset(ref), sizeof(n), &retlen, (char *)&n);
 	if (ret) {
 		pr_warn("Write error in obliterating obsoleted node at 0x%08x: %d\n",
diff --git a/fs/jffs2/read.c b/fs/jffs2/read.c
index 0b042b1fc82f..95f66eb2b184 100644
--- a/fs/jffs2/read.c
+++ b/fs/jffs2/read.c
@@ -51,26 +51,26 @@ int jffs2_read_dnode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 	crc = crc32(0, ri, sizeof(*ri)-8);
 
 	jffs2_dbg(1, "Node read from %08x: node_crc %08x, calculated CRC %08x. dsize %x, csize %x, offset %x, buf %p\n",
-		  ref_offset(fd->raw), je32_to_cpu(ri->node_crc),
-		  crc, je32_to_cpu(ri->dsize), je32_to_cpu(ri->csize),
-		  je32_to_cpu(ri->offset), buf);
-	if (crc != je32_to_cpu(ri->node_crc)) {
+		  ref_offset(fd->raw), je32_to_cpu(c, ri->node_crc),
+		  crc, je32_to_cpu(c, ri->dsize), je32_to_cpu(c, ri->csize),
+		  je32_to_cpu(c, ri->offset), buf);
+	if (crc != je32_to_cpu(c, ri->node_crc)) {
 		pr_warn("Node CRC %08x != calculated CRC %08x for node at %08x\n",
-			je32_to_cpu(ri->node_crc), crc, ref_offset(fd->raw));
+			je32_to_cpu(c, ri->node_crc), crc, ref_offset(fd->raw));
 		ret = -EIO;
 		goto out_ri;
 	}
 	/* There was a bug where we wrote hole nodes out with csize/dsize
 	   swapped. Deal with it */
-	if (ri->compr == JFFS2_COMPR_ZERO && !je32_to_cpu(ri->dsize) &&
-	    je32_to_cpu(ri->csize)) {
+	if (ri->compr == JFFS2_COMPR_ZERO && !je32_to_cpu(c, ri->dsize) &&
+	    je32_to_cpu(c, ri->csize)) {
 		ri->dsize = ri->csize;
-		ri->csize = cpu_to_je32(0);
+		ri->csize = cpu_to_je32(c, 0);
 	}
 
-	D1(if(ofs + len > je32_to_cpu(ri->dsize)) {
+	D1(if(ofs + len > je32_to_cpu(c, ri->dsize)) {
 			pr_warn("jffs2_read_dnode() asked for %d bytes at %d from %d-byte node\n",
-				len, ofs, je32_to_cpu(ri->dsize));
+				len, ofs, je32_to_cpu(c, ri->dsize));
 		ret = -EINVAL;
 		goto out_ri;
 	});
@@ -87,18 +87,18 @@ int jffs2_read_dnode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 	   Reading partial node and it's uncompressed - read into readbuf, check CRC, and copy
 	   Reading partial node and it's compressed - read into readbuf, check checksum, decompress to decomprbuf and copy
 	*/
-	if (ri->compr == JFFS2_COMPR_NONE && len == je32_to_cpu(ri->dsize)) {
+	if (ri->compr == JFFS2_COMPR_NONE && len == je32_to_cpu(c, ri->dsize)) {
 		readbuf = buf;
 	} else {
-		readbuf = kmalloc(je32_to_cpu(ri->csize), GFP_KERNEL);
+		readbuf = kmalloc(je32_to_cpu(c, ri->csize), GFP_KERNEL);
 		if (!readbuf) {
 			ret = -ENOMEM;
 			goto out_ri;
 		}
 	}
 	if (ri->compr != JFFS2_COMPR_NONE) {
-		if (len < je32_to_cpu(ri->dsize)) {
-			decomprbuf = kmalloc(je32_to_cpu(ri->dsize), GFP_KERNEL);
+		if (len < je32_to_cpu(c, ri->dsize)) {
+			decomprbuf = kmalloc(je32_to_cpu(c, ri->dsize), GFP_KERNEL);
 			if (!decomprbuf) {
 				ret = -ENOMEM;
 				goto out_readbuf;
@@ -110,36 +110,36 @@ int jffs2_read_dnode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 		decomprbuf = readbuf;
 	}
 
-	jffs2_dbg(2, "Read %d bytes to %p\n", je32_to_cpu(ri->csize),
+	jffs2_dbg(2, "Read %d bytes to %p\n", je32_to_cpu(c, ri->csize),
 		  readbuf);
 	ret = jffs2_flash_read(c, (ref_offset(fd->raw)) + sizeof(*ri),
-			       je32_to_cpu(ri->csize), &readlen, readbuf);
+			       je32_to_cpu(c, ri->csize), &readlen, readbuf);
 
-	if (!ret && readlen != je32_to_cpu(ri->csize))
+	if (!ret && readlen != je32_to_cpu(c, ri->csize))
 		ret = -EIO;
 	if (ret)
 		goto out_decomprbuf;
 
-	crc = crc32(0, readbuf, je32_to_cpu(ri->csize));
-	if (crc != je32_to_cpu(ri->data_crc)) {
+	crc = crc32(0, readbuf, je32_to_cpu(c, ri->csize));
+	if (crc != je32_to_cpu(c, ri->data_crc)) {
 		pr_warn("Data CRC %08x != calculated CRC %08x for node at %08x\n",
-			je32_to_cpu(ri->data_crc), crc, ref_offset(fd->raw));
+			je32_to_cpu(c, ri->data_crc), crc, ref_offset(fd->raw));
 		ret = -EIO;
 		goto out_decomprbuf;
 	}
 	jffs2_dbg(2, "Data CRC matches calculated CRC %08x\n", crc);
 	if (ri->compr != JFFS2_COMPR_NONE) {
 		jffs2_dbg(2, "Decompress %d bytes from %p to %d bytes at %p\n",
-			  je32_to_cpu(ri->csize), readbuf,
-			  je32_to_cpu(ri->dsize), decomprbuf);
-		ret = jffs2_decompress(c, f, ri->compr | (ri->usercompr << 8), readbuf, decomprbuf, je32_to_cpu(ri->csize), je32_to_cpu(ri->dsize));
+			  je32_to_cpu(c, ri->csize), readbuf,
+			  je32_to_cpu(c, ri->dsize), decomprbuf);
+		ret = jffs2_decompress(c, f, ri->compr | (ri->usercompr << 8), readbuf, decomprbuf, je32_to_cpu(c, ri->csize), je32_to_cpu(c, ri->dsize));
 		if (ret) {
 			pr_warn("Error: jffs2_decompress returned %d\n", ret);
 			goto out_decomprbuf;
 		}
 	}
 
-	if (len < je32_to_cpu(ri->dsize)) {
+	if (len < je32_to_cpu(c, ri->dsize)) {
 		memcpy(buf, decomprbuf+ofs, len);
 	}
  out_decomprbuf:
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 389ea53ea487..fdca03c9c803 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -594,9 +594,9 @@ static inline int read_direntry(struct jffs2_sb_info *c, struct jffs2_raw_node_r
 	BUG_ON(ref_obsolete(ref));
 
 	crc = crc32(0, rd, sizeof(*rd) - 8);
-	if (unlikely(crc != je32_to_cpu(rd->node_crc))) {
+	if (unlikely(crc != je32_to_cpu(c, rd->node_crc))) {
 		JFFS2_NOTICE("header CRC failed on dirent node at %#08x: read %#08x, calculated %#08x\n",
-			     ref_offset(ref), je32_to_cpu(rd->node_crc), crc);
+			     ref_offset(ref), je32_to_cpu(c, rd->node_crc), crc);
 		jffs2_mark_node_obsolete(c, ref);
 		return 0;
 	}
@@ -607,9 +607,9 @@ static inline int read_direntry(struct jffs2_sb_info *c, struct jffs2_raw_node_r
 		int len;
 
 		/* Sanity check */
-		if (unlikely(PAD((rd->nsize + sizeof(*rd))) != PAD(je32_to_cpu(rd->totlen)))) {
+		if (unlikely(PAD((rd->nsize + sizeof(*rd))) != PAD(je32_to_cpu(c, rd->totlen)))) {
 			JFFS2_ERROR("illegal nsize in node at %#08x: nsize %#02x, totlen %#04x\n",
-				    ref_offset(ref), rd->nsize, je32_to_cpu(rd->totlen));
+				    ref_offset(ref), rd->nsize, je32_to_cpu(c, rd->totlen));
 			jffs2_mark_node_obsolete(c, ref);
 			return 0;
 		}
@@ -622,7 +622,7 @@ static inline int read_direntry(struct jffs2_sb_info *c, struct jffs2_raw_node_r
 		jeb->unchecked_size -= len;
 		c->used_size += len;
 		c->unchecked_size -= len;
-		ref->flash_offset = ref_offset(ref) | dirent_node_state(rd);
+		ref->flash_offset = ref_offset(ref) | dirent_node_state(c, rd);
 		spin_unlock(&c->erase_completion_lock);
 	}
 
@@ -631,17 +631,17 @@ static inline int read_direntry(struct jffs2_sb_info *c, struct jffs2_raw_node_r
 		return -ENOMEM;
 
 	fd->raw = ref;
-	fd->version = je32_to_cpu(rd->version);
-	fd->ino = je32_to_cpu(rd->ino);
+	fd->version = je32_to_cpu(c, rd->version);
+	fd->ino = je32_to_cpu(c, rd->ino);
 	fd->type = rd->type;
 
 	if (fd->version > rii->highest_version)
 		rii->highest_version = fd->version;
 
 	/* Pick out the mctime of the latest dirent */
-	if(fd->version > rii->mctime_ver && je32_to_cpu(rd->mctime)) {
+	if(fd->version > rii->mctime_ver && je32_to_cpu(c, rd->mctime)) {
 		rii->mctime_ver = fd->version;
-		rii->latest_mctime = je32_to_cpu(rd->mctime);
+		rii->latest_mctime = je32_to_cpu(c, rd->mctime);
 	}
 
 	/*
@@ -707,9 +707,9 @@ static inline int read_dnode(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 	BUG_ON(ref_obsolete(ref));
 
 	crc = crc32(0, rd, sizeof(*rd) - 8);
-	if (unlikely(crc != je32_to_cpu(rd->node_crc))) {
+	if (unlikely(crc != je32_to_cpu(c, rd->node_crc))) {
 		JFFS2_NOTICE("node CRC failed on dnode at %#08x: read %#08x, calculated %#08x\n",
-			     ref_offset(ref), je32_to_cpu(rd->node_crc), crc);
+			     ref_offset(ref), je32_to_cpu(c, rd->node_crc), crc);
 		jffs2_mark_node_obsolete(c, ref);
 		return 0;
 	}
@@ -721,14 +721,14 @@ static inline int read_dnode(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 	}
 
 	tn->partial_crc = 0;
-	csize = je32_to_cpu(rd->csize);
+	csize = je32_to_cpu(c, rd->csize);
 
 	/* If we've never checked the CRCs on this node, check them now */
 	if (ref_flags(ref) == REF_UNCHECKED) {
 
 		/* Sanity checks */
-		if (unlikely(je32_to_cpu(rd->offset) > je32_to_cpu(rd->isize)) ||
-		    unlikely(PAD(je32_to_cpu(rd->csize) + sizeof(*rd)) != PAD(je32_to_cpu(rd->totlen)))) {
+		if (unlikely(je32_to_cpu(c, rd->offset) > je32_to_cpu(c, rd->isize)) ||
+		    unlikely(PAD(je32_to_cpu(c, rd->csize) + sizeof(*rd)) != PAD(je32_to_cpu(c, rd->totlen)))) {
 			JFFS2_WARNING("inode node header CRC is corrupted at %#08x\n", ref_offset(ref));
 			jffs2_dbg_dump_node(c, ref_offset(ref));
 			jffs2_mark_node_obsolete(c, ref);
@@ -783,9 +783,9 @@ static inline int read_dnode(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 
 			/* If we actually calculated the whole data CRC
 			 * and it is wrong, drop the node. */
-			if (len >= csize && unlikely(tn->partial_crc != je32_to_cpu(rd->data_crc))) {
+			if (len >= csize && unlikely(tn->partial_crc != je32_to_cpu(c, rd->data_crc))) {
 				JFFS2_NOTICE("wrong data CRC in data node at 0x%08x: read %#08x, calculated %#08x.\n",
-					ref_offset(ref), tn->partial_crc, je32_to_cpu(rd->data_crc));
+					ref_offset(ref), tn->partial_crc, je32_to_cpu(c, rd->data_crc));
 				jffs2_mark_node_obsolete(c, ref);
 				goto free_out;
 			}
@@ -820,9 +820,9 @@ static inline int read_dnode(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 		goto free_out;
 	}
 
-	tn->version = je32_to_cpu(rd->version);
-	tn->fn->ofs = je32_to_cpu(rd->offset);
-	tn->data_crc = je32_to_cpu(rd->data_crc);
+	tn->version = je32_to_cpu(c, rd->version);
+	tn->fn->ofs = je32_to_cpu(c, rd->offset);
+	tn->data_crc = je32_to_cpu(c, rd->data_crc);
 	tn->csize = csize;
 	tn->fn->raw = ref;
 	tn->overlapped = 0;
@@ -832,14 +832,14 @@ static inline int read_dnode(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 
 	/* There was a bug where we wrote hole nodes out with
 	   csize/dsize swapped. Deal with it */
-	if (rd->compr == JFFS2_COMPR_ZERO && !je32_to_cpu(rd->dsize) && csize)
+	if (rd->compr == JFFS2_COMPR_ZERO && !je32_to_cpu(c, rd->dsize) && csize)
 		tn->fn->size = csize;
 	else // normal case...
-		tn->fn->size = je32_to_cpu(rd->dsize);
+		tn->fn->size = je32_to_cpu(c, rd->dsize);
 
 	dbg_readinode2("dnode @%08x: ver %u, offset %#04x, dsize %#04x, csize %#04x\n",
-		       ref_offset(ref), je32_to_cpu(rd->version),
-		       je32_to_cpu(rd->offset), je32_to_cpu(rd->dsize), csize);
+		       ref_offset(ref), je32_to_cpu(c, rd->version),
+		       je32_to_cpu(c, rd->offset), je32_to_cpu(c, rd->dsize), csize);
 
 	ret = jffs2_add_tn_to_tree(c, rii, tn);
 
@@ -850,7 +850,7 @@ static inline int read_dnode(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 		return ret;
 	}
 #ifdef JFFS2_DBG_READINODE2_MESSAGES
-	dbg_readinode2("After adding ver %d:\n", je32_to_cpu(rd->version));
+	dbg_readinode2("After adding ver %d:\n", je32_to_cpu(c, rd->version));
 	tn = tn_first(&rii->tn_root);
 	while (tn) {
 		dbg_readinode2("%p: v %d r 0x%x-0x%x ov %d\n",
@@ -876,37 +876,37 @@ static inline int read_unknown(struct jffs2_sb_info *c, struct jffs2_raw_node_re
 		JFFS2_ERROR("REF_UNCHECKED but unknown node at %#08x\n",
 			    ref_offset(ref));
 		JFFS2_ERROR("Node is {%04x,%04x,%08x,%08x}. Please report this error.\n",
-			    je16_to_cpu(un->magic), je16_to_cpu(un->nodetype),
-			    je32_to_cpu(un->totlen), je32_to_cpu(un->hdr_crc));
+			    je16_to_cpu(c, un->magic), je16_to_cpu(c, un->nodetype),
+			    je32_to_cpu(c, un->totlen), je32_to_cpu(c, un->hdr_crc));
 		jffs2_mark_node_obsolete(c, ref);
 		return 0;
 	}
 
-	un->nodetype = cpu_to_je16(JFFS2_NODE_ACCURATE | je16_to_cpu(un->nodetype));
+	un->nodetype = cpu_to_je16(c, JFFS2_NODE_ACCURATE | je16_to_cpu(c, un->nodetype));
 
-	switch(je16_to_cpu(un->nodetype) & JFFS2_COMPAT_MASK) {
+	switch(je16_to_cpu(c, un->nodetype) & JFFS2_COMPAT_MASK) {
 
 	case JFFS2_FEATURE_INCOMPAT:
 		JFFS2_ERROR("unknown INCOMPAT nodetype %#04X at %#08x\n",
-			    je16_to_cpu(un->nodetype), ref_offset(ref));
+			    je16_to_cpu(c, un->nodetype), ref_offset(ref));
 		/* EEP */
 		BUG();
 		break;
 
 	case JFFS2_FEATURE_ROCOMPAT:
 		JFFS2_ERROR("unknown ROCOMPAT nodetype %#04X at %#08x\n",
-			    je16_to_cpu(un->nodetype), ref_offset(ref));
+			    je16_to_cpu(c, un->nodetype), ref_offset(ref));
 		BUG_ON(!(c->flags & JFFS2_SB_FLAG_RO));
 		break;
 
 	case JFFS2_FEATURE_RWCOMPAT_COPY:
 		JFFS2_NOTICE("unknown RWCOMPAT_COPY nodetype %#04X at %#08x\n",
-			     je16_to_cpu(un->nodetype), ref_offset(ref));
+			     je16_to_cpu(c, un->nodetype), ref_offset(ref));
 		break;
 
 	case JFFS2_FEATURE_RWCOMPAT_DELETE:
 		JFFS2_NOTICE("unknown RWCOMPAT_DELETE nodetype %#04X at %#08x\n",
-			     je16_to_cpu(un->nodetype), ref_offset(ref));
+			     je16_to_cpu(c, un->nodetype), ref_offset(ref));
 		jffs2_mark_node_obsolete(c, ref);
 		return 0;
 	}
@@ -1041,25 +1041,25 @@ static int jffs2_get_inode_nodes(struct jffs2_sb_info *c, struct jffs2_inode_inf
 		node = (union jffs2_node_union *)buf;
 
 		/* No need to mask in the valid bit; it shouldn't be invalid */
-		if (je32_to_cpu(node->u.hdr_crc) != crc32(0, node, sizeof(node->u)-4)) {
+		if (je32_to_cpu(c, node->u.hdr_crc) != crc32(0, node, sizeof(node->u)-4)) {
 			JFFS2_NOTICE("Node header CRC failed at %#08x. {%04x,%04x,%08x,%08x}\n",
-				     ref_offset(ref), je16_to_cpu(node->u.magic),
-				     je16_to_cpu(node->u.nodetype),
-				     je32_to_cpu(node->u.totlen),
-				     je32_to_cpu(node->u.hdr_crc));
+				     ref_offset(ref), je16_to_cpu(c, node->u.magic),
+				     je16_to_cpu(c, node->u.nodetype),
+				     je32_to_cpu(c, node->u.totlen),
+				     je32_to_cpu(c, node->u.hdr_crc));
 			jffs2_dbg_dump_node(c, ref_offset(ref));
 			jffs2_mark_node_obsolete(c, ref);
 			goto cont;
 		}
-		if (je16_to_cpu(node->u.magic) != JFFS2_MAGIC_BITMASK) {
+		if (je16_to_cpu(c, node->u.magic) != JFFS2_MAGIC_BITMASK) {
 			/* Not a JFFS2 node, whinge and move on */
 			JFFS2_NOTICE("Wrong magic bitmask 0x%04x in node header at %#08x.\n",
-				     je16_to_cpu(node->u.magic), ref_offset(ref));
+				     je16_to_cpu(c, node->u.magic), ref_offset(ref));
 			jffs2_mark_node_obsolete(c, ref);
 			goto cont;
 		}
 
-		switch (je16_to_cpu(node->u.nodetype)) {
+		switch (je16_to_cpu(c, node->u.nodetype)) {
 
 		case JFFS2_NODETYPE_DIRENT:
 
@@ -1191,12 +1191,12 @@ static int jffs2_do_read_inode_internal(struct jffs2_sb_info *c,
 			}
 			JFFS2_NOTICE("but it has children so we fake some modes for it\n");
 		}
-		latest_node->mode = cpu_to_jemode(S_IFDIR|S_IRUGO|S_IWUSR|S_IXUGO);
-		latest_node->version = cpu_to_je32(0);
-		latest_node->atime = latest_node->ctime = latest_node->mtime = cpu_to_je32(0);
-		latest_node->isize = cpu_to_je32(0);
-		latest_node->gid = cpu_to_je16(0);
-		latest_node->uid = cpu_to_je16(0);
+		latest_node->mode = cpu_to_jemode(c, S_IFDIR|S_IRUGO|S_IWUSR|S_IXUGO);
+		latest_node->version = cpu_to_je32(c, 0);
+		latest_node->atime = latest_node->ctime = latest_node->mtime = cpu_to_je32(c, 0);
+		latest_node->isize = cpu_to_je32(c, 0);
+		latest_node->gid = cpu_to_je16(c, 0);
+		latest_node->uid = cpu_to_je16(c, 0);
 		if (f->inocache->state == INO_STATE_READING)
 			jffs2_set_inocache_state(c, f->inocache, INO_STATE_PRESENT);
 		return 0;
@@ -1211,29 +1211,29 @@ static int jffs2_do_read_inode_internal(struct jffs2_sb_info *c,
 	}
 
 	crc = crc32(0, latest_node, sizeof(*latest_node)-8);
-	if (crc != je32_to_cpu(latest_node->node_crc)) {
+	if (crc != je32_to_cpu(c, latest_node->node_crc)) {
 		JFFS2_ERROR("CRC failed for read_inode of inode %u at physical location 0x%x\n",
 			f->inocache->ino, ref_offset(rii.latest_ref));
 		return -EIO;
 	}
 
-	switch(jemode_to_cpu(latest_node->mode) & S_IFMT) {
+	switch(jemode_to_cpu(c, latest_node->mode) & S_IFMT) {
 	case S_IFDIR:
-		if (rii.mctime_ver > je32_to_cpu(latest_node->version)) {
+		if (rii.mctime_ver > je32_to_cpu(c, latest_node->version)) {
 			/* The times in the latest_node are actually older than
 			   mctime in the latest dirent. Cheat. */
-			latest_node->ctime = latest_node->mtime = cpu_to_je32(rii.latest_mctime);
+			latest_node->ctime = latest_node->mtime = cpu_to_je32(c, rii.latest_mctime);
 		}
 		break;
 
 
 	case S_IFREG:
 		/* If it was a regular file, truncate it to the latest node's isize */
-		new_size = jffs2_truncate_fragtree(c, &f->fragtree, je32_to_cpu(latest_node->isize));
-		if (new_size != je32_to_cpu(latest_node->isize)) {
+		new_size = jffs2_truncate_fragtree(c, &f->fragtree, je32_to_cpu(c, latest_node->isize));
+		if (new_size != je32_to_cpu(c, latest_node->isize)) {
 			JFFS2_WARNING("Truncating ino #%u to %d bytes failed because it only had %d bytes to start with!\n",
-				      f->inocache->ino, je32_to_cpu(latest_node->isize), new_size);
-			latest_node->isize = cpu_to_je32(new_size);
+				      f->inocache->ino, je32_to_cpu(c, latest_node->isize), new_size);
+			latest_node->isize = cpu_to_je32(c, new_size);
 		}
 		break;
 
@@ -1242,14 +1242,14 @@ static int jffs2_do_read_inode_internal(struct jffs2_sb_info *c,
 		   Remove this when dwmw2 comes to his senses and stops
 		   symlinks from being an entirely gratuitous special
 		   case. */
-		if (!je32_to_cpu(latest_node->isize))
+		if (!je32_to_cpu(c, latest_node->isize))
 			latest_node->isize = latest_node->dsize;
 
 		if (f->inocache->state != INO_STATE_CHECKING) {
 			/* Symlink's inode data is the target path. Read it and
 			 * keep in RAM to facilitate quick follow symlink
 			 * operation. */
-			uint32_t csize = je32_to_cpu(latest_node->csize);
+			uint32_t csize = je32_to_cpu(c, latest_node->csize);
 			if (csize > JFFS2_MAX_NAME_LEN)
 				return -ENAMETOOLONG;
 			f->target = kmalloc(csize + 1, GFP_KERNEL);
@@ -1281,18 +1281,18 @@ static int jffs2_do_read_inode_internal(struct jffs2_sb_info *c,
 		   kept as the metadata node */
 		if (f->metadata) {
 			JFFS2_ERROR("Argh. Special inode #%u with mode 0%o had metadata node\n",
-			       f->inocache->ino, jemode_to_cpu(latest_node->mode));
+			       f->inocache->ino, jemode_to_cpu(c, latest_node->mode));
 			return -EIO;
 		}
 		if (!frag_first(&f->fragtree)) {
 			JFFS2_ERROR("Argh. Special inode #%u with mode 0%o has no fragments\n",
-			       f->inocache->ino, jemode_to_cpu(latest_node->mode));
+			       f->inocache->ino, jemode_to_cpu(c, latest_node->mode));
 			return -EIO;
 		}
 		/* ASSERT: f->fraglist != NULL */
 		if (frag_next(frag_first(&f->fragtree))) {
 			JFFS2_ERROR("Argh. Special inode #%u with mode 0x%x had more than one node\n",
-			       f->inocache->ino, jemode_to_cpu(latest_node->mode));
+			       f->inocache->ino, jemode_to_cpu(c, latest_node->mode));
 			/* FIXME: Deal with it - check crc32, check for duplicate node, check times and discard the older one */
 			return -EIO;
 		}
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 90431dd613b8..07c74dafb44e 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -333,23 +333,23 @@ static int jffs2_scan_xattr_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 	int err;
 
 	crc = crc32(0, rx, sizeof(struct jffs2_raw_xattr) - 4);
-	if (crc != je32_to_cpu(rx->node_crc)) {
+	if (crc != je32_to_cpu(c, rx->node_crc)) {
 		JFFS2_WARNING("node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
-			      ofs, je32_to_cpu(rx->node_crc), crc);
-		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rx->totlen))))
+			      ofs, je32_to_cpu(c, rx->node_crc), crc);
+		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(c, rx->totlen))))
 			return err;
 		return 0;
 	}
 
-	xid = je32_to_cpu(rx->xid);
-	version = je32_to_cpu(rx->version);
+	xid = je32_to_cpu(c, rx->xid);
+	version = je32_to_cpu(c, rx->version);
 
 	totlen = PAD(sizeof(struct jffs2_raw_xattr)
-			+ rx->name_len + 1 + je16_to_cpu(rx->value_len));
-	if (totlen != je32_to_cpu(rx->totlen)) {
+			+ rx->name_len + 1 + je16_to_cpu(c, rx->value_len));
+	if (totlen != je32_to_cpu(c, rx->totlen)) {
 		JFFS2_WARNING("node length mismatch at %#08x, read=%u, calc=%u\n",
-			      ofs, je32_to_cpu(rx->totlen), totlen);
-		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rx->totlen))))
+			      ofs, je32_to_cpu(c, rx->totlen), totlen);
+		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(c, rx->totlen))))
 			return err;
 		return 0;
 	}
@@ -367,14 +367,14 @@ static int jffs2_scan_xattr_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 		xd->version = version;
 		xd->xprefix = rx->xprefix;
 		xd->name_len = rx->name_len;
-		xd->value_len = je16_to_cpu(rx->value_len);
-		xd->data_crc = je32_to_cpu(rx->data_crc);
+		xd->value_len = je16_to_cpu(c, rx->value_len);
+		xd->data_crc = je32_to_cpu(c, rx->data_crc);
 
 		jffs2_link_node_ref(c, jeb, ofs | REF_PRISTINE, totlen, (void *)xd);
 	}
 
 	if (jffs2_sum_active())
-		jffs2_sum_add_xattr_mem(s, rx, ofs - jeb->offset);
+		jffs2_sum_add_xattr_mem(c, s, rx, ofs - jeb->offset);
 	dbg_xattr("scanning xdatum at %#08x (xid=%u, version=%u)\n",
 		  ofs, xd->xid, xd->version);
 	return 0;
@@ -389,19 +389,19 @@ static int jffs2_scan_xref_node(struct jffs2_sb_info *c, struct jffs2_eraseblock
 	int err;
 
 	crc = crc32(0, rr, sizeof(*rr) - 4);
-	if (crc != je32_to_cpu(rr->node_crc)) {
+	if (crc != je32_to_cpu(c, rr->node_crc)) {
 		JFFS2_WARNING("node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
-			      ofs, je32_to_cpu(rr->node_crc), crc);
-		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rr->totlen)))))
+			      ofs, je32_to_cpu(c, rr->node_crc), crc);
+		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, rr->totlen)))))
 			return err;
 		return 0;
 	}
 
-	if (PAD(sizeof(struct jffs2_raw_xref)) != je32_to_cpu(rr->totlen)) {
+	if (PAD(sizeof(struct jffs2_raw_xref)) != je32_to_cpu(c, rr->totlen)) {
 		JFFS2_WARNING("node length mismatch at %#08x, read=%u, calc=%zd\n",
-			      ofs, je32_to_cpu(rr->totlen),
+			      ofs, je32_to_cpu(c, rr->totlen),
 			      PAD(sizeof(struct jffs2_raw_xref)));
-		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(rr->totlen))))
+		if ((err = jffs2_scan_dirty_space(c, jeb, je32_to_cpu(c, rr->totlen))))
 			return err;
 		return 0;
 	}
@@ -419,18 +419,18 @@ static int jffs2_scan_xref_node(struct jffs2_sb_info *c, struct jffs2_eraseblock
 	 * used to chain all xattr_ref object. It's re-chained to
 	 * jffs2_inode_cache in jffs2_build_xattr_subsystem() correctly.
 	 */
-	ref->ino = je32_to_cpu(rr->ino);
-	ref->xid = je32_to_cpu(rr->xid);
-	ref->xseqno = je32_to_cpu(rr->xseqno);
+	ref->ino = je32_to_cpu(c, rr->ino);
+	ref->xid = je32_to_cpu(c, rr->xid);
+	ref->xseqno = je32_to_cpu(c, rr->xseqno);
 	if (ref->xseqno > c->highest_xseqno)
 		c->highest_xseqno = (ref->xseqno & ~XREF_DELETE_MARKER);
 	ref->next = c->xref_temp;
 	c->xref_temp = ref;
 
-	jffs2_link_node_ref(c, jeb, ofs | REF_PRISTINE, PAD(je32_to_cpu(rr->totlen)), (void *)ref);
+	jffs2_link_node_ref(c, jeb, ofs | REF_PRISTINE, PAD(je32_to_cpu(c, rr->totlen)), (void *)ref);
 
 	if (jffs2_sum_active())
-		jffs2_sum_add_xref_mem(s, rr, ofs - jeb->offset);
+		jffs2_sum_add_xref_mem(c, s, rr, ofs - jeb->offset);
 	dbg_xattr("scan xref at %#08x (xid=%u, ino=%u)\n",
 		  ofs, ref->xid, ref->ino);
 	return 0;
@@ -487,9 +487,9 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 		if (!buf_size) {
 			/* XIP case. Just look, point at the summary if it's there */
 			sm = (void *)buf + c->sector_size - sizeof(*sm);
-			if (je32_to_cpu(sm->magic) == JFFS2_SUM_MAGIC) {
-				sumptr = buf + je32_to_cpu(sm->offset);
-				sumlen = c->sector_size - je32_to_cpu(sm->offset);
+			if (je32_to_cpu(c, sm->magic) == JFFS2_SUM_MAGIC) {
+				sumptr = buf + je32_to_cpu(c, sm->offset);
+				sumlen = c->sector_size - je32_to_cpu(c, sm->offset);
 			}
 		} else {
 			/* If NAND flash, read a whole page of it. Else just the end */
@@ -506,8 +506,8 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 				return err;
 
 			sm = (void *)buf + buf_size - sizeof(*sm);
-			if (je32_to_cpu(sm->magic) == JFFS2_SUM_MAGIC) {
-				sumlen = c->sector_size - je32_to_cpu(sm->offset);
+			if (je32_to_cpu(c, sm->magic) == JFFS2_SUM_MAGIC) {
+				sumlen = c->sector_size - je32_to_cpu(c, sm->offset);
 				sumptr = buf + buf_size - sumlen;
 
 				/* sm->offset maybe wrong but MAGIC maybe right */
@@ -715,7 +715,7 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			goto more_empty;
 		}
 
-		if (ofs == jeb->offset && je16_to_cpu(node->magic) == KSAMTIB_CIGAM_2SFFJ) {
+		if (ofs == jeb->offset && je16_to_cpu(c, node->magic) == KSAMTIB_CIGAM_2SFFJ) {
 			pr_warn("Magic bitmask is backwards at offset 0x%08x. Wrong endian filesystem?\n",
 				ofs);
 			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
@@ -723,14 +723,14 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			ofs += 4;
 			continue;
 		}
-		if (je16_to_cpu(node->magic) == JFFS2_DIRTY_BITMASK) {
+		if (je16_to_cpu(c, node->magic) == JFFS2_DIRTY_BITMASK) {
 			jffs2_dbg(1, "Dirty bitmask at 0x%08x\n", ofs);
 			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
 				return err;
 			ofs += 4;
 			continue;
 		}
-		if (je16_to_cpu(node->magic) == JFFS2_OLD_MAGIC_BITMASK) {
+		if (je16_to_cpu(c, node->magic) == JFFS2_OLD_MAGIC_BITMASK) {
 			pr_warn("Old JFFS2 bitmask found at 0x%08x\n", ofs);
 			pr_warn("You cannot use older JFFS2 filesystems with newer kernels\n");
 			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
@@ -738,12 +738,12 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			ofs += 4;
 			continue;
 		}
-		if (je16_to_cpu(node->magic) != JFFS2_MAGIC_BITMASK) {
+		if (je16_to_cpu(c, node->magic) != JFFS2_MAGIC_BITMASK) {
 			/* OK. We're out of possibilities. Whinge and move on */
 			noisy_printk(&noise, "%s(): Magic bitmask 0x%04x not found at 0x%08x: 0x%04x instead\n",
 				     __func__,
 				     JFFS2_MAGIC_BITMASK, ofs,
-				     je16_to_cpu(node->magic));
+				     je16_to_cpu(c, node->magic));
 			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
 				return err;
 			ofs += 4;
@@ -751,17 +751,17 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 		}
 		/* We seem to have a node of sorts. Check the CRC */
 		crcnode.magic = node->magic;
-		crcnode.nodetype = cpu_to_je16( je16_to_cpu(node->nodetype) | JFFS2_NODE_ACCURATE);
+		crcnode.nodetype = cpu_to_je16(c, je16_to_cpu(c, node->nodetype) | JFFS2_NODE_ACCURATE);
 		crcnode.totlen = node->totlen;
 		hdr_crc = crc32(0, &crcnode, sizeof(crcnode)-4);
 
-		if (hdr_crc != je32_to_cpu(node->hdr_crc)) {
+		if (hdr_crc != je32_to_cpu(c, node->hdr_crc)) {
 			noisy_printk(&noise, "%s(): Node at 0x%08x {0x%04x, 0x%04x, 0x%08x) has invalid CRC 0x%08x (calculated 0x%08x)\n",
 				     __func__,
-				     ofs, je16_to_cpu(node->magic),
-				     je16_to_cpu(node->nodetype),
-				     je32_to_cpu(node->totlen),
-				     je32_to_cpu(node->hdr_crc),
+				     ofs, je16_to_cpu(c, node->magic),
+				     je16_to_cpu(c, node->nodetype),
+				     je32_to_cpu(c, node->totlen),
+				     je32_to_cpu(c, node->hdr_crc),
 				     hdr_crc);
 			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
 				return err;
@@ -769,10 +769,10 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			continue;
 		}
 
-		if (ofs + je32_to_cpu(node->totlen) > jeb->offset + c->sector_size) {
+		if (ofs + je32_to_cpu(c, node->totlen) > jeb->offset + c->sector_size) {
 			/* Eep. Node goes over the end of the erase block. */
 			pr_warn("Node at 0x%08x with length 0x%08x would run over the end of the erase block\n",
-				ofs, je32_to_cpu(node->totlen));
+				ofs, je32_to_cpu(c, node->totlen));
 			pr_warn("Perhaps the file system was created with the wrong erase size?\n");
 			if ((err = jffs2_scan_dirty_space(c, jeb, 4)))
 				return err;
@@ -780,17 +780,17 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			continue;
 		}
 
-		if (!(je16_to_cpu(node->nodetype) & JFFS2_NODE_ACCURATE)) {
+		if (!(je16_to_cpu(c, node->nodetype) & JFFS2_NODE_ACCURATE)) {
 			/* Wheee. This is an obsoleted node */
 			jffs2_dbg(2, "Node at 0x%08x is obsolete. Skipping\n",
 				  ofs);
-			if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
+			if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, node->totlen)))))
 				return err;
-			ofs += PAD(je32_to_cpu(node->totlen));
+			ofs += PAD(je32_to_cpu(c, node->totlen));
 			continue;
 		}
 
-		switch(je16_to_cpu(node->nodetype)) {
+		switch(je16_to_cpu(c, node->nodetype)) {
 		case JFFS2_NODETYPE_INODE:
 			if (buf_ofs + buf_len < ofs + sizeof(struct jffs2_raw_inode)) {
 				buf_len = min_t(uint32_t, buf_size, jeb->offset + c->sector_size - ofs);
@@ -805,14 +805,14 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			}
 			err = jffs2_scan_inode_node(c, jeb, (void *)node, ofs, s);
 			if (err) return err;
-			ofs += PAD(je32_to_cpu(node->totlen));
+			ofs += PAD(je32_to_cpu(c, node->totlen));
 			break;
 
 		case JFFS2_NODETYPE_DIRENT:
-			if (buf_ofs + buf_len < ofs + je32_to_cpu(node->totlen)) {
+			if (buf_ofs + buf_len < ofs + je32_to_cpu(c, node->totlen)) {
 				buf_len = min_t(uint32_t, buf_size, jeb->offset + c->sector_size - ofs);
 				jffs2_dbg(1, "Fewer than %d bytes (dirent node) left to end of buf. Reading 0x%x at 0x%08x\n",
-					  je32_to_cpu(node->totlen), buf_len,
+					  je32_to_cpu(c, node->totlen), buf_len,
 					  ofs);
 				err = jffs2_fill_scan_buf(c, buf, ofs, buf_len);
 				if (err)
@@ -822,15 +822,15 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			}
 			err = jffs2_scan_dirent_node(c, jeb, (void *)node, ofs, s);
 			if (err) return err;
-			ofs += PAD(je32_to_cpu(node->totlen));
+			ofs += PAD(je32_to_cpu(c, node->totlen));
 			break;
 
 #ifdef CONFIG_JFFS2_FS_XATTR
 		case JFFS2_NODETYPE_XATTR:
-			if (buf_ofs + buf_len < ofs + je32_to_cpu(node->totlen)) {
+			if (buf_ofs + buf_len < ofs + je32_to_cpu(c, node->totlen)) {
 				buf_len = min_t(uint32_t, buf_size, jeb->offset + c->sector_size - ofs);
 				jffs2_dbg(1, "Fewer than %d bytes (xattr node) left to end of buf. Reading 0x%x at 0x%08x\n",
-					  je32_to_cpu(node->totlen), buf_len,
+					  je32_to_cpu(c, node->totlen), buf_len,
 					  ofs);
 				err = jffs2_fill_scan_buf(c, buf, ofs, buf_len);
 				if (err)
@@ -841,13 +841,13 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			err = jffs2_scan_xattr_node(c, jeb, (void *)node, ofs, s);
 			if (err)
 				return err;
-			ofs += PAD(je32_to_cpu(node->totlen));
+			ofs += PAD(je32_to_cpu(c, node->totlen));
 			break;
 		case JFFS2_NODETYPE_XREF:
-			if (buf_ofs + buf_len < ofs + je32_to_cpu(node->totlen)) {
+			if (buf_ofs + buf_len < ofs + je32_to_cpu(c, node->totlen)) {
 				buf_len = min_t(uint32_t, buf_size, jeb->offset + c->sector_size - ofs);
 				jffs2_dbg(1, "Fewer than %d bytes (xref node) left to end of buf. Reading 0x%x at 0x%08x\n",
-					  je32_to_cpu(node->totlen), buf_len,
+					  je32_to_cpu(c, node->totlen), buf_len,
 					  ofs);
 				err = jffs2_fill_scan_buf(c, buf, ofs, buf_len);
 				if (err)
@@ -858,15 +858,15 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 			err = jffs2_scan_xref_node(c, jeb, (void *)node, ofs, s);
 			if (err)
 				return err;
-			ofs += PAD(je32_to_cpu(node->totlen));
+			ofs += PAD(je32_to_cpu(c, node->totlen));
 			break;
 #endif	/* CONFIG_JFFS2_FS_XATTR */
 
 		case JFFS2_NODETYPE_CLEANMARKER:
 			jffs2_dbg(1, "CLEANMARKER node found at 0x%08x\n", ofs);
-			if (je32_to_cpu(node->totlen) != c->cleanmarker_size) {
+			if (je32_to_cpu(c, node->totlen) != c->cleanmarker_size) {
 				pr_notice("CLEANMARKER node found at 0x%08x has totlen 0x%x != normal 0x%x\n",
-					  ofs, je32_to_cpu(node->totlen),
+					  ofs, je32_to_cpu(c, node->totlen),
 					  c->cleanmarker_size);
 				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(sizeof(struct jffs2_unknown_node)))))
 					return err;
@@ -886,47 +886,47 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 
 		case JFFS2_NODETYPE_PADDING:
 			if (jffs2_sum_active())
-				jffs2_sum_add_padding_mem(s, je32_to_cpu(node->totlen));
-			if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
+				jffs2_sum_add_padding_mem(s, je32_to_cpu(c, node->totlen));
+			if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, node->totlen)))))
 				return err;
-			ofs += PAD(je32_to_cpu(node->totlen));
+			ofs += PAD(je32_to_cpu(c, node->totlen));
 			break;
 
 		default:
-			switch (je16_to_cpu(node->nodetype) & JFFS2_COMPAT_MASK) {
+			switch (je16_to_cpu(c, node->nodetype) & JFFS2_COMPAT_MASK) {
 			case JFFS2_FEATURE_ROCOMPAT:
 				pr_notice("Read-only compatible feature node (0x%04x) found at offset 0x%08x\n",
-					  je16_to_cpu(node->nodetype), ofs);
+					  je16_to_cpu(c, node->nodetype), ofs);
 				c->flags |= JFFS2_SB_FLAG_RO;
 				if (!(jffs2_is_readonly(c)))
 					return -EROFS;
-				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
+				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, node->totlen)))))
 					return err;
-				ofs += PAD(je32_to_cpu(node->totlen));
+				ofs += PAD(je32_to_cpu(c, node->totlen));
 				break;
 
 			case JFFS2_FEATURE_INCOMPAT:
 				pr_notice("Incompatible feature node (0x%04x) found at offset 0x%08x\n",
-					  je16_to_cpu(node->nodetype), ofs);
+					  je16_to_cpu(c, node->nodetype), ofs);
 				return -EINVAL;
 
 			case JFFS2_FEATURE_RWCOMPAT_DELETE:
 				jffs2_dbg(1, "Unknown but compatible feature node (0x%04x) found at offset 0x%08x\n",
-					  je16_to_cpu(node->nodetype), ofs);
-				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(node->totlen)))))
+					  je16_to_cpu(c, node->nodetype), ofs);
+				if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, node->totlen)))))
 					return err;
-				ofs += PAD(je32_to_cpu(node->totlen));
+				ofs += PAD(je32_to_cpu(c, node->totlen));
 				break;
 
 			case JFFS2_FEATURE_RWCOMPAT_COPY: {
 				jffs2_dbg(1, "Unknown but compatible feature node (0x%04x) found at offset 0x%08x\n",
-					  je16_to_cpu(node->nodetype), ofs);
+					  je16_to_cpu(c, node->nodetype), ofs);
 
-				jffs2_link_node_ref(c, jeb, ofs | REF_PRISTINE, PAD(je32_to_cpu(node->totlen)), NULL);
+				jffs2_link_node_ref(c, jeb, ofs | REF_PRISTINE, PAD(je32_to_cpu(c, node->totlen)), NULL);
 
 				/* We can't summarise nodes we don't grok */
 				jffs2_sum_disable_collecting(s);
-				ofs += PAD(je32_to_cpu(node->totlen));
+				ofs += PAD(je32_to_cpu(c, node->totlen));
 				break;
 				}
 			}
@@ -986,7 +986,7 @@ static int jffs2_scan_inode_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 				 struct jffs2_raw_inode *ri, uint32_t ofs, struct jffs2_summary *s)
 {
 	struct jffs2_inode_cache *ic;
-	uint32_t crc, ino = je32_to_cpu(ri->ino);
+	uint32_t crc, ino = je32_to_cpu(c, ri->ino);
 
 	jffs2_dbg(1, "%s(): Node at 0x%08x\n", __func__, ofs);
 
@@ -1001,15 +1001,15 @@ static int jffs2_scan_inode_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 
 	/* Check the node CRC in any case. */
 	crc = crc32(0, ri, sizeof(*ri)-8);
-	if (crc != je32_to_cpu(ri->node_crc)) {
+	if (crc != je32_to_cpu(c, ri->node_crc)) {
 		pr_notice("%s(): CRC failed on node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
-			  __func__, ofs, je32_to_cpu(ri->node_crc), crc);
+			  __func__, ofs, je32_to_cpu(c, ri->node_crc), crc);
 		/*
 		 * We believe totlen because the CRC on the node
 		 * _header_ was OK, just the node itself failed.
 		 */
 		return jffs2_scan_dirty_space(c, jeb,
-					      PAD(je32_to_cpu(ri->totlen)));
+					      PAD(je32_to_cpu(c, ri->totlen)));
 	}
 
 	ic = jffs2_get_ino_cache(c, ino);
@@ -1020,17 +1020,17 @@ static int jffs2_scan_inode_node(struct jffs2_sb_info *c, struct jffs2_erasebloc
 	}
 
 	/* Wheee. It worked */
-	jffs2_link_node_ref(c, jeb, ofs | REF_UNCHECKED, PAD(je32_to_cpu(ri->totlen)), ic);
+	jffs2_link_node_ref(c, jeb, ofs | REF_UNCHECKED, PAD(je32_to_cpu(c, ri->totlen)), ic);
 
 	jffs2_dbg(1, "Node is ino #%u, version %d. Range 0x%x-0x%x\n",
-		  je32_to_cpu(ri->ino), je32_to_cpu(ri->version),
-		  je32_to_cpu(ri->offset),
-		  je32_to_cpu(ri->offset)+je32_to_cpu(ri->dsize));
+		  je32_to_cpu(c, ri->ino), je32_to_cpu(c, ri->version),
+		  je32_to_cpu(c, ri->offset),
+		  je32_to_cpu(c, ri->offset)+je32_to_cpu(c, ri->dsize));
 
-	pseudo_random += je32_to_cpu(ri->version);
+	pseudo_random += je32_to_cpu(c, ri->version);
 
 	if (jffs2_sum_active()) {
-		jffs2_sum_add_inode_mem(s, ri, ofs - jeb->offset);
+		jffs2_sum_add_inode_mem(c, s, ri, ofs - jeb->offset);
 	}
 
 	return 0;
@@ -1051,16 +1051,16 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_info *c, struct jffs2_eraseblo
 	   mask in the ACCURATE bit any more. */
 	crc = crc32(0, rd, sizeof(*rd)-8);
 
-	if (crc != je32_to_cpu(rd->node_crc)) {
+	if (crc != je32_to_cpu(c, rd->node_crc)) {
 		pr_notice("%s(): Node CRC failed on node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
-			  __func__, ofs, je32_to_cpu(rd->node_crc), crc);
+			  __func__, ofs, je32_to_cpu(c, rd->node_crc), crc);
 		/* We believe totlen because the CRC on the node _header_ was OK, just the node itself failed. */
-		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)))))
+		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, rd->totlen)))))
 			return err;
 		return 0;
 	}
 
-	pseudo_random += je32_to_cpu(rd->version);
+	pseudo_random += je32_to_cpu(c, rd->version);
 
 	/* Should never happen. Did. (OLPC trac #4184)*/
 	checkedlen = strnlen(rd->name, rd->nsize);
@@ -1076,36 +1076,36 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_info *c, struct jffs2_eraseblo
 	fd->name[checkedlen] = 0;
 
 	crc = crc32(0, fd->name, rd->nsize);
-	if (crc != je32_to_cpu(rd->name_crc)) {
+	if (crc != je32_to_cpu(c, rd->name_crc)) {
 		pr_notice("%s(): Name CRC failed on node at 0x%08x: Read 0x%08x, calculated 0x%08x\n",
-			  __func__, ofs, je32_to_cpu(rd->name_crc), crc);
+			  __func__, ofs, je32_to_cpu(c, rd->name_crc), crc);
 		jffs2_dbg(1, "Name for which CRC failed is (now) '%s', ino #%d\n",
-			  fd->name, je32_to_cpu(rd->ino));
+			  fd->name, je32_to_cpu(c, rd->ino));
 		jffs2_free_full_dirent(fd);
 		/* FIXME: Why do we believe totlen? */
 		/* We believe totlen because the CRC on the node _header_ was OK, just the name failed. */
-		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)))))
+		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, rd->totlen)))))
 			return err;
 		return 0;
 	}
-	ic = jffs2_scan_make_ino_cache(c, je32_to_cpu(rd->pino));
+	ic = jffs2_scan_make_ino_cache(c, je32_to_cpu(c, rd->pino));
 	if (!ic) {
 		jffs2_free_full_dirent(fd);
 		return -ENOMEM;
 	}
 
-	fd->raw = jffs2_link_node_ref(c, jeb, ofs | dirent_node_state(rd),
-				      PAD(je32_to_cpu(rd->totlen)), ic);
+	fd->raw = jffs2_link_node_ref(c, jeb, ofs | dirent_node_state(c, rd),
+				      PAD(je32_to_cpu(c, rd->totlen)), ic);
 
 	fd->next = NULL;
-	fd->version = je32_to_cpu(rd->version);
-	fd->ino = je32_to_cpu(rd->ino);
+	fd->version = je32_to_cpu(c, rd->version);
+	fd->ino = je32_to_cpu(c, rd->ino);
 	fd->nhash = full_name_hash(NULL, fd->name, checkedlen);
 	fd->type = rd->type;
 	jffs2_add_fd_to_list(c, fd, &ic->scan_dents);
 
 	if (jffs2_sum_active()) {
-		jffs2_sum_add_dirent_mem(s, rd, ofs - jeb->offset);
+		jffs2_sum_add_dirent_mem(c, s, rd, ofs - jeb->offset);
 	}
 
 	return 0;
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index be7c8a6a5748..11998d98861b 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -60,7 +60,8 @@ void jffs2_sum_exit(struct jffs2_sb_info *c)
 	c->summary = NULL;
 }
 
-static int jffs2_sum_add_mem(struct jffs2_summary *s, union jffs2_sum_mem *item)
+static int jffs2_sum_add_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+						union jffs2_sum_mem *item)
 {
 	if (!s->sum_list_head)
 		s->sum_list_head = (union jffs2_sum_mem *) item;
@@ -68,25 +69,25 @@ static int jffs2_sum_add_mem(struct jffs2_summary *s, union jffs2_sum_mem *item)
 		s->sum_list_tail->u.next = (union jffs2_sum_mem *) item;
 	s->sum_list_tail = (union jffs2_sum_mem *) item;
 
-	switch (je16_to_cpu(item->u.nodetype)) {
+	switch (je16_to_cpu(c, item->u.nodetype)) {
 		case JFFS2_NODETYPE_INODE:
 			s->sum_size += JFFS2_SUMMARY_INODE_SIZE;
 			s->sum_num++;
 			dbg_summary("inode (%u) added to summary\n",
-						je32_to_cpu(item->i.inode));
+						je32_to_cpu(c, item->i.inode));
 			break;
 		case JFFS2_NODETYPE_DIRENT:
 			s->sum_size += JFFS2_SUMMARY_DIRENT_SIZE(item->d.nsize);
 			s->sum_num++;
 			dbg_summary("dirent (%u) added to summary\n",
-						je32_to_cpu(item->d.ino));
+						je32_to_cpu(c, item->d.ino));
 			break;
 #ifdef CONFIG_JFFS2_FS_XATTR
 		case JFFS2_NODETYPE_XATTR:
 			s->sum_size += JFFS2_SUMMARY_XATTR_SIZE;
 			s->sum_num++;
 			dbg_summary("xattr (xid=%u, version=%u) added to summary\n",
-				    je32_to_cpu(item->x.xid), je32_to_cpu(item->x.version));
+				    je32_to_cpu(c, item->x.xid), je32_to_cpu(c, item->x.version));
 			break;
 		case JFFS2_NODETYPE_XREF:
 			s->sum_size += JFFS2_SUMMARY_XREF_SIZE;
@@ -96,7 +97,7 @@ static int jffs2_sum_add_mem(struct jffs2_summary *s, union jffs2_sum_mem *item)
 #endif
 		default:
 			JFFS2_WARNING("UNKNOWN node type %u\n",
-					    je16_to_cpu(item->u.nodetype));
+					    je16_to_cpu(c, item->u.nodetype));
 			return 1;
 	}
 	return 0;
@@ -112,8 +113,8 @@ int jffs2_sum_add_padding_mem(struct jffs2_summary *s, uint32_t size)
 	return 0;
 }
 
-int jffs2_sum_add_inode_mem(struct jffs2_summary *s, struct jffs2_raw_inode *ri,
-				uint32_t ofs)
+int jffs2_sum_add_inode_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_inode *ri, uint32_t ofs)
 {
 	struct jffs2_sum_inode_mem *temp = kmalloc(sizeof(struct jffs2_sum_inode_mem), GFP_KERNEL);
 
@@ -123,15 +124,15 @@ int jffs2_sum_add_inode_mem(struct jffs2_summary *s, struct jffs2_raw_inode *ri,
 	temp->nodetype = ri->nodetype;
 	temp->inode = ri->ino;
 	temp->version = ri->version;
-	temp->offset = cpu_to_je32(ofs); /* relative offset from the beginning of the jeb */
+	temp->offset = cpu_to_je32(c, ofs); /* relative offset from the beginning of the jeb */
 	temp->totlen = ri->totlen;
 	temp->next = NULL;
 
-	return jffs2_sum_add_mem(s, (union jffs2_sum_mem *)temp);
+	return jffs2_sum_add_mem(c, s, (union jffs2_sum_mem *)temp);
 }
 
-int jffs2_sum_add_dirent_mem(struct jffs2_summary *s, struct jffs2_raw_dirent *rd,
-				uint32_t ofs)
+int jffs2_sum_add_dirent_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_dirent *rd, uint32_t ofs)
 {
 	struct jffs2_sum_dirent_mem *temp =
 		kmalloc(sizeof(struct jffs2_sum_dirent_mem) + rd->nsize, GFP_KERNEL);
@@ -141,7 +142,7 @@ int jffs2_sum_add_dirent_mem(struct jffs2_summary *s, struct jffs2_raw_dirent *r
 
 	temp->nodetype = rd->nodetype;
 	temp->totlen = rd->totlen;
-	temp->offset = cpu_to_je32(ofs);	/* relative from the beginning of the jeb */
+	temp->offset = cpu_to_je32(c, ofs);	/* relative from the beginning of the jeb */
 	temp->pino = rd->pino;
 	temp->version = rd->version;
 	temp->ino = rd->ino;
@@ -151,11 +152,12 @@ int jffs2_sum_add_dirent_mem(struct jffs2_summary *s, struct jffs2_raw_dirent *r
 
 	memcpy(temp->name, rd->name, rd->nsize);
 
-	return jffs2_sum_add_mem(s, (union jffs2_sum_mem *)temp);
+	return jffs2_sum_add_mem(c, s, (union jffs2_sum_mem *)temp);
 }
 
 #ifdef CONFIG_JFFS2_FS_XATTR
-int jffs2_sum_add_xattr_mem(struct jffs2_summary *s, struct jffs2_raw_xattr *rx, uint32_t ofs)
+int jffs2_sum_add_xattr_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_xattr *rx, uint32_t ofs)
 {
 	struct jffs2_sum_xattr_mem *temp;
 
@@ -166,14 +168,15 @@ int jffs2_sum_add_xattr_mem(struct jffs2_summary *s, struct jffs2_raw_xattr *rx,
 	temp->nodetype = rx->nodetype;
 	temp->xid = rx->xid;
 	temp->version = rx->version;
-	temp->offset = cpu_to_je32(ofs);
+	temp->offset = cpu_to_je32(c, ofs);
 	temp->totlen = rx->totlen;
 	temp->next = NULL;
 
-	return jffs2_sum_add_mem(s, (union jffs2_sum_mem *)temp);
+	return jffs2_sum_add_mem(c, s, (union jffs2_sum_mem *)temp);
 }
 
-int jffs2_sum_add_xref_mem(struct jffs2_summary *s, struct jffs2_raw_xref *rr, uint32_t ofs)
+int jffs2_sum_add_xref_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_xref *rr, uint32_t ofs)
 {
 	struct jffs2_sum_xref_mem *temp;
 
@@ -182,10 +185,10 @@ int jffs2_sum_add_xref_mem(struct jffs2_summary *s, struct jffs2_raw_xref *rr, u
 		return -ENOMEM;
 
 	temp->nodetype = rr->nodetype;
-	temp->offset = cpu_to_je32(ofs);
+	temp->offset = cpu_to_je32(c, ofs);
 	temp->next = NULL;
 
-	return jffs2_sum_add_mem(s, (union jffs2_sum_mem *)temp);
+	return jffs2_sum_add_mem(c, s, (union jffs2_sum_mem *)temp);
 }
 #endif
 /* Cleanup every collected summary information */
@@ -260,7 +263,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 	jeb = &c->blocks[ofs / c->sector_size];
 	ofs -= jeb->offset;
 
-	switch (je16_to_cpu(node->u.nodetype)) {
+	switch (je16_to_cpu(c, node->u.nodetype)) {
 		case JFFS2_NODETYPE_INODE: {
 			struct jffs2_sum_inode_mem *temp =
 				kmalloc(sizeof(struct jffs2_sum_inode_mem), GFP_KERNEL);
@@ -271,11 +274,11 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 			temp->nodetype = node->i.nodetype;
 			temp->inode = node->i.ino;
 			temp->version = node->i.version;
-			temp->offset = cpu_to_je32(ofs);
+			temp->offset = cpu_to_je32(c, ofs);
 			temp->totlen = node->i.totlen;
 			temp->next = NULL;
 
-			return jffs2_sum_add_mem(c->summary, (union jffs2_sum_mem *)temp);
+			return jffs2_sum_add_mem(c, c->summary, (union jffs2_sum_mem *)temp);
 		}
 
 		case JFFS2_NODETYPE_DIRENT: {
@@ -287,7 +290,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 
 			temp->nodetype = node->d.nodetype;
 			temp->totlen = node->d.totlen;
-			temp->offset = cpu_to_je32(ofs);
+			temp->offset = cpu_to_je32(c, ofs);
 			temp->pino = node->d.pino;
 			temp->version = node->d.version;
 			temp->ino = node->d.ino;
@@ -309,7 +312,7 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 					break;
 			}
 
-			return jffs2_sum_add_mem(c->summary, (union jffs2_sum_mem *)temp);
+			return jffs2_sum_add_mem(c, c->summary, (union jffs2_sum_mem *)temp);
 		}
 #ifdef CONFIG_JFFS2_FS_XATTR
 		case JFFS2_NODETYPE_XATTR: {
@@ -322,10 +325,10 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 			temp->xid = node->x.xid;
 			temp->version = node->x.version;
 			temp->totlen = node->x.totlen;
-			temp->offset = cpu_to_je32(ofs);
+			temp->offset = cpu_to_je32(c, ofs);
 			temp->next = NULL;
 
-			return jffs2_sum_add_mem(c->summary, (union jffs2_sum_mem *)temp);
+			return jffs2_sum_add_mem(c, c->summary, (union jffs2_sum_mem *)temp);
 		}
 		case JFFS2_NODETYPE_XREF: {
 			struct jffs2_sum_xref_mem *temp;
@@ -333,15 +336,15 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 			if (!temp)
 				goto no_mem;
 			temp->nodetype = node->r.nodetype;
-			temp->offset = cpu_to_je32(ofs);
+			temp->offset = cpu_to_je32(c, ofs);
 			temp->next = NULL;
 
-			return jffs2_sum_add_mem(c->summary, (union jffs2_sum_mem *)temp);
+			return jffs2_sum_add_mem(c, c->summary, (union jffs2_sum_mem *)temp);
 		}
 #endif
 		case JFFS2_NODETYPE_PADDING:
 			dbg_summary("node PADDING\n");
-			c->summary->sum_padded += je32_to_cpu(node->u.totlen);
+			c->summary->sum_padded += je32_to_cpu(c, node->u.totlen);
 			break;
 
 		case JFFS2_NODETYPE_CLEANMARKER:
@@ -394,7 +397,7 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 
 	sp = summary->sum;
 
-	for (i=0; i<je32_to_cpu(summary->sum_num); i++) {
+	for (i=0; i<je32_to_cpu(c, summary->sum_num); i++) {
 		dbg_summary("processing summary index %d\n", i);
 
 		cond_resched();
@@ -404,16 +407,16 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 		if (err)
 			return err;
 
-		switch (je16_to_cpu(((struct jffs2_sum_unknown_flash *)sp)->nodetype)) {
+		switch (je16_to_cpu(c, ((struct jffs2_sum_unknown_flash *)sp)->nodetype)) {
 			case JFFS2_NODETYPE_INODE: {
 				struct jffs2_sum_inode_flash *spi;
 				spi = sp;
 
-				ino = je32_to_cpu(spi->inode);
+				ino = je32_to_cpu(c, spi->inode);
 
 				dbg_summary("Inode at 0x%08x-0x%08x\n",
-					    jeb->offset + je32_to_cpu(spi->offset),
-					    jeb->offset + je32_to_cpu(spi->offset) + je32_to_cpu(spi->totlen));
+					    jeb->offset + je32_to_cpu(c, spi->offset),
+					    jeb->offset + je32_to_cpu(c, spi->offset) + je32_to_cpu(c, spi->totlen));
 
 				ic = jffs2_scan_make_ino_cache(c, ino);
 				if (!ic) {
@@ -421,10 +424,10 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 					return -ENOMEM;
 				}
 
-				sum_link_node_ref(c, jeb, je32_to_cpu(spi->offset) | REF_UNCHECKED,
-						  PAD(je32_to_cpu(spi->totlen)), ic);
+				sum_link_node_ref(c, jeb, je32_to_cpu(c, spi->offset) | REF_UNCHECKED,
+						  PAD(je32_to_cpu(c, spi->totlen)), ic);
 
-				*pseudo_random += je32_to_cpu(spi->version);
+				*pseudo_random += je32_to_cpu(c, spi->version);
 
 				sp += JFFS2_SUMMARY_INODE_SIZE;
 
@@ -437,8 +440,8 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 				spd = sp;
 
 				dbg_summary("Dirent at 0x%08x-0x%08x\n",
-					    jeb->offset + je32_to_cpu(spd->offset),
-					    jeb->offset + je32_to_cpu(spd->offset) + je32_to_cpu(spd->totlen));
+					    jeb->offset + je32_to_cpu(c, spd->offset),
+					    jeb->offset + je32_to_cpu(c, spd->offset) + je32_to_cpu(c, spd->totlen));
 
 
 				/* This should never happen, but https://dev.laptop.org/ticket/4184 */
@@ -446,13 +449,13 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 				if (!checkedlen) {
 					pr_err("Dirent at %08x has zero at start of name. Aborting mount.\n",
 					       jeb->offset +
-					       je32_to_cpu(spd->offset));
+					       je32_to_cpu(c, spd->offset));
 					return -EIO;
 				}
 				if (checkedlen < spd->nsize) {
 					pr_err("Dirent at %08x has zeroes in name. Truncating to %d chars\n",
 					       jeb->offset +
-					       je32_to_cpu(spd->offset),
+					       je32_to_cpu(c, spd->offset),
 					       checkedlen);
 				}
 
@@ -464,24 +467,24 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 				memcpy(&fd->name, spd->name, checkedlen);
 				fd->name[checkedlen] = 0;
 
-				ic = jffs2_scan_make_ino_cache(c, je32_to_cpu(spd->pino));
+				ic = jffs2_scan_make_ino_cache(c, je32_to_cpu(c, spd->pino));
 				if (!ic) {
 					jffs2_free_full_dirent(fd);
 					return -ENOMEM;
 				}
 
-				fd->raw = sum_link_node_ref(c, jeb,  je32_to_cpu(spd->offset) | REF_UNCHECKED,
-							    PAD(je32_to_cpu(spd->totlen)), ic);
+				fd->raw = sum_link_node_ref(c, jeb,  je32_to_cpu(c, spd->offset) | REF_UNCHECKED,
+							    PAD(je32_to_cpu(c, spd->totlen)), ic);
 
 				fd->next = NULL;
-				fd->version = je32_to_cpu(spd->version);
-				fd->ino = je32_to_cpu(spd->ino);
+				fd->version = je32_to_cpu(c, spd->version);
+				fd->ino = je32_to_cpu(c, spd->ino);
 				fd->nhash = full_name_hash(NULL, fd->name, checkedlen);
 				fd->type = spd->type;
 
 				jffs2_add_fd_to_list(c, fd, &ic->scan_dents);
 
-				*pseudo_random += je32_to_cpu(spd->version);
+				*pseudo_random += je32_to_cpu(c, spd->version);
 
 				sp += JFFS2_SUMMARY_DIRENT_SIZE(spd->nsize);
 
@@ -494,27 +497,27 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 
 				spx = (struct jffs2_sum_xattr_flash *)sp;
 				dbg_summary("xattr at %#08x-%#08x (xid=%u, version=%u)\n", 
-					    jeb->offset + je32_to_cpu(spx->offset),
-					    jeb->offset + je32_to_cpu(spx->offset) + je32_to_cpu(spx->totlen),
-					    je32_to_cpu(spx->xid), je32_to_cpu(spx->version));
+					    jeb->offset + je32_to_cpu(c, spx->offset),
+					    jeb->offset + je32_to_cpu(c, spx->offset) + je32_to_cpu(c, spx->totlen),
+					    je32_to_cpu(c, spx->xid), je32_to_cpu(c, spx->version));
 
-				xd = jffs2_setup_xattr_datum(c, je32_to_cpu(spx->xid),
-								je32_to_cpu(spx->version));
+				xd = jffs2_setup_xattr_datum(c, je32_to_cpu(c, spx->xid),
+								je32_to_cpu(c, spx->version));
 				if (IS_ERR(xd))
 					return PTR_ERR(xd);
-				if (xd->version > je32_to_cpu(spx->version)) {
+				if (xd->version > je32_to_cpu(c, spx->version)) {
 					/* node is not the newest one */
 					struct jffs2_raw_node_ref *raw
-						= sum_link_node_ref(c, jeb, je32_to_cpu(spx->offset) | REF_UNCHECKED,
-								    PAD(je32_to_cpu(spx->totlen)), NULL);
+						= sum_link_node_ref(c, jeb, je32_to_cpu(c, spx->offset) | REF_UNCHECKED,
+								    PAD(je32_to_cpu(c, spx->totlen)), NULL);
 					raw->next_in_ino = xd->node->next_in_ino;
 					xd->node->next_in_ino = raw;
 				} else {
-					xd->version = je32_to_cpu(spx->version);
-					sum_link_node_ref(c, jeb, je32_to_cpu(spx->offset) | REF_UNCHECKED,
-							  PAD(je32_to_cpu(spx->totlen)), (void *)xd);
+					xd->version = je32_to_cpu(c, spx->version);
+					sum_link_node_ref(c, jeb, je32_to_cpu(c, spx->offset) | REF_UNCHECKED,
+							  PAD(je32_to_cpu(c, spx->totlen)), (void *)xd);
 				}
-				*pseudo_random += je32_to_cpu(spx->xid);
+				*pseudo_random += je32_to_cpu(c, spx->xid);
 				sp += JFFS2_SUMMARY_XATTR_SIZE;
 
 				break;
@@ -525,8 +528,8 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 
 				spr = (struct jffs2_sum_xref_flash *)sp;
 				dbg_summary("xref at %#08x-%#08x\n",
-					    jeb->offset + je32_to_cpu(spr->offset),
-					    jeb->offset + je32_to_cpu(spr->offset) + 
+					    jeb->offset + je32_to_cpu(c, spr->offset),
+					    jeb->offset + je32_to_cpu(c, spr->offset) + 
 					    (uint32_t)PAD(sizeof(struct jffs2_raw_xref)));
 
 				ref = jffs2_alloc_xattr_ref();
@@ -537,7 +540,7 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 				ref->next = c->xref_temp;
 				c->xref_temp = ref;
 
-				sum_link_node_ref(c, jeb, je32_to_cpu(spr->offset) | REF_UNCHECKED,
+				sum_link_node_ref(c, jeb, je32_to_cpu(c, spr->offset) | REF_UNCHECKED,
 						  PAD(sizeof(struct jffs2_raw_xref)), (void *)ref);
 
 				*pseudo_random += ref->node->flash_offset;
@@ -547,7 +550,7 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 			}
 #endif
 			default : {
-				uint16_t nodetype = je16_to_cpu(((struct jffs2_sum_unknown_flash *)sp)->nodetype);
+				uint16_t nodetype = je16_to_cpu(c, ((struct jffs2_sum_unknown_flash *)sp)->nodetype);
 				JFFS2_WARNING("Unsupported node type %x found in summary! Exiting...\n", nodetype);
 				if ((nodetype & JFFS2_COMPAT_MASK) == JFFS2_FEATURE_INCOMPAT)
 					return -EIO;
@@ -583,37 +586,37 @@ int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 		    jeb->offset, jeb->offset + ofs, sumsize);
 
 	/* OK, now check for node validity and CRC */
-	crcnode.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	crcnode.nodetype = cpu_to_je16(JFFS2_NODETYPE_SUMMARY);
+	crcnode.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	crcnode.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_SUMMARY);
 	crcnode.totlen = summary->totlen;
 	crc = crc32(0, &crcnode, sizeof(crcnode)-4);
 
-	if (je32_to_cpu(summary->hdr_crc) != crc) {
+	if (je32_to_cpu(c, summary->hdr_crc) != crc) {
 		dbg_summary("Summary node header is corrupt (bad CRC or "
 				"no summary at all)\n");
 		goto crc_err;
 	}
 
-	if (je32_to_cpu(summary->totlen) != sumsize) {
+	if (je32_to_cpu(c, summary->totlen) != sumsize) {
 		dbg_summary("Summary node is corrupt (wrong erasesize?)\n");
 		goto crc_err;
 	}
 
 	crc = crc32(0, summary, sizeof(struct jffs2_raw_summary)-8);
 
-	if (je32_to_cpu(summary->node_crc) != crc) {
+	if (je32_to_cpu(c, summary->node_crc) != crc) {
 		dbg_summary("Summary node is corrupt (bad CRC)\n");
 		goto crc_err;
 	}
 
 	crc = crc32(0, summary->sum, sumsize - sizeof(struct jffs2_raw_summary));
 
-	if (je32_to_cpu(summary->sum_crc) != crc) {
+	if (je32_to_cpu(c, summary->sum_crc) != crc) {
 		dbg_summary("Summary node data is corrupt (bad CRC)\n");
 		goto crc_err;
 	}
 
-	if ( je32_to_cpu(summary->cln_mkr) ) {
+	if ( je32_to_cpu(c, summary->cln_mkr) ) {
 
 		dbg_summary("Summary : CLEANMARKER node \n");
 
@@ -621,19 +624,19 @@ int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 		if (ret)
 			return ret;
 
-		if (je32_to_cpu(summary->cln_mkr) != c->cleanmarker_size) {
+		if (je32_to_cpu(c, summary->cln_mkr) != c->cleanmarker_size) {
 			dbg_summary("CLEANMARKER node has totlen 0x%x != normal 0x%x\n",
-				je32_to_cpu(summary->cln_mkr), c->cleanmarker_size);
-			if ((ret = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(summary->cln_mkr)))))
+				je32_to_cpu(c, summary->cln_mkr), c->cleanmarker_size);
+			if ((ret = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, summary->cln_mkr)))))
 				return ret;
 		} else if (jeb->first_node) {
 			dbg_summary("CLEANMARKER node not first node in block "
 					"(0x%08x)\n", jeb->offset);
-			if ((ret = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(summary->cln_mkr)))))
+			if ((ret = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(c, summary->cln_mkr)))))
 				return ret;
 		} else {
 			jffs2_link_node_ref(c, jeb, jeb->offset | REF_NORMAL,
-					    je32_to_cpu(summary->cln_mkr), NULL);
+					    je32_to_cpu(c, summary->cln_mkr), NULL);
 		}
 	}
 
@@ -706,19 +709,19 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
 	memset(c->summary->sum_buf, 0xff, datasize);
 	memset(&isum, 0, sizeof(isum));
 
-	isum.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	isum.nodetype = cpu_to_je16(JFFS2_NODETYPE_SUMMARY);
-	isum.totlen = cpu_to_je32(infosize);
-	isum.hdr_crc = cpu_to_je32(crc32(0, &isum, sizeof(struct jffs2_unknown_node) - 4));
-	isum.padded = cpu_to_je32(c->summary->sum_padded);
-	isum.cln_mkr = cpu_to_je32(c->cleanmarker_size);
-	isum.sum_num = cpu_to_je32(c->summary->sum_num);
+	isum.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	isum.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_SUMMARY);
+	isum.totlen = cpu_to_je32(c, infosize);
+	isum.hdr_crc = cpu_to_je32(c, crc32(0, &isum, sizeof(struct jffs2_unknown_node) - 4));
+	isum.padded = cpu_to_je32(c, c->summary->sum_padded);
+	isum.cln_mkr = cpu_to_je32(c, c->cleanmarker_size);
+	isum.sum_num = cpu_to_je32(c, c->summary->sum_num);
 	wpage = c->summary->sum_buf;
 
 	while (c->summary->sum_num) {
 		temp = c->summary->sum_list_head;
 
-		switch (je16_to_cpu(temp->u.nodetype)) {
+		switch (je16_to_cpu(c, temp->u.nodetype)) {
 			case JFFS2_NODETYPE_INODE: {
 				struct jffs2_sum_inode_flash *sino_ptr = wpage;
 
@@ -778,10 +781,10 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
 			}
 #endif
 			default : {
-				if ((je16_to_cpu(temp->u.nodetype) & JFFS2_COMPAT_MASK)
+				if ((je16_to_cpu(c, temp->u.nodetype) & JFFS2_COMPAT_MASK)
 				    == JFFS2_FEATURE_RWCOMPAT_COPY) {
 					dbg_summary("Writing unknown RWCOMPAT_COPY node type %x\n",
-						    je16_to_cpu(temp->u.nodetype));
+						    je16_to_cpu(c, temp->u.nodetype));
 					jffs2_sum_disable_collecting(c->summary);
 				} else {
 					BUG();	/* unknown node in summary information */
@@ -800,11 +803,11 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
 	wpage += padsize;
 
 	sm = wpage;
-	sm->offset = cpu_to_je32(c->sector_size - jeb->free_size);
-	sm->magic = cpu_to_je32(JFFS2_SUM_MAGIC);
+	sm->offset = cpu_to_je32(c, c->sector_size - jeb->free_size);
+	sm->magic = cpu_to_je32(c, JFFS2_SUM_MAGIC);
 
-	isum.sum_crc = cpu_to_je32(crc32(0, c->summary->sum_buf, datasize));
-	isum.node_crc = cpu_to_je32(crc32(0, &isum, sizeof(isum) - 8));
+	isum.sum_crc = cpu_to_je32(c, crc32(0, c->summary->sum_buf, datasize));
+	isum.node_crc = cpu_to_je32(c, crc32(0, &isum, sizeof(isum) - 8));
 
 	vecs[0].iov_base = &isum;
 	vecs[0].iov_len = sizeof(isum);
diff --git a/fs/jffs2/summary.h b/fs/jffs2/summary.h
index 60207a2ae952..b8558d753f01 100644
--- a/fs/jffs2/summary.h
+++ b/fs/jffs2/summary.h
@@ -182,10 +182,14 @@ int jffs2_sum_add_kvec(struct jffs2_sb_info *c, const struct kvec *invecs,
 			unsigned long count,  uint32_t to);
 int jffs2_sum_write_sumnode(struct jffs2_sb_info *c);
 int jffs2_sum_add_padding_mem(struct jffs2_summary *s, uint32_t size);
-int jffs2_sum_add_inode_mem(struct jffs2_summary *s, struct jffs2_raw_inode *ri, uint32_t ofs);
-int jffs2_sum_add_dirent_mem(struct jffs2_summary *s, struct jffs2_raw_dirent *rd, uint32_t ofs);
-int jffs2_sum_add_xattr_mem(struct jffs2_summary *s, struct jffs2_raw_xattr *rx, uint32_t ofs);
-int jffs2_sum_add_xref_mem(struct jffs2_summary *s, struct jffs2_raw_xref *rr, uint32_t ofs);
+int jffs2_sum_add_inode_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_inode *ri, uint32_t ofs);
+int jffs2_sum_add_dirent_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_dirent *rd, uint32_t ofs);
+int jffs2_sum_add_xattr_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_xattr *rx, uint32_t ofs);
+int jffs2_sum_add_xref_mem(struct jffs2_sb_info *c, struct jffs2_summary *s,
+				struct jffs2_raw_xref *rr, uint32_t ofs);
 int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb,
 			   struct jffs2_raw_summary *summary, uint32_t sumlen,
 			   uint32_t *pseudo_random);
@@ -202,10 +206,10 @@ int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 #define jffs2_sum_move_collected(a,b)
 #define jffs2_sum_write_sumnode(a) (0)
 #define jffs2_sum_add_padding_mem(a,b)
-#define jffs2_sum_add_inode_mem(a,b,c)
-#define jffs2_sum_add_dirent_mem(a,b,c)
-#define jffs2_sum_add_xattr_mem(a,b,c)
-#define jffs2_sum_add_xref_mem(a,b,c)
+#define jffs2_sum_add_inode_mem(a,b,c,d)
+#define jffs2_sum_add_dirent_mem(a,b,c,d)
+#define jffs2_sum_add_xattr_mem(a,b,c,d)
+#define jffs2_sum_add_xref_mem(a,b,c,d)
 #define jffs2_sum_scan_sumnode(a,b,c,d,e) (0)
 
 #endif /* CONFIG_JFFS2_SUMMARY */
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 902a7dd10e5c..73ecc723f7d1 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -63,6 +63,18 @@ static void jffs2_i_init_once(void *foo)
 	inode_init_once(&f->vfs_inode);
 }
 
+static const char *jffs2_endianness(unsigned int endian)
+{
+	switch (endian) {
+	case JFFS2_ENDIAN_LITTLE:
+		return "little";
+	case JFFS2_ENDIAN_BIG:
+		return "big";
+	default:
+		return "native";
+	}
+}
+
 static const char *jffs2_compr_name(unsigned int compr)
 {
 	switch (compr) {
@@ -92,6 +104,8 @@ static int jffs2_show_options(struct seq_file *s, struct dentry *root)
 		seq_printf(s, ",compr=%s", jffs2_compr_name(opts->compr));
 	if (opts->rp_size)
 		seq_printf(s, ",rp_size=%u", opts->rp_size / 1024);
+	if (opts->endian)
+		seq_printf(s, ",force_endian=%s", jffs2_endianness(opts->endian));
 
 	return 0;
 }
@@ -161,17 +175,20 @@ static const struct export_operations jffs2_export_ops = {
  *
  * Opt_override_compr: override default compressor
  * Opt_rp_size: size of reserved pool in KiB
+ * Opt_force_endian: override endianness
  * Opt_err: just end of array marker
  */
 enum {
 	Opt_override_compr,
 	Opt_rp_size,
+	Opt_force_endian,
 	Opt_err,
 };
 
 static const match_table_t tokens = {
 	{Opt_override_compr, "compr=%s"},
 	{Opt_rp_size, "rp_size=%u"},
+	{Opt_force_endian, "force_endian=%s"},
 	{Opt_err, NULL},
 };
 
@@ -228,6 +245,19 @@ static int jffs2_parse_options(struct jffs2_sb_info *c, char *data)
 			}
 			c->mount_opts.rp_size = opt;
 			break;
+		case Opt_force_endian:
+			name = match_strdup(&args[0]);
+
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "little"))
+				c->mount_opts.endian = JFFS2_ENDIAN_LITTLE;
+			else if (!strcmp(name, "big"))
+				c->mount_opts.endian = JFFS2_ENDIAN_BIG;
+			else
+				c->mount_opts.endian = JFFS2_ENDIAN_NATIVE;
+			kfree(name);
+			break;
 		default:
 			pr_err("Error: unrecognized mount option '%s' or missing value\n",
 			       p);
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index c6821a509481..a2d6503d2a05 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -188,18 +188,18 @@ static struct jffs2_raw_node_ref **jffs2_incore_replace_raw(struct jffs2_sb_info
 	struct jffs2_full_dirent *fd;
 
 	dbg_noderef("incore_replace_raw: node at %p is {%04x,%04x}\n",
-		    node, je16_to_cpu(node->u.magic), je16_to_cpu(node->u.nodetype));
+		    node, je16_to_cpu(c, node->u.magic), je16_to_cpu(c, node->u.nodetype));
 
-	BUG_ON(je16_to_cpu(node->u.magic) != 0x1985 &&
-	       je16_to_cpu(node->u.magic) != 0);
+	BUG_ON(je16_to_cpu(c, node->u.magic) != 0x1985 &&
+	       je16_to_cpu(c, node->u.magic) != 0);
 
-	switch (je16_to_cpu(node->u.nodetype)) {
+	switch (je16_to_cpu(c, node->u.nodetype)) {
 	case JFFS2_NODETYPE_INODE:
 		if (f->metadata && f->metadata->raw == raw) {
 			dbg_noderef("Will replace ->raw in f->metadata at %p\n", f->metadata);
 			return &f->metadata->raw;
 		}
-		frag = jffs2_lookup_node_frag(&f->fragtree, je32_to_cpu(node->i.offset));
+		frag = jffs2_lookup_node_frag(&f->fragtree, je32_to_cpu(c, node->i.offset));
 		BUG_ON(!frag);
 		/* Find a frag which refers to the full_dnode we want to modify */
 		while (!frag->node || frag->node->raw != raw) {
@@ -220,7 +220,7 @@ static struct jffs2_raw_node_ref **jffs2_incore_replace_raw(struct jffs2_sb_info
 
 	default:
 		dbg_noderef("Don't care about replacing raw for nodetype %x\n",
-			    je16_to_cpu(node->u.nodetype));
+			    je16_to_cpu(c, node->u.nodetype));
 		break;
 	}
 	return NULL;
@@ -615,10 +615,10 @@ static int __jffs2_flush_wbuf(struct jffs2_sb_info *c, int pad)
 
 		if ( c->wbuf_len + sizeof(struct jffs2_unknown_node) < c->wbuf_pagesize) {
 			struct jffs2_unknown_node *padnode = (void *)(c->wbuf + c->wbuf_len);
-			padnode->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-			padnode->nodetype = cpu_to_je16(JFFS2_NODETYPE_PADDING);
-			padnode->totlen = cpu_to_je32(c->wbuf_pagesize - c->wbuf_len);
-			padnode->hdr_crc = cpu_to_je32(crc32(0, padnode, sizeof(*padnode)-4));
+			padnode->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+			padnode->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_PADDING);
+			padnode->totlen = cpu_to_je32(c, c->wbuf_pagesize - c->wbuf_len);
+			padnode->hdr_crc = cpu_to_je32(c, crc32(0, padnode, sizeof(*padnode)-4));
 		}
 	}
 	/* else jffs2_flash_writev has actually filled in the rest of the
@@ -1019,12 +1019,16 @@ int jffs2_flash_read(struct jffs2_sb_info *c, loff_t ofs, size_t len, size_t *re
 /* For historical reasons we use only 8 bytes for OOB clean marker */
 #define OOB_CM_SIZE 8
 
-static const struct jffs2_unknown_node oob_cleanmarker =
+static struct jffs2_unknown_node oob_cleanmarker;
+
+static void jffs2_init_oob_cleanmarker(struct jffs2_sb_info *c)
 {
-	.magic = constant_cpu_to_je16(JFFS2_MAGIC_BITMASK),
-	.nodetype = constant_cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER),
-	.totlen = constant_cpu_to_je32(8)
-};
+	if (!je16_to_cpu(c, oob_cleanmarker.magic)) {
+		oob_cleanmarker.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+		oob_cleanmarker.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_CLEANMARKER);
+		oob_cleanmarker.totlen = cpu_to_je32(c, 8);
+	}
+}
 
 /*
  * Check, if the out of band area is empty. This function knows about the clean
@@ -1079,6 +1083,7 @@ int jffs2_check_nand_cleanmarker(struct jffs2_sb_info *c,
 	struct mtd_oob_ops ops;
 	int ret, cmlen = min_t(int, c->oobavail, OOB_CM_SIZE);
 
+	jffs2_init_oob_cleanmarker(c);
 	ops.mode = MTD_OPS_AUTO_OOB;
 	ops.ooblen = cmlen;
 	ops.oobbuf = c->oobbuf;
@@ -1104,6 +1109,7 @@ int jffs2_write_nand_cleanmarker(struct jffs2_sb_info *c,
 	struct mtd_oob_ops ops;
 	int cmlen = min_t(int, c->oobavail, OOB_CM_SIZE);
 
+	jffs2_init_oob_cleanmarker(c);
 	ops.mode = MTD_OPS_AUTO_OOB;
 	ops.ooblen = cmlen;
 	ops.oobbuf = (uint8_t *)&oob_cleanmarker;
diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
index cda9a361368e..5706508803fc 100644
--- a/fs/jffs2/write.c
+++ b/fs/jffs2/write.c
@@ -39,16 +39,16 @@ int jffs2_do_new_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 
 	jffs2_add_ino_cache(c, f->inocache);
 	jffs2_dbg(1, "%s(): Assigned ino# %d\n", __func__, f->inocache->ino);
-	ri->ino = cpu_to_je32(f->inocache->ino);
+	ri->ino = cpu_to_je32(c, f->inocache->ino);
 
-	ri->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	ri->nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-	ri->totlen = cpu_to_je32(PAD(sizeof(*ri)));
-	ri->hdr_crc = cpu_to_je32(crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
-	ri->mode = cpu_to_jemode(mode);
+	ri->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	ri->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+	ri->totlen = cpu_to_je32(c, PAD(sizeof(*ri)));
+	ri->hdr_crc = cpu_to_je32(c, crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
+	ri->mode = cpu_to_jemode(c, mode);
 
 	f->highest_version = 1;
-	ri->version = cpu_to_je32(f->highest_version);
+	ri->version = cpu_to_je32(c, f->highest_version);
 
 	return 0;
 }
@@ -69,7 +69,7 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
 	int retried = 0;
 	unsigned long cnt = 2;
 
-	D1(if(je32_to_cpu(ri->hdr_crc) != crc32(0, ri, sizeof(struct jffs2_unknown_node)-4)) {
+	D1(if(je32_to_cpu(c, ri->hdr_crc) != crc32(0, ri, sizeof(struct jffs2_unknown_node)-4)) {
 		pr_crit("Eep. CRC not correct in jffs2_write_dnode()\n");
 		BUG();
 	}
@@ -79,9 +79,9 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
 	vecs[1].iov_base = (unsigned char *)data;
 	vecs[1].iov_len = datalen;
 
-	if (je32_to_cpu(ri->totlen) != sizeof(*ri) + datalen) {
+	if (je32_to_cpu(c, ri->totlen) != sizeof(*ri) + datalen) {
 		pr_warn("%s(): ri->totlen (0x%08x) != sizeof(*ri) (0x%08zx) + datalen (0x%08x)\n",
-			__func__, je32_to_cpu(ri->totlen),
+			__func__, je32_to_cpu(c, ri->totlen),
 			sizeof(*ri), datalen);
 	}
 
@@ -97,13 +97,13 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
 
 	jffs2_dbg_prewrite_paranoia_check(c, flash_ofs, vecs[0].iov_len + vecs[1].iov_len);
 
-	if ((alloc_mode!=ALLOC_GC) && (je32_to_cpu(ri->version) < f->highest_version)) {
+	if ((alloc_mode!=ALLOC_GC) && (je32_to_cpu(c, ri->version) < f->highest_version)) {
 		BUG_ON(!retried);
 		jffs2_dbg(1, "%s(): dnode_version %d, highest version %d -> updating dnode\n",
 			  __func__,
-			  je32_to_cpu(ri->version), f->highest_version);
-		ri->version = cpu_to_je32(++f->highest_version);
-		ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
+			  je32_to_cpu(c, ri->version), f->highest_version);
+		ri->version = cpu_to_je32(c, ++f->highest_version);
+		ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
 	}
 
 	ret = jffs2_flash_writev(c, vecs, cnt, flash_ofs, &retlen,
@@ -172,9 +172,9 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
 	   beginning of a page and runs to the end of the file, or if
 	   it's a hole node, mark it REF_PRISTINE, else REF_NORMAL.
 	*/
-	if ((je32_to_cpu(ri->dsize) >= PAGE_SIZE) ||
-	    ( ((je32_to_cpu(ri->offset)&(PAGE_SIZE-1))==0) &&
-	      (je32_to_cpu(ri->dsize)+je32_to_cpu(ri->offset) ==  je32_to_cpu(ri->isize)))) {
+	if ((je32_to_cpu(c, ri->dsize) >= PAGE_SIZE) ||
+	    ( ((je32_to_cpu(c, ri->offset)&(PAGE_SIZE-1))==0) &&
+	      (je32_to_cpu(c, ri->dsize)+je32_to_cpu(c, ri->offset) ==  je32_to_cpu(c, ri->isize)))) {
 		flash_ofs |= REF_PRISTINE;
 	} else {
 		flash_ofs |= REF_NORMAL;
@@ -186,14 +186,14 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
 		jffs2_free_full_dnode(fn);
 		return ERR_CAST(hold_err);
 	}
-	fn->ofs = je32_to_cpu(ri->offset);
-	fn->size = je32_to_cpu(ri->dsize);
+	fn->ofs = je32_to_cpu(c, ri->offset);
+	fn->size = je32_to_cpu(c, ri->dsize);
 	fn->frags = 0;
 
 	jffs2_dbg(1, "jffs2_write_dnode wrote node at 0x%08x(%d) with dsize 0x%x, csize 0x%x, node_crc 0x%08x, data_crc 0x%08x, totlen 0x%08x\n",
-		  flash_ofs & ~3, flash_ofs & 3, je32_to_cpu(ri->dsize),
-		  je32_to_cpu(ri->csize), je32_to_cpu(ri->node_crc),
-		  je32_to_cpu(ri->data_crc), je32_to_cpu(ri->totlen));
+		  flash_ofs & ~3, flash_ofs & 3, je32_to_cpu(c, ri->dsize),
+		  je32_to_cpu(c, ri->csize), je32_to_cpu(c, ri->node_crc),
+		  je32_to_cpu(c, ri->data_crc), je32_to_cpu(c, ri->totlen));
 
 	if (retried) {
 		jffs2_dbg_acct_sanity_check(c,NULL);
@@ -215,10 +215,10 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
 
 	jffs2_dbg(1, "%s(ino #%u, name at *0x%p \"%s\"->ino #%u, name_crc 0x%08x)\n",
 		  __func__,
-		  je32_to_cpu(rd->pino), name, name, je32_to_cpu(rd->ino),
-		  je32_to_cpu(rd->name_crc));
+		  je32_to_cpu(c, rd->pino), name, name, je32_to_cpu(c, rd->ino),
+		  je32_to_cpu(c, rd->name_crc));
 
-	D1(if(je32_to_cpu(rd->hdr_crc) != crc32(0, rd, sizeof(struct jffs2_unknown_node)-4)) {
+	D1(if(je32_to_cpu(c, rd->hdr_crc) != crc32(0, rd, sizeof(struct jffs2_unknown_node)-4)) {
 		pr_crit("Eep. CRC not correct in jffs2_write_dirent()\n");
 		BUG();
 	   });
@@ -228,8 +228,8 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
 		   occasion: https://dev.laptop.org/ticket/4184 */
 		pr_crit("Error in jffs2_write_dirent() -- name contains zero bytes!\n");
 		pr_crit("Directory inode #%u, name at *0x%p \"%s\"->ino #%u, name_crc 0x%08x\n",
-			je32_to_cpu(rd->pino), name, name, je32_to_cpu(rd->ino),
-			je32_to_cpu(rd->name_crc));
+			je32_to_cpu(c, rd->pino), name, name, je32_to_cpu(c, rd->ino),
+			je32_to_cpu(c, rd->name_crc));
 		WARN_ON(1);
 		return ERR_PTR(-EIO);
 	}
@@ -243,8 +243,8 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
 	if (!fd)
 		return ERR_PTR(-ENOMEM);
 
-	fd->version = je32_to_cpu(rd->version);
-	fd->ino = je32_to_cpu(rd->ino);
+	fd->version = je32_to_cpu(c, rd->version);
+	fd->ino = je32_to_cpu(c, rd->ino);
 	fd->nhash = full_name_hash(NULL, name, namelen);
 	fd->type = rd->type;
 	memcpy(fd->name, name, namelen);
@@ -255,18 +255,18 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
 
 	jffs2_dbg_prewrite_paranoia_check(c, flash_ofs, vecs[0].iov_len + vecs[1].iov_len);
 
-	if ((alloc_mode!=ALLOC_GC) && (je32_to_cpu(rd->version) < f->highest_version)) {
+	if ((alloc_mode!=ALLOC_GC) && (je32_to_cpu(c, rd->version) < f->highest_version)) {
 		BUG_ON(!retried);
 		jffs2_dbg(1, "%s(): dirent_version %d, highest version %d -> updating dirent\n",
 			  __func__,
-			  je32_to_cpu(rd->version), f->highest_version);
-		rd->version = cpu_to_je32(++f->highest_version);
-		fd->version = je32_to_cpu(rd->version);
-		rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
+			  je32_to_cpu(c, rd->version), f->highest_version);
+		rd->version = cpu_to_je32(c, ++f->highest_version);
+		fd->version = je32_to_cpu(c, rd->version);
+		rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
 	}
 
 	ret = jffs2_flash_writev(c, vecs, 2, flash_ofs, &retlen,
-				 (alloc_mode==ALLOC_GC)?0:je32_to_cpu(rd->pino));
+				 (alloc_mode==ALLOC_GC)?0:je32_to_cpu(c, rd->pino));
 	if (ret || (retlen != sizeof(*rd) + namelen)) {
 		pr_notice("Write of %zd bytes at 0x%08x failed. returned %d, retlen %zd\n",
 			  sizeof(*rd) + namelen, flash_ofs, ret, retlen);
@@ -318,7 +318,7 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
 		return ERR_PTR(ret?ret:-EIO);
 	}
 	/* Mark the space used */
-	fd->raw = jffs2_add_physical_node_ref(c, flash_ofs | dirent_node_state(rd),
+	fd->raw = jffs2_add_physical_node_ref(c, flash_ofs | dirent_node_state(c, rd),
 					      PAD(sizeof(*rd)+namelen), f->inocache);
 	if (IS_ERR(fd->raw)) {
 		void *hold_err = fd->raw;
@@ -372,21 +372,21 @@ int jffs2_write_inode_range(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 
 		comprtype = jffs2_compress(c, f, buf, &comprbuf, &datalen, &cdatalen);
 
-		ri->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-		ri->nodetype = cpu_to_je16(JFFS2_NODETYPE_INODE);
-		ri->totlen = cpu_to_je32(sizeof(*ri) + cdatalen);
-		ri->hdr_crc = cpu_to_je32(crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
-
-		ri->ino = cpu_to_je32(f->inocache->ino);
-		ri->version = cpu_to_je32(++f->highest_version);
-		ri->isize = cpu_to_je32(max(je32_to_cpu(ri->isize), offset + datalen));
-		ri->offset = cpu_to_je32(offset);
-		ri->csize = cpu_to_je32(cdatalen);
-		ri->dsize = cpu_to_je32(datalen);
+		ri->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+		ri->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_INODE);
+		ri->totlen = cpu_to_je32(c, sizeof(*ri) + cdatalen);
+		ri->hdr_crc = cpu_to_je32(c, crc32(0, ri, sizeof(struct jffs2_unknown_node)-4));
+
+		ri->ino = cpu_to_je32(c, f->inocache->ino);
+		ri->version = cpu_to_je32(c, ++f->highest_version);
+		ri->isize = cpu_to_je32(c, max(je32_to_cpu(c, ri->isize), offset + datalen));
+		ri->offset = cpu_to_je32(c, offset);
+		ri->csize = cpu_to_je32(c, cdatalen);
+		ri->dsize = cpu_to_je32(c, datalen);
 		ri->compr = comprtype & 0xff;
 		ri->usercompr = (comprtype >> 8 ) & 0xff;
-		ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
-		ri->data_crc = cpu_to_je32(crc32(0, comprbuf, cdatalen));
+		ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
+		ri->data_crc = cpu_to_je32(c, crc32(0, comprbuf, cdatalen));
 
 		fn = jffs2_write_dnode(c, f, ri, comprbuf, cdatalen, ALLOC_NORETRY);
 
@@ -459,13 +459,13 @@ int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 
 	mutex_lock(&f->sem);
 
-	ri->data_crc = cpu_to_je32(0);
-	ri->node_crc = cpu_to_je32(crc32(0, ri, sizeof(*ri)-8));
+	ri->data_crc = cpu_to_je32(c, 0);
+	ri->node_crc = cpu_to_je32(c, crc32(0, ri, sizeof(*ri)-8));
 
 	fn = jffs2_write_dnode(c, f, ri, NULL, 0, ALLOC_NORMAL);
 
 	jffs2_dbg(1, "jffs2_do_create created file with mode 0x%x\n",
-		  jemode_to_cpu(ri->mode));
+		  jemode_to_cpu(c, ri->mode));
 
 	if (IS_ERR(fn)) {
 		jffs2_dbg(1, "jffs2_write_dnode() failed\n");
@@ -507,19 +507,19 @@ int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 
 	mutex_lock(&dir_f->sem);
 
-	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
-	rd->totlen = cpu_to_je32(sizeof(*rd) + qstr->len);
-	rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
+	rd->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rd->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
+	rd->totlen = cpu_to_je32(c, sizeof(*rd) + qstr->len);
+	rd->hdr_crc = cpu_to_je32(c, crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
 
-	rd->pino = cpu_to_je32(dir_f->inocache->ino);
-	rd->version = cpu_to_je32(++dir_f->highest_version);
+	rd->pino = cpu_to_je32(c, dir_f->inocache->ino);
+	rd->version = cpu_to_je32(c, ++dir_f->highest_version);
 	rd->ino = ri->ino;
 	rd->mctime = ri->ctime;
 	rd->nsize = qstr->len;
 	rd->type = DT_REG;
-	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
-	rd->name_crc = cpu_to_je32(crc32(0, qstr->name, qstr->len));
+	rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
+	rd->name_crc = cpu_to_je32(c, crc32(0, qstr->name, qstr->len));
 
 	fd = jffs2_write_dirent(c, dir_f, rd, qstr->name, qstr->len, ALLOC_NORMAL);
 
@@ -570,19 +570,19 @@ int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 		mutex_lock(&dir_f->sem);
 
 		/* Build a deletion node */
-		rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-		rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
-		rd->totlen = cpu_to_je32(sizeof(*rd) + namelen);
-		rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
-
-		rd->pino = cpu_to_je32(dir_f->inocache->ino);
-		rd->version = cpu_to_je32(++dir_f->highest_version);
-		rd->ino = cpu_to_je32(0);
-		rd->mctime = cpu_to_je32(time);
+		rd->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+		rd->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
+		rd->totlen = cpu_to_je32(c, sizeof(*rd) + namelen);
+		rd->hdr_crc = cpu_to_je32(c, crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
+
+		rd->pino = cpu_to_je32(c, dir_f->inocache->ino);
+		rd->version = cpu_to_je32(c, ++dir_f->highest_version);
+		rd->ino = cpu_to_je32(c, 0);
+		rd->mctime = cpu_to_je32(c, time);
 		rd->nsize = namelen;
 		rd->type = DT_UNKNOWN;
-		rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
-		rd->name_crc = cpu_to_je32(crc32(0, name, namelen));
+		rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
+		rd->name_crc = cpu_to_je32(c, crc32(0, name, namelen));
 
 		fd = jffs2_write_dirent(c, dir_f, rd, name, namelen, ALLOC_DELETION);
 
@@ -687,21 +687,21 @@ int jffs2_do_link (struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, uint
 	mutex_lock(&dir_f->sem);
 
 	/* Build a deletion node */
-	rd->magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rd->nodetype = cpu_to_je16(JFFS2_NODETYPE_DIRENT);
-	rd->totlen = cpu_to_je32(sizeof(*rd) + namelen);
-	rd->hdr_crc = cpu_to_je32(crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
-
-	rd->pino = cpu_to_je32(dir_f->inocache->ino);
-	rd->version = cpu_to_je32(++dir_f->highest_version);
-	rd->ino = cpu_to_je32(ino);
-	rd->mctime = cpu_to_je32(time);
+	rd->magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rd->nodetype = cpu_to_je16(c, JFFS2_NODETYPE_DIRENT);
+	rd->totlen = cpu_to_je32(c, sizeof(*rd) + namelen);
+	rd->hdr_crc = cpu_to_je32(c, crc32(0, rd, sizeof(struct jffs2_unknown_node)-4));
+
+	rd->pino = cpu_to_je32(c, dir_f->inocache->ino);
+	rd->version = cpu_to_je32(c, ++dir_f->highest_version);
+	rd->ino = cpu_to_je32(c, ino);
+	rd->mctime = cpu_to_je32(c, time);
 	rd->nsize = namelen;
 
 	rd->type = type;
 
-	rd->node_crc = cpu_to_je32(crc32(0, rd, sizeof(*rd)-8));
-	rd->name_crc = cpu_to_je32(crc32(0, name, namelen));
+	rd->node_crc = cpu_to_je32(c, crc32(0, rd, sizeof(*rd)-8));
+	rd->name_crc = cpu_to_je32(c, crc32(0, name, namelen));
 
 	fd = jffs2_write_dirent(c, dir_f, rd, name, namelen, ALLOC_NORMAL);
 
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..98ea8f87df9d 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -152,32 +152,32 @@ static int do_verify_xattr_datum(struct jffs2_sb_info *c, struct jffs2_xattr_dat
 		return rc ? rc : -EIO;
 	}
 	crc = crc32(0, &rx, sizeof(rx) - 4);
-	if (crc != je32_to_cpu(rx.node_crc)) {
+	if (crc != je32_to_cpu(c, rx.node_crc)) {
 		JFFS2_ERROR("node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
-			    offset, je32_to_cpu(rx.hdr_crc), crc);
+			    offset, je32_to_cpu(c, rx.hdr_crc), crc);
 		xd->flags |= JFFS2_XFLAGS_INVALID;
 		return JFFS2_XATTR_IS_CORRUPTED;
 	}
-	totlen = PAD(sizeof(rx) + rx.name_len + 1 + je16_to_cpu(rx.value_len));
-	if (je16_to_cpu(rx.magic) != JFFS2_MAGIC_BITMASK
-	    || je16_to_cpu(rx.nodetype) != JFFS2_NODETYPE_XATTR
-	    || je32_to_cpu(rx.totlen) != totlen
-	    || je32_to_cpu(rx.xid) != xd->xid
-	    || je32_to_cpu(rx.version) != xd->version) {
+	totlen = PAD(sizeof(rx) + rx.name_len + 1 + je16_to_cpu(c, rx.value_len));
+	if (je16_to_cpu(c, rx.magic) != JFFS2_MAGIC_BITMASK
+	    || je16_to_cpu(c, rx.nodetype) != JFFS2_NODETYPE_XATTR
+	    || je32_to_cpu(c, rx.totlen) != totlen
+	    || je32_to_cpu(c, rx.xid) != xd->xid
+	    || je32_to_cpu(c, rx.version) != xd->version) {
 		JFFS2_ERROR("inconsistent xdatum at %#08x, magic=%#04x/%#04x, "
 			    "nodetype=%#04x/%#04x, totlen=%u/%u, xid=%u/%u, version=%u/%u\n",
-			    offset, je16_to_cpu(rx.magic), JFFS2_MAGIC_BITMASK,
-			    je16_to_cpu(rx.nodetype), JFFS2_NODETYPE_XATTR,
-			    je32_to_cpu(rx.totlen), totlen,
-			    je32_to_cpu(rx.xid), xd->xid,
-			    je32_to_cpu(rx.version), xd->version);
+			    offset, je16_to_cpu(c, rx.magic), JFFS2_MAGIC_BITMASK,
+			    je16_to_cpu(c, rx.nodetype), JFFS2_NODETYPE_XATTR,
+			    je32_to_cpu(c, rx.totlen), totlen,
+			    je32_to_cpu(c, rx.xid), xd->xid,
+			    je32_to_cpu(c, rx.version), xd->version);
 		xd->flags |= JFFS2_XFLAGS_INVALID;
 		return JFFS2_XATTR_IS_CORRUPTED;
 	}
 	xd->xprefix = rx.xprefix;
 	xd->name_len = rx.name_len;
-	xd->value_len = je16_to_cpu(rx.value_len);
-	xd->data_crc = je32_to_cpu(rx.data_crc);
+	xd->value_len = je16_to_cpu(c, rx.value_len);
+	xd->data_crc = je32_to_cpu(c, rx.data_crc);
 
 	spin_lock(&c->erase_completion_lock);
  complete:
@@ -301,18 +301,18 @@ static int save_xattr_datum(struct jffs2_sb_info *c, struct jffs2_xattr_datum *x
 
 	/* Setup raw-xattr */
 	memset(&rx, 0, sizeof(rx));
-	rx.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rx.nodetype = cpu_to_je16(JFFS2_NODETYPE_XATTR);
-	rx.totlen = cpu_to_je32(PAD(totlen));
-	rx.hdr_crc = cpu_to_je32(crc32(0, &rx, sizeof(struct jffs2_unknown_node) - 4));
+	rx.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rx.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_XATTR);
+	rx.totlen = cpu_to_je32(c, PAD(totlen));
+	rx.hdr_crc = cpu_to_je32(c, crc32(0, &rx, sizeof(struct jffs2_unknown_node) - 4));
 
-	rx.xid = cpu_to_je32(xd->xid);
-	rx.version = cpu_to_je32(++xd->version);
+	rx.xid = cpu_to_je32(c, xd->xid);
+	rx.version = cpu_to_je32(c, ++xd->version);
 	rx.xprefix = xd->xprefix;
 	rx.name_len = xd->name_len;
-	rx.value_len = cpu_to_je16(xd->value_len);
-	rx.data_crc = cpu_to_je32(crc32(0, vecs[1].iov_base, vecs[1].iov_len));
-	rx.node_crc = cpu_to_je32(crc32(0, &rx, sizeof(struct jffs2_raw_xattr) - 4));
+	rx.value_len = cpu_to_je16(c, xd->value_len);
+	rx.data_crc = cpu_to_je32(c, crc32(0, vecs[1].iov_base, vecs[1].iov_len));
+	rx.node_crc = cpu_to_je32(c, crc32(0, &rx, sizeof(struct jffs2_raw_xattr) - 4));
 
 	rc = jffs2_flash_writev(c, vecs, 2, phys_ofs, &length, 0);
 	if (rc || totlen != length) {
@@ -464,24 +464,24 @@ static int verify_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref
 	}
 	/* obsolete node */
 	crc = crc32(0, &rr, sizeof(rr) - 4);
-	if (crc != je32_to_cpu(rr.node_crc)) {
+	if (crc != je32_to_cpu(c, rr.node_crc)) {
 		JFFS2_ERROR("node CRC failed at %#08x, read=%#08x, calc=%#08x\n",
-			    offset, je32_to_cpu(rr.node_crc), crc);
+			    offset, je32_to_cpu(c, rr.node_crc), crc);
 		return JFFS2_XATTR_IS_CORRUPTED;
 	}
-	if (je16_to_cpu(rr.magic) != JFFS2_MAGIC_BITMASK
-	    || je16_to_cpu(rr.nodetype) != JFFS2_NODETYPE_XREF
-	    || je32_to_cpu(rr.totlen) != PAD(sizeof(rr))) {
+	if (je16_to_cpu(c, rr.magic) != JFFS2_MAGIC_BITMASK
+	    || je16_to_cpu(c, rr.nodetype) != JFFS2_NODETYPE_XREF
+	    || je32_to_cpu(c, rr.totlen) != PAD(sizeof(rr))) {
 		JFFS2_ERROR("inconsistent xref at %#08x, magic=%#04x/%#04x, "
 			    "nodetype=%#04x/%#04x, totlen=%u/%zu\n",
-			    offset, je16_to_cpu(rr.magic), JFFS2_MAGIC_BITMASK,
-			    je16_to_cpu(rr.nodetype), JFFS2_NODETYPE_XREF,
-			    je32_to_cpu(rr.totlen), PAD(sizeof(rr)));
+			    offset, je16_to_cpu(c, rr.magic), JFFS2_MAGIC_BITMASK,
+			    je16_to_cpu(c, rr.nodetype), JFFS2_NODETYPE_XREF,
+			    je32_to_cpu(c, rr.totlen), PAD(sizeof(rr)));
 		return JFFS2_XATTR_IS_CORRUPTED;
 	}
-	ref->ino = je32_to_cpu(rr.ino);
-	ref->xid = je32_to_cpu(rr.xid);
-	ref->xseqno = je32_to_cpu(rr.xseqno);
+	ref->ino = je32_to_cpu(c, rr.ino);
+	ref->xid = je32_to_cpu(c, rr.xid);
+	ref->xseqno = je32_to_cpu(c, rr.xseqno);
 	if (ref->xseqno > c->highest_xseqno)
 		c->highest_xseqno = (ref->xseqno & ~XREF_DELETE_MARKER);
 
@@ -511,22 +511,22 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
 	uint32_t xseqno, phys_ofs = write_ofs(c);
 	int ret;
 
-	rr.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	rr.nodetype = cpu_to_je16(JFFS2_NODETYPE_XREF);
-	rr.totlen = cpu_to_je32(PAD(sizeof(rr)));
-	rr.hdr_crc = cpu_to_je32(crc32(0, &rr, sizeof(struct jffs2_unknown_node) - 4));
+	rr.magic = cpu_to_je16(c, JFFS2_MAGIC_BITMASK);
+	rr.nodetype = cpu_to_je16(c, JFFS2_NODETYPE_XREF);
+	rr.totlen = cpu_to_je32(c, PAD(sizeof(rr)));
+	rr.hdr_crc = cpu_to_je32(c, crc32(0, &rr, sizeof(struct jffs2_unknown_node) - 4));
 
 	xseqno = (c->highest_xseqno += 2);
 	if (is_xattr_ref_dead(ref)) {
 		xseqno |= XREF_DELETE_MARKER;
-		rr.ino = cpu_to_je32(ref->ino);
-		rr.xid = cpu_to_je32(ref->xid);
+		rr.ino = cpu_to_je32(c, ref->ino);
+		rr.xid = cpu_to_je32(c, ref->xid);
 	} else {
-		rr.ino = cpu_to_je32(ref->ic->ino);
-		rr.xid = cpu_to_je32(ref->xd->xid);
+		rr.ino = cpu_to_je32(c, ref->ic->ino);
+		rr.xid = cpu_to_je32(c, ref->xd->xid);
 	}
-	rr.xseqno = cpu_to_je32(xseqno);
-	rr.node_crc = cpu_to_je32(crc32(0, &rr, sizeof(rr) - 4));
+	rr.xseqno = cpu_to_je32(c, xseqno);
+	rr.node_crc = cpu_to_je32(c, crc32(0, &rr, sizeof(rr) - 4));
 
 	ret = jffs2_flash_write(c, phys_ofs, sizeof(rr), &length, (char *)&rr);
 	if (ret || sizeof(rr) != length) {
-- 
2.19.1

