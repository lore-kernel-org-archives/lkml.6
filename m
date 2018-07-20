Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FBC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FBC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390017AbeGTNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:30:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbeGTNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:30:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61DE2C96;
        Fri, 20 Jul 2018 12:37:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 045/101] VSOCK: fix loopback on big-endian systems
Date:   Fri, 20 Jul 2018 14:13:51 +0200
Message-Id: <20180720121424.921886139@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

[ Upstream commit e5ab564c9ebee77794842ca7d7476147b83d6a27 ]

The dst_cid and src_cid are 64 bits, therefore 64 bit accessors should be
used, and in fact in virtio_transport_common.c only 64 bit accessors are
used. Using 32 bit accessors for 64 bit values breaks big endian systems.

This patch fixes a wrong use of le32_to_cpu in virtio_transport_send_pkt.

Fixes: b9116823189e85ccf384 ("VSOCK: add loopback to virtio_transport")

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -201,7 +201,7 @@ virtio_transport_send_pkt(struct virtio_
 		return -ENODEV;
 	}
 
-	if (le32_to_cpu(pkt->hdr.dst_cid) == vsock->guest_cid)
+	if (le64_to_cpu(pkt->hdr.dst_cid) == vsock->guest_cid)
 		return virtio_transport_send_pkt_loopback(vsock, pkt);
 
 	if (pkt->reply)


