Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA18CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3E12077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3E12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeICViP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbeICViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55A5ED13;
        Mon,  3 Sep 2018 17:17:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 040/165] can: m_can: Move accessing of message ram to after clocks are enabled
Date:   Mon,  3 Sep 2018 18:55:26 +0200
Message-Id: <20180903165657.110812303@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Faiz Abbas <faiz_abbas@ti.com>

[ Upstream commit 54e4a0c486041dc1c20593d997fafd67089e8408 ]

MCAN message ram should only be accessed once clocks are enabled.
Therefore, move the call to parse/init the message ram to after
clocks are enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/m_can/m_can.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1637,8 +1637,6 @@ static int m_can_plat_probe(struct platf
 	priv->can.clock.freq = clk_get_rate(cclk);
 	priv->mram_base = mram_addr;
 
-	m_can_of_parse_mram(priv, mram_config_vals);
-
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -1649,6 +1647,8 @@ static int m_can_plat_probe(struct platf
 		goto failed_free_dev;
 	}
 
+	m_can_of_parse_mram(priv, mram_config_vals);
+
 	devm_can_led_init(dev);
 
 	dev_info(&pdev->dev, "%s device registered (irq=%d, version=%d)\n",
@@ -1698,8 +1698,6 @@ static __maybe_unused int m_can_resume(s
 
 	pinctrl_pm_select_default_state(dev);
 
-	m_can_init_ram(priv);
-
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
@@ -1709,6 +1707,7 @@ static __maybe_unused int m_can_resume(s
 		if (ret)
 			return ret;
 
+		m_can_init_ram(priv);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
 		netif_start_queue(ndev);


