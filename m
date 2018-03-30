Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeC3Thh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 15:37:37 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:48205 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752314AbeC3Thg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 15:37:36 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:981:988:989:1260:1345:1437:1534:1542:1711:1730:1747:1777:1792:1978:1981:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3867:3870:5007:6261:10004:10848:11026:11473:11657:11658:11914:12043:12296:12438:12555:12895:13161:13229:13869:14181:14394:14721:21080:21627:21740:30003:30005:30012:30054:30079,0,RBL:172.56.31.163:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: eggs06_5f279ddbc991e
X-Filterd-Recvd-Size: 2685
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>, netdev@vger.kernel.org
Subject: [PATCH] ethernet: hisilicon: hns: hns_dsaf_mac: Use generic eth_broadcast_addr
Date: Fri, 30 Mar 2018 12:37:30 -0700
Message-Id: <7ca107f9960b176c10c7b1ac4c4fe0b492fb1b48.1522438626.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than use an on-stack array to copy a broadcast address, use
the generic eth_broadcast_addr function to save a trivial amount of
object code.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index cac86e9ae0dd..9dcc5765f11f 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -369,7 +369,6 @@ static int hns_mac_port_config_bc_en(struct hns_mac_cb *mac_cb,
 {
 	int ret;
 	struct dsaf_device *dsaf_dev = mac_cb->dsaf_dev;
-	u8 addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct dsaf_drv_mac_single_dest_entry mac_entry;
 
 	/* directy return ok in debug network mode */
@@ -377,7 +376,7 @@ static int hns_mac_port_config_bc_en(struct hns_mac_cb *mac_cb,
 		return 0;
 
 	if (!HNS_DSAF_IS_DEBUG(dsaf_dev)) {
-		memcpy(mac_entry.addr, addr, sizeof(mac_entry.addr));
+		eth_broadcast_addr(mac_entry.addr);
 		mac_entry.in_vlan_id = vlan_id;
 		mac_entry.in_port_num = mac_cb->mac_id;
 		mac_entry.port_num = port_num;
@@ -404,7 +403,6 @@ int hns_mac_vm_config_bc_en(struct hns_mac_cb *mac_cb, u32 vmid, bool enable)
 	int ret;
 	struct dsaf_device *dsaf_dev = mac_cb->dsaf_dev;
 	u8 port_num;
-	u8 addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct mac_entry_idx *uc_mac_entry;
 	struct dsaf_drv_mac_single_dest_entry mac_entry;
 
@@ -414,7 +412,7 @@ int hns_mac_vm_config_bc_en(struct hns_mac_cb *mac_cb, u32 vmid, bool enable)
 	uc_mac_entry = &mac_cb->addr_entry_idx[vmid];
 
 	if (!HNS_DSAF_IS_DEBUG(dsaf_dev))  {
-		memcpy(mac_entry.addr, addr, sizeof(mac_entry.addr));
+		eth_broadcast_addr(mac_entry.addr);
 		mac_entry.in_vlan_id = uc_mac_entry->vlan_id;
 		mac_entry.in_port_num = mac_cb->mac_id;
 		ret = hns_mac_get_inner_port_num(mac_cb, vmid, &port_num);
-- 
2.15.0
