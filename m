Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756505AbeEJCrL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:47:11 -0400
Received: from mail-db5eur01on0119.outbound.protection.outlook.com ([104.47.2.119]:61946
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756351AbeEJCrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:47:09 -0400
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
Subject: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover the contents of ONFI parameter
Date: Wed,  9 May 2018 19:46:40 -0700
Message-Id: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: HE1PR0102CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::18) To DB5PR07MB1606.eurprd07.prod.outlook.com
 (2603:10a6:0:11::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:DB5PR07MB1606;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1606;3:Gt0uiHCBoMSD5/TYBQIBuW4KRCCcFv67Cdc7PBxNMIJ7QzgqMvcjTCDmuLatAAz3UXK1zKqeF7gR0yEJhpUhL+o7ihSgH2zsjceEmUPjUrK32mRkU8VICBsk4gKxvr+wWR7fnexpPrL1Jtc7CA3uI7BRGdtI4nD700rk+H5srEML0FnMCE02stTLYlwRkrvKGlcLE62n5ot+EM46um60KdWAWbqTYOXjRxf4KqIb7r16umY9Cn3eV3OPb2L36F2VvhYlPGB4cuuAF6QQweCzQ004xbRiPwDeGmZoKbRh/AU=;25:9QPOjqzOITz43/DbCzPRot2fXK7b+bJnGGkOTYR+s9E54+nfX1XKHeY4Ra/b5ORljCVG5Qnfp039fFcjStPUFXQBCcLs9L01NLGUS+yZXjR1hho+lMeMb1y09I2jfo4UBJQmFYYQQKyj6hciTy2FdL4hPWzqn99fvTvyVRHJ5dOKDSHyOUkxVlRGPBZBl6of9BuY+8KzgmuU7eGlyxoj9Mrt6A2gJjCU3GFHSR6a4cSzfPZM0h5MKkfiDYiDcd/xKOSSqPfSDYm868Zwz4J7FxZGYVPppvSju77SaWDtnUs/b4SeVRWNQiBaVZwE+8Y3yk/ttoa6qcJMyc941lvCVQ==;31:gfUt7/Ve0e6f1hVk6g39bCwU/Fg7XiblQ7YPV2UztFMpWmhAi2DV9sD3AcwX4yjjZd9OIaSFH8gDTJcJ/2788Qh7hsXddvhLWcRzU9itEIV7sBmbCmw4PXjZOwrM+sTBFL1eKPTzoZQyRuUOnVupx5gxNPZB/7af6VgGwAJGN2eYedZ4gkcJ0fTFzV6wRTi5jsGvC9VwSbG6rJPFQQuqqltZpUu+RhrbXWXTTKLW/Y0=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1606:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1606;20:VBOMxNPIJ89WoQCvleQF5d5oPTZVAuTaeF11fhMjpFU8D0XO2Qb+lZXh0ft+VKHEcoSSthHWzX1UuEMj2FvD1OSfFn3RSweMtA6Hfc8yStmPkX6/1zbeK6VSCFl2fXL7A+jfZJzp0Vne2Z2m3QWwhGTqUYGD7+bpNvHtL5imnGNQ2UBeZPe5NoiGG3G5sHKaNvNso9HQ1jHnanMhfiAk1UfZ392SumvPcqIS7h47nR1M/D+LXgHENFs7Ww08Hdlw6qXXa1kA9ZRmovZ+bnYt7ij284jSqvq5rNP0Y9s8AHVQnLtAdvq1K5YKPG8rR+3dC6nWVfDTojFZ1eGVhOxML1R9ECT+PrJoWpSie9gHp4oyOVa74qP2Hov7pwqgtQQJK4NDLqz2fxGDm7V0NvHHFUOAR9Nwq4g9DnQlFNfjI+nRtt8bD4/A6bcaOebzfcJ/a4kORmZccM8nD1dwfvsaVTUtoVvyyNCcdVblSucP/KKPJgFwGQI/OsJdJnpIhcte;4:NCcJVYAI8RF23S16dOcvMoUAUn03amfarPNtYveOdl576aw/anS36oYg98bWQ3EsIfc2UDfDkgHIcbRffbcuknXnvOPxDsfgjeIZrceHPiaPx+I6s4LojI13jLBgFHyuNWyusBD3KCGSCycAd3ICFBmlRobSZyKroEyc4eoE4FdYiDnW2y2WOeImBbXjJvT/SZdVc2/V1RPdq1fMCgOcpJIhPvQ9qYsmbDrK4kAlpokHG/H0olnGCh6B/4K59FGPvZ1lHu6PpMi7X5H78FAIxm84vDzIAjqwjFONLRuqV0t6tFkFEeauJQbNiZfDDMD/C+XQ4oAG2Z8w9s5vbNlQueJWJH8MBNNvicfIKWRwZ8U=
X-Microsoft-Antispam-PRVS: <DB5PR07MB1606F6C33F6D1BEBD3A498EC81980@DB5PR07MB1606.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR07MB1606;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1606;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(86362001)(7416002)(16586007)(316002)(386003)(8656006)(2906002)(6666003)(59450400001)(6486002)(47776003)(51416003)(16526019)(106356001)(105586002)(52116002)(4720700003)(186003)(26005)(5660300001)(486006)(476003)(50226002)(3846002)(6506007)(25786009)(68736007)(97736004)(36756003)(2616005)(305945005)(956004)(478600001)(6512007)(53936002)(8936002)(39060400002)(81166006)(4326008)(81156014)(7736002)(50466002)(107886003)(8676002)(48376002)(66066001)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1606;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1606;23:/0rHBUywdJzgEoDiT0zYiINeImXOfGf4n27VB7g6o?=
 =?us-ascii?Q?ns4YaAITHF59jlu203UTLczICzBoCKOMG6pKcLCUSi9wyac9lrAqNjc5TLfX?=
 =?us-ascii?Q?DsqnelmPF/X/NYtHh5YnjnU6QV48nOmplPC0aOqV+XMY4TJPSNSDKD3iJFMV?=
 =?us-ascii?Q?Qu9UvN9EmgUqi5emwx9bzLWZXzrXst4ypmKaa4fxyL1SyeS3fz3P0ZQq08WD?=
 =?us-ascii?Q?tcXIi+fpkyIqjPA7Rvxc/EbDX9ovmRLmj50RpdCLzGKM6S6Q+L/BhTF8pU56?=
 =?us-ascii?Q?5AoAk5hPjxB0048+g2XSbIByO21FGq5Xe3z0bOIJ0dg4rle7Xq/nI6NyJ05a?=
 =?us-ascii?Q?kZgEcju8th4YZWdb8Q4cIRpDB47sMd+WEdhqxILG2zqru2FfkHwmUJvGakS/?=
 =?us-ascii?Q?UwoiCa0ZEeOorBCjjfPwg1tr/zEmfo7XeFhYIxM7Ik9uVb7XAxXNv4Xfoh54?=
 =?us-ascii?Q?Bk0Fq+2rbo+SdwHnQ8Iiy9dUmET5LQDPj4s0J6LE0/UnuO7JF4SaiNXU3JQj?=
 =?us-ascii?Q?nai+979+TW0jqN2lkvoJ2Ayxz8jxb8z/9keyTWtCIZ3pAjRNzg+qjRZ1EXnK?=
 =?us-ascii?Q?3IE+AkSHtwpJV80ldg01Y3ZuQY4ZPq+B24LYtLlFQFuGWpRJLz1OSDpa2AGh?=
 =?us-ascii?Q?C0GbpQc0oY8PSfP1FqTqDO66QBCXkgJwqAgnLrPKOL1LpEmosXGPGThm7cYq?=
 =?us-ascii?Q?jH98NmSI8tvheF+5o0ptMCoLHvZh1AU/6L3Wtsvb+3F+tqg1bL/kBmqIhs9i?=
 =?us-ascii?Q?P1sHKfXrPblNw99BxDm2pwbPT4JPk6PjFZiOICokXlVVzQbxp+RWUcTsG5tF?=
 =?us-ascii?Q?XFpemf8DQQsqjdEHjfXoYI7q7KTK4DYLh+H53k4Kgr8REtw5TZCMia1l80Q5?=
 =?us-ascii?Q?oS9G6RhD/49+/e/YFc24EoqQ+PqHfJtNlw0df8xAMiwkSubUoav1M8xyg0OV?=
 =?us-ascii?Q?uVdU5GU3m0DABnnUpXVPKA0WoFbUICuYFL4HiPKZDeW5Br/sadJPt2PNLeLG?=
 =?us-ascii?Q?JAPlmcKT33vD4Suj9RBSd0Q/5Kb9vwqBQd3XVgiD/Jooz+NyqiTbhzf16eI2?=
 =?us-ascii?Q?NfioOLNeAdhf/VcXne6fEWRHjB2GbQwpB6v8C3ZSq7avJ7Yrxta7PN/ax9R/?=
 =?us-ascii?Q?hwKbQ+Yeby09tfGJDMmuXBYp4Ws+jLPXopIzx2hm63trS7B81ghiq/3ZbQUq?=
 =?us-ascii?Q?t5r8XBjOVtSOsjA7WbXy6h78krcENLrxVIBCd7Gv2OjMIfpeQMPFi5+axeA6?=
 =?us-ascii?Q?q4lDS6PkV6Pw7HQY6jPq2DLAvFuL/Sk7vnarHPe?=
X-Microsoft-Antispam-Message-Info: QWHaqaRVM4AOWKGJpcniz8E1ppQbYktWjIGLfwnrjcyucx7qDh7eMIe/W0z/jj2tzQZ02PjKwgpjhoaEsJu2uv+agAJqtX1/0SteUevG/255UXGG8zl3UNEIeL2N4QgMAohoPLQe76wiRCGes2vlxz6B4vt9ET06M3kY0XFCnvA9KnSlMxSJR6sHohu9k1jvWCJo55MVQ/qogJXdoMMrZvQIjKxVAPfed9vuNMn1BOk=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1606;6:F0O/SKQISu8aMakvRiFJXV+bnc77kVL+lBdTTD8jDrQE8eTYkF4/yFWmxRDHS/fXrziGq6akmg9N9k6eVZtP+EbCzjQ75cHMeEk2FpPh3JG2L/IbDAWyhNl767r+jDLQ/OEYSQKOzL21PY9MXSOTsxt6+obwwDqJapM7AGzWwUJzxzCZmwTV3g/shME2eFzdmfK3mrULpqATSbqvGUQUz7jvaCmjttAYRPdbMiypeTzTiBiXsVN8l5PT9M29f1d7O6Xmz3ixPW8o4lu1jDv0+tKs++MeD6+Xrc3JlV5oyRaV6FFIEqX1UJSWqBAKlYsBZi9xJvMFalHzhcii9u6G/lRgl3P26AT7+JJWGl8gnsD7bNHWatCfcClvIGsn1M0UgOyvBZrzjZ2YUsxeVK2bz1JeOlks1uw+1vIkkRX9whxLw4ia1kicnTKYMxaT7KZvd9TMWIS2IvXQlrMOBGqNFw==;5:WRLmEZLDLGdgUN/ECcXH+O/2WCb20+ntSbypScq8BQm4dHJYGwojn1n4/Xs42LRvYpRBYdsCPhfoTjiLsRC6DAezK8iaVbJ86+BoFjqnMAnnxNuBR5D20XXOgGccdyKJneiLE+IEzYGiZpHLB10X+p/Z5p39fJ9YY8KT33JOrCE=;24:u+BQkuh7dZ1y/IGEB/Q8w8fz3sbNGYsusIS3iybkfsEdSTBxMtILHU6djfmTwzOEl3Bk7QuCO0w4QB9QSzUhlLv0ovLJBhK7ugNVtwdWvZ0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1606;7:2bGm0bQeUO2DSr1EdONtaSra8QqWwg2cKLfE5DvfBzxTHsEHjwJ0BqTgcpmzesACGu4CNXwUJk2DkpdTa5j4gSs6+gGW5X+G+1vLWXkW1K4GRv2MbAXaq4G3Q5Qs0lBtI/VSYM0UlVgbDlqGlhOoknlHegH6Fj4BZPi4FvIobrWCXeThDD4qCVpneHUO+5+tdpGEkLhQDopLyUez8V+L00wCCiCUoZ+Opi0R78duFPWkNDmMVwgqyB7+aSL8zSNY
X-MS-Office365-Filtering-Correlation-Id: d1d305a8-5e57-45ca-0678-08d5b6205161
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 02:47:02.2375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d305a8-5e57-45ca-0678-08d5b6205161
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1606
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/raw/nand_base.c |   46 +++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..a7c2507 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5086,6 +5086,34 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 	return ret;
 }
 
+#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
+
+/*
+ * Recover data with bit-wise majority
+ */
+static void nand_bit_wise_majority(const void **srcbufs,
+				   void *dstbuf,
+				   unsigned int nbufs,
+				   unsigned int bufsize)
+{
+	int i, j, k;
+	u8 v, m;
+	u8 *p;
+
+	p = *(u8 **)srcbufs;
+	for (i = 0; i < bufsize; i++) {
+		v = 0;
+		for (j = 0; j < 8; j++) {
+			m = 0;
+			for (k = 0; k < nbufs; k++)
+				m += GET_BIT(j, p[k*bufsize + i]);
+			if (m > nbufs/2)
+				v |= BIT(j);
+		}
+		((u8 *)dstbuf)[i] = v;
+	}
+}
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
@@ -5102,7 +5130,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		return 0;
 
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -5113,21 +5141,29 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
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
+		nand_bit_wise_majority((const void **)&p, p, 3, sizeof(*p));
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
 
 	/* Check version */
-- 
1.7.9.5
