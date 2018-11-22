Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D003C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B20020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B20020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436530AbeKVWSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:18:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58460 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405550AbeKVWSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:18:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBdlCC008454;
        Thu, 22 Nov 2018 05:39:47 -0600
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBdliA107021
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:39:47 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:39:46 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:39:46 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdkHK027423;
        Thu, 22 Nov 2018 05:39:46 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDf6013203;
        Thu, 22 Nov 2018 05:39:42 -0600
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
Subject: [PATCH 07/17] soc: ti: pruss: enable OCP master ports in SYSCFG always
Date:   Thu, 22 Nov 2018 13:39:03 +0200
Message-ID: <1542886753-17625-8-git-send-email-rogerq@ti.com>
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
PRCM clock management settings at the PRU-ICSS subsystem level,
and is being programmed for the PRCM Idle/Standby protocol properly
during probe and remove. The register is also programmed to enable
the OCP master ports (disable MStandby) by default during probe now
to allow the PRUs access to on-chip memories and peripherals outside
the PRUSS without having to do it in firmware (primarily for the PRU
Ethernet usecase currently, the firmware is not programming this
register).

NOTE:
1. The AM57xx TRM suggests to enable "No Standby" during the
   Idle + Standby state to an Active/Normal state, but this
   sequence is not documented in either of AM33xx and AM437x
   SoCs. Furthermore, it did not have an impact on the working
   of Ethernet Rx, so is left out.
2. This has an impact on the PM suspend/resume operation usually
   (same bit is used to trigger PRU standby), and even when the
   PRU cores are in halted state. The STANDBY_INIT has to be
   re-programmed to initiate a standby sequence and have the PM
   suspend/resume functional when PRUs are halted. This is already
   handled in commit b7e68ab66385 ("remoteproc/pruss_soc: fix system
   suspend/MStandby config issues").

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/soc/ti/pruss_soc_bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pruss_soc_bus.c b/drivers/soc/ti/pruss_soc_bus.c
index 46dfb7a..f477168 100644
--- a/drivers/soc/ti/pruss_soc_bus.c
+++ b/drivers/soc/ti/pruss_soc_bus.c
@@ -67,8 +67,7 @@ static inline void pruss_soc_bus_rmw(void __iomem *reg, u32 mask, u32 set)
  * outside of the PRU-ICSS. The function has to wait for the PRCM to
  * acknowledge through the monitoring of the PRUSS_SYSCFG.SUB_MWAIT bit.
  */
-static
-int __maybe_unused pruss_soc_bus_enable_ocp_master_ports(struct device *dev)
+static int pruss_soc_bus_enable_ocp_master_ports(struct device *dev)
 {
 	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
 	u32 syscfg_val, i;
@@ -160,6 +159,11 @@ static int pruss_enable_module(struct device *dev)
 	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
 			  SYSCFG_STANDBY_MODE_SMART);
 
+	/* enable OCP master ports/disable MStandby */
+	ret = pruss_soc_bus_enable_ocp_master_ports(dev);
+	if (ret)
+		pruss_disable_module(dev);
+
 	return ret;
 }
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

