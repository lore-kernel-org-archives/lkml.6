Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEBUAu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbeEBUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:00:43 -0400
Message-Id: <20180502200041.518016867@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 02 May 2018 16:00:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH 2/7] tracing: Remove igrab() iput() call from uprobes.c
References: <20180502200003.592877274@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Remove-igrab-iput-call-from-uprobes.c.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Caller of uprobe_register is required to keep the inode and containing
mount point referenced.

There was misuse of igrab() in uprobes.c and trace_uprobe.c. This is
because igrab() will not prevent umount of the containing mount point.
To fix this, we added path to struct trace_uprobe, which keeps the inode
and containing mount reference.

For uprobes.c, it is not necessary to call igrab() in uprobe_register(),
as the caller is required to keep the inode reference. The igrab() is
removed and comments on this requirement is added to uprobe_register().

Link: http://lkml.kernel.org/r/CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com
Link: http://lkml.kernel.org/r/20180423172135.4050588-2-songliubraving@fb.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Howard McLauchlan <hmclauchlan@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/events/uprobes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ce6848e46e94..1725b902983f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -491,7 +491,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 	if (!uprobe)
 		return NULL;
 
-	uprobe->inode = igrab(inode);
+	uprobe->inode = inode;
 	uprobe->offset = offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
@@ -502,7 +502,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 	if (cur_uprobe) {
 		kfree(uprobe);
 		uprobe = cur_uprobe;
-		iput(inode);
 	}
 
 	return uprobe;
@@ -701,7 +700,6 @@ static void delete_uprobe(struct uprobe *uprobe)
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
 	spin_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
-	iput(uprobe->inode);
 	put_uprobe(uprobe);
 }
 
@@ -873,7 +871,8 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
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
2.17.0
