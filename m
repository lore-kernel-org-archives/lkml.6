Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B36222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Oj5DkcYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437732AbfBNIwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:52:00 -0500
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:35102
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437698AbfBNIv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02EEmL7KkDY0boFc52AqfVdNRQfQIlh3LJdfe8zrT4s=;
 b=Oj5DkcYk6NyYGarTlaipucRca0b2ChHaxRLBXjMwO7nVNl4Pd3iCSyBbu9YCtosRtI8oWHY+M3pbCb/0alA4Oe4cdLaFAgbnH4wit9T0t1bi56sABrXfi+N2m475IT0I9irFD5GhYCkSMDXxqg6Vv3wr9fbuWI0597c+Kyk7GKU=
Received: from VI1PR0601CA0012.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::22) by AM4PR0601MB2146.eurprd06.prod.outlook.com
 (2603:10a6:200:47::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Thu, 14 Feb
 2019 08:51:51 +0000
Received: from HE1EUR02FT053.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::209) by VI1PR0601CA0012.outlook.office365.com
 (2603:10a6:800:1e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 08:51:50 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT053.mail.protection.outlook.com (10.152.11.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 08:51:50 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:47 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:46 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v7 3/5] i2c: ocores: add polling interface
Date:   Thu, 14 Feb 2019 09:51:32 +0100
Message-ID: <20190214085134.12900-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214085134.12900-1-federico.vaga@cern.ch>
References: <20190214085134.12900-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(14444005)(48376002)(356004)(86362001)(16526019)(1076003)(50466002)(26005)(6666004)(186003)(53416004)(478600001)(107886003)(476003)(126002)(66066001)(956004)(8936002)(2616005)(426003)(4326008)(8676002)(54906003)(47776003)(51416003)(11346002)(16586007)(446003)(486006)(7696005)(50226002)(316002)(7736002)(76176011)(74482002)(7636002)(6116002)(336012)(3846002)(2906002)(786003)(106002)(106466001)(305945005)(36756003)(246002)(110136005)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2146;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e945f4f-cc21-4dd6-b342-08d69259a911
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2146;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2146:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;20:5YYMy+WuabHT+50j4D9+mwszr9LlvEk17Z4IMqpcZLxps+qLTmkn48If8rbHxL2dxpIpEYnndsZtWUgebnL4VXclKtYBUcmniC/53+MHQ6gIHpUW7sJYSxcXFG4YHTdn7fSHqc/9VTbyFpXfs3UCQY72qbtw5shPSOGoDr29wbJbTRKbEeZ+k3VsAGd4Qi6CIX3tTZTvAqOU5TidDPms+4VLBaPKg2m6B2sJob2YIZUeJY+jWr7xE36ttEW0LQNTvXm4WPxrII1068uLSpcivRulFKr4RzQz5GzgeSSSDeiBL8tlkIlDn1DVTkHFnL4QObJ6KhqKYSWRhzwEDgR4wUN1z1qfbCKK5kBIJBOU6eigGqZoUmSpsM1lMwXHS+V0nRE5EphSJGW6yZpHnv6bKEYMzKAqz+1b11SDd/bg0XsImjRFT3BkvmOf625qIf20ccGAa4hIU3AvIQXMp/6HJSasLwFJOrTp6mc59HruxM4EmYB68R9GCDgwzaeiOm2K
X-Microsoft-Antispam-PRVS: <AM4PR0601MB2146ECAABE77EE2BFB5E3C21EF670@AM4PR0601MB2146.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0601MB2146;23:q8U+6IgM2pgFtH1zK5LlNo3AmW3XDncRBgG2KPp?=
 =?us-ascii?Q?Y/ZmYex0pKXrxTSHunawKM/1LXsEuqnji7drKeBPEw7+dj8u1Zhj+zIVN6Mh?=
 =?us-ascii?Q?zS4NJKoEzhCnKOKnllAwProcp5R/RKTpP39hPWOCumAab3Joe9ZmV9Qfu5Al?=
 =?us-ascii?Q?pkp6c40aBRPYBu8q7zV0Mw9/JsjBWX53dDuuzeEcX45JoOd6DmWk3ggO9Ces?=
 =?us-ascii?Q?16kSkBDhx7rY2ZggA/IprCUeVpndguiFew/n0pYTJDRbRI0VZO5rvT5C0YY6?=
 =?us-ascii?Q?8g4WdgrETN/2qsrtyyUuKkNrVc6mDXQFgWm902RtBmhOfrVrbCNS7+ryEr/m?=
 =?us-ascii?Q?Ibzw7Dow9I64PXCoP7VEGRHEy74IaA4yuzbv0XKhbaVsm0uq+l7FMEc2xgDD?=
 =?us-ascii?Q?nQ6sPBNhy1WroT6rECawtFxKKQ0uf3w+7fSTQqwh3uFsYngtNo40+YmTkJN0?=
 =?us-ascii?Q?PWyJcGyQzSW4EJ5wBt4uBPeieE9wH3FQ3jkNjmknPQX+if8b/8Vf61tM2xT6?=
 =?us-ascii?Q?Z7pP15+eQuL3Ov1ZGBgfOoTCAlPWm1qbIkD3z+2oFmxECnzE4lPKS/Q/yv9a?=
 =?us-ascii?Q?6OLE+k9rHZ0OCdzKXk1/2SNG4La2N0hV7v5sRxULuuhvF2wzf7SFglDFlNDW?=
 =?us-ascii?Q?D7s2OnJusvDJcqi50usADFy0c3WpjZ52rlRPDHBgRPVZO8WnzXZa+7lUvd35?=
 =?us-ascii?Q?59nECg4acgDpqKFjTEGiHDfp8mxDqsJN2EGzH6tA2yBsmFTKB6Dnlt3TGnTP?=
 =?us-ascii?Q?ha8YAjNzK81wMafD9FYvhtSLKu7WAfk1EWBuj12ky/CDCa+hdW8/hMlnEOZS?=
 =?us-ascii?Q?sqBwuuG6Uq+2XYkdlzPsUPoCmtA3xmL1CE4lDKuNWGga+QVLsFIrKMTBAk53?=
 =?us-ascii?Q?s43ZlDL0lezIQ1uppbf3dIeR3bk+cMZr80kWRD6TdIHHSlqYvy1S52uB4ASu?=
 =?us-ascii?Q?c/yGBAVc2BmXV46a7OeEGgk73UfmrpE+/cIIlPNJqJNqxq7Y5J5nN5jQyQaL?=
 =?us-ascii?Q?2Q95xQwDsnjGpC8tHwk3yBuArRkvrR6FIKskU6sNbzZd+y96sSRXLhxhJq11?=
 =?us-ascii?Q?F+qoNvORxcvXM6NEufM0BxQBAnoRbWL0NqMFm3L+6JTLeFY1/SUuD5GKvGJz?=
 =?us-ascii?Q?vbXh5B5s6SSRt0TdXbwODImO3ZL9o7EPOd1lMHZNZfloO1+4ygeHZGzNLLcn?=
 =?us-ascii?Q?kuw9GOqF/xUZbFjgGZlpmlIQqi/JiX+mPklJH?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BX6GBF5zUj9IZcim14XXyP2vRnBUQm9PKqOFzHxOSp24Z20WfYmbYkCWpl/JJ8UiO22smcADYecVtT2G/fjJpR6G/qCRn+q2wlPOx8Eiz+tLGQ9hPyoGcFwNQwWX8kttA60QFPcN5NuRi9q/JEvShtgpR9VyejIc+trCQbMonicZ1B1sZoL2VlsQWFBn0Wov+6oaoioEJGag6rG4QXBbJqM4tnyULVGpwdhc6Fi472WVTC4JeO4LFBYsxJRN1N9N+PhQORtYqouEpFI01SbGe69XlCFSF9WM9sxtRGd0s771nyqgOAxEceS8fIBYS17ro7EfFh8iysKjWErw7hf0a/xzT3UgcjSzceXEWrUIYFtrKiRnM7oHayOM63N9v2i0IFdbpwopAQFo3QvbhRgnTLgjRbhKuMR7qq37ZIqftCU=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 08:51:50.2805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e945f4f-cc21-4dd6-b342-08d69259a911
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver assumes that an interrupt line is always available for
the I2C master. This is not always the case and this patch adds support
for a polling version.

Report from Andrew Lunn:

  I did some timing tests for this. On my box, we request a udelay of
  80uS. The kernel actually delays for about 79uS. We then spin in
  ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.

  There are actually 9 bits on the wire, not 8, since there is an
  ACK/NACK bit after the actual data transfer. So i changed the delay to
  (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
  not looping at all. But for reading an 4K AT24 EEPROM, it increased
  the read time by 10ms, from 424ms to 434ms. So we should probably keep
  with 8.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 182 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index fcc2558..5dea7b9 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -26,6 +27,9 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/spinlock.h>
+#include <linux/jiffies.h>
+
+#define OCORES_FLAG_POLL BIT(0)
 
 /**
  * @process_lock: protect I2C transfer process.
@@ -35,6 +39,7 @@ struct ocores_i2c {
 	void __iomem *base;
 	u32 reg_shift;
 	u32 reg_io_width;
+	unsigned long flags;
 	wait_queue_head_t wait;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
@@ -246,10 +251,116 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
 	spin_unlock_irqrestore(&i2c->process_lock, flags);
 }
 
-static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+/**
+ * Wait until something change in a given register
+ * @i2c: ocores I2C device instance
+ * @reg: register to query
+ * @mask: bitmask to apply on register value
+ * @val: expected result
+ * @timeout: timeout in jiffies
+ *
+ * Timeout is necessary to avoid to stay here forever when the chip
+ * does not answer correctly.
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout
+ */
+static int ocores_wait(struct ocores_i2c *i2c,
+		       int reg, u8 mask, u8 val,
+		       const unsigned long timeout)
+{
+	unsigned long j;
+
+	j = jiffies + timeout;
+	while (1) {
+		u8 status = oc_getreg(i2c, reg);
+
+		if ((status & mask) == val)
+			break;
+
+		if (time_after(jiffies, j))
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/**
+ * Wait until is possible to process some data
+ * @i2c: ocores I2C device instance
+ *
+ * Used when the device is in polling mode (interrupts disabled).
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout
+ */
+static int ocores_poll_wait(struct ocores_i2c *i2c)
+{
+	u8 mask;
+	int err;
+
+	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR) {
+		/* transfer is over */
+		mask = OCI2C_STAT_BUSY;
+	} else {
+		/* on going transfer */
+		mask = OCI2C_STAT_TIP;
+		/*
+		 * We wait for the data to be transferred (8bit),
+		 * then we start polling on the ACK/NACK bit
+		 */
+		udelay((8 * 1000) / i2c->bus_clock_khz);
+	}
+
+	/*
+	 * once we are here we expect to get the expected result immediately
+	 * so if after 1ms we timeout then something is broken.
+	 */
+	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
+	if (err)
+		dev_warn(i2c->adap.dev.parent,
+			 "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
+			 __func__, mask);
+	return err;
+}
+
+/**
+ * It handles an IRQ-less transfer
+ * @i2c: ocores I2C device instance
+ *
+ * Even if IRQ are disabled, the I2C OpenCore IP behavior is exactly the same
+ * (only that IRQ are not produced). This means that we can re-use entirely
+ * ocores_isr(), we just add our polling code around it.
+ *
+ * It can run in atomic context
+ */
+static void ocores_process_polling(struct ocores_i2c *i2c)
+{
+	while (1) {
+		irqreturn_t ret;
+		int err;
+
+		err = ocores_poll_wait(i2c);
+		if (err) {
+			i2c->state = STATE_ERROR;
+			break; /* timeout */
+		}
+
+		ret = ocores_isr(-1, i2c);
+		if (ret == IRQ_NONE)
+			break; /* all messages have been transferred */
+	}
+}
+
+static int ocores_xfer_core(struct ocores_i2c *i2c,
+			    struct i2c_msg *msgs, int num,
+			    bool polling)
 {
-	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
 	int ret;
+	u8 ctrl;
+
+	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
+	if (polling)
+		oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~OCI2C_CTRL_IEN);
+	else
+		oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN);
 
 	i2c->msg = msgs;
 	i2c->pos = 0;
@@ -259,16 +370,37 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
-	ret = wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-				 (i2c->state == STATE_DONE), HZ);
-	if (ret == 0) {
-		ocores_process_timeout(i2c);
-		return -ETIMEDOUT;
+	if (polling) {
+		ocores_process_polling(i2c);
+	} else {
+		ret = wait_event_timeout(i2c->wait,
+					 (i2c->state == STATE_ERROR) ||
+					 (i2c->state == STATE_DONE), HZ);
+		if (ret == 0) {
+			ocores_process_timeout(i2c);
+			return -ETIMEDOUT;
+		}
 	}
 
 	return (i2c->state == STATE_DONE) ? num : -EIO;
 }
 
+static int ocores_xfer_polling(struct i2c_adapter *adap,
+			       struct i2c_msg *msgs, int num)
+{
+	return ocores_xfer_core(i2c_get_adapdata(adap), msgs, num, true);
+}
+
+static int ocores_xfer(struct i2c_adapter *adap,
+		       struct i2c_msg *msgs, int num)
+{
+	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
+
+	if (i2c->flags & OCORES_FLAG_POLL)
+		return ocores_xfer_polling(adap, msgs, num);
+	return ocores_xfer_core(i2c, msgs, num, false);
+}
+
 static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 {
 	int prescale;
@@ -276,7 +408,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
 	prescale = clamp(prescale, 0, 0xffff);
@@ -294,7 +427,7 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 
 	/* Init the device */
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
 
 	return 0;
 }
@@ -451,10 +584,6 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -509,18 +638,29 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	init_waitqueue_head(&i2c->wait);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq == -ENXIO) {
+		i2c->flags |= OCORES_FLAG_POLL;
+	} else {
+		if (irq < 0)
+			return irq;
+	}
+
+	if (!(i2c->flags & OCORES_FLAG_POLL)) {
+		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
+				       pdev->name, i2c);
+		if (ret) {
+			dev_err(&pdev->dev, "Cannot claim IRQ\n");
+			goto err_clk;
+		}
+	}
+
 	ret = ocores_init(&pdev->dev, i2c);
 	if (ret)
 		goto err_clk;
 
-	init_waitqueue_head(&i2c->wait);
-	ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
-			       pdev->name, i2c);
-	if (ret) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		goto err_clk;
-	}
-
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = ocores_adapter;
-- 
2.15.0

