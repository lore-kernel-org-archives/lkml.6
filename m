Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4E3214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4E3214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeIZTfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:35:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57638 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbeIZTfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:35:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 95E8C20025B;
        Wed, 26 Sep 2018 15:22:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8816C200253;
        Wed, 26 Sep 2018 15:22:53 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E1D22203C2;
        Wed, 26 Sep 2018 15:22:52 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 06/22] soc/fsl/qman_portals: defer probe after qman's probe
Date:   Wed, 26 Sep 2018 16:22:31 +0300
Message-Id: <20180926132247.10971-7-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Defer probe of qman portals after qman probing. This fixes the crash
below, seen on NXP LS1043A SoCs:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000004
Mem abort info:
  ESR = 0x96000004
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[0000000000000004] user address but active_mm is swapper
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.18.0-rc1-next-20180622-00200-g986f5c179185 #9
Hardware name: LS1043A RDB Board (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO)
pc : qman_set_sdest+0x74/0xa0
lr : qman_portal_probe+0x22c/0x470
sp : ffff00000803bbc0
x29: ffff00000803bbc0 x28: 0000000000000000
x27: ffff0000090c1b88 x26: ffff00000927cb68
x25: ffff00000927c000 x24: ffff00000927cb60
x23: 0000000000000000 x22: 0000000000000000
x21: ffff0000090e9000 x20: ffff800073b5c810
x19: ffff800027401298 x18: ffffffffffffffff
x17: 0000000000000001 x16: 0000000000000000
x15: ffff0000090e96c8 x14: ffff80002740138a
x13: ffff0000090f2000 x12: 0000000000000030
x11: ffff000008f25000 x10: 0000000000000000
x9 : ffff80007bdfd2c0 x8 : 0000000000004000
x7 : ffff80007393cc18 x6 : 0040000000000001
x5 : 0000000000000000 x4 : ffffffffffffffff
x3 : 0000000000000004 x2 : ffff00000927c900
x1 : 0000000000000000 x0 : 0000000000000004
Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
Call trace:
 qman_set_sdest+0x74/0xa0
 platform_drv_probe+0x50/0xa8
 driver_probe_device+0x214/0x2f8
 __driver_attach+0xd8/0xe0
 bus_for_each_dev+0x68/0xc8
 driver_attach+0x20/0x28
 bus_add_driver+0x108/0x228
 driver_register+0x60/0x110
 __platform_driver_register+0x40/0x48
 qman_portal_driver_init+0x20/0x84
 do_one_initcall+0x58/0x168
 kernel_init_freeable+0x184/0x22c
 kernel_init+0x10/0x108
 ret_from_fork+0x10/0x18
Code: f9400443 11001000 927e4800 8b000063 (b9400063)
---[ end trace 4f6d50489ecfb930 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 6d9da3b1b5ad..eef93cab84f1 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -229,6 +229,14 @@ static int qman_portal_probe(struct platform_device *pdev)
 	int irq, cpu, err;
 	u32 val;
 
+	err = qman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to qman probe error\n");
+		return -ENODEV;
+	}
+
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
 	if (!pcfg)
 		return -ENOMEM;
-- 
2.17.1

