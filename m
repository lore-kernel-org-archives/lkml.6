Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22BEC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6927824FFB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6927824FFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbeFXPet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:34:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeFXPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:34:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB4A149F;
        Sun, 24 Jun 2018 15:34:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 10/64] net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload holds vlan
Date:   Sun, 24 Jun 2018 23:21:51 +0800
Message-Id: <20180624142744.282615804@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit fd3a88625844907151737fc3b4201676effa6d27 ]

Tun, tap, virtio, packet and uml vector all use struct virtio_net_hdr
to communicate packet metadata to userspace.

For skbuffs with vlan, the first two return the packet as it may have
existed on the wire, inserting the VLAN tag in the user buffer.  Then
virtio_net_hdr.csum_start needs to be adjusted by VLAN_HLEN bytes.

Commit f09e2249c4f5 ("macvtap: restore vlan header on user read")
added this feature to macvtap. Commit 3ce9b20f1971 ("macvtap: Fix
csum_start when VLAN tags are present") then fixed up csum_start.

Virtio, packet and uml do not insert the vlan header in the user
buffer.

When introducing virtio_net_hdr_from_skb to deduplicate filling in
the virtio_net_hdr, the variant from macvtap which adds VLAN_HLEN was
applied uniformly, breaking csum offset for packets with vlan on
virtio and packet.

Make insertion of VLAN_HLEN optional. Convert the callers to pass it
when needed.

Fixes: e858fae2b0b8f4 ("virtio_net: use common code for virtio_net_hdr and skb GSO conversion")
Fixes: 1276f24eeef2 ("packet: use common code for virtio_net_hdr and skb GSO conversion")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tap.c          |    5 ++++-
 drivers/net/tun.c          |    3 ++-
 drivers/net/virtio_net.c   |    3 ++-
 include/linux/virtio_net.h |   11 ++++-------
 net/packet/af_packet.c     |    4 ++--
 5 files changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -774,13 +774,16 @@ static ssize_t tap_put_user(struct tap_q
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
+		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 		struct virtio_net_hdr vnet_hdr;
+
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 		if (iov_iter_count(iter) < vnet_hdr_len)
 			return -EINVAL;
 
 		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q), true))
+					    tap_is_little_endian(q), true,
+					    vlan_hlen))
 			BUG();
 
 		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2062,7 +2062,8 @@ static ssize_t tun_put_user(struct tun_s
 			return -EINVAL;
 
 		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(tun), true)) {
+					    tun_is_little_endian(tun), true,
+					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
 			pr_err("unexpected GSO type: "
 			       "0x%x, gso_size %d, hdr_len %d\n",
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1358,7 +1358,8 @@ static int xmit_skb(struct send_queue *s
 		hdr = skb_vnet_hdr(skb);
 
 	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
-				    virtio_is_little_endian(vi->vdev), false))
+				    virtio_is_little_endian(vi->vdev), false,
+				    0))
 		BUG();
 
 	if (vi->mergeable_rx_bufs)
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -58,7 +58,8 @@ static inline int virtio_net_hdr_to_skb(
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
-					  bool has_data_valid)
+					  bool has_data_valid,
+					  int vlan_hlen)
 {
 	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
 
@@ -83,12 +84,8 @@ static inline int virtio_net_hdr_from_sk
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
-		if (skb_vlan_tag_present(skb))
-			hdr->csum_start = __cpu_to_virtio16(little_endian,
-				skb_checksum_start_offset(skb) + VLAN_HLEN);
-		else
-			hdr->csum_start = __cpu_to_virtio16(little_endian,
-				skb_checksum_start_offset(skb));
+		hdr->csum_start = __cpu_to_virtio16(little_endian,
+			skb_checksum_start_offset(skb) + vlan_hlen);
 		hdr->csum_offset = __cpu_to_virtio16(little_endian,
 				skb->csum_offset);
 	} else if (has_data_valid &&
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2037,7 +2037,7 @@ static int packet_rcv_vnet(struct msghdr
 		return -EINVAL;
 	*len -= sizeof(vnet_hdr);
 
-	if (virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true))
+	if (virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true, 0))
 		return -EINVAL;
 
 	return memcpy_to_msg(msg, (void *)&vnet_hdr, sizeof(vnet_hdr));
@@ -2304,7 +2304,7 @@ static int tpacket_rcv(struct sk_buff *s
 	if (do_vnet) {
 		if (virtio_net_hdr_from_skb(skb, h.raw + macoff -
 					    sizeof(struct virtio_net_hdr),
-					    vio_le(), true)) {
+					    vio_le(), true, 0)) {
 			spin_lock(&sk->sk_receive_queue.lock);
 			goto drop_n_account;
 		}


