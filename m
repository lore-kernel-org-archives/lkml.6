Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A48FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CBA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBTKRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:17:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBTKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:17:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 448AA253C4D8CD2A68AA;
        Wed, 20 Feb 2019 18:17:25 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 18:17:16 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH 2/2] jffs2: handle INO_STATE_CLEARING in jffs2_do_read_inode()
Date:   Wed, 20 Feb 2019 18:21:33 +0800
Message-ID: <20190220102133.7878-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190220102133.7878-1-houtao1@huawei.com>
References: <20190220102133.7878-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For inode that fails to be created midway, GC procedure may
try to GC its dnode, and in the following case BUG() will be
triggered:

CPU 0                       CPU 1
in jffs2_do_create()        in jffs2_garbage_collect_pass()

jffs2_write_dnode succeed
// for dirent
jffs2_reserve_space fail

			    inum = ic->ino
			    nlink = ic->pino_nlink (> 0)

iget_failed
  make_bad_inode
    remove_inode_hash
  iput
    jffs2_evict_inode
      jffs2_do_clear_inode
        jffs2_set_inocache_state(INO_STATE_CLEARING)

			    jffs2_gc_fetch_inode
			      jffs2_iget
			        // a new inode is created because
			        // the old inode had been unhashed
			        iget_locked
			      jffs2_do_read_inode
			        jffs2_get_ino_cache
				// assert BUG()
				f->inocache->state = INO_STATE_CLEARING

Fix it by waiting for its state changes to INO_STATE_CHECKEDABSENT.

Fixes: 67e345d17ff8 ("[JFFS2] Prevent ino cache removal for inodes in use")
Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/readinode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 389ea53ea487..0bae0583106e 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -1328,6 +1328,7 @@ int jffs2_do_read_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 
 		case INO_STATE_CHECKING:
 		case INO_STATE_GC:
+		case INO_STATE_CLEARING:
 			/* If it's in either of these states, we need
 			   to wait for whoever's got it to finish and
 			   put it back. */
-- 
2.16.2.dirty

