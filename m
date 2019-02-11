Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71338C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5FB21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="iFtBFzQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbfBKQGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:06:08 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:16304
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731555AbfBKQGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02EEmL7KkDY0boFc52AqfVdNRQfQIlh3LJdfe8zrT4s=;
 b=iFtBFzQiOi/mdgq7P2LsssAdvtynnoyU08/GW3YiAuPLNk5DF8Z5HoKwFWa+W60GwWcyAPmF7NlMWbcctUbNq+aSE66qdDH0M/iOXpSEujh69v909E8MGsirRY6kYONnHmC5Iig5yo5+GI7CGSN4CRwXDUmbo2AOTIAWf+8GhWU=
Received: from AM5PR0601CA0030.eurprd06.prod.outlook.com
 (2603:10a6:203:68::16) by VI1PR0602MB3533.eurprd06.prod.outlook.com
 (2603:10a6:803:a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Mon, 11 Feb
 2019 16:05:56 +0000
Received: from VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::206) by AM5PR0601CA0030.outlook.office365.com
 (2603:10a6:203:68::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:05:56 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT012.mail.protection.outlook.com (10.152.12.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:05:56 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:40 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:40 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v5 3/5] i2c:ocores: add polling interface
Date:   Mon, 11 Feb 2019 17:05:27 +0100
Message-ID: <20190211160529.23858-4-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211160529.23858-1-federico.vaga@cern.ch>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(51416003)(106466001)(8676002)(66066001)(426003)(74482002)(76176011)(47776003)(4326008)(3846002)(316002)(786003)(16586007)(6116002)(336012)(7696005)(107886003)(44832011)(14444005)(26005)(478600001)(50466002)(8936002)(1076003)(956004)(53416004)(186003)(54906003)(48376002)(446003)(126002)(36756003)(7736002)(7636002)(86362001)(486006)(305945005)(16526019)(11346002)(50226002)(356004)(6666004)(106002)(110136005)(476003)(2906002)(246002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3533;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0ef9e26-1aa7-4564-b705-08d6903ace6a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3533;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3533:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3533;20:D1HjWI0bzv3iHnDUV8/A1IKLCo9zP/BA2jPU13YDRjNq3PUjGFxML+5Boi4B5UFiRmusOwpgG8tObSqNNlDzftceh934qS64o6Ab3jBZJvHyuLxuJUYHL46im/OiEo7g9S94LOo9m1RRgxjVbo5aX98BnFQnesXyvl0Mmtvw52qe8noK2ObiiQq4gm1qUZ3GTsjvoYRt3fJoyEJrnQpLfWdmqeIZw2aQBetC8AtDrByV3PTJ7UoRv/pZsGyTx4PUyX/1rEla1yX4G1yys2GnoJWxFwC4EkRJygDrGkoga/jL64rOU37xZv4N+y+UP3e6NrlkBgThy6fvTEFt/LR7rcbYtlcCMqV8+qMbzImZ+DHEwHQtVvCHsZ+L5/D4NAb6ThQsIseD9nmRIzPcg7AGsTAZTYOGxgdMP7t1yK2xhl9yI62aTTY8A1hgGB5YkW5BRxusRebJ792G4bfzzzI6uGA5wLbRPwYJOJdospPbUkbFbuD3puv25eFT9puSfSNn;4:vrw60cF6Y4aSbKy8DYQGU+CNU7o4XGmqnYvpmF7UQACWS3mA37heKE+o4/l0XjuWO6Z1JiIYNLNZMPFoPE9lmY5WuhhlBLpDbT126yvaSerunOGx/Mpz9enfLLMOXQxBIXrqU6WwjQ9NC/jYQTEfhNSOo8DuXrUxcPU4UUvLvCNmE5tCHq/YG18WPi5L/98FdIPQ0Z5J7ZPfwuU3RqLyEENjPEaTWPSO30NKdjrxQibdwe4KdDTmz4KsRmqvlw1b4CACLjdI/C6ljIu0MZ2E4GNcD5js6iNFkU+4qOLbsaA=
X-Microsoft-Antispam-PRVS: <VI1PR0602MB35339B245794B1A7FC81443DEF640@VI1PR0602MB3533.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0602MB3533;23:ZvfaSu4XlXQWCXM6hYfPsT6KNhGG97EFRSuHEgm?=
 =?us-ascii?Q?PSNmIX0ygzoeFTOgKmvtvycDrJL647o6FqcusBb27/0i3wSbZ6FPa1r2sCh4?=
 =?us-ascii?Q?Zqt6xhiD/LBJLszYgLtKSfojLugZWcSUolXIYpGJ5kiIo/M9YiKHZ8Gsf00q?=
 =?us-ascii?Q?pT5zMB0YVFsGMzMrSRKsctvSTLAANVSnNWgDaeKh/XpqvLPwYGAxoON/uk/t?=
 =?us-ascii?Q?HDQ+ruk8ZCk3Gyw1dKUAyeTxZb/N8cRtYefXA2OttfASeBKDOC2TPX9L6CKf?=
 =?us-ascii?Q?dIeI98lB2ENs725LsC/7HvIhP25Fj0CZBzoHr7Km4ub4u6o6pbXwNsUuktIb?=
 =?us-ascii?Q?PTBL6GtbOWf9LKHBO9P1RdR8hJTvRkIM+TgDB2G85Mhxb3iBQQxF9AKpLTEI?=
 =?us-ascii?Q?DPKW3OnBhmzwj82kO9DdG2FimSaxvdIhHnGQTIQJ35pjNrtmKQ/em7dSLmwQ?=
 =?us-ascii?Q?fCsAowUfig7KYVablKF9jH/cBSL+/7iCOyqpY5rClGaqY8+aFtSYhaaKV+Gt?=
 =?us-ascii?Q?NSJ8iJZpoK/qNnzfimplWHsjs+MxRtYb89NoEv8RYOY4BtWSmGGXZ8IGZ1VW?=
 =?us-ascii?Q?hnfUN8KMUgwrKlwmJquRahkEQgEGhUBv28SqNDyjIzLMRtMEa+cEATDDYJu6?=
 =?us-ascii?Q?tk5yah2xc99RsT0ptbS04vMAipOyvb072B98WyqU9XM2Jdoh5+M4wT+Q2sGG?=
 =?us-ascii?Q?W0vzGaFCQHI8LKMZo0azJ0/lQp44x4pVQWbKGQlFiMa8f+9zQT/6lz/pYRhe?=
 =?us-ascii?Q?e3gqEF+7o1r0g4UFzq+Vi5p7OlWr4cd8DaJcuedCPUfCouqA/197j5Pqy+gp?=
 =?us-ascii?Q?V8Myv3j/TmCaKyDfmtFTVaZqNhE9QM6ex40fH3iEA/6+lZ6qt0CWbu50b/mT?=
 =?us-ascii?Q?0XRKIT+CJPYKAMC/wQqfTOw1fBEsJnUC0rDp1QDAbnj/LHPzt9BeAeG43SWl?=
 =?us-ascii?Q?kT/OKHhGqhI6n7tNCBDVsp1WGQSwG/fHx3FfxtKtC/v1voHiXzFUMs0F17Mc?=
 =?us-ascii?Q?dJ85fepEVXVbcGQ3eThmLf5BYpqmFjkeRUlJNQ4I4mzpj7u5Iolcuo1/irxZ?=
 =?us-ascii?Q?eOrmY40fWmJBrKhLgpuNisANHfEPSwg7LZgrc8LHQDEm9bXyidHQ09fSGKo/?=
 =?us-ascii?Q?2uhWcWaro+rNo24a/fzLhWzz2ThPDrJbadnF2M6bTgIo76ipIW/laPrrUMxP?=
 =?us-ascii?Q?yaII9u2lEF+QVcd6IPYr638tPwEfvbwcC7YZC?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 11tPss6EPUv57BzlPJZe60mHL4gZjg/bLgVOeA5ue7Hq0SeI8jNm+p72AkYs1rbh2mRlbDwxRmGGI1jKx774frp2sXgtB8gpVGfmjwrYOSbWTqzuPp0hnzO/8Rt32T/Y7y0nl/yegSNKSTOJq/wUNPS0xNMpTDg7U9u+U6jhlohN2SRhG6QRqzmydrtcAcTJpfkUcEbBmVyi9szi6Mht6l+8tf0QIFrWiDrBMHpM3RPUvCi+j5p/DUINEBkGBCg90mQIHlsabc7DgaP+qiAyFsURe4oHbYp5iSkpOF7KnqbvR572rm3zhcSJ627WhGhPbkQW6Kqu/2Yxp0jQ8zkDkhuk2y+ZZhN25iqZY3aZgpjNPHR5uxKEY5wEPLpuO+vazucU7fQtW9cwfIN8E4GuJEtQTNuw7xOIfoKANpHrgJQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3533;6:W2NC/CChrATcBB3IuXWDO2/J6dyEBOvuwOJIH1vEbfKnLuSsdp6kfUwoL8htqF51Jt+7Q1qUU3OuHIdwqwpoZh9BxJTi8LhVAsB8HAFXd4OdKcF6qvpJS5V+9zIK9LxWphWLhVqXl5clvL/lUybhhppyzgnV+cCzOsRI5fjDPe6aq70QM3H/45WNeKLKnXb8UZ4j3i0jOgTxAq3hW0whMLXyEvID2qOUyNOPvHgiFgUG7sg1fSWdrlEuJePih10q4EWkuEM9vurjoPQiF2XDUlPaTWaJ1Ql0q9UX8feja5wcyf+8nd4LkSAMIKxyArB+iEU5eADsaHCmpVyS05vKur/RG3VmHxhKylpyoccwXZzbWB93sA+WyLIC+sGegbi6AjUNxSkXk7OiUR2alQ79CcfOBu2Mxbw4ZrgBlhA3yyzf4LzQW90QESangFBuFW0r7PEqIcNBb/eJKeNjQObRog==;5:Fl8WEOrlN9i3C8TKyLOJ0tq/svHNgiSAX8vfl4YbGBo54cnkdDjaNaS9prl3cc+Tc5oyvVb+vzinxWmQWQO+n4JvrELG/MZPgJ1XdgsD4oVF1Ts9wOuGCRFMB+CjafBqZh4D6JG66+pcz895ufkKBv8vqEJVqg7RBUwanBeZ9X4H9LkK3xS1aVvqBhegaNl6LzQGw0yJC6gEqCTaGhFWww==;7:x0nliI+ffNhyyyNisjadkmA/9NiZZEX6Y+avqVxEe09B5m9cL0iBzXWQS/mSmQxsv/t8ApkloEZ0D9Gsws0l50wbSX4+OZZ2FnOQXMpUDX6mP1E91ELgVsyTOy8YZg2a1moARXa6GMH0xYKkvx+jNg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:05:56.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ef9e26-1aa7-4564-b705-08d6903ace6a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3533
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

