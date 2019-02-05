Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94998C4151A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81CB20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i5MkPkJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfBEB3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:29:32 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12453 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfBEB3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:29:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c58e6fd0000>; Mon, 04 Feb 2019 17:29:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Feb 2019 17:29:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Feb 2019 17:29:30 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 01:29:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Feb 2019 01:29:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.70]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c58e6fa0000>; Mon, 04 Feb 2019 17:29:30 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V10 4/5] i2c: tegra: update transfer timeout
Date:   Mon, 4 Feb 2019 17:29:26 -0800
Message-ID: <1549330167-8690-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549330167-8690-1-git-send-email-skomatineni@nvidia.com>
References: <1549330167-8690-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549330174; bh=itHWOfvERrZ7LhhBzmA2pl8TQPGU5Ks1SjlQhehy7F0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=i5MkPkJ95/o4oFixLfdRJ0aaL8UnyceKBrlNpZAx+hZWtgKsc2VKvGXRWmgp1VlmV
         feUrUH4XUo6HHF/NGUALcxR7gYM9l7R83Mksm87xiKqKGGoBh3U53pCLQyKlF95k9z
         f2SNF+YTvZbnP6UivYybeDOy2hkht65ICbrHiZWQ5B/ieRT7Qh1uOVbmhq/xAIY7Ay
         SsEnmHz0a0xDkFPMYinZBnCsqoCKy3FJgqLazfyFJVFQrHPUgaPGzWF2PcrQBmYpOW
         h9fKDlDw5K+jJG9y3tv+oqAy1YfHFSKQEEAULvJOdMk8EEZcUjGOrvGFhEifOyk4uy
         5MXEP0YUzwMiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 allows max of 64K bytes and Tegra186 and prior allows
max of 4K bytes of transfer per packet.

one sec timeout is not enough for transfers more than 10K bytes
at STD bus rate.

This patch updates I2C transfer timeout based on the transfer size
and I2C bus rate to allow enough time during max transfer size at
lower bus speed.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---
 [V10] : Reduced the timeout for bus clear operation
	Added adapter timeout to cover worst case transfer rate (max transfer
	size at STD speed) incase if ARB LOST happens during middle/end of 
	the transaction.
 [V9] : Rebased to 5.0-rc4
	Minor updates for readability of xfer time
 [V8] : Added comment with explaination of xfer time calculation
 [V5/V6/V7] : Same as V4
 [V4] : V4 series includes bus clear support and this patch is updated with
	fixed timeout of 1sec for bus clear operation.
 [V3] : Same as V2
 [V2] : Added this patch in V2 series to allow enough time for data transfer
	to happen.
	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
	takes argument with this patch.

 drivers/i2c/busses/i2c-tegra.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 658cf01e3f59..341475204cb6 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -25,7 +25,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
@@ -936,8 +935,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
 		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
 		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 
-		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-							TEGRA_I2C_TIMEOUT);
+		time_left = wait_for_completion_timeout(
+						&i2c_dev->msg_complete,
+						msecs_to_jiffies(50));
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "timed out for bus clear\n");
 			return -ETIMEDOUT;
@@ -964,6 +964,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	u32 *buffer = NULL;
 	int err = 0;
 	bool dma = false;
+	u16 xfer_time = 100;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
@@ -982,6 +983,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN) && i2c_dev->dma_buf;
 	i2c_dev->is_curr_dma_xfer = dma;
 
+	/*
+	 * Transfer time in mSec = Total bits / transfer rate
+	 * Total bits = 9 bits per byte (including ACK bit) + Start & stop bits
+	 */
+	xfer_time += DIV_ROUND_CLOSEST(((xfer_size * 9) + 2) * MSEC_PER_SEC,
+					i2c_dev->bus_clk_rate);
+
 	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
 
 	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
@@ -1089,7 +1097,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 		time_left = wait_for_completion_timeout(
 						&i2c_dev->dma_complete,
-						TEGRA_I2C_TIMEOUT);
+						msecs_to_jiffies(xfer_time));
 
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
@@ -1110,8 +1118,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		}
 	}
 
-	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-						TEGRA_I2C_TIMEOUT);
+	time_left = wait_for_completion_timeout(
+					&i2c_dev->msg_complete,
+					msecs_to_jiffies(xfer_time));
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
 
 	if (time_left == 0) {
@@ -1367,6 +1376,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.retries = 1;
+	i2c_dev->adapter.timeout = msecs_to_jiffies(6 * MSEC_PER_SEC);
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
-- 
2.7.4

