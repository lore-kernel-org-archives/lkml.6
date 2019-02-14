Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8139DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A920222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="JiGWfLZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437688AbfBNIvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:51:51 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:12560
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbfBNIvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDAZgYkVYhsafmVcLMETwoZc3dH+0zTh+vH0xDIqy4o=;
 b=JiGWfLZ/zPBLhxAs7+x7Wy+ORiGbCowMlmMNKPjXxYNWSIbftRyrMEdh2+iFY3GLc/uLCz1lz1J9rWWrQWmic+MXgez4wurGBk7+0A5Tnq14a9+rBNZihaCQrpArch8wzmedLQe7lPaf3UP0YlMXgTiPaEcNqjO3l31FfXXRptU=
Received: from AM5PR0602CA0004.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::14) by AM4PR0601MB2145.eurprd06.prod.outlook.com
 (2603:10a6:200:47::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Thu, 14 Feb
 2019 08:51:46 +0000
Received: from AM5EUR02FT058.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::203) by AM5PR0602CA0004.outlook.office365.com
 (2603:10a6:203:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 08:51:46 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT058.mail.protection.outlook.com (10.152.9.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 08:51:46 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:44 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:51:45 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v7 2/5] i2c: ocores: do not handle IRQ if IF is not set
Date:   Thu, 14 Feb 2019 09:51:31 +0100
Message-ID: <20190214085134.12900-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214085134.12900-1-federico.vaga@cern.ch>
References: <20190214085134.12900-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2145;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe71177-fe65-45fa-2a1d-08d69259a6c7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2145;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2145:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2145;20:rBgUf2PDPf8Urpz4Yyg92Nsg/GSwrwbUuAljPm8xbJGnVePj3ing3RvgREbBv8WU1z1AYnSKAheykNivcjTnbGOyLflHQMBcLHqe72dP6/TbeuZi/9kKYR6urlBgHV8SQLVeb6g+QP/XYVX28rYf6qDZ/ZLNzWDjDfVjRMV3tvdiIfheAtGUmmedYq4vp05sVm4hHrOorQHsbjm9Qaa3LjNeZ9RB+JBhM1asKl9Hm8FjdjCf3WqAfp3VcUK3Xl1nOxM+AEzIFFpgLfcJu0lCAqo1cjizpPlbo9nIqyjkPRV+c3RTGD9J4ZzYwu+um0VUSwynLrutsl3Gey4awl0mZTLetUg8S8T18mZ8ZxnSJPOXNgRYCu0+Nv+XrFR4+ZbeAQEpBlSfF9vxgnm3OiAxALQz5AsbqcF3S1pmDaKydMh2ZxCZm4qiTQnJre0FjXuLPMNpbGD/qRYScMNr8KQ798fl4TRvxsg/EHea4Zvj47BWjukIO1HqnnRQSSkRgVpr;23:TE+RkfHSgsodoVf1hzSjR3Ym6zN+d+TARyhJOF8KazY67bLR8tHBY4t1WAp5a0tQQFOjBXP0MPsxXSolP4ZjNWzEphcmtC2lczZShuhIym4HzZuV70dSTJBihbGdzNMF6nrA8CE9KdCUsyidGCt4eUGjTCgN5s+OSCW7UPwzmv4PnruUdTFTtxNoBLH5vhAh
X-Microsoft-Antispam-PRVS: <AM4PR0601MB214535D42D14E2F6FC6D4DEBEF670@AM4PR0601MB2145.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gfzLO2kgm/H4aD71D85SnR5kzsolG5/yXPS0EtoSx/5hZaCa8rhDczBEkhT0LuPMOUtoQZ1UvkePadrtktbS8SRgpiI4WUnyO55h0f9HzorlEKahDhYDAI8dZ8+Dz2yhFafSRbSxUYd6q3ZAcBSMfZlmo00MDp3QF0NiYINJb195FekFCT0hr0JV+KFlWyn8GYh6cJV761yjtQQQjGRrNS10klaHsMZwqZG+rapI2DGObV+Nf9/eyx4Yx6DNfHZaZY4XRUy4v1ft3b3IK89+iPqRRyHvOe5iEEif1F6XRppU9K0T5po090DGkihW/fNN9WNP4q/SfF8eOC0PzvfqRtuAqhhjWGogvC7lpZOzRfHd+IMX2TmJ0crXjLHxK9P6xcpD6PmWs1+zm1XFct+U97KOF/zyDUyatOhnbCGxHnGGk3t4s4fdMgPLOn6ZiAABtgVQMK0tvJGPUcbb8WjxAVz9SUy3zMwqqVgTRF0/py7nh/Z53DEVzsTLTz5Xi52qcADm+nxDyJqwBYoojE1zr2DeuW1PHSQS9Be0Wrluhag=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 08:51:46.4296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe71177-fe65-45fa-2a1d-08d69259a6c7
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

