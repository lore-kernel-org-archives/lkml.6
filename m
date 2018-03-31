Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeCaHGG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:06:06 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:55984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752422AbeCaHGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:06:02 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:800:960:973:981:988:989:1260:1345:1359:1437:1534:1543:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3354:3865:3866:3867:4321:4605:5007:6261:10004:10394:10848:11026:11233:11473:11657:11658:11914:12043:12048:12114:12296:12438:12555:12895:12986:14181:14394:14721:21080:21433:21627:30012:30045:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: pigs54_8bb2e8f016d0a
X-Filterd-Recvd-Size: 4472
From: Joe Perches <joe@perches.com>
To: Manish Chopra <manish.chopra@cavium.com>,
        Rahul Verma <rahul.verma@cavium.com>, Dept-GELinuxNICDev@cavium.com,
        Harish Patil <harish.patil@cavium.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] qlogic: Convert local bcast_addr to global ether_broadcast_addr
Date: Sat, 31 Mar 2018 00:05:26 -0700
Message-Id: <1241f333e7c6775ea7b7e56c4c4032f727b86ac3.1522479609.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new global instead of local statics to save a bit of object code.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c       | 5 +----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c           | 6 ++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 6 ++----
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
index 1cd39c9a0345..bd21aa3d5833 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -668,9 +668,6 @@ static void netxen_p3_nic_set_multi(struct net_device *netdev)
 {
 	struct netxen_adapter *adapter = netdev_priv(netdev);
 	struct netdev_hw_addr *ha;
-	static const u8 bcast_addr[ETH_ALEN] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
 	u32 mode = VPORT_MISS_MODE_DROP;
 	LIST_HEAD(del_list);
 	struct list_head *head;
@@ -682,7 +679,7 @@ static void netxen_p3_nic_set_multi(struct net_device *netdev)
 	list_splice_tail_init(&adapter->mac_list, &del_list);
 
 	nx_p3_nic_add_mac(adapter, adapter->mac_addr, &del_list);
-	nx_p3_nic_add_mac(adapter, bcast_addr, &del_list);
+	nx_p3_nic_add_mac(adapter, ether_broadcast_addr, &del_list);
 
 	if (netdev->flags & IFF_PROMISC) {
 		mode = VPORT_MISS_MODE_ACCEPT_ALL;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index 7848cf04b29a..948cb7ae9758 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -542,9 +542,6 @@ static void __qlcnic_set_multi(struct net_device *netdev, u16 vlan)
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
 	struct netdev_hw_addr *ha;
-	static const u8 bcast_addr[ETH_ALEN] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
 	u32 mode = VPORT_MISS_MODE_DROP;
 
 	if (!test_bit(__QLCNIC_FW_ATTACHED, &adapter->state))
@@ -552,7 +549,8 @@ static void __qlcnic_set_multi(struct net_device *netdev, u16 vlan)
 
 	qlcnic_nic_add_mac(adapter, adapter->mac_addr, vlan,
 			   QLCNIC_UNICAST_MAC);
-	qlcnic_nic_add_mac(adapter, bcast_addr, vlan, QLCNIC_BROADCAST_MAC);
+	qlcnic_nic_add_mac(adapter, ether_broadcast_addr, vlan,
+			   QLCNIC_BROADCAST_MAC);
 
 	if (netdev->flags & IFF_PROMISC) {
 		if (!(adapter->flags & QLCNIC_PROMISC_DISABLED))
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index c58180f40844..17dd0a1353f2 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1546,9 +1546,6 @@ void qlcnic_sriov_vf_set_multi(struct net_device *netdev)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
-	static const u8 bcast_addr[ETH_ALEN] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
 	struct netdev_hw_addr *ha;
 	u32 mode = VPORT_MISS_MODE_DROP;
 
@@ -1562,7 +1559,8 @@ void qlcnic_sriov_vf_set_multi(struct net_device *netdev)
 		   (netdev_mc_count(netdev) > ahw->max_mc_count)) {
 		mode = VPORT_MISS_MODE_ACCEPT_MULTI;
 	} else {
-		qlcnic_vf_add_mc_list(netdev, bcast_addr, QLCNIC_BROADCAST_MAC);
+		qlcnic_vf_add_mc_list(netdev, ether_broadcast_addr,
+				      QLCNIC_BROADCAST_MAC);
 		if (!netdev_mc_empty(netdev)) {
 			qlcnic_flush_mcast_mac(adapter);
 			netdev_for_each_mc_addr(ha, netdev)
-- 
2.15.0
