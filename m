Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933030AbeBLW51 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:57:27 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37550 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932695AbeBLWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:27 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 12/45] rtc: m48t86: call rtc_nvmem_register()
Date: Mon, 12 Feb 2018 23:47:26 +0100
Message-Id: <20180212224759.15999-13-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call rtc_nvmem_register instead of letting the core do it and stop using
the nvmem_config member of struct rtc_device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m48t86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index d9aea9b6d9cd..3a48a7eb3e9c 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -266,13 +266,14 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	info->rtc->ops = &m48t86_rtc_ops;
 
 	m48t86_nvmem_cfg.priv = &pdev->dev;
-	info->rtc->nvmem_config = &m48t86_nvmem_cfg;
 	info->rtc->nvram_old_abi = true;
 
 	err = rtc_register_device(info->rtc);
 	if (err)
 		return err;
 
+	rtc_nvmem_register(info->rtc, &m48t86_nvmem_cfg);
+
 	/* read battery status */
 	reg = m48t86_readb(&pdev->dev, M48T86_D);
 	dev_info(&pdev->dev, "battery %s\n",
-- 
2.16.1
