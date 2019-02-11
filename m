Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7955AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329DE21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="E50iw6So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfBKQth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:37 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:7040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfBKQte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECSIoVa8JW6O8tJu7FSlaxo4KybqvBjFMHglIfGO/yI=;
 b=E50iw6Sokc0gOunkYg3kWG9v0ZZFsSiLNl+P26fzgbPxIAM5r7hK5fJZ1gUEkRyrgePdKBYlZbN25NZSNJ70AOEQT1ysFIoWDsmSppnRSCKWp0OWjaTODdmiUONt1NDfQNteDly2bQjH1QJLae0+sVJ15wmo7VVp5trzCldXSu8=
Received: from DB6PR0601CA0007.eurprd06.prod.outlook.com (2603:10a6:4:7b::17)
 by AM4PR0601MB2146.eurprd06.prod.outlook.com (2603:10a6:200:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 16:49:26 +0000
Received: from HE1EUR02FT046.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::200) by DB6PR0601CA0007.outlook.office365.com
 (2603:10a6:4:7b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 16:49:25 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT046.mail.protection.outlook.com (10.152.11.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:49:25 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:23 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:24 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v6 1/5] i2c: ocores: stop transfer on timeout
Date:   Mon, 11 Feb 2019 17:49:09 +0100
Message-ID: <20190211164913.5988-2-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(199004)(189003)(6666004)(86362001)(50466002)(1076003)(356004)(16526019)(14444005)(26005)(186003)(48376002)(107886003)(53416004)(478600001)(476003)(126002)(106002)(16586007)(956004)(2616005)(486006)(426003)(4326008)(110136005)(11346002)(66066001)(8936002)(316002)(6116002)(3846002)(74482002)(305945005)(786003)(76176011)(7736002)(7636002)(2906002)(50226002)(106466001)(336012)(246002)(36756003)(446003)(44832011)(8676002)(51416003)(47776003)(7696005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2146;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0030a9c7-b136-4145-effd-08d69040e181
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2146;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2146:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;20:MsjWyrf9+h49LWHMt4j5kKhYGQaIkhBKyBWgk3BlO1DdzWcYLEsv8CtNIxrsQi840rVbRh4Jh63RlVDpoHThnoF1Cyu7U6bT9iMwtAsR3GFNuKPW3wLUaO+xNqv6Olr1cY6dMJ7n3vh2QQT8nT7n8GlRok2p7817hV4VIK40uLQ4zZeGgoiePTRyFmm1Km17VeCI2vLu2TBhNSY5Rtxxzxr0tDwPv8LkkDvJhI3iPgrAdmNlBp0McLeOdUpzP+tlJBcLSLRVTBHg3cdlPhOZdVzLMXjL8lx/GO/XmJ2VoaZI5p7kgZPhD37TTtKsKSUgubspH9ggXPANjJxaEl6N8I+fykKGltlPtadYeyDnjOTeWd9a48aoya9KEXhX50NzaTiu+yincqlBo3KPzLerXRnElTMZFLI65lilXsFn8mnh2N1vmSljmXCAgFkBNHSyO4GCZOClVeqVtYz0lBlkUkTKEhDGUHc+vrVEOkcjV2UTlWj4Jb/xJ+qeKm5Oi8jJ;4:8/FuitI776l/Ma2IYRaF31P6jE0hmVa7CzSDOOdWjjnAtcZorL7N0fjg95Hkaj0ATA9E0da/qJd5xqT5FD2LPy1mWhgXAjICdxZEMIYheBSFd7D7R3DxWsEr4D8861zY7OcIExdwymS9e+yufqOdqNYb2S3kgHyGhiKgMheMHKXAlZ6ZKTJMiE56S/YFb3Mplb2+Bty9zTRi0kyKKyAGKvbdHjekX18K2XdySdnUfJCfSxoj89prJlLqQ2J8Ht3jHYmBb5CEvnhIwLikwBVkIels66RfuwsrUdNOHtC5oZQ=
X-Microsoft-Antispam-PRVS: <AM4PR0601MB2146F1C0D3D71655DF0EBDAEEF640@AM4PR0601MB2146.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0601MB2146;23:Zi/Hv8w1IZXxyHpgWPZUyGxyktQgrfDyYkD/mTV?=
 =?us-ascii?Q?VKvedj7X8s4MoiAnrk9jK57IeC+Nei0+F+b+Eb/2jRwyJ+F+oCY10Uw36O8L?=
 =?us-ascii?Q?baOGUJg3YLWZ2HhF0zhYEXuSmmOK6eK9SUkiOLdweO71vF2K8/vxdYE52Kuo?=
 =?us-ascii?Q?Mzi0G8qProXZNe3d4mlqe3KvOcTLtKS6F/anY9Ic8fKu+OTUazmhsfC5jw5B?=
 =?us-ascii?Q?e/FDyDQi+2yAFUu/Ia97EK/oAI7LiQvNkFdHnq3qh4WbvCPy2xbAQuC2zps7?=
 =?us-ascii?Q?KU3ke0kawphhaj2bqE3sWWAqhOCee7ZnUoZ0qhLtNV3lXWh6CVtZE8XcuN9M?=
 =?us-ascii?Q?JQnJgha6Jq4o9TndmXRV51RXVX01VyigJZ+pkgiElQ4u6iMZnzabO1PfPDgz?=
 =?us-ascii?Q?7fZwWTkn75CMP+GmljYtlbiKFQArCewYcM03s5VAobLBkBO6pCj2jvC4BIkw?=
 =?us-ascii?Q?xDNBB59fCTjHMhbRzWwLpn+azGlIwIAPrxnvojMGqTMFep2tVsqOIm+La67G?=
 =?us-ascii?Q?42E+85oO5eNWItxMS8HVOfD/uoC27I8T1hvrNg5i0KtP0TRjg032V8QCcJND?=
 =?us-ascii?Q?bmudGMkpE5Zeaz3BMElX8zRGV4XkgeaFA1Z/9uN1LluhMujeP6w6dziPcEde?=
 =?us-ascii?Q?kvhSPXK4Wg5j0wCIpksgE8ow9DJt4E8OJ4Ts5DqAX9DwjzPPA7razYp/8ySS?=
 =?us-ascii?Q?EqNsMe1NIZhHyi2Cb2YG0cdiT15UQksnIZh2ojPShz1f4og3MURwbDwRYazO?=
 =?us-ascii?Q?yrHCLLc/KuFixs/8NdxRWfmLzlYoRpzlffXdYoTWEdvFUBzbUdJlgKiG+he/?=
 =?us-ascii?Q?ijc0YDN/DaYNteQZq8Bbaifw2NZk41If/rMy0HoDeZDZVo3mz/DvO8zWS+Zu?=
 =?us-ascii?Q?hgY0b661uE/xas2Lph6wernxU6Ar6jrpR71RpwiRbw6jYLo5GvufYXQJjmpC?=
 =?us-ascii?Q?zMG3Wvs24HBC+sO3NT53tBMFxc30yeS6rHO3z0FzrGx7tftS+bV/nN/cklLZ?=
 =?us-ascii?Q?l3NpRJNCcSRiXzLVdLKkhwIyc0ZH0rNncAlr+5QWwQF3z/0K7vMb3FrCM6Ji?=
 =?us-ascii?Q?gwWZygYfe/dOZ1pnxyjn8pvR2A8kFjvU2uQff3FkTtXVxH6swCpbPg7zQ1ro?=
 =?us-ascii?Q?BTfdFrbFhNp5XTqKssXifwumy0ohpIeQJbL4zux9Je7TSsEREXAMDbQwWMJP?=
 =?us-ascii?Q?0BazOND8H5kXkunvpzZJRczuUZ40AyINNN9Wj?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jzatqIBCEsLEys96sjsIzL1WRAgHMR3m5wMqmeZOy0kHXPCBHN8EbmYD91cVRcbocbrZYjiVY2eJUASQPjTsIqFQSgEArcE8njIoukO6KWQvdUGzkNwrZrOREmI7MWTjNAQRKZ0QocQc+hya7Z1H0lh9G/4WPGdPzPprnZK7apbkh7ewSiW3lh7tghBM0SLkz0qlRGT7O4W8f2H6JiSoy5KiHotRg3LuYmsqV7/lqenWkaOgae0Ji1hS/NGLsfzfLpeoVwDNYKi082P0VLSl47aUQzjrQT2TDAqQpI08D7EWxfIuhCChEeNjEj3XvUtgpMc2f/o/oSnIkqn4dzmR+oXIYF6QM0pJipjELdqZjkO8dNmLePvW+peb33rc23KfP8zWnpAhsr5wEJ1e0GSP0n1NEb45R3asJ7G8D0Q/8KA=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;6:kJt7dQIvuHrVW2NWu8w20L+MZt+h9bw2D5swNyq8mc5/6fPBMqFuROWDgJ5dXK9u+vxjBcj7wejptkR8udZ1G25YTYr7qxoBsmT/L6Y7ElN06oWiw+alIaSE68t36JU8Tfq43F61kxJa1eUyeDHgkc7jvhzMGkWgwmYCY3vStgTw7x1Jnz7D8XHpSCW09XL4RopSnxjShcmM6zaVrHnCcztRsxTDU7zQ6jWhwo+Pkjg89Tqo4iafKx2UVmzPFb1ybehEDzGRhRTwLiIdyo3ITLW2oRGHwrHeHoJqYIQlYOUF7XY//SuTukD4Jm2XL7pvgRpzMxA7h19DXzlbl2hFbYCTLrl0bHV6k3w8w9cm0gJBDtpz8x6GwpIV9mMficSs/goFKdwT3gW8ObG7axoKVJ8fAstJYEXBXYRMA7aLzZWTVEWgWFfvcIUBQi9RxoSBQPdGD9EluqlLYEPkQrDrMQ==;5:J2iufnWzTpFCjESj/9yFvJ8urlqkTGp7s59RPNwjna5j9vobydSUbfqGazvVtn49E4wLT5UGUQfFrHkBNSpg72TZC8pAP4M83zaWQSwIujPQGmqwVWppNi54yiAICDCyCRuCclLW6rSKLyPQpn0Eohi5uT76INzIERp3PgQn4fwCux3353R23FQ/bcfN/joKW1i1HUSq+/nvASA1N8KEow==;7:mjXTELm0UhYzq1eSDCJ0sG6NC4VHgSfDEMmJoIWJIU2OSZlN/2T+OnR0a13yQwXwkDTykqt+2NRktmrf+nCaCKCW7EesBSTlXFzqIqPN0SvcBudfMZ2/64gi9PzQvpCV1CaBOxi8YzlclDiJFDtNWg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:49:25.2227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0030a9c7-b136-4145-effd-08d69040e181
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2146
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

