Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6257C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5A3219E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="RRGPlEj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5A3219E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeFYQN4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:13:56 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:49248
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeFYQNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMlo8dcuNxsvdCrIapAO4Z3cdRcK/06wppGAIK9ed/8=;
 b=RRGPlEj/S+hosRaix3ufNvJymc1u18Vo260M4anHCF9XtFiBUO8/vC+Bhn++vxcgYI8wITwLH9qUYAMaAHuQecO3rluUYmNSlG3LOy5PLf+S9UmzC6pMPC2yc36BbcKVDYxipd34JbZMawt1jOWWDy6yiLxyjfoS0zAAu16/iRs=
Received: from DB6PR0601CA0002.eurprd06.prod.outlook.com (2603:10a6:4:7b::12)
 by HE1PR0602MB3370.eurprd06.prod.outlook.com (2603:10a6:7:88::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.24; Mon, 25 Jun
 2018 16:13:49 +0000
Received: from HE1EUR02FT035.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::200) by DB6PR0601CA0002.outlook.office365.com
 (2603:10a6:4:7b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.21 via Frontend
 Transport; Mon, 25 Jun 2018 16:13:49 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT035.mail.protection.outlook.com (10.152.10.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.906.15 via Frontend Transport; Mon, 25 Jun 2018 16:13:48 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 25 Jun
 2018 18:13:23 +0200
Received: from pcbe13614.cern.ch (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Mon, 25 Jun 2018 18:13:24 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Peter Korsgaard" <jacmet@sunsite.dk>
CC:     <federico.vaga@cern.ch>
Subject: [PATCH 3/3] i2c:ocores: add polling interface
Date:   Mon, 25 Jun 2018 18:13:03 +0200
Message-ID: <20180625161303.7991-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(786003)(47776003)(316002)(107886003)(106002)(110136005)(16586007)(36756003)(2906002)(4326008)(478600001)(26005)(186003)(16526019)(74482002)(426003)(8676002)(51416003)(86362001)(106466001)(59450400001)(8936002)(50226002)(476003)(76176011)(246002)(126002)(486006)(2616005)(7696005)(356003)(6666003)(446003)(305945005)(11346002)(44832011)(336012)(5660300001)(1076002)(7636002)(7736002)(50466002)(48376002)(6116002)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0602MB3370;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f1c1d9-7eaf-4a76-d5bd-08d5dab6a28c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:HE1PR0602MB3370;
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3370:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3370;20:rKkQyGwb63W4a2PxSjtng8bp/TgwRUNjV7S1DXYV/TL46ohzTnTWrOPuyJKzoIPXesyRfrPdMFidreqotUYpLVeDtpOZOqapECzZ7VbNA0ZY2SUX/w44PEt/yHfkFiNO+Jti0b48lpPKzIERRl0WrelT8UcFALVVikn1OEOKetfYCxEI+k/LjDGEAKYK8xVWOjLGQ3YR93sP4pWoIpOXOfOitAu7VJHMaRKaKwVsSgWd3ANLm4v4L+kXh92u4cUcZsLgkChyrBhlrPU5moNL9G8xx43ssIabvXxfMCmimNGRt+0X1WQpThockn2rQlp+s5Gxgu/0KOIPleaXwITV7l/ijorsk4/0nuMLmVVY85uoHY8ZWY3jcO8jBrjCdydyFmA6niFsUQATEV4HI1hn/nPAy0cfC7HEgTDNA/MuGYt6j3qylEaVJ+X+xP4oz8XumJZa2qpjI+MnqCkf1yHrE/CdihKSB691hDNBwtACW9yEZPgHsVGQW8EclRfT/P7H;4:fauo4n22uF1aKt20pcOfbmXMOt0ZSnzrXc7ybytdZzJUsR+stj1a2YynWRx2r6WTtf33KLZP4CUlwGEX61dGnbJ/Xm/PyT/i6kttRobu5TkPL3Qpq5z/rHtyQ7hAx9MGBnN/WjkQ7Qgubx+g1DzMkDqVk1bv9nqFDMbGwb5SIrR+DQNXITWFptPzf25nTP0eR0zUlIADUy4PjeoB0LCo0dyIGYyJ9NEO3hx4CO4a8VqlRAGnVT6PK+qB2gYm+ONfW9jiSgdsfMoMSnTxwrAg6A==
X-Microsoft-Antispam-PRVS: <HE1PR0602MB3370C6EFFC3EB2FD0EF603C5EF4A0@HE1PR0602MB3370.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0602MB3370;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0602MB3370;
X-Forefront-PRVS: 0714841678
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0602MB3370;23:stlpU2DSDGskEtKK/tuFQd6IQiTCFUIJeW9iWnY?=
 =?us-ascii?Q?exvkgXvQtdTNeSMMk4b3nRmjXJ3XNHahEMnEOeCM2eL/F40rZ0eBNRT5LlEr?=
 =?us-ascii?Q?jSO60NgoQsctX4dNFPhKKftKy/vMTlBxUFYyoVFZZc8GqTYuZbCMf6wpMjoe?=
 =?us-ascii?Q?IMIGVvY88K88oQJLLArJcTvSj/13UZJWbK9OxZ8JNMpP3e5ig7t5gZSPog4r?=
 =?us-ascii?Q?RV+dsQ+MHIEkdmowXugIU/QimT25qCyX0CN9QnQfxRnjdngmLij2lFuz8gGc?=
 =?us-ascii?Q?U/GxxCsBvJ21Xm8jNMZpI0RmMf2QXZlD7AZJcnFE2tYMZ515fwBfeVuYXatL?=
 =?us-ascii?Q?WVPMksNQ5Dy9VHEV5urT9f8HUgPY/Lhq+m70d9tR3doqe+xWkRkSZwfnrhXg?=
 =?us-ascii?Q?4vX3wUbbLN6HfN2uEaspKUddE9L/drN6UFhwHuYOtKynCq31WatD+2uiAzlF?=
 =?us-ascii?Q?UykMTII5PzX5m7bOfln3X24tVn4Ong3VJAsegGHFO/1P82VcIq8kBBfdfmGJ?=
 =?us-ascii?Q?ThAt7MrfJ2QPTcxjBkBZLC8ZPfkY+25fsUgS6GccQ63HzeJdMWo7AaM48DAt?=
 =?us-ascii?Q?+iW7mNOCzNth0U/3uqkgDvGpTDV8w4Hrwwy3mYBW2eDMWnIdl2DI1K/WfqDv?=
 =?us-ascii?Q?7K5VA+nHhMvpis+6BUIWT7IqrVUiX2YTKK/oRjms4Zg2n+3uSlRieQ7IuYV+?=
 =?us-ascii?Q?DMYTgx/HK59em/HO/6rErMOMxTcz9PnB6y4mZyowVsSqAZX/j2KPIVJLchQQ?=
 =?us-ascii?Q?4/CLVEXrrbzJX4/IIXcATNWNlUR0T7hfABj5Y/pw/puIJnOhBC6QxxRe+I+r?=
 =?us-ascii?Q?8LtCEFHXFvRgspJlHdZMQvKunj3QyddL0QUZ9JiZYKX99oSltKqnCrtptiLB?=
 =?us-ascii?Q?ipUkCZ3sFbiqkVo8KTRApaWaSSc+fi4WoHi28Qu6VpH7VdFlyIEa//3N239Z?=
 =?us-ascii?Q?40VkZJj8u59yiUFaeCLegacTk9QO6anHJ7vA7Q0DXtu87wp6Iw/2k6pLUci+?=
 =?us-ascii?Q?0npaaovzZ6QvFp00mDVG99spzXF9de2FhrLzRDVqmsFr65yP5Lq0cNt29761?=
 =?us-ascii?Q?wtyZzy2R7RwyLVJbz7FajTLq6+B4jnn4iEADSQfsmFVR4S0MsFeZtNVJprLf?=
 =?us-ascii?Q?4DT8IYWqQVntFI8UwRM1nlhvw0PKcN44bl0npHu9zcopxRJOlAQGX9x/4leI?=
 =?us-ascii?Q?CYMGg57SSb2v/RvM=3D?=
X-Microsoft-Antispam-Message-Info: HZKqh8Xt1sdEiYW4K0W+eYJdhtAH3AP5zH/XUs2h3qDfsCIgNoCkLsMo+5cbbZGhR7eWrwy4KzOhwmrVLOobvLV4AjvdXU3XKQYlnjoPdtZhzWHHHMdE/pBdyYrKSnwT662G0/OTMOk9zeB9L2LyFjfb8Qxz+TpKnLf9ieMA83folJ7wqppGNGRvWB16BhJdWfrplAoiKqTIY/aEHz7kbw3fBxXY/gfeRCinyb84/pkYESj95QavKQgDH8TIFMQAT2M+Aa7vTxyjsK7kMs+QJyGEzenfrwBmY3ch0nXle8BW6qZaNaIvykpnjc1h/coWl5oU7nPsC1Gbc1JJDVC+VygztbqBx2I9BRQs5D6l4io=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3370;6:4A4hCNR2b3gxZdV4Z/94/7YvEFGZmc9DwKFwJQt6vcUzbIod3redJwWrd2J91UYIUJBYPHXkBZ6eZSMj//wLQarF9+2GhA3k4gpqDNK0S01eAr83sPy1sXYVra0SuWqsnATura40NT3t015GyYPdh/P1mORJ44STIWl8bhqubplbpn3WLv5G+aN9qI6MfBmVmaA51hLT0+dNQ6RoXNy9e/vVbh5AIGJaloJaNJ5zL1CVV/ODV3bbZ6HohCsBeswOMy3IxklrN/1YO8r8xKXhPwGF3XUXzYVSRc6nkyZqx7qBaVtVAi1xckE1VB+8ZDdsd1LfZkUkKylcjbj3GrbHp9qtwqvd1SBNsDoMF/dDrgQcK36kj+2hyQozaI9kNe3IqX4MLLY2jgsSh9ha/8ml9KDxOgcaAQC+6oKRKKYg2exYi89j0hEcxqpQ+7jmB/VWxsGKBBs0EknENxaObvJZ4Q==;5:dX8uMJfOnfHGAnSxvH/Cfw6vlwUaKwgB3j1cCLrqHdZxp+oz959iCaNmeW0KK8UCX96WbFSdeFBFjEdtqkZUwDTm4oGn19Rd/krr2v1+UAOsJoL6cYmrmZxiCAPJ9Bw4kb8OOr2AnfB5dcSQM7mORJ1KfdJqiNp9vksIQOz+8KE=;24:UCs8Qdv1D+MCaO5MHE24U26T21FFEMrK1sdqa51J7maPvk3a/TEHSM3pR/wpHR2TC/tutCM49khBR3q63wLovVkN+aM0Io3bFsIFiuvPkBg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0602MB3370;7:7I+Z5L6TPPO/Wi3ZNdcSfBTEsGPSUg6rTSjD5IilXwFQBaSiz+TlmQsXlkuVLvTY7AHeMwLIAA3tPhu2ICpgdspK6FeL24EOwwlITPrHEBgEO5+iqv+LOO5yfrhuPu6OxnqouHCABRe4b7a50u9Z1900AscyxoyM6dzhsIt73EfZumRpDHjLw9/KX3vFUDO+x9ebFgdfOPIVV0YD9XE8242CO/I1CrDaA3DsjgQE9/jqYru5aZrUP2lD+D4Yncda
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 16:13:48.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f1c1d9-7eaf-4a76-d5bd-08d5dab6a28c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver assumes that an interrupt line is always available for
the I2C master. This is not always the case and this patch adds support
for a polling version based on workqueue.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 94 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 274d6eb22a2c..0dad1a512ef5 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -26,14 +27,19 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#define OCORES_FLAG_POLL BIT(0)
 
 struct ocores_i2c {
 	void __iomem *base;
 	u32 reg_shift;
 	u32 reg_io_width;
+	unsigned long flags;
 	wait_queue_head_t wait;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
+	struct work_struct xfer_work;
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
@@ -166,8 +172,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 			return;
 		}
-	} else
+	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
+	}
 
 	/* end of msg? */
 	if (i2c->pos == msg->len) {
@@ -232,6 +239,50 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+
+/**
+ * It waits until is possible to process some data
+ * @i2c: ocores I2C device instance
+ *
+ * This is used when the device is in polling mode (interrupts disabled).
+ * It sleeps for the time necessary to send 8bits (one transfer over
+ * the I2C bus), then it permanently ping the ip-core until is possible
+ * to process data. The idea is that we sleep for most of the time at the
+ * beginning because we are sure that the ip-core is not ready yet.
+ */
+static void ocores_poll_wait(struct ocores_i2c *i2c)
+{
+	int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
+	u8 loop_on;
+
+	usleep_range(sleep_min, sleep_min + 10);
+	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
+		loop_on = OCI2C_STAT_BUSY;
+	else
+		loop_on = OCI2C_STAT_TIP;
+	while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
+		;
+}
+
+
+/**
+ * It implements the polling logic
+ * @work: work instance descriptor
+ *
+ * Here we try to re-use as much as possible from the IRQ logic
+ */
+static void ocores_work(struct work_struct *work)
+{
+	struct ocores_i2c *i2c = container_of(work,
+					      struct ocores_i2c, xfer_work);
+	irqreturn_t ret;
+
+	do {
+		ocores_poll_wait(i2c);
+		ret = ocores_isr(-1, i2c);
+	} while (ret != IRQ_NONE);
+}
+
 static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
@@ -245,6 +296,9 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
+	if (i2c->flags & OCORES_FLAG_POLL)
+		schedule_work(&i2c->xfer_work);
+
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
 			       (i2c->state == STATE_DONE), HZ)) {
 		return (i2c->state == STATE_DONE) ? num : -EIO;
@@ -264,7 +318,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
 	prescale = clamp(prescale, 0, 0xffff);
@@ -277,12 +332,16 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 		return -EINVAL;
 	}
 
+
 	oc_setreg(i2c, OCI2C_PRELOW, prescale & 0xff);
 	oc_setreg(i2c, OCI2C_PREHIGH, prescale >> 8);
 
 	/* Init the device */
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
+	ctrl |= OCI2C_CTRL_EN;
+	if (i2c->flags != OCORES_FLAG_POLL)
+		ctrl |= OCI2C_CTRL_IEN;
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	return 0;
 }
@@ -439,10 +498,6 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -497,18 +552,25 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
+	init_waitqueue_head(&i2c->wait);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq == -ENXIO) {
+		i2c->flags |= OCORES_FLAG_POLL;
+		INIT_WORK(&i2c->xfer_work, ocores_work);
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
@@ -538,6 +600,8 @@ static int ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
 
+	flush_scheduled_work();
+
 	/* disable i2c logic */
 	oc_setreg(i2c, OCI2C_CONTROL, oc_getreg(i2c, OCI2C_CONTROL)
 		  & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
-- 
2.15.0

