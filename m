Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B38826877
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CZ+946P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B38826877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeF0DdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:33:12 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:23368
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751384AbeF0DdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq/N4HYxTWYzD1a1FzokLb9na1MvLSkfE7ocErnakJc=;
 b=CZ+946P7ZAWvW9WpGpvlunp96DP9GwGg34anwM51/BV+Jk2Kc4VMbpS+v4hiAE1hyHPL/qrtn/qu1qvotel5475Cq68mT4C+JeIzBxL7Pq3Av8xcBzW+x9YcAiGp4I4jugqfxG4wlfUvVUTqtAk+RUWwdeX5h6NVOL8WDL7f1oA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1320.eurprd04.prod.outlook.com (2a01:111:e400:51cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Wed, 27 Jun
 2018 03:33:03 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmem: imx-ocotp: add support for imx6sll
Date:   Wed, 27 Jun 2018 11:28:49 +0800
Message-Id: <1530070130-3004-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 901d224c-5082-4c89-67b4-08d5dbdeb21b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:tCe6U8b3hOarmIKTtNj5EsbibyPVZxPSZCObE9a3OmR10ez8DCboPbUxw5jwgNQ24qiJErtU6HDIhW3l8n6fedGtq+BGOkHA5qhQ3+Jt2aTecmXR277P74ulPZHXlCP8VMHR9qlUoTgmNVVrKCWy9pPq12191OfFg80BaHK3EGr9V6h4a8AQY8qyQsNFSoz0X949LCXCqWe+iX5VeDSe2HE17sacS8FeTnjXjmrKser1w8bY5OvD4nqXcLCNGM+i;25:7gCnyJRMzsvVuZL5R9dGxHAnyzt7bgtfgUftEQfU+SRWggRjvvKyc0XG9cf8Xa31EqFuniCywOy1ruQ10BrFHH3DN+9KRdGgX9FnOXOrhNLNBlhNnjTEKuxRQXpZgnV2NxKQyOoRF0QYAd/JVQ4CDrq2uUWoLxkdbqydCZjcAKAFYciHg8hC6qy+jWdaHnn95VYrrEjZ811EbU6MlIacXzL6mKTD1xVKSSmQK/bpTAL6J8VW3dQ9+cpwNsuy47Hko6xC4ZZrMGr3Qh8H+h27dUYm2UTaaYGLcQjuH+/JA20tV+T3DgRfftNJXW5F0wb9Wu6iY2yorDiiYUJcIDEYSA==;31:OpHJ8Op5UKE61SETFw0vmd1fm08LvcihR8+ikK5NrgAIBzbDnVMswBwpzEmJzq9nDi4lAHwTLsQgmTlIPDuo+he9KtQO75yQyVMsNmXgGTKdLbocCCecHmZhB8aBe0DbqHBuxb6SSWFPWI+wGBl87bIo906IxCaeua/TarXhprCZKdEhrNRNiH7mZZxT+Nq8I9u5gQ9kCehvufnEbhQsEeWr40wg3KuBKdR0Q5rBdZU=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:6FPSLkK43WiUojsszHbJN+5iA0w2Sn9LPfk2pS3qgSSBdsPxv7HoDvf0K1mnN0C20HDTvm7AEJgL/jCWnT4VJQBZGO5vpZ21JvWEWLWUBOTHLgVurT6F99V3yXxaULR/W1QCbLYRnkXynFhc9NyzvsKP/SxfWiP03yKdiRhPNc3sEtcFYhAg2dovEG1vXXrxdVc4jvFDhXjwS6rK9G5wRHApo66zQMrumSLPORTAt+7FRHL+Sm0I8yRlR7bZYo0BP+kjiSFoPh3jdi4Ppdf5nzjfti7KbkocFKenkv4iWWng/i3woS0sV+ng7iViqk2gIs0tVXzwaN34R/+X4WQjgSjPgsDNxJ4A3ZkrnpuiIfJbSNaR6WUEUM/W1btha3ociMGgH+n/GnLodWPqI12D2/0qYxoUSftAjBLlkoy1NCV2w3QMg20DFj3wtiFPU6demd2L/CzLilfMVwrkZlZBxNtUIaW94RoBPX/U7WyB/zO7CHOX67x29z+ZJzvYFPAT;4:VfcU7bQU4gY78FmSN8cO2CnXbtuXnP5LrXDHMlo6rYNjEcKwxprmWMi02vmwae2im6wDlUWolvTzZyOKm78AYpXoG+aegSYdQhSgyvgJ+MzGzRJ0D97zVzigW7RpekdgK6QzQNwAdUj5TST/6HsfDqbJmoX+AUKGIkG9BJToh0L0VmZXr4qG4Pmv1OUO6caLXt38dHC9a1Zm0mMedq6xOjlIYncklpJnmfVOJxF6YrreWGBgS785tqsFpLY30uKLWx09kz2MuzG1CQ/ADalTq4aOp2e552OiLtn4l5JB8bfYyvIvMHo1lYZODDobKbmQ
X-Microsoft-Antispam-PRVS: <DB5PR04MB1320CD816EFBAB455D9B055CF5480@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(186003)(16526019)(8676002)(2906002)(386003)(6506007)(26005)(2616005)(476003)(81166006)(486006)(81156014)(8936002)(316002)(956004)(16586007)(5660300001)(105586002)(7736002)(6512007)(52116002)(51416003)(36756003)(106356001)(305945005)(6116002)(3846002)(478600001)(48376002)(50466002)(47776003)(97736004)(66066001)(6666003)(4326008)(6486002)(25786009)(53936002)(86362001)(50226002)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:GoKFTHDvTl8cko7o2UECabkil6jq9VP7BjY/KXo7h?=
 =?us-ascii?Q?Kcg1A1CaIAjKU9cSSpm0XDCGpgVL/jCyPROwiiqVWbGfzAafBjBlWJHUsFLi?=
 =?us-ascii?Q?l0LBKxpDgD3C28Fl3CarMtr15+a07Uv1SaB25OPGOneAKIaoYA4Mi8ja3laK?=
 =?us-ascii?Q?pT3z2qGvcYUjLFhVkMrVsnCAHpmiXBBEiMg51wy0AP5LdkiTMuHDb4rYR9/u?=
 =?us-ascii?Q?KYhkwu8TArFKyXeAH2Y/1prOL+mPOWfezjMPZvhtEnVdhYJfZtNcUDmJAVEa?=
 =?us-ascii?Q?LXxuu+EZt0Seopnk8iXrycRN8ZxKnrM5WA9Lx+2iDfzN3FlMgCvZkb0C5go1?=
 =?us-ascii?Q?LUgAUR+JNUK9WYl8uCfU6EcQDEMnGKSi6Aku/PCoqz6X0WJx/9dkrUDM4cN9?=
 =?us-ascii?Q?L56zPrsK3y/JaxDRtbDPmh9qKo/KaJASfkyVewzyLbDOUqtXY8OAlLiLbb/4?=
 =?us-ascii?Q?9gVxKfG22TxvvkjaCNPXX7pw1ObDmBr5TLeQSa48U/p+lKF4/9UH9G86w4/+?=
 =?us-ascii?Q?2IaWYOD7jY+GOBs0nJDXIK1nbF2nfBGkK2QUQeyQjmZ0BO7lCgSj+IGYVs8s?=
 =?us-ascii?Q?OJwX0CyCdHJ8LOWKl9BQ/78uOcIw1zJVOvxo3bhaorXj7N407SgmbjvXlIVj?=
 =?us-ascii?Q?Be5ubJQuaFq90TFPx7zLwnQY8pqGuUXdvaQ+nP6uSvqR+oNGKadJlgntdvN7?=
 =?us-ascii?Q?I/Hv7Y7Gcrt+QV6Og8ikWsDu1QVduG/xjeJEW2mAiOPS6x48vTuMpZMHuNTo?=
 =?us-ascii?Q?5va2o0gm+vQFzGW4QT4XxS7STtTP6H0zcxWKw80QPEFYfG7WQpYvARyVeoPC?=
 =?us-ascii?Q?QCbHpsBV0pke9jIQnieo+X8SNXz9dAKLiebrQmXieSLg3Tr2GbQ4Ehln+lyw?=
 =?us-ascii?Q?QPZPSkZVesgY0LJ3SJhv/4xmfnkZVUNKrJBcrNV9yTElYgrR8EgnjKyfRQl8?=
 =?us-ascii?Q?7TaS6eCMwyB54+ZgMWC3FQTDRXYHX5vxE3xuqVn5wsMBXYhKLwDvXLplgKVf?=
 =?us-ascii?Q?EwqJK2gMguKdkSyKm1L3I4LfLb8hRdwz38kyCFfDNdz9Xpgcdb8rsIRB5NSp?=
 =?us-ascii?Q?PRpsuhyxlLIJh49XnAimjVNNtwFdE7av/R+tbae42ne0xGDz57TNXNRnyW5/?=
 =?us-ascii?Q?V/sL1GXD/w=3D?=
X-Microsoft-Antispam-Message-Info: pmS3n/hL2ybGwiPr9A5JMpCsyT5dcmpUNS7Wgy6tU5PlwKc08hLXY1FIYEmiOARDrHJpKxXvAV263Al6Q+qciaFsK46xp4ImO7IZOxyTQwoxO0rNOXUJL+Or/QpgzA6m2B9RPxsN+cpWG14PSCk06qA8QUMB9JTqgotKDepn9rhiqS2faTNj+LEPOC3ZrON61BRLrCoyPWbDfjnTSMYqv0nZS0VinGuAjMa6WeuDrrrZN36l3+4nQ8NsC7uj6+FQF2tltx9ZnvZrAB2QsUVV6YXkfREAuCXmp14Cme3Y8FGFRfHDfvA53jL75luXkfB+Dom1CryiciqsNM9jFEy6nQd4o3iTK3lUfFmQ2s2dEYk=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:q95EMiIVbaSqWJEOudjvF6KW+32baggDYYOzScUD01CoTCKJ9pAs9jy4YnFW4ILZjP9d5raWSMUTNZoKb1hN3RXG2aygwftAgJpEVz5eyJ4GAi7zkoBfmHuUYF9IiQ3nJW7QXp/5iR9k6BMf9Wo5OU9Kcxci5/sQNyvEu6hFFmrry+FY/r7+IPh7Ix/7OOTFP6m3yZkLaF3CMqx4khw2apaj4riRKdytj+cxOjogUckBIV8o4lfwgkS741gazVCDYYvUPXw2kaoTcLlR1EN07y8i/G1m0wKwxxsPZuAvNiYHgN7ssQRfbQyQDnpwlWHBUGsR3nQfoFRoPKIDaWTEaPOyHSvhlstUAZntG/9WGNvA6PrXD66W1mbDoIq3kTjdfHdPpNhnzHdqN+oynyzLAQEZx0J8x7E8K9ZbGsa6UGlpu0qwzyeMA+MoFts1qyQ1Oz2GhLwaJrKSuZ2NueS1PA==;5:vAhRDjH89owe4NmzATXUKuCqNZ/pJkES3HjrLuc/x+v4wgkBxJjU4uULBoe0U4nJvUJFxhP+BDYIdDA3gB20PQ1nTXgiZ4DnGRml9j4tw/ANZwpypwOLVVFeNgCQwsxQ8Pw04dgvk6U3FPxOSitoPXgIHECvp4iWsvQk8w0g+OQ=;24:vyOfzvjLHUJp8HJuQFH5M11z5I4wx6tu74M2jg2aJIEAJpBHrbuSk3XHWhjKxzCO6IDVcVWSpvPBRDGA+cMOXzFQgfv3I5P81i8SGfPtGSg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:szJ2UgbFp5b4K3Lvxxdst1A2kJy+d/5dyEeZOhD2zwnduhT6btW3gGpLYiXC+QRvqkG1yIelYwW8sm6cBvHXqWMxhcsG86AsHGFhKslSs5EQ31kjnbsOwGJJ/mGJ0x3dr38bJq6Swo6JurVU79ERqdD5m7UaVzQyicuz9SjCYbDkgb4t2tKmxF7f1VcTGjLrxr1GZxdWSkOZA//qR67urFw6QU04O8+cL8bDMKyC8IP1CsqluP2nj6uGJbVlJCUu
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 03:33:03.2913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901d224c-5082-4c89-67b4-08d5dbdeb21b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL is a new SoC of i.MX6 family, enable ocotp
driver support for this SoC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 60816c8..afb429a 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -409,6 +409,12 @@ static const struct ocotp_params imx6sl_params = {
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
+static const struct ocotp_params imx6sll_params = {
+	.nregs = 128,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+};
+
 static const struct ocotp_params imx6sx_params = {
 	.nregs = 128,
 	.bank_address_words = 0,
@@ -433,6 +439,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-ocotp", .data = &imx6sx_params },
 	{ .compatible = "fsl,imx6ul-ocotp", .data = &imx6ul_params },
 	{ .compatible = "fsl,imx7d-ocotp",  .data = &imx7d_params },
+	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.7.4

