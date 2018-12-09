Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF65C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CBE20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CBE20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLIGS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:18:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeLIGS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:18:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 55313EA0C9F0B;
        Sun,  9 Dec 2018 14:18:25 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 14:18:24 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <dwmw2@infradead.org>, <linux-mtd@lists.infradead.org>
CC:     <richard.weinberger@gmail.com>, <boris.brezillon@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] jffs2: make the overwritten xattr invisible after remount
Date:   Sun, 9 Dec 2018 14:21:33 +0800
Message-ID: <20181209062133.106781-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For xattr modification, we do not write a new jffs2_raw_xref with
delete marker into flash, so if a xattr is modified then removed,
and the old xref & xdatum are not erased by GC, after reboot or
remount, the new xattr xref will be dead but the old xattr xref
will be alive, and we will get the overwritten xattr instead of
non-existent error when reading the removed xattr.

Fix it by writing the deletion mark for xattr overwrite.

Fixes: 8a13695cbe4e ("[JFFS2][XATTR] rid unnecessary writing of delete marker.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/xattr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..b2d6072f34af 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -573,6 +573,15 @@ static struct jffs2_xattr_ref *create_xattr_ref(struct jffs2_sb_info *c, struct
 	return ref; /* success */
 }
 
+static void move_xattr_ref_to_dead_list(struct jffs2_sb_info *c,
+		struct jffs2_xattr_ref *ref)
+{
+	spin_lock(&c->erase_completion_lock);
+	ref->next = c->xref_dead_list;
+	c->xref_dead_list = ref;
+	spin_unlock(&c->erase_completion_lock);
+}
+
 static void delete_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
 {
 	/* must be called under down_write(xattr_sem) */
@@ -582,10 +591,7 @@ static void delete_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *re
 	ref->xseqno |= XREF_DELETE_MARKER;
 	ref->ino = ref->ic->ino;
 	ref->xid = ref->xd->xid;
-	spin_lock(&c->erase_completion_lock);
-	ref->next = c->xref_dead_list;
-	c->xref_dead_list = ref;
-	spin_unlock(&c->erase_completion_lock);
+	move_xattr_ref_to_dead_list(c, ref);
 
 	dbg_xattr("xref(ino=%u, xid=%u, xseqno=%u) was removed.\n",
 		  ref->ino, ref->xid, ref->xseqno);
@@ -1090,6 +1096,40 @@ int do_jffs2_getxattr(struct inode *inode, int xprefix, const char *xname,
 	return rc;
 }
 
+static void do_jffs2_delete_xattr_ref(struct jffs2_sb_info *c,
+		struct jffs2_xattr_ref *ref)
+{
+	uint32_t request, length;
+	int err;
+	struct jffs2_xattr_datum *xd;
+
+	request = PAD(sizeof(struct jffs2_raw_xref));
+	err = jffs2_reserve_space(c, request, &length,
+			ALLOC_NORMAL, JFFS2_SUMMARY_XREF_SIZE);
+	down_write(&c->xattr_sem);
+	if (err) {
+		JFFS2_WARNING("jffs2_reserve_space()=%d, request=%u\n",
+				err, request);
+		delete_xattr_ref(c, ref);
+		up_write(&c->xattr_sem);
+		return;
+	}
+
+	xd = ref->xd;
+	ref->ino = ref->ic->ino;
+	ref->xid = xd->xid;
+	ref->xseqno |= XREF_DELETE_MARKER;
+	save_xattr_ref(c, ref);
+
+	move_xattr_ref_to_dead_list(c, ref);
+	dbg_xattr("xref(ino=%u, xid=%u, xseqno=%u) was removed.\n",
+		  ref->ino, ref->xid, ref->xseqno);
+	unrefer_xattr_datum(c, xd);
+
+	up_write(&c->xattr_sem);
+	jffs2_complete_reservation(c);
+}
+
 int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		      const char *buffer, size_t size, int flags)
 {
@@ -1097,7 +1137,7 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	struct jffs2_inode_cache *ic = f->inocache;
 	struct jffs2_xattr_datum *xd;
-	struct jffs2_xattr_ref *ref, *newref, **pref;
+	struct jffs2_xattr_ref *ref, *newref, *oldref, **pref;
 	uint32_t length, request;
 	int rc;
 
@@ -1113,6 +1153,7 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		return rc;
 	}
 
+	oldref = NULL;
 	/* Find existing xattr */
 	down_write(&c->xattr_sem);
  retry:
@@ -1196,11 +1237,13 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		rc = PTR_ERR(newref);
 		unrefer_xattr_datum(c, xd);
 	} else if (ref) {
-		delete_xattr_ref(c, ref);
+		oldref = ref;
 	}
  out:
 	up_write(&c->xattr_sem);
 	jffs2_complete_reservation(c);
+	if (oldref)
+		do_jffs2_delete_xattr_ref(c, oldref);
 	return rc;
 }
 
-- 
2.16.2.dirty

