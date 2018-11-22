Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A810C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oP5igHjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1802C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436487AbeKVWSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:18:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41972 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405572AbeKVWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:18:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBdb9F022534;
        Thu, 22 Nov 2018 05:39:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886777;
        bh=wid2SPnwYAS8OrDuPNeFfDxOtgHDrKisgze3uUQ/47A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oP5igHjvdpz6N+rdhOf4a0gDZNlRzmFMOXngvZGz7sFwQpeIDPRjp5dEEsnhr9W2r
         sl0if1ofabNQnS+O0lSLhxxm98dNKWUWyrZ2gcbTPKH55q9EqzLhBwdFiRq9Ssqnvs
         gJvzHFJv6MYNv4y3N1ROb+17Lu9VZdiu78tm+bqI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBdb4q106946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:39:37 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:39:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:39:34 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdYq9017630;
        Thu, 22 Nov 2018 05:39:34 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDf3013203;
        Thu, 22 Nov 2018 05:39:30 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 04/17] soc: ti: pruss: Fix system suspend/MStandby config issues
Date:   Thu, 22 Nov 2018 13:39:00 +0200
Message-ID: <1542886753-17625-5-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRU-ICSS subsystem has a separate PRUSS_CFG module that contains
various configuration registers. This includes a control bit STANDBY_INIT
in PRUSS_CFG register to initiate a Standby sequence (when set) and
trigger a MStandby request to the SoC's PRCM module. This same bit is
also used to enable the OCP master ports (when cleared). The system
suspend/resume functionality on AM33xx/AM437x/AM57xx SoCs requires
all initiators to assert their MStandby signal properly inorder to
successfully enter suspend, and resume on a wakeup event.

Certain firmwares can enable the OCP master ports through the
STANDBY_INIT programming on the firmware side in order to access
peripherals or memories external to the PRUSS. This causes a hang
in the resume sequence on AM33xx/AM437x boards and requires a
board reset to come out of the hang.

This patch adds the preliminary System PM callbacks in the PRUSS SoC
bus driver, and fixes this system resume hang by setting the STANDBY_INIT
in the PM system suspend callback and resetting it back in the PM system
resume callback, if so configured. The clearing of the STANDBY_INIT
during resume requires an acknowledgment from PRCM and is done through
the monitoring of the PRUSS_SYSCFG.SUB_MWAIT bit.

NOTE:
1. This patch only adds the PM callbacks with code to fix the System
   Suspend/Resume hang issue on AM33xx/AM437x SoCs, but does not
   implement the full context save and restore required for the PRUSS
   drivers to work across system suspend/resume when the power domain
   is switched off (L4PER domain is switched OFF on AM335x/AM437x
   during system suspend/resume, so PRUSS modules do lose context).
2. The PRUSS driver functionality on AM57xx SoCs is not affected that
   much because the PER power domain to which the PRUSS IPs belong is
   not switched OFF during suspend/resume.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/pruss_soc_bus.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/soc/ti/pruss_soc_bus.c b/drivers/soc/ti/pruss_soc_bus.c
index 16b4802..d4da55d2 100644
--- a/drivers/soc/ti/pruss_soc_bus.c
+++ b/drivers/soc/ti/pruss_soc_bus.c
@@ -7,6 +7,7 @@
  *	Keerthy <j-keerthy@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -16,13 +17,18 @@
 
 #include <linux/platform_data/ti-pruss.h>
 
+#define SYSCFG_STANDBY_INIT	BIT(4)
+#define SYSCFG_SUB_MWAIT_READY	BIT(5)
+
 /**
  * struct pruss_soc_bus - PRUSS SoC bus structure
  * @syscfg: kernel mapped address for SYSCFG register
+ * @in_standby: flag for storing standby status
  * @has_reset: cached variable for storing global module reset flag
  */
 struct pruss_soc_bus {
 	void __iomem *syscfg;
+	bool in_standby;
 	bool has_reset;
 };
 
@@ -34,6 +40,81 @@ struct pruss_soc_bus_match_data {
 	bool has_reset;
 };
 
+static inline void pruss_soc_bus_rmw(void __iomem *reg, u32 mask, u32 set)
+{
+	u32 val;
+
+	val = readl_relaxed(reg);
+	val &= ~mask;
+	val |= (set & mask);
+	writel_relaxed(val, reg);
+}
+
+/*
+ * This function programs the PRUSS_SYSCFG.STANDBY_INIT bit to achieve dual
+ * functionalities - one is to deassert the MStandby signal to the device
+ * PRCM, and the other is to enable OCP master ports to allow accesses
+ * outside of the PRU-ICSS. The function has to wait for the PRCM to
+ * acknowledge through the monitoring of the PRUSS_SYSCFG.SUB_MWAIT bit.
+ */
+static
+int __maybe_unused pruss_soc_bus_enable_ocp_master_ports(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+	u32 syscfg_val, i;
+	bool ready = false;
+
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_INIT, 0);
+
+	/* wait till we are ready for transactions - delay is arbitrary */
+	for (i = 0; i < 10; i++) {
+		syscfg_val = readl_relaxed(psoc_bus->syscfg);
+		ready = !(syscfg_val & SYSCFG_SUB_MWAIT_READY);
+		if (ready)
+			break;
+		udelay(5);
+	}
+
+	if (!ready) {
+		dev_err(dev, "timeout waiting for SUB_MWAIT_READY\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused pruss_soc_bus_suspend(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+	u32 syscfg_val;
+
+	syscfg_val = readl_relaxed(psoc_bus->syscfg);
+	psoc_bus->in_standby = syscfg_val & SYSCFG_STANDBY_INIT;
+
+	/* initiate MStandby, undo the MStandby config in probe */
+	if (!psoc_bus->in_standby) {
+		pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_INIT,
+				  SYSCFG_STANDBY_INIT);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused pruss_soc_bus_resume(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+	int ret = 0;
+
+	/* re-enable OCP master ports/disable MStandby */
+	if (!psoc_bus->in_standby) {
+		ret = pruss_soc_bus_enable_ocp_master_ports(dev);
+		if (ret)
+			dev_err(dev, "%s failed\n", __func__);
+	}
+
+	return ret;
+}
+
 static int pruss_soc_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -126,9 +207,13 @@ static const struct of_device_id pruss_soc_bus_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pruss_soc_bus_of_match);
 
+static SIMPLE_DEV_PM_OPS(pruss_soc_bus_pm_ops,
+			 pruss_soc_bus_suspend, pruss_soc_bus_resume);
+
 static struct platform_driver pruss_soc_bus_driver = {
 	.driver	= {
 		.name = "pruss-soc-bus",
+		.pm = &pruss_soc_bus_pm_ops,
 		.of_match_table = pruss_soc_bus_of_match,
 	},
 	.probe	= pruss_soc_bus_probe,
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

