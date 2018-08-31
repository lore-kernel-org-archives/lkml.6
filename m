Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97924C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2664120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wM1oDeWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2664120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHaIz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:55:28 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:60361
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbeHaIz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/thw4qAY2AosM13kzicMCmSaCF3HITh68iWufgkEdI=;
 b=wM1oDeWpI2KA+tmR0etAQXxl6wZ0DKQGn//wSfhAdHLvkxKW/wW0Z7eFnphxQINu9EXz67MDVcW/xEznJUM2c2I3MPmbBEqMqPc1Dc2ecnDFN2NtsyQG1HL9iQFP3EAxQrKWb9//E+JUodfFynWfMLFzB6ifisBHtLu7i2i0Jxg=
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (2603:10a6:208:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.18; Fri, 31 Aug 2018 04:49:41 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V6 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Date:   Fri, 31 Aug 2018 12:45:56 +0800
Message-Id: <1535690756-22234-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:203:52::25) To AM0PR04MB4212.eurprd04.prod.outlook.com
 (2603:10a6:208:66::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51cb1034-2ed8-4d1d-0b8c-08d60efd2ccc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;3:QRWF8apf5hmSrsxuxtXue1I/3gou4De+oFd+AXm6e72BrXgIO4CZE0cdcCxDQauQ8RHhBFZLNmSnmuJBPhXCM0iKNtp56qWMmC9wiTUKc3wPvV45Y+c9nfauDV2kEzwvwYSTpIOHNUztJVFxAobk6Cvi606IxL8NMuMBHQMYamrouCTnCp/BoV2gHq/duBXElTKfb6bsnI0w2ziwcvmqcVTw0VrFiyGXvDzwaQe2AQ0X1r4kgAb4LwjsTlKaXaDv;25:CG4TFYjWXiLTFC3mGtfF+3vkl9ET2bOwh+QnuQw3B4oxLB2C2p9DiW4mzhFiY3yZXwjJemxVQj+z411LO979lXzmksW5pjhn6iR3IRlA14VVxt1746qTwJsgqPvq5fY+FjYXi2s72IOfiyJvBrFl5WUs9THjpGTfaua243zFtezsaLL1dRMCbwngCsU0dWv/fOAnFO6JnQ5+KJLH9d17mhJaa6zmFOvAXIWeRSF3+hF/GXSHebxS0Z61fFGxwILynTnRQSuUP+6n8F617I1ak7uyIQckaOLc2wgE/yqL6S95y0D1Pak7lLmEXUe3YRDrhlGI2YCLb5RRR/1l7nifjQ==;31:f/MAVp8MkwA4jB33q4ccrax8jnLxC/yUlGoV7hUP+Uf4CLwHBRAyCfB5OtYJzoQBopX4Ia/DYCKiLyAaXi9ECn/mbi59xn4sNB0sK7Z5wfGJlg/p5JmBTDEbV7lJjnZJXn1lOVWfTDoVPfZTE9TBTw4OGcds5b2dIS4uPc7LFyKtnZXArUD0HPEv01Uib6nxVgc1Yixnt8oyjDSdzGa1xTi9Du3O/C+PE861jCeZicE=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4212:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;20:TomZHKkKvdnkWzE4+oTmu2AJpfBjBmKm7m76guknwUjfmxJYlSAaVu4NTFWhGZyBhPD7Xtj6VL3CtJ4WFHAeCI/x77UIH2cY2gW/HWxkOBf2nCYZfBhxD1pCJuCoGG8a78MeGhhNrdURWWz8Zqe6UVyd7OgBSgWxz7sRxEvLqzghzQ6c4N7hC58Qtc1oEmdWYLDwygIGLlCqTSBwQlQxBcUDUThUuEUs7GKtUkL5cLFcynARZufcY+68Jqk+9A1q7KGJhfhe3m7nsIoMebBMOwnHHv8zkI5zTN+RMpF8UexUY1DCxtFPJbIS2GBQpJrIrmBuk1EMHVS900PeDiTzfM/6U1OX4AGrRdTzDRPX5wCX2l0QgQlEAHAQk57/K6lswZgf/4tfUIx7avgwPEVh3lvIiZPMX9TaTIkRf4o0XolZI6yzgS1817h5R2WuLyoiuPNXZ4CKBrNMlC08FDYIqLKs9k1o4O27mfC2ppupagb5h2IW4SdJuEiY7ac/izgr;4:YOwUo0OrAcESSPTR7rjwsNoQuw/jvhFH7eMDVL9Lx2KQVnPgTG2X+3jmYsBfmgy1XI8lxZNuXLjnIR3oq7nF6DiHFnTU9pLpiB3w6EKBXazCR5YGhR954YiFrq6qsyLRmVnARjqEcYo/otyZYaHeu3z7UYUpiBcw1rwbpAcYVKr2zlU33A17TfsfbyyQ4151L/UWqVQVjYpEQIDAhILdT6hMhxOO3k8OggND0+gTnEXh02gDAE0SRag3wi/euFMM6rG06DjtsEDkVX0JEK3lbLYa5u2uY7Sv7foCNEUQeWKrwZsrygtkTlXGSpHxw/kNroVffR2fxjDWL1vczm+FQb2dRa6waQa3kuVoqG18zqAAmVzoKovthgf5zSPsbzshJw/iuy/l0GkFr912qjG8mGTTkWUMwSSfzrAxxZmjcOQ=
X-Microsoft-Antispam-PRVS: <AM0PR04MB42120BF92F8E6FC381013ED5800F0@AM0PR04MB4212.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(7411616537696)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(5660300001)(26005)(52116002)(186003)(47776003)(16526019)(2351001)(2906002)(6666003)(386003)(6506007)(51416003)(76176011)(446003)(11346002)(53936002)(2616005)(105586002)(14444005)(486006)(25786009)(4326008)(6512007)(476003)(956004)(36756003)(66066001)(478600001)(86362001)(6486002)(106356001)(316002)(16586007)(6116002)(3846002)(50466002)(54906003)(2361001)(81156014)(48376002)(7736002)(97736004)(305945005)(50226002)(7416002)(81166006)(6916009)(8936002)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4212;23:FeVLEhCyKmhSKBWuhpnnrQXGR0L8ev3ihhUzgkilZ?=
 =?us-ascii?Q?j4oMwDngjYDgAd7K/85a+pDK5rd5fxbw/p0qR995REj8TOjjkIST0Yp7EbzR?=
 =?us-ascii?Q?ZU5G3RyPksI6EEdlegxdlbzfJg1LI7fYy5Z26MGxpC7YNFat1u74lE916x0m?=
 =?us-ascii?Q?WcPwgwyRgqgIpkL4zyxQrwjolzN2UIPrs158eeCspSVn6CUKTymASeHRbX8d?=
 =?us-ascii?Q?lw9qu15Nxvi+odTjk2pv+ufTOZHNArk+2/pAQfG22G4U88WvIhUnmxyuKHl3?=
 =?us-ascii?Q?sur5sUs2qBAOUmGxuikSGY46iE+G9NCJrg4Q4wpHpOqrEFIUVTDpkvur1y1P?=
 =?us-ascii?Q?YRT3rcytU8qcSmpFzbXVmn3OV8WrlRFeJj+sVrUeDlIAxx12OmfsDe4L6UW1?=
 =?us-ascii?Q?aNUy8g5za3poaj8vixwz4oIct31nvgL76esE2Lpo6v3XeQrBZ9iCk+pWHQzG?=
 =?us-ascii?Q?JZ0r7vBSgIrkUjLZ00VGFFJeZMByRtRGzcm4FVyOdLM1IG+VE+cB8LsSlRlC?=
 =?us-ascii?Q?rSmYMX66gnwp5/Dc7Ax60BMO9QdI98/+/pzQA4HoCso7nxhRvWOQQLaKZglK?=
 =?us-ascii?Q?XrXxgqTzLeCcajpJMxxcks9yYpPcqmBursycUWyOJ+mJJ85GA2GxQXisOkrE?=
 =?us-ascii?Q?GIIF6naZHGC2tQpK/vyizTrCQEdlXRc/tjIwPPnn9WbokTfnpJe8NGSvwfYS?=
 =?us-ascii?Q?tWsSAjFdPSSghp54vLs8Duhk+JAFrqc3hhw1y9vAASv2ef0UJKsFjQnalBW1?=
 =?us-ascii?Q?J18N1RumsPdoEBOb7Um3Bjqsbquev/EnJ/nmxitsxMznblYAEc39t8TPKH4H?=
 =?us-ascii?Q?BYfysAYLGQxpOCBc1VbrlFGID4XRCg7PtRuMhPIblJg8+TROpyqeUJHYWX/a?=
 =?us-ascii?Q?+HpPb9iS3IGYMTAsac3jxtZh8fdbWy4zyWfQAvWWwAo+4mc7ipPGggDirkv/?=
 =?us-ascii?Q?SErAHlR5NvzguuF0RARCHvcQAZAprCIv02EQ1A64cspaQ5iB5kK36P9zgxpK?=
 =?us-ascii?Q?qjTuyZDOE4lTTxXlBQNMwwzLtWuQONx2iZE6TKyBr5ed2GxT9udGxtwB1zTo?=
 =?us-ascii?Q?MPjEb4wWSsAy0eMWZUUxOQkqPhGSLWLQmb2CT4Pg9OoNm7ycH2ekP8VzPif/?=
 =?us-ascii?Q?Gx6o1ur6kyGAeNupm/u8re8/bjT/2EvIsZNNcIIovFw+iGDBgt7yfiFEAWsu?=
 =?us-ascii?Q?Qa56OFrNuXXDpV9qwCLVDm0IubR3+A0rO8aX11qetHazdKU3YweMosUf3TYA?=
 =?us-ascii?Q?IfpOxujud+3Al//Slt6wYeNZ3kyTkIzunKC1FIH?=
X-Microsoft-Antispam-Message-Info: 9nSI9o68Vr9hYDNNnLRLQRAO64Lkn/W4kPt/usULx1jKdPUt+BPlTXXzOkulgAgYSb9EvJOupjkge2rOAoROIY3rB/HQVrKAKk2cbmHVEVl9oV+5xSMyKbU7Bnzni7+G8WSDHtp7C5AM4qgdycOheU0aRKq7UqvO4UYFaMRffuKmtanYq+Ocu+d52KFDcgcvp6/rRmqSikK8Z92hYA4rtxZowSHI+oIqc14OcmskYBcC+wNHBjyvHti21lyu4bmD5oaplYdW/KHI9UCwQxYL9pIO7z8DaREAoDRt/rgKQKR/G4raNDirU3ucvk7Sjm0cMqQ3gCdZvjMvx3JjBjxEsJ+85G107o+a+2+ExkGDZlg=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;6:VC+Hy7KeIVSolMnOFY/gWiLwpVPpXYMrj6ZFCzATuZ8cwZR0/ZGDPCxt1+K2bVUbu18EXAGe7ucKFxnDgk64QZ0ET4dK0LnPDcFsjx3CcfXawOnlH3ZTQtIor3aFjtMCtwwBnhu301ybq5qJIkviJbAgBqtNnzTFwy82+14F9UonLfiwhPrs4GHmmMBxvElTDNhe1j97xj/onG8vyjePc2Y2bKl1+qp1HyRROWwm5DmlXGlaX2khhPzknAGvxq3fLHEMa+4ZF+63rcN8SNq3YHJ5cWRY9AMbIqMqgb5ZLN6vtj0yM4K4XCmG8oJbunMsKEgAC6lVRNyTe/f+QBWEnkXSEbpxj+oiMZkybJt9UwJCX3yqz23o/Bt6eNXHR4cpu3hhA+sIqV/Gok2oVJ92hlMzSIOB9sJmVcNF3kUYkPlRU6GWlW1zvVAbHqu7VlXLJY3DsYUsYrOYZ4yvdP9oVQ==;5:f7HGsfMZFDeRnLKTxjOccr1QzJ/YJgEDRvGpnB8f/FKd5/vZ+23mf8olJQnlSFwj951G+D4uz12ZpZN4Zf+jx2tJPecbrbx/OA5TTpQnB4ttJx4CRz/wH3jRjAzISXU8L0liteqWHut87PO2ixX+rv6nigzw1bm0gZKaXxgxixE=;7:juwRRjZAUti8HvgVO03vlOOmatnx+WTMLxYk2B4T8wTNaGzyz+s+r+rwjbAbyT+uocglj1ZBW24t76dfrsPj097egfCAvJamdfmjz2PU7Hddyv5u1mkj8qi+oORYJ4fjXhaA6fjqJSozAQ7vvrtpWfFT2YB5zefe/nUAymoZ4L2JiM+eWCOM4+iDPZfPO06Mw9KYwHU6Ayzket0WTV6YuqhRKb6V5eTc0MTusC/5f4YVi1qc4OZkjzWJf3urgFhw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 04:49:41.9182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cb1034-2ed8-4d1d-0b8c-08d60efd2ccc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to use clk_bulk API to simplify clock operations.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v5->v6:
 * address Hans's comments
v4->v5:
 * fix wrong setting of par->clks_enabled
v3->v4:
 * no changes
v2->v3:
 * fix a build warning on x86 platform due to a wrong
   of the prototype of simplefb_clocks_enable
v1->v2:
 * switch to clk_bulk_get_all from of_clk_bulk_get_all
---
 drivers/video/fbdev/simplefb.c | 72 +++++++++++-------------------------------
 1 file changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 9a9d748..89fb1e7 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -181,8 +181,8 @@ struct simplefb_par {
 	u32 palette[PSEUDO_PALETTE_SIZE];
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
 	bool clks_enabled;
-	unsigned int clk_count;
-	struct clk **clks;
+	int clk_count;
+	struct clk_bulk_data *clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 	bool regulators_enabled;
@@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 			       struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clock;
-	int i;
 
 	if (dev_get_platdata(&pdev->dev) || !np)
 		return 0;
 
-	par->clk_count = of_clk_get_parent_count(np);
-	if (!par->clk_count)
-		return 0;
-
-	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
-	if (!par->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < par->clk_count; i++) {
-		clock = of_clk_get(np, i);
-		if (IS_ERR(clock)) {
-			if (PTR_ERR(clock) == -EPROBE_DEFER) {
-				while (--i >= 0) {
-					if (par->clks[i])
-						clk_put(par->clks[i]);
-				}
-				kfree(par->clks);
-				return -EPROBE_DEFER;
-			}
-			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
-				__func__, i, PTR_ERR(clock));
-			continue;
-		}
-		par->clks[i] = clock;
-	}
+	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
+	if (par->clk_count == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -252,39 +228,27 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 static void simplefb_clocks_enable(struct simplefb_par *par,
 				   struct platform_device *pdev)
 {
-	int i, ret;
+	int ret;
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			ret = clk_prepare_enable(par->clks[i]);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"%s: failed to enable clock %d: %d\n",
-					__func__, i, ret);
-				clk_put(par->clks[i]);
-				par->clks[i] = NULL;
-			}
-		}
-	}
-	par->clks_enabled = true;
+	if (par->clk_count <= 0)
+		return;
+
+	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to enable clocks\n");
+	else
+		par->clks_enabled = true;
 }
 
 static void simplefb_clocks_destroy(struct simplefb_par *par)
 {
-	int i;
-
-	if (!par->clks)
+	if (par->clk_count <= 0)
 		return;
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
-			clk_put(par->clks[i]);
-		}
-	}
+	if (par->clks_enabled)
+		clk_bulk_disable_unprepare(par->clk_count, par->clks);
 
-	kfree(par->clks);
+	clk_bulk_put_all(par->clk_count, par->clks);
 }
 #else
 static int simplefb_clocks_get(struct simplefb_par *par,
-- 
2.7.4

