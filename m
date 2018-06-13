Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D45B4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765C120891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lwCJiVBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765C120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeFMGJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:09:46 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:32386
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754404AbeFMGJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh//wxILlwghAkKbK/VQG/ZPAIKnYD/teoCB7miznVc=;
 b=lwCJiVBW8yDgem1q/7aRbFcANp/3DPwgcDxE4lZEA0iRXIgk18sgVdvPbkFnpOOr35niltQuRo5thqfPJc7EcZd13oiDAGbQb6RKJFtUtdQZkThBKsu3Sjw/LJ8hkWVC9xfU5beLn+842BUqFA7h4LCTEJK4ESx9U4UMJ3E5/Tc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.142.187.166) by
 DB6PR0402MB2840.eurprd04.prod.outlook.com (2603:10a6:4:98::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Wed, 13 Jun 2018 06:09:36 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org
Cc:     boris.brezillon@bootlin.com, frieder.schrempf@exceet.de,
        computersforpeace@gmail.com, david.wolfe@nxp.com, han.xu@nxp.com,
        festevam@gmail.com, marek.vasut@gmail.com,
        prabhakar.kushwaha@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO size
Date:   Wed, 13 Jun 2018 11:38:12 +0530
Message-Id: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To DB6PR0402MB2840.eurprd04.prod.outlook.com (2603:10a6:4:98::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd5294d4-e87a-43c6-ad26-08d5d0f43fcc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2840;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2840;3:4laBD/48EYmC9dOA/wvMB7hD8nzyddwUic4jlkBKEkh79FhJVWrXSfNuz48hlMCJfEOIHpZreDdJOxdmP1qrNFzNZGJaXap0MbNZgLBnLG4FmAuszPlX7LkbhPZIYQ6YySJwIQMyYFV9RJ12PnOO+mZPsjkyga4FNZ+l4PlSH6otcjA64xtlV3CXUCFHjWiJYND5Zpc+vtN0h5uHQqmgClg2Ia9QRosXk5ahB86PQHzRfQuVuVnwoawaMwmKCSVl;25:bOuxoYIVQypIs6nzdu+wZ6hRS2QzaDezdFsFWFudOkuovDYUD4WpXXcjp2oxpb56dlgBElkNOFaOVG04YOsyupj9Ycsa50oQ2ljwDW6uLHhVxhjMDqVEMso8cl6lXrl8rWatI+t0JqrofY98cK6N4/tqx1jD3B7K4JOcq+jRYk9Mv1RgDfAXAD9D70RCt+Ach5saW5XABDegFyJz+rll+jT+7uZ2G2hxBYn+ch3BpTIkRtLAuaFcXNX7dx/jFlxVcKEVdo5wtYer5BVbYKz0ClkgklAOHR5CT3ib+OcYjUOafrepNdv2KSuTSpHI8onV59NmfQiVgzLkx6j4LE+8ng==;31:mYLINWBh1MwRFqo5T90u9B4hhKhV5h1Af0GxHaADDccq+YRPMvc6XtuZgae9bVjVD2nmrNNBBt2+hP56yKBTxL6OHL3Omi1uaFmxEBQ8FdyNnl18muIwZn451XpUK/SkHiSQpB73e3llUR6IYxdth7H5t5O2M1/nSkNUe3X0oghtTsjwUz/rsHrLqyn1K5LWjVpaTIPaVZ9rRcO/2djeG//iOP597tk1ekpGy28gp7U=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2840:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2840;20:zShxKM+G/2UtSQJKE+Wf4Xg145aRkSuX1PYCE7g06Dd3ryUH7MJ8ncSr/p7wulMPaJo/nT/4bUcNo3xFg9X2Gu1gmhnHvdYuORFFIvE8VtUFi7UoyqHuIXsbA5lt8rI4C7dnfdsaBGp+vFW26JxAWHVJqAGxUXm2Q06G3UcrBgdiTUPFktSQl7mGrahKoakWncOAU6XUDdxmoh9iKWGaUBzPWfqhAhCcDIZmHLq3YdwdXOixEUI2TzoTd8T5c4J+JKugT4EzKMPmbmvy+8J7x/TzioaZ55PNjHJSfAmyyl3j8FfhP9XTPNOr7kTk/fJXXJrFcW2U3sanAsU1XhGczm6Jf/xUMVtYmGGNKKmQ2VSV4SD0sWGQ14T7CKsE1NihqiF0YfFm5YqkMu4G0ThSXonikU1/YXNET2gmUbcAkmwxLxF9qz4a+5ZfDqdQe1mcKZTigNOUQATKxS2TAG7xNJ+MFOD4oRICEonCP15eUVl84YV4gUNOGYS5dkL855zJ;4:5SZbM7QgR0yR5oc4L4o9k9d4ONiub73/MZMT7XDQIeXAhs7nffBJYmA7s26pkLVF64jhHBqP3NjrE38dsbZgnnC1Fn13ZW0NOwelD+ygW/GCbzWO04igxORKnED1w7PYdoFn26GX208WaO64Kq7DzWOC8jnceUXB05w7mj1HWFni9rw4vq9rqzKUAY38IjGFah1A6/hlmlPQaasims/TsEwrxTSsx59y1XMtqrFI+xXKzYsr4gFLWRLMiVGhw8ch5GVuEgFlyD/5EEuPh/UP+86sDHIDDgWko2scPVJy3SM/CC6KXI6npbI//frVFRbJ1Ag5zh2u4XDDgtNR2RolhUSW8aAV9XeTtSBQEYNw958=
X-Microsoft-Antispam-PRVS: <DB6PR0402MB28409C41F7D126EF0B728C1E997E0@DB6PR0402MB2840.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2840;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2840;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(199004)(189003)(305945005)(6306002)(4326008)(106356001)(6512007)(51416003)(8676002)(2906002)(6666003)(386003)(6506007)(55236004)(25786009)(66066001)(68736007)(52116002)(5660300001)(48376002)(6916009)(81166006)(81156014)(6116002)(6486002)(3846002)(7736002)(50226002)(53936002)(50466002)(2351001)(2361001)(105586002)(47776003)(39060400002)(8936002)(16526019)(86362001)(186003)(97736004)(1857600001)(2616005)(316002)(486006)(26005)(476003)(36756003)(956004)(478600001)(5009440100003)(16586007)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2840;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0402MB2840;23:I9LTH1w4w4L+Cm+hF4+WkyeCnx19TO1MrSnSMtU?=
 =?us-ascii?Q?HxYBOS9FS2Myo/63oymQo2ADyHF48VdEgRo2yvJZYCfpVMggYbNgy2iT2r9P?=
 =?us-ascii?Q?kXVV0ZD4LYBgBPi1NhKKWvOWEMA3lYDZ/6eiGk4V4YJ0NDT6wQ+xWCmMmsSU?=
 =?us-ascii?Q?T3ihDOTGVOeo4xOPVHVPDVljDZgHWaYStFX9efbNw15f2YHb0QC/Pz1TjCNC?=
 =?us-ascii?Q?O2ky7wLlqo2pXSgFKq/uuNEbpa3ewl0GaIh+se4ZM42SNLRoGrEL+05YZ79Y?=
 =?us-ascii?Q?pBAW7OlAxGQ8CauzJb8agqOn6Bn/FPTB1N9OHA2kXjijbjFsqqAR9Ru9X+bM?=
 =?us-ascii?Q?AcixA8seBsXBEKR+erLd9gEFyLhafMbOeMd3DlwedXsLyLho18Wcb5So73za?=
 =?us-ascii?Q?jcHJEvMrof9ACNOF3PIOWj9ph8fXHkFxKidw1qH+hkdi2XjVYpmCdsay83LO?=
 =?us-ascii?Q?dQjqKNReESKRzUSjBrVDuzemjUmqAyuaMRE4JwMD4ubO74PqqTEkfSHqjAst?=
 =?us-ascii?Q?0U2Pi+XzhImRusnNnf2VRTYRrngHo1HSSTbeb8uZCYh9DzCEMcWeNt/BCTs+?=
 =?us-ascii?Q?6tVQkcdeWxBNbnxaCeALtYTBVOIdd0hm/UDib3BrLEN0Gxt2vsI7xW2+JlbN?=
 =?us-ascii?Q?zJ58+caJW9IrHXeLR7iNMSF1di/zRosbulhBmZfWXge4uMew99DjP4hzId9Z?=
 =?us-ascii?Q?P3TLy83MstNdvLzEntpbo+Uo+2x7pe0zi94XF6xVe8+XuWM/kBnRiF7FehDa?=
 =?us-ascii?Q?qKkgoJpa3RKOCG9fJzbB8CmJ4tqDct58j6uI64oAKdAcqjFknWgF9hyuL6rA?=
 =?us-ascii?Q?O19qltVBMr8RmtSoEYvfd08wV4OGum7Gm0POXARMzMcP5gLtiLBD+Cfth6hT?=
 =?us-ascii?Q?LEPo9CHia4eKYHLOG/1TVspu1UacMNPr+hbOn0kI2G3CPZ5iJC6bN/MU9rO7?=
 =?us-ascii?Q?OIpfOgTprnXVdhq3sLGZN2oh+g9amXlky4VaJ4bLuKR0HUpS+vH/g35RGPDr?=
 =?us-ascii?Q?FOxHrTWITBziXqvsD9pyEEa2+WNoyLaMxJolkK4rks09LBUpdv+IsGKgemxe?=
 =?us-ascii?Q?4hDb/a7aKmNAYzNeaDgSXUp93z9R0vwsRpXpzGChus6bjUMt46WBGfq3aVYS?=
 =?us-ascii?Q?5B3hjTJaSswI1Xq09y2cqUQLI9sjKmaLTA7bczgGD2evBxVRuK+yMBoQNYc6?=
 =?us-ascii?Q?5S7J1dgwg6v+sYVGkca2naMEBME8uGQUNNtaAd8Byef96Strf1Kx9qsmaWQV?=
 =?us-ascii?Q?vyL8qMilIgcKxsfLD+4NrejrF7bkJF6nWVKMbYOMbZXjd/gdTvtmB7ghRmzu?=
 =?us-ascii?Q?iTWHzBqngrFNSWC5DkingL8I=3D?=
X-Microsoft-Antispam-Message-Info: XbU+MzrS5SAnLqSDVJ0BAfDLT+llQ7bvMjbJvit3SGTmm4mjSZP3oES7rb8PuXZcdVoDsJNLD8VgeQV4oBopon/ATlu/NQIiG6kr4ABUhSdceEJMXnxmA6HrhMKIa8U9XEWt8F9Ozftdbx1xdEGOj8UEsrrnqU3mWQJxbdq5VHWSYE7LTod4OSPQYQk3X/jE
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2840;6:y7RiIzOIPeP3lOKbGEvguH7qS3pT5tx5geXsJczLLooJ0XR73jlLFQwRjqlO0p+nVZyU1444RA9pvVbWIZHFG1Pi1/c6KnsNuQpYktlnS0+5iJFe/gJNiB4Ag3U5FWBOzi1CyzFGLhdOdGYeQWt3rP5HHJyrHMxmRJ3oyVUZEYSqDkEVoOFoomFlq6osDYsEV7L7fLpwPSzH6532QzukaSCBcqkkFoJw31+X7fe8ZrURyh/ZWV79Ujibc5YFyLIrkB2Edx893eAp+AdMUsQsORhYCNSSeNlOT7dYQNoAqfqGK1OOQLBqZK/GWuIM6C7sfiYJpb/7160KPNHiVbtbTAnZOxI5/BCSAYPbmeAONupuCxH02MQ2+OsrhZ4mfqQPmTqyxv+l2k7fcFCOrYBOSDi3VfYOBNm+IV9/IKnF2ejAlKspa0V12biEBgpKatAjBDRyXZAWhzTqgEeIGdVWpA==;5:PmXVsJOUKHmsWZBPrNNXvMolqrRchK4QkBhOTST6u584vYkiyvM73lphvfwl30eHBqP0IFs7wt1I6k3GOGXvU5lLZPMeDubkPPNvEwqY4KZfneWg7AZ7OE+iEa3qyoYOeRZRtoLftkKcUCsOD0kTOjtfYEEmfNCTXbLmZQjIK+Q=;24:9loRNfpbhc8GcaiZaiPXoGSCCQim6uTcaRlyF8H+W/ITm7+3nP2MklPikLsBmP8axhbdRltf3PnNWZBHD8DiVp/zEQgcGcznJDQqZhSzl8Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2840;7:nVKE03mvZt33UDjN9k0twv3MMVaiGT0FQjnp0ra/ae8NxTKvolDM/nMbPOAjKI6BQo8IPj48+Epcms+fvW5iVg1dyriBwMEsV2sSEglxMviREAsKVSnC6LJRhpXMDJ3ARgJzuU9zHcQw5K3mUT2UC7KtWllG4R4aDRqMYq60x1Z+XUYk3lAiXOnR7Bthpu0/ykmZLw0pGtxfrcTltNdGRR9CJtAK5IR5RomM1Q0B0qxUAnFkKHdpVelnpFj6i6eO
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:09:36.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5294d4-e87a-43c6-ad26-08d5d0f43fcc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI controllers can't write nor->page_size bytes in a single
step because their TX FIFO is too small.

Allow nor->write() to return a size that is smaller than the requested
write size to gracefully handle this case.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5bfa36e..3e63543 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		*retlen += written;
 		i += written;
-		if (written != page_remain) {
-			dev_err(nor->dev,
-				"While writing %zu bytes written %zd bytes\n",
-				page_remain, written);
-			ret = -EIO;
-			goto write_err;
-		}
 	}
 
 write_err:
-- 
2.7.4

Patch is based on the spi-mem framework[1]
[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-4.18
