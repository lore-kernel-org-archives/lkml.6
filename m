Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71179C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEC42086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="ljQt4VK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfBHQMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:12:34 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:14214
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfBHQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8tAcT/apF6DPLLmFySVdcDsEcqNwhs0WLE6X7Q3J0c=;
 b=ljQt4VK/PvDX+850Bttuv36RHt7GjYXyqSbwrcBLhzL9a4FUzahsffK4kUKrIo4/91nCpwC30muiBPlJs6rRFj+nPTyzUhbruAOrenPIuSpmLcEmInX/hW+cS76HZswRGlsMz+E4g1OpdrhcT0wIcVtLhbHoY0TDt3BM0m4d4v0=
Received: from AM5PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:206:2::40)
 by AM5PR0601MB2257.eurprd06.prod.outlook.com (2603:10a6:203:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Fri, 8 Feb
 2019 16:12:30 +0000
Received: from AM5EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::201) by AM5PR06CA0027.outlook.office365.com
 (2603:10a6:206:2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Fri, 8 Feb 2019 16:12:30 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT025.mail.protection.outlook.com (10.152.8.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 16:12:30 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:21 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 8 Feb
 2019 17:12:21 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 2/5] i2c:ocores: do not handle IRQ if IF is not set
Date:   Fri, 8 Feb 2019 17:11:58 +0100
Message-ID: <20190208161201.7860-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0601MB2257;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88482373-b670-4095-900a-08d68de03a0c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:AM5PR0601MB2257;
X-MS-TrafficTypeDiagnostic: AM5PR0601MB2257:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2257;20:UyvTUR8qwu03AVcONLjx59N4NU+JQLUf0ZH/E+1sPyofKEB4qMi+ul4+6JroLMzTgwNQcyH5l19tBQQdFrErWx6gy02JxGppWYCVq8S7U8SZPfbu/YvUJyKhHsHI1mAvjLlSby2Dv6HQlceYwBW968YvLkTacOS/8vS0F64XIiN7zypBdS+X3pgaj0w6rRwtCLZi0Qf8Qb7vUZ7LcGOuEQy1fwbI/tg4dsEuGNBc/RDs5q08229OavBc0Py5sHYF5WWxTLW2QR8Z2Rw35+JcppsgzcazwwRrAtAfPRDyvxpZaW8s4kWJry9f88UBYyIUkynO7f2SKHqmB0rK5Ou57NJT2QlS78zGgpBvE4vsx8exIq8jcLsk1tdzvYIW20GlWpQfQ8AYn7oXXdPZ5fRPFRR9tyjkCKp7TGUjcV6PzQSrFHNME0EsosPwcC7wrfrk1k5Ou74idJmsg8zmdSnF6BqVY1ECsl7akXaWu78DcFz5tb5kFPzjr6JtU7y5lmXf;4:I7qDKNQ3WNkDy1vUyBL5CpBBCUgZhxUb3giIh1DBz1EuA1yprHquv1IAp8PzSHtdpNcMhBh1DjaVko+rUND3xg9WFIehVql3prDxyMSZXnLj4GqHELK/xix6vMUpy59sjP8jowlJ9wnMJ6m+l5TRS5s5jADlYd4neJsO5dIVCNmZL1NnMkf9821soqINAQP+zj711C3bxBUo9KRtgsCeKevh4on2iuVgtbZ//pgTf5jILwdqYysqOYR3kiIUjJ6NjRR+D8jsGwAaG2S5eOwyeNbjMPk/o5TanPPCb/DTD2ahPX8LYAFc15dlXRLTciP1
X-Microsoft-Antispam-PRVS: <AM5PR0601MB2257A71560815BAF16930590EF690@AM5PR0601MB2257.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2257;23:vfnynuTLNr+9mE9wJBEnsqWmHpzzcy8O8fwpHggjir7KBpCuMdcYnzmjKSYqGBo22v4BWO+l8RTA3nrnlsDWgdjRCAcxjmg+FYydLSfDCaDSfheEjAFMqGsHNt0G5Vd07t9ryjwiarrhzc7R4xXRUHZXzuEE8ht/vswxcpKVzf5Otij0hdjwh+cHcrpEM6ro;6:9IN4h/qVSkpxLdOqHaBlAKvzxfPftjidmO84GTYtUy1Ucp49kjRnKX/akam7rtdr9HdKjRBbe478E+iZdTYzLIX8W3vWPraFWfNO5iMYuuMiKutW9/SOqKzgSSHivNHeccyDfDg9AQUCNfgH7LYZzwjYU+1eW4IKKvD9XLzsiqikJFsKjY+bn4P1VzvHvMeUwVIaNnXXR6bFBkKT8Wv0zCGIWGA6N43u5RTXKVNRSXmueGXhsYPen5sNpivP5DphItEkffwz6hqtbqaTrYMnwoyOrwGyJ7MjB/qfTcVJA6j37M21rKu4UQvtcwZfqxWauyMJQusq1V0TRgNltlxPVR1sajoW1v21GtcfBTQBxpEbO2qMdFGB8mVqFL2vVcKkpkw2YUmgQinzJNnwnYIYxwVS1F3gtVbZxALomvFzVVq+lj/wXNqqLDwd2+l6bxMlBWtYqYKgqufu7xodNAX9Vw==;5:sS1QnNbX0r7G224j2VLEeJy922JKbCi3IxwE3xq05NTi+9gIeBBb9uM8Sq+Z8rV+vtmL3TKOvV23KJN4BlU4X+AOX6pZGO3D68HhDByFxtGy0fpnrFxh5lJL3C7cvKb4Iw8Km2ybgYzdGxx2Gt4h57LPwfj3LFZE9ath2N38SS4lte+ft6nL2eIGNyjBRPyBdF8xLAwZ/SL1E4xApRV1VA==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZIzjv3yCTpSGI4ETPkVGsaUHtOa7kWFQUGJZeT27HDd8kyuB1w8KH0M7T+e24PGa7rFCFIJTdNPEPjbHZKIzyvSyr3y1gTP62AkilFzT7H5cBvo/Lngd6oe9L1SHjV3MDH+ZXFlQM/S25C2HGKRTa+VEYOjlGyPYoUuYfNA8VkJlVbWIx0WTWQPgPq5AqekLZRt7WMLtY4/bbRKKPcMlrYScerCja+APazQRWBCF/6+EMJvYhl4ExVaPlhi8gSB08SYK6fzRURLu+1lUL5BICOK3FTnhaabPtPvvnEDjs0XiooPI8QKwPGKgwnq3G3Abz4G40hnoQziYAG/Vw12UuNKlU0AiXGcfHxqX5vj6Gh3csMx2biuwwIto4NzLqFgDW8KcMzjMExt6CcvcUQz1phx8XYgGzg9j8FAMHMadmAhC8MzEbfSIpVPd3qLUGLmMIaiNY5J2u1LyhF4SOItQV+UoTmUpYyyeutKHZRcR6LBZ4D9Ag0mTNqDdYBrHvDpgb6dLsH9LxFM0ePMXS1zu6GEQ3AuJTzXAUicNw3Mp/yw=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0601MB2257;7:puzCcaTA2NRhd0lY5qdBAGQm9lcKOoVLWZRaWtVenQEjll9ZQeOsyQlkd/PrDr2M+mkhK7SweU2w3ru+/v9Ob04qCXQK96HLAwv5IqS3HsV4emJbp38IP2FXljZJO0frmYA4lMMsPlObgRyVwwr6ng==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 16:12:30.3194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88482373-b670-4095-900a-08d68de03a0c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0601MB2257
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

