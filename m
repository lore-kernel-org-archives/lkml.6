Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeCPK4a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:56:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37119 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753040AbeCPK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:56:29 -0400
From: Yufen Yu <yuyufen@huawei.com>
To: <dwmw2@infradead.org>
CC: <viro@zeniv.linux.org.uk>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] jffs2: remove fd from the f->dents list immediately.
Date: Fri, 16 Mar 2018 19:05:22 +0800
Message-ID: <20180316110522.1120-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 15953580e79b ("[JFFS2] Improve getdents vs. f_pos handling on NOR flash.")
is introduced to resolve 'rm -r', which cannot remove all files:
    http://lists.infradead.org/pipermail/linux-mtd/2007-October/019658.html

However, it can cause the following issues:

1. 'deletion' dirents is alway in the f->dents list, wasting memory
    resource. For example:
        There is a file named 'file1'. Then we rename it:
        mv file1 file2;
        mv file2 file3;
        ...
        mv file99999 file1000000

        When CONFIG_JFFS2_SUMMARY is not set, file1~file1000000
        always in the f->dents list.

2. Since the list become longer and longer, more CPU time is used
    to traverse it.

After reverting the commit, we test 'rm -r', which can remove all
files, and all seems OK!

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/jffs2/write.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
index cda9a361368e..1deed35beb50 100644
--- a/fs/jffs2/write.c
+++ b/fs/jffs2/write.c
@@ -598,31 +598,32 @@ int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 		jffs2_add_fd_to_list(c, fd, &dir_f->dents);
 		mutex_unlock(&dir_f->sem);
 	} else {
+		struct jffs2_full_dirent **prev = &dir_f->dents;
 		uint32_t nhash = full_name_hash(NULL, name, namelen);
 
-		fd = dir_f->dents;
 		/* We don't actually want to reserve any space, but we do
 		   want to be holding the alloc_sem when we write to flash */
 		mutex_lock(&c->alloc_sem);
 		mutex_lock(&dir_f->sem);
 
-		for (fd = dir_f->dents; fd; fd = fd->next) {
-			if (fd->nhash == nhash &&
-			    !memcmp(fd->name, name, namelen) &&
-			    !fd->name[namelen]) {
-
-				jffs2_dbg(1, "Marking old dirent node (ino #%u) @%08x obsolete\n",
-					  fd->ino, ref_offset(fd->raw));
-				jffs2_mark_node_obsolete(c, fd->raw);
-				/* We don't want to remove it from the list immediately,
-				   because that screws up getdents()/seek() semantics even
-				   more than they're screwed already. Turn it into a
-				   node-less deletion dirent instead -- a placeholder */
-				fd->raw = NULL;
-				fd->ino = 0;
-				break;
+		while ((*prev) && (*prev)->nhash <= nhash) {
+			if ((*prev)->nhash == nhash &&
+				!memcmp((*prev)->name, name, namelen) &&
+				!(*prev)->name[namelen]) {
+
+					struct jffs2_full_dirent *this = *prev;
+
+					jffs2_dbg(1, "Marking old dirent node (ino #%u) @%08x obsolete\n",
+							this->ino, ref_offset(this->raw));
+					*prev = this->next;
+					jffs2_mark_node_obsolete(c, this->raw);
+					jffs2_free_full_dirent(this);
+
+					break;
 			}
+			prev = &((*prev)->next);
 		}
+
 		mutex_unlock(&dir_f->sem);
 	}
 
-- 
2.13.6
