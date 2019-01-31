Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C2DC282DB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VuRUPhMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfAaGQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:16:52 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19172 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfAaGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:16:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5292a70000>; Wed, 30 Jan 2019 22:16:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 22:16:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 22:16:35 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 06:16:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 06:16:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.12]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5292c20002>; Wed, 30 Jan 2019 22:16:34 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V8 4/5] i2c: tegra: Update transfer timeout
Date:   Wed, 30 Jan 2019 22:16:26 -0800
Message-ID: <1548915387-28826-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548915367; bh=bKYwxzKUCWGDWbAJc/rgyqJtTlAzhcUvstvJjJv36eM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VuRUPhMu5KsO9iupjID403wuX2dn/Qv9ZXYglbfVlGBSejjiOkzfpjpjwWmMY1GY4
         lv95VfBpe82cIroQ4+/+dEzYT0MCPCNCm+O5N9D+zfY7UMJozSg98i3w5VgVu43IkC
         gi0HpgM8vYCu1gPPNX467gx3CcnUOkR7Rnzh1lTt6fOny3KkerXXzkyNrTlW5R4hhJ
         WvaowuNajUxeCDL8HpclVTER8eUcRp9HGAbVmDGxznC1zvpaDaMzUWOPPHmGAFEKOs
         4+BYUiceuTSlWoS0lUW5jx5qKiVEMVtj75BR7BunVabBplYqUbnx1qirG2cgoDqZLU
         LyvsM3ZMzHV1A==
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
---
 [V8] : Added comment with explaination of xfer time calculation
 [V5/V6/V7] : Same as V4
 [V4] : V4 series includes bus clear support and this patch is updated with
	fixed timeout of 1sec for bus clear operation.
 [V3] : Same as V2
 [V2] : Added this patch in V2 series to allow enough time for data transfer
	to happen.
	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
	takes argument with this patch.

 drivers/i2c/busses/i2c-tegra.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 025d63972e50..435518cd91b6 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -25,7 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
@@ -901,8 +901,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
 		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
 		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 
-		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-							TEGRA_I2C_TIMEOUT);
+		time_left = wait_for_completion_timeout(
+						&i2c_dev->msg_complete,
+						TEGRA_I2C_TIMEOUT(1000));
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "timed out for bus clear\n");
 			return -ETIMEDOUT;
@@ -930,6 +931,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	int err = 0;
 	bool dma = false;
 	struct dma_chan *chan;
+	u16 xfer_time = 100;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
@@ -945,6 +947,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
 
 	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
+	/*
+	 * Transfer time = Total bits / transfer rate
+	 * Total bits = 9 bits per byte (including ACK bit) + Start & stop bits
+	 */
+	xfer_time += DIV_ROUND_CLOSEST(((xfer_size * 9) + 2) * 1000,
+					i2c_dev->bus_clk_rate);
+
 	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN);
 	if (dma) {
 		err = tegra_i2c_init_dma_param(i2c_dev);
@@ -1063,7 +1072,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 		time_left = wait_for_completion_timeout(
 						&i2c_dev->dma_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
@@ -1086,7 +1095,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	}
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
 
 	if (time_left == 0) {
-- 
2.7.4

