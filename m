Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A382CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B48A25DF4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="BtlgPUf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B48A25DF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbeFYQNp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:13:45 -0400
Received: from mail-ve1eur01on0056.outbound.protection.outlook.com ([104.47.1.56]:5437
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754795AbeFYQNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUXV9GBEe71KZonKFdWHeBTby9Y+WPN+bqrWb/UuV50=;
 b=BtlgPUf9CNO1tiskdYanw7Q/794c6XAIUE4sY1IA90W2N4wfkYNTiGAV1OQYJ7KVShyxgbVKeMIZ7j5pK0THkYznt+w3b7dgKZW4RfxPGJSUNwuJhXXehfklw9dTOnAQ26/2Uqy/jEKi2aL/J5etJGrT4LYwSP749N93B2BFxcA=
Received: from HE1PR0601CA0018.eurprd06.prod.outlook.com
 (2a01:111:e400:c513::28) by DB5PR06MB1142.eurprd06.prod.outlook.com
 (2a01:111:e400:51cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Mon, 25 Jun
 2018 16:13:33 +0000
Received: from VE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::205) by HE1PR0601CA0018.outlook.office365.com
 (2a01:111:e400:c513::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.20 via Frontend
 Transport; Mon, 25 Jun 2018 16:13:32 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT040.mail.protection.outlook.com (10.152.13.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.906.15 via Frontend Transport; Mon, 25 Jun 2018 16:13:31 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 25 Jun
 2018 18:13:21 +0200
Received: from pcbe13614.cern.ch (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Mon, 25 Jun 2018 18:13:21 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Peter Korsgaard" <jacmet@sunsite.dk>
CC:     <federico.vaga@cern.ch>
Subject: [PATCH 1/3] i2c:ocores: stop transfer on timeout
Date:   Mon, 25 Jun 2018 18:13:01 +0200
Message-ID: <20180625161303.7991-2-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39380400002)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(107886003)(446003)(316002)(86362001)(74482002)(246002)(11346002)(110136005)(76176011)(48376002)(8936002)(4326008)(8676002)(16526019)(186003)(59450400001)(47776003)(786003)(356003)(106002)(50226002)(50466002)(106466001)(7696005)(7636002)(426003)(51416003)(16586007)(7736002)(2616005)(26005)(305945005)(575784001)(6116002)(2906002)(1076002)(6666003)(336012)(53416004)(44832011)(486006)(476003)(36756003)(478600001)(5660300001)(126002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR06MB1142;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx13.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a69a197-93a5-4ff0-1e5e-08d5dab6986c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:DB5PR06MB1142;
X-MS-TrafficTypeDiagnostic: DB5PR06MB1142:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR06MB1142;20:AfkEUclKNzB0H9D5N0Wxykq3O+Fo/kWAoZuuypaKxKjxjhWobi7sx0G7T5Y3MLB2jsRUxW9hDR0nAceG3Rr7yWmr8KuuBA9yFeH99hqKzuw0IGxODKtp4sDFaCWpVFpUQNtEh9bB9QDCiPOz4Pf53kkoC0qt8dNFuiyRamBYpP7FebA9E9v6uA/V/4fa7WAelO3e/wFfezqX+aVVFhttG8unk69HmJlyZ1+SXj8enK7oDlvp73a8c+ji3bjRp5D/nLOc0hNs+tDad0jVkYa9pJ0Wp8/axkOCLF0D+I+blKRa0d4JZd7+THTIavw22dALEnQbY/lwgVm4Wu4aZSu6tZ8FIS522ebKrVeQjD5LPgTj5LFkoSU5PMpNpRK96f4uTwMGMMUGX8N+p8smlXtUT9aHkHhGOQgJCz5CnNv+KHMW6JpVyOUh0clihZCnyzfw/NVLFEjfRuo2bnOiDLBkcZ7gSWkXHI8414H42GaDOhAFGOtbUu7lRmdGwx1Unhpi;4:Lrlk+5neJ8GFLhXlYdQuQ3N89aaOYQlq2cf/QUC9IExFxv3elHAFVBzBjqdUB7Alrx1cI4tseiBvPKQFg8mT87tULoBii81HiA7v6jg/zeuIpwa4K3wUVZ8VyCbD+90Y1bLFpkEZ8L6AzddvUCqDYBavzTjvdgbQTJ32LgUd+DlXR4RDfn8cQo7B5OX+4RAwZiBOYIo1Oemc67ug+CmNpnuiUyA92FHQ7EDZVWED0BS38ijUdv+kcp5tVCxcdd0xj+maPIu1BdsWX7+9W3XBWg==
X-Microsoft-Antispam-PRVS: <DB5PR06MB1142DC95A67D5B5FB0F882DEEF4A0@DB5PR06MB1142.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB5PR06MB1142;BCL:0;PCL:0;RULEID:;SRVR:DB5PR06MB1142;
X-Forefront-PRVS: 0714841678
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR06MB1142;23:YZgPL/VrB3grfU5gG+SC5mNB6sacd+klkg6ET9uZn?=
 =?us-ascii?Q?Ieup/YKJRUzuS5pT1jpavMj/yxyVIXEVBjoU6qBJ8gWn/Dh3LGE4GXjLMsX5?=
 =?us-ascii?Q?GSJM3FNXr1VxPYdes9e3Qm3fjK4kaOyvMVRXCIEc9ZmFjxexi/OcD8lsmfnD?=
 =?us-ascii?Q?xMoCUNsX7JP4GOTkM2pI31EdL1LkCck7OokL1ENaa7uL7f4gPc24L8Zvwi+J?=
 =?us-ascii?Q?DY0wRVOBEj8clwSLOeovkNsxYJVzsXZjLef+d7a93cEwVd9eS0UsVz9sgCEA?=
 =?us-ascii?Q?EDoitrkj6vS9lmH8wuhhQa9umMtzLFVhgymp2WMxQsJybFY7CllMa7ELL51J?=
 =?us-ascii?Q?MsYComYhtXg2SXuRRFvGnZO0MN8uWQDgJH4hXQ4JhRqNdlPrggCEd/dHyc1v?=
 =?us-ascii?Q?1D3VahosslePCSPs8PnOpWF2qQxLhU62AN8aD6ALa/Pmi9hCHcNAE4LLGO+0?=
 =?us-ascii?Q?05hoF+vsmg5cL1KxIrP1atH+MMOv0EYB0C+l/1z06G/hTaQ+wcYZ0LB5c7pU?=
 =?us-ascii?Q?weOg4VubZqMTrSGkJEYaE7UUJZ0CjabSpt8R76rfreNfhEKD+yUwLSgtj3ca?=
 =?us-ascii?Q?OFgbH1OmA39UzWOTTHlsH8fFRtrJmnGYpyaSPONlZOuzFQrFPVGPsZ8hRxXJ?=
 =?us-ascii?Q?Sd69Fh04I0CrBRPHu+DcdUdLbADteAxiA8JpwcOtbd4yH5Q7Jxnojix8qgNL?=
 =?us-ascii?Q?TSKvy//nZHhClXvDnarrJbQ9Ay/FuDz8qrcuAQyybMN2e8RO35ZdLYJ8f3YX?=
 =?us-ascii?Q?gGOE2R3yH6/9q8tSa5yBelT7Kb2ZnyTSTz+iySLoGNSFdRn95UJbeefd85U8?=
 =?us-ascii?Q?XVzR+zaie39iUqIWsKBmPuGTqlCX7lkRTR4SP9OzXIPD9vIjxBSZbyWLoxbQ?=
 =?us-ascii?Q?4QyuAPvsjXkSPCu4uyOVTAZzIARE3NuAMAPZq15J3UUkuArOCbrZhSwmbC0V?=
 =?us-ascii?Q?HuUjxO9UCiSiaToc0Uosnw8I6U4+TE3zmMW8odzNzMJ3FzXB2FnkascnWL2T?=
 =?us-ascii?Q?p2kwSnq/XaQvwsuC/Jhakh3JxKGr5mMDgmbxPpS7QOkr3W15v27cr+bUCogN?=
 =?us-ascii?Q?jxYHHYYZi1kLzqphErn86V9Io4dCaG29hD5NM7PYYt5ZVHkIbJCRB1iagYuH?=
 =?us-ascii?Q?sIGZvgdrW7JEzzCPwR3etIf0A0YICqftM9dlYiKrLM2/pBYr4RjEBbqiqpmC?=
 =?us-ascii?Q?UVmw9i9DQqybhU8D/xYQW/amjOntOZVQPrbMeY1FNM9tZDVEz6F6NS+5PA6a?=
 =?us-ascii?Q?vB1RH9Tj32X1twCFhRV6FLWrJGDCSrj6NXABBTSkk9cQifGbIGOzJSew6Vbe?=
 =?us-ascii?Q?Qc2QePstnRHmmXz25fLu38=3D?=
X-Microsoft-Antispam-Message-Info: EX1Fs0lZRNU1Ul2WVA3m5STvqV5TdTA+dlflaSjJeMA7mSXNaM+XlKCy3w789p/RzBlGhup59bbbokUB6BPp86EBlNqMyE7XYq64LoVK5JA/cvBLg+3ZceoJItJlSf7iORh+r4EicFvNumB7IeVqBAph1KekoK2kZkZ7XOwKxgIsLGRHCW5+jjDwHZPOwrzufd+W1rHnpyE4/1sZrQp++T88An0vUagr59EqB+Xiig599Mpe+hAt/VEz2ZUpwWDi6GlG8ZCg4cluIPmMXpHwPPQ14Cc8FrGLaRRmAMirTEePCxxlt2NhDQV2cHDglNr7UvDuVwg1v11a3Ojjt88VigV+hd2MnlZjgdIDFbFqqPg=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR06MB1142;6:PKsEuU+GXoMrRa6N7PtzdgbKtvXNgKc6zQ0+fX55zWZuWbQeZJ4cxKnUQu3s0L47NGd8GZ582MVGMS4GrY5swKnLaNcTFZqeYv/JVsRKC4t2j89IWD84Uz3wF6BTs+TvbsyjVNhNXt4SccCxzKyqMeFdY+8vZr1Fs+sQXzc3thlcN7/byHyKfBfH9BYkeHFCRs4K3QQF7xFnpsMtFijFq8gpi8KUTjY0enwxoTcpqK7i3qzK8emp8pW0blv1OSouewjsFB0nWjPKGRbZIacoqpLRXYprgr3qk+BYwtS7zEzAN62LV2JYqZcfmh4Vc32JY5xIrHhXapVLkWPJqxjTYcJCNUzH8l9SIpZOFgkrxAmTvJTgHbNrG1HtjfrN/KEirut02CLFP6U8qwV8Mb08WxpebERkzTQc0CqNmlPtZdslha0fXaCbqUSOt0WaEp2ldkPrHjCatK2OzeEZ4orFvA==;5:OSk9aUilJ2M0bCAWQ+mGpikWX2m65g0AF5mRFGnfNWCsndc0vLJe1xY5tZlelg3A5FxgUsQTRGCjSdrk1pdu1vTW49CJ7pFkv1ANegW6S8HWsX5lq837qbhueSn4YrEcbhTvaavcvnW+BX/rZPOe9+CmZxaCl3u2Q4+2TgJvf6Q=;24:mXOw1SRG38Zb0k78iMn4T/cZPar4vi/fzGKF5211b0eJRaYoLkNPyzSd3Lz9x++YbHa4Muw0fUA+r87FS8sgjjoMoi5cL/GDMdxFx84C/FI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR06MB1142;7:LgRYxnbBPw0vrLI5lCjKeY1cN4/Ltei/FNKPopvxC4jxnC34rogWUpdBODdjmBAHsyDmtJV4gOfetnOvO70ONiAoMAz85iJb3OW+DOc+dC/+beVrKdTEGkR8RQFqrn4TQxNQVLKXpj54Cpo0jzQukQwh1bPam8ehDrDxjq4iRbNjmEuQu9JqmJN6bBhGp0mnG42bD6Zw4DPjeynMYJyg9DiyOeZqrEggLQ3zb60KekeIoy2U+4lvy3PF+WATXN2V
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 16:13:31.6236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a69a197-93a5-4ff0-1e5e-08d5dab6986c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR06MB1142
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
introduce a spinlock. In the IRQ handler we can just use trylock because
if the lock is taken is because we are in timeout, so there is no need to
process the IRQ.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 88444ef74943..98c0ef74882b 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/spinlock.h>
 
 struct ocores_i2c {
 	void __iomem *base;
@@ -36,6 +37,7 @@ struct ocores_i2c {
 	int pos;
 	int nmsgs;
 	int state; /* see STATE_ */
+	spinlock_t xfer_lock;
 	struct clk *clk;
 	int ip_clock_khz;
 	int bus_clock_khz;
@@ -207,15 +209,30 @@ static void ocores_process(struct ocores_i2c *i2c)
 static irqreturn_t ocores_isr(int irq, void *dev_id)
 {
 	struct ocores_i2c *i2c = dev_id;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * We need to protect i2c against a timeout event (see ocores_xfer())
+	 * If we cannot take this lock, it means that we are already in
+	 * timeout, so it's pointless to handle this interrupt because we
+	 * are going to abort the current transfer.
+	 */
+	ret = spin_trylock_irqsave(&i2c->xfer_lock, flags);
+	if (!ret)
+		return IRQ_HANDLED;
 
 	ocores_process(i2c);
 
+	spin_unlock_irqrestore(&i2c->xfer_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
 static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
+	unsigned long flags;
 
 	i2c->msg = msgs;
 	i2c->pos = 0;
@@ -226,10 +243,15 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-			       (i2c->state == STATE_DONE), HZ))
+			       (i2c->state == STATE_DONE), HZ)) {
 		return (i2c->state == STATE_DONE) ? num : -EIO;
-	else
+	} else {
+		spin_lock_irqsave(&i2c->xfer_lock, flags);
+		i2c->state = STATE_ERROR;
+		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
+		spin_unlock_irqrestore(&i2c->xfer_lock, flags);
 		return -ETIMEDOUT;
+	}
 }
 
 static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
@@ -422,6 +444,8 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	spin_lock_init(&i2c->xfer_lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(i2c->base))
-- 
2.15.0

