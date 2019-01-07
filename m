Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F57C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026BA217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866046;
	bh=AQf9W1ipM8DhB5Vm0utMkTnZlww5C3IHpDfX70Y3MGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNrqi8d0xvng7r0jQv83FPJihPL/4zs7W1MOAlBDjJeo/j1nPN8bcFDQCpY3G+HSB
	 Wkb18IBjAz4sLrHvNYyfFlUAp7XQUk8oiHWE5oedRD6UuKJtEnwERcTRg1sZRvHrxs
	 bsgTj+0fXHYF62V5S4hrgW60rcmrlwmzqpLmWEWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfAGNAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbfAGNAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E32CF2089F;
        Mon,  7 Jan 2019 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866039;
        bh=AQf9W1ipM8DhB5Vm0utMkTnZlww5C3IHpDfX70Y3MGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxW4Fjk3Xpolyk2rRFpH6rtqqh+72kemWjreYabVo5OEEfO4kby3kZSkdsV19y/Tt
         4q4jKzflGV6GfSru+t0LxKZOrdKWLpsl7yAKujq15k6clk2VBPmMReEezs6VENwMtw
         1Yx1ZRLt25qMUJAcchp1dLwaLgZYbrSZiWTR7I6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adit Ranadive <aditr@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 025/101] VSOCK: Send reset control packet when socket is partially bound
Date:   Mon,  7 Jan 2019 13:32:13 +0100
Message-Id: <20190107105334.305474407@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jorgen Hansen <jhansen@vmware.com>

[ Upstream commit a915b982d8f5e4295f64b8dd37ce753874867e88 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/vmci_transport.c |   67 ++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 17 deletions(-)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -265,6 +265,31 @@ vmci_transport_send_control_pkt_bh(struc
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
@@ -273,9 +298,7 @@ vmci_transport_send_control_pkt(struct s
 				u16 proto,
 				struct vmci_handle handle)
 {
-	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
-	int err;
 
 	vsk = vsock_sk(sk);
 
@@ -285,17 +308,10 @@ vmci_transport_send_control_pkt(struct s
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
@@ -313,12 +329,29 @@ static int vmci_transport_send_reset_bh(
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


