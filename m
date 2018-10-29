Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58818C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083342082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="AeAHjRvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083342082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJ2XkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:40:21 -0400
Received: from mail-db5eur01on0076.outbound.protection.outlook.com ([104.47.2.76]:26592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbeJ2XkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsHjJ9ryUGYpXbAC4zXu/vxpZrDjhqBwxSGtdInXPLU=;
 b=AeAHjRvqJ+APg5Om1kXF4Jn7tE8/ONqj0UVOMKoq3keNzx1UfmyLt57cbdW72+SJ74+r1QqZlTLfPVRAAKDNQgN9EeEK8ueYczzyMraqcHl52SPOjj5Qa+m4i5xp1gnIRTfeaF+RLGUx7+Ija4a4OLpu2Z+QoNyxoF/GyhameeU=
Received: from VI1PR0601CA0023.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::33) by HE1PR0602MB3531.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.26; Mon, 29 Oct
 2018 14:51:18 +0000
Received: from AM5EUR02FT055.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::206) by VI1PR0601CA0023.outlook.office365.com
 (2603:10a6:800:1e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.21 via Frontend
 Transport; Mon, 29 Oct 2018 14:51:17 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT055.mail.protection.outlook.com (10.152.9.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 14:51:17 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:17 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:17 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <federico.vaga@cern.ch>
Subject: [PATCH V2 3/5] i2c:ocores: add polling interface
Date:   Mon, 29 Oct 2018 15:50:49 +0100
Message-ID: <20181029145051.31984-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181029145051.31984-1-federico.vaga@cern.ch>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(74482002)(53416004)(36756003)(305945005)(86362001)(16526019)(66066001)(7736002)(7636002)(186003)(51416003)(47776003)(106466001)(50466002)(76176011)(26005)(48376002)(8676002)(5660300001)(7696005)(4326008)(50226002)(316002)(3846002)(6666004)(786003)(356004)(11346002)(16586007)(956004)(2616005)(446003)(2906002)(426003)(14444005)(6116002)(8936002)(106002)(110136005)(336012)(246002)(478600001)(44832011)(54906003)(486006)(107886003)(1076002)(126002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3531;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a156507-b0e4-4207-30ed-08d63dadfb5e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:HE1PR0602MB3531;
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3531:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3531;20:HgbXxplWA5MIW/54pNWGj6LMXFKGlljq9V3EfbMxI0JqC77PDwmnTQySdb0GAKJzAUiBhTtuvs+LfznXrbFUeEEKQtZ+11oG63tJx22xLjgKIBV9R/HPNud4CpjIbdt7XdWc6dfBqkEngQyolfotu8M52UVPhpWYW8v64/AvCdlrLA8J1NZCXHGPHVjPm7WQmfD7pjp+a32XBOI/zWZfXi0XIO+NwwSA906IRnanM9jMZaLx/1HCUbOPr+D7+W0lsVBgJGXuxcNpROUg6vhqRuZP4tzPe0vDs4Q+3K1KqLUUn7SYzD2qgUhROTo5LqyjZ62cYM2yCRjrOq3HkTEIfcxogbnryBSgiM2TB5enEr3oDpRkclKD/iooeqCGMdvxKQyx1OymQXDOqPcfdm7mxXoV0FDeIYym91Iuaohw0BC3C0pHsSn2ZK0BLjPbxId+ednKfV4pULSMDeM36Ji0IHf5vWCbEyS4wzmsNUXWq5YU7geCKFL/PaJDPOHA3F+n;4:Qge27kpDtD5K5HW7TagBpARzWNP35ZJfLAzuWMagCKd5CttJe+5XWrt/dDStN4QHMO3J+QT6MzOQ/vTKH4CleC8MV+cPL3puv/VsJIpzGcYscrFLdaqQH4LFRY+eJMRTEMHPE3UFnjTxx3MIWm6sBT/uZBJb1to2X33HbNZoch4nJeYKReoFl17XDqHOwMoMMp7v/6S/pPU9u5wyPz17q2woccyUR8QQS4eV76ZE1Ur7/VEO3XkMaxnPrcu6puMUh/wRNtGqkIU92Exhfmnkfw==
X-Microsoft-Antispam-PRVS: <HE1PR0602MB3531B23BFF2D7716E4973AF2EFF30@HE1PR0602MB3531.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0602MB3531;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0602MB3531;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0602MB3531;23:apruY/EhsIU1rFIJWZK8MgCSUFwUDHPuz8c8JUW?=
 =?us-ascii?Q?s8b+ecNkZvgfmOt+vOqbAtaybek7ayXtIpf1yZSP3BqctXs5/+QU2eexUS9j?=
 =?us-ascii?Q?5wGGmT/yvILR6azE8h6VFOAqF3MW4dxJeIPYGxZPHl2Uf6iFxyzyXDiu+JbY?=
 =?us-ascii?Q?KHAUMUnLkKoAHidRVEJ3VbsTiOdzGYhQ2AJCe58yZZENCzfycbWrZXCTQTgo?=
 =?us-ascii?Q?o4VC/QXKpQ9boLBUlmVUtv0xYiOOhyjGb+wyA9MeflcKEEQ1XTD36dUVhf75?=
 =?us-ascii?Q?5qpiSMHSiAsK6htUnT7PApNkFTBmzr1acEsnjwsiIa0yWaLKccaS5Xx6fz0W?=
 =?us-ascii?Q?mrnriDX/79Uz+4POsJprQicUZJT21ADEN3dCE7uHAgggmczkc9GFfJ0ZKCcP?=
 =?us-ascii?Q?ONBhMmuODBTQO/rX4pOZ4kuvmPidVUzRNwDB/lSQtEWh1LHm1iJUHKqNcNk8?=
 =?us-ascii?Q?vqs3Vh8lBCL+biT3HrpwPGZtRGfni8U8KgTSRVfQLuZnlRN5mfV9MUTnG/sX?=
 =?us-ascii?Q?9koS6dEOip0bQ/oGmBquwiST06yVdYUQDytFQiCTs/KaTG0XEOHcIFHRgj+l?=
 =?us-ascii?Q?tJzEKyXmZ3T/nmj+tmOy6Ikno0EHTwshUYud6Nk6w0fNaljoGbo1oEYuilQZ?=
 =?us-ascii?Q?tI+8u0ou3XnoHio9WGDWfaqz3dgurONNoOZOVPNCZMGqQHYGVZbIKISeGCWm?=
 =?us-ascii?Q?lbNWVqOvhmd0qmb7b9eqpDGvVfdZXpBdCckqDI5xKqNnw7lNld85g87zY2Em?=
 =?us-ascii?Q?HgxmpFmVaQHNKzUuq9ZQkqZxQ1EFo1LWjx71gdpbnDPNJLsog7X5a5/WaZXn?=
 =?us-ascii?Q?8nyip6JGBXJhl7PQ9rQ0Q5ljF17PbzRylS/5Qfr09il27fe0n4/cBEdRYwuT?=
 =?us-ascii?Q?1h5P5cNffYjdarkeB4EqULHtzhAWy3EiTVnNt7iwtrUR7Sp69HL/P+b/gmXB?=
 =?us-ascii?Q?IzH6rbZMKPeDs1sEn6mhaFQ5WnYuyHAQYCuhnWWAz0+lN8XMhL8VsLgB1Fgo?=
 =?us-ascii?Q?C4AXK7xp8WcnotOF4nHiIiCIKLy7kAogPqa/k6C02sbVjZ4KXZNYPUu6pnVc?=
 =?us-ascii?Q?yVN2P5cB2ZRM/WwdkEOeJm5U8VF91nJrP3dJnPAOnaZ1by99kZ3PNnvsQDA7?=
 =?us-ascii?Q?TvOcEh6k41VihU3/SF2Us4cZ0B2ggqJRLom/WGTx0WEKXX5cpgatwuz3c9oh?=
 =?us-ascii?Q?o8/rhishH7gzN+OoI7b7MY1CizHD+RdRyJ00QIZJrdyX2M9laRuFQFsAmDt5?=
 =?us-ascii?Q?0i6taewm403OHHq0xCT8=3D?=
X-Microsoft-Antispam-Message-Info: FYKW5nXkBNMiu+GH04h8e1JuoTSeD0N9508CdEfxz26PbPQmYmFzytPUiMtLVS90PxBk14Cg2XkBBHoFrem6CJHpF2jrvV6WF9/Y0FMJLc4jHdCnQ0EBocx3onQaPCToh8zaLFcIbM20GWnhCIhMN69q9oUcWNDpsqXR6JiidJCQIkPrA/ZtTF1d3lEm8cnQcu2raKghSKb2Oq7qzpRfXVn5LYsn8ETc/l8TndUCR199NX+IfDU7JZixSD379gl397qsT1V+6/u58D4ehEoMzS6CdB3wHxmgkFiPwxpgMs/BAlUz7sTmqT4V4FzcWqlgdkMxG/KMP8OlDmP5JcpmNHYmX14m47ygLFmo7gh4FUc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3531;6:tBpj6R9KMLXYE/aLg1PHwDRgMekzWMcDFFpBrIU4ogsJJjciSTsghKMMuoal9RsWiVcOTU4LPOsOENrD9OUSq16Z7wuAt2kIF7hpV3NwZUQN/8V75DPP5g0DFTT8+gHi+3d5UG+B5vFZIqAPw3YGVzyU1d4h5QrRnyvT3UlozUNZcoWvAyeacJkK0+dqQ+47gDN78YHgmXqC7Jev/C0C5p29xrxYJZzgv+k4jEdLPRtPJXSiKxVOiOHB8DWmaXiA/YTG4H64wi7yGVtrbVbHVYyCq3n4ezwuDB+ZEE7RwxYIojxT4nrqUQ9mH68lZD+um7BEHzk0lVPiZcUYIU/+Ug/1gtKDUv96DVCkJ5N3m7MTm8Uv36+PGz7PC3DmLCCCM47lEs85bBQSk9CwC131d2tsyeYGSILbsHgHhFiBSyGBIbO0XI3kxCqbZluggZk7H4yfSFUI66nYmpRvo8ff0Q==;5:8K02USgJgYBQX+Rez3WbLQxDK8YZ6FCYkYrqsI9FheZ4z3ho8/4lpqLPr3ni5R+5fx4xNVF+kNfeJc9Rn0IzAFn529PU0WFBd+fAHfd6VoH5ORmNHLbezFjoCLwlU9KHRv+EhjOVkpwkMXCmm1B5c0Vm08Mi6mP2EVg4XMpfPbY=;7:ChOt0YBNCP4QkWCHUODMMHZ50APq+LHxX4IM7reGHFv2jKjSVZFVvN7smUbpZ1MBW4r/3oAFXnYW0yFir6wgLicmfaAHlaLxk6GOuL4RX4myAoF0ec7JNYl0gjtOqMCf6fPm11Uoz+MN6tHuVNeZcg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 14:51:17.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a156507-b0e4-4207-30ed-08d63dadfb5e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver assumes that an interrupt line is always available for
the I2C master. This is not always the case and this patch adds support
for a polling version.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 171 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index fcc2558..2d71f11 100644
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
@@ -509,18 +634,24 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	init_waitqueue_head(&i2c->wait);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq == -ENXIO) {
+		i2c->flags |= OCORES_FLAG_POLL;
+	} else {
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

