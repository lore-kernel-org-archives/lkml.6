Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeEHVU5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:20:57 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:14240
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932460AbeEHVUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:20:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
From: Jane Wan <Jane.Wan@nokia.com>
To: Boris.Brezillon@bootlin.com, miquel.raynal@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        marek.vasut@gmail.com, yamada.masahiro@socionext.com,
        prabhakar.kushwaha@nxp.com, shawnguo@kernel.org,
        jagdish.gediya@nxp.com, shreeya.patel23498@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ties.bos@nokia.com, Jane Wan <Jane.Wan@nokia.com>
Subject: [PATCH v4 2/2] mtd: rawnand: use bit-wise majority to recover the contents of ONFI parameter
Date: Tue,  8 May 2018 14:19:54 -0700
Message-Id: <1525814394-30067-2-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
References: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: VI1PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:803:64::26) To VI1PR07MB1614.eurprd07.prod.outlook.com
 (2a01:111:e400:c546::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:VI1PR07MB1614;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;3:2BAE5R2XrOwY9bIiKQNDES/eue4KfDHKz4HgpkA64dWSmdpz2h5NpnA78mqa7STu7w+VfwBeFQH7P5bSwtos7QptNYWHt7YXFeD3sXWAL91/5u9DQLvMBXkvcdyN/C1mysA2Ej9hfCFWg1dmUx3Hg/Ld/S6ptmqkPAaZyD5FylkemK9M3X0hwIIUkhKUy0Q6skScV1vj9KcZtpV98xvCrc9D2zT8gPvswxsbziVmga5mBgRfsSgMe3kxEiU6/fi48snW1YZq8aJcRgurQKB3dN23+3956PS0MC60nu+17Ik=;25:6PObiia03BU2uJFqsZJBT99n0gfZZ/BKpnW26gokV+qW7V/kEkh+NT1b6APWr13lk3CVhXeC0SvgjHPQBQf1ncBszKeeD17pOLgKKKX6PS/KOIH3mJWiO81H1PUftjqSetahamiYoEkhm7Loz4AxV0Mx2uv1MlbzxZr1fl7rpnT3+4X084FVygtRvvqSnkBHACfV4QJKd9NVHKZ8Y+TQ/ldSe9MnWJbe+MHIx5IbnsAG0RuHpFeGQ3BfPjOcCf85rej3LVG2IyWMNNzSogL96/LfQ9CU1hnh0CFUqsX1TMf0rpnEeh9w7d/jKfgIabZXHTv0eN5CvW5QJ/hXrwn09w==;31:dV8vzIrFsjVnx3Dyt52bsej2GgZEEGYP+NPbsF6vm4uiGGr2XPzN++TRtcoSFxW7BrfFER5kOzyT+UYh3ZcMTuPrVgvtJoZOGNHzxlfZnd1+g/eVuU2EIxI8yv1L/09bf0i1Vx/0B4S6yyLbqG+YK2XbrGETs6SM/nQQQEd7/snKrKV2f2Ehu+vzh/PxhQRJQI6bW3ELvgl5K4SbfnAIjjTcbG8uGGql8ip2pgYjK3E=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1614:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;20:uHKmWS22Hg3vHlOUcXAhMqgw3vyvKe0uYX+3n8bvjsx7kGdRgRhv+MCGpEBXFZ7jg2clbzk4nOnN0zXGhvay9eV8sZDM2rkzbYx2LwXDByCJnewkVEDx8e3Ic0IJ9AagV1ektT32IUumSfdn1GOzBeqm0ai3fjQoIp+xlxMZK4Pje9H73VJyP3e5As6KsmY1xEtedUhvALqBOGgVQ2igilyWSqILatV2al9tRCElyi2AAiNI/fjFvquweDfXWwZUABWvALkyjO9PWZ8zm5ktSwqfC+GLA+oxIx5Gkng5e3GDyvWEpCrxwBwlHgQQmCUs4Yfa8p5o73zINDrM61xUMEJ8nyo2cvA5eeb1bUai7cgzH1Z0VDAxZdeFHvvpIJ8saLNkOvz3dYfQCg9j1HtJdjKnNnmCt+vX4bPfNQgvjsVt8L+EBIRyBkqu5i0/z3IKaHRZBMhWmr/EbCSYuBQDzOn6O93KsszeEam5DaHzQkG2l8YAwhO1Xw2IAZfnyeVQ;4:FA/BcBk4iSkms3CYiAJ+vujgqxUGnq69lYBGk3E2v6A3kFeDDzvjYi/eAsp+GzFUrl9S/W2kzj2lMhcEX3jMkdL/QduO9awBNzj4M+pjI9cZr0UzeLqbmRAbF7cwrcpqlh5W1GHPYhig9ghMVxOubg1rbpfOiC6n0nDDyDHEPIELojVyqdgV/CiQT01qAvmZ3f0KHuCw1GBpmBU42K8pdG85cM+seFgxIuKir5g5/nWdc+PUGW5MqDZoWS4Wy7YbtFAPtA/YcKX9H7hEN5rueOBgL6cjK6bLzFMrxNoTLpreNIB+gec9uIYb1FnGiW92nFqjmPm7PaT83EMKymM4Qjk2M7oUyjmvvNlQPSEA924=
X-Microsoft-Antispam-PRVS: <VI1PR07MB1614E4A934BE17B9CEE5B516819A0@VI1PR07MB1614.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1614;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(81166006)(8676002)(81156014)(446003)(66066001)(47776003)(7736002)(68736007)(6512007)(486006)(476003)(956004)(97736004)(8936002)(25786009)(11346002)(50226002)(305945005)(2616005)(186003)(8656006)(4326008)(50466002)(53936002)(51416003)(86362001)(39060400002)(52116002)(2906002)(59450400001)(26005)(6506007)(36756003)(16526019)(386003)(6666003)(48376002)(6486002)(76176011)(6116002)(5660300001)(4720700003)(316002)(107886003)(105586002)(3846002)(16586007)(106356001)(478600001)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1614;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1614;23:1jcIS2QGobGtrvl8NrtXburd/L3D4ZiXBlZw3WEj4?=
 =?us-ascii?Q?ErD8yAd1/7gvZwNN5ZmvP9rVze16W8yeVYkKK92ASTEirOBcOMFjt+nL6gB0?=
 =?us-ascii?Q?ngnu4XzbWV1Drdb2d/GeVmjrQcyTEqP3PHHMirbQ0kXUzrp7EYKSHa0J3o3Q?=
 =?us-ascii?Q?ddSlVGvroRDS4Qu4lfClNNqA4aVY9xONn2ZUr1XmBl4DboyLtlRP9X17PKaN?=
 =?us-ascii?Q?k+3SGGWvnkdgqXbqycjdW82aRuwCcRpQGioLrN0GsSGCBftPcyk000C7sI4O?=
 =?us-ascii?Q?nudlcZ05ycTiTFd4ii1vV/GMO5KgxgNIlIbBTKbm7+V9Q9Pofa+70kAwVJO6?=
 =?us-ascii?Q?0COFzZ+ixi8PP7paKXDOgovKUqaNQwZFPKqHk2PNm2e7GAhYq4yaUi6t0jgL?=
 =?us-ascii?Q?B8HVUIVN8Rsb9MTiOE/XWeDmkGynzj0UObhuAClB/qXaHF5g6PZCWXLjlwTR?=
 =?us-ascii?Q?tz1laJPKM1P0DdsHIo04TxqXkkyW8ccmT8j1bJFxnFb//jji3ivVYDwYc1V4?=
 =?us-ascii?Q?LG3a3nShzbzSzmZP5hAd7Z8D6ANLfLVAj63/UpBbXDGOAb8GetV7YyhlAdYI?=
 =?us-ascii?Q?WOMWfPspkWkUd5dOxTR/Kjpw3QetjlbXoTCmtyRhXS1BeHwUm3+fYgV0+PAk?=
 =?us-ascii?Q?F27oNkVuIv1o/YHgj0bwedJGU644mEHYmm2Wq5vLadQVzZa/2bDMmwBl7iVs?=
 =?us-ascii?Q?qaSeDgW4zrDKwg/hyvFSB4ibDxS1sQ5EE7hVW6FvpAzYXl2Mgpi9gu+uuYin?=
 =?us-ascii?Q?cBcO9FpoSCMx86QEjzngivn4jI0HlHN82sLsoq2VTa2tPWzakC7XlzTlZK77?=
 =?us-ascii?Q?MIstVysR6Ee0/MNkMJ5cQZVahhXMC0PokJdDASE4EIH2PazcZrozr4BaC6Hp?=
 =?us-ascii?Q?lqqIrQ5lYigZRveVaL1EMS4a0Wzl85kuwO0uoWu7zo1236/SdSpDmtbepaB/?=
 =?us-ascii?Q?9NGBpxLQKDKkulhHgf5nfMmzXY4nB4sN9MzAA73FYbiW49Tz6ys8uQ6RMm/W?=
 =?us-ascii?Q?LDUU5ur72r6tSN8WANdOuUhvjg8B6tkKJ6hWG1Ajl9ilb9zShIMRe4ZVW6HN?=
 =?us-ascii?Q?w6hZF6MTeHb4xooTKGhike/Z1C0EVu66XAQ49qGVa6lrnA5CS8ClHuLwODJp?=
 =?us-ascii?Q?SrDo8MqR6aG+jEiGNCGsMsjYRGbZjBVWCn3D1YXtn4rAKHkUipfVM32Mz86z?=
 =?us-ascii?Q?M9aEnmAlKZZOEiWGZNrbD+j6gpgrPT4FxSPr4woeAAhIFkcQhhAfBKyMPt9/?=
 =?us-ascii?Q?Qmood/xr2OzMehrhJIDvDPpHNq0f4h+yer4LEhp1HJTuUG/hci8Sqx8TmsJC?=
 =?us-ascii?Q?KE5PZ1mJn4Sm3WqOZzlCG9dBtPVVHUPmAd47ufcvV7o?=
X-Microsoft-Antispam-Message-Info: S641d9ko0kXSNa98K2B+V2SxaavXpSM1GeZv6DNIdJ8LBx1wGripzkdeJ/IpLCdLMLI2eFGynHsLEHZ3RHPC8eK/hwUfVVhrbSewz+Q6MwJ3iF3azNLLe/fzDzUnxq0/wCd/zRLX57SJjaZNnpupnVpxdlcXz8TN1mBPfuKV0V3gkPpbv5jYQ3W3Z6V1q4ygoIJRRVxTOvJyqMJgqyVqVGCXgT/MSRp+0acTT6egyDc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;6:eGRHe9TuJUqeIiUsea/zFudWksRXhY5Eaf+7t/79mAXijrjMWEg2yaSrHLAFBX2VHCMfo5QsA/glS1kT0m48ykvw4hxF11aAIXXi9DePUEEK07dBDOl0GqGOKVujLW8EMvu3l68RdAxgqAdwtMC16WSIspY4M1lJAWfiZCrmSsgDh168jjP6Fu7Pqf0GtTfz6RFmSNzIOeXCFkj0HfkAg7924LVE8V+a1Ex3PZ1xeiSeAYKpjIDshfaY4PWGTVU0uYynGBC4Dgb+o5MKA1XFthlvnYX93xP9U10q6BhB9bMjercKBkc5yhvITS/kgcSEYP1XUq17mpBvry1vyiy7P+jYPO3WTQL7elrhxj1McXoqQlzxGQG3Wiw5NPR7Sr299mfUFCtmdNXs6penZelGSYPGoLQilQY99X4srnfJet8x8Zic6ODoqW7A3zhUKGxAWI2IntbnPQ7p6ediWxBfRQ==;5:RtIimFMQQ6nV1xEV/Cst7ftlrlshGanncb7uEdeFzrehYO2afHj3XiEV316v/0QbUR85Xuma8Ho5G8Abr0Foo4oKNpetM5l3EQNyN8ZqNiTbmOaap4Ypu1XY3LDdAvSwil27wfWr3vAnNJCpjNuD7y/eIsKyp5016fqUPd0L3O8=;24:EvDwQc0rdG7gEH/Dw6zeke4GGG2LuqOkca+1X28/UCVsv8PXxF2LOwILO8EXhpxHK4FE484Bv10PdiRyRP1XuuRwXbZkwc22DTrXs5fd6Bk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;7:y2JrTmWJ/CF5PLxxM2mmo5YNr0NU5DzAQcbrYwPiDq+caO8ZpYxAW1hx6RCa/jjQFu3zHGlH+SkHNyVEgECXGTlNbTt7x0h0ilC/jvy6Ko8MRy+wv9jprPKJQEAKRytKLZmgLQo0mYSCldOGf0eRHzY3bP8R91k9ibPiCuYIw7qGPLUrx6DDVcnPO4ERPgA9IoVyWCN6Yb/9RyVcZozZPmuEDLZQlPCMGL9dYq36if4/0E6Yn0LniGndktbi7/9g
X-MS-Office365-Filtering-Correlation-Id: 2e74da2b-04a1-41c0-3b3d-08d5b5298fce
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 21:20:42.4203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e74da2b-04a1-41c0-3b3d-08d5b5298fce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1614
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/raw/nand_base.c |   49 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..dfc341c 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5086,6 +5086,38 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 	return ret;
 }
 
+#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
+
+/*
+ * Recover NAND parameter page with bit-wise majority
+ */
+static int onfi_recover_param(struct nand_onfi_params *p, int pages)
+{
+	int i, j, k;
+	u8 v, m;
+	u8 *buf;
+
+	buf = (u8 *)p;
+	for (i = 0; i < sizeof(*p); i++) {
+		v = 0;
+		for (j = 0; j < 8; j++) {
+			m = 0;
+			for (k = 0; k < pages; k++)
+				m += GET_BIT(j, buf[k*sizeof(*p) + i]);
+			if (m > pages/2)
+				v |= BIT(j);
+		}
+		((u8 *)p)[i] = v;
+	}
+
+	if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) ==
+			le16_to_cpu(p->crc)) {
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
@@ -5102,7 +5134,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		return 0;
 
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -5113,21 +5145,28 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	}
 
 	for (i = 0; i < 3; i++) {
-		ret = nand_read_data_op(chip, p, sizeof(*p), true);
+		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
 		if (ret) {
 			ret = 0;
 			goto free_onfi_param_page;
 		}
 
-		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
 				le16_to_cpu(p->crc)) {
+			if (i)
+				memcpy(p, &p[i], sizeof(*p));
 			break;
 		}
 	}
 
 	if (i == 3) {
-		pr_err("Could not find valid ONFI parameter page; aborting\n");
-		goto free_onfi_param_page;
+		pr_err("Could not find valid ONFI parameter page\n");
+		pr_info("Recover ONFI params with bit-wise majority\n");
+		ret = onfi_recover_param(p, 3);
+		if (ret == 0) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
 
 	/* Check version */
-- 
1.7.9.5
