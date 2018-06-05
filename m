Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeFEQHg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:07:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752275AbeFEQHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:07:32 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] afs: Optimise callback breaking by not repeating volume
 lookup
From: David Howells <dhowells@redhat.com>
To: viro@ZenIV.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 17:07:30 +0100
Message-ID: <152821485065.16494.756490676047402859.stgit@warthog.procyon.org.uk>
In-Reply-To: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
References: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, afs_break_callbacks calls afs_break_one_callback() for each
separate FID it was given, and the latter looks up the volume individually
for each one.

However, this is inefficient if two or more FIDs have the same vid as we
could reuse the volume.  This is complicated by cell aliasing whereby we
may have multiple cells sharing a volume and can therefore have multiple
callback interests for any particular volume ID.

At the moment afs_break_one_callback() scans the entire list of volumes
we're getting from a server and breaks the appropriate callback in every
matching volume, regardless of cell.  This scan is done for every FID.

Optimise callback breaking by the following means:

 (1) Sort the FID list by vid so that all FIDs belonging to the same volume
     are clumped together.

     This is done through the use of an indirection table as we cannot do
     an insertion sort on the afs_callback_break array as we decode FIDs
     into it as we subsequently also have to decode callback info into it
     that corresponds by array index only.

     We also don't really want to bubblesort afterwards if we can avoid it.

 (2) Sort the server->cb_interests array by vid so that all the matching
     volumes are grouped together.  This permits the scan to stop after
     finding a record that has a higher vid.

 (3) When breaking FIDs, we try to keep server->cb_break_lock as long as
     possible, caching the start point in the array for that volume group
     as long as possible.

     It might make sense to add another layer in that list and have a
     refcounted volume ID anchor that has the matching interests attached
     to it rather than being in the list.  This would allow the lock to be
     dropped without losing the cursor.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c |  110 +++++++++++++++++++++++++++++++++++++++++++++--------
 fs/afs/internal.h |   15 ++++++-
 fs/afs/server.c   |    2 -
 3 files changed, 107 insertions(+), 20 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 571437dcb252..5f261fbf2182 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -20,6 +20,66 @@
 #include <linux/sched.h>
 #include "internal.h"
 
+/*
+ * Create volume and callback interests on a server.
+ */
+static struct afs_cb_interest *afs_create_interest(struct afs_server *server,
+						   struct afs_vnode *vnode)
+{
+	struct afs_vol_interest *new_vi, *vi;
+	struct afs_cb_interest *new;
+	struct hlist_node **pp;
+
+	new_vi = kzalloc(sizeof(struct afs_vol_interest), GFP_KERNEL);
+	if (!new_vi)
+		return NULL;
+
+	new = kzalloc(sizeof(struct afs_cb_interest), GFP_KERNEL);
+	if (!new) {
+		kfree(new_vi);
+		return NULL;
+	}
+
+	new_vi->usage = 1;
+	new_vi->vid = vnode->volume->vid;
+	INIT_HLIST_NODE(&new_vi->srv_link);
+	INIT_HLIST_HEAD(&new_vi->cb_interests);
+
+	refcount_set(&new->usage, 1);
+	new->sb = vnode->vfs_inode.i_sb;
+	new->vid = vnode->volume->vid;
+	new->server = afs_get_server(server);
+	INIT_HLIST_NODE(&new->cb_vlink);
+
+	write_lock(&server->cb_break_lock);
+
+	for (pp = &server->cb_volumes.first; *pp; pp = &(*pp)->next) {
+		vi = hlist_entry(*pp, struct afs_vol_interest, srv_link);
+		if (vi->vid < new_vi->vid)
+			continue;
+		if (vi->vid > new_vi->vid)
+			break;
+		vi->usage++;
+		goto found_vi;
+	}
+
+	new_vi->srv_link.pprev = pp;
+	new_vi->srv_link.next = *pp;
+	if (*pp)
+		(*pp)->pprev = &new_vi->srv_link.next;
+	*pp = &new_vi->srv_link;
+	vi = new_vi;
+	new_vi = NULL;
+found_vi:
+
+	new->vol_interest = vi;
+	hlist_add_head(&new->cb_vlink, &vi->cb_interests);
+
+	write_unlock(&server->cb_break_lock);
+	kfree(new_vi);
+	return new;
+}
+
 /*
  * Set up an interest-in-callbacks record for a volume on a server and
  * register it with the server.
@@ -77,20 +137,10 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
 	}
 
 	if (!cbi) {
-		new = kzalloc(sizeof(struct afs_cb_interest), GFP_KERNEL);
+		new = afs_create_interest(server, vnode);
 		if (!new)
 			return -ENOMEM;
 
-		refcount_set(&new->usage, 1);
-		new->sb = vnode->vfs_inode.i_sb;
-		new->vid = vnode->volume->vid;
-		new->server = afs_get_server(server);
-		INIT_LIST_HEAD(&new->cb_link);
-
-		write_lock(&server->cb_break_lock);
-		list_add_tail(&new->cb_link, &server->cb_interests);
-		write_unlock(&server->cb_break_lock);
-
 		write_lock(&slist->lock);
 		if (!entry->cb_interest) {
 			entry->cb_interest = afs_get_cb_interest(new);
@@ -126,11 +176,22 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
  */
 void afs_put_cb_interest(struct afs_net *net, struct afs_cb_interest *cbi)
 {
+	struct afs_vol_interest *vi;
+
 	if (cbi && refcount_dec_and_test(&cbi->usage)) {
-		if (!list_empty(&cbi->cb_link)) {
+		if (!hlist_unhashed(&cbi->cb_vlink)) {
 			write_lock(&cbi->server->cb_break_lock);
-			list_del_init(&cbi->cb_link);
+
+			hlist_del_init(&cbi->cb_vlink);
+			vi = cbi->vol_interest;
+			cbi->vol_interest = NULL;
+			if (--vi->usage == 0)
+				hlist_del(&vi->srv_link);
+			else
+				vi = NULL;
+
 			write_unlock(&cbi->server->cb_break_lock);
+			kfree(vi);
 			afs_put_server(net, cbi->server);
 		}
 		kfree(cbi);
@@ -182,20 +243,34 @@ void afs_break_callback(struct afs_vnode *vnode)
 static void afs_break_one_callback(struct afs_server *server,
 				   struct afs_fid *fid)
 {
+	struct afs_vol_interest *vi;
 	struct afs_cb_interest *cbi;
 	struct afs_iget_data data;
 	struct afs_vnode *vnode;
 	struct inode *inode;
 
 	read_lock(&server->cb_break_lock);
+	hlist_for_each_entry(vi, &server->cb_volumes, srv_link) {
+		if (vi->vid < fid->vid)
+			continue;
+		if (vi->vid > fid->vid) {
+			vi = NULL;
+			break;
+		}
+		//atomic_inc(&vi->usage);
+		break;
+	}
+
+	/* TODO: Find all matching volumes if we couldn't match the server and
+	 * break them anyway.
+	 */
+	if (!vi)
+		goto out;
 
 	/* Step through all interested superblocks.  There may be more than one
 	 * because of cell aliasing.
 	 */
-	list_for_each_entry(cbi, &server->cb_interests, cb_link) {
-		if (cbi->vid != fid->vid)
-			continue;
-
+	hlist_for_each_entry(cbi, &vi->cb_interests, cb_vlink) {
 		if (fid->vnode == 0 && fid->unique == 0) {
 			/* The callback break applies to an entire volume. */
 			struct afs_super_info *as = AFS_FS_S(cbi->sb);
@@ -217,6 +292,7 @@ static void afs_break_one_callback(struct afs_server *server,
 		}
 	}
 
+out:
 	read_unlock(&server->cb_break_lock);
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ab6bdf456f1a..e35d59761d47 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -406,16 +406,27 @@ struct afs_server {
 	rwlock_t		fs_lock;	/* access lock */
 
 	/* callback promise management */
-	struct list_head	cb_interests;	/* List of superblocks using this server */
+	struct hlist_head	cb_volumes;	/* List of volume interests on this server */
 	unsigned		cb_s_break;	/* Break-everything counter. */
 	rwlock_t		cb_break_lock;	/* Volume finding lock */
 };
 
+/*
+ * Volume collation in the server's callback interest list.
+ */
+struct afs_vol_interest {
+	struct hlist_node	srv_link;	/* Link in server->cb_volumes */
+	struct hlist_head	cb_interests;	/* List of callback interests on the server */
+	afs_volid_t		vid;		/* Volume ID to match */
+	unsigned int		usage;
+};
+
 /*
  * Interest by a superblock on a server.
  */
 struct afs_cb_interest {
-	struct list_head	cb_link;	/* Link in server->cb_interests */
+	struct hlist_node	cb_vlink;	/* Link in vol_interest->cb_interests */
+	struct afs_vol_interest	*vol_interest;
 	struct afs_server	*server;	/* Server on which this interest resides */
 	struct super_block	*sb;		/* Superblock on which inodes reside */
 	afs_volid_t		vid;		/* Volume ID to match */
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 3af4625e2f8c..1d329e6981d5 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -228,7 +228,7 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	server->flags = (1UL << AFS_SERVER_FL_NEW);
 	server->update_at = ktime_get_real_seconds() + afs_server_update_delay;
 	rwlock_init(&server->fs_lock);
-	INIT_LIST_HEAD(&server->cb_interests);
+	INIT_HLIST_HEAD(&server->cb_volumes);
 	rwlock_init(&server->cb_break_lock);
 
 	afs_inc_servers_outstanding(net);
