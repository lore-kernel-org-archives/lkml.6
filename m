Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06315C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B357023CE8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B357023CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeGDEgf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:36:35 -0400
Received: from mail.windriver.com ([147.11.1.11]:64532 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeGDEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:36:34 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w644aQDX015731
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 3 Jul 2018 21:36:26 -0700 (PDT)
Received: from pek-lpggp4.wrs.com (128.224.153.77) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.399.0; Tue, 3 Jul 2018
 21:36:19 -0700
From:   Zumeng Chen <zumeng.chen@gmail.com>
To:     <lee.jones@linaro.org>, <rachna@ti.com>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH] mfd: ti_am335x_tscadc: Fix struct clk memory leak
Date:   Wed, 4 Jul 2018 12:35:29 +0800
Message-ID: <1530678929-24482-1-git-send-email-zumeng.chen@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_elk_get() to let Linux manage struct clk memory to avoid the following
memory leakage report:

unreferenced object 0xdd75efc0 (size 64):
  comm "systemd-udevd", pid 186, jiffies 4294945126 (age 1195.750s)
  hex dump (first 32 bytes):
    61 64 63 5f 74 73 63 5f 66 63 6b 00 00 00 00 00  adc_tsc_fck.....
    00 00 00 00 92 03 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<c0a15260>] kmemleak_alloc+0x40/0x74
    [<c0287a10>] __kmalloc_track_caller+0x198/0x388
    [<c0255610>] kstrdup+0x40/0x5c
    [<c025565c>] kstrdup_const+0x30/0x3c
    [<c0636630>] __clk_create_clk+0x60/0xac
    [<c0630918>] clk_get_sys+0x74/0x144
    [<c0630cdc>] clk_get+0x5c/0x68
    [<bf0ac540>] ti_tscadc_probe+0x260/0x468 [ti_am335x_tscadc]
    [<c06f3c0c>] platform_drv_probe+0x60/0xac
    [<c06f1abc>] driver_probe_device+0x214/0x2dc
    [<c06f1c18>] __driver_attach+0x94/0xc0
    [<c06efe2c>] bus_for_each_dev+0x90/0xa0
    [<c06f1470>] driver_attach+0x28/0x30
    [<c06f1030>] bus_add_driver+0x184/0x1ec
    [<c06f2b74>] driver_register+0xb0/0xf0
    [<c06f3b4c>] __platform_driver_register+0x40/0x54

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 47012c0..7a30546 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -209,14 +209,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	 * The TSC_ADC_SS controller design assumes the OCP clock is
 	 * at least 6x faster than the ADC clock.
 	 */
-	clk = clk_get(&pdev->dev, "adc_tsc_fck");
+	clk = devm_clk_get(&pdev->dev, "adc_tsc_fck");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get TSC fck\n");
 		err = PTR_ERR(clk);
 		goto err_disable_clk;
 	}
 	clock_rate = clk_get_rate(clk);
-	clk_put(clk);
 	tscadc->clk_div = clock_rate / ADC_CLK;
 
 	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
-- 
2.7.4

