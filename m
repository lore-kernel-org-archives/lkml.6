Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BC7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A067B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J3bCFcup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A067B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436498AbeKVWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:18:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35414 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405550AbeKVWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:18:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBdfrd078031;
        Thu, 22 Nov 2018 05:39:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886781;
        bh=vxyCHXR1JMyg6Q9lFruUOMrUzaWNOqUp0GPab0Yz8Rk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J3bCFcupOggCja41aIAQA9OXTRiGuJ9Tojqb4NDru3MPPJoBTdDDoES+1lLAJT04Z
         uyDHabqPkP00Gkdt9++W0ha7etBV73on5LFk92CDg2Tizamv70o+bDtY5oSJcxLf1k
         krYRPv8NUj1+Iu7CVDu2ZJSqKnzu8hHqTzmQKRqw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBdfQQ076850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:39:41 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:39:38 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:39:38 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdcj2024667;
        Thu, 22 Nov 2018 05:39:38 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDf4013203;
        Thu, 22 Nov 2018 05:39:34 -0600
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
Subject: [PATCH 05/17] soc: ti: pruss: Configure SYSCFG properly during probe/remove
Date:   Thu, 22 Nov 2018 13:39:01 +0200
Message-ID: <1542886753-17625-6-git-send-email-rogerq@ti.com>
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

The PRUSS CFG module's SYSCFG register is used for managing the
PRCM clock management settings at the PRU-ICSS subsystem level.

Add two helper functions pruss_{enable/disable}_module() that
programs this SYSCFG register during probe and remove. The
register is currently programmed for the default Smart-Idle
and Smart-Standby always during probe. The MStandby is enabled
during remove to undo the settings in probe to properly configure
the SYSCFG in the case that a firmware has disabled MStandby.
This is needed on SoCs like AM57xx that do not have a reset line
and so cannot reset the register properly.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/pruss_soc_bus.c | 60 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/pruss_soc_bus.c b/drivers/soc/ti/pruss_soc_bus.c
index d4da55d2..46dfb7a 100644
--- a/drivers/soc/ti/pruss_soc_bus.c
+++ b/drivers/soc/ti/pruss_soc_bus.c
@@ -20,6 +20,16 @@
 #define SYSCFG_STANDBY_INIT	BIT(4)
 #define SYSCFG_SUB_MWAIT_READY	BIT(5)
 
+#define SYSCFG_STANDBY_MODE_FORCE	(0 << 2)
+#define SYSCFG_STANDBY_MODE_NO		(1 << 2)
+#define SYSCFG_STANDBY_MODE_SMART	(2 << 2)
+#define SYSCFG_STANDBY_MODE_MASK	(3 << 2)
+
+#define SYSCFG_IDLE_MODE_FORCE		0
+#define SYSCFG_IDLE_MODE_NO		1
+#define SYSCFG_IDLE_MODE_SMART		2
+#define SYSCFG_IDLE_MODE_MASK		3
+
 /**
  * struct pruss_soc_bus - PRUSS SoC bus structure
  * @syscfg: kernel mapped address for SYSCFG register
@@ -115,6 +125,44 @@ static int __maybe_unused pruss_soc_bus_resume(struct device *dev)
 	return ret;
 }
 
+/* firmware must be idle when calling this function */
+static void pruss_disable_module(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+
+	/* configure Smart Standby */
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
+			  SYSCFG_STANDBY_MODE_SMART);
+
+	/* initiate MStandby */
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_INIT,
+			  SYSCFG_STANDBY_INIT);
+
+	/* tell PRCM to initiate IDLE request */
+	pm_runtime_put_sync(dev);
+}
+
+static int pruss_enable_module(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+	int ret;
+
+	/* tell PRCM to de-assert IDLE request */
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	/* configure for Smart Idle & Smart Standby */
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_IDLE_MODE_MASK,
+			  SYSCFG_IDLE_MODE_SMART);
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
+			  SYSCFG_STANDBY_MODE_SMART);
+
+	return ret;
+}
+
 static int pruss_soc_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -155,10 +203,10 @@ static int pruss_soc_bus_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pruss_enable_module(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
-		goto fail_clock;
+		dev_err(dev, "couldn't enable module\n");
+		goto fail_module;
 	}
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
@@ -168,8 +216,8 @@ static int pruss_soc_bus_probe(struct platform_device *pdev)
 	return 0;
 
 fail_of:
-	pm_runtime_put_sync(dev);
-fail_clock:
+	pruss_disable_module(dev);
+fail_module:
 	pm_runtime_disable(dev);
 	if (psoc_bus->has_reset)
 		pdata->assert_reset(pdev, pdata->reset_name);
@@ -186,7 +234,7 @@ static int pruss_soc_bus_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 
-	pm_runtime_put_sync(dev);
+	pruss_disable_module(dev);
 	pm_runtime_disable(dev);
 
 	if (psoc_bus->has_reset)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

