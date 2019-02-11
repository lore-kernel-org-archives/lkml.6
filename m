Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990CCC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB79214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="kWThdFXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBKIby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:31:54 -0500
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:8224
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfBKIbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLwsofVkTI5AVlJfqOgmCA10KEihOww2hNo+PbYbw38=;
 b=kWThdFXIQggGfeIBs7FLMXeA5CQNJlI0BjVsP6NkNlIE/esdylWLxB2B1VI/7xNEQ1LrUXrheJgxklrcY9OsnsBf6F4/nlI/m/GsW+OO4hGstqvaJgpYQT75TByonNk+tt4wdgfTmeSC99gOz7h6FVU/AB8TBmzqBPDzgXFCFOg=
Received: from HE1PR06CA0150.eurprd06.prod.outlook.com (2603:10a6:7:16::37) by
 AM4PR0601MB2145.eurprd06.prod.outlook.com (2603:10a6:200:47::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Mon, 11 Feb
 2019 08:31:46 +0000
Received: from HE1EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::209) by HE1PR06CA0150.outlook.office365.com
 (2603:10a6:7:16::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 08:31:46 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT064.mail.protection.outlook.com (10.152.11.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:31:45 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:36 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:34 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v4 2/5] i2c:ocores: do not handle IRQ if IF is not set
Date:   Mon, 11 Feb 2019 09:31:19 +0100
Message-ID: <20190211083122.32485-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190211083122.32485-1-federico.vaga@cern.ch>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2145;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca4095c-e107-4072-ea57-08d68ffb5be8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2145;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2145:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2145;20:4XIk0fIKKMaXjGfGQsgozpbaRhHrMgpb+2lUmIbMkqZ6dPfct0XPBAsG+kRKV78Q8Y1NzXRGPgStsnRjYAPJBvUmq31qZFYr4oa69YZjFOR/KWkt0PP+f6U532kaD2PR5PQlkcHXG6dw3b8AKNuOdTjyRjVqr5fYlSGPAHebcaibJYBiijFa3ZdVCHkosa73kbbOFa6s6+Ucg8wWNxh1T/axx4DEFq7n9XhrIolbcVaA6hU51Ki9wBqAA8XD02UDJFqgoZSJ3RUBVH4aZ7LJv3VXylJTqizDL8EWXOs/kJNa1UZCsl5JjzuHUiB+p9Sd9c81Bb65eLRsX7KiZ/FaCuL2hckESRKEOe0e19qHQaoh8gF8lL49yQhEFCDxElq22ms9LlSOw2KGKiG+pC1PIxDDqrFBJCr9KaL68i54wxDRYw/jqbCd/5287tqHGO0/aj2EkuYpnEFVtw5bhKTHuZ0j/VigCLDEb3V1v+gE9fFevwgp0cVPptH6zSkTaACv;4:i4be34KiFanBGWM24y+MewgtNK5K4G38QX9Pht0i7YHe3LU4BzMZZUUVryr/FgGk8pEBmJ00Q3Naqi98oYwzIfcoi3aDqUtLeD0kjprh+YhFzQ0+lLnXwEwjr77XqjxnPbBleNLUkNurrHJVtcl3lqhHrLi0WUBl0d7x0UorK5cqP3ekAP5WKD6Q86JHQnTZ91A9SPbupIx1kSojekP3zVOaZ4QqF04t6ayExav44rWE/kGJi3/igDoWah/V3JtSPB8AwnI5GbztyamUKTTMlvKPX968J15wF7C8ZGBTgyTRnt4iYhqEUgu0TCHP/0ei
X-Microsoft-Antispam-PRVS: <AM4PR0601MB21456324C0915A222137D4FFEF640@AM4PR0601MB2145.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2145;23:5BP39nlXnKlkovhUz5Si/O7wkwnLaGsCOOycbJ9pIAhb1jFwVJqkSi2Gd8WjgFVMbg2lTWEvcV7W3FTWWIqsqWDxkJQmCNq+UsaGhZXDwslETaOLMOvNcibaHCQkdO0E1E3P4dHpXPjCdbvnC5aBGt1GMLO/0Fw8OyeG/VK1vUBvCtgAVK60APWj6ZobB5CU;6:47zBdeEca18AquvWlxn8u7/+dZh6UbTEdJmFoYsbeYp+0m+9Yq0f3vTirJ+C8a7MidGz3iv8b2TOOqPfTQ/I1G5YoBV06Aj6iMgyqaF1wbEOZ9A4+ZQdXLTlLolJ9wxOdy+LhNmxedCcDfSiCWakUtzxWKERgk/SkKSGXn7qA58Aq+G7ikaYzD/igmBMF70dOUpjIXsYZCgEMKXjod8QwwE41cOgplZgnEbJKEskvv2xlekNMQgQQ5aX1P6QR3pdqUYT0DUMbddo4WWrjHtuc4pyOT7VB9grBn72gUpAtZfadYpZPb/Bh/rwxd7+fTlotCJ2Q53rLa/yoDFYZM8aGLwmeLB6+a9mxd5zc9BAVKH5+Bru6bZvs4Cj87z8bQiuJ0I0hVGvzH0vBdHiJFcTgvq+vVlmHxGUoBZoFp74pEK3OQye36PP49OEb7wI/Q6QTt9VybdoGjEhN7mKkZyvQQ==;5:8qwkto9JTigsbtkEfwHeqLiqeNcSVic9/urxzjqTJ0nZ5lKgGxbG4brtB107rRaDVqRqVaDfxjnNnVqKWhl8J335QWUT89yym555EuPxE34QEwZmtPMp/slp2OhDtbBrJhVSi9E+vX4HVObB/V4TWEqS3FFthG9HzxecsqDhN5U0wbAJInS23pd++nXvl/7onZTM58YZGZs/1dzdUWa6AA==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jZ179Dr9/gm9c23rFbomJjs0RmqAVYft7hjRLIWG8MIUdAdQc7Uu6qoIv8AuNxL3fec5I1Gi7WM4FoAL/jEt4RRdkoXftmLXxNHVxdcrme2APjHLAYKKI/nM2wo5gjyd9zQ0q+Gp+fUcwyhK/q4cKCsj8AWq6tbR8jA9BTUcap9Zag5h9w3r9NileUWpNjpHlNYM4N3KIlqBtl2gYms0nf0j8sb+/QUr6BVkD7Mms3xLhho3qVJ5dHUQHzCjIj72PnRwbrJhWzQ4eOBCbizW6d0rkQKG+n8NIg6Qi41FOpFOYyHEfBkeY7bNVGsp6ePwUz4PqyIVIjRqUbwKHe0Z1tDXhIIloiHLTHoRVaQsxYESihppbGun/E5Pf3T+0y8Iw/4YTd4DwKITlf/A8pL5HqDU9Y+DvyBUnN9TotPL+CsFO4zJju4BVgZFDntxU8FWyWIYZIoYushPYPMQ/S3hNJMAe1tN/a4XL7Ti/UoomDVQU2ppKR46YSwpQCVO9KT4WKm3LJkxtxQEjhlWPK2tlsflzb/78gkUaTJwandgkz4=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2145;7:qNg+GXb92OKdRx1KHQyr6QPALthSGQOKwu3ZIs/4GlUeovFdwaOzn/b+zYzcxgkEUhooZWe+JgX0+QxRCEwr/0htycj2mcHDTr/mNIVsBb2Wf6aEeKH+pFoy/GxWbljwh8o5H2ZT66lPqk3FSi6+8A==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:31:45.8145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca4095c-e107-4072-ea57-08d68ffb5be8
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2145
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

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

