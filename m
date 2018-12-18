Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AB1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeLRItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:49:09 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:31915 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbeLRItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:49:08 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 03:49:08 EST
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 18 Dec 2018 00:34:03 -0800
Received: from pa-dbc1104.eng.vmware.com (pa-dbc1104.eng.vmware.com [10.162.210.4])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1E43D41104;
        Tue, 18 Dec 2018 00:34:06 -0800 (PST)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <davem@davemloft.net>,
        <pv-drivers@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH v2] VSOCK: Send reset control packet when socket is partially bound
Date:   Tue, 18 Dec 2018 00:34:06 -0800
Message-ID: <1545122046-43955-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

v1 -> v2:
- Changed order of local variables

 net/vmw_vsock/vmci_transport.c | 67 +++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 0ae3614..5cf8935 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -264,6 +264,31 @@ vmci_transport_send_control_pkt_bh(struct sockaddr_vm *src,
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
@@ -272,9 +297,7 @@ vmci_transport_send_control_pkt(struct sock *sk,
 				u16 proto,
 				struct vmci_handle handle)
 {
-	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
-	int err;
 
 	vsk = vsock_sk(sk);
 
@@ -284,17 +307,10 @@ vmci_transport_send_control_pkt(struct sock *sk,
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
@@ -312,12 +328,29 @@ static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
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
-- 
2.6.2

