Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938991AbeE1MwK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164447AbeE1Kzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 315/496] vlan: Fix vlan insertion for packets without ethernet header
Date: Mon, 28 May 2018 12:01:40 +0200
Message-Id: <20180528100333.104173363@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit c769accdf3d8a103940bea2979b65556718567e9 ]

In some situation vlan packets do not have ethernet headers. One example
is packets from tun devices. Users can specify vlan protocol in tun_pi
field instead of IP protocol. When we have a vlan device with reorder_hdr
disabled on top of the tun device, such packets from tun devices are
untagged in skb_vlan_untag() and vlan headers will be inserted back in
vlan_insert_inner_tag().

vlan_insert_inner_tag() however did not expect packets without ethernet
headers, so in such a case size argument for memmove() underflowed.

We don't need to copy headers for packets which do not have preceding
headers of vlan headers, so skip memmove() in that case.
Also don't write vlan protocol in skb->data when it does not have enough
room for it.

Fixes: cbe7128c4b92 ("vlan: Fix out of order vlan headers with reorder header off")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/if_vlan.h |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -323,13 +323,24 @@ static inline int __vlan_insert_inner_ta
 	skb_push(skb, VLAN_HLEN);
 
 	/* Move the mac header sans proto to the beginning of the new header. */
-	memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
+	if (likely(mac_len > ETH_TLEN))
+		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
 	skb->mac_header -= VLAN_HLEN;
 
 	veth = (struct vlan_ethhdr *)(skb->data + mac_len - ETH_HLEN);
 
 	/* first, the ethernet type */
-	veth->h_vlan_proto = vlan_proto;
+	if (likely(mac_len >= ETH_TLEN)) {
+		/* h_vlan_encapsulated_proto should already be populated, and
+		 * skb->data has space for h_vlan_proto
+		 */
+		veth->h_vlan_proto = vlan_proto;
+	} else {
+		/* h_vlan_encapsulated_proto should not be populated, and
+		 * skb->data has no space for h_vlan_proto
+		 */
+		veth->h_vlan_encapsulated_proto = skb->protocol;
+	}
 
 	/* now, the TCI */
 	veth->h_vlan_TCI = htons(vlan_tci);
