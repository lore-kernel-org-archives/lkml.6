Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B525C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5621021738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5621021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390334AbeHNUaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390232AbeHNUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 956C6C7B;
        Tue, 14 Aug 2018 17:42:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.9 016/107] proc/sysctl: Dont grab i_lock under sysctl_lock.
Date:   Tue, 14 Aug 2018 19:16:39 +0200
Message-Id: <20180814171521.727718884@linuxfoundation.org>
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

From: Eric W. Biederman <ebiederm@xmission.com>

commit ace0c791e6c3cf5ef37cad2df69f0d90ccc40ffb upstream.

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:
> This patch has locking problem. I've got lockdep splat under LTP.
>
> [ 6633.115456] ======================================================
> [ 6633.115502] [ INFO: possible circular locking dependency detected ]
> [ 6633.115553] 4.9.10-debug+ #9 Tainted: G             L
> [ 6633.115584] -------------------------------------------------------
> [ 6633.115627] ksm02/284980 is trying to acquire lock:
> [ 6633.115659]  (&sb->s_type->i_lock_key#4){+.+...}, at: [<ffffffff816bc1ce>] igrab+0x1e/0x80
> [ 6633.115834] but task is already holding lock:
> [ 6633.115882]  (sysctl_lock){+.+...}, at: [<ffffffff817e379b>] unregister_sysctl_table+0x6b/0x110
> [ 6633.116026] which lock already depends on the new lock.
> [ 6633.116026]
> [ 6633.116080]
> [ 6633.116080] the existing dependency chain (in reverse order) is:
> [ 6633.116117]
> -> #2 (sysctl_lock){+.+...}:
> -> #1 (&(&dentry->d_lockref.lock)->rlock){+.+...}:
> -> #0 (&sb->s_type->i_lock_key#4){+.+...}:
>
> d_lock nests inside i_lock
> sysctl_lock nests inside d_lock in d_compare
>
> This patch adds i_lock nesting inside sysctl_lock.

Al Viro <viro@ZenIV.linux.org.uk> replied:
> Once ->unregistering is set, you can drop sysctl_lock just fine.  So I'd
> try something like this - use rcu_read_lock() in proc_sys_prune_dcache(),
> drop sysctl_lock() before it and regain after.  Make sure that no inodes
> are added to the list ones ->unregistering has been set and use RCU list
> primitives for modifying the inode list, with sysctl_lock still used to
> serialize its modifications.
>
> Freeing struct inode is RCU-delayed (see proc_destroy_inode()), so doing
> igrab() is safe there.  Since we don't drop inode reference until after we'd
> passed beyond it in the list, list_for_each_entry_rcu() should be fine.

I agree with Al Viro's analsysis of the situtation.

Fixes: d6cffbbe9a7e ("proc/sysctl: prune stale dentries during unregistering")
Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Tested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/proc_sysctl.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -266,21 +266,19 @@ static void proc_sys_prune_dcache(struct
 	struct inode *inode, *prev = NULL;
 	struct proc_inode *ei;
 
-	list_for_each_entry(ei, &head->inodes, sysctl_inodes) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ei, &head->inodes, sysctl_inodes) {
 		inode = igrab(&ei->vfs_inode);
 		if (inode) {
-			spin_unlock(&sysctl_lock);
+			rcu_read_unlock();
 			iput(prev);
 			prev = inode;
 			d_prune_aliases(inode);
-			spin_lock(&sysctl_lock);
+			rcu_read_lock();
 		}
 	}
-	if (prev) {
-		spin_unlock(&sysctl_lock);
-		iput(prev);
-		spin_lock(&sysctl_lock);
-	}
+	rcu_read_unlock();
+	iput(prev);
 }
 
 /* called under sysctl_lock, will reacquire if has to wait */
@@ -296,10 +294,10 @@ static void start_unregistering(struct c
 		p->unregistering = &wait;
 		spin_unlock(&sysctl_lock);
 		wait_for_completion(&wait);
-		spin_lock(&sysctl_lock);
 	} else {
 		/* anything non-NULL; we'll never dereference it */
 		p->unregistering = ERR_PTR(-EINVAL);
+		spin_unlock(&sysctl_lock);
 	}
 	/*
 	 * Prune dentries for unregistered sysctls: namespaced sysctls
@@ -310,6 +308,7 @@ static void start_unregistering(struct c
 	 * do not remove from the list until nobody holds it; walking the
 	 * list in do_sysctl() relies on that.
 	 */
+	spin_lock(&sysctl_lock);
 	erase_header(p);
 }
 
@@ -455,11 +454,17 @@ static struct inode *proc_sys_make_inode
 	inode->i_ino = get_next_ino();
 
 	ei = PROC_I(inode);
-	ei->sysctl = head;
-	ei->sysctl_entry = table;
 
 	spin_lock(&sysctl_lock);
-	list_add(&ei->sysctl_inodes, &head->inodes);
+	if (unlikely(head->unregistering)) {
+		spin_unlock(&sysctl_lock);
+		iput(inode);
+		inode = NULL;
+		goto out;
+	}
+	ei->sysctl = head;
+	ei->sysctl_entry = table;
+	list_add_rcu(&ei->sysctl_inodes, &head->inodes);
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
@@ -487,7 +492,7 @@ out:
 void proc_sys_evict_inode(struct inode *inode, struct ctl_table_header *head)
 {
 	spin_lock(&sysctl_lock);
-	list_del(&PROC_I(inode)->sysctl_inodes);
+	list_del_rcu(&PROC_I(inode)->sysctl_inodes);
 	if (!--head->count)
 		kfree_rcu(head, rcu);
 	spin_unlock(&sysctl_lock);


