Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BAC208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BAC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeHAWvr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:51:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeHAWvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:51:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30C7381663CF;
        Wed,  1 Aug 2018 21:04:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE51C10CD883;
        Wed,  1 Aug 2018 21:04:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com> <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        raven@themaw.net, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: LSM hook for mount, superblock and keys watch notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7560.1533157444.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 01 Aug 2018 22:04:04 +0100
Message-ID: <7561.1533157444@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 21:04:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 21:04:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about if I apply the attached patch?  It creates a new LSM hook that gets
called each time a notification is about to be posted on a queue.  It is given
the creds from the /dev/watch_queue opener, the creds of whoever triggered the
watchpoint and a pointer to the notification message.

The notification message includes metadata describing the source/type of the
message and the subtype within that, plus subtype-specific flags.

David
---
diff --git a/drivers/misc/watch_queue.c b/drivers/misc/watch_queue.c
index 13c9f88e6953..3e7bb032ec17 100644
--- a/drivers/misc/watch_queue.c
+++ b/drivers/misc/watch_queue.c
@@ -23,6 +23,8 @@
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <linux/file.h>
+#include <linux/security.h>
+#include <linux/cred.h>
 #include <linux/watch_queue.h>
 
 #define DEBUG_WITH_WRITE /* Allow use of write() to record notifications */
@@ -50,6 +52,7 @@ struct watch_filter {
 struct watch_queue {
 	struct rcu_head		rcu;
 	struct address_space	mapping;
+	const struct cred	*cred;		/* Creds of the owner of the queue */
 	struct watch_filter	*filter;
 	wait_queue_head_t	waiters;
 	struct hlist_head	watches;	/* Contributory watches */
@@ -82,7 +85,8 @@ struct watch_queue {
  * should be in units of sizeof(*n).
  */
 static bool post_one_notification(struct watch_queue *wqueue,
-				  struct watch_notification *n)
+				  struct watch_notification *n,
+				  const struct cred *cred)
 {
 	struct watch_queue_buffer *buf = wqueue->buffer;
 	unsigned int metalen = sizeof(buf->meta) / sizeof(buf->slots[0]);
@@ -99,7 +103,8 @@ static bool post_one_notification(struct watch_queue *wqueue,
 
 	spin_lock(&wqueue->lock); /* Protect head pointer */
 
-	if (wqueue->defunct)
+	if (wqueue->defunct ||
+	    security_post_notification(wqueue->cred, cred, n) < 0)
 		goto out;
 
 	ring_tail = READ_ONCE(buf->meta.tail);
@@ -205,6 +210,7 @@ static bool filter_watch_notification(const struct watch_filter *wf,
  * __post_watch_notification - Post an event notification
  * @wlist: The watch list to post the event to.
  * @n: The notification record to post.
+ * @cred: The creds of the process that triggered the notification.
  * @id: The ID to match on the watch.
  *
  * Post a notification of an event into a set of watch queues and let the users
@@ -217,6 +223,7 @@ static bool filter_watch_notification(const struct watch_filter *wf,
  */
 void __post_watch_notification(struct watch_list *wlist,
 			       struct watch_notification *n,
+			       const struct cred *cred,
 			       u64 id)
 {
 	const struct watch_filter *wf;
@@ -236,7 +243,7 @@ void __post_watch_notification(struct watch_list *wlist,
 		if (wf && !filter_watch_notification(wf, n))
 			continue;
 
-		post_one_notification(wqueue, n);
+		post_one_notification(wqueue, n, cred);
 	}
 
 	rcu_read_unlock();
@@ -517,6 +524,7 @@ static int watch_queue_open(struct inode *inode, struct file *file)
 	refcount_set(&wqueue->usage, 1);
 	spin_lock_init(&wqueue->lock);
 	init_waitqueue_head(&wqueue->waiters);
+	wqueue->cred = get_cred(file->f_cred);
 
 	file->private_data = wqueue;
 	return 0;
@@ -615,7 +623,7 @@ int remove_watch_from_object(struct watch_list *wlist, struct watch_queue *wq,
 	n.subtype = watch_meta_removal_notification;
 	n.info = watch->info_id | sizeof(n);
 
-	post_one_notification(watch->queue, &n);
+	post_one_notification(watch->queue, &n, wq->cred);
 
 	/* We don't need the watch list lock for the next bit as RCU is
 	 * protecting everything from being deallocated.
@@ -733,6 +741,7 @@ static int watch_queue_release(struct inode *inode, struct file *file)
 	if (wqueue->filter)
 		kfree_rcu(wqueue->filter, rcu);
 	kfree(wqueue->pages);
+	put_cred(wqueue->cred);
 	put_watch_queue(wqueue);
 	return 0;
 }
@@ -760,7 +769,7 @@ static ssize_t watch_queue_write(struct file *file,
 		goto error;
 	n->info &= (WATCH_INFO_LENGTH | WATCH_INFO_TYPE_FLAGS | WATCH_INFO_ID);
 
-	if (post_one_notification(wqueue, n))
+	if (post_one_notification(wqueue, n, current_cred()))
 		wqueue->debug = 0;
 	else
 		wqueue->debug++;
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index b4905c363136..6de6e701bf20 100644
--- a/fs/mount_notify.c
+++ b/fs/mount_notify.c
@@ -22,6 +22,7 @@
 void post_mount_notification(struct mount *changed,
 			     struct mount_notification *notify)
 {
+	const struct cred *cred = current_cred();
 	struct path cursor;
 	struct mount *mnt;
 	unsigned seq;
@@ -40,7 +41,7 @@ void post_mount_notification(struct mount *changed,
 		    !hlist_empty(&mnt->mnt_watchers->watchers)) {
 			if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
 				post_watch_notification(mnt->mnt_watchers,
-							&notify->watch,
+							&notify->watch, cred,
 							(unsigned long)cursor.dentry);
 		} else {
 			cursor.dentry = mnt->mnt.mnt_root;
diff --git a/fs/super.c b/fs/super.c
index 1a1cf517dbd8..939ed08b87e9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1825,7 +1825,8 @@ EXPORT_SYMBOL(vfs_get_tree);
  */
 void post_sb_notification(struct super_block *s, struct superblock_notification *n)
 {
-	post_watch_notification(s->s_watchers, &n->watch, s->s_watch_id);
+	post_watch_notification(s->s_watchers, &n->watch, current_cred(),
+				s->s_watch_id);
 }
 
 static void release_sb_watch(struct watch_list *wlist, struct watch *watch)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b1a62dc0b8d9..08a61a5fecd4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1439,6 +1439,13 @@
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
  *
+ * @post_notification:
+ *	Check to see if a watch notification can be posted to a particular
+ *	queue.
+ *	@q_cred: The credentials of the target watch queue.
+ *	@cred: The event-triggerer's credentials
+ *	@n: The notification being posted
+ *
  * Security hooks for using the eBPF maps and programs functionalities through
  * eBPF syscalls.
  *
@@ -1713,6 +1720,11 @@ union security_list_options {
 	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_WATCH_QUEUE
+	int (*post_notification)(const struct cred *q_cred,
+				 const struct cred *cred,
+				 struct watch_notification *n);
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
@@ -1992,6 +2004,9 @@ struct security_hook_heads {
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
 	struct hlist_head inode_getsecctx;
+#ifdef CONFIG_WATCH_QUEUE
+	struct hlist_head post_notification;
+#endif
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index c73d9ba863bc..946ab7455a3f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -392,6 +392,11 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+#ifdef CONFIG_WATCH_QUEUE
+int security_post_notification(const struct cred *q_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n);
+#endif
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -1216,6 +1221,14 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+#ifdef CONFIG_WATCH_QUEUE
+static inline int security_post_notification(const struct cred *q_cred,
+					     const struct cred *cred,
+					     struct watch_notification *n)
+{
+	return 0;
+}
+#endif
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 465b14f3ad42..a1d20c917998 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -46,7 +46,9 @@ struct watch_list {
 };
 
 extern void __post_watch_notification(struct watch_list *,
-				      struct watch_notification *, u64);
+				      struct watch_notification *,
+				      const struct cred *,
+				      u64);
 extern struct watch_queue *get_watch_queue(int);
 extern void put_watch_queue(struct watch_queue *);
 extern void put_watch_list(struct watch_list *);
@@ -68,10 +70,11 @@ static inline void init_watch(struct watch *watch)
 
 static inline void post_watch_notification(struct watch_list *wlist,
 					   struct watch_notification *n,
+					   const struct cred *cred,
 					   u64 id)
 {
 	if (unlikely(wlist))
-		__post_watch_notification(wlist, n, id);
+		__post_watch_notification(wlist, n, cred, id);
 }
 
 static inline void remove_watch_list(struct watch_list *wlist)
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 66b424e8c104..8394e42fe5ae 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -194,7 +194,8 @@ static inline void notify_key(struct key *key,
 		.aux		= aux,
 	};
 
-	post_watch_notification(key->watchers, &n.watch, n.key_id);
+	post_watch_notification(key->watchers, &n.watch, current_cred(),
+				n.key_id);
 #endif
 }
 
diff --git a/security/security.c b/security/security.c
index 2439a5613813..2e9c74ca3eac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1375,6 +1375,15 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+#ifdef CONFIG_WATCH_QUEUE
+int security_post_notification(const struct cred *q_cred,
+			       const struct cred *cred,
+			       struct watch_notification *n)
+{
+	return call_int_hook(post_notification, 0, q_cred, cred, n);
+}
+#endif
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
