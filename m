Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0420D26EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0420D26EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeFZRvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:51:16 -0400
Received: from da1vs04.rockwellcollins.com ([205.175.227.52]:7965 "EHLO
        da1vs04.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752591AbeFZRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:51:14 -0400
Received: from ofwda1n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.227.14])
  by da1vs04.rockwellcollins.com with ESMTP; 26 Jun 2018 12:51:13 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 4069C2007C;
        Tue, 26 Jun 2018 12:51:13 -0500 (CDT)
From:   Brandon Maier <brandon.maier@rockwellcollins.com>
To:     netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH net-next v2 1/3] net: phy: xgmiitorgmii: Check phy_driver ready before accessing
Date:   Tue, 26 Jun 2018 12:50:48 -0500
Message-Id: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a phy_device is added to the global mdio_bus list during
phy_device_register(), but a phy_device's phy_driver doesn't get
attached until phy_probe(). It's possible of_phy_find_device() in
xgmiitorgmii will return a valid phy with a NULL phy_driver. Leading to
a NULL pointer access during the memcpy().

Fixes this Oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.40 #1
Hardware name: Xilinx Zynq Platform
task: ce4c8d00 task.stack: ce4ca000
PC is at memcpy+0x48/0x330
LR is at xgmiitorgmii_probe+0x90/0xe8
pc : [<c074bc68>]    lr : [<c0529548>]    psr: 20000013
sp : ce4cbb54  ip : 00000000  fp : ce4cbb8c
r10: 00000000  r9 : 00000000  r8 : c0c49178
r7 : 00000000  r6 : cdc14718  r5 : ce762800  r4 : cdc14710
r3 : 00000000  r2 : 00000054  r1 : 00000000  r0 : cdc14718
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 18c5387d  Table: 0000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xce4ca210)
...
[<c074bc68>] (memcpy) from [<c0529548>] (xgmiitorgmii_probe+0x90/0xe8)
[<c0529548>] (xgmiitorgmii_probe) from [<c0526a94>] (mdio_probe+0x28/0x34)
[<c0526a94>] (mdio_probe) from [<c04db98c>] (driver_probe_device+0x254/0x414)
[<c04db98c>] (driver_probe_device) from [<c04dbd58>] (__device_attach_driver+0xac/0x10c)
[<c04dbd58>] (__device_attach_driver) from [<c04d96f4>] (bus_for_each_drv+0x84/0xc8)
[<c04d96f4>] (bus_for_each_drv) from [<c04db5bc>] (__device_attach+0xd0/0x134)
[<c04db5bc>] (__device_attach) from [<c04dbdd4>] (device_initial_probe+0x1c/0x20)
[<c04dbdd4>] (device_initial_probe) from [<c04da8fc>] (bus_probe_device+0x98/0xa0)
[<c04da8fc>] (bus_probe_device) from [<c04d8660>] (device_add+0x43c/0x5d0)
[<c04d8660>] (device_add) from [<c0526cb8>] (mdio_device_register+0x34/0x80)
[<c0526cb8>] (mdio_device_register) from [<c0580b48>] (of_mdiobus_register+0x170/0x30c)
[<c0580b48>] (of_mdiobus_register) from [<c05349c4>] (macb_probe+0x710/0xc00)
[<c05349c4>] (macb_probe) from [<c04dd700>] (platform_drv_probe+0x44/0x80)
[<c04dd700>] (platform_drv_probe) from [<c04db98c>] (driver_probe_device+0x254/0x414)
[<c04db98c>] (driver_probe_device) from [<c04dbc58>] (__driver_attach+0x10c/0x118)
[<c04dbc58>] (__driver_attach) from [<c04d9600>] (bus_for_each_dev+0x8c/0xd0)
[<c04d9600>] (bus_for_each_dev) from [<c04db1fc>] (driver_attach+0x2c/0x30)
[<c04db1fc>] (driver_attach) from [<c04daa98>] (bus_add_driver+0x50/0x260)
[<c04daa98>] (bus_add_driver) from [<c04dc440>] (driver_register+0x88/0x108)
[<c04dc440>] (driver_register) from [<c04dd6b4>] (__platform_driver_register+0x50/0x58)
[<c04dd6b4>] (__platform_driver_register) from [<c0b31248>] (macb_driver_init+0x24/0x28)
[<c0b31248>] (macb_driver_init) from [<c010203c>] (do_one_initcall+0x60/0x1a4)
[<c010203c>] (do_one_initcall) from [<c0b00f78>] (kernel_init_freeable+0x15c/0x1f8)
[<c0b00f78>] (kernel_init_freeable) from [<c0763d10>] (kernel_init+0x18/0x124)
[<c0763d10>] (kernel_init) from [<c0112d74>] (ret_from_fork+0x14/0x20)
Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
---[ end trace 3e4ec21905820a1f ]---

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
v2:
- Add Oops to commit message

v1: https://marc.info/?l=linux-netdev&m=152838762210538&w=2

 drivers/net/phy/xilinx_gmii2rgmii.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 2e5150b0b8d5..04c8bec1c4c1 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -81,6 +81,11 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 		return -EPROBE_DEFER;
 	}
 
+	if (!priv->phy_dev->drv) {
+		dev_info(dev, "Attached phy not ready\n");
+		return -EPROBE_DEFER;
+	}
+
 	priv->addr = mdiodev->addr;
 	priv->phy_drv = priv->phy_dev->drv;
 	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
-- 
2.17.1

