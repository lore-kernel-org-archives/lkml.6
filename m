Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5942C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D34C2238E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D34C2238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeGCIzv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:55:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3237 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeGCIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:55:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3b3a150000>; Tue, 03 Jul 2018 01:55:49 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Jul 2018 01:55:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Jul 2018 01:55:48 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Jul
 2018 08:55:48 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 3 Jul 2018 08:55:48 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.122]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b3b3a120001>; Tue, 03 Jul 2018 01:55:47 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] i2c: tegra: Fix NACK error handling
Date:   Tue, 3 Jul 2018 09:55:43 +0100
Message-ID: <1530608143-9222-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 Cardhu the PCA9546 I2C mux is not ACK'ing I2C commands on
resume from suspend (which is caused by the reset signal for the I2C
mux not being configured correctl). However, this NACK is causing the
Tegra30 to hang on resuming from suspend which is not expected as we
detect NACKs and handle them. The hang observed appears to occur when
resetting the I2C controller to recover from the NACK.

Commit 77821b4678f9 ("i2c: tegra: proper handling of error cases") added
additional error handling for some error cases including NACK, however,
it appears that this change conflicts with an early fix by commit
f70893d08338 ("i2c: tegra: Add delay before resetting the controller
after NACK"). After commit 77821b4678f9 was made we now disable 'packet
mode' before the delay from commit f70893d08338 happens. Testing shows
that moving the delay to before disabling 'packet mode' fixes the hang
observed on Tegra30. The delay was added to give the I2C controller
chance to send a stop condition and so it makes sense to move this to
before we disable packet mode. Please note that packet mode is always
enabled for Tegra.

Fixes: 77821b4678f9 ("i2c: tegra: proper handling of error cases")

Cc: stable@vger.kernel.org

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 5fccd1f1bca8..797def5319f1 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -545,6 +545,14 @@ static int tegra_i2c_disable_packet_mode(struct tegra_i2c_dev *i2c_dev)
 {
 	u32 cnfg;
 
+	/*
+	 * NACK interrupt is generated before the I2C controller generates
+	 * the STOP condition on the bus. So wait for 2 clock periods
+	 * before disabling the controller so that the STOP condition has
+	 * been delivered properly.
+	 */
+	udelay(DIV_ROUND_UP(2 * 1000000, i2c_dev->bus_clk_rate));
+
 	cnfg = i2c_readl(i2c_dev, I2C_CNFG);
 	if (cnfg & I2C_CNFG_PACKET_MODE_EN)
 		i2c_writel(i2c_dev, cnfg & ~I2C_CNFG_PACKET_MODE_EN, I2C_CNFG);
@@ -706,15 +714,6 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
 		return 0;
 
-	/*
-	 * NACK interrupt is generated before the I2C controller generates
-	 * the STOP condition on the bus. So wait for 2 clock periods
-	 * before resetting the controller so that the STOP condition has
-	 * been delivered properly.
-	 */
-	if (i2c_dev->msg_err == I2C_ERR_NO_ACK)
-		udelay(DIV_ROUND_UP(2 * 1000000, i2c_dev->bus_clk_rate));
-
 	tegra_i2c_init(i2c_dev);
 	if (i2c_dev->msg_err == I2C_ERR_NO_ACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
-- 
1.9.1

