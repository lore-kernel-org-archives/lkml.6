Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D77AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE4C2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE4C2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeIREUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:20:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIREUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:20:33 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E857BCAC;
        Mon, 17 Sep 2018 22:51:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zumeng Chen <zumeng.chen@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 42/56] mfd: ti_am335x_tscadc: Fix struct clk memory leak
Date:   Tue, 18 Sep 2018 00:42:15 +0200
Message-Id: <20180917213829.658724921@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zumeng Chen <zumeng.chen@gmail.com>

[ Upstream commit c2b1509c77a99a0dcea0a9051ca743cb88385f50 ]

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
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/ti_am335x_tscadc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -224,14 +224,13 @@ static	int ti_tscadc_probe(struct platfo
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


