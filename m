Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26A0C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683DE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130812;
	bh=zypTq7TrXKBD/ZFT5L6raSxhy5ouApkzJXffRJ5er14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3uRc6ftvs9KCqs2CNls3GDVhUE6kj2oofqaa6HoaFk9AreHu9cwUM480i9+HQTHY
	 JZWC2bFQd06ikYGczwVny/6eMzgXqju6CARICxDxp2+RfBnacTDwhyuNg5lB8e4T0M
	 M3zTiCIvh/G748dDWtc405VwSjXrb2/xyl/BZhr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfBYVfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbfBYVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902E4217F5;
        Mon, 25 Feb 2019 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130510;
        bh=zypTq7TrXKBD/ZFT5L6raSxhy5ouApkzJXffRJ5er14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQcMUZXpAG6Q+jhuT5VHUt0ucG7Waw8V2Yx4cOxBmcinllE/+KzMST7XKFVnmw4qx
         MTyxOq2mxEqOPK6UPn60NcDIe/bY7uPx8mzrvks265PUkweEkZ3KlgaFr/y8bA2jmH
         J57SZISloEDthHCkI9CfhQGMZ/iFqNmEQRWhJfDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 105/183] afs: Fix race in async call refcounting
Date:   Mon, 25 Feb 2019 22:11:18 +0100
Message-Id: <20190225195112.384271892@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 34fa47612bfe5d7de7fcaf658a6952b6aeec3b13 ]

There's a race between afs_make_call() and afs_wake_up_async_call() in the
case that an error is returned from rxrpc_kernel_send_data() after it has
queued the final packet.

afs_make_call() will try and clean up the mess, but the call state may have
been moved on thereby causing afs_process_async_call() to also try and to
delete the call.

Fix this by:

 (1) Getting an extra ref for an asynchronous call for the call itself to
     hold.  This makes sure the call doesn't evaporate on us accidentally
     and will allow the call to be retained by the caller in a future
     patch.  The ref is released on leaving afs_make_call() or
     afs_wait_for_call_to_complete().

 (2) In the event of an error from rxrpc_kernel_send_data():

     (a) Don't set the call state to AFS_CALL_COMPLETE until *after* the
     	 call has been aborted and ended.  This prevents
     	 afs_deliver_to_call() from doing anything with any notifications
     	 it gets.

     (b) Explicitly end the call immediately to prevent further callbacks.

     (c) Cancel any queued async_work and wait for the work if it's
     	 executing.  This allows us to be sure the race won't recur when we
     	 change the state.  We put the work queue's ref on the call if we
     	 managed to cancel it.

     (d) Put the call's ref that we got in (1).  This belongs to us as long
     	 as the call is in state AFS_CALL_CL_REQUESTING.

Fixes: 341f741f04be ("afs: Refcount the afs_call struct")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c             | 35 ++++++++++++++++++++++++++++++-----
 include/trace/events/afs.h |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 4830e0a6bf1d1..2c588f9bbbda2 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -23,6 +23,7 @@ struct workqueue_struct *afs_async_calls;
 static void afs_wake_up_call_waiter(struct sock *, struct rxrpc_call *, unsigned long);
 static long afs_wait_for_call_to_complete(struct afs_call *, struct afs_addr_cursor *);
 static void afs_wake_up_async_call(struct sock *, struct rxrpc_call *, unsigned long);
+static void afs_delete_async_call(struct work_struct *);
 static void afs_process_async_call(struct work_struct *);
 static void afs_rx_new_call(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_rx_discard_new_call(struct rxrpc_call *, unsigned long);
@@ -404,6 +405,12 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 		}
 	}
 
+	/* If the call is going to be asynchronous, we need an extra ref for
+	 * the call to hold itself so the caller need not hang on to its ref.
+	 */
+	if (call->async)
+		afs_get_call(call, afs_call_trace_get);
+
 	/* create a call */
 	rxcall = rxrpc_kernel_begin_call(call->net->socket, srx, call->key,
 					 (unsigned long)call,
@@ -444,15 +451,17 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 			goto error_do_abort;
 	}
 
-	/* at this point, an async call may no longer exist as it may have
-	 * already completed */
-	if (call->async)
+	/* Note that at this point, we may have received the reply or an abort
+	 * - and an asynchronous call may already have completed.
+	 */
+	if (call->async) {
+		afs_put_call(call);
 		return -EINPROGRESS;
+	}
 
 	return afs_wait_for_call_to_complete(call, ac);
 
 error_do_abort:
-	call->state = AFS_CALL_COMPLETE;
 	if (ret != -ECONNABORTED) {
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret, "KSD");
@@ -469,8 +478,24 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 error_kill_call:
 	if (call->type->done)
 		call->type->done(call);
-	afs_put_call(call);
+
+	/* We need to dispose of the extra ref we grabbed for an async call.
+	 * The call, however, might be queued on afs_async_calls and we need to
+	 * make sure we don't get any more notifications that might requeue it.
+	 */
+	if (call->rxcall) {
+		rxrpc_kernel_end_call(call->net->socket, call->rxcall);
+		call->rxcall = NULL;
+	}
+	if (call->async) {
+		if (cancel_work_sync(&call->async_work))
+			afs_put_call(call);
+		afs_put_call(call);
+	}
+
 	ac->error = ret;
+	call->state = AFS_CALL_COMPLETE;
+	afs_put_call(call);
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 33d291888ba9c..e3f005eae1f76 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -25,6 +25,7 @@
 enum afs_call_trace {
 	afs_call_trace_alloc,
 	afs_call_trace_free,
+	afs_call_trace_get,
 	afs_call_trace_put,
 	afs_call_trace_wake,
 	afs_call_trace_work,
@@ -159,6 +160,7 @@ enum afs_file_error {
 #define afs_call_traces \
 	EM(afs_call_trace_alloc,		"ALLOC") \
 	EM(afs_call_trace_free,			"FREE ") \
+	EM(afs_call_trace_get,			"GET  ") \
 	EM(afs_call_trace_put,			"PUT  ") \
 	EM(afs_call_trace_wake,			"WAKE ") \
 	E_(afs_call_trace_work,			"WORK ")
-- 
2.19.1



