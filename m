Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F1ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D2E20989
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="N9YXyZ4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D2E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbeIURn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:59 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:43153 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389981AbeIURn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:57 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:22 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id E8FE97412C;
        Fri, 21 Sep 2018 20:55:22 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="293141292"
Received: from mail-ty1jpn01lp0179.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.179])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:22 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLD1HOx6HwspfHqwjm6K0fXvVhZ5DGJuUhmeZ+yhGmY=;
 b=N9YXyZ4+LDZsgzuO3E4ktXtiCpulywI7/9YMO1M4AicN16J8lFsar3JlqBJX9D5m/oSmWUFJvIzHNcYrRfO8DeA+6wo6ff8CO2fLeglO1TcfNq2NBHLSgTRreRRqyv16rgRpN6AOOQL3QmP+/hZxjztcmmnpwKjVWJnEuXr4lEI=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:21 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 5/8] phy: renesas: rcar-gen3-usb2: unify OBINTEN handling
Date:   Fri, 21 Sep 2018 20:53:21 +0900
Message-Id: <1537530804-19399-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8896231-da84-47f6-82d2-08d61fb91bd0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:PcKxTgH5RhhOCIFQ87vpF7QfkGlf5fjXEmX3kJCo1q9MbP+CLLPyy69E5gCfLi+9P3XzHo1VhPJtwHnejNAUTbaFEijSi6uMUzmSZtdxf5lcSMq0MRbEF5xdEyh/3QRkoemumdTbJM4K9HEbaYxlzbbcvoHHJ84O4x3LvD8ekn6RbwU9CcKuMR5eVli7gTgMZKRy84sowdoZNf6MnSfwpKJRJJVJVWMhqYVgK6yPY2HDWMekyF0+rktscfgI797Q;25:ZY2eVyQ6MSuvqAcRKAeMOMdeWBp4GZ37Gp/DEjrvEJnFidP9Blvrlcp8NsbWrxZQ98kJlLZ/da8ymWc7EMe1q8dNyx374WW4WR2YWOc9m5ltKRtcHLfhNFsXkrVCgcCa8GuUeo5ZKI77FP6wI2YI5VyaNjWtxaElG+T/8sT2j4CxdBDw990pFSMXe9JAl103flt0ya/Ie/cN/t3nvDLqmVnCIuXfJ6bdBBxwX+Du27x5MT8L7qidzkKqCINcdaR8c8DDiHtTpoqaIjzussfZ/dq8d9lZ4h/aRsfamxC5KirEALxOUSStBxCYuyM3MiqvvnclWMt9ma3ByAciaChsRg==;31:Cv/mIAnsZ36IlNhwmdYuVUldM/4J5TO/9rQIFPYHihIThtNBJUume5G9o5vmPS2CtXFKG8ftBN+Itmq9VEr3kmbNyVJAMQcXuQmnnDZU8w8Y0hTeRNW6xMdwGzM6ZQQ59VncpqCmzeaQZgJLc27tocP81Nto6lJLs8OxEijRGgv9xkJSyVySgLOh7UM6+5h0NzEITFlnCFlBKgn+AL2YxQSczA8kfbBAQ9InCGt1iZ8=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:2qlhNL74OiWR3r6bm2bl0EoGs4Pa4nUhObWU4iAwKLc1f601BEG+Q61NQxK0+lsK+wkbbM1QDznpmUgpLSAsVfmAmATvU9sIJUnPu05hP6np2fSjlnyPKP9vdarLIrEu+Fs5HCnU5o/o1sRAr6OjHveI3okCANk4JuNdGRJe8kSk3LBa0WrcODQJ24zxZy7icc9EmtySJpajFntKCEDEccidOsQhVdXiR0HL0rwYyt/e6aFCHYLPZR+fDKY+ae5i5ZhBQPLXRn459BIwdJztUkDqz1952JF3PeWDJVi4z2Au2LtnQXlKh3IU7naf/czZaa+ei1PCMZWdowsJIhTO3WNtyV1dwSYUKkUyR4JKAGI+I8f/gkw5jjv5IM5m5zy/y/iuTeTaSt3exgUsbzeyeg2DPFURLg0BcUd3IlXHtjEE6LbiB/Ot7A2tg+8bPGb1mQdY/dxfwuPUixPrIBoEfNVIWHIRafnCA9qzgeAKuCLkaNAb8hD2RP9n/V70NZv0;4:3CD0P5yK9YxURBqQj91zd/nXXx1N+j5pq2l9swGse4cDbbw2POMW02jDejfz5QQZ8UM35VRdf7fZab+e00ysecASQ6OHqUfXSrH2p+WdEU5/zI4iI4j8zHkq/iS8mxpZRjXk8Qaw+wHeKtvpHIBu7OYV/mAKNr0OAxqsifZORlqKyu4sNxlSFcahKxYbSmctWcX0G6tTEUHCpeKkoXKcIeSzvFS8szUjOmpIdLpgce4KYn+12MGMnuI1xMr9FmwgCwX8eCg9ieXCuDlCGoxivQ==
X-Microsoft-Antispam-PRVS: <OSBPR01MB22964CB91DB39F88D8E48D1BB8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:ufuDpBs7sYaaL2SYK5FkHHQr79680pXxIEhT2tRUj?=
 =?us-ascii?Q?8cI2b3JuHajIQSlu5A3HSLw7UoccRfJX6jXsQr6V79GCckR7EWaQMncJQR+d?=
 =?us-ascii?Q?x8AZIirn9sE0JUo06gpUtn8Wg9OH+bao3XZWUqbzPyGPNsrr6L9F3OfKtNza?=
 =?us-ascii?Q?rWXY9Jjx9c8Qno8XZ5YOoMTHtywoMW294eHi9NujYGFg2qopOH8fH6xIT8/D?=
 =?us-ascii?Q?2YyRj4SZXvXlRxsHDdC711cILlkRvtPaPUxwFtIfJ+Z3NoZOMjCVodKwSraN?=
 =?us-ascii?Q?4USfQx20esfGfWRBLRKr3LQ+OyQPjKxrB0aoTKq0HsYbhrGJHngpyYNIV/T/?=
 =?us-ascii?Q?NUIfJ6/5eHG+NYgVBTNCSnOWx04k/bTUCRswKdaSS5U7jSt57Cdmt+GDxKWG?=
 =?us-ascii?Q?pThli8HFIBTxycNS5WY7BMH7tFzpJXwv1vVveyAOh+5q31YGacdhg+3bU6Km?=
 =?us-ascii?Q?iHEzyrunmIyOaFRQjXpTPEqDg+VyXqxwZqPNaNomGjcp3qYMBy3/UUxuM2A0?=
 =?us-ascii?Q?S1CK2WvWhArhdEhdTwhztreATdIMUjfszMIirJIIu41DaAxRGhdV5IaxiCrT?=
 =?us-ascii?Q?Q32F0CuefE92X0RaVBkm/ikdJcv9ESnr7xoEnJCUXNBRF2s6xTB0+bu2zR+K?=
 =?us-ascii?Q?C0s5UrsfAvWH73kfPPvs1N/NQcc8lVXNgnujm4Z7HztO6bfdPACbhVwB+EyK?=
 =?us-ascii?Q?PkL60GeHPxSeicTrvNoW+T00iNIvht7HUczPcj1jWeZqOwwF83wDYM6Vu0rr?=
 =?us-ascii?Q?nOBJdjNEEUatsnN2VEEEzejYznwXLxe6/QcMfzFOgma3KRuENoMTSAI1oW0U?=
 =?us-ascii?Q?1lc3wHAlLrKB2dKYOna7bpxrdn2gGDS9bU5khZ/gKQP1HLqWEYb8cMNGt7Og?=
 =?us-ascii?Q?3+kzFwXFlrj6ryUNShpUkEw7fN8qGr2zVusA+q/6+foBLZzAbI/ec/KTFtqV?=
 =?us-ascii?Q?LA5hXT5qZw1uOHC7C+Mhk68YMHCebI+kT/QUjwTha6vyhV/MKAemsP/9m1Oc?=
 =?us-ascii?Q?ZIP/2AqfRB/riLeOs64yzb8DyM4dmG46V7vE6Rg3nf8i0o971r3TCU8E92Y5?=
 =?us-ascii?Q?xuh2fMBLvcqgvk2JxBEf1jfG0Dc9ako7N3Ezql/7UPRV96RPZwC96/IZOGoW?=
 =?us-ascii?Q?rg7+evFjz0JDwqMUk3Z/Nx1pS5zx/IJqrjkBZr/jUf3iIMimGpKhztuy3/JH?=
 =?us-ascii?Q?ORTOfNqVtQAF8m0UZYDtnOssuYil03hslcuanVzJl3cFWgAvQInR3Lnig=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: yKBz4zn2fxb70LNSkFpd1i715fPBj32rlLNT0kycG0OL3NnCCbrsC9zbfCnaIDe1xefJkNsS6mE2dyrgPFd1A6MThDGWfirOObbxgFLciYX9kD1y5LRQRUyfkfOOEKqCF2TcNszHQq5TMR43ntiX9OH804pTaMzFZ74p/Vj+bjd5jZU7AihJ1lxWBVJm/qps/Akqv+F6758UYk+HeZ24k6/8yu/kCGsmwqO4H0odKvzPBtN5mikHyuB/VoGXVsXQetE910kkJL2vXyM9/t4LiWr8BdPal6GYccsy4GA7qYio9Q6ajPwShewbJ7SZhl7GavOwmY+nJuCh98kA6Tn+HXlnMAUDa+clkebTiWpYQQM=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:AwIChmWMPEswGliRMkaf1kt2GA+MC4KJEoykn0DppfrqbNRN7TxvNrY0j3cPGKTAD5DKqEuPT2IvA3voOkQ/Vb8TZh6V6u91HQSJUdGFKSLtE/7iTZTbhh1Alc4n1VAXhITxRRMhwldx4GQUiyatJ5JrdkpgV9Iq8ECgXu8iD5ayR3GAjBZVANAHcucNcc2JVLYuidC72M+EPXwhwaXzMwDjnbsgt7nrNUbLcLci1lWJFCpGQ6iU3iIcak/rZMVBTK9UhUByi+YFplA97qM7Q8TWOkoIF8/PoXLGqg59Qrj+ZkvqaeLKFNuw5KkhV08HXR0en1l3HN4sYxiGT0Ka8PCfx3gkLUrnFOoBxwnpwceAQsmAtnprbGVwywnaxirLt6bD3CPqhuQq+/sXmQbZCqqfcsQmwWaT7WqCIXRrrXD2JYgZhIKcXLp2DT2XFyNTtQKluG6q4hKLt4JL0Iyuww==;5:eBxf2b6N0p3WYxJNQQBioBgmt1rBsnErSicD1DkOs7GMtJErOzdA9ssXzF1wl09S5FsbBiK2hmqEuMayoG2W7b/QOPH89i8o4r89Vh8CELS6jc04pWiuenkI74U1uZ8UKcxRdcNgXVxmAOcGc42imFpAgEtEBT0Ifk1TaSBXml4=;7:3yErfCIt5mbUJMG1W4hY8Q+KsI09TJS4OC4YQtDuLzrjKQgEDFGORvAwoPKvzE9KhzhyCZGfspdgG5i6ZNkimFKDGDtqnJZyTiyXYHeAudVi1/MsuWFJdlmz2Qjc8M2Akth9I1RzuUsb7GUQ7/sgA3okUwQS5nb2qlWyCiBlF1n5ZCofLq4fXHzerft09PVTXkyOritibHZP4jSXlhArKpCloQyDe8SVKkRn4Gs2IDIuyNw/kJmzBbKgUnICLiB0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:a6lSLR0na/RWerwjEZAhb93zIKO204ABsqPz5tKlT2vwxTJ5rEHeNdBoa4bPNQeqciGqBTod9g/E14AgiOWelEZKpkFMH5B+fnSDDvA84jiySWKaDncBqgtQZiJ7G28DCVRdlBfvnfOwTpkRn6k/e9iquzNJ2Uh5TXF2aSdpCEM=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:21.4203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8896231-da84-47f6-82d2-08d61fb91bd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch unifies the OBINTEN handling to clean-up the code.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 856056e..e7eaed9 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -142,6 +142,18 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
 	writel(val, usb2_base + USB2_ADPCTRL);
 }
 
+static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int enable)
+{
+	void __iomem *usb2_base = ch->base;
+	u32 val = readl(usb2_base + USB2_OBINTEN);
+
+	if (enable)
+		val |= USB2_OBINT_BITS;
+	else
+		val &= ~USB2_OBINT_BITS;
+	writel(val, usb2_base + USB2_OBINTEN);
+}
+
 static void rcar_gen3_init_for_host(struct rcar_gen3_chan *ch)
 {
 	rcar_gen3_set_linectrl(ch, 1, 1);
@@ -187,16 +199,12 @@ static void rcar_gen3_init_for_a_peri(struct rcar_gen3_chan *ch)
 
 static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 {
-	void __iomem *usb2_base = ch->base;
-	u32 val;
-
-	val = readl(usb2_base + USB2_OBINTEN);
-	writel(val & ~USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
+	rcar_gen3_control_otg_irq(ch, 0);
 
 	rcar_gen3_enable_vbus_ctrl(ch, 1);
 	rcar_gen3_init_for_host(ch);
 
-	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
+	rcar_gen3_control_otg_irq(ch, 1);
 }
 
 static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
@@ -286,8 +294,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	val = readl(usb2_base + USB2_VBCTRL);
 	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
 	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
-	val = readl(usb2_base + USB2_OBINTEN);
-	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
+	rcar_gen3_control_otg_irq(ch, 1);
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	val = readl(usb2_base + USB2_LINECTRL1);
-- 
1.9.1

