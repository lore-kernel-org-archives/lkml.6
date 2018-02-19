Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeBSKXi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:23:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeBSKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:23:36 -0500
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] i40evf: remove redundant array comparisons to 0 checks
Date: Mon, 19 Feb 2018 10:23:30 +0000
Message-Id: <20180219102330.22045-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The checks to see if key->dst.s6_addr and key->src.s6_addr are null
pointers are redundant because these are constant size arrays and
so the checks always return true.  Fix this by removing the redundant
checks.   Also replace filter->f with vf, allowing wide lines to be
condensed and to rejoin some split wide lines.

Detected by CoverityScan, CID#1465279 ("Array compared to 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 61 ++++++++++---------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4955ce3ab6a2..a13df27089c3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2493,6 +2493,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 	u16 addr_type = 0;
 	u16 n_proto = 0;
 	int i = 0;
+	struct virtchnl_filter *vf = &filter->f;
 
 	if (f->dissector->used_keys &
 	    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
@@ -2540,7 +2541,7 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			return -EINVAL;
 		if (n_proto == ETH_P_IPV6) {
 			/* specify flow type as TCP IPv6 */
-			filter->f.flow_type = VIRTCHNL_TCP_V6_FLOW;
+			vf->flow_type = VIRTCHNL_TCP_V6_FLOW;
 		}
 
 		if (key->ip_proto != IPPROTO_TCP) {
@@ -2585,9 +2586,8 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			    is_multicast_ether_addr(key->dst)) {
 				/* set the mask if a valid dst_mac address */
 				for (i = 0; i < ETH_ALEN; i++)
-					filter->f.mask.tcp_spec.dst_mac[i] |=
-									0xff;
-				ether_addr_copy(filter->f.data.tcp_spec.dst_mac,
+					vf->mask.tcp_spec.dst_mac[i] |= 0xff;
+				ether_addr_copy(vf->data.tcp_spec.dst_mac,
 						key->dst);
 			}
 
@@ -2596,9 +2596,8 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			    is_multicast_ether_addr(key->src)) {
 				/* set the mask if a valid dst_mac address */
 				for (i = 0; i < ETH_ALEN; i++)
-					filter->f.mask.tcp_spec.src_mac[i] |=
-									0xff;
-				ether_addr_copy(filter->f.data.tcp_spec.src_mac,
+					vf->mask.tcp_spec.src_mac[i] |= 0xff;
+				ether_addr_copy(vf->data.tcp_spec.src_mac,
 						key->src);
 		}
 	}
@@ -2622,8 +2621,8 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 				return I40E_ERR_CONFIG;
 			}
 		}
-		filter->f.mask.tcp_spec.vlan_id |= cpu_to_be16(0xffff);
-		filter->f.data.tcp_spec.vlan_id = cpu_to_be16(key->vlan_id);
+		vf->mask.tcp_spec.vlan_id |= cpu_to_be16(0xffff);
+		vf->data.tcp_spec.vlan_id = cpu_to_be16(key->vlan_id);
 	}
 
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_CONTROL)) {
@@ -2670,14 +2669,12 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			return I40E_ERR_CONFIG;
 		}
 		if (key->dst) {
-			filter->f.mask.tcp_spec.dst_ip[0] |=
-							cpu_to_be32(0xffffffff);
-			filter->f.data.tcp_spec.dst_ip[0] = key->dst;
+			vf->mask.tcp_spec.dst_ip[0] |= cpu_to_be32(0xffffffff);
+			vf->data.tcp_spec.dst_ip[0] = key->dst;
 		}
 		if (key->src) {
-			filter->f.mask.tcp_spec.src_ip[0] |=
-							cpu_to_be32(0xffffffff);
-			filter->f.data.tcp_spec.src_ip[0] = key->src;
+			vf->mask.tcp_spec.src_ip[0] |= cpu_to_be32(0xffffffff);
+			vf->data.tcp_spec.src_ip[0] = key->src;
 		}
 	}
 
@@ -2710,22 +2707,14 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 		if (!ipv6_addr_any(&mask->dst) || !ipv6_addr_any(&mask->src))
 			field_flags |= I40EVF_CLOUD_FIELD_IIP;
 
-		if (key->dst.s6_addr) {
-			for (i = 0; i < 4; i++)
-				filter->f.mask.tcp_spec.dst_ip[i] |=
-							cpu_to_be32(0xffffffff);
-			memcpy(&filter->f.data.tcp_spec.dst_ip,
-			       &key->dst.s6_addr32,
-			       sizeof(filter->f.data.tcp_spec.dst_ip));
-		}
-		if (key->src.s6_addr) {
-			for (i = 0; i < 4; i++)
-				filter->f.mask.tcp_spec.src_ip[i] |=
-							cpu_to_be32(0xffffffff);
-			memcpy(&filter->f.data.tcp_spec.src_ip,
-			       &key->src.s6_addr32,
-			       sizeof(filter->f.data.tcp_spec.src_ip));
-		}
+		for (i = 0; i < 4; i++)
+			vf->mask.tcp_spec.dst_ip[i] |= cpu_to_be32(0xffffffff);
+		memcpy(&vf->data.tcp_spec.dst_ip, &key->dst.s6_addr32,
+		       sizeof(vf->data.tcp_spec.dst_ip));
+		for (i = 0; i < 4; i++)
+			vf->mask.tcp_spec.src_ip[i] |= cpu_to_be32(0xffffffff);
+		memcpy(&vf->data.tcp_spec.src_ip, &key->src.s6_addr32,
+		       sizeof(vf->data.tcp_spec.src_ip));
 	}
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_PORTS)) {
 		struct flow_dissector_key_ports *key =
@@ -2757,16 +2746,16 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
 			}
 		}
 		if (key->dst) {
-			filter->f.mask.tcp_spec.dst_port |= cpu_to_be16(0xffff);
-			filter->f.data.tcp_spec.dst_port = key->dst;
+			vf->mask.tcp_spec.dst_port |= cpu_to_be16(0xffff);
+			vf->data.tcp_spec.dst_port = key->dst;
 		}
 
 		if (key->src) {
-			filter->f.mask.tcp_spec.src_port |= cpu_to_be16(0xffff);
-			filter->f.data.tcp_spec.src_port = key->dst;
+			vf->mask.tcp_spec.src_port |= cpu_to_be16(0xffff);
+			vf->data.tcp_spec.src_port = key->dst;
 		}
 	}
-	filter->f.field_flags = field_flags;
+	vf->field_flags = field_flags;
 
 	return 0;
 }
-- 
2.15.1
