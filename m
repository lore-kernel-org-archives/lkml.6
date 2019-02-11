Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E97C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3785721B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="jOAWbGl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfBKQtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:52 -0500
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:49259
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfBKQtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02EEmL7KkDY0boFc52AqfVdNRQfQIlh3LJdfe8zrT4s=;
 b=jOAWbGl5YfSAj2vKFQUoe6f+rguOfX+IyZsWS3Mt0KFh9NL5ocHHN13Oto/u+spvGl2vAMM2PF3jQriechqZi+riTMuvykmBIeCywnTPJpPxl8DTGNxbxFzXKYvn3Ju2WkkHtjp9s8rsCmn6Gzs3e7B9EntJmabrQZ3MoLjySag=
Received: from AM0PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:208:ab::38)
 by VI1PR06MB4736.eurprd06.prod.outlook.com (2603:10a6:803:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Mon, 11 Feb
 2019 16:49:28 +0000
Received: from AM5EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::200) by AM0PR06CA0025.outlook.office365.com
 (2603:10a6:208:ab::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:49:28 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT049.mail.protection.outlook.com (10.152.9.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:49:27 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:27 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:25 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v6 3/5] i2c: ocores: add polling interface
Date:   Mon, 11 Feb 2019 17:49:11 +0100
Message-ID: <20190211164913.5988-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB4736;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4e7b19-8352-4dd5-e9dd-08d69040e30e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB4736;
X-MS-TrafficTypeDiagnostic: VI1PR06MB4736:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4736;20:oiKvUIM4+0CCa2Z0AVOmaPDjOf3A5/K2l/zFLkWMUqDLuE390IhPGXyeXWW2oC3/N7vfoTTcBtq+mJCDzwrcQUVCKPJXjU/X66ql9EXeyyQUVtns93bzZkWUEzDQpmP92MXy990X+K/jMOKm/wcDRzS0s0dsiq7LOI1hlFaQmD26gIzUkr9vPL/3OgcuLyHuPthLcQi+CY6B9MRBHFnvSNTpfOiOBEmaOiXzINz08aCXX581Mme+UaWju5Jt1ynB/B7gG5XbgDkIhVdN4fqavlieVxCfzrN6nNSEulIFkDnx/Ph7hFfqh/exNaP3wNxgy0QUe4P0KMU+YbVro/ThjSwXL95/Tzi3itervRDx6EEQjQJt3S6WlYGsSImKYv7e1TfLTh2aD6GKvEjSK9svtcmEme4B1mclVNngm4C29YF5Re4qBIcy60Q3hhMngLFxZEoMQdupPTrM2XvAX/zH9y0vTksUqtDw34XI90C6xFL9D/A8UWM/Gs7S2bWBSCbm;4:kTFJyKNui66vFqf56s5oa9iZk3nAu0y5oSDob/5g+dDNx+MnVGklxx1dvnwgmzDJlQXhcRnCQ1it1/hKjLR+cecaOA52Cg2HZ0SWWQiG/iv48gt3FmHDG50JPuTL9Yy/9Aks3dKY5T3tJD2VGURQEmbk8uUsm2dhrvfNfdUnXIibvrTmrA6us13/vr4evvhOdGWASuIlOaYFy6FlnpfC3/JCR4j4WrAjo2cLQrTwN9fKhgDxdHqK2XQmZWFvApCBgPbldeC5nPvYCdMmh7x8WHYfb+5T1Wj7TxxLrc8eLhs=
X-Microsoft-Antispam-PRVS: <VI1PR06MB4736EA0BF2AB427582B72523EF640@VI1PR06MB4736.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4736;23:T3+2z9SL3CPPsAIQDSe6JP/E1O/cRjuhx7hx3XPA8lUyPdrOjg7nxK9X4navKIxlmcrk6fNX/c8vnqi2Vd9tad6RO0qSK3H8jkUV/TKlXnNNLXLLOBgH5qRBgdfNzysOtM2rzhja5R4leSNkvNQRutu36zIqEDReiIKWS28E7q846rQqzKrNpIhZb8Y1W5Ho;6:LoraVKsntPG5olAqsiQtXz4sOXrGaLPhHafMOkfA6mNJWbLv0+l+L13gdJMZ5+TrSaiHGQ4pzdKwOEbtmrskZ+ldaI78jvzTWADoMztnZjT7n6Wn16IXCvdtcd5nRf/s7EvUNLlC86xjzcG6YfB4pCWkF6lu/2Y1f3rP9RChsttu4ieyrJqEOH6u19Xo4G25NEXPhGGVh96YCzkwm54qPpD5apX89ZeTBXXiA1C4Z4O4to9pozthyL3ewouNGHn+7H2BxRaIZq7aiR6Ce54ICzssIc1J5j+SP82hfX2qeUCowaFmkEyu44HkmYQQFDouhl+zh1aiyoirCYEqXodIqsq+lQmTNpEiUZ7BpLN0rIjt7aMGMdOQp1FpDXRosO0HbRkj+mo0ft/KIb313eaUML2nOFK0HSXUXMWTCs0SSmDlLuZkZjkDeYeCxB0ZKt4lnf0vp5AX5uAOJadcmGFYrA==;5:783MwAhyNohr0ViVZp2ji3I2hsVrm1ykDznWmV0EoOwXScxtozJwE0kLiBqFSe2WmJHAXAGLeitk3Q92/z12Jjk6nRen3hdedimqvYYZw7/cN0xes0SbHKhIyKljWccTcZdQydThiga4iDZR48lQdTOPPUMc0V6DRyGQP65Fb/bluMCKGKYrvq7VTPBKceJGCovCHrNVIg/pBDebffJK1Q==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3m10yrsmhEtqnT1z4efH6hdJd91SMWSWjE83hv21An6OW66S7dtrafYuUAUHKkHf1dZbKsv+IwDxlREipVbPgq+0Isw7eaKxjJps1f9YgIUx3yT0zUcqJX/dFyPofBfgGhppDozJc5NS1utQ64RfdjyKpnyd89efGHV6D7w2mDV87vNRzA3j2SWFtlkmVs0wqCNXiRyXiakx83mXbN1G0FiyvGTMCzcM+94cRpVwWHaVYjdFX6TsmX11+6qB8vkTt9bt7XRCuzUNWOBIHaWOTWnPKDr5E08rq/XCLQ1wIfVtnzDO0lGFx5Pqk7fftak4dsyzoF8jUhv7yalSNwEC+NmQ1ExCWH6ZoCbi6uWlF+p7QHRw4BPdWJECSTRMMMICs49UpH4Btof8CYDopngo1YmhNyugLROAMW32CkRggyH6WOlY95s2Dm6h0IJ/B4VF5w+qS+jlmeafVKr+z4Iroeq7eXCfv1XJanTlxElL7vbRPKH/6qJzPmhNAVWmuoWawhGlmxfsGkRfOheGQll6rkc8OaFb22uIG153rymaNtc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4736;7:B3ogtAzVCcBNE5d3/nnaFOkAE2PYivW53YVaYqYbvqrKaHVbYctyrkF/d3HhPwWTc1sWwkcn/FXOg4BZDxsz335tbU1jAW7yWLy6JKYx/BM4mLEdFiYyECMF+AqksymmcEoXXQzzIWUidXiPdxwyYg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:49:27.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4e7b19-8352-4dd5-e9dd-08d69040e30e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4736
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

