Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8481821653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481821653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbeHNUmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:42:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390233AbeHNUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:15 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 229C5AF3;
        Tue, 14 Aug 2018 17:41:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.9 015/107] proc/sysctl: prune stale dentries during unregistering
Date:   Tue, 14 Aug 2018 19:16:38 +0200
Message-Id: <20180814171521.682991894@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit d6cffbbe9a7e51eb705182965a189457c17ba8a3 upstream.

Currently unregistering sysctl table does not prune its dentries.
Stale dentries could slowdown sysctl operations significantly.

For example, command:

 # for i in {1..100000} ; do unshare -n -- sysctl -a &> /dev/null ; done
 creates a millions of stale denties around sysctls of loopback interface:

 # sysctl fs.dentry-state
 fs.dentry-state = 25812579  24724135        45      0       0       0

 All of them have matching names thus lookup have to scan though whole
 hash chain and call d_compare (proc_sys_compare) which checks them
 under system-wide spinlock (sysctl_lock).

 # time sysctl -a > /dev/null
 real    1m12.806s
 user    0m0.016s
 sys     1m12.400s

Currently only memory reclaimer could remove this garbage.
But without significant memory pressure this never happens.

This patch collects sysctl inodes into list on sysctl table header and
prunes all their dentries once that table unregisters.

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:
> On 10.02.2017 10:47, Al Viro wrote:
>> how about >> the matching stats *after* that patch?
>
> dcache size doesn't grow endlessly, so stats are fine
>
> # sysctl fs.dentry-state
> fs.dentry-state = 92712	58376	45	0	0	0
>
> # time sysctl -a &>/dev/null
>
> real	0m0.013s
> user	0m0.004s
> sys	0m0.008s

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/inode.c        |    3 +-
 fs/proc/internal.h     |    7 ++++-
 fs/proc/proc_sysctl.c  |   59 +++++++++++++++++++++++++++++++++++--------------
 include/linux/sysctl.h |    1 
 4 files changed, 51 insertions(+), 19 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -43,10 +43,11 @@ static void proc_evict_inode(struct inod
 	de = PDE(inode);
 	if (de)
 		pde_put(de);
+
 	head = PROC_I(inode)->sysctl;
 	if (head) {
 		RCU_INIT_POINTER(PROC_I(inode)->sysctl, NULL);
-		sysctl_head_put(head);
+		proc_sys_evict_inode(inode, head);
 	}
 }
 
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -65,6 +65,7 @@ struct proc_inode {
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
 	struct ctl_table *sysctl_entry;
+	struct list_head sysctl_inodes;
 	const struct proc_ns_operations *ns_ops;
 	struct inode vfs_inode;
 };
@@ -249,10 +250,12 @@ extern void proc_thread_self_init(void);
  */
 #ifdef CONFIG_PROC_SYSCTL
 extern int proc_sys_init(void);
-extern void sysctl_head_put(struct ctl_table_header *);
+extern void proc_sys_evict_inode(struct inode *inode,
+				 struct ctl_table_header *head);
 #else
 static inline void proc_sys_init(void) { }
-static inline void sysctl_head_put(struct ctl_table_header *head) { }
+static inline void proc_sys_evict_inode(struct  inode *inode,
+					struct ctl_table_header *head) { }
 #endif
 
 /*
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -190,6 +190,7 @@ static void init_header(struct ctl_table
 	head->set = set;
 	head->parent = NULL;
 	head->node = node;
+	INIT_LIST_HEAD(&head->inodes);
 	if (node) {
 		struct ctl_table *entry;
 		for (entry = table; entry->procname; entry++, node++)
@@ -259,6 +260,29 @@ static void unuse_table(struct ctl_table
 			complete(p->unregistering);
 }
 
+/* called under sysctl_lock */
+static void proc_sys_prune_dcache(struct ctl_table_header *head)
+{
+	struct inode *inode, *prev = NULL;
+	struct proc_inode *ei;
+
+	list_for_each_entry(ei, &head->inodes, sysctl_inodes) {
+		inode = igrab(&ei->vfs_inode);
+		if (inode) {
+			spin_unlock(&sysctl_lock);
+			iput(prev);
+			prev = inode;
+			d_prune_aliases(inode);
+			spin_lock(&sysctl_lock);
+		}
+	}
+	if (prev) {
+		spin_unlock(&sysctl_lock);
+		iput(prev);
+		spin_lock(&sysctl_lock);
+	}
+}
+
 /* called under sysctl_lock, will reacquire if has to wait */
 static void start_unregistering(struct ctl_table_header *p)
 {
@@ -278,27 +302,17 @@ static void start_unregistering(struct c
 		p->unregistering = ERR_PTR(-EINVAL);
 	}
 	/*
+	 * Prune dentries for unregistered sysctls: namespaced sysctls
+	 * can have duplicate names and contaminate dcache very badly.
+	 */
+	proc_sys_prune_dcache(p);
+	/*
 	 * do not remove from the list until nobody holds it; walking the
 	 * list in do_sysctl() relies on that.
 	 */
 	erase_header(p);
 }
 
-static void sysctl_head_get(struct ctl_table_header *head)
-{
-	spin_lock(&sysctl_lock);
-	head->count++;
-	spin_unlock(&sysctl_lock);
-}
-
-void sysctl_head_put(struct ctl_table_header *head)
-{
-	spin_lock(&sysctl_lock);
-	if (!--head->count)
-		kfree_rcu(head, rcu);
-	spin_unlock(&sysctl_lock);
-}
-
 static struct ctl_table_header *sysctl_head_grab(struct ctl_table_header *head)
 {
 	BUG_ON(!head);
@@ -440,11 +454,15 @@ static struct inode *proc_sys_make_inode
 
 	inode->i_ino = get_next_ino();
 
-	sysctl_head_get(head);
 	ei = PROC_I(inode);
 	ei->sysctl = head;
 	ei->sysctl_entry = table;
 
+	spin_lock(&sysctl_lock);
+	list_add(&ei->sysctl_inodes, &head->inodes);
+	head->count++;
+	spin_unlock(&sysctl_lock);
+
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_mode = table->mode;
 	if (!S_ISDIR(table->mode)) {
@@ -466,6 +484,15 @@ out:
 	return inode;
 }
 
+void proc_sys_evict_inode(struct inode *inode, struct ctl_table_header *head)
+{
+	spin_lock(&sysctl_lock);
+	list_del(&PROC_I(inode)->sysctl_inodes);
+	if (!--head->count)
+		kfree_rcu(head, rcu);
+	spin_unlock(&sysctl_lock);
+}
+
 static struct ctl_table_header *grab_header(struct inode *inode)
 {
 	struct ctl_table_header *head = PROC_I(inode)->sysctl;
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -143,6 +143,7 @@ struct ctl_table_header
 	struct ctl_table_set *set;
 	struct ctl_dir *parent;
 	struct ctl_node *node;
+	struct list_head inodes; /* head for proc_inode->sysctl_inodes */
 };
 
 struct ctl_dir {


