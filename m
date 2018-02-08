Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHQQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752185AbeBHQQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:38 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/7] afs: Remove unused code
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:36 +0000
Message-ID: <151810659639.20070.2254220204722586730.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some old unused code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rotate.c |  235 -------------------------------------------------------
 1 file changed, 235 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 892a4904fd77..cfe0931e7844 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -516,238 +516,3 @@ int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 
 	return fc->ac.error;
 }
-
-#if 0
-/*
- * Set a filesystem server cursor for using a specific FS server.
- */
-int afs_set_fs_cursor(struct afs_fs_cursor *fc, struct afs_vnode *vnode)
-{
-	afs_init_fs_cursor(fc, vnode);
-
-	read_seqlock_excl(&vnode->cb_lock);
-	if (vnode->cb_interest) {
-		if (vnode->cb_interest->server->fs_state == 0)
-			fc->server = afs_get_server(vnode->cb_interest->server);
-		else
-			fc->ac.error = vnode->cb_interest->server->fs_state;
-	} else {
-		fc->ac.error = -ESTALE;
-	}
-	read_sequnlock_excl(&vnode->cb_lock);
-
-	return fc->ac.error;
-}
-
-/*
- * pick a server to use to try accessing this volume
- * - returns with an elevated usage count on the server chosen
- */
-bool afs_volume_pick_fileserver(struct afs_fs_cursor *fc, struct afs_vnode *vnode)
-{
-	struct afs_volume *volume = vnode->volume;
-	struct afs_server *server;
-	int ret, state, loop;
-
-	_enter("%s", volume->vlocation->vldb.name);
-
-	/* stick with the server we're already using if we can */
-	if (vnode->cb_interest && vnode->cb_interest->server->fs_state == 0) {
-		fc->server = afs_get_server(vnode->cb_interest->server);
-		goto set_server;
-	}
-
-	down_read(&volume->server_sem);
-
-	/* handle the no-server case */
-	if (volume->nservers == 0) {
-		fc->ac.error = volume->rjservers ? -ENOMEDIUM : -ESTALE;
-		up_read(&volume->server_sem);
-		_leave(" = f [no servers %d]", fc->ac.error);
-		return false;
-	}
-
-	/* basically, just search the list for the first live server and use
-	 * that */
-	ret = 0;
-	for (loop = 0; loop < volume->nservers; loop++) {
-		server = volume->servers[loop];
-		state = server->fs_state;
-
-		_debug("consider %d [%d]", loop, state);
-
-		switch (state) {
-		case 0:
-			goto picked_server;
-
-		case -ENETUNREACH:
-			if (ret == 0)
-				ret = state;
-			break;
-
-		case -EHOSTUNREACH:
-			if (ret == 0 ||
-			    ret == -ENETUNREACH)
-				ret = state;
-			break;
-
-		case -ECONNREFUSED:
-			if (ret == 0 ||
-			    ret == -ENETUNREACH ||
-			    ret == -EHOSTUNREACH)
-				ret = state;
-			break;
-
-		default:
-		case -EREMOTEIO:
-			if (ret == 0 ||
-			    ret == -ENETUNREACH ||
-			    ret == -EHOSTUNREACH ||
-			    ret == -ECONNREFUSED)
-				ret = state;
-			break;
-		}
-	}
-
-error:
-	fc->ac.error = ret;
-
-	/* no available servers
-	 * - TODO: handle the no active servers case better
-	 */
-	up_read(&volume->server_sem);
-	_leave(" = f [%d]", fc->ac.error);
-	return false;
-
-picked_server:
-	/* Found an apparently healthy server.  We need to register an interest
-	 * in receiving callbacks before we talk to it.
-	 */
-	ret = afs_register_server_cb_interest(vnode,
-					      &volume->cb_interests[loop], server);
-	if (ret < 0)
-		goto error;
-
-	fc->server = afs_get_server(server);
-	up_read(&volume->server_sem);
-set_server:
-	fc->ac.alist = afs_get_addrlist(fc->server->addrs);
-	fc->ac.addr = &fc->ac.alist->addrs[0];
-	_debug("USING SERVER: %pIS\n", &fc->ac.addr->transport);
-	_leave(" = t (picked %pIS)", &fc->ac.addr->transport);
-	return true;
-}
-
-/*
- * release a server after use
- * - releases the ref on the server struct that was acquired by picking
- * - records result of using a particular server to access a volume
- * - return true to try again, false if okay or to issue error
- * - the caller must release the server struct if result was false
- */
-bool afs_iterate_fs_cursor(struct afs_fs_cursor *fc,
-			   struct afs_vnode *vnode)
-{
-	struct afs_volume *volume = vnode->volume;
-	struct afs_server *server = fc->server;
-	unsigned loop;
-
-	_enter("%s,%pIS,%d",
-	       volume->vlocation->vldb.name, &fc->ac.addr->transport,
-	       fc->ac.error);
-
-	switch (fc->ac.error) {
-		/* success */
-	case 0:
-		server->fs_state = 0;
-		_leave(" = f");
-		return false;
-
-		/* the fileserver denied all knowledge of the volume */
-	case -ENOMEDIUM:
-		down_write(&volume->server_sem);
-
-		/* firstly, find where the server is in the active list (if it
-		 * is) */
-		for (loop = 0; loop < volume->nservers; loop++)
-			if (volume->servers[loop] == server)
-				goto present;
-
-		/* no longer there - may have been discarded by another op */
-		goto try_next_server_upw;
-
-	present:
-		volume->nservers--;
-		memmove(&volume->servers[loop],
-			&volume->servers[loop + 1],
-			sizeof(volume->servers[loop]) *
-			(volume->nservers - loop));
-		volume->servers[volume->nservers] = NULL;
-		afs_put_server(afs_v2net(vnode), server);
-		volume->rjservers++;
-
-		if (volume->nservers > 0)
-			/* another server might acknowledge its existence */
-			goto try_next_server_upw;
-
-		/* handle the case where all the fileservers have rejected the
-		 * volume
-		 * - TODO: try asking the fileservers for volume information
-		 * - TODO: contact the VL server again to see if the volume is
-		 *         no longer registered
-		 */
-		up_write(&volume->server_sem);
-		afs_put_server(afs_v2net(vnode), server);
-		fc->server = NULL;
-		_leave(" = f [completely rejected]");
-		return false;
-
-		/* problem reaching the server */
-	case -ENETUNREACH:
-	case -EHOSTUNREACH:
-	case -ECONNREFUSED:
-	case -ETIME:
-	case -ETIMEDOUT:
-	case -EREMOTEIO:
-		/* mark the server as dead
-		 * TODO: vary dead timeout depending on error
-		 */
-		spin_lock(&server->fs_lock);
-		if (!server->fs_state) {
-			server->fs_state = fc->ac.error;
-			printk("kAFS: SERVER DEAD state=%d\n", fc->ac.error);
-		}
-		spin_unlock(&server->fs_lock);
-		goto try_next_server;
-
-		/* miscellaneous error */
-	default:
-	case -ENOMEM:
-	case -ENONET:
-		/* tell the caller to accept the result */
-		afs_put_server(afs_v2net(vnode), server);
-		fc->server = NULL;
-		_leave(" = f [local failure]");
-		return false;
-	}
-
-	/* tell the caller to loop around and try the next server */
-try_next_server_upw:
-	up_write(&volume->server_sem);
-try_next_server:
-	afs_put_server(afs_v2net(vnode), server);
-	_leave(" = t [try next server]");
-	return true;
-}
-
-/*
- * Clean up a fileserver cursor.
- */
-int afs_end_fs_cursor(struct afs_fs_cursor *fc, struct afs_net *net)
-{
-	afs_end_cursor(&fc->ac);
-	afs_put_server(net, fc->server);
-	return fc->ac.error;
-}
-
-#endif
