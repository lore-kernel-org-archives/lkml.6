Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1476C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2A120844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="MBx9h3S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfBHQNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:13:49 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:64380
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfBHQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMxtgcJ7AI8cEYfkuHibQoKaSpmTQPYoLUfhZFtWQco=;
 b=MBx9h3S9WupKABwF24kti/S9rKhG2gg5waoBSLWcJcwA9l6aPqJq9e1/+Ch08sYd3+sckMbL3kMXLFb+pzqWaFRc6BTi1dZzMWybaMj0D65LFErfZvak05vTBn2Ovh7GlK91kaVeSaqmVGZeCXJlI6Gq6a7DcJRucB11RBTlCjU=
Received: from VI1PR06CA0103.eurprd06.prod.outlook.com (2603:10a6:803:8c::32)
 by HE1PR0602MB3258.eurprd06.prod.outlook.com (2603:10a6:7:1c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22; Fri, 8 Feb
 2019 16:12:24 +0000
Received: from AM5EUR02FT042.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::205) by VI1PR06CA0103.outlook.office365.com
 (2603:10a6:803:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21 via Frontend
 Transport; Fri, 8 Feb 2019 16:12:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT042.mail.protection.outlook.com (10.152.9.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 16:12:23 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:22 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:22 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 3/5] i2c:ocores: add polling interface
Date:   Fri, 8 Feb 2019 17:11:59 +0100
Message-ID: <20190208161201.7860-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(110136005)(16586007)(74482002)(7736002)(8676002)(786003)(316002)(478600001)(54906003)(7636002)(2906002)(1076003)(305945005)(47776003)(66066001)(246002)(356004)(6666004)(53416004)(16526019)(336012)(106466001)(76176011)(36756003)(186003)(26005)(6346003)(14444005)(7696005)(50466002)(446003)(11346002)(48376002)(8936002)(107886003)(106002)(956004)(486006)(44832011)(2616005)(476003)(126002)(426003)(4326008)(86362001)(50226002)(51416003)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3258;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a26d65-7b2e-4638-f95c-08d68de0362b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:HE1PR0602MB3258;
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3258:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3258;20:jzCsRtI57NT+PwHGUJs8pWhlNMfNvCfsaslOEfDgAMWrnuMVEJBzyI177QQnuHuzZKpPoQrnsA5Meb3dTZhlmDsIT6IprkoXmSlv3Y4rAtc3eXWQ0Aq5/wtYV2qershqBdO8+itkytOdiHRz3vjzvDVGHEp9hvjr76Qn2Okp6K5GaNDZr+2MXRpy0L5QMbo8VzuKtfO/TIGwYu/aepFvvX0qBsAEZc75sdEq3th7MEEbvEu1zZAh0qynDk0RTEFd5SakLYBH/23OPFr8HxoxxjWiZvRJ4o6a81RNOiyRybPNlBvJspePEEIClS931WnNOtijNcR1X3FzS1vP/7QaqW1+gi8Ejg4Ii3fJu0yrM2ugUi5cDj52DO2bumHa7ueA6yKOp5dntj9r5tun+8ajcAd3kCmN2RBi/FjIkKZLp6k/fndFHnQ//4YVJPA7jE3iOFoLg8GTQWOvh8fbUGe2IcgwgIsjBB4cSW02EcAU5J4xGMgqfKK7rSw34rNWcAFm;4:JWmWoTvX/W47h0dNICq3GD/FyF9GqPa3aAfBIraiezHi+XzIXHk4Zxqn5HRUY1a0blkxK6opzUvqT+4PJttd5CADnEuPvHTvVhmdKVIdT2Wl68lzYWgvHIqHfvulfCQpn2gcQxLrUxY+LjvxtKJpmc8Ig4aCRvUZ0LYbyH/8CR2+6oFtF1PHiPcyFwoOx9mY4EbDYYu4bsBd0gGvu6o/LB6oJJFfuNj6rrLxj7e1dgZa00KbIblDg1KfUV1nO/5MtMzBSftjvDPuNw+unJbqFij33tJgAunvCsIWdBa2rrs=
X-Microsoft-Antispam-PRVS: <HE1PR0602MB3258E563893F5299B3F70A53EF690@HE1PR0602MB3258.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0602MB3258;23:SJ7Sg63kkOvRwPUEwHm8SuQ7kE6JMBh/IhdBMDX?=
 =?us-ascii?Q?ihcOeRH6Foc4b9v4k2imLigWBJm32cYHoPlJl6ebAcIg5uEcQoZOflVKskvA?=
 =?us-ascii?Q?za91LyPlecnC89vWgUgWU4SJHGamzQJ78jk5cs+e5BBqVPTUJ9NjOhUkufih?=
 =?us-ascii?Q?JZvl56nK7o58YvBxrvXv9DoPXkRl5VcEWJLwfv8mavhLNuyNHiwkj0PW8DXk?=
 =?us-ascii?Q?+WQi6JElm9iR87mCuq/asrez8CGAV4KU0iFQbydPi7VBNMP4RZailrpAPo5W?=
 =?us-ascii?Q?uaKs7Ynnf/HvEGlZAdn49VTTjWpj6NpT0mmz4gCyYLSnR/hcZBDAO+yCgkrn?=
 =?us-ascii?Q?HJBjLh5B+vWxS5wfUmX15DpysHsnlRtN3CZLyS8GZZbmHNixru5EOKrkUlpJ?=
 =?us-ascii?Q?brza3lcIwT/UoDt5G9wk0zkgfObEjRG8BHfsr5B5jVnrFqrWEX1B541YT6OH?=
 =?us-ascii?Q?5x9r2Z6otKD5f9hHLY/UMHEhHxwXxwsdnWCmpC3UijF9XWKFSDZ/h0iDOYLF?=
 =?us-ascii?Q?8TPf65cN9FeTleciEChLlIpWBdVmoMaM9emgPGuXMGA1ONndhWmVIYN4H5dD?=
 =?us-ascii?Q?Zs+/aHn9gyJ93xC9BBvHMGQq1hT6W2NsAErAtMCezwYd8SV9TS/jAWS2bStE?=
 =?us-ascii?Q?kajYctnr04bMbOF655S1g8ijdRWaKex/hYuWN02j+KzCwfBP8xuO8uFAIlO1?=
 =?us-ascii?Q?wdo/Kt6lw3+bCWS1Z7SeQx+rFWAMVW8vRWjQPD4qcuMqmWA31kPn5+TsBbgn?=
 =?us-ascii?Q?8CkYjHNfuZXB+4jjMGtodieRz4wftdCXa1MxKPF1tVDj5qW7DJxmdVriEMRP?=
 =?us-ascii?Q?WCCe0Vst585XcDgRHGESabEhBF2I9XXaHIn2LEuorXajL3Vjr7PAygKet58A?=
 =?us-ascii?Q?Xeq18TaqCtnXZTf0iE2tjrt9MZaZ4T5HtPI4ja4/z7fkHNRuxyVg7uw14IRh?=
 =?us-ascii?Q?gZnvZbPWdxar28InDEJPclZnNek8WVdgt+GOPi/aaXgwhWiFJ1xoBd70tbsL?=
 =?us-ascii?Q?XOh73X/RqUKYj1Li1VpQ4Gj4YxTa2WiglWrEczYLsjeDTij1pyIjkPFAax6b?=
 =?us-ascii?Q?5UniE/ZDZkf0zbM5zTYzr78mAxDl/fIDzxIMEUVN9F/00YkXOPe9XrzTekhN?=
 =?us-ascii?Q?kO2O8Qzntg/4EWSIsvzKdpoRU8cf83eWeZC/PjuRhHo0EaFve6HLwGfqH2mU?=
 =?us-ascii?Q?NomYpe1H1R/D+OScOtKCTk0W0lpH7NLQCJ6B9B1laUPq/DBaChh7a/25ceQ?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tQr9o1wqt7m/saQFOT4wvqaMESCvBgvtNo7PTu8ISdABSsFckdyQY1dBshnjXks7CbyQy0lQzpyC9x5uzIAkbZKAPXhLNsLL2OxGx/hoZPPvxSz5AAvQaGF7C/4EJ6E62zpgzOgrEoe3qMytJQeQiUh0FtjBWa7DOfnhLnale0IpOVE41AFBabRtY/AcFek4XH+1dA1PhvqLDHnrz1X2sbxzMsX2bkpvsIG+35NL2PoF6KIDMDdt4wMM5zRy48uwucigBDYu65O7sQLbi55Q6RLnTEGTdoABNV9icunOaMt9KnUGlTRaRNo8+APrLUnpl76HOb71qeggvPHmJ3UWe94UcpKUyUkVE4Y/5wFzML+BApYCNkL/q4V0nfXU+i4ED0yeFihDM+E1wS8BCYpbDPN2MOVXGj8cJ/cXhdHWNs8=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3258;6:L6jrtordX0zYSWqVjWxRnnIhBiEq71C4tz2re185H1oQN+9fgqqbXB0n32FE6nJKI7r6WA/r8VbYGAi8qVAQT3y3zhh4SMS592u7BySGpDPLn3Ioqpkn8GzLQPcuYlQDfVhOZUIDagkdXNoTGhMNbaiT+dCuso/6Ph1RVNd3tbQMFjhMKPR8zUQlWC03/EOjAl5y4r1LCw5PV5X+gPpcqaKWWlmia5sUEeVxhRU354HAS2OiC9w9v4LVAjZfBwJNROzR//u87hP6fi1iKRMY37lZ11YUZ+rnLWccTphgkteWu6QGqLUCirG6YOwJRSlcPTAGWim72wJXEpwDCRhenGhDy9ODflbmwzxI5xFGuhO6BpRd2iU7sgjnFc9ivH7ojiwEQdAhOv+nhc7iv0dTTWlKvMwmLmTw8sPmTqBViGn1n+7MCEDf4UDV1qmx0kNMvLQZ3NXA9eFrst97045nAg==;5:wofKu7CJWf9UBt8WOxRGrZC+ZhiTRrAAMxgZqMNQ209Oe3nbApBjoi388mggDtYNkXDecHETjS2L9ZlYKYG9RkH83K8kG2SWiXEAsV2RiHOznl+CGrdJuL4Oury0dG76PygXiGKtayWM0VMqTZ3SIsLgG7FISzwoAW6j3uSJ90YXDyw5UfV+UamPpfJAQwy/kFpYc+cSAEpJ3hC3P4yNRQ==;7:0CHyBpUM9IijnweH8+fzlOkChIsyw0/E44h+Hcv0Jeyj36jClXTlgnCahuYqdb0iaSy5Xq5khwlGFHwWsvJbMg5kK06l7INzteAHGAozdS+FIp2+ZCXkNQWDM0ulhotaqnTL03i8Yu9eY0ZcZ9EkZg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 16:12:23.8114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a26d65-7b2e-4638-f95c-08d68de0362b
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver assumes that an interrupt line is always available for
the I2C master. This is not always the case and this patch adds support
for a polling version.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 176 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 156 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index fcc2558..bbe3e96 100644
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
@@ -246,10 +251,113 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
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
+			break; /* all messages have been transfered */
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
@@ -259,16 +367,37 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
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
@@ -294,7 +423,7 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 
 	/* Init the device */
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
 
 	return 0;
 }
@@ -451,10 +580,6 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -509,18 +634,29 @@ static int ocores_i2c_probe(struct platform_device *pdev)
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

