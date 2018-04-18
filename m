Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDRTsU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 15:48:20 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:14218 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750824AbeDRTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 15:48:19 -0400
From: Ronak Doshi <doshir@vmware.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <doshir@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net] vmxnet3: fix incorrect dereference when rxvlan is disabled
Date: Wed, 18 Apr 2018 12:48:04 -0700
Message-ID: <20180418194805.29119-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmxnet3_get_hdr_len() is used to calculate the header length which in
turn is used to calculate the gso_size for skb. When rxvlan offload is
disabled, vlan tag is present in the header and the function references
ip header from sizeof(ethhdr) and leads to incorrect pointer reference.

This patch fixes this issue by taking sizeof(vlan_ethhdr) into account
if vlan tag is present and correctly references the ip hdr.

Signed-off-by: Ronak Doshi <doshir@vmware.com>
Acked-by: Guolin Yang <gyang@vmware.com>
Acked-by: Louis Luo <llouis@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 17 +++++++++++++----
 drivers/net/vmxnet3/vmxnet3_int.h |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index e04937f44f33..9ebe2a689966 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1218,6 +1218,7 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 	union {
 		void *ptr;
 		struct ethhdr *eth;
+		struct vlan_ethhdr *veth;
 		struct iphdr *ipv4;
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
@@ -1228,16 +1229,24 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
 		return 0;
 
+	if (skb->protocol == cpu_to_be16(ETH_P_8021Q) ||
+	    skb->protocol == cpu_to_be16(ETH_P_8021AD))
+		hlen = sizeof(struct vlan_ethhdr);
+	else
+		hlen = sizeof(struct ethhdr);
+
 	hdr.eth = eth_hdr(skb);
 	if (gdesc->rcd.v4) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP));
-		hdr.ptr += sizeof(struct ethhdr);
+		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
+		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
+		hdr.ptr += hlen;
 		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6));
-		hdr.ptr += sizeof(struct ethhdr);
+		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6) &&
+		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6));
+		hdr.ptr += hlen;
 		/* Use an estimated value, since we also need to handle
 		 * TSO case.
 		 */
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 59ec34052a65..a3326463b71f 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,10 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.13.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.14.0-k"
 
 /* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040d00
+#define VMXNET3_DRIVER_VERSION_NUM      0x01040e00
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.11.0
