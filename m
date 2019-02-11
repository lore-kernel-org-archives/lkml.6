Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80178C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639121A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="oU4x4xhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfBKQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:05:51 -0500
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:42002
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbfBKQFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8tAcT/apF6DPLLmFySVdcDsEcqNwhs0WLE6X7Q3J0c=;
 b=oU4x4xhx5G2So46+5fwXj6XjKr1aDV3EFF0AwoPHmwB9IJSSh045bGnoWtOSAuX753TkYhDNVstUz7DmM7/rRY9ibgY/n7LZjoKaP+YGQ5eAHDaJRynecbCWUjf0/DJpmw2ly2zBCIVxMLK+1+/pqWec0LOccLaKql+6ms0agUc=
Received: from DB6PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:6:1::26) by
 AM6PR0602MB3526.eurprd06.prod.outlook.com (2603:10a6:209:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19; Mon, 11 Feb
 2019 16:05:46 +0000
Received: from AM5EUR02FT063.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::204) by DB6PR06CA0013.outlook.office365.com
 (2603:10a6:6:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 16:05:45 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT063.mail.protection.outlook.com (10.152.9.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:05:45 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:41 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:40 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v5 2/5] i2c:ocores: do not handle IRQ if IF is not set
Date:   Mon, 11 Feb 2019 17:05:26 +0100
Message-ID: <20190211160529.23858-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211160529.23858-1-federico.vaga@cern.ch>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0602MB3526;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c825e68a-b80c-45d2-348d-08d6903ac7df
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:AM6PR0602MB3526;
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3526:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0602MB3526;20:p0/0Eie7baV98kHh3H5oVUBudIaXUINPKqYa+9VaU+9Gw9wMDCuNQ2wKOSrEDZy4vtORHUnNeC8rr3Vd47a7cHNDFRH+sJQmHuygiqqFiy289/Fx4yewMqI34yxP/PnhoyLSTxoEb8zYzT/K9N9y07GGg9p9I+ZS17bFnw674sPOH0MhHQvKWjXFc8az7Xsxz4DgDl4UiAOV9BvDK0VX6IGCFHG2dwUWi2qXc2OhRQ+oUMfQsmMPzl99iv/aEtq4CsozCG5vqsFdMDF963Wyw/QSQoB6bqMjIFXe78yDQnI8ufyMkGfcceWw+4rYQJXzJcyj7QoQxix54nOXP7X9L3MjS2IT5kELLRmZbNfegUq9be9mzv2+2dgY1QZNGY/P2zZPMS+lVuWK51cTT5gKlj3ppGAByzPAjdCGrav9izhNdWUaPos7HIqdmOAA3bmJYH6Zmqvis4KzKi6PUt6IdMuT4+jiGK/W3DkmaXIGeyz+Z91vZF/8LzLHt3+MbnSW;4:eRncCLdePETIRIUtjdXxMjNwyY/X/Ax3sewHBq2chwEkiAKrgjSNVTZodgqjuIumxkdxJbKErnDyAXNwtPrTPTlV8oxcyiPiWqoeCTsD/iAL2katC0a0kyCGcIVguOR0+tKrKBVPQDMJRPKdoDOVZeeCWDdyJ2xHAR/43mqx3hXvTybi9NlzryQ++7mWZXuCLgBk0OzJBl663+AG5BQOaMe24oSmLbivgQ8hqBMeXhGk4W/UNqdh6OQv6MkHSUEymJnAF3LBKTxSj2bjaDDSbbNslWEbSAlb+hb6POvzlbEmVBKRJ5sYdXAoEaQXWTHp
X-Microsoft-Antispam-PRVS: <AM6PR0602MB3526C14EB0353087E7193C46EF640@AM6PR0602MB3526.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0602MB3526;23:0f4mfUb4b8cvnknITcOB4OmLAg+EYlFhUF2kocRS5fuw3vqP9gndLjWsWCBxGp/b2UJ1zN0kwaJLExz0wBiFmEcxgTj+8UfUeTaRIfZQD5iqkLnVagPG2d1uYo85H0aE3D4PsEdrv1YRzBYJ3xCdKufiGeYRrawBRpRuXd3cD75wdXrb9u3yhwiOKyg3W+Ra;6:Tq3diMl3Vy/QwGOqwNMojzu8PRIEG/jlRlqBvVoXwDLFbcfB/TbbedjSPbmiqFPEkDRoSJwmBY2gqzR9BkG/XIgUTEjcaT2bF0ABOW4Nd4a7Em9jJy+zm6CJhFaZH9QA6pwKkkKn+uq+7nDG/yrLNwX9xT8v6UgFewgDeitZBbkClQFtokcCGvyQWUTZ+t4ybhaan82OZNNsF1bnZB9KveBoKxD8mwtQIVfxXJd4HO949jlzHddEQwecgf7NCZCQXWiYH8j9NfVY+rMV42hrOuWwpaX2zFjUzv3ex0i7sEnudOX0C35SvKo65rgksd0K1zRYkazmAL5cMcMYw5Jfd+I1TXNwB03fdan+Fnt5FmBBBk0F9E1kgBCgqZTYVBOymyxWTr5vtsJKsOhrlFdSDBRe4zKyRKORFlubnkLBxGXJlklVmqT62KVlvmVhOOTQQu1CTUJ2419c1yJSD00lIA==;5:aUVEF5CeQIeH3bMAIUo7hQKiovDq9z4lYfMxT0hQHPGKZ9gNS0gJ8VamTL/smpVGtkE9I8Fipxuw79uTXChZfRLK/yB9LEka1RGX+vpG9CUd95grHzIgQlmYCusdzOo+dSld4A+rqMbSUrvEWD51wykO0E59Ckn3D5hqPTQAc6XM2U4tRfly5o/E0V0mqc/BZVsXZwHDtJE/NsVvZ+t//w==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9P5aK0mAGgywwkVTOvzT1F+ZGuMVUtmfKIDJWz8mC4uehvoh4h2YXnJSk8trDwC8QRTnJJ66vF5tXD4kUsZHIqNQHnle3rdewJt2sEuSr66SOMPo0HukwJwNoTEgSNk5pfLibOWYvD+k1As9Pepzhc8bAwHMIaEBr2j9GR0h8+Pov2RilHSGrODiN45lRQNX7oiub5I0xCh1hFDc4s5E+uZ9ZK+WFi0k+kpUFYI+6oft6r0TXk6CFojqPO69MND0/RbzRx4rksjn+9UhtlFn43y0tKIYJ6lRrLcq4rJyZcFmd7AxKaACV62l/wfQEJ+NW1mCrJHY/D5e3pSoGCdDVyuCZehEVnZRAF9vNPbfiXeo96mb9G+5UsqG9JngdIb6S0Dt1iBbhLicliUY4OO7q+CaqlrsYbAB0WbsARHvYBR3b7xEvpoUWziFk+vBUgkp5WBUB6w3Ks5QKZ0DBxMlYFnXzqiW39dz5ANNGDLN1DZlD0XLMn9miQgdPaAqP6FLy+wdpTdfXW/6fvPVaS4FH7Cz1ggZ4LlVBT28nqq0+Bk=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0602MB3526;7:BacPdaQjvKmjIpwbkpMEjRxwsJy2m6kXSm4mn1gsscaq2YU+cfl8XhHzJakJqoukdsd/iDOQTAJ/zgS6KWZV63sw0k0ULTBvEZ4/lYcMUzSw0jvu2Jbq8lUxHh2+x2I77/VID4yT3rWN1vtD0+801A==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:05:45.2818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c825e68a-b80c-45d2-348d-08d6903ac7df
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3526
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
- the line can be shared with other devices
- it can be a spurious interrupt

To avoid reading twice the status register, the ocores_process() function
expects it to be read by the caller.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
---
 drivers/i2c/busses/i2c-ocores.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index aa85202..fcc2558 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -143,10 +143,9 @@ static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 	return i2c->getreg(i2c, reg);
 }
 
-static void ocores_process(struct ocores_i2c *i2c)
+static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 {
 	struct i2c_msg *msg = i2c->msg;
-	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 	unsigned long flags;
 
 	/*
@@ -223,8 +222,12 @@ out:
 static irqreturn_t ocores_isr(int irq, void *dev_id)
 {
 	struct ocores_i2c *i2c = dev_id;
+	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
+
+	if (!(stat & OCI2C_STAT_IF))
+		return IRQ_NONE;
 
-	ocores_process(i2c);
+	ocores_process(i2c, stat);
 
 	return IRQ_HANDLED;
 }
-- 
2.15.0

