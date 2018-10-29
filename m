Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43026C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A8C2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="k3sMYmd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A8C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJ2Xkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:40:37 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:49376
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbeJ2Xkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8tAcT/apF6DPLLmFySVdcDsEcqNwhs0WLE6X7Q3J0c=;
 b=k3sMYmd9RR+Pg+ARxzGL0rCv6LHxoXT+TGOYIvZmfIuqHcfzLcUN5UBKxOk/TTvqkf2k9qsO5qTHe5N6dtPpA19XSx2L47kFM2UM5mTTfXzEj8QpRygMBtaEoTZYtvuXgO6Qhzf/okMg3b2yhtuPlYQuaUNnJX4Ag4Xc3mlEsyA=
Received: from VI1PR06CA0124.eurprd06.prod.outlook.com (2603:10a6:803:a0::17)
 by VI1PR0602MB3535.eurprd06.prod.outlook.com (2603:10a6:803:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.27; Mon, 29 Oct
 2018 14:51:36 +0000
Received: from VE1EUR02FT027.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::207) by VI1PR06CA0124.outlook.office365.com
 (2603:10a6:803:a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.18 via Frontend
 Transport; Mon, 29 Oct 2018 14:51:36 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT027.mail.protection.outlook.com (10.152.12.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 14:51:36 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:15 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 15:51:15 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <federico.vaga@cern.ch>
Subject: [PATCH V2 2/5] i2c:ocores: do not handle IRQ if IF is not set
Date:   Mon, 29 Oct 2018 15:50:48 +0100
Message-ID: <20181029145051.31984-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181029145051.31984-1-federico.vaga@cern.ch>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3535;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f478266e-524f-45d9-555e-08d63dae06b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(5565046)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3535;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3535:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3535;20:4hHy/PfWS1EvXVKPof2dAGodg44H1fdURyoqz/f9T6rzPnaPz4rAXuMRhjGM39w9AQUznOGwuq0YQwXplE1ylkDb8GXBCYD3N5+hbY6etVyw7wvY4QQNDckhqJkD4xujRT3ZhHIKia5az78b8A5uiaa1z4oInuPt9XBEDHSf0ZubwHebsxz99J9yNqfm1fer0kQLK/lgAH1y9ZdBnfvDnEyQgt4TOgra9W4+d+Ginf4NakMdUFKuaeeFHajAVTLwiHErlZod3vqFQZrIQMLCBrqhpJY3UefoUeOtXzfRgTHec8hn7wN1eTlauqBZvTrb2+iowgx8rL/XWHXKGNU9SGils+qQVD1jD3O/PoqdVmBzbjZI/CavbGj8pVdEJbtG0dUxLXt1T4H5DvIgicam0T1m7UJLVsHlCAbUQW7zrozx1pqpP2CJrG2aIFGJVGTkxU6ClIgXYIWnKorbXNnYPgY8wX81P87fbLpb/zF1W8plUC+Vl6AacXlk3D8fvvxm;4:Z0CJzwv7ma4r0WUsOEX1dRrMANvvjWNiOSLMGDVEgHhzMFczZ3nCotkz73Xxl5a8qOFPM/KaZR3a9IQhoIEiPCYtN3x4LV/+IF2PdIo9dITdQ9S/KIxyNw9Meyu+njY3yQuXYii+0xrHJsEe1pg/TbRFpqLHFcEHLalViXmn63c/vswPG4KClWN4Gxyd8iGw0F/knultSOZ66pQxzjrMPDe0FC2atViWTOgmPHcFfQfyTNDWhdbHss7eeC20Ndx9FfdrDqnGj82OXPyDKnV2cQ==
X-Microsoft-Antispam-PRVS: <VI1PR0602MB3535C8F534FA669405FD3031EFF30@VI1PR0602MB3535.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(7700054)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095)(7701012);SRVR:VI1PR0602MB3535;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0602MB3535;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3535;23:xOy7y2xcBEHtaSrLgLBXrrEvbdIIQTxz1LCjbvagSPqMwV1epknDVRtVstcsziqCszPKklujGOEK8mAVi60YROevX1ezz0lE7ueROVZ7cp30hSuqtvdJQavPJrbo4OdGu1O4Q7sBT/jNcvilprhbmD+6lR4f50Xj3ruK0vF5z0HNbFJTfhEbQkwhzrBwB0W7;6:+9vxirXtZAQfArqgFKxMPAHQ7HhTGiDbhVGZXn0pJotkBRX5js42j0DhbalXpEBs7qLutOgIOXIBawlTuRbbJu8xSgxh+DPJepV10SUb8RDdp9oNN6nFj4Em4Pq8wx2TNUf7XCHrWpyeJqnrN7RO3cejpR5B0GzcXw2hUDTp41u2Wu3wcyJnA9piYbo46ywFXFDaBKVjEdVDuW2u1yWlIsueJfHYEG1hIFh22ngPUEUzsTpKspAY3B/vwY8IF7QN38GMgxDDYDvI1/coHIMBB2RFxm4Pv/tQEpiZEpH6dvpVCqkPlnCDAd8suf0KoSDMMRy1d/kUBZynKHOF9YZETn+HAH7s9MNNIt+G9hr9WGm1YLSY/plvhVWy0Cc+3mhzpC6pcqn+1EtmgQdkIKWVEWISp/ffj+89xvHJL3uU/YhCoO1kUoVRheAVcjxWnebPstWQHo/oHhyxrWBrMWLqgZVdEolXiM4JiLEMriQhzLCNj6DYRUcYVHlxi5q/Yce1;5:S8zKuZnyBw5ouon0T8e5MtuRYEJPp1/tLKAJohA3GDKZ1R3TPt07uY5lFiEQLKHaVl1Ql8aENUZ0lEqYLmsZQEyI05Cg/xgVHhtNCdWA47T4zipkqSnUcLM6vOkI4jczfhprI1QLdLObIDwGMJOM4fCFdWH9SDHNTt34ejCowj4=
X-Microsoft-Antispam-Message-Info: EZFhhmi8btOtTkvoBtzPwRy/sB++bTnJAj73LXsuHn2kLBM7sC6TAVUPjudfXWwo99/6fnhdA7dw60GDE0rVpM1Gl66Fg+C/4TsDmWZsRNZjEyOldKFSSBl0nGGWc3VAkLy5pgNMfVJU+SDAMtnpksz1jbU4cvWBVIwC65yGeIFaY3yzhAGlncC+AmtEwSA+9n7RH97/l1KHloRtEsfkJk/bvYs6nKicEDugzLOSQEa3x1fPxU9lINVpARHbPlba00TfPo294C7NztDYeiaZA45vxFG5HOW26JMV0ZC7lQ2gnDlaxbhAIPEAIP6zEMQ9mAtnQXcqFFATIe/3Wk8izTxAYzvoECSYR+C7KfscKOqLMTu3bxYqikdNiuDpzVOUOm2a3ZsZirQFKAu9JiUFvsobL16W7dyADlfU/xd3TJopXIf5OGuXsfeua6S8EF0/F+WGwx6Cf0G+I/Vud0ET66M5UlKbZ9y1XyzlTqqtjic=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3535;7:lKWGbdUfn+MjVfwzpK6YODLYP0Yerbl8DHrye8G14KsvQei1LhVtDOfKqjkDEB0JI6kr8GlQ+kUnUmohZ/5lpckiCyLV/0vDU7Q4+YZc28tQDyTEgcgHbOUiQKCv2n0p3lYY/PWxdaKSoE9yG74VHg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 14:51:36.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f478266e-524f-45d9-555e-08d63dae06b7
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3535
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

