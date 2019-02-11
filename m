Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4808EC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31920863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="UBAVJPQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBKIcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:32:09 -0500
Received: from mail-eopbgr120070.outbound.protection.outlook.com ([40.107.12.70]:21536
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbfBKIcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JTNzsmKwErAAd//GAVWgR2NqKp4zHNiNicfI4xabBA=;
 b=UBAVJPQ709O0DUDlTzxbJUiL6hoU7O1xEEojb7CH1Iwoo0exBKjr32ndMUfZJdMRIg7dkiZGmYPF9RFU7Du6w8kgbSi1d64UGYStV97C3mgpVc+HEu38O1VWkHm2OlN6Rm16H7J74Nv7wxfZq+kPG+JQBwosTaxfTKOHbBC3lg4=
Received: from AM0PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:208:ab::30)
 by PR1PR06MB4729.eurprd06.prod.outlook.com (2603:10a6:102:f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 08:32:00 +0000
Received: from VE1EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::207) by AM0PR06CA0017.outlook.office365.com
 (2603:10a6:208:ab::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 08:31:59 +0000
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
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:31:59 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:38 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:36 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v4 3/5] i2c:ocores: add polling interface
Date:   Mon, 11 Feb 2019 09:31:20 +0100
Message-ID: <20190211083122.32485-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211083122.32485-1-federico.vaga@cern.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(189003)(199004)(246002)(8676002)(106002)(2906002)(8936002)(305945005)(6666004)(356004)(14444005)(786003)(7636002)(7736002)(7696005)(50226002)(110136005)(51416003)(48376002)(76176011)(1076003)(316002)(107886003)(54906003)(16586007)(50466002)(478600001)(126002)(44832011)(486006)(426003)(74482002)(36756003)(476003)(66066001)(106466001)(186003)(86362001)(2616005)(956004)(336012)(16526019)(47776003)(446003)(26005)(6116002)(4326008)(3846002)(53416004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:PR1PR06MB4729;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b53381-4f72-43b8-3975-08d68ffb641d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:PR1PR06MB4729;
X-MS-TrafficTypeDiagnostic: PR1PR06MB4729:
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4729;20:y12kMESD+yz1WXrAt7n4c1SWK30iuVYqjqaFjPbF7T4sDoU1/MBeLRx5/T9te+d7g3HePPi2hg7X7iiQ9hHMIutbrkhqgKSF821qEQj2n4R5t9QUEHma0WXI/00gedcfjTc5afOomt7HOOcyuuXimEPF9sc12kQDnClVI8VgGvhXIGZ0fP3NTcPLYFLwgMh4pYiUvxSXppT/+r9eBsWeNAN7mvN2HqP/RLhID542DDRgYyVUp5bwp830Oa9kPFcUo4VHZ2T3R5BWsCQc2DP0bpIdAduCVoyOzbq8PMaRbZYfzVrpwwPBhpTJs0/Wb1GsYRbv7OA6X4blExx4tcSUJw5uvVORF3y1uQmAg/0e3GBfWxzj93CZrcipGHCQ8+8cSxX48oYibmgaCM7/7aNnL80oBWRihgyG8Dl86nS64krd3JT2R8d5aIeSDb+ooLeg2zTZk0mr15tQvkQvDVWFGtp6sl3sEh7mOZ5lYDNo6dEj9OkIMMG20ouhod22hsRD;4:mijQXAOnp10PNadQx/XgqLz7MbTCT7acF1MB169/wNsBcAKBreiOqd/LumFyrTd57NTvPKLeSNNNjxvN5NiCPH0QTr7oIgebklB/evlbJRSa75uyp5OcL+DuEob2MC+7ruxe4wDIi7WM1gSFaJbqvl4ZXd0kG4+CoIsqwY8/xFMVm+wlu2o4oJfccopU/ExcS94TPTqzF7QydFXeZODq7Y5WTBln1yfze4UQ3lE8plLU2B8TxQHVp2yxhc6fKQB8jPoSCf2qtnvOxNH4jmkQ1GEbGguJ1ifBeID21fIjjKc=
X-Microsoft-Antispam-PRVS: <PR1PR06MB4729E762E51F52425A862768EF640@PR1PR06MB4729.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;PR1PR06MB4729;23:7rvQkep9kd2ddM/rmbC7HOIiRQSQveHVwSeEvq/Gc?=
 =?us-ascii?Q?Ska6KsMzf2wVBqhWjidqic44eKgwKkJiHt0Z0duraSt4UQGYIzG+SGaKOqo7?=
 =?us-ascii?Q?8FNqhMv2oLNcrbG+Mmg2l5qEqBt1wV9jEdOmZasoY16EpFalMnfsv1llibcI?=
 =?us-ascii?Q?qV9UgBtUlIaL1kfE/pmGsQCVhipY/yes3QSktvimPK/J/FE8RU6K1xEJSmU1?=
 =?us-ascii?Q?bHSRwawb/EYpAmaTvo6wdVO0apjVvzYwP4ldfJ58rONMsF0wYW7hTqD2JtF6?=
 =?us-ascii?Q?awyf1g5cofzzVYfcxJ7eqjnqnAL0vZuhUuRAwj+hn71LqOyYjj2Ux+taqVzq?=
 =?us-ascii?Q?klr/aPiluSV4qy//80CwlPiwbu7aH+/B3DNCMmpysjQeXOBLzzjG3gXMNEQ2?=
 =?us-ascii?Q?fmTbJ097n37ao3k8KBlgNAIsyQH6CL/kI3M6MijUhyB0j36t4k8NaqgK+jBk?=
 =?us-ascii?Q?4/rutRTmuowge3kObbtS+xB80A1LaH2sU18vdz7sMfh/Xjjc1GKizG8SLHYD?=
 =?us-ascii?Q?8SJBGi6vcQEdaFGvKL54huESaE2PIJNRirXooe31iDlmIP2hu4+XUi7LEDVI?=
 =?us-ascii?Q?GGAbzI+w+Pntt7mOLFCedZy2WwCKuwxxNjH833ALXf85MS6jXQphLarcX49k?=
 =?us-ascii?Q?x8NGwC3AEqoYTaZrX9n9q9PzO6GFXwdf2hwD3nfsLa0u1BLV0RCgCKWdziR7?=
 =?us-ascii?Q?W8Pl57lpVnekQdHonJzidZrUaE6fnXb5d6cvKfVPTSy6zICjZ7TWa/2oaWjj?=
 =?us-ascii?Q?oCnl7rA88Wv+0YIjqUThyYKUzbQR0c479pbo+6shspXS6urKGWaVj7LN5VcB?=
 =?us-ascii?Q?CXp31NebrQ/t7eA6RK53nZanf1SXliqUbUXkXzTkIkx1Z4rTX67rs+sWyyBc?=
 =?us-ascii?Q?OkIxKHvTJkomd1pqR5fpUSlNz8burUk2xjZFGgGuokTY8NvWEyPwbJ27QIYm?=
 =?us-ascii?Q?JQCdmTcsgxlclU7HFGyr/X4wHUOsWijjhSr2rJGMb9S9lLIiWdGHu97u3Xb8?=
 =?us-ascii?Q?XtHJFP/FrbLnrrYV18W19WQS1cO7OIAbxMbQtyTWaF402WfEsTUQ1tMlRGVw?=
 =?us-ascii?Q?1sfrj6pn+JjCLpVoWZTcIUSOjlUOd+70+EM51GhSrF+toibWMjhwJGhGrY/G?=
 =?us-ascii?Q?TwaNGS8sc7p6trxPLasf4mHsOt16ROvGf+o2ytSUg8twGY4W3uejymn/DuZV?=
 =?us-ascii?Q?OXw/vjm287regurptgFXQlrsxyFJ8gvDQcA?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Kvapnswfml187u5XAhyFF5ykHtg7qcZ7icHhBBB0x6z0JUZw+s+fkrg0TXie2Q3yMej1W66fhNaflyAoxjdbzlAoZ4eiDQw4cd+1SgrU/5Qu5CjDpyLWRbNSNG2Vs2vNw9qljjPF09X7/Y/Lyw+Y0BnIEXKN4CL0X8h2cIdYlF77rz9BeEPhB7WtMQHee4f2e4fdKz097SHF+4iJM4AtL5kIqRJhe97SBJDh1YSIkNyu5If6+TfOoIDHPhSDJOkXkCIjxT+efRfV4FMln+F4DW8eil1Vjc7X00axbKq6A1Yabnc1zE4w6VUcUhp/A9ra4wT1aGx8/7AYdeFNRo2W7pmfgda7lU8SB6l97fNW4RR9RsS+TcWYCEZfN9nxL8DbjP9KnuBxp3VBxSmANnWKWYorm3qTvtccsAxq0dqtkHg=
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4729;6:LDpT1Smz2azQHH7zI+u3IwaG2IUDpF6ynuEYf0gzpeAXeDgcqz1mRbiNcBcswBuIG6/xkVEaEezayWzjj7MIiD8Ud0Gsbc0V8/dzndQYFxUPRNts4LaF9Y5UVgx4IdgLfJe68ijef+GcHOBg2x6gvbOx2hW76kMHfVh2vpnKVFAhR0nWZMC4Z36C3KaXtecc8g9Fx9EnmXkK+zc7ND/NiMtDA9qrUz9XoCvKnfm3KUo8c0YyoQVKu1nIOCxZVpSO6o1/+s1Zxw2rSXGFpG5RDQ9CjUZQ5VIGgFW63B3122jGK2Ri0xDY/oe2nHcA83u24lcx4G+axRPELUveRRL21a8WRNIWe6R+n3VraFkNQL0Thc5iIUB9M6fw7Cm83fnF0OOkBvNK9DXxKJtkGlwSSrCX4STxvsNGeFzP5CoAF5pSf33dLJT5t8WlpYYMz0xjTJTvhylaqHWSwnJyDNTnRw==;5:myJ1Kdgc1Si0dF+fMo6cgpPPRuVACtXnjChd5koe851Ev5qa9/IlJX4WRhoyt75gqnbysc36e6aM+3bGvh0jhwKpzoPwKfYSxFmE34rRBmPWO5T/nRqx1Qf+CW0JnAjdJt/or+00uEqG/ltgQRtfe4ZmYcmhpTU6l+XJv273+Uya6HyKXv/pSumhu8+s17PzBgiVEV+8vk15MYWM/Qy6Zw==;7:3wgwDShJgkmuU0WVRdqETJQzOkzlQNu9rISiGLf6/b32X4YN7ywmme/NM462eHFEoAi+ZwqLZYHfzVLIWXoClahAR4rVOnlsckbgB5n+2sm1u2kZnr0+EAhN3+wSHWL6hoJOFGP5Ki1ExGvZ8uFCeA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:31:59.6157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b53381-4f72-43b8-3975-08d68ffb641d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4729
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
 drivers/i2c/busses/i2c-ocores.c | 180 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index fcc2558..d42a324 100644
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
@@ -246,10 +251,117 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
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
+		 * We wait for the data to be transfered (8bit),
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
@@ -259,16 +371,37 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
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

