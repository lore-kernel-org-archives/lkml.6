Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA19C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0A121486
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="mesjOoXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0A121486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeFYQNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:13:36 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:26496
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754017AbeFYQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGBDCiIjInfGhbS5po3Rutny60IIm02U58n0e61kZgM=;
 b=mesjOoXk/Ekz0RkCuk5sSGkIsytCPMN9hzHNA5N9MNATh9IHbTaNkqYxwXbE8AYx5UvxT/BXmIW04ig3Luw9Ws1GvOSckKrw/Tk8Gtp1XgJ33k729zIvb7a1waTizkEYsroDw8oKWcOIU5b4jRfrgS575wM+07rk52pndFD8kwQ=
Received: from AM6PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:20b:14::29)
 by AM3PR06MB1140.eurprd06.prod.outlook.com (2a01:111:e400:5872::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.22; Mon, 25 Jun
 2018 16:13:28 +0000
Received: from VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::205) by AM6PR06CA0016.outlook.office365.com
 (2603:10a6:20b:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.21 via Frontend
 Transport; Mon, 25 Jun 2018 16:13:28 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT013.mail.protection.outlook.com (10.152.12.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.906.15 via Frontend Transport; Mon, 25 Jun 2018 16:13:27 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 25 Jun
 2018 18:13:22 +0200
Received: from pcbe13614.cern.ch (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Mon, 25 Jun 2018 18:13:22 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Peter Korsgaard" <jacmet@sunsite.dk>
CC:     <federico.vaga@cern.ch>
Subject: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
Date:   Mon, 25 Jun 2018 18:13:02 +0200
Message-ID: <20180625161303.7991-3-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(6666003)(786003)(76176011)(575784001)(478600001)(86362001)(1076002)(16526019)(106002)(51416003)(186003)(26005)(7696005)(6116002)(336012)(107886003)(53416004)(4326008)(14444005)(106466001)(2906002)(5660300001)(426003)(110136005)(8936002)(2616005)(446003)(356003)(11346002)(48376002)(47776003)(74482002)(16586007)(36756003)(246002)(44832011)(7736002)(7636002)(8676002)(305945005)(50226002)(316002)(476003)(486006)(126002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR06MB1140;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22cf6d13-3529-414c-f4a0-08d5dab69639
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM3PR06MB1140;
X-MS-TrafficTypeDiagnostic: AM3PR06MB1140:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1140;20:YyOO4xFWz29+XT/lNp0iPXzJaEub6leriTL4c4M3WIOXQ/AmkdPIncYQhQShnyH7QiTU2PVphuP7PBPqXAb8mKxk1/WO6GrPSoYc6ZfEicSss9H5ZlWp4DARVOMWem72UYfpgSbg5ddfXL5kGzWYj4tNfnMCPRQRxJY86DNwL4bwgTz0R8/2mIzqfaYOk7xy4fMd7kP4QAhzGgOAncNp93RfZ+jznRVqrTvfrqN+TBkrZ02ohYyaDc0CbCiJLK0lSgqeXpeTCkCvgMSS4KOD9mrAp3b8C1XmZZH6famb9FzL7GSv7f/gBCshryavfI63C6nojWPOJm36c287O6RLKJyEJmnZ6HWcye7QsrPQbj41cMwgaqmwn5ZPNCD86iw0piWiDv7FEvuNwRbHT2mkUOuqp4RHnxjtizF3MDJP+YiNQrcz0zUq333ub8JeDnSfq4j3s/2Nerrw6ak+ABpnRQvzDWUtrjGm+ZmsoH+rvUno4v5+1DZlxgpvPboBkByC;4:Lj4taYtz+J2LEEYMm4vAvaLwhLuRvLmk7C2cUB7V+RWKt2sDvyj3j6h9VVhgDubFW0SFawiyWbTeoOexzxbYmKUESh7VJb1y0H4s4W7/MgWtScWRs2Rb8VQZ2a2PuB6EmgBntAwI/VpBeX7JSvsN7PuoFy+MZ+zYIoMGsDtODg6nHQQF3L+2RSIzMATMtGG02BXAhQPhTNZm+f2um84ze4odu2qXXrZd2qbhBSZVaickPej1fYB2EoHZYTQpHI1LZf07b+7b/COfm76WAd77yA==
X-Microsoft-Antispam-PRVS: <AM3PR06MB11403E2F1352246362BE2EC1EF4A0@AM3PR06MB1140.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR06MB1140;BCL:0;PCL:0;RULEID:;SRVR:AM3PR06MB1140;
X-Forefront-PRVS: 0714841678
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR06MB1140;23:pKy2+CjX+XqLbCZjm82oN4NgIK6g8KFqFaUocAt6n?=
 =?us-ascii?Q?onXBDG9cZ/sPCpoLrLuBDW+sM12L5QpBXNq03xZwplzAlqyQk1o0qE2d3lKg?=
 =?us-ascii?Q?6/zYgk734CBaPXUEXA2yAAje3W0xO1Oaiwf/nyX2lo7SiQgeV7E9XhjL7NFZ?=
 =?us-ascii?Q?l/pJ9+AJJuVbqZzD2ZrW2VHwJOckKhnLd1hMmGs8OaKJirGkvj2JwQihSptw?=
 =?us-ascii?Q?E9NuAeShC3d1TOUo4YFiI5kYbVgnNFwt/wW5AkPzK4kjyPTPF9kr9oF9ooLk?=
 =?us-ascii?Q?LPVxn03ofoDaSw4t1ZglATzEVlkSYCoNY8tqh8FUPxBLd9gVWgiImf1gnBUD?=
 =?us-ascii?Q?b9hRonXRk+OnjBeyLGzOFwSRUJwWjMHLywOUT4WMf59RIB/HWTtKQdWldGLl?=
 =?us-ascii?Q?taERYk8udI5UjOCDQA4YUBgUGgZGQXw2TUvQj1uGUSPAbJgNcj+7VS/4hHtD?=
 =?us-ascii?Q?AHP9cbg/SOsXJYZGjGRJgkVGKt7kdx0NOurgaCbtl7voZm0y1ubenyMFKXxi?=
 =?us-ascii?Q?pgxgxjY+s66GL/LKm36BhktBaV0rkSSZl9SGd+BV9rVWfmeadmKJQmhQOJE+?=
 =?us-ascii?Q?fQq1eZbgZ6BV1tDLFJBHhPfQXc1b2QmUs+09CChs4NkO99bTH550pclhIRBc?=
 =?us-ascii?Q?ZGsMDs8spNKf1uoyGlFRy+ZgqSdiGCn0FTPCsoE4hbdUp4LXEBmL/+Xssm/d?=
 =?us-ascii?Q?N/Jb9Hxz87utWKas/8NoDghbjmHkMN4u9vnnT6T89+cdeJfjRUh/NlfKYgRf?=
 =?us-ascii?Q?xoW9ptf4Nk6C8fEn5BA+whXIO2mqRm/NQWIsC6H2MRKZOmacHekjrbgtgxd3?=
 =?us-ascii?Q?9frl6Zmv9XDapzwDTDWcR/KvwhHTYt63EL16uDQhbAnjwLAWKCtIEbFnWD8F?=
 =?us-ascii?Q?nSOWCwWJZXT5EzsG9Fj+b2Sk4REKG8a3Dhix37l/pHneUdv5gQI2BphIBxZ/?=
 =?us-ascii?Q?zeiWuY5bjLsf6vBXr9YSr5S66jgj8GXWwdnvrnu5q5c89Y4LoiohgMGtAifA?=
 =?us-ascii?Q?xEUjRga0cCNzlQzRfzYcK6dKm4e+r36vD6eC2DnDlZT6G85JxF1lzfFM07Cn?=
 =?us-ascii?Q?RYgzDJ9gZfOB5xVetuMA5/4qaOBt0UdCAPztIoVcsAbZ8ZRjkdCD8/CayK6C?=
 =?us-ascii?Q?MZnppdFHL2ThhyWztGMKD+d7ArfXTN62A6ftuiX2iLVqePc6GOARCnN6dS6c?=
 =?us-ascii?Q?iWPZaKQuo1qtqgL1UrFG2YL7rLzDjkrQcK6?=
X-Microsoft-Antispam-Message-Info: eggJJxcReOfD9YSzw1xL83xmABu3o0fVMhcwffXNqyogJFHg0WymbYigMnTIbZ6fjwC4Z5DYzQZsY48gTMALmBsRnd9Tine9BPkkpA+7uVkiMf00jZ8Kg7TFfVdRgWqPLfqolaJLhoxNHU16mmD1KY0LnsjeU2TKVS0tPCZ19uZhM88rlQRVnwl6PEAlMNe5bEwGDH98M1Po6M21Hl/7YoH1ZSCo+uJUarMbKlrKkcq7IprwdTTGIJh1SYQg/Kp6yJfD5OQgbBfPGzpxmgO7t+zoRhRamFv6gFUbam2SM/lCKkHQz5f/yY6I3H3CpACm/5ebYUoOrKaCVOawbppx6UQov7IK6AQlKFiz/HDQKMI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1140;6:nVZs03HnZUdmsZcWySIfM0LIgYwWwL30muhomicxcQ6MUSUpv4x5iayJx1AIESqKsW4dmfvTaCaAfGXPlNdUUeEPrXYAZlxytdIRJk/C7HcYwhEClyeLEPOUDI3nNjF2YUyN+FaDhBmgVFahf+YC6K3uL5Mpel5hsUSlhRLeYlf6Uy3dRCSgczARz4sLix6pskT5n71lRN2SNwEhXaMHfUI7iL+Syfvo6HoYAztikELylLhrTcIXI+P1x96wyKP0bUx+zDuNppbLBbUULk7xO/XrX44R9nX1FxX0kD7E0nD8TZh1TfRWQ1tsUcky2wKss023K8hM+z6KjSjmYljZ0LoKwiXRA9r81/QFVhFVNZnxiX3YF9fPBo/DcfpRhqrMmLM42Gxrg2sPGyHrz+g0PoyOn/updak/o5sHcDwUEmPuxWc+JxpoTj/Yc1TcjZEfW8keCmnRj62FiQ9/B1hvyg==;5:p+W5aQf426Cg8epGZojJcA0iNnc4gi6+2mPnu0JDXRcywrGdNNx+GUS1d0vaABEaLTHW9SoJT4Lqseo6gfB1dOVkecmZUevkTrrJy/ZCE6DTWZsXFKpIWGiZA8gTShFiSngQh3h76qR2TrorlGTkgigOR1kmIW5c9VTG9gh12Wc=;24:HpHOQJY9rGaQnuwLUZB0y+UmqFQLOQGse71H0n4v1k+t+B6PvHIgkvTa0EufKpMC27KkqltArWxgjE2L6PxLsxKoXaZFwaUXFgEZUN0avIM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR06MB1140;7:mwoSv6lNdgd0mDzltmnKyP22/MdVCBnyJWwXmSizwTDzOzPXSAyDT7puyAayfWyOwDUQPcBOpZzeNB7C9L8WWzjpZhfEwp1lGbyV9p882LyCr5f6AqSmIVk6j1G1o7YH/150jqmq6gmCCQrTtG5ZjfCvsWkeIodKK/yFA3DU+39zF57ITycwTempSKNcEu0FHAIp+bYGE8E7nBuv3r1vaKhyJvKnuCnE8ML0nzgFOrt76gV7QbgDX5TxkR9zCShr
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 16:13:27.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf6d13-3529-414c-f4a0-08d5dab69639
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR06MB1140
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
---
 drivers/i2c/busses/i2c-ocores.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 98c0ef74882b..274d6eb22a2c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -139,10 +139,9 @@ static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 	return i2c->getreg(i2c, reg);
 }
 
-static void ocores_process(struct ocores_i2c *i2c)
+static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 {
 	struct i2c_msg *msg = i2c->msg;
-	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 
 	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
 		/* stop has been sent */
@@ -209,9 +208,13 @@ static void ocores_process(struct ocores_i2c *i2c)
 static irqreturn_t ocores_isr(int irq, void *dev_id)
 {
 	struct ocores_i2c *i2c = dev_id;
+	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 	unsigned long flags;
 	int ret;
 
+	if (!(stat & OCI2C_STAT_IF))
+		return IRQ_NONE;
+
 	/*
 	 * We need to protect i2c against a timeout event (see ocores_xfer())
 	 * If we cannot take this lock, it means that we are already in
@@ -222,7 +225,7 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	if (!ret)
 		return IRQ_HANDLED;
 
-	ocores_process(i2c);
+	ocores_process(i2c, stat);
 
 	spin_unlock_irqrestore(&i2c->xfer_lock, flags);
 
-- 
2.15.0

