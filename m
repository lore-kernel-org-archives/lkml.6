Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B2C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4F2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfBCO02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:26:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55610 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbfBCOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:56 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdi-0006N3-9n; Sun, 03 Feb 2019 14:20:54 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9u-0007RH-4A; Sun, 03 Feb 2019 14:50:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jorgen Hansen" <jhansen@vmware.com>,
        "Vishnu Dasa" <vdasa@vmware.com>,
        "Adit Ranadive" <aditr@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.508144320@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 290/305] VSOCK: Send reset control packet when socket
 is partially bound
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jorgen Hansen <jhansen@vmware.com>

commit a915b982d8f5e4295f64b8dd37ce753874867e88 upstream.

If a server side socket is bound to an address, but not in the listening
state yet, incoming connection requests should receive a reset control
packet in response. However, the function used to send the reset
silently drops the reset packet if the sending socket isn't bound
to a remote address (as is the case for a bound socket not yet in
the listening state). This change fixes this by using the src
of the incoming packet as destination for the reset packet in
this case.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/vmw_vsock/vmci_transport.c | 67 +++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 17 deletions(-)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -275,6 +275,31 @@ vmci_transport_send_control_pkt_bh(struc
 }
 
 static int
+vmci_transport_alloc_send_control_pkt(struct sockaddr_vm *src,
+				      struct sockaddr_vm *dst,
+				      enum vmci_transport_packet_type type,
+				      u64 size,
+				      u64 mode,
+				      struct vmci_transport_waiting_info *wait,
+				      u16 proto,
+				      struct vmci_handle handle)
+{
+	struct vmci_transport_packet *pkt;
+	int err;
+
+	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	err = __vmci_transport_send_control_pkt(pkt, src, dst, type, size,
+						mode, wait, proto, handle,
+						true);
+	kfree(pkt);
+
+	return err;
+}
+
+static int
 vmci_transport_send_control_pkt(struct sock *sk,
 				enum vmci_transport_packet_type type,
 				u64 size,
@@ -283,9 +308,7 @@ vmci_transport_send_control_pkt(struct s
 				u16 proto,
 				struct vmci_handle handle)
 {
-	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
-	int err;
 
 	vsk = vsock_sk(sk);
 
@@ -295,17 +318,10 @@ vmci_transport_send_control_pkt(struct s
 	if (!vsock_addr_bound(&vsk->remote_addr))
 		return -EINVAL;
 
-	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return -ENOMEM;
-
-	err = __vmci_transport_send_control_pkt(pkt, &vsk->local_addr,
-						&vsk->remote_addr, type, size,
-						mode, wait, proto, handle,
-						true);
-	kfree(pkt);
-
-	return err;
+	return vmci_transport_alloc_send_control_pkt(&vsk->local_addr,
+						     &vsk->remote_addr,
+						     type, size, mode,
+						     wait, proto, handle);
 }
 
 static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
@@ -323,12 +339,29 @@ static int vmci_transport_send_reset_bh(
 static int vmci_transport_send_reset(struct sock *sk,
 				     struct vmci_transport_packet *pkt)
 {
+	struct sockaddr_vm *dst_ptr;
+	struct sockaddr_vm dst;
+	struct vsock_sock *vsk;
+
 	if (pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST)
 		return 0;
-	return vmci_transport_send_control_pkt(sk,
-					VMCI_TRANSPORT_PACKET_TYPE_RST,
-					0, 0, NULL, VSOCK_PROTO_INVALID,
-					VMCI_INVALID_HANDLE);
+
+	vsk = vsock_sk(sk);
+
+	if (!vsock_addr_bound(&vsk->local_addr))
+		return -EINVAL;
+
+	if (vsock_addr_bound(&vsk->remote_addr)) {
+		dst_ptr = &vsk->remote_addr;
+	} else {
+		vsock_addr_init(&dst, pkt->dg.src.context,
+				pkt->src_port);
+		dst_ptr = &dst;
+	}
+	return vmci_transport_alloc_send_control_pkt(&vsk->local_addr, dst_ptr,
+					     VMCI_TRANSPORT_PACKET_TYPE_RST,
+					     0, 0, NULL, VSOCK_PROTO_INVALID,
+					     VMCI_INVALID_HANDLE);
 }
 
 static int vmci_transport_send_negotiate(struct sock *sk, size_t size)

