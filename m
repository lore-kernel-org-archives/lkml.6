Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C6020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeLIWDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35842 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbeLIVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:31 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72u-0002iZ-7y; Sun, 09 Dec 2018 21:55:28 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003cy-U2; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Shahed Shaikh" <shahed.shaikh@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.743089324@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 278/328] qlcnic: fix Tx descriptor corruption on 82xx
 devices
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shahed Shaikh <shahed.shaikh@cavium.com>

commit c333fa0c4f220f8f7ea5acd6b0ebf3bf13fd684d upstream.

In regular NIC transmission flow, driver always configures MAC using
Tx queue zero descriptor as a part of MAC learning flow.
But with multi Tx queue supported NIC, regular transmission can occur on
any non-zero Tx queue and from that context it uses
Tx queue zero descriptor to configure MAC, at the same time TX queue
zero could be used by another CPU for regular transmission
which could lead to Tx queue zero descriptor corruption and cause FW
abort.

This patch fixes this in such a way that driver always configures
learned MAC address from the same Tx queue which is used for
regular transmission.

Fixes: 7e2cf4feba05 ("qlcnic: change driver hardware interface mechanism")
Signed-off-by: Shahed Shaikh <shahed.shaikh@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h         |  8 +++++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h      |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c      | 12 ++++++------
 5 files changed, 17 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -1793,7 +1793,8 @@ struct qlcnic_hardware_ops {
 	int (*config_loopback) (struct qlcnic_adapter *, u8);
 	int (*clear_loopback) (struct qlcnic_adapter *, u8);
 	int (*config_promisc_mode) (struct qlcnic_adapter *, u32);
-	void (*change_l2_filter) (struct qlcnic_adapter *, u64 *, u16);
+	void (*change_l2_filter)(struct qlcnic_adapter *adapter, u64 *addr,
+				 u16 vlan, struct qlcnic_host_tx_ring *tx_ring);
 	int (*get_board_info) (struct qlcnic_adapter *);
 	void (*set_mac_filter_count) (struct qlcnic_adapter *);
 	void (*free_mac_list) (struct qlcnic_adapter *);
@@ -2035,9 +2036,10 @@ static inline int qlcnic_nic_set_promisc
 }
 
 static inline void qlcnic_change_filter(struct qlcnic_adapter *adapter,
-					u64 *addr, u16 id)
+					u64 *addr, u16 vlan,
+					struct qlcnic_host_tx_ring *tx_ring)
 {
-	adapter->ahw->hw_ops->change_l2_filter(adapter, addr, id);
+	adapter->ahw->hw_ops->change_l2_filter(adapter, addr, vlan, tx_ring);
 }
 
 static inline int qlcnic_get_board_info(struct qlcnic_adapter *adapter)
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -2095,7 +2095,8 @@ out:
 }
 
 void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *adapter, u64 *addr,
-				  u16 vlan_id)
+				  u16 vlan_id,
+				  struct qlcnic_host_tx_ring *tx_ring)
 {
 	u8 mac[ETH_ALEN];
 	memcpy(&mac, addr, ETH_ALEN);
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -549,7 +549,8 @@ int qlcnic_83xx_wrt_reg_indirect(struct
 int qlcnic_83xx_nic_set_promisc(struct qlcnic_adapter *, u32);
 int qlcnic_83xx_config_hw_lro(struct qlcnic_adapter *, int);
 int qlcnic_83xx_config_rss(struct qlcnic_adapter *, int);
-void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *, u64 *, u16);
+void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *adapter, u64 *addr,
+				  u16 vlan, struct qlcnic_host_tx_ring *ring);
 int qlcnic_83xx_get_pci_info(struct qlcnic_adapter *, struct qlcnic_pci_info *);
 int qlcnic_83xx_set_nic_info(struct qlcnic_adapter *, struct qlcnic_info *);
 void qlcnic_83xx_initialize_nic(struct qlcnic_adapter *, int);
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
@@ -172,7 +172,8 @@ int qlcnic_82xx_napi_add(struct qlcnic_a
 			 struct net_device *netdev);
 void qlcnic_82xx_get_beacon_state(struct qlcnic_adapter *);
 void qlcnic_82xx_change_filter(struct qlcnic_adapter *adapter,
-			       u64 *uaddr, u16 vlan_id);
+			       u64 *uaddr, u16 vlan_id,
+			       struct qlcnic_host_tx_ring *tx_ring);
 int qlcnic_82xx_config_intr_coalesce(struct qlcnic_adapter *,
 				     struct ethtool_coalesce *);
 int qlcnic_82xx_set_rx_coalesce(struct qlcnic_adapter *);
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -268,13 +268,12 @@ static void qlcnic_add_lb_filter(struct
 }
 
 void qlcnic_82xx_change_filter(struct qlcnic_adapter *adapter, u64 *uaddr,
-			       u16 vlan_id)
+			       u16 vlan_id, struct qlcnic_host_tx_ring *tx_ring)
 {
 	struct cmd_desc_type0 *hwdesc;
 	struct qlcnic_nic_req *req;
 	struct qlcnic_mac_req *mac_req;
 	struct qlcnic_vlan_req *vlan_req;
-	struct qlcnic_host_tx_ring *tx_ring = adapter->tx_ring;
 	u32 producer;
 	u64 word;
 
@@ -301,7 +300,8 @@ void qlcnic_82xx_change_filter(struct ql
 
 static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 			       struct cmd_desc_type0 *first_desc,
-			       struct sk_buff *skb)
+			       struct sk_buff *skb,
+			       struct qlcnic_host_tx_ring *tx_ring)
 {
 	struct vlan_ethhdr *vh = (struct vlan_ethhdr *)(skb->data);
 	struct ethhdr *phdr = (struct ethhdr *)(skb->data);
@@ -335,7 +335,7 @@ static void qlcnic_send_filter(struct ql
 		    tmp_fil->vlan_id == vlan_id) {
 			if (jiffies > (QLCNIC_READD_AGE * HZ + tmp_fil->ftime))
 				qlcnic_change_filter(adapter, &src_addr,
-						     vlan_id);
+						     vlan_id, tx_ring);
 			tmp_fil->ftime = jiffies;
 			return;
 		}
@@ -350,7 +350,7 @@ static void qlcnic_send_filter(struct ql
 	if (!fil)
 		return;
 
-	qlcnic_change_filter(adapter, &src_addr, vlan_id);
+	qlcnic_change_filter(adapter, &src_addr, vlan_id, tx_ring);
 	fil->ftime = jiffies;
 	fil->vlan_id = vlan_id;
 	memcpy(fil->faddr, &src_addr, ETH_ALEN);
@@ -766,7 +766,7 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_
 	}
 
 	if (adapter->drv_mac_learn)
-		qlcnic_send_filter(adapter, first_desc, skb);
+		qlcnic_send_filter(adapter, first_desc, skb, tx_ring);
 
 	tx_ring->tx_stats.tx_bytes += skb->len;
 	tx_ring->tx_stats.xmit_called++;

