Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C3DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8622082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8622082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeKCEcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57314 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCEce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JO3qD011849;
        Fri, 2 Nov 2018 14:24:03 -0500
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JO32m128026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:24:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:24:03 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:24:03 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfva000522;
        Fri, 2 Nov 2018 14:24:00 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 6/6] can: m_can: Add support for transceiver as phy
Date:   Sat, 3 Nov 2018 00:56:16 +0530
Message-ID: <20181102192616.28291-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for implementing the transceiver device as a phy. Instead
of a child node, the max_bitrate information is obtained by getting a
phy attribute. Fallback to the legacy API if no phy node is found.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b449400376b..ed6d84acea20 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
+#include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 
 /* napi related */
@@ -1582,6 +1583,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	struct device_node *np;
 	u32 mram_config_vals[MRAM_CFG_LEN];
 	u32 tx_fifo_size;
+	struct phy *transceiver;
 
 	np = pdev->dev.of_node;
 
@@ -1671,7 +1673,26 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	devm_can_led_init(dev);
 
-	of_can_transceiver(dev);
+	transceiver = devm_phy_optional_get(&pdev->dev, "can_transceiver");
+	if (IS_ERR(transceiver)) {
+		ret = PTR_ERR(transceiver);
+		dev_err(&pdev->dev, "Couldn't get phy. err=%d\n", ret);
+		return ret;
+	}
+
+	if (!transceiver) {
+		dev_warn(&pdev->dev, "No transceiver phy. Falling back to legacy API\n");
+		of_can_transceiver(dev);
+	} else {
+		ret = phy_power_on(transceiver);
+		if (ret) {
+			dev_err(&pdev->dev, "phy_power_on err:%d\n", ret);
+			return ret;
+		}
+		priv->can.bitrate_max = phy_get_max_bitrate(transceiver);
+		if (!priv->can.bitrate_max)
+			dev_warn(&pdev->dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	}
 
 	dev_info(&pdev->dev, "%s device registered (irq=%d, version=%d)\n",
 		 KBUILD_MODNAME, dev->irq, priv->version);
-- 
2.18.0

