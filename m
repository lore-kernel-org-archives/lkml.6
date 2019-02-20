Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDCB2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfBTKRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:17:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbfBTKRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:17:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2131363613876F9CEA08;
        Wed, 20 Feb 2019 18:17:44 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 18:17:36 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH] jffs2: protect no-raw-node-ref check of inocache by erase_completion_lock
Date:   Wed, 20 Feb 2019 18:21:54 +0800
Message-ID: <20190220102154.8031-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In jffs2_do_clear_inode(), we will check whether or not there is any
jffs2_raw_node_ref associated with the current inocache. If there
is no raw-node-ref, the inocache could be freed. And if there are
still some jffs2_raw_node_ref linked in inocache->nodes, the inocache
could not be freed and its free will be decided by
jffs2_remove_node_refs_from_ino_list().

However there is a race between jffs2_do_clear_inode() and
jffs2_remove_node_refs_from_ino_list() as shown in the following
scenario:

CPU 0                   CPU 1
in sys_unlink()         in jffs2_garbage_collect_pass()

jffs2_do_unlink
  f->inocache->pino_nlink = 0
  set_nlink(inode, 0)

                        // contains all raw-node-refs of the unlinked inode
                        start GC a jeb

iput_final
jffs2_evict_inode
jffs2_do_clear_inode
  acquire f->sem
    mark all refs as obsolete

                        GC complete
                        jeb is moved to erase_pending_list
                        jffs2_erase_pending_blocks
                          jffs2_free_jeb_node_refs
                            jffs2_remove_node_refs_from_ino_list

    f->inocache = INO_STATE_CHECKEDABSENT

                              // no raw-node-ref is associated with the
                              // inocache of the unlinked inode
                              ic->nodes == (void *)ic && ic->pino_nlink == 0
                                jffs2_del_ino_cache

    f->inodecache->nodes == f->nodes
      // double-free occurs
      jffs2_del_ino_cache

Double-free of inocache will lead to all kinds of weired behaviours. The
following BUG_ON is one case in which two active inodes are used the same
inocache (the freed inocache is reused by a new inode, then the inocache
is double-freed and reused by another new inode):

  jffs2: Raw node at 0x006c6000 wasn't in node lists for ino #662249
  ------------[ cut here ]------------
  kernel BUG at fs/jffs2/gc.c:645!
  invalid opcode: 0000 [#1] PREEMPT SMP
  Modules linked in: nandsim
  CPU: 0 PID: 15837 Comm: cp Not tainted 4.4.172 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  RIP: [<ffffffff816f1256>] jffs2_garbage_collect_live+0x1578/0x1593
  Call Trace:
   [<ffffffff8154b8aa>] jffs2_garbage_collect_pass+0xf6a/0x15d0
   [<ffffffff81541bbd>] jffs2_reserve_space+0x2bd/0x8a0
   [<ffffffff81546a62>] jffs2_do_create+0x52/0x480
   [<ffffffff8153c9f2>] jffs2_create+0xe2/0x2a0
   [<ffffffff8133bed7>] vfs_create+0xe7/0x220
   [<ffffffff81340ab4>] path_openat+0x11f4/0x1c00
   [<ffffffff81343635>] do_filp_open+0xa5/0x140
   [<ffffffff813288ed>] do_sys_open+0x19d/0x320
   [<ffffffff81328a96>] SyS_open+0x26/0x30
   [<ffffffff81c3f8f8>] entry_SYSCALL_64_fastpath+0x18/0x73
  ---[ end trace dd5c02f1653e8cac ]---

Fix it by protecting no-raw-node-ref check by erase_completion_lock.
And also need to move the call of jffs2_set_inocache_state() under
erase_completion_lock, else the inocache may be leaked because
jffs2_del_ino_cache() invoked by jffs2_remove_node_refs_from_ino_list()
may find the state of inocache is still INO_STATE_CHECKING and will
not free the inocache.

Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/jffs2/nodelist.c  |  7 +++++++
 fs/jffs2/readinode.c | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
index b86c78d178c6..c3b0d56e7007 100644
--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -469,6 +469,13 @@ void jffs2_del_ino_cache(struct jffs2_sb_info *c, struct jffs2_inode_cache *old)
 	while ((*prev) && (*prev)->ino < old->ino) {
 		prev = &(*prev)->next;
 	}
+
+	/*
+	 * It's possible that we can not find the inocache in
+	 * hash table because it had been removed by
+	 * jffs2_remove_node_refs_from_ino_list(), but it's still not freed,
+	 * so we need go forward and free it.
+	 */
 	if ((*prev) == old) {
 		*prev = old->next;
 	}
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 0bae0583106e..64613207d3fe 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -1428,8 +1428,16 @@ void jffs2_do_clear_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f)
 	}
 
 	if (f->inocache && f->inocache->state != INO_STATE_CHECKING) {
-		jffs2_set_inocache_state(c, f->inocache, INO_STATE_CHECKEDABSENT);
+		bool need_del = false;
+
+		spin_lock(&c->erase_completion_lock);
 		if (f->inocache->nodes == (void *)f->inocache)
+			need_del = true;
+		jffs2_set_inocache_state(c, f->inocache,
+					 INO_STATE_CHECKEDABSENT);
+		spin_unlock(&c->erase_completion_lock);
+
+		if (need_del)
 			jffs2_del_ino_cache(c, f->inocache);
 	}
 
-- 
2.16.2.dirty

