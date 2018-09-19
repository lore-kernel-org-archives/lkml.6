Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C0A2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kqxcGx7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C0A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeISLqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:46:19 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:6887
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeISLqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS6zmtPpJX0mAscP8F2uy/cKsZTsc4He2u2hCKTJeDk=;
 b=kqxcGx7J6XXgoGOcISy1LZgZfICuAGvPdYNfXb9QTO1zHKgT70slCMlxb1WGdROx1ZNpADy5kXaZMwNSTX8SHlq0wmoKE46uIidJiCMfTuBTNgWWsiPZAn35e8uE1HhDrYCn9TfYUla92HvslPO/cUgf4KVPqybCA4ncSA1Up90=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3919.eurprd04.prod.outlook.com (2603:10a6:803:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 19 Sep
 2018 06:09:46 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
Date:   Wed, 19 Sep 2018 14:04:45 +0800
Message-Id: <1537337088-28819-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To VI1PR0402MB3919.eurprd04.prod.outlook.com
 (2603:10a6:803:22::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14276a32-71c5-4ec0-aa61-08d61df682d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3919;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;3:X45PeOvRXcz3VFOrJKZxQ2YI6i1s/12clPoP7yjPiTIY3bsvTweKswxL/MsRvSGBBP+JCBJrruQaL7k7mGD9ny54CHQCp9VeyYFDfnfVPrZ+WYjny2JIP+HoBEWT43qRPba1yyCq952hoJ+HJHLoK6ot5FZvR+NKUKUDYiBHdiKZMbnvqf+nRMT+moj5VEL1uBmsVKXcKv8dkhXwFEPLVhj27qiN1hxAA4NAqbI9tDN82HNP/ZzF98HBIIe6zLqZ;25:NGU2ANg58wg+waLwDzy1ZOo9qfVUzRXTR2uOpiCieD+bM9FPSqIpuQa0Ls/EycC50/+gNsLNl6n4BEHh67iu/dLP7s4swrq4x/w06O8VHUw07vV9FIMl89nW1UJ6Uq1eNWHg/VcfPYsds0Kuz74IKx1ZvBN3uYchDe7NjydVmAYtJL6No+yhFt0OZcko52f1TZWsph4kdToKKD7znjP2e1zSVARZSsuG4DIjUTfGXsPKnWbd5Zh8/cR1KVVEbYlSAJWfxqqF7NR636hkLI/Hhgpewo4XdHFRffvWvz+thA8GOqxkZoYHWoLDH2sTSVYWc08GmKfAUFvK1FyrvnLOMw==;31:jPEs8e/sStZC1a893unTkZ1EbTG7NcD/sTA8k4JxMAnVoO2zWEoyO3pw2CTacKZ+ZMlu3Fgp+BPOxOILXzWPpXSMwfJR7LDImY67Agt9wv5brCmTh5OC7MKvxhOfv3RDX6kHrazNhN8CjKtwFGTa71kB56RCczmFdmjut4muXw+AZbQjKlvYyxh0apIAkA9rLE/G5j/FXG+ePXyUMtOY8PR5SLjmBT5wugsMmYTHpeI=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3919:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;20:4H+TQMT7KBw77tY+7CEbl9GdcDbScdCboMlbP9/3D7+V3BwyVW5VkY5wm1MaDfTczbAEYwj8dzQlc7YtEppmB6fxmxolsLe2TOLPkq0rV1j64ls1qeaOvDtmaOjxzTpkZEc0VGxjlGH2X1G+mv6UR46s+ossJ33eKalpCQScBbDK3iSpByhw22ZKhVNbrnMCi8fGom2TMXfC67C7etpqAQzoqtOfhQ/mpqKjJqAM6WjB1USg5almWkseQT9bQdtrsSdpwLo0ms54Vj8D5/zPCGOl9Ih4Sr6Ulv3QgVAVCFlSKPpWq37NeinEfrXiaEAdL1xTo6ob/rFoHNvCldzsK/50vaVltQvKWRK2IJNlP8RUs3ZG4QXESD+gpQGxPIaxDaugy1dofHSvVM0ja/s2pQyqFfY9Pd7XB4XXYo03U1r048ouE1yJoMdAArHAi9i8JiLLbAsahgE0OTdEWPQoD38LK/SseiNKgRV6x25zkALosygp9QeGMTw/PaxN4Iej;4:/1cdDt85SiN/D9WUBmR0rgESU6Go0BaTgy/qN5hGZoKJwZCXjQ2uEyhViuUKfUyl6njPDV/gJm436iU8Cjbu2LDliubb+h7R9TOac1M+zaMypElsZOzVchk95Vu3zdocnGIWVf3zM53PUvM06B0ILUaC33kIELHZKMPetNO72PN/R9mv4SAQAMvfxCIxw+ntznrx0gFeO5KTRD9M22ET+vKN+4qPdc8YDixn2IS9ANF58cMrcGqd2PGJBpN4eKuFmitAi3o2oNq4sAf0KalOgeVX3zS0Xi6kiuFNxnodhDfr1LyTS3dknxHX8yI1m98q
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3919AF73E1CEFB4C4032653EF51C0@VI1PR0402MB3919.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:VI1PR0402MB3919;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3919;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(6506007)(26005)(23676004)(486006)(4326008)(16526019)(36756003)(52116002)(476003)(956004)(11346002)(105586002)(25786009)(6512007)(386003)(53936002)(2616005)(47776003)(6346003)(186003)(68736007)(81166006)(81156014)(446003)(8936002)(76176011)(50226002)(66066001)(106356001)(6486002)(5660300001)(86362001)(305945005)(7416002)(7736002)(478600001)(2906002)(6116002)(3846002)(2870700001)(316002)(50466002)(97736004)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3919;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM5MTk7MjM6eEFqVnhtcHR6eTdKcVpOTlFIQTloZGYx?=
 =?utf-8?B?dWh4UmJyeFc0cTFadUZrcXd0S05ramhPVDB6amU0ekZjY2xUNms3V3pIT090?=
 =?utf-8?B?ejdENG40Q0F3SEo1MHJETlJmTWQzaUhrMTh3TjVVMm9RcWpHYVdrZ0lLNGdY?=
 =?utf-8?B?OWl5VEIzUDNhTVFYcE81cnlvRmNWTFl3ZjdRUUV6MUtwQTlrcDNNMXdVY05C?=
 =?utf-8?B?enBraUFyZTloQVB0cGlQa015MjVDS2hyWElTUW13NUppZFhSbDBlMGg1TXBN?=
 =?utf-8?B?bVBiVHpDaEg5TnRoUno3QXpsYXQrYU1EM3J5QisvZmxTcHVqdmw0WTVTN3R1?=
 =?utf-8?B?ZnlXNkJmTEJ6bjZJMEFsZ3RCQWhyVkE2WWd4QUpNUmdDL1ZzbDB1ZUZqWC9O?=
 =?utf-8?B?aEtjVmZVN0NyWkwxSmlhWWtzNTVUR1pKc3dubHZObDB0YTBNVUQ5QkxnWnpC?=
 =?utf-8?B?M0M0WDlPU1Q4VElnd2VVR3FsdFdxb0gzcHN3Ni93VzhLWElaWVI0VnVIVGRZ?=
 =?utf-8?B?N0RVcUxoNlN0V3YrRVJnemVVWTg4cnZHekxQODdIdmJsTW1BVS9aeWEwTGRD?=
 =?utf-8?B?MDNyakFJTitNSXVBdUJWWVpPdEFYSGdWNGdsTmpSL0tCTnZsU1lYTFMvaXF2?=
 =?utf-8?B?djNhUkhjRjk4UkxxQVh6WVJmN3RKZXBFSGZwQ3BEQnJ3cGdtMTZiM2JFVWpS?=
 =?utf-8?B?V1prMUh4NTRFenIzSFNIakxJQkhVMnNnOTAxa01mU0NRZ0QxODIraVVOWXhq?=
 =?utf-8?B?U09vNElOVXYzN3VDdE9iQnJRSkYzdVdQWXo0U2dKUnYwVHdYV3RKb0t4Q1FG?=
 =?utf-8?B?N2NHZ1hVVjNiOWtvRlI4Vi9zV2ZjdHBtWFVtRi9VVTZPYzlBeSswSXdhemhQ?=
 =?utf-8?B?ZTVRcDFqWlYwb002K0JwY2Q5dmlpU2hmWVlNS0VUdGpGNDFEYk52dFNBb2JR?=
 =?utf-8?B?YWJWVW91M29DcWdvdHptZjAyejJSckZkRXErNFYrRFV6ZWY5MWtNWVFGK1RC?=
 =?utf-8?B?R2RQUC9Wc1l4dXJXR1J5RmcxWWdTR3ZieTFTaHBBSHphRHNKakRJaVBTVFps?=
 =?utf-8?B?ZjhzTC9FR0lHV0VyVVhvUmFURDF2RXBoN0hUVzMrK0ZFRWRnN1NndEpGays0?=
 =?utf-8?B?RHdTdjhuVjZsUXVxNHZ4dUxORDFkaE5mbzZXcldzaS9WRExodEhBMFpRMTFs?=
 =?utf-8?B?UlltWlh3UU9YUVRDZVN1Z3RKQVZ2c3JXSmxrQWlMbm5vY0kyb2NxamxjanRC?=
 =?utf-8?B?bTd2ay9FWHFXZXoyd3J2VDdFWU95QXh3S3UrVkJlSTZFdGtYQzRpRzRHVGgz?=
 =?utf-8?B?VmwwTklxZytVejc5M3VxQnM5Mm5DRmNjd2dUNG5UbjN1TVArL05yend3YXM2?=
 =?utf-8?B?cFN4ajNiL2E3NnVsMWdMQUtOUmtKK1NHeEdPVjBPb1liQUpNV3JaazU1NWw0?=
 =?utf-8?B?TlFvdXIvYy9kdjVHU0hHWWRLelplZElsdTdKN2ZmdmNyUVNmK1VtaDZiWlc2?=
 =?utf-8?B?OXh5Qmt3SE9lN2VKYVBSeVFMTXJnZ3ZaNG1YRlFVVG52MUNMMmVmeVMwZ3Nz?=
 =?utf-8?B?bTNOU0V3OHdsRTVTeDd2VHMrSC9DRlpYMzNNQ0YrWXlZM1REQmVIakJYVXd4?=
 =?utf-8?Q?k=3D?=
X-Microsoft-Antispam-Message-Info: mqDkqSgYzk2KbE0GlOnx3je5sNGwWPdjYyH7Sz1MaEewJSc92//iyl/xnFLTgx8IQRIawEfFyXV6M+Qx5/lFSO2Su3JSenraAQUrgT013zijFRbzbKJkLL3SsjLRkeXvWVnrdm5OraQSgQMNT9tilmhd/rcJybLg+xxTsTajFPlqpKtW7XrwjDRNkbn81OCMgDi63U5Gbi3n/axm6jKe5suLeE6Bnv0oSZlHg8ZT0Bpvo9WRBoj4T1XbAI5OZ8SNaAAgkoUSke7A4EcUywxHvaSu7Y6vuJ9L2OmB8tDRQ3n08quoIkhU7x9fbKKgDXhSLg2TN5tOhmoIWURjAXOEGiQh08Goe3rxfQgQlL5Qcfw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;6:6fwtCPfsh5eC4OB/I5opwo/je9SzNy+WspDImnrVSztuten5kZTul2w4q0qXA3F+N0odh+7hdRRYCSrYurst4Oe8khaj4CeP1H0VLPwRS8hFVTmiljhcmHW3kRg8cipWJiw+LLrtRg9ERRyBcI9KL9yR3L63mdCDe89VnrRYM7MkwaupP5dReDxv4qRHsFj7x8EM6HcZrZcPPz0lIMbHPf3B4WBbJtD+1a+e8LKU/3jzE7wuaPboooSht11Iz4TU8FCoNxDi7P2MSsadiNmjkrv0qp+Vhi6dDiY/Rvas6h28LOPuEBIqg43QzdgOSJXMTtscT7B/lrZwsK3RfWBCxV5RhRGZBz5QZrxf5lOU+yrUyws4++NqCPE5el5lqHAS530XkUBcEee5U/ucOsnz7Sp0rXiXb8Vr/KnbcJOlINeFKdQNmyKmYCBt9zAApngx7lmEah63qKoXtiyGl0viCQ==;5:HB/00ueQcnbFvoUcaQ+I14kfcZrHpy4l9mJFah6xZ9Cl8+fumh7h04tkyqK+Nj6IyDFlrc/dswRmDPAJeQ8Qt510cayhcHhb6eV6xBcLCmmKr4XS+gE907xCRbRozWIsTUjVeozNl1yse5RvpFOFCe4f9ZQC6XftqUEIoEWfB24=;7:03q/2XIxwNEufyYrWrc1q/QwmTxM7JruMUw+XyvrnhUW6n/hGLhGTkyMFL90rTDoQ7Q/qRFDOkwIi/Y2/vT4WJWyMF+m8JpHp4Zk/EoXL3aE+egYH1lDaHIYk7DS51MjXiCpxahEXraX5Izj8ADA/j7UjIaOeMIeViYoOxr547twJv8usnRVa+OoiRjwP3dwp1juQNd2kZatW3fA5lN8NGseGYvFgTuYYatMIEBZjSyVuGGFKKNM7beNr9/zvJ3R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 06:09:46.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14276a32-71c5-4ec0-aa61-08d61df682d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 6ULZ processor is a high-performance, ultra
cost-efficient consumer Linux processor featuring an
advanced implementation of a single Arm® Cortex®-A7 core,
which operates at speeds up to 900 MHz.

This patch adds basic MSL support for i.MX6ULZ, the
i.MX6ULZ has same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6]
is to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means
i.MX6ULZ and 1'b0 means i.MX6ULL.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/anatop.c      | 20 ++++++++++++++++++++
 arch/arm/mach-imx/cpu.c         |  3 +++
 arch/arm/mach-imx/mach-imx6ul.c |  1 +
 arch/arm/mach-imx/mxc.h         |  7 +++++++
 arch/arm/mach-imx/pm-imx6.c     |  4 ++--
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 61f3d94..45d618a 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -31,6 +31,8 @@
 #define ANADIG_DIGPROG_IMX6SL	0x280
 #define ANADIG_DIGPROG_IMX7D	0x800
 
+#define SRC_SBMR2		0x1c
+
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
 #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
@@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
 		major_part = (digprog >> 8) & 0xf;
 		minor_part = digprog & 0xf;
 		revision = ((major_part + 1) << 4) | minor_part;
+
+		if ((digprog >> 16) == MXC_CPU_IMX6ULL) {
+			void __iomem *src_base;
+			u32 sbmr2;
+
+			np = of_find_compatible_node(NULL, NULL,
+						     "fsl,imx6ul-src");
+			src_base = of_iomap(np, 0);
+			WARN_ON(!src_base);
+			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
+			iounmap(src_base);
+
+			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
+			if (sbmr2 & (1 << 6)) {
+				digprog &= ~(0xff << 16);
+				digprog |= (MXC_CPU_IMX6ULZ << 16);
+			}
+		}
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index c6b1bf9..c73593e 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6ULL:
 		soc_id = "i.MX6ULL";
 		break;
+	case MXC_CPU_IMX6ULZ:
+		soc_id = "i.MX6ULZ";
+		break;
 	case MXC_CPU_IMX6SLL:
 		soc_id = "i.MX6SLL";
 		break;
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 6cb8a22..4ffe3c8 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -90,6 +90,7 @@ static void __init imx6ul_init_late(void)
 static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
 	"fsl,imx6ull",
+	"fsl,imx6ulz",
 	NULL,
 };
 
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 026e2ca..b130a53 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -40,6 +40,8 @@
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
 #define MXC_CPU_IMX6ULL		0x65
+/* virtual cpu id for i.mx6ulz */
+#define MXC_CPU_IMX6ULZ		0x6b
 #define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
 
@@ -80,6 +82,11 @@ static inline bool cpu_is_imx6ull(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
 }
 
+static inline bool cpu_is_imx6ulz(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULZ;
+}
+
 static inline bool cpu_is_imx6sll(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 529f4b5..87f45b9 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -313,7 +313,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -331,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4

