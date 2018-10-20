Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E6C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB352150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB352150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJTTPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:15:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727292AbeJTTPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:15:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 313ECAB4DE87E;
        Sat, 20 Oct 2018 19:05:08 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Sat, 20 Oct 2018
 19:05:06 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <dwmw2@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <richard.weinberger@gmail.com>,
        <boris.brezillon@bootlin.com>
Subject: [RFC PATCH] jffs2: make the overwritten xattr invisible after remount
Date:   Sat, 20 Oct 2018 19:07:41 +0800
Message-ID: <20181020110741.98202-1-houtao1@huawei.com>
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

Fix it by keeping dead xrefs and linking them to the corresponding
xdatum & inode in jffs2_build_xattr_subsystem(), and using them to
check and remove the xrefs with a lower xseqno in check_xattr_ref_inode(),
and removing these dead xrefs once the check is done.

The fix will cause performance degradation in check_xattr_ref_inode(),
when xattrs are updated through deletion & addition, because there will
be many dead xrefs in the inode xref list. Luckily SELinux and ACL always
update xattr through overwrite, so the degradation may be acceptable.

The problem can also be fixed by writing the delete marker for xattr
ovewrite, but that will incur an extra flash write for each update
which is more expensive than just checking the lower xseqno once.

Fixes: 8a13695cbe4e ("[JFFS2][XATTR] rid unnecessary writing of delete marker.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/xattr.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/jffs2/xattr.h |  8 +++++++-
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..3d40fe02b003 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -522,6 +522,12 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
 		rr.ino = cpu_to_je32(ref->ino);
 		rr.xid = cpu_to_je32(ref->xid);
 	} else {
+		/*
+		 * For dead xref which has not been moved to xref_dead_list yet
+		 * (refer to jffs2_build_xattr_subsystem())
+		 */
+		if (ref->flags & JFFS2_XREF_FLAGS_DEAD)
+			xseqno |= XREF_DELETE_MARKER;
 		rr.ino = cpu_to_je32(ref->ic->ino);
 		rr.xid = cpu_to_je32(ref->xd->xid);
 	}
@@ -539,6 +545,8 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
 		return ret;
 	}
 	/* success */
+	if (ref->flags & JFFS2_XREF_FLAGS_DEAD)
+		xseqno &= ~XREF_DELETE_MARKER;
 	ref->xseqno = xseqno;
 	jffs2_add_physical_node_ref(c, phys_ofs | REF_PRISTINE, PAD(sizeof(rr)), (void *)ref);
 
@@ -680,6 +688,22 @@ static int check_xattr_ref_inode(struct jffs2_sb_info *c, struct jffs2_inode_cac
 			}
 		}
 	}
+
+	/* Remove dead xrefs moved in by jffs2_build_xattr_subsystem() */
+	for (ref=ic->xref, pref=&ic->xref; ref; ref=*pref) {
+		if (ref->flags & JFFS2_XREF_FLAGS_DEAD) {
+			ref->flags &= ~JFFS2_XREF_FLAGS_DEAD;
+
+			*pref = ref->next;
+			dbg_xattr("remove dead xref (ino=%u, xid=%u)\n",
+					ref->ic->ino, ref->xd->xid);
+			delete_xattr_ref(c, ref);
+			continue;
+		}
+
+		pref = &ref->next;
+	}
+
 	ic->flags |= INO_FLAGS_XATTR_CHECKED;
  out:
 	up_write(&c->xattr_sem);
@@ -830,12 +854,27 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 		for (ref=xref_tmphash[i]; ref; ref=_ref) {
 			xref_count++;
 			_ref = ref->next;
-			if (is_xattr_ref_dead(ref)) {
-				ref->next = c->xref_dead_list;
-				c->xref_dead_list = ref;
+			/*
+			 * Now the dead xref can not been moved into
+			 * xref_dead_list, it will be used in
+			 * check_xattr_ref_inode() to check whether or not
+			 * a xref with a lower xseqno (without delete marker)
+			 * also needs to be marked as dead. After that, the
+			 * dead xref will be moved into xref_dead_list.
+			 *
+			 * The reason for a xref with lower xseqno may be dead
+			 * is that for xattr modification we do not write a new
+			 * jffs2_raw_xref with delete mark into flash as we do
+			 * for xattr removal. So if a xattr is modified then
+			 * removed and the old xref & xdatum are not GC-ed,
+			 * after reboot or remount, the new xattr xref will be
+			 * dead but the old xattr xref will be alive, and we
+			 * will get a older xattr value instead of non-existent
+			 * error when reading the removed xattr.
+			 */
+			if (is_xattr_ref_dead(ref))
 				xref_dead_count++;
-				continue;
-			}
+
 			/* At this point, ref->xid and ref->ino contain XID and inode number.
 			   ref->xd and ref->ic are not valid yet. */
 			xd = jffs2_find_xattr_datum(c, ref->xid);
@@ -849,6 +888,18 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 				xref_orphan_count++;
 				continue;
 			}
+
+			/*
+			 * Use JFFS2_XREF_FLAGS_DEAD instead of
+			 * XREF_DELETE_MARKER to prevent xref from being
+			 * skipped by jffs2_garbage_collect_xattr_ref()
+			 * during GC.
+			 */
+			if (is_xattr_ref_dead(ref)) {
+				ref->xseqno &= ~XREF_DELETE_MARKER;
+				ref->flags |= JFFS2_XREF_FLAGS_DEAD;
+			}
+
 			ref->xd = xd;
 			ref->ic = ic;
 			atomic_inc(&xd->refcnt);
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 720007b2fd65..f18f968bd901 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -41,13 +41,19 @@ struct jffs2_xattr_datum
 	uint32_t value_len;	/* length of xvalue */
 };
 
+/*
+ * xref is dead, but has not been moved to xref_dead_list yet
+ * and needs save during GC.
+ */
+#define JFFS2_XREF_FLAGS_DEAD (0x01)
+
 struct jffs2_inode_cache;
 struct jffs2_xattr_ref
 {
 	void *always_null;
 	struct jffs2_raw_node_ref *node;
 	uint8_t class;
-	uint8_t flags;		/* Currently unused */
+	uint8_t flags;
 	u16 unused;
 
 	uint32_t xseqno;
-- 
2.16.2.dirty

