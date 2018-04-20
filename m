Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbeDTSI6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:08:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753576AbeDTSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:08:56 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Date: Fri, 20 Apr 2018 11:08:47 -0700
Message-ID: <20180420180847.418760-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caller of uprobe_register is required to keep the inode and containing
mount point referenced.

There was misuse of igrab() in uprobes.c and trace_uprobe.c. This is
because igrab() will not prevent umount of the containing mount point.
To fix this, we added path to struct trace_uprobe, which keeps the inode
and containing mount reference.

For uprobes.c sisde, igrab() is not necessary. So we removed it and
added comments on requirements to callers of uprobe_register().

Link: http://lkml.kernel.org/r/CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Howard McLauchlan <hmclauchlan@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/uprobes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ce6848e..20486bb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -491,7 +491,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 	if (!uprobe)
 		return NULL;
 
-	uprobe->inode = igrab(inode);
 	uprobe->offset = offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
@@ -502,7 +501,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 	if (cur_uprobe) {
 		kfree(uprobe);
 		uprobe = cur_uprobe;
-		iput(inode);
 	}
 
 	return uprobe;
@@ -701,7 +699,6 @@ static void delete_uprobe(struct uprobe *uprobe)
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
 	spin_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
-	iput(uprobe->inode);
 	put_uprobe(uprobe);
 }
 
@@ -873,7 +870,8 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
  * tuple).  Creation refcount stops uprobe_unregister from freeing the
  * @uprobe even before the register operation is complete. Creation
  * refcount is released when the last @uc for the @uprobe
- * unregisters.
+ * unregisters. Caller of uprobe_register() is required to keep @inode
+ * (and the containing mount) referenced.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
-- 
2.9.5
