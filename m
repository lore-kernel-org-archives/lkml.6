Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ADEC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5FC20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5FC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeHaTTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:19:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46999 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeHaTTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:19:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A0CD020756; Fri, 31 Aug 2018 17:11:50 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 48B5322A39;
        Fri, 31 Aug 2018 17:11:28 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 3/7] i2c: designware: allow IP specific sda_hold_time
Date:   Fri, 31 Aug 2018 17:11:10 +0200
Message-Id: <20180831151114.25739-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because some old designware IPs were not supporting setting an SDA hold
time, vendors developed their own solution. Add a way for the final driver
to provide its own SDA hold time handling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 2 ++
 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 69ec4a791f23..36271cd75342 100644
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
index e367b1af4ab2..f6cad20a86ff 100644
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
2.19.0.rc1

