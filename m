Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A87C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A8E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejz3pJJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A8E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeJPMF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbeJPMF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:05:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907E32147E;
        Tue, 16 Oct 2018 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663422;
        bh=PTNpZePCiVpUwFBgw0IOR+TdDLa5wdkJoIJPodQhgBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ejz3pJJ8o9u7Bq988LkSQ/QH758grUIoizjj0VpvJL7WGFPPH07coJnkyKo07YlK/
         WF/sb1gkhSwHJ/RWZ6CPcGD23H32Yez1BHZEjfTJaSKlUMe2YojGjvA7UBbT6ADyO3
         td4ftzeynML5EBLVl5Yp2qWUudb2kkgpRhkZlc6s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shahed Shaikh <shahed.shaikh@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 11/15] qlcnic: fix Tx descriptor corruption on 82xx devices
Date:   Tue, 16 Oct 2018 00:16:46 -0400
Message-Id: <20181016041650.135958-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041650.135958-1-sashal@kernel.org>
References: <20181016041650.135958-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shahed Shaikh <shahed.shaikh@cavium.com>

[ Upstream commit c333fa0c4f220f8f7ea5acd6b0ebf3bf13fd684d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h         |  8 +++++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h      |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c      | 12 ++++++------
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
index 76b2cfe12504..b32aefe1f3d4 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -1796,7 +1796,8 @@ struct qlcnic_hardware_ops {
 	int (*config_loopback) (struct qlcnic_adapter *, u8);
 	int (*clear_loopback) (struct qlcnic_adapter *, u8);
 	int (*config_promisc_mode) (struct qlcnic_adapter *, u32);
-	void (*change_l2_filter) (struct qlcnic_adapter *, u64 *, u16);
+	void (*change_l2_filter)(struct qlcnic_adapter *adapter, u64 *addr,
+				 u16 vlan, struct qlcnic_host_tx_ring *tx_ring);
 	int (*get_board_info) (struct qlcnic_adapter *);
 	void (*set_mac_filter_count) (struct qlcnic_adapter *);
 	void (*free_mac_list) (struct qlcnic_adapter *);
@@ -2038,9 +2039,10 @@ static inline int qlcnic_nic_set_promisc(struct qlcnic_adapter *adapter,
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
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index 1c40c524f0c8..21a666f98433 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -2132,7 +2132,8 @@ int qlcnic_83xx_sre_macaddr_change(struct qlcnic_adapter *adapter, u8 *addr,
 }
 
 void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *adapter, u64 *addr,
-				  u16 vlan_id)
+				  u16 vlan_id,
+				  struct qlcnic_host_tx_ring *tx_ring)
 {
 	u8 mac[ETH_ALEN];
 	memcpy(&mac, addr, ETH_ALEN);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
index f3346a3779d3..db21bc4b58ad 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -549,7 +549,8 @@ int qlcnic_83xx_wrt_reg_indirect(struct qlcnic_adapter *, ulong, u32);
 int qlcnic_83xx_nic_set_promisc(struct qlcnic_adapter *, u32);
 int qlcnic_83xx_config_hw_lro(struct qlcnic_adapter *, int);
 int qlcnic_83xx_config_rss(struct qlcnic_adapter *, int);
-void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *, u64 *, u16);
+void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *adapter, u64 *addr,
+				  u16 vlan, struct qlcnic_host_tx_ring *ring);
 int qlcnic_83xx_get_pci_info(struct qlcnic_adapter *, struct qlcnic_pci_info *);
 int qlcnic_83xx_set_nic_info(struct qlcnic_adapter *, struct qlcnic_info *);
 void qlcnic_83xx_initialize_nic(struct qlcnic_adapter *, int);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
index cbe2399c30a0..480aa1f9f2e1 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
@@ -172,7 +172,8 @@ int qlcnic_82xx_napi_add(struct qlcnic_adapter *adapter,
 			 struct net_device *netdev);
 void qlcnic_82xx_get_beacon_state(struct qlcnic_adapter *);
 void qlcnic_82xx_change_filter(struct qlcnic_adapter *adapter,
-			       u64 *uaddr, u16 vlan_id);
+			       u64 *uaddr, u16 vlan_id,
+			       struct qlcnic_host_tx_ring *tx_ring);
 int qlcnic_82xx_config_intr_coalesce(struct qlcnic_adapter *,
 				     struct ethtool_coalesce *);
 int qlcnic_82xx_set_rx_coalesce(struct qlcnic_adapter *);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 18e5de72e9b4..579bf42252c0 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -268,13 +268,12 @@ static void qlcnic_add_lb_filter(struct qlcnic_adapter *adapter,
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
 
@@ -301,7 +300,8 @@ void qlcnic_82xx_change_filter(struct qlcnic_adapter *adapter, u64 *uaddr,
 
 static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 			       struct cmd_desc_type0 *first_desc,
-			       struct sk_buff *skb)
+			       struct sk_buff *skb,
+			       struct qlcnic_host_tx_ring *tx_ring)
 {
 	struct vlan_ethhdr *vh = (struct vlan_ethhdr *)(skb->data);
 	struct ethhdr *phdr = (struct ethhdr *)(skb->data);
@@ -335,7 +335,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 		    tmp_fil->vlan_id == vlan_id) {
 			if (jiffies > (QLCNIC_READD_AGE * HZ + tmp_fil->ftime))
 				qlcnic_change_filter(adapter, &src_addr,
-						     vlan_id);
+						     vlan_id, tx_ring);
 			tmp_fil->ftime = jiffies;
 			return;
 		}
@@ -350,7 +350,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 	if (!fil)
 		return;
 
-	qlcnic_change_filter(adapter, &src_addr, vlan_id);
+	qlcnic_change_filter(adapter, &src_addr, vlan_id, tx_ring);
 	fil->ftime = jiffies;
 	fil->vlan_id = vlan_id;
 	memcpy(fil->faddr, &src_addr, ETH_ALEN);
@@ -766,7 +766,7 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	}
 
 	if (adapter->drv_mac_learn)
-		qlcnic_send_filter(adapter, first_desc, skb);
+		qlcnic_send_filter(adapter, first_desc, skb, tx_ring);
 
 	tx_ring->tx_stats.tx_bytes += skb->len;
 	tx_ring->tx_stats.xmit_called++;
-- 
2.17.1

