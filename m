Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BDC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B307321726
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y0x70Znt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfAZD6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:58:00 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19519 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAZD54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:57:56 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4bdac30000>; Fri, 25 Jan 2019 19:57:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 19:57:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 25 Jan 2019 19:57:56 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 26 Jan
 2019 03:57:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 26 Jan 2019 03:57:55 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4bdac30000>; Fri, 25 Jan 2019 19:57:55 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
Date:   Fri, 25 Jan 2019 19:57:52 -0800
Message-ID: <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548475075; bh=XvvqbS1z9f57RFui+7PPoT+5G1DjdCT6vDRPriaIsxU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Y0x70ZntYVq2iOKgv3uAEBEsVr4uq93sfV+j2wocdqg0HAo8qTqvX+HMz5PtHTpH7
         Ih6hHCT6zaO7Ajl09isDrkEVjRLlQ9QCxcTipZ3pE+GsK19L1sl74PiYqJpO/rlQ3b
         U41jqHH5SNhbIY6c5OpzSWSykdF6/RtEEfD3810yFdvrnk5amDVFEdGqj8MTFxLek6
         0UgNHMxoagyhD2Hk7mjww+IKQDi6uT+inQCGALjbDI59OrYKngxe+RYZN9Emp+M3fM
         zKqYF6Mt8s+AFgcS1ZP/Lv91BGmKCdul7Z7VfzAX4ZHFsTzHdt7NkYqzEuBkSSUr0o
         EirpG+IO+DBFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update I2C transfer timeout based on transfer bytes and I2C bus
rate to allow enough time during max transfer size based on the
speed.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V3] : Same as V2
 [V2] : Added this patch in V2 series to allow enough time for data transfer
	to happen.
	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
	takes argument with this patch.

 drivers/i2c/busses/i2c-tegra.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index aec500ef9a98..3dcbc9960d9d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -23,7 +23,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
@@ -116,6 +116,9 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -683,6 +686,17 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	u32 int_mask;
 	unsigned long time_left;
 	unsigned long flags;
+	u16 xfer_time = 100;
+	size_t xfer_size = 0;
+
+	if (msg->flags & I2C_M_RD)
+		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD);
+	else
+		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
+			    I2C_PACKET_HEADER_SIZE;
+
+	xfer_time += DIV_ROUND_CLOSEST((xfer_size * 9) * 1000,
+					i2c_dev->bus_clk_rate);
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
@@ -739,7 +753,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		i2c_readl(i2c_dev, I2C_INT_MASK));
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
 
 	if (time_left == 0) {
-- 
2.7.4

