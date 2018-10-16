Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C7AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ACB2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJg4guWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ACB2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJQBDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB402098A;
        Tue, 16 Oct 2018 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709903;
        bh=sq7o5lKFdorBXv09dH4SpoSm+AniY+F0y7JJ6nvf+yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJg4guWze9cdnnO2+KDSCLecFYJq2kViyJE/ucJtNUNnEoncwPv7+ugidmoah7xye
         ZE8pvJ2bDTi4a7c4cH51vaQ03g8Di0YpctK4FgRzTPbHGiMSXWUKIZmw31uuRrMRev
         PHgi6iVsTbf8h0ko2UvYjdSzTtrq44R8+PzQzwIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jianfeng Tan <jianfeng.tan@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 034/135] net/packet: fix packet drop as of virtio gso
Date:   Tue, 16 Oct 2018 19:04:24 +0200
Message-Id: <20181016170517.343252259@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianfeng Tan <jianfeng.tan@linux.alibaba.com>

[ Upstream commit 9d2f67e43b73e8af7438be219b66a5de0cfa8bd9 ]

When we use raw socket as the vhost backend, a packet from virito with
gso offloading information, cannot be sent out in later validaton at
xmit path, as we did not set correct skb->protocol which is further used
for looking up the gso function.

To fix this, we set this field according to virito hdr information.

Fixes: e858fae2b0b8f4 ("virtio_net: use common code for virtio_net_hdr and skb GSO conversion")
Signed-off-by: Jianfeng Tan <jianfeng.tan@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/virtio_net.h |   18 ++++++++++++++++++
 net/packet/af_packet.c     |   11 +++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -5,6 +5,24 @@
 #include <linux/if_vlan.h>
 #include <uapi/linux/virtio_net.h>
 
+static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
+					   const struct virtio_net_hdr *hdr)
+{
+	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	case VIRTIO_NET_HDR_GSO_TCPV4:
+	case VIRTIO_NET_HDR_GSO_UDP:
+		skb->protocol = cpu_to_be16(ETH_P_IP);
+		break;
+	case VIRTIO_NET_HDR_GSO_TCPV6:
+		skb->protocol = cpu_to_be16(ETH_P_IPV6);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
 					bool little_endian)
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2712,10 +2712,12 @@ tpacket_error:
 			}
 		}
 
-		if (po->has_vnet_hdr && virtio_net_hdr_to_skb(skb, vnet_hdr,
-							      vio_le())) {
-			tp_len = -EINVAL;
-			goto tpacket_error;
+		if (po->has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+				tp_len = -EINVAL;
+				goto tpacket_error;
+			}
+			virtio_net_hdr_set_proto(skb, vnet_hdr);
 		}
 
 		skb->destructor = tpacket_destruct_skb;
@@ -2911,6 +2913,7 @@ static int packet_snd(struct socket *soc
 		if (err)
 			goto out_free;
 		len += sizeof(vnet_hdr);
+		virtio_net_hdr_set_proto(skb, &vnet_hdr);
 	}
 
 	skb_probe_transport_header(skb, reserve);


