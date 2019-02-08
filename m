Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53712086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="ThDejYt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfBHQMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:12:42 -0500
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:50307
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfBHQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECSIoVa8JW6O8tJu7FSlaxo4KybqvBjFMHglIfGO/yI=;
 b=ThDejYt/zY5x0B/McSBqdPmFQfGVcNO7tmJQd6LOUlOOByw+L+4L60ijjLOZgnl2XjAoROovbvvXmf40y45L1j4cvnOnJppV/jRLjfoFltskrHhY06gEHhDYq0NXRuBs8b3e4VUpGkn5Al+P3VwWBYiwavrtq3wsHsOnLqaViro=
Received: from AM0PR06CA0056.eurprd06.prod.outlook.com (2603:10a6:208:aa::33)
 by VI1PR06MB4015.eurprd06.prod.outlook.com (2603:10a6:802:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Fri, 8 Feb
 2019 16:12:29 +0000
Received: from HE1EUR02FT017.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::205) by AM0PR06CA0056.outlook.office365.com
 (2603:10a6:208:aa::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21 via Frontend
 Transport; Fri, 8 Feb 2019 16:12:29 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT017.mail.protection.outlook.com (10.152.10.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 16:12:28 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:16 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:16 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 1/5] i2c:ocores: stop transfer on timeout
Date:   Fri, 8 Feb 2019 17:11:57 +0100
Message-ID: <20190208161201.7860-2-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(50466002)(47776003)(478600001)(356004)(6666004)(106466001)(86362001)(6116002)(3846002)(66066001)(14444005)(48376002)(186003)(486006)(2906002)(53416004)(126002)(36756003)(476003)(2616005)(956004)(11346002)(50226002)(51416003)(446003)(16526019)(7636002)(305945005)(7736002)(8936002)(4326008)(246002)(44832011)(74482002)(7696005)(76176011)(1076003)(26005)(106002)(107886003)(8676002)(316002)(786003)(336012)(16586007)(54906003)(110136005)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB4015;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90b77c7d-5403-47fa-0ba0-08d68de0393e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB4015;
X-MS-TrafficTypeDiagnostic: VI1PR06MB4015:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4015;20:Mr4TFxLSKd6rDfqBafP3RKFMYu1FwJjofHazHCLhIjXONCOyvVtNWjZL4NSTWRBUWO9Xhka1zPX2Csl+BbJ3+du1tQxUlt4EhY0vonByUmgJ0kkwyh6XdfNimicWQmWS3r63+8HxwXbqfGcCyQo4AitvhTCcvSvP5EhGWJhHf5OmZ/bWJ5IIhdkSpQ2X3Hf5b9qcINk8lQB81rNuYcrmmxfzf7BJOX6oPSywv95H/b6lEnxg7K+zdqje9AALBzcsRhAma/4vjbeZk6dCFElOCmkQeQsF4COoX/E/26Jq5dl5jb7qITH68cg8xQ/OUMRBQy+rRC4OtnvENNc6PiqgS5QH5wSKg1cWgmGbmUVgQ8by3UZg6RbEmev5zkWKH+fu8Xu1qSc2Fl9D4nNqBCfMOwFYiI5KhUtaYW0V8+llVZMD0cvVVViDntWWvGRS/xWn36KkG2egXgL9wl6Q7ku9MZdvksCMvWJsNee1SmPFxGIEpSv5zosjCT+i1TelvmDg;4:IMfOCqe7O7iQ1izUE9nWkSoEwnzRPI56qgutMMMc/z94yaA+PEe9nt4bGAYDRDmso7VJwpnPtUOcdm4l2Gq+D+IqiCf8ce3wMGhu78rurwRDFrjnQwxq5m2mlKMHTi+XIGkmqj+BzUfsgp03jcFANIxej4cnB+SGm7vh3datsuO8+AqC6DQZi6Aq4DtlGKQCC0Gy8ru9wlNj0FBqrsGmjba6mJamecC/larlkyJuQP/Y1noIiVKtVwjClO5z1bkXgWsBM88IGxIR7miNBd4O8bccmrSdPqXW+ea9I9F4mq0wUUvHCMiD4zKWLwaM2MQq
X-Microsoft-Antispam-PRVS: <VI1PR06MB4015609258FA8129A107E58BEF690@VI1PR06MB4015.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR06MB4015;23:7iwfVbckdpqj1JFZLCuniCMp1UNNcgZczRvixbGzF?=
 =?us-ascii?Q?a+VzIpUp7iELQrq9jTmkIy+MymGlKODD/MaSUqFKIp2DKJKMo6IBegfinFjZ?=
 =?us-ascii?Q?R2oIsCjRCDclwufHK/uryNfMX9XyFZjG7SuutqeVzS0TgZKwDPawpdeumHuV?=
 =?us-ascii?Q?uzybCzaJ5w+NJOXBkBNGQLV0uLzN2x8b9gWaa1mlAI/KjQR4oLEYHXPITGVn?=
 =?us-ascii?Q?XJVhU4mC7fnM9oZUutW1OZCIbEv4JvvQFImLRADI6P1FJ9tsmtLzk0pTXcjm?=
 =?us-ascii?Q?ya2+4Tf0PoSB2QDV04iMqzjp7r9/7XfoUaj9LoDZKOibo9kM1pMVXoGp+1qD?=
 =?us-ascii?Q?KAO1iGMJm0ovBnv/3b0lBbyguu5O/NjQxi2GtSeNA1UJdgCl1FPiu5VZuZx5?=
 =?us-ascii?Q?lT5FgpVY0WBdNTDVEbPGUnAMGaO578l2rLsL97YBXJ4kq7QZ7J8f3AG0wkk5?=
 =?us-ascii?Q?UhQPriasw9n1WnnSpuIF1kc+iTlrolcF+zGYkMN94r7kMxzbG5guL65Cv6Tk?=
 =?us-ascii?Q?SQ2m3xAHcxlCUth/gPiH99j/rDsi7UsgEGGDzmJawLUcOcW0dVpcwz7BBTbe?=
 =?us-ascii?Q?ySYrYr0ADIerIdk2OJ5Yy1VIikLPz4c2dZPibpDFMCNOiFAI0Nv8s1gL39Fk?=
 =?us-ascii?Q?+Xlj+z6iaGOygMrjplh1GKBhUHjIy65cMaN+dXpVFMKo8XQhlPl1Fi1EU4YL?=
 =?us-ascii?Q?roqcUQ1xgDnGHjdjUxmjlqldzgg3rbX7q8hGMDNWYOYQZpVYqx3Jo9+JDVLb?=
 =?us-ascii?Q?sJCC7gzkyK/zPT9eOXpRi8DW+f3frCVB9ZqFy2yBCOIUj+7hZntqk1TNt5ID?=
 =?us-ascii?Q?klViUuVl40ct/fFd3JKIEhkCEDxGMrTs4e44U6uCOW78V1VLhilydzv3Thrc?=
 =?us-ascii?Q?qV2EHXKP2/NyzYzBIs4v9fnhmu2ly18GRvYTeMskkHkf4VjIJgyqSUjkKlFL?=
 =?us-ascii?Q?wRPPdWxbRuTLkCG0nRD3Vc3gOCKHxPajiPrl2TN8+2Ro5/TOUkfSGzip9D3q?=
 =?us-ascii?Q?WvSR9aOiwL2N/dmi1nPn54HXXajSVtLi3iXvmZI9+Kqu8qaZmmj122sdsCUp?=
 =?us-ascii?Q?BjnQXdsbnLKHpJQVFN6GOFVNNzfVWFb/UhX5B+ciiapPZYmExA3E9mB2XPN+?=
 =?us-ascii?Q?E0Z55h0OjsVtmFhJIeeWLeYWpG4XoKJMPalJOa+hEGGKAGWKWJ0XwQhBmbXR?=
 =?us-ascii?Q?evpOo6tcuou+47VNO9YB15V/8yaZnxZI2Zz?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: y/3bD81xoKUXztDOSo10wFpt5oYHqflAnl55vWtg+ijeL3JLXvrFCr0y0vi4P0WpytEae3aE9lF4DZ6vAPCqEDlNb8Ao/HBQ+Cp+BBg/k1eKp1yiHspOTuhr65VStvV9RqAGxCKo6Rbj0bStUaHlP/T4UOmOr2OJ8urrvCOPer3aVKiniXAXVmz/UnFDQSOigDoIpDlZPO9aRkcT9NI0n4CB9TzT/BE9MmFfe1Nm0IHwLpQ9a8M1hj3zjoSNvzh+qrRY9UHVghFWahYo3tIOLyWe1ZOJ53ZHuKZu08uQ2dIc/Q1zBeINu46q094LZHu4hZOouev4IgG5VGmZFhuGHg/ZnVMPCd6EbY3sSx95DDcexwUU2YFgIKdxot2bDv0kVsWJpmGMK2TbLbkRCVz3L3CZWP4dwFXhxDlZvQyYFMw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4015;6:MfGIEx5a4jS+M4TuCj8CVY0bRREHqbgVuADsCxRIYJ8dpL9sOk4zLR9OcfiSrl4tvXAIfjTamxHrpbuXxWA33KvnhswSNHIypHxP4XZ2pJRpRxmLubSkOtLONId+lEaEsKbfIvFsN6Tp59Gx2lsU8nTt7ism7J8jizGoyHy92sCt04mkwVVhLno6KoAipU1quHvo5wbKqxqMYr81zzkJDFZIRL0wBgUwNrnk/hsyjRUdfaUGnN45CZlGwg12GQ5JRfU15IcaPrUneNpH2FJpIiPLdxLamUCz5kf/Yp9dtPZgb3353DAcORkDhqsHQ8E21pkacviZqjQCdhUtTOyZ9Nq6ggHwKnkwHdvbQeCpyJJ//rpZOiKRXlIsnJaFvMngiR9j9tLtECXnxrC89QdQ7fwT2O8o/72064nlWKPZCLUHm1sYfyaLkrAiEjLkF5E8hbWVaaSwFPVHnsxJ0M329w==;5:m6++fnVreqEjKhj6xHy6LCcL9ZlMPQ9LzOnUSQpTkRojpabvlZ6f9w6H+OI7Fw+ujDLub4L2cojIayiDRyPdLSwirsAZ5lVV7OTjDjnNXqesMfPwnYfAlksgrKp6mD1hzoQpj2CCDTG23NeT8/uCNXTXcqQB4A4w3fG6adCCqz17ZckQzlkCjfbh0OqHnP22kA9mhd8kJgnbxs3t1B+r+w==;7:5dgVqQdCXmGKJJAFEZbvQfvHdepDZGxj4+s6ao+Ltlgcr8n2rm6Erwf/VyoUaNdcHlQXvstU7yk45tusxH8ztlPgfdbjUCnpJxTlfv/yRENSWDdr9HLPw5HBrh7YrzSxABI0pS1MEXDAeYw4lrmmQg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 16:12:28.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b77c7d-5403-47fa-0ba0-08d68de0393e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4015
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

