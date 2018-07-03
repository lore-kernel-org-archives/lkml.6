Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2754E219EE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WuSi3afr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2754E219EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeGCLP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:15:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52552 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeGCLPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:15:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w63BFJeC091956;
        Tue, 3 Jul 2018 06:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530616519;
        bh=Xowt0NvKxuoYviv3Im9vDqOwJcJgbcZg2wbC6XamJZg=;
        h=From:To:CC:Subject:Date;
        b=WuSi3afrvIdurpUTgLOxc0oYPiv/7mKmuZDN1ecwA8tzLmVQgQWUSRIjDsSgSqaYU
         jX0j5mNdyb6HQBy+prAGtDr5M1OA6cZm621cTIgK7cg6Y4nBrFRcfdSkBM6K967ygz
         bGB7XONi90/5NW8NBbzrByLBpm1P4GKQQDbuk4UM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w63BFJNc011625;
        Tue, 3 Jul 2018 06:15:19 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 06:15:19 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 06:15:19 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w63BFGrZ004157;
        Tue, 3 Jul 2018 06:15:17 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2] can: m_can: Move accessing of message ram to after clocks are enabled
Date:   Tue, 3 Jul 2018 16:47:10 +0530
Message-ID: <20180703111710.27084-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCAN message ram should only be accessed once clocks are enabled.
Therefore, move the call to parse/init the message ram to after
clocks are enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
Changes in v2:

rebased to latest mainline

 drivers/net/can/m_can/m_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ac4c6dc2f8c8..04c48371ab2a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1644,8 +1644,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(cclk);
 	priv->mram_base = mram_addr;
 
-	m_can_of_parse_mram(priv, mram_config_vals);
-
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -1668,6 +1666,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	m_can_of_parse_mram(priv, mram_config_vals);
+
 	devm_can_led_init(dev);
 
 	of_can_transceiver(dev);
@@ -1715,8 +1715,6 @@ static __maybe_unused int m_can_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	m_can_init_ram(priv);
-
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
@@ -1726,6 +1724,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		m_can_init_ram(priv);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
 		netif_start_queue(ndev);
-- 
2.17.0

