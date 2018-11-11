Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6647C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AF920818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AF920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbeKLGWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50144 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730271AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000l4-EF; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pG-6C; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jorgen Hansen" <jhansen@vmware.com>,
        "" <syzbot+8a9b1bd330476a4f3db6@syzkaller.appspotmail.com>,
        "Andy king" <acking@vmware.com>,
        "Stefan Hajnoczi" <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Cong Wang" <xiyou.wangcong@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.846596785@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 313/366] vsock: split dwork to avoid reinitializations
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 455f05ecd2b219e9a216050796d30c830d9bc393 upstream.

syzbot reported that we reinitialize an active delayed
work in vsock_stream_connect():

	ODEBUG: init active (active state 0) object type: timer_list hint:
	delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:1414
	WARNING: CPU: 1 PID: 11518 at lib/debugobjects.c:329
	debug_print_object+0x16a/0x210 lib/debugobjects.c:326

The pattern is apparently wrong, we should only initialize
the dealyed work once and could repeatly schedule it. So we
have to move out the initializations to allocation side.
And to avoid confusion, we can split the shared dwork
into two, instead of re-using the same one.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: <syzbot+8a9b1bd330476a4f3db6@syzkaller.appspotmail.com>
Cc: Andy king <acking@vmware.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/af_vsock.h         |  4 ++--
 net/vmw_vsock/af_vsock.c       | 15 ++++++++-------
 net/vmw_vsock/vmci_transport.c |  3 +--
 3 files changed, 11 insertions(+), 11 deletions(-)

--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -59,7 +59,8 @@ struct vsock_sock {
 	struct list_head pending_links;
 	struct list_head accept_queue;
 	bool rejected;
-	struct delayed_work dwork;
+	struct delayed_work connect_work;
+	struct delayed_work pending_work;
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
@@ -70,7 +71,6 @@ struct vsock_sock {
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
-void vsock_pending_work(struct work_struct *work);
 struct sock *__vsock_create(struct net *net,
 			    struct socket *sock,
 			    struct sock *parent,
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -431,14 +431,14 @@ static int vsock_send_shutdown(struct so
 	return transport->shutdown(vsock_sk(sk), mode);
 }
 
-void vsock_pending_work(struct work_struct *work)
+static void vsock_pending_work(struct work_struct *work)
 {
 	struct sock *sk;
 	struct sock *listener;
 	struct vsock_sock *vsk;
 	bool cleanup;
 
-	vsk = container_of(work, struct vsock_sock, dwork.work);
+	vsk = container_of(work, struct vsock_sock, pending_work.work);
 	sk = sk_vsock(vsk);
 	listener = vsk->listener;
 	cleanup = true;
@@ -478,7 +478,6 @@ out:
 	sock_put(sk);
 	sock_put(listener);
 }
-EXPORT_SYMBOL_GPL(vsock_pending_work);
 
 /**** SOCKET OPERATIONS ****/
 
@@ -577,6 +576,8 @@ static int __vsock_bind(struct sock *sk,
 	return retval;
 }
 
+static void vsock_connect_timeout(struct work_struct *work);
+
 struct sock *__vsock_create(struct net *net,
 			    struct socket *sock,
 			    struct sock *parent,
@@ -618,6 +619,8 @@ struct sock *__vsock_create(struct net *
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
 	vsk->peer_shutdown = 0;
+	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
+	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
 
 	psk = parent ? vsock_sk(parent) : NULL;
 	if (parent) {
@@ -1095,7 +1098,7 @@ static void vsock_connect_timeout(struct
 	struct sock *sk;
 	struct vsock_sock *vsk;
 
-	vsk = container_of(work, struct vsock_sock, dwork.work);
+	vsk = container_of(work, struct vsock_sock, connect_work.work);
 	sk = sk_vsock(vsk);
 
 	lock_sock(sk);
@@ -1196,9 +1199,7 @@ static int vsock_stream_connect(struct s
 			 * timeout fires.
 			 */
 			sock_hold(sk);
-			INIT_DELAYED_WORK(&vsk->dwork,
-					  vsock_connect_timeout);
-			schedule_delayed_work(&vsk->dwork, timeout);
+			schedule_delayed_work(&vsk->connect_work, timeout);
 
 			/* Skip ahead to preserve error code set above. */
 			goto out_wait;
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1101,8 +1101,7 @@ static int vmci_transport_recv_listen(st
 	vpending->listener = sk;
 	sock_hold(sk);
 	sock_hold(pending);
-	INIT_DELAYED_WORK(&vpending->dwork, vsock_pending_work);
-	schedule_delayed_work(&vpending->dwork, HZ);
+	schedule_delayed_work(&vpending->pending_work, HZ);
 
 out:
 	return err;

