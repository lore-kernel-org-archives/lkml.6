Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563DBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F271020864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F271020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeGPIFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:05:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeGPIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:05:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5FCBCA0;
        Mon, 16 Jul 2018 07:39:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.17 46/67] i2c: tegra: Fix NACK error handling
Date:   Mon, 16 Jul 2018 09:35:15 +0200
Message-Id: <20180716073450.499931251@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

commit 54836e2d03e76d80aec3399368ffaf5b7caadd1b upstream.

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
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-tegra.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -547,6 +547,14 @@ static int tegra_i2c_disable_packet_mode
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
@@ -708,15 +716,6 @@ static int tegra_i2c_xfer_msg(struct teg
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


