Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0653C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830322088F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830322088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeHUJnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4380516;
        Tue, 21 Aug 2018 06:24:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8a9b1bd330476a4f3db6@syzkaller.appspotmail.com,
        Andy king <acking@vmware.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 05/42] vsock: split dwork to avoid reinitializations
Date:   Tue, 21 Aug 2018 08:20:37 +0200
Message-Id: <20180821055017.825559982@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 455f05ecd2b219e9a216050796d30c830d9bc393 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/af_vsock.h         |    4 ++--
 net/vmw_vsock/af_vsock.c       |   15 ++++++++-------
 net/vmw_vsock/vmci_transport.c |    3 +--
 3 files changed, 11 insertions(+), 11 deletions(-)

--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -64,7 +64,8 @@ struct vsock_sock {
 	struct list_head pending_links;
 	struct list_head accept_queue;
 	bool rejected;
-	struct delayed_work dwork;
+	struct delayed_work connect_work;
+	struct delayed_work pending_work;
 	struct delayed_work close_work;
 	bool close_work_scheduled;
 	u32 peer_shutdown;
@@ -77,7 +78,6 @@ struct vsock_sock {
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
-void vsock_pending_work(struct work_struct *work);
 struct sock *__vsock_create(struct net *net,
 			    struct socket *sock,
 			    struct sock *parent,
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -451,14 +451,14 @@ static int vsock_send_shutdown(struct so
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
@@ -498,7 +498,6 @@ out:
 	sock_put(sk);
 	sock_put(listener);
 }
-EXPORT_SYMBOL_GPL(vsock_pending_work);
 
 /**** SOCKET OPERATIONS ****/
 
@@ -597,6 +596,8 @@ static int __vsock_bind(struct sock *sk,
 	return retval;
 }
 
+static void vsock_connect_timeout(struct work_struct *work);
+
 struct sock *__vsock_create(struct net *net,
 			    struct socket *sock,
 			    struct sock *parent,
@@ -638,6 +639,8 @@ struct sock *__vsock_create(struct net *
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
 	vsk->peer_shutdown = 0;
+	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
+	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
 
 	psk = parent ? vsock_sk(parent) : NULL;
 	if (parent) {
@@ -1117,7 +1120,7 @@ static void vsock_connect_timeout(struct
 	struct vsock_sock *vsk;
 	int cancel = 0;
 
-	vsk = container_of(work, struct vsock_sock, dwork.work);
+	vsk = container_of(work, struct vsock_sock, connect_work.work);
 	sk = sk_vsock(vsk);
 
 	lock_sock(sk);
@@ -1221,9 +1224,7 @@ static int vsock_stream_connect(struct s
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
@@ -1094,8 +1094,7 @@ static int vmci_transport_recv_listen(st
 	vpending->listener = sk;
 	sock_hold(sk);
 	sock_hold(pending);
-	INIT_DELAYED_WORK(&vpending->dwork, vsock_pending_work);
-	schedule_delayed_work(&vpending->dwork, HZ);
+	schedule_delayed_work(&vpending->pending_work, HZ);
 
 out:
 	return err;


