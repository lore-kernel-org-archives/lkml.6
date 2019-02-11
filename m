Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8845C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB2A21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="KxliK4Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBKQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:34 -0500
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:61067
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbfBKQtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8tAcT/apF6DPLLmFySVdcDsEcqNwhs0WLE6X7Q3J0c=;
 b=KxliK4EeQo7zIQ3xNSX7aZNyuj8zv6vAtF04NmTJZmfXPPZfGkjgKFDn6hfD+K0rDRsVdcsacQYlZVeUZy0UeeXwoB87+c85hTJNKSskqchzO34VCo76qaCTc+ZhmerUAtyF1nJ/GnWOsx0IVdaN60nNSwDxV5zKUTuIMSYIxdw=
Received: from DB6PR0601CA0021.eurprd06.prod.outlook.com (2603:10a6:4:7b::31)
 by DB6PR0601MB2152.eurprd06.prod.outlook.com (2603:10a6:4:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Mon, 11 Feb
 2019 16:49:27 +0000
Received: from HE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::204) by DB6PR0601CA0021.outlook.office365.com
 (2603:10a6:4:7b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:49:27 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT056.mail.protection.outlook.com (10.152.11.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:49:26 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:24 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:24 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v6 2/5] i2c: ocores: do not handle IRQ if IF is not set
Date:   Mon, 11 Feb 2019 17:49:10 +0100
Message-ID: <20190211164913.5988-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(53416004)(48376002)(50466002)(66066001)(54906003)(51416003)(76176011)(4326008)(786003)(106002)(16586007)(110136005)(316002)(107886003)(106466001)(47776003)(7696005)(1076003)(8936002)(8676002)(305945005)(246002)(7636002)(7736002)(50226002)(86362001)(956004)(6116002)(3846002)(36756003)(11346002)(126002)(426003)(446003)(26005)(478600001)(336012)(2906002)(2616005)(6666004)(356004)(476003)(16526019)(186003)(44832011)(74482002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2152;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19993c7d-c608-4564-f44a-08d69040e249
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2152;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2152:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2152;20:VVeJkCr4CHcEcxTqNxHG6F5cYu3FLeTuPqUcD2y1uJ5ycpY1+m9WPqgSHbd+um4UAdax8+wXTzv+1IRNfJkcDAVlATaXIxld5Fr5ztKWo8ibBKBeywvgWXN8bn718dE4XQ+buUG2TEmUQnn38PQqRBj7CCZ2xDHTk8/m9RhzEkCh4sRrCCkszWvz5eah+Rxarj4m8YKMhQtWYCjvaTOxMNAOPZav8ozGKhTJa3L840hGL7frHOw8K+iV0h4aFXT2gy70d+/W9eWugfyi8HNgbpVY1WsyaAd5iZndmO5dfJbPDipnaBWksd8zp4IxKlHmNpoVclef0iwOSQX2y8fecM8d+H6wDUmFkwmroopeKHeV6Ks+ti9w1y3qXjVix1pik7umGFp46wg/REBT5NJq2ynRU1+5gZulGBJK1AUjp+E9eNFkhSoOvC+R3c6+z/5Zo6vTIReW0L+wYR7adWRzKwG3XzSv8/1q7C2FXLzB5lpC0/aLcxtcBbix3WFYe2v4;4:V8ekLyzCSBfscndmCaU4J0kSpnkS+v0V5kB93HOJ3HnWy4RJk/ZonZvPpSEQAiQvn7/oGnbY5Jc1CQTzxrXDL5JKBTg5029swE6yDDyeCusIBoWmlXdhq6YCjsgcbFEUPm6wfdIXdQ6ZOypVapkcGPhBLUmfWJSyLokcrcF7SSrsE+2j98Khxk8o/Ww3i251+slCRH2IhGn9O1mv0eoMSwJlQwcBu7DwJH0svbh45YgLHDzCkkuKy6odv0f/I1dtkgWGy0dU7wkcKx97RHB7jfQWc4F596NAmb4dId+nkVw=
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2152F4A247AAD0AEBE974DDEEF640@DB6PR0601MB2152.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0601MB2152;23:TlWlawNppf9OOZeHkVMAr+obM8L26GSRMxaEIjM?=
 =?us-ascii?Q?qdqSLbPfb900zIv98UmUCbVNhMGXvkfuiaCT+dUsky2y9ZIhxN4FHys+OA1P?=
 =?us-ascii?Q?61Gf1un0nhpik7HmitEElq58suclYHSsVCV51fm9Zr2CXU8jcpTuWpxlSA/A?=
 =?us-ascii?Q?PdEaut8ZVLcp3LSif1tuVUWwxj9VaBk2m1O8s9CfrGJPACPjILwhvKrUhvv0?=
 =?us-ascii?Q?B0C4pRQ0pDnpqjeZ0vaZFZHsJFBQ84RFp1mqR5e/DfaHjHmJIbBa+fHxekAT?=
 =?us-ascii?Q?K8HTUfogt8p1nO4kQehHKEH0sR+dkbKYHQqrtWvDDiJHhjEq2AJ6tGTnCvxT?=
 =?us-ascii?Q?eYLpnUP1RAqJCMjhlbUd4xAQvHPkcWdwn8mJjGhhzEDCc1hDXr3grrxoCrhf?=
 =?us-ascii?Q?2N7RmPzMdEkP9/PE4BatL+od/IlIoG9fKKBicLV+R5BJOGLa/m0hc9mNxqb2?=
 =?us-ascii?Q?bU14hyUFJtS9BrbZOxhbPh5ZVSXIpDG02L6qvPlmY4iMPdh8rcnZ2qLbmbgx?=
 =?us-ascii?Q?eleltwQgdG4D0gmt8TSmv6KRB+gKBRYOMRfmmWSomYwzz+xanMs9ZaDpmm97?=
 =?us-ascii?Q?tZmzDPLTupn88QT7YNNTzXvsjhM2+48pDRhine0KNlHC+I89REzNMfU6Ru/d?=
 =?us-ascii?Q?1na7GKu8E1qjlbUWWVrEPLn1N/QgqE47qGqdv/VmS1G+3ay6N96lPh+oagHk?=
 =?us-ascii?Q?RHB8zy4/6n9onmI8y6r+nI5ss7jtcmXGMPF1FKHLI2ZxibM0FFdsZW0CmkVG?=
 =?us-ascii?Q?PB4Z4E64gKgUuUOL983blF/dAILayKM2VXEYlW2Pabw+GPaAzlL3tHfNtFX5?=
 =?us-ascii?Q?SJrY5oQLUl/5qN8jhObXpB8LBXafPKTnpOhh30J4M6dTU3w7WHAUuUU4827v?=
 =?us-ascii?Q?5I4fqGn13yhrqftx2f6wHcTXEWWZ6AGsVJs1ms6Ey3tBLvF9CQCO4HW3c20c?=
 =?us-ascii?Q?C0hC1FSVy1wyWGocckO1Xvm2arWeEaQXLRahcTrAJN+XHQ60RgDGJb7IxcCS?=
 =?us-ascii?Q?6z5wXStvEwiInfBh6D+8li+WNfzZHKCSVogsBHoeNY2HDizaZgYA+c8ceM7K?=
 =?us-ascii?Q?qNpCtfrK2RtcNxeezThaAGaTTErkv7Eu7+ueRsQVeQuQk9UFbmqu9tHMQmyl?=
 =?us-ascii?Q?z2JBwg7tmN9gGGWaiO1nXT1x5735R0UDMiXGA69dbFbqS7PnxvhqUci0mkNP?=
 =?us-ascii?Q?o8mgO33SeVpSN6pk=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0BBy0SRjPAWzASeDUyCPRxBrdFcL4ap0gPW6C2KMuLXk67gJ8gZZJngjEORYHhhi3fjJ8H+SnppbGacClpg728U48i3N4Q5UwrrIQ40xlHX9ktHAC47QYK4fb9JepyqeX9oxR3iiSXhS3UPax43Rr61iW57Zx4318aJtS3XEMJB4rMqnIo+oM8JE7LT+m5HbCGaDCSWw07onaG7a7Eb4wcZ0xhJpcT9QsChtSTPdK/CxiKqvNuieWKLC6irKVLgz8Kman356l/Gd8aYImLT2GGZlA6HFd3USn1xgajXTgNbAVypXTq7MPvbkgt+xL9NbwznOjPzjySy7yF4PwKCi270pPQc0rt/a56XWQgw/JkFQy+PLccVC1UqoY/svq009xFLkupip5/+4X8N2EjJDWCbObFuYVDnDKHGEQkOVfo8=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2152;6:6Q/oyo8V94eBDZsxo5znu0/p0j5U3nyD94BEChCUy01EoRvGwrIHu5DfM2UYinrcnA9qNwmNlaHMRF+tkOqSIaKmzgnr7AhAOCGBkUmqt7hgXJpUe/04dStx0Mj0PfpNaPed1y22CBaeADlo+b1IogvMyYcRbQTXyUa1qXW6yd6Nzypq9ehmpm/Mk4L4xm6yjFOs/xVhqnZMNoJvWg5vvV8g7c7bqipIcAOq3N/95tI8TTcxuz8d6IVN96yx86DXlUc4y2YxNJjROmFMNBUOb8hiNoIygPttWbOJ/0Jjz7DvOBG6h8hETwo9J81bHJUiHt0XssMbM1gEskXeNkhCLSw0QpGfTc7mVKAg2gDrxiPh0wfzR74xhIV9ft4Cf8ogAwz3LZ/qUgY6jHTAz8tsrCmxWWequql13flYEq39UlC22rFJ4M38Wtu2UrMAP8bRE69qrGIpXf8jOJv1CuUMHQ==;5:UU+T5OwtCuvvEYoeosKrg+Q3R0nQwNe8E6Q4T+X2eiB8UQHl4amzi7gBNoPxHNZq1Nej1IvnG1AO40l4my8aT4xBL6w+wf7H9uP9wHll2WZuugmGWP8Gti41C6kF52JdfteSR7bQ+R/yY6i/1x+m+MHsmqvdY7PvNsCgFfSFY65iQKnDOw89fBfyfK1UYlYOkni25PZays4xRRFz3Efx+Q==;7:AIyaVgfSa/iNNEGevIc71MB8DaUp4jQ7CzEPJQyY2WcOGZ+TP/x2F7ze4qXxJuVNtyn2LNQq1gWO9cqeZI0ZV5C06U3hwQTJBeO37m0ak0eXu1JC8P51Mm+kV4iFZMvprgJtYrjzSSbbhHjD4iRWzg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:49:26.5475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19993c7d-c608-4564-f44a-08d69040e249
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2152
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

