Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74607ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927D21528
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927D21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJTTP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:15:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727292AbeJTTP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:15:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89EC79E2AFA09;
        Sat, 20 Oct 2018 19:05:22 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Sat, 20 Oct 2018
 19:05:18 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <dwmw2@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <richard.weinberger@gmail.com>,
        <boris.brezillon@bootlin.com>
Subject: [PATCH] jffs2: fix invocations of dbg_xattr() for dead jffs2_xattr_ref
Date:   Sat, 20 Oct 2018 19:07:53 +0800
Message-ID: <20181020110753.98407-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When jffs2_xattr_ref is dead, xref->ic or xref->xd will be invalid
because these fields will be reused as xref->ino or xref->xid,
so access xref->ic->ino or xref->xd->xid will lead to Oops.

Fix the problem by checking whether or not it is a dead xref.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/xattr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 3d40fe02b003..0c4c7891556d 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -550,7 +550,8 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
 	ref->xseqno = xseqno;
 	jffs2_add_physical_node_ref(c, phys_ofs | REF_PRISTINE, PAD(sizeof(rr)), (void *)ref);
 
-	dbg_xattr("success on saving xref (ino=%u, xid=%u)\n", ref->ic->ino, ref->xd->xid);
+	dbg_xattr("success on saving xref (ino=%u, xid=%u)\n",
+			je32_to_cpu(rr.ino), je32_to_cpu(rr.xid));
 
 	return 0;
 }
@@ -1329,7 +1330,11 @@ int jffs2_garbage_collect_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_
 	rc = save_xattr_ref(c, ref);
 	if (!rc)
 		dbg_xattr("xref (ino=%u, xid=%u) GC'ed from %#08x to %08x\n",
-			  ref->ic->ino, ref->xd->xid, old_ofs, ref_offset(ref->node));
+				is_xattr_ref_dead(ref) ?
+					ref->ino : ref->ic->ino,
+				is_xattr_ref_dead(ref) ?
+					ref->xid : ref->xd->xid,
+				old_ofs, ref_offset(ref->node));
  out:
 	if (!rc)
 		jffs2_mark_node_obsolete(c, raw);
-- 
2.16.2.dirty

