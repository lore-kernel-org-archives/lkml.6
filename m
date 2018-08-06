Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57134C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5D021A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5D021A29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbeHFVEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:04:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37140 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbeHFVEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:04:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 951A7207DA; Mon,  6 Aug 2018 20:54:15 +0200 (CEST)
Received: from localhost (LPuteaux-656-1-243-71.w82-127.abo.wanadoo.fr [82.127.120.71])
        by mail.bootlin.com (Postfix) with ESMTPSA id 55D4D2072D;
        Mon,  6 Aug 2018 20:54:15 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 3/6] i2c: designware: allow IP specific sda_hold_time
Date:   Mon,  6 Aug 2018 20:54:09 +0200
Message-Id: <20180806185412.7210-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because some old designware IPs were not supporting setting an SDA hold
time, vendors developed their own solution. Add a way for the final driver
to provide its own SDA hold time handling.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 2 ++
 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e67d6c7d552c..463906a02c7f 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -201,6 +201,8 @@ int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 		dev_dbg(dev->dev, "SDA Hold Time TX:RX = %d:%d\n",
 			dev->sda_hold_time & ~(u32)DW_IC_SDA_HOLD_RX_MASK,
 			dev->sda_hold_time >> DW_IC_SDA_HOLD_RX_SHIFT);
+	} else if (dev->set_sda_hold_time) {
+		dev->set_sda_hold_time(dev);
 	} else if (dev->sda_hold_time) {
 		dev_warn(dev->dev,
 			"Hardware too old to adjust SDA hold time.\n");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 70c188d6fb6b..870444bbbcc4 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -269,6 +269,7 @@ struct dw_i2c_dev {
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
+	int			(*set_sda_hold_time)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
 };
-- 
2.18.0

