Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A08C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3160206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VozvV7KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeLNPaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:30:23 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:22720
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbeLNPaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnvmXRDZfurbnBR2CTHq1Qjm56AC9bgfi2mVOAIai8k=;
 b=VozvV7KVrk+ohFURkKl7DoI6jSmA5VJm59tG8lEJA5RIJy54MQUuEy38jTYORjKj+0rriooHeym3+8xNOMgbZ16bxgHyUOtfO0n9MZw3dc/G27EHJdECfNnLiMdNlaTRtvGF/cZ8aP5UDUn0PIQhLmKxSlvqkJXw3vHe7HnfJ0M=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 15:30:10 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 15:30:10 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/3] clk: imx: Make parents const pointer in mux wrappers
Thread-Topic: [PATCH 2/3] clk: imx: Make parents const pointer in mux wrappers
Thread-Index: AQHUk8HmFta/HziE702t12doB90prw==
Date:   Fri, 14 Dec 2018 15:30:10 +0000
Message-ID: <1544801400-18951-3-git-send-email-abel.vesa@nxp.com>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::33) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3754;6:mEsjJY7TK1S16EfjetrQqJf7xxOR+90SgMpENJYlTLU3vmYCBT+1Ziyw72PngXuQpUMIOt7JUJF+jsCv6yzG0aNigZxJFT7rEdnQqjzRTxbQejNBvYnQ+y0r4dy7aLt2Ue43LT1BS6MfrV/y+YeQlj9r+z6SROjUPrWfoy0Z1Rf+5K3vVz4CCTewYxTBIkq/qSGJbs1NwpFWg5YCmkEHI6mF7A0ye4j3aiXyPFPo1vCS3Nqi14TqcWvJMG09kRHQfPVXauCxyM8hwNY+3ilvgg8pqE9/M/8XrwnDHL5I8LLD1Uy7XIDS5TLCe1iyhjONfmoYtLVsan+Q9wo3T3DTAd4TGF1Ov5Rtk8d2LonB/BH1NCJVMYuVPyP+LMZ7tLGy3dKcagSTvcNA6Oi3MPwyxjfjWWtOQdjseb+0rNCiK//mlXGGyiU/phtTmEfv36nCwBrh56HU3NJKUaUtwM+JKw==;5:qlYvB7WCe5dAhvGOrSIZgRVDHLUDlB0aCRzMql75PWNwvmZ6uAsqYRYf9vLB0HduvFxSXq4Jtmqa5xs+ckovoYmdLH0OUPDsa0VRcPHFmpBOiu4bi0pvJcxkMTMe1pRu/dZvvUbZbmvj35CbHfMpV5CuZzReph2qyrbsnrzTwog=;7:P5GIMhbxmAaUcOXEqpnkBoQGwxKXiDLLiRB2JlX7axKYvRDCdm2J/8S0xV2vte+7AsbfqLbSTiyYEKDJfWttPFJzBnPOV9u/cQXtpSTfvez94l+iO6F/GkirqzFyV9gp/9OFGka+5177/dj6gYJd+A==
x-ms-office365-filtering-correlation-id: 2b8fccda-d043-4b89-0426-08d661d908b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3754E7C781B227776342392FF6A10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3754;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3754;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(2616005)(53936002)(6636002)(8936002)(186003)(66066001)(97736004)(52116002)(68736007)(4326008)(305945005)(36756003)(25786009)(14454004)(2906002)(6512007)(478600001)(5660300001)(386003)(316002)(26005)(99286004)(6486002)(6506007)(71200400001)(105586002)(54906003)(110136005)(76176011)(81166006)(81156014)(8676002)(486006)(7736002)(3846002)(44832011)(6116002)(6436002)(86362001)(106356001)(71190400001)(102836004)(446003)(11346002)(476003)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dqBsQQrwwj+9jq+q88qj8of5bX+/qEx43zUxgxEHjpktB8bfrWcR/+qarZRa39+KdMg+JnnUy5Cvf5BmNYd4nM2SFXXiMSLpqhOAKmXOjj4nTm/wPRyX4M/vs5RyWWEyPT/A8FFcuJ/zBaHmpbSGjvyZwp8KFaBBiAyNrmJLNM/StYh55b62WRboRF5IOeStFLu99cI1Baym+gPLjcpf4zDZf0irBDpOsujOiL4pf9xJ/uCG7k/OP6V8lQuluAg0b7+c+cyAifj00GbEUsOqpQ3sm3dv5yN5tnqIkW3P8fDzvk+dqLzwCFTXcZ5CSNqY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8fccda-d043-4b89-0426-08d661d908b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:10.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parents needs to be pointer to const pointer to const char.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1363dbe..2e442d8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -329,7 +329,8 @@ static inline struct clk *imx_clk_mux_flags(const char =
*name,
 }
=20
 static inline struct clk *imx_clk_mux2_flags(const char *name,
-		void __iomem *reg, u8 shift, u8 width, const char **parents,
+		void __iomem *reg, u8 shift, u8 width,
+		const char * const *parents,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
--=20
2.7.4

