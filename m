Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165139AbeE1NET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164043AbeE1Kwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 259/496] vlan: Fix out of order vlan headers with reorder header off
Date: Mon, 28 May 2018 12:00:44 +0200
Message-Id: <20180528100330.785067771@linuxfoundation.org>
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

[ Upstream commit cbe7128c4b92e2004984f477fd38dfa81662f02e ]

With reorder header off, received packets are untagged in skb_vlan_untag()
called from within __netif_receive_skb_core(), and later the tag will be
inserted back in vlan_do_receive().

This caused out of order vlan headers when we create a vlan device on top
of another vlan device, because vlan_do_receive() inserts a tag as the
outermost vlan tag. E.g. the outer tag is first removed in skb_vlan_untag()
and inserted back in vlan_do_receive(), then the inner tag is next removed
and inserted back as the outermost tag.

This patch fixes the behaviour by inserting the inner tag at the right
position.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/if_vlan.h |   66 ++++++++++++++++++++++++++++++++++++++++--------
 net/8021q/vlan_core.c   |    4 +-
 2 files changed, 57 insertions(+), 13 deletions(-)

--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -300,30 +300,34 @@ static inline bool vlan_hw_offload_capab
 }
 
 /**
- * __vlan_insert_tag - regular VLAN tag inserting
+ * __vlan_insert_inner_tag - inner VLAN tag inserting
  * @skb: skbuff to tag
  * @vlan_proto: VLAN encapsulation protocol
  * @vlan_tci: VLAN TCI to insert
+ * @mac_len: MAC header length including outer vlan headers
  *
- * Inserts the VLAN tag into @skb as part of the payload
+ * Inserts the VLAN tag into @skb as part of the payload at offset mac_len
  * Returns error if skb_cow_head failes.
  *
  * Does not change skb->protocol so this function can be used during receive.
  */
-static inline int __vlan_insert_tag(struct sk_buff *skb,
-				    __be16 vlan_proto, u16 vlan_tci)
+static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
+					  __be16 vlan_proto, u16 vlan_tci,
+					  unsigned int mac_len)
 {
 	struct vlan_ethhdr *veth;
 
 	if (skb_cow_head(skb, VLAN_HLEN) < 0)
 		return -ENOMEM;
 
-	veth = skb_push(skb, VLAN_HLEN);
+	skb_push(skb, VLAN_HLEN);
 
-	/* Move the mac addresses to the beginning of the new header. */
-	memmove(skb->data, skb->data + VLAN_HLEN, 2 * ETH_ALEN);
+	/* Move the mac header sans proto to the beginning of the new header. */
+	memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
 	skb->mac_header -= VLAN_HLEN;
 
+	veth = (struct vlan_ethhdr *)(skb->data + mac_len - ETH_HLEN);
+
 	/* first, the ethernet type */
 	veth->h_vlan_proto = vlan_proto;
 
@@ -334,12 +338,30 @@ static inline int __vlan_insert_tag(stru
 }
 
 /**
- * vlan_insert_tag - regular VLAN tag inserting
+ * __vlan_insert_tag - regular VLAN tag inserting
  * @skb: skbuff to tag
  * @vlan_proto: VLAN encapsulation protocol
  * @vlan_tci: VLAN TCI to insert
  *
  * Inserts the VLAN tag into @skb as part of the payload
+ * Returns error if skb_cow_head failes.
+ *
+ * Does not change skb->protocol so this function can be used during receive.
+ */
+static inline int __vlan_insert_tag(struct sk_buff *skb,
+				    __be16 vlan_proto, u16 vlan_tci)
+{
+	return __vlan_insert_inner_tag(skb, vlan_proto, vlan_tci, ETH_HLEN);
+}
+
+/**
+ * vlan_insert_inner_tag - inner VLAN tag inserting
+ * @skb: skbuff to tag
+ * @vlan_proto: VLAN encapsulation protocol
+ * @vlan_tci: VLAN TCI to insert
+ * @mac_len: MAC header length including outer vlan headers
+ *
+ * Inserts the VLAN tag into @skb as part of the payload at offset mac_len
  * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
  *
  * Following the skb_unshare() example, in case of error, the calling function
@@ -347,12 +369,14 @@ static inline int __vlan_insert_tag(stru
  *
  * Does not change skb->protocol so this function can be used during receive.
  */
-static inline struct sk_buff *vlan_insert_tag(struct sk_buff *skb,
-					      __be16 vlan_proto, u16 vlan_tci)
+static inline struct sk_buff *vlan_insert_inner_tag(struct sk_buff *skb,
+						    __be16 vlan_proto,
+						    u16 vlan_tci,
+						    unsigned int mac_len)
 {
 	int err;
 
-	err = __vlan_insert_tag(skb, vlan_proto, vlan_tci);
+	err = __vlan_insert_inner_tag(skb, vlan_proto, vlan_tci, mac_len);
 	if (err) {
 		dev_kfree_skb_any(skb);
 		return NULL;
@@ -361,6 +385,26 @@ static inline struct sk_buff *vlan_inser
 }
 
 /**
+ * vlan_insert_tag - regular VLAN tag inserting
+ * @skb: skbuff to tag
+ * @vlan_proto: VLAN encapsulation protocol
+ * @vlan_tci: VLAN TCI to insert
+ *
+ * Inserts the VLAN tag into @skb as part of the payload
+ * Returns a VLAN tagged skb. If a new skb is created, @skb is freed.
+ *
+ * Following the skb_unshare() example, in case of error, the calling function
+ * doesn't have to worry about freeing the original skb.
+ *
+ * Does not change skb->protocol so this function can be used during receive.
+ */
+static inline struct sk_buff *vlan_insert_tag(struct sk_buff *skb,
+					      __be16 vlan_proto, u16 vlan_tci)
+{
+	return vlan_insert_inner_tag(skb, vlan_proto, vlan_tci, ETH_HLEN);
+}
+
+/**
  * vlan_insert_tag_set_proto - regular VLAN tag inserting
  * @skb: skbuff to tag
  * @vlan_proto: VLAN encapsulation protocol
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -48,8 +48,8 @@ bool vlan_do_receive(struct sk_buff **sk
 		 * original position later
 		 */
 		skb_push(skb, offset);
-		skb = *skbp = vlan_insert_tag(skb, skb->vlan_proto,
-					      skb->vlan_tci);
+		skb = *skbp = vlan_insert_inner_tag(skb, skb->vlan_proto,
+						    skb->vlan_tci, skb->mac_len);
 		if (!skb)
 			return false;
 		skb_pull(skb, offset + VLAN_HLEN);
