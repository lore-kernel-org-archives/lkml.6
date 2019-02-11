Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F86C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B4B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="JHjEhrBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfBKIcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:32:04 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:35505
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfBKIcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbuCK+LU0KyeijPrVwD56tzZePc8hapAnnEcpITRndw=;
 b=JHjEhrBWE2m/3U7AaKyZfP2CCqyz53P6Rht0Nf4u2CWs4bMJrUeFdCc1ueXzs2MB/ywPjPqEZ6CuifW2ofFXa+qMrfh+0lDijr+d4vfvM+MMNw81MJeuplHXVzWgBA701Qm8DQfHPM0HoUKMqNXtH59NYWkCOTlSdUWvTxpTrAw=
Received: from AM0PR06CA0010.eurprd06.prod.outlook.com (2603:10a6:208:ab::23)
 by AM6PR06MB4722.eurprd06.prod.outlook.com (2603:10a6:20b:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19; Mon, 11 Feb
 2019 08:31:54 +0000
Received: from VE1EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::209) by AM0PR06CA0010.outlook.office365.com
 (2603:10a6:208:ab::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 08:31:54 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT019.mail.protection.outlook.com (10.152.12.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:31:53 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:35 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:33 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Date:   Mon, 11 Feb 2019 09:31:18 +0100
Message-ID: <20190211083122.32485-2-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211083122.32485-1-federico.vaga@cern.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(7736002)(16526019)(106466001)(16586007)(54906003)(110136005)(26005)(53416004)(3846002)(14444005)(8676002)(7636002)(186003)(246002)(74482002)(48376002)(50466002)(6116002)(86362001)(1076003)(478600001)(7696005)(51416003)(126002)(476003)(2616005)(2906002)(106002)(76176011)(36756003)(6666004)(8936002)(356004)(786003)(66066001)(50226002)(316002)(486006)(426003)(336012)(4326008)(44832011)(956004)(446003)(11346002)(47776003)(107886003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB4722;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc97dd17-dbba-477f-fb34-08d68ffb60be
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:AM6PR06MB4722;
X-MS-TrafficTypeDiagnostic: AM6PR06MB4722:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR06MB4722;20:rNJY+1h/BgvSKTujkVnDXIXcIzCdTx1W6znWVMKKAqQlBasvn9yFr+IscB4+yBrESysyjcZTlq4FcGx5lZjl/uhIiE92Awr3nrfLCc0mbs8a5PpFgxOJENSOzuHLw8OqOm7x4azFPpkxamMBuQC/JtbRNMWFx57cApaLAKKS6cYg4dps2K5W50k0nJvO6D3GlpNwfOiCS5Wk+/3TGMjTTmkdPgy/ZetmMGJmlba+ONzYxe7gXuvJbYjARbQIHLOTEBK7IeRxjYD4m97ZBDACnHoL15mlunrqHfFHGnUJmCNEp19lHX+IgiAjhqjnh+YRo/K6fcADqBcPjsXR3dPLWNTgtESMy153we5Zp/D+0X/IKEErDwJHZ6/3LryVkhw+ny0S9LfpVbHE7sNB1Qh3flfWetEK9u6ocIyN3aC+HNBARURqixy+1WlLTal7CbgSo3OF+ON1odmE2diNz3B6x5NCAifOmJ4nHjS0iAtxL02ikabbz4GHuKQcE2DHuT4a;4:Qvtt37aflDCXMYPTRzij3QO4bWt4M67kBmn9RrHqQyNd8QeAELa7hnKifpm2+BQLnt4PegNS9bN8e/2n7aGpps9SafIPgRpn/tRmTs6uVJizS7UY85y6UXJOfbaZYV9Vsz0LYbQY2FwLUEyXXZa9RRoOneIGJFu6YYjQ9vrgJYy2AiGz5LrLVA5NubmhORounQJJ3cnalrWcxew/+4bHAqLFYDOC0ldVRfRLudg/vxI74sAZpqiPzgRMX5CYkGJNV1wt8s5pnXbFkV/jobNAu+ZRbxESK1bImjfy2QbaOOT9sA7dnQiJN47hoU/VhMnS
X-Microsoft-Antispam-PRVS: <AM6PR06MB472229CC8266462D185E1B06EF640@AM6PR06MB4722.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR06MB4722;23:2Hzr+BGa6uKicsKBrtH8lERU+bTzGPhRmyleE9fFl?=
 =?us-ascii?Q?PaavORtZt4Qi9OYKiPIy1mEXHJVnzqtS/77nE4LH5UPtvbLdkt2F85V709Cm?=
 =?us-ascii?Q?lYSr1L4SgmPql+VZXkPUQKvXLjsdYE1wb4sGF6+rzs5rSxXNnz197lV4pyiW?=
 =?us-ascii?Q?NNFaIQWAssEJpWvDsJv5yKHWh7if9qEUdIbU7UKyFYB4aBluuo9q9GYPT6uP?=
 =?us-ascii?Q?67WZMBpo4f26GH47ZB0AuvXu/zLoyeXlRtw/3PrU0xa+ZPyulNHrWjyBVtfJ?=
 =?us-ascii?Q?FFmerbaw/9vOiS1DSqEk63efufkDQqzAT/wGmt5M1EqfxtjAsG71OXaN5nnM?=
 =?us-ascii?Q?cOxtdLq1XF5/b7SpxVswGDWErWqnxpw6erulox6UVJDNNajKV/+dbon9sQ87?=
 =?us-ascii?Q?44Fw5k1uhB/K7ORm6DYCYK8NTUKblTaqf7poJjDKnJJPNDc+TDw+imcIDcsF?=
 =?us-ascii?Q?pY7lbRkZZ0zeqt36mG3/E7bxOF3fsZ2C7m3IeZe7giJUBTqysFlKUvMrSY4T?=
 =?us-ascii?Q?o4SDqCe2iWrfmdWmcnC5B6objMfMbF9qqi7Hoo9O7WQBpBsbbeELdCPlN8tv?=
 =?us-ascii?Q?e9AV5jKpdl5jmqX4pcI7MyjM+a03CTJiRjmfV0EUAi4+qKSDHHJz2gxvifCv?=
 =?us-ascii?Q?TS1Z20+8z50wKHIElDvJkEL/iWttAzVAUHOgHyDDTFv6qRwxPGDKqIa4J1I8?=
 =?us-ascii?Q?xvcdaBla0zgZNEOHdM7L3QzOw2DxwRnCbk1/safRpoDfKTVQzoy0Xfa8irMQ?=
 =?us-ascii?Q?QOYfLHuDuhxCVw2NuTUZVe9l1FBV3NwQ1AE3M8zgFYpBbtYh5RiHUPpkCbLz?=
 =?us-ascii?Q?Cl2NnwDj/5QMC9u6YGM/y/sKvl2n3obqkYSPVzjWMCqewuvHOiqoj24L2OQh?=
 =?us-ascii?Q?ZeZkOxzppMYLyIgbmRXqk/j/SJlzQiZYq/ans/kGVHHQoICN7Mz0ylvmdCb8?=
 =?us-ascii?Q?0SrRqn7PG8cIz8wUhiod/1g4eesrx8tzcH29SMBZrN2JI7/fcPSNWqgxsubA?=
 =?us-ascii?Q?KPllizJr1tVj+gV8XPwTfk0DwrJZ0/Fs4Y8i+BVZL3CH9b0KNwCsuzu84/e6?=
 =?us-ascii?Q?alQhH/2DWGOuDz4Cj0N5RVYJsifDM6VOzpbH1ONypmYsqlovyGgVCqMFqEuo?=
 =?us-ascii?Q?1VXyuKYrX/VP48WVC0KZ+KqwrQOefotikzRibfwJeNleNaah0aiXCHLkzMaB?=
 =?us-ascii?Q?sOxbHEicBadm4Ls8TpxCCPQakdm9/w11ayd?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: K0U9TQt6Gk6LDDRwEeRNepSMXah8U4iqMaKYt6EhqoDPprWav4j8RZG/jMBWbqm8jtvNqG3HuvWKxUWt3ccwTx5suJy1I3pFsrtxPE/sDq3tYpsECrWEqbhs/Z+Ea3UVGmqz4CrtVVmTBjou6Mq3N4GFKhul8kUi3witl3LxyoUMB8r19PBGZLj3zEdEYXdwOIIvC3XAim2CiA8olE1h6hOMMXGk8zGOaN+ggU+Emi8sIrhfROLnRNb8r+/2hj1zaxWxKXPyAONxmJ9k6t3qBj3HwPAUWyCg7e+cif+v8C7Vn9UU8/j67IoIRAonNm0lUqyuNtWbSCpqchBsrIXkR1mBBU353nOwtBmr3MgLLS54OU4hALFuJY+QQ+aAxGxfP5J1t6LXikaKVHbuHRAivf0lnity1r6G7sKHewc659Y=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR06MB4722;6:cF5k7uCmRF06dCDLN2SNUXpkyhmV34u+aAJgC+3Jo9+l0sthC37EpIq+Scpi2M52DNJQVyUjmwMhUqhXgLSOLv1WAHFIY5jlqnKJ9OtuvAbHjBHHONzEkCU7b7lnytkZdG+en3B2E6dMZnW9EnHK1IGBuIFzMAYC/t2FCffeIj/ZEGw5Lbbde4MKP9CRZR51Z+GRq+h3f8gEZw2rKb1OWht+7lkRjjT5LcDYz7l3xKdxxyelmS56JwpLDzLA7RHvElmZrknrRuGRZObWQoYvgUuu8/dhmHgvtzpE++KHTG9QPb0sudapqaRu8ryLI+QWylY206tFwxt5MeK/tbdSoMxWeE78IkRij35dFWHOQyhqKPeOtfeQ5uDBikQ4uJENcsLnG1JBtT96bs/t9GbtOLmqVrT+imgvgppulceDipmDGECxZPVuXUJUj/Zbp3Emh5lSNf10UwgPMik32IT1gQ==;5:Z9VWUGka6W/lw6t7G6w7qagzm4YgbVph9IwYb5gZB86zqZEn0dzicRITa+mKjqx49aDpWoQJ2SmXAfW1hqKXqRRDZ5J4HAXGRmsLtBWjZOAHdVFOe2B1DHTvdjgB58fx0DfzunrAWw+LCyftlDn6bby4DgG+Y6AOBHHIGr45+Ap1H4/beqMWdeiY5DWRwEO+I0UhYHxvGPT9yQFbo8vmUg==;7:V+DQFe48T/3IXZgUWwXkoVoYAQ/QDJUnROYEOjk/M+jYnTNyE7c0n/m0uQ8iVyPt+o/8D38g0NScHMlJOlExOqiU6B87ey7imWaCwgcx1acu+jRNOyDPKyCok4FRz3cFMQorFNt1G3k0jcKpdZRaNA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:31:53.9623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc97dd17-dbba-477f-fb34-08d68ffb60be
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detecting a timeout is ok, but we also need to assert a STOP command on
the bus in order to prevent it from generating interrupts when there are
no on going transfers.

Example: very long transmission.

1. ocores_xfer: START a transfer
2. ocores_isr : handle byte by byte the transfer
3. ocores_xfer: goes in timeout [[bugfix here]]
4. ocores_xfer: return to I2C subsystem and to the I2C driver
5. I2C driver : it may clean up the i2c_msg memory
6. ocores_isr : receives another interrupt (pending bytes to be
                transferred) but the i2c_msg memory is invalid now

So, since the transfer was too long, we have to detect the timeout and
STOP the transfer.

Another point is that we have a critical region here. When handling the
timeout condition we may have a running IRQ handler. For this reason I
introduce a spinlock.

In order to make easier to understan locking I have:
- added a new function to handle timeout
- modified the current ocores_process() function in order to be protected
  by the new spinlock
Like this it is obvious at first sight that this locking serializes
the execution of ocores_process() and ocores_process_timeout()

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
 drivers/i2c/busses/i2c-ocores.c | 54 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 87f9caa..aa85202 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -25,7 +25,12 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/spinlock.h>
 
+/**
+ * @process_lock: protect I2C transfer process.
+ *     ocores_process() and ocores_process_timeout() can't run in parallel.
+ */
 struct ocores_i2c {
 	void __iomem *base;
 	u32 reg_shift;
@@ -36,6 +41,7 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
+	spinlock_t process_lock;
 	struct clk *clk;
 	int ip_clock_khz;
 	int bus_clock_khz;
@@ -141,19 +147,26 @@ static void ocores_process(struct ocores_i2c *i2c)
 {
 	struct i2c_msg *msg = i2c->msg;
 	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
+	unsigned long flags;
+
+	/*
+	 * If we spin here is because we are in timeout, so we are going
+	 * to be in STATE_ERROR. See ocores_process_timeout()
+	 */
+	spin_lock_irqsave(&i2c->process_lock, flags);
 
 	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
 		/* stop has been sent */
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 		wake_up(&i2c->wait);
-		return;
+		goto out;
 	}
 
 	/* error? */
 	if (stat & OCI2C_STAT_ARBLOST) {
 		i2c->state = STATE_ERROR;
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-		return;
+		goto out;
 	}
 
 	if ((i2c->state == STATE_START) || (i2c->state == STATE_WRITE)) {
@@ -163,7 +176,7 @@ static void ocores_process(struct ocores_i2c *i2c)
 		if (stat & OCI2C_STAT_NACK) {
 			i2c->state = STATE_ERROR;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-			return;
+			goto out;
 		}
 	} else
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
@@ -184,14 +197,14 @@ static void ocores_process(struct ocores_i2c *i2c)
 
 				oc_setreg(i2c, OCI2C_DATA, addr);
 				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
-				return;
+				goto out;
 			} else
 				i2c->state = (msg->flags & I2C_M_RD)
 					? STATE_READ : STATE_WRITE;
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
-			return;
+			goto out;
 		}
 	}
 
@@ -202,6 +215,9 @@ static void ocores_process(struct ocores_i2c *i2c)
 		oc_setreg(i2c, OCI2C_DATA, msg->buf[i2c->pos++]);
 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_WRITE);
 	}
+
+out:
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
 }
 
 static irqreturn_t ocores_isr(int irq, void *dev_id)
@@ -213,9 +229,24 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * Process timeout event
+ * @i2c: ocores I2C device instance
+ */
+static void ocores_process_timeout(struct ocores_i2c *i2c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c->process_lock, flags);
+	i2c->state = STATE_ERROR;
+	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
+	spin_unlock_irqrestore(&i2c->process_lock, flags);
+}
+
 static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
+	int ret;
 
 	i2c->msg = msgs;
 	i2c->pos = 0;
@@ -225,11 +256,14 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
-	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-			       (i2c->state == STATE_DONE), HZ))
-		return (i2c->state == STATE_DONE) ? num : -EIO;
-	else
+	ret = wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
+				 (i2c->state == STATE_DONE), HZ);
+	if (ret == 0) {
+		ocores_process_timeout(i2c);
 		return -ETIMEDOUT;
+	}
+
+	return (i2c->state == STATE_DONE) ? num : -EIO;
 }
 
 static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
@@ -422,6 +456,8 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	spin_lock_init(&i2c->process_lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(i2c->base))
-- 
2.15.0

