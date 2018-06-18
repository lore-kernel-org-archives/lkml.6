Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BBDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1000F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966339AbeFRI1A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:27:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965815AbeFRI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A67A0C5C;
        Mon, 18 Jun 2018 08:26:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 249/279] afs: Fix refcounting in callback registration
Date:   Mon, 18 Jun 2018 10:13:54 +0200
Message-Id: <20180618080619.065282447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit d4a96bec7a7362834ef5c31d7b2cc9bf36eb0570 ]

The refcounting on afs_cb_interest struct objects in
afs_register_server_cb_interest() is wrong as it uses the server list
entry's call back interest pointer without regard for the fact that it
might be replaced at any time and the object thrown away.

Fix this by:

 (1) Put a lock on the afs_server_list struct that can be used to
     mediate access to the callback interest pointers in the servers array.

 (2) Keep a ref on the callback interest that we get from the entry.

 (3) Dropping the old reference held by vnode->cb_interest if we replace
     the pointer.

Fixes: c435ee34551e ("afs: Overhaul the callback handling")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/callback.c    |   56 ++++++++++++++++++++++++++++++++++++---------------
 fs/afs/internal.h    |    7 ++++--
 fs/afs/rotate.c      |    4 +--
 fs/afs/server_list.c |    7 ++++--
 4 files changed, 52 insertions(+), 22 deletions(-)

--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -23,36 +23,55 @@
 /*
  * Set up an interest-in-callbacks record for a volume on a server and
  * register it with the server.
- * - Called with volume->server_sem held.
+ * - Called with vnode->io_lock held.
  */
 int afs_register_server_cb_interest(struct afs_vnode *vnode,
-				    struct afs_server_entry *entry)
+				    struct afs_server_list *slist,
+				    unsigned int index)
 {
-	struct afs_cb_interest *cbi = entry->cb_interest, *vcbi, *new, *x;
+	struct afs_server_entry *entry = &slist->servers[index];
+	struct afs_cb_interest *cbi, *vcbi, *new, *old;
 	struct afs_server *server = entry->server;
 
 again:
+	if (vnode->cb_interest &&
+	    likely(vnode->cb_interest == entry->cb_interest))
+		return 0;
+
+	read_lock(&slist->lock);
+	cbi = afs_get_cb_interest(entry->cb_interest);
+	read_unlock(&slist->lock);
+
 	vcbi = vnode->cb_interest;
 	if (vcbi) {
-		if (vcbi == cbi)
+		if (vcbi == cbi) {
+			afs_put_cb_interest(afs_v2net(vnode), cbi);
 			return 0;
+		}
 
+		/* Use a new interest in the server list for the same server
+		 * rather than an old one that's still attached to a vnode.
+		 */
 		if (cbi && vcbi->server == cbi->server) {
 			write_seqlock(&vnode->cb_lock);
-			vnode->cb_interest = afs_get_cb_interest(cbi);
+			old = vnode->cb_interest;
+			vnode->cb_interest = cbi;
 			write_sequnlock(&vnode->cb_lock);
-			afs_put_cb_interest(afs_v2net(vnode), cbi);
+			afs_put_cb_interest(afs_v2net(vnode), old);
 			return 0;
 		}
 
+		/* Re-use the one attached to the vnode. */
 		if (!cbi && vcbi->server == server) {
-			afs_get_cb_interest(vcbi);
-			x = cmpxchg(&entry->cb_interest, cbi, vcbi);
-			if (x != cbi) {
-				cbi = x;
-				afs_put_cb_interest(afs_v2net(vnode), vcbi);
+			write_lock(&slist->lock);
+			if (entry->cb_interest) {
+				write_unlock(&slist->lock);
+				afs_put_cb_interest(afs_v2net(vnode), cbi);
 				goto again;
 			}
+
+			entry->cb_interest = cbi;
+			write_unlock(&slist->lock);
 			return 0;
 		}
 	}
@@ -72,13 +91,16 @@ again:
 		list_add_tail(&new->cb_link, &server->cb_interests);
 		write_unlock(&server->cb_break_lock);
 
-		x = cmpxchg(&entry->cb_interest, cbi, new);
-		if (x == cbi) {
+		write_lock(&slist->lock);
+		if (!entry->cb_interest) {
+			entry->cb_interest = afs_get_cb_interest(new);
 			cbi = new;
+			new = NULL;
 		} else {
-			cbi = x;
-			afs_put_cb_interest(afs_v2net(vnode), new);
+			cbi = afs_get_cb_interest(entry->cb_interest);
 		}
+		write_unlock(&slist->lock);
+		afs_put_cb_interest(afs_v2net(vnode), new);
 	}
 
 	ASSERT(cbi);
@@ -88,11 +110,13 @@ again:
 	 */
 	write_seqlock(&vnode->cb_lock);
 
-	vnode->cb_interest = afs_get_cb_interest(cbi);
+	old = vnode->cb_interest;
+	vnode->cb_interest = cbi;
 	vnode->cb_s_break = cbi->server->cb_s_break;
 	clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 
 	write_sequnlock(&vnode->cb_lock);
+	afs_put_cb_interest(afs_v2net(vnode), old);
 	return 0;
 }
 
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -399,6 +399,7 @@ struct afs_server_list {
 	unsigned short		index;		/* Server currently in use */
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
 	unsigned int		seq;		/* Set to ->servers_seq when installed */
+	rwlock_t		lock;
 	struct afs_server_entry	servers[];
 };
 
@@ -605,13 +606,15 @@ extern void afs_init_callback_state(stru
 extern void afs_break_callback(struct afs_vnode *);
 extern void afs_break_callbacks(struct afs_server *, size_t,struct afs_callback[]);
 
-extern int afs_register_server_cb_interest(struct afs_vnode *, struct afs_server_entry *);
+extern int afs_register_server_cb_interest(struct afs_vnode *,
+					   struct afs_server_list *, unsigned int);
 extern void afs_put_cb_interest(struct afs_net *, struct afs_cb_interest *);
 extern void afs_clear_callback_interests(struct afs_net *, struct afs_server_list *);
 
 static inline struct afs_cb_interest *afs_get_cb_interest(struct afs_cb_interest *cbi)
 {
-	refcount_inc(&cbi->usage);
+	if (cbi)
+		refcount_inc(&cbi->usage);
 	return cbi;
 }
 
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -350,8 +350,8 @@ use_server:
 	 * break request before we've finished decoding the reply and
 	 * installing the vnode.
 	 */
-	fc->ac.error = afs_register_server_cb_interest(
-		vnode, &fc->server_list->servers[fc->index]);
+	fc->ac.error = afs_register_server_cb_interest(vnode, fc->server_list,
+						       fc->index);
 	if (fc->ac.error < 0)
 		goto failed;
 
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -49,6 +49,7 @@ struct afs_server_list *afs_alloc_server
 		goto error;
 
 	refcount_set(&slist->usage, 1);
+	rwlock_init(&slist->lock);
 
 	/* Make sure a records exists for each server in the list. */
 	for (i = 0; i < vldb->nr_servers; i++) {
@@ -64,9 +65,11 @@ struct afs_server_list *afs_alloc_server
 			goto error_2;
 		}
 
-		/* Insertion-sort by server pointer */
+		/* Insertion-sort by UUID */
 		for (j = 0; j < slist->nr_servers; j++)
-			if (slist->servers[j].server >= server)
+			if (memcmp(&slist->servers[j].server->uuid,
+				   &server->uuid,
+				   sizeof(server->uuid)) >= 0)
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {


