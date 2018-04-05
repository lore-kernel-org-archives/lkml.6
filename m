Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDEU3r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:29:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeDEU3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:29:44 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/20] afs: Fix checker warnings
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:29:42 +0100
Message-ID: <152296018223.31027.12652988859947053572.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings raised by checker, including:

 (*) Warnings raised by unequal comparison for the purposes of sorting,
     where the endianness doesn't matter:

fs/afs/addr_list.c:246:21: warning: restricted __be16 degrades to integer
fs/afs/addr_list.c:246:30: warning: restricted __be16 degrades to integer
fs/afs/addr_list.c:248:21: warning: restricted __be32 degrades to integer
fs/afs/addr_list.c:248:49: warning: restricted __be32 degrades to integer
fs/afs/addr_list.c:283:21: warning: restricted __be16 degrades to integer
fs/afs/addr_list.c:283:30: warning: restricted __be16 degrades to integer

 (*) afs_set_cb_interest() is not actually used and can be removed.

 (*) afs_cell_gc_delay() should be provided with a sysctl.

 (*) afs_cell_destroy() needs to use rcu_access_pointer() to read
     cell->vl_addrs.

 (*) afs_init_fs_cursor() should be static.

 (*) struct afs_vnode::permit_cache needs to be marked __rcu.

 (*) afs_server_rcu() needs to use rcu_access_pointer().

 (*) afs_destroy_server() should use rcu_access_pointer() on
     server->addresses as the server object is no longer accessible.

 (*) afs_find_server() casts __be16/__be32 values to int in order to
     directly compare them for the purpose of finding a match in a list,
     but is should also annotate the cast with __force to avoid checker
     warnings.

 (*) afs_check_permit() accesses vnode->permit_cache outside of the RCU
     readlock, though it doesn't then access the value; the extraneous
     access is deleted.

False positives:

 (*) Conditional locking around the code in xdr_decode_AFSFetchStatus.  This
     can be dealt with in a separate patch.

fs/afs/fsclient.c:148:9: warning: context imbalance in 'xdr_decode_AFSFetchStatus' - different lock contexts for basic block

 (*) Incorrect handling of seq-retry lock context balance:

fs/afs/inode.c:455:38: warning: context imbalance in 'afs_getattr' - different
lock contexts for basic block
fs/afs/server.c:52:17: warning: context imbalance in 'afs_find_server' - different lock contexts for basic block
fs/afs/server.c:128:17: warning: context imbalance in 'afs_find_server_by_uuid' - different lock contexts for basic block

Errors:

 (*) afs_lookup_cell_rcu() needs to break out of the seq-retry loop, not go
     round again if it successfully found the workstation cell.

 (*) Fix UUID decode in afs_deliver_cb_probe_uuid().

 (*) afs_cache_permit() has a missing rcu_read_unlock() before one of the
     jumps to the someone_else_changed_it label.  Move the unlock to after
     the label.

 (*) afs_vl_get_addrs_u() is using ntohl() rather than htonl() when
     encoding to XDR.

 (*) afs_deliver_yfsvl_get_endpoints() is using htonl() rather than ntohl()
     when decoding from XDR.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |    6 +++---
 fs/afs/callback.c  |   20 --------------------
 fs/afs/cell.c      |    6 +++---
 fs/afs/cmservice.c |    6 +++---
 fs/afs/inode.c     |    2 +-
 fs/afs/internal.h  |    2 +-
 fs/afs/proc.c      |    8 ++++++++
 fs/afs/rotate.c    |    2 +-
 fs/afs/security.c  |   11 +++--------
 fs/afs/server.c    |   14 ++++++++------
 fs/afs/vlclient.c  |    8 ++++----
 11 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index fd9f28b8a933..3bedfed608a2 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -243,9 +243,9 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 		    xport == a->sin6_port)
 			return;
 		if (xdr == a->sin6_addr.s6_addr32[3] &&
-		    xport < a->sin6_port)
+		    (u16 __force)xport < (u16 __force)a->sin6_port)
 			break;
-		if (xdr < a->sin6_addr.s6_addr32[3])
+		if ((u32 __force)xdr < (u32 __force)a->sin6_addr.s6_addr32[3])
 			break;
 	}
 
@@ -280,7 +280,7 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 		    xport == a->sin6_port)
 			return;
 		if (diff == 0 &&
-		    xport < a->sin6_port)
+		    (u16 __force)xport < (u16 __force)a->sin6_port)
 			break;
 		if (diff < 0)
 			break;
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index f4291b576054..bf082c719645 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -96,26 +96,6 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
 	return 0;
 }
 
-/*
- * Set a vnode's interest on a server.
- */
-void afs_set_cb_interest(struct afs_vnode *vnode, struct afs_cb_interest *cbi)
-{
-	struct afs_cb_interest *old_cbi = NULL;
-
-	if (vnode->cb_interest == cbi)
-		return;
-
-	write_seqlock(&vnode->cb_lock);
-	if (vnode->cb_interest != cbi) {
-		afs_get_cb_interest(cbi);
-		old_cbi = vnode->cb_interest;
-		vnode->cb_interest = cbi;
-	}
-	write_sequnlock(&vnode->cb_lock);
-	afs_put_cb_interest(afs_v2net(vnode), cbi);
-}
-
 /*
  * Remove an interest on a server.
  */
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 4235a05afc76..69b95faacc5e 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -18,7 +18,7 @@
 #include <keys/rxrpc-type.h>
 #include "internal.h"
 
-unsigned __read_mostly afs_cell_gc_delay = 10;
+static unsigned __read_mostly afs_cell_gc_delay = 10;
 
 static void afs_manage_cell(struct work_struct *);
 
@@ -75,7 +75,7 @@ struct afs_cell *afs_lookup_cell_rcu(struct afs_net *net,
 			cell = rcu_dereference_raw(net->ws_cell);
 			if (cell) {
 				afs_get_cell(cell);
-				continue;
+				break;
 			}
 			ret = -EDESTADDRREQ;
 			continue;
@@ -411,7 +411,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 
 	ASSERTCMP(atomic_read(&cell->usage), ==, 0);
 
-	afs_put_addrlist(cell->vl_addrs);
+	afs_put_addrlist(rcu_access_pointer(cell->vl_addrs));
 	key_put(cell->anonymous_key);
 	kfree(cell);
 
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 41e277f57b20..83ff283979a4 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -500,9 +500,9 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 		b = call->buffer;
 		r = call->request;
-		r->time_low			= ntohl(b[0]);
-		r->time_mid			= ntohl(b[1]);
-		r->time_hi_and_version		= ntohl(b[2]);
+		r->time_low			= b[0];
+		r->time_mid			= htons(ntohl(b[1]));
+		r->time_hi_and_version		= htons(ntohl(b[2]));
 		r->clock_seq_hi_and_reserved 	= ntohl(b[3]);
 		r->clock_seq_low		= ntohl(b[4]);
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 65c5b1edd338..d5db9dead18c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -544,7 +544,7 @@ void afs_evict_inode(struct inode *inode)
 	}
 #endif
 
-	afs_put_permits(vnode->permit_cache);
+	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
 	_leave("");
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a6a1d75eee41..135192b7dc04 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -458,7 +458,7 @@ struct afs_vnode {
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
-	struct afs_permits	*permit_cache;	/* cache of permits so far obtained */
+	struct afs_permits __rcu *permit_cache;	/* cache of permits so far obtained */
 	struct mutex		io_lock;	/* Lock for serialising I/O on this mutex */
 	struct mutex		validate_lock;	/* lock for validating this vnode */
 	spinlock_t		wb_lock;	/* lock for wb_keys */
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 4508dd54f789..1c95756335b7 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -183,6 +183,7 @@ static int afs_proc_cells_open(struct inode *inode, struct file *file)
  * first item
  */
 static void *afs_proc_cells_start(struct seq_file *m, loff_t *_pos)
+	__acquires(rcu)
 {
 	struct afs_net *net = afs_seq2net(m);
 
@@ -204,6 +205,7 @@ static void *afs_proc_cells_next(struct seq_file *m, void *v, loff_t *pos)
  * clean up after reading from the cells list
  */
 static void afs_proc_cells_stop(struct seq_file *m, void *v)
+	__releases(rcu)
 {
 	rcu_read_unlock();
 }
@@ -413,6 +415,7 @@ static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file)
  * first item
  */
 static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
+	__acquires(cell->proc_lock)
 {
 	struct afs_cell *cell = m->private;
 
@@ -438,6 +441,7 @@ static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
  * clean up after reading from the cells list
  */
 static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
+	__releases(cell->proc_lock)
 {
 	struct afs_cell *cell = p->private;
 
@@ -500,6 +504,7 @@ static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
  * first item
  */
 static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
+	__acquires(rcu)
 {
 	struct afs_addr_list *alist;
 	struct afs_cell *cell = m->private;
@@ -544,6 +549,7 @@ static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
  * clean up after reading from the cells list
  */
 static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v)
+	__releases(rcu)
 {
 	rcu_read_unlock();
 }
@@ -580,6 +586,7 @@ static int afs_proc_servers_open(struct inode *inode, struct file *file)
  * first item.
  */
 static void *afs_proc_servers_start(struct seq_file *m, loff_t *_pos)
+	__acquires(rcu)
 {
 	struct afs_net *net = afs_seq2net(m);
 
@@ -601,6 +608,7 @@ static void *afs_proc_servers_next(struct seq_file *m, void *v, loff_t *_pos)
  * clean up after reading from the cells list
  */
 static void afs_proc_servers_stop(struct seq_file *p, void *v)
+	__releases(rcu)
 {
 	rcu_read_unlock();
 }
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ad1328d85526..ac0feac9d746 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -21,7 +21,7 @@
 /*
  * Initialise a filesystem server cursor for iterating over FS servers.
  */
-void afs_init_fs_cursor(struct afs_fs_cursor *fc, struct afs_vnode *vnode)
+static void afs_init_fs_cursor(struct afs_fs_cursor *fc, struct afs_vnode *vnode)
 {
 	memset(fc, 0, sizeof(*fc));
 }
diff --git a/fs/afs/security.c b/fs/afs/security.c
index b88b7d45fdaa..bd82c5bf4a6a 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -178,18 +178,14 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 		}
 	}
 
-	if (cb_break != (vnode->cb_break + vnode->cb_interest->server->cb_s_break)) {
-		rcu_read_unlock();
+	if (cb_break != (vnode->cb_break + vnode->cb_interest->server->cb_s_break))
 		goto someone_else_changed_it;
-	}
 
 	/* We need a ref on any permits list we want to copy as we'll have to
 	 * drop the lock to do memory allocation.
 	 */
-	if (permits && !refcount_inc_not_zero(&permits->usage)) {
-		rcu_read_unlock();
+	if (permits && !refcount_inc_not_zero(&permits->usage))
 		goto someone_else_changed_it;
-	}
 
 	rcu_read_unlock();
 
@@ -278,6 +274,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 	/* Someone else changed the cache under us - don't recheck at this
 	 * time.
 	 */
+	rcu_read_unlock();
 	return;
 }
 
@@ -296,8 +293,6 @@ int afs_check_permit(struct afs_vnode *vnode, struct key *key,
 	_enter("{%x:%u},%x",
 	       vnode->fid.vid, vnode->fid.vnode, key_serial(key));
 
-	permits = vnode->permit_cache;
-
 	/* check the permits to see if we've got one yet */
 	if (key == vnode->volume->cell->anonymous_key) {
 		_debug("anon");
diff --git a/fs/afs/server.c b/fs/afs/server.c
index a43ef77dabae..e23be63998a8 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -59,7 +59,8 @@ struct afs_server *afs_find_server(struct afs_net *net,
 				alist = rcu_dereference(server->addresses);
 				for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
 					b = &alist->addrs[i].transport.sin6;
-					diff = (u16)a->sin6_port - (u16)b->sin6_port;
+					diff = ((u16 __force)a->sin6_port -
+						(u16 __force)b->sin6_port);
 					if (diff == 0)
 						diff = memcmp(&a->sin6_addr,
 							      &b->sin6_addr,
@@ -79,10 +80,11 @@ struct afs_server *afs_find_server(struct afs_net *net,
 				alist = rcu_dereference(server->addresses);
 				for (i = 0; i < alist->nr_ipv4; i++) {
 					b = &alist->addrs[i].transport.sin6;
-					diff = (u16)a->sin6_port - (u16)b->sin6_port;
+					diff = ((u16 __force)a->sin6_port -
+						(u16 __force)b->sin6_port);
 					if (diff == 0)
-						diff = ((u32)a->sin6_addr.s6_addr32[3] -
-							(u32)b->sin6_addr.s6_addr32[3]);
+						diff = ((u32 __force)a->sin6_addr.s6_addr32[3] -
+							(u32 __force)b->sin6_addr.s6_addr32[3]);
 					if (diff == 0)
 						goto found;
 					if (diff < 0) {
@@ -381,7 +383,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 {
 	struct afs_server *server = container_of(rcu, struct afs_server, rcu);
 
-	afs_put_addrlist(server->addresses);
+	afs_put_addrlist(rcu_access_pointer(server->addresses));
 	kfree(server);
 }
 
@@ -390,7 +392,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
  */
 static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 {
-	struct afs_addr_list *alist = server->addresses;
+	struct afs_addr_list *alist = rcu_access_pointer(server->addresses);
 	struct afs_addr_cursor ac = {
 		.alist	= alist,
 		.addr	= &alist->addrs[0],
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 5d8562f1ad4a..f9d89795e41b 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -303,7 +303,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_net *net,
 	r->uuid.clock_seq_hi_and_reserved 	= htonl(u->clock_seq_hi_and_reserved);
 	r->uuid.clock_seq_low			= htonl(u->clock_seq_low);
 	for (i = 0; i < 6; i++)
-		r->uuid.node[i] = ntohl(u->node[i]);
+		r->uuid.node[i] = htonl(u->node[i]);
 
 	trace_afs_make_vl_call(call);
 	return (struct afs_addr_list *)afs_make_call(ac, call, GFP_KERNEL, false);
@@ -504,7 +504,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		/* Got either the type of the next entry or the count of
 		 * volEndpoints if no more fsEndpoints.
 		 */
-		call->count2 = htonl(*bp++);
+		call->count2 = ntohl(*bp++);
 
 		call->offset = 0;
 		call->count--;
@@ -531,7 +531,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		call->count2 = htonl(*bp++);
+		call->count2 = ntohl(*bp++);
 		call->offset = 0;
 		call->unmarshall = 4;
 
@@ -576,7 +576,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		call->offset = 0;
 		call->count--;
 		if (call->count > 0) {
-			call->count2 = htonl(*bp++);
+			call->count2 = ntohl(*bp++);
 			goto again;
 		}
 
