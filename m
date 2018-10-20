Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A1EECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7241C214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7241C214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJTJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 905CAA6DE0;
        Sat, 20 Oct 2018 01:11:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4407B6252D;
        Sat, 20 Oct 2018 01:11:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/24] afs: Improve FS server rotation error handling
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:11:21 +0100
Message-ID: <153999788143.866.18124839695968387766.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 20 Oct 2018 01:11:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the error handling in FS server rotation by:

 (1) Cache the latest useful error value for the fs operation as a whole in
     struct afs_fs_cursor separately from the error cached in the
     afs_addr_cursor struct.  The one in the address cursor gets clobbered
     occasionally.  Copy over the error to the fs operation only when it's
     something we'd be interested in passing to userspace.

 (2) Make it so that EDESTADDRREQ is the default that is seen only if no
     addresses are available to be accessed.

 (3) When calling utility functions, such as checking a volume status or
     probing a fileserver, don't let a successful result clobber the cached
     error in the cursor; instead, stash the result in a temporary variable
     until it has been assessed.

 (4) Don't return ETIMEDOUT or ETIME if a better error, such as
     ENETUNREACH, is already cached.

 (5) On leaving the rotation loop, turn any remote abort code into a more
     useful error than ECONNABORTED.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |    4 +-
 fs/afs/internal.h  |    1 +
 fs/afs/rotate.c    |   95 +++++++++++++++++++++++++++++-----------------------
 3 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 55a756c60746..7b34fad4f8f5 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -318,10 +318,8 @@ bool afs_iterate_addresses(struct afs_addr_cursor *ac)
 		if (ac->index == ac->alist->nr_addrs)
 			ac->index = 0;
 
-		if (ac->index == ac->start) {
-			ac->error = -EDESTADDRREQ;
+		if (ac->index == ac->start)
 			return false;
-		}
 	}
 
 	ac->begun = true;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 36e9cc74ac11..81936a4d5035 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -629,6 +629,7 @@ struct afs_fs_cursor {
 	unsigned int		cb_break_2;	/* cb_break + cb_s_break (2nd vnode) */
 	unsigned char		start;		/* Initial index in server list */
 	unsigned char		index;		/* Number of servers tried beyond start */
+	short			error;
 	unsigned short		flags;
 #define AFS_FS_CURSOR_STOP	0x0001		/* Set to cease iteration */
 #define AFS_FS_CURSOR_VBUSY	0x0002		/* Set if seen VBUSY */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 1faef56b12bd..d7cbc3c230ee 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -39,9 +39,10 @@ bool afs_begin_vnode_operation(struct afs_fs_cursor *fc, struct afs_vnode *vnode
 	fc->vnode = vnode;
 	fc->key = key;
 	fc->ac.error = SHRT_MAX;
+	fc->error = -EDESTADDRREQ;
 
 	if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
-		fc->ac.error = -EINTR;
+		fc->error = -EINTR;
 		fc->flags |= AFS_FS_CURSOR_STOP;
 		return false;
 	}
@@ -80,7 +81,7 @@ static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
 		 * and have to return an error.
 		 */
 		if (fc->flags & AFS_FS_CURSOR_CUR_ONLY) {
-			fc->ac.error = -ESTALE;
+			fc->error = -ESTALE;
 			return false;
 		}
 
@@ -127,7 +128,7 @@ static bool afs_sleep_and_retry(struct afs_fs_cursor *fc)
 {
 	msleep_interruptible(1000);
 	if (signal_pending(current)) {
-		fc->ac.error = -ERESTARTSYS;
+		fc->error = -ERESTARTSYS;
 		return false;
 	}
 
@@ -143,11 +144,12 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct afs_vnode *vnode = fc->vnode;
+	int error = fc->ac.error;
 
 	_enter("%u/%u,%u/%u,%d,%d",
 	       fc->index, fc->start,
 	       fc->ac.index, fc->ac.start,
-	       fc->ac.error, fc->ac.abort_code);
+	       error, fc->ac.abort_code);
 
 	if (fc->flags & AFS_FS_CURSOR_STOP) {
 		_leave(" = f [stopped]");
@@ -155,15 +157,16 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	}
 
 	/* Evaluate the result of the previous operation, if there was one. */
-	switch (fc->ac.error) {
+	switch (error) {
 	case SHRT_MAX:
 		goto start;
 
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */
+		fc->error = error;
 		fc->flags |= AFS_FS_CURSOR_STOP;
-		_leave(" = f [okay/local %d]", fc->ac.error);
+		_leave(" = f [okay/local %d]", error);
 		return false;
 
 	case -ECONNABORTED:
@@ -178,7 +181,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 * - May indicate that the fileserver couldn't attach to the vol.
 			 */
 			if (fc->flags & AFS_FS_CURSOR_VNOVOL) {
-				fc->ac.error = -EREMOTEIO;
+				fc->error = -EREMOTEIO;
 				goto next_server;
 			}
 
@@ -187,12 +190,12 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			write_unlock(&vnode->volume->servers_lock);
 
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &vnode->volume->flags);
-			fc->ac.error = afs_check_volume_status(vnode->volume, fc->key);
-			if (fc->ac.error < 0)
-				goto failed;
+			error = afs_check_volume_status(vnode->volume, fc->key);
+			if (error < 0)
+				goto failed_set_error;
 
 			if (test_bit(AFS_VOLUME_DELETED, &vnode->volume->flags)) {
-				fc->ac.error = -ENOMEDIUM;
+				fc->error = -ENOMEDIUM;
 				goto failed;
 			}
 
@@ -200,7 +203,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 * it's the fileserver having trouble.
 			 */
 			if (vnode->volume->servers == fc->server_list) {
-				fc->ac.error = -EREMOTEIO;
+				fc->error = -EREMOTEIO;
 				goto next_server;
 			}
 
@@ -215,7 +218,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		case VONLINE:
 		case VDISKFULL:
 		case VOVERQUOTA:
-			fc->ac.error = afs_abort_to_error(fc->ac.abort_code);
+			fc->error = afs_abort_to_error(fc->ac.abort_code);
 			goto next_server;
 
 		case VOFFLINE:
@@ -224,11 +227,11 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 				clear_bit(AFS_VOLUME_BUSY, &vnode->volume->flags);
 			}
 			if (fc->flags & AFS_FS_CURSOR_NO_VSLEEP) {
-				fc->ac.error = -EADV;
+				fc->error = -EADV;
 				goto failed;
 			}
 			if (fc->flags & AFS_FS_CURSOR_CUR_ONLY) {
-				fc->ac.error = -ESTALE;
+				fc->error = -ESTALE;
 				goto failed;
 			}
 			goto busy;
@@ -240,7 +243,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 * have a file lock we need to maintain.
 			 */
 			if (fc->flags & AFS_FS_CURSOR_NO_VSLEEP) {
-				fc->ac.error = -EBUSY;
+				fc->error = -EBUSY;
 				goto failed;
 			}
 			if (!test_and_set_bit(AFS_VOLUME_BUSY, &vnode->volume->flags)) {
@@ -269,16 +272,16 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 * honour, just in case someone sets up a loop.
 			 */
 			if (fc->flags & AFS_FS_CURSOR_VMOVED) {
-				fc->ac.error = -EREMOTEIO;
+				fc->error = -EREMOTEIO;
 				goto failed;
 			}
 			fc->flags |= AFS_FS_CURSOR_VMOVED;
 
 			set_bit(AFS_VOLUME_WAIT, &vnode->volume->flags);
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &vnode->volume->flags);
-			fc->ac.error = afs_check_volume_status(vnode->volume, fc->key);
-			if (fc->ac.error < 0)
-				goto failed;
+			error = afs_check_volume_status(vnode->volume, fc->key);
+			if (error < 0)
+				goto failed_set_error;
 
 			/* If the server list didn't change, then the VLDB is
 			 * out of sync with the fileservers.  This is hopefully
@@ -290,7 +293,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 * TODO: Retry a few times with sleeps.
 			 */
 			if (vnode->volume->servers == fc->server_list) {
-				fc->ac.error = -ENOMEDIUM;
+				fc->error = -ENOMEDIUM;
 				goto failed;
 			}
 
@@ -299,20 +302,25 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		default:
 			clear_bit(AFS_VOLUME_OFFLINE, &vnode->volume->flags);
 			clear_bit(AFS_VOLUME_BUSY, &vnode->volume->flags);
-			fc->ac.error = afs_abort_to_error(fc->ac.abort_code);
+			fc->error = afs_abort_to_error(fc->ac.abort_code);
 			goto failed;
 		}
 
+	case -ETIMEDOUT:
+	case -ETIME:
+		if (fc->error != -EDESTADDRREQ)
+			goto iterate_address;
+		/* Fall through */
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
 	case -ECONNREFUSED:
-	case -ETIMEDOUT:
-	case -ETIME:
 		_debug("no conn");
+		fc->error = error;
 		goto iterate_address;
 
 	case -ECONNRESET:
 		_debug("call reset");
+		fc->error = error;
 		goto failed;
 	}
 
@@ -328,9 +336,9 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	/* See if we need to do an update of the volume record.  Note that the
 	 * volume may have moved or even have been deleted.
 	 */
-	fc->ac.error = afs_check_volume_status(vnode->volume, fc->key);
-	if (fc->ac.error < 0)
-		goto failed;
+	error = afs_check_volume_status(vnode->volume, fc->key);
+	if (error < 0)
+		goto failed_set_error;
 
 	if (!afs_start_fs_iteration(fc, vnode))
 		goto failed;
@@ -354,10 +362,10 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	 * break request before we've finished decoding the reply and
 	 * installing the vnode.
 	 */
-	fc->ac.error = afs_register_server_cb_interest(vnode, fc->server_list,
-						       fc->index);
-	if (fc->ac.error < 0)
-		goto failed;
+	error = afs_register_server_cb_interest(vnode, fc->server_list,
+						fc->index);
+	if (error < 0)
+		goto failed_set_error;
 
 	fc->cbi = afs_get_cb_interest(vnode->cb_interest);
 
@@ -422,13 +430,14 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	if (fc->flags & AFS_FS_CURSOR_VBUSY)
 		goto restart_from_beginning;
 
-	fc->ac.error = -EDESTADDRREQ;
 	goto failed;
 
+failed_set_error:
+	fc->error = error;
 failed:
 	fc->flags |= AFS_FS_CURSOR_STOP;
 	afs_end_cursor(&fc->ac);
-	_leave(" = f [failed %d]", fc->ac.error);
+	_leave(" = f [failed %d]", fc->error);
 	return false;
 }
 
@@ -442,13 +451,14 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_cb_interest *cbi = vnode->cb_interest;
 	struct afs_addr_list *alist;
+	int error = fc->ac.error;
 
 	_enter("");
 
-	switch (fc->ac.error) {
+	switch (error) {
 	case SHRT_MAX:
 		if (!cbi) {
-			fc->ac.error = -ESTALE;
+			fc->error = -ESTALE;
 			fc->flags |= AFS_FS_CURSOR_STOP;
 			return false;
 		}
@@ -461,7 +471,7 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 		afs_get_addrlist(alist);
 		read_unlock(&cbi->server->fs_lock);
 		if (!alist) {
-			fc->ac.error = -ESTALE;
+			fc->error = -ESTALE;
 			fc->flags |= AFS_FS_CURSOR_STOP;
 			return false;
 		}
@@ -475,11 +485,13 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */
+		fc->error = error;
 		fc->flags |= AFS_FS_CURSOR_STOP;
-		_leave(" = f [okay/local %d]", fc->ac.error);
+		_leave(" = f [okay/local %d]", error);
 		return false;
 
 	case -ECONNABORTED:
+		fc->error = afs_abort_to_error(fc->ac.abort_code);
 		fc->flags |= AFS_FS_CURSOR_STOP;
 		_leave(" = f [abort]");
 		return false;
@@ -490,6 +502,7 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	case -ETIMEDOUT:
 	case -ETIME:
 		_debug("no conn");
+		fc->error = error;
 		goto iterate_address;
 	}
 
@@ -512,7 +525,6 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 {
 	struct afs_net *net = afs_v2net(fc->vnode);
-	int ret;
 
 	mutex_unlock(&fc->vnode->io_lock);
 
@@ -520,9 +532,8 @@ int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 	afs_put_cb_interest(net, fc->cbi);
 	afs_put_serverlist(net, fc->server_list);
 
-	ret = fc->ac.error;
-	if (ret == -ECONNABORTED)
-		afs_abort_to_error(fc->ac.abort_code);
+	if (fc->error == -ECONNABORTED)
+		fc->error = afs_abort_to_error(fc->ac.abort_code);
 
-	return fc->ac.error;
+	return fc->error;
 }

