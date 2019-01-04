Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A753C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF32173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfADMSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:18:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfADMSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:18:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20F2F8D714F8D;
        Fri,  4 Jan 2019 20:18:34 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 4 Jan 2019 20:18:25 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH net 1/2] net: hns: Fix WARNING when hns modules installed
Date:   Fri, 4 Jan 2019 20:18:10 +0800
Message-ID: <1546604291-63155-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546604291-63155-1-git-send-email-tanhuazhong@huawei.com>
References: <1546604291-63155-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

Commit 308c6cafde01 ("net: hns: All ports can not work when insmod hns ko
after rmmod.") add phy_stop in hns_nic_init_phy(), In the branch of "net",
this method is effective, but in the branch of "net-next", it will cause
a WARNING when hns modules loaded, reference to commit 2b3e88ea6528 ("net:
phy: improve phy state checking"):

[10.092168] ------------[ cut here ]------------
[10.092171] called from state READY
[10.092189] WARNING: CPU: 4 PID: 1 at ../drivers/net/phy/phy.c:854
                phy_stop+0x90/0xb0
[10.092192] Modules linked in:
[10.092197] CPU: 4 PID:1 Comm:swapper/0 Not tainted 4.20.0-rc7-next-20181220 #1
[10.092200] Hardware name: Huawei TaiShan 2280 /D05, BIOS Hisilicon D05 UEFI
                16.12 Release 05/15/2017
[10.092202] pstate: 60000005 (nZCv daif -PAN -UAO)
[10.092205] pc : phy_stop+0x90/0xb0
[10.092208] lr : phy_stop+0x90/0xb0
[10.092209] sp : ffff00001159ba90
[10.092212] x29: ffff00001159ba90 x28: 0000000000000007
[10.092215] x27: ffff000011180068 x26: ffff0000110a5620
[10.092218] x25: ffff0000113b6000 x24: ffff842f96dac000
[10.092221] x23: 0000000000000000 x22: 0000000000000000
[10.092223] x21: ffff841fb8425e18 x20: ffff801fb3a56438
[10.092226] x19: ffff801fb3a56000 x18: ffffffffffffffff
[10.092228] x17: 0000000000000000 x16: 0000000000000000
[10.092231] x15: ffff00001122d6c8 x14: ffff00009159b7b7
[10.092234] x13: ffff00001159b7c5 x12: ffff000011245000
[10.092236] x11: 0000000005f5e0ff x10: ffff00001159b750
[10.092239] x9 : 00000000ffffffd0 x8 : 0000000000000465
[10.092242] x7 : ffff0000112457f8 x6 : ffff0000113bd7ce
[10.092245] x5 : 0000000000000000 x4 : 0000000000000000
[10.092247] x3 : 00000000ffffffff x2 : ffff000011245828
[10.092250] x1 : 4b5860bd05871300 x0 : 0000000000000000
[10.092253] Call trace:
[10.092255]  phy_stop+0x90/0xb0
[10.092260]  hns_nic_init_phy+0xf8/0x110
[10.092262]  hns_nic_try_get_ae+0x4c/0x3b0
[10.092264]  hns_nic_dev_probe+0x1fc/0x480
[10.092268]  platform_drv_probe+0x50/0xa0
[10.092271]  really_probe+0x1f4/0x298
[10.092273]  driver_probe_device+0x58/0x108
[10.092275]  __driver_attach+0xdc/0xe0
[10.092278]  bus_for_each_dev+0x74/0xc8
[10.092280]  driver_attach+0x20/0x28
[10.092283]  bus_add_driver+0x1b8/0x228
[10.092285]  driver_register+0x60/0x110
[10.092288]  __platform_driver_register+0x40/0x48
[10.092292]  hns_nic_dev_driver_init+0x18/0x20
[10.092296]  do_one_initcall+0x5c/0x180
[10.092299]  kernel_init_freeable+0x198/0x240
[10.092303]  kernel_init+0x10/0x108
[10.092306]  ret_from_fork+0x10/0x18
[10.092308] ---[ end trace 1396dd0278e397eb ]---

This WARNING occurred because of calling phy_stop before phy_start.

The root cause of the problem in commit '308c6cafde01' is:

Reference to hns_nic_init_phy, the flag phydev->supported is changed after
phy_connect_direct. The flag phydev->supported is 0x6ff when hns modules is
loaded, so will not change Fiber Port power(Reference to marvell.c), which
is power on at default.
Then the flag phydev->supported is changed to 0x6f, so Fiber Port power is
off when removing hns modules.
When hns modules installed again, the flag phydev->supported is default
value 0x6ff, so will not change Fiber Port power(now is off), causing mac
link not up problem.

So the solution is change phy flags before phy_connect_direct.

Fixes: 308c6cafde01 ("net: hns: All ports can not work when insmod hns ko after rmmod.")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 5748d3f..5b33238 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1170,6 +1170,13 @@ int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h)
 	if (!h->phy_dev)
 		return 0;
 
+	ethtool_convert_legacy_u32_to_link_mode(supported, h->if_support);
+	linkmode_and(phy_dev->supported, phy_dev->supported, supported);
+	linkmode_copy(phy_dev->advertising, phy_dev->supported);
+
+	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
+		phy_dev->autoneg = false;
+
 	if (h->phy_if != PHY_INTERFACE_MODE_XGMII) {
 		phy_dev->dev_flags = 0;
 
@@ -1181,16 +1188,6 @@ int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h)
 	if (unlikely(ret))
 		return -ENODEV;
 
-	ethtool_convert_legacy_u32_to_link_mode(supported, h->if_support);
-	linkmode_and(phy_dev->supported, phy_dev->supported, supported);
-	linkmode_copy(phy_dev->advertising, phy_dev->supported);
-
-	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
-		phy_dev->autoneg = false;
-
-	if (h->phy_if == PHY_INTERFACE_MODE_SGMII)
-		phy_stop(phy_dev);
-
 	return 0;
 }
 
-- 
2.7.4

