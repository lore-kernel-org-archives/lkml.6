Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeEJV3D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:29:03 -0400
Received: from mail-he1eur01on0131.outbound.protection.outlook.com ([104.47.0.131]:36644
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752416AbeEJV3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:29:01 -0400
From: Jane Wan <Jane.Wan@nokia.com>
To: Boris.Brezillon@bootlin.com, miquel.raynal@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        marek.vasut@gmail.com, yamada.masahiro@socionext.com,
        prabhakar.kushwaha@nxp.com, shawnguo@kernel.org,
        jagdish.gediya@nxp.com, shreeya.patel23498@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ties.bos@nokia.com, Jane Wan <Jane.Wan@nokia.com>
Subject: [PATCH v6] mtd: rawnand: use bit-wise majority to recover the contents of ONFI parameter
Date: Thu, 10 May 2018 14:28:37 -0700
Message-Id: <1525987717-31675-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: HE1PR0802CA0023.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::33) To AM4PR07MB1601.eurprd07.prod.outlook.com
 (2603:10a6:200:25::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:AM4PR07MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1601;3:+rQirc/sjs7UbTthQSu7/G4M09bMwQNwIVDcM/mNcgbNiFBYOunv4vILAB2XE29S5a9dTIJdRrQ4CYXFBA1hZOBYYsVzzVWNLBde3EprkKHXThh2W/ZVduBgZU/gLrF6Z7pQBUrfenjWuWfPSohpRDCRug1NFd7QBQyNsRk4I68iWrxJQfs4F3j4799ckopheV6V06ELBIAD+VhzQUbEj1hDpZNkfOY9oceICqY9Eo1Km8jg0bRaub0oC8ND1PxocGCjRdwQZUFKGgl8eRoRTSMknP614wltccLKWl8kWaA=;25:hZCXJ8Wn5/nUTThdbhMkW2Ejol6oePVJk2n6q5O3dU/psQIxOVrA5Z58oHDoGDqdmM8EEk4NGckshYXDI3GiwEB0HIHfHupVufLSRHxbQyiHXAX3xge793c9qDnV7SAVHZvtFJ2CdhZ0jkOmsy/qb/A7fq0nSHc36E9R1PD9plgKyjwoqTnrjGJCT5GNaBOpNqPOXea0hAazsMhdVE/7uuc5VUvOJvYxc/edMbaL/g86GPiRs9jRq1FPLLQb5NJykCdRV+rXV3jVpx7Z1vgCD3sTLLCyA7sLmWWfiyCaOKuUMaDb+DCXYvX46y+zhoANyCP3jYThNcj7F13AcAC15g==;31:cFSmjQLld832Nk9zaXzrR9JpgJYbOOe7tJJuXLKExDMoCxUnxjYaLroNq3g23qvwppM9lzcnnGNHra4YsKMN+C45XDK8GjUteSLYqXluMODPoaa/0wuV9YFTcEi+13m/4gM8PjtdIZ1tQHObw5KycXiDRaLWWdtjRqpshuI4tJa5sYkZvwjk6FidMsBbwK4zw8CwPZNVFsOTt8SjsoGgnfCFUPDQ5HaaCiyvreBVmgU=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1601;20:bpzaDQrfbSbMBnr+j9tNC/HiAieDBpDXYHXWa319GUIXBGRlL6iDR52LqWXssMg9SCpZ6R1g3u9XyeuUPdfPgsWjIbfFkB4GjCMYKzE466xRf0aoeMTgDH94pj43K1hVoReCSb8OhmTPYyOsWCw9ApshqdzqSDnq3m3ztwB0Ckgvk/ZfPzxp1f2+JM144DlrGmDb7WJWyikvIUpQEzDNWAyHFGiGkR6XC0a2QZXEzi7XsJ0YpmlSWLLj8W+eeuomhog5ZnpYhp4z8AavzlJu5TMoSJVHTq0Ee6G1+V9OzEi9UTvFmkuv14SAUhurq3sDHJLEJmSKAtsT61snR17iZ6bXaCA+NpvRSss1pg3G+75GWHLeS9rsrNWyCCBMTmtwtdTObpcxQt8SJY4SRJJZFU3T6a0Sm+g68mXWV8pmFU59kocMwKbs64LBMB+9Dt/pJriBM0ciWPXlvHTI9cuwISaAPDGoZbLNoPveDfyYvVxnE7eRfPhyjwZXiWStNDD9;4:G3kvOaRNdV8jsaTpWbmLf0acJqERfe1ksw4wdkZ+L5bpus7ka6PDbjjrQvSNFRgNRhFHXsbu3qXTnG9TeqjZuNddSfNQThlBq8vQ2cpSuIGIwrLWT4gJnXMKZBHVaYeGJOWah91zhL3NVlICNIMyhynQJLUy0MI0OWeKHYKtlV6KAJCBunN9b2yIQJurEXjLSPvmVHiT305O+Bgkkfomq9wqZwnyQXXHcWrvIRd/l0WRTKZwCAZgmQ0/uBdIzbvopO5LmGNpdBFHY6blO2SSW+UthGPcKGhjSXFBkQXZhj3UkCPUMYuXrepQccKShVk+1nTpcIdbilhyzt63FqT/dN8R1tMGCj/Xu4MeyigkAtk=
X-Microsoft-Antispam-PRVS: <AM4PR07MB160140F030E5B2F27464162781980@AM4PR07MB1601.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR07MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1601;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(366004)(346002)(396003)(189003)(199004)(105586002)(86362001)(47776003)(386003)(66066001)(26005)(51416003)(6506007)(48376002)(305945005)(7416002)(2906002)(50466002)(3846002)(52116002)(106356001)(8656006)(486006)(59450400001)(6346003)(316002)(68736007)(6116002)(7736002)(956004)(97736004)(81166006)(107886003)(4326008)(53936002)(39060400002)(8676002)(6512007)(8936002)(25786009)(50226002)(478600001)(4720700003)(5660300001)(36756003)(16526019)(81156014)(186003)(16586007)(476003)(2616005)(6666003)(6486002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1601;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB1601;23:w8Q1/kD1pIUxyOuYmM52zkLudeOlkJ78e6OxkF7CU?=
 =?us-ascii?Q?1M3ePDsBdaPyyExueNT48El/AZYKJvFcbTAj6mdOb+X4rJ5RHfT5UiLYcCBo?=
 =?us-ascii?Q?gm5SguMtFhWDsvnTLsP85wcKd8TOgs9CnNorp0POPlLupel/M7hfkGv4foWn?=
 =?us-ascii?Q?cNnGQ3KKkqu63xDS4RUIrTkMzIcuSqLIl0492ui14lcPA3Xk/3fPWSLGxDtC?=
 =?us-ascii?Q?3UIYdPlLpVJ4TmYEsfCBvcAhs7NnITJMJaRb92plxkuz5uFuiBNLwx0g8a/X?=
 =?us-ascii?Q?tgrTRVwOptS251jLAYWKfAbyrBIlFkcOlveUfczsAKkQzBmWwKspxvx+PJnP?=
 =?us-ascii?Q?oZ51oSe6IzOaXGhLjLSJIKIp3x8DJeOk0q72vA51lIhlkZYE9pGNi4g6tMeH?=
 =?us-ascii?Q?6Km43462wjzD+vLwDnC9v7QtHqjq7pg30km1f52C8ggjRlEfe58rGwfA4uz1?=
 =?us-ascii?Q?A6LL8vLxEfYMC5BYtBu/abI7cR2TXg4ou/NqsW23mfXr9g9mh5GEhkE5SnKj?=
 =?us-ascii?Q?RpR/zo0eQv72g0GWfzU3hYGJX1MYqB60g4Fmw3iuWmOMxcm1RXhszssRISgc?=
 =?us-ascii?Q?gYQyK9qgj/jc0sEXjzaaURSqexXI8jCHxfe7+/FPiZ3P9dbmtD7k1UApL+Wy?=
 =?us-ascii?Q?0x0n88+oG6jlIp9ApGwHEG1OYHeeoOYqDm/ATfujQovbj0P3GC3i0lkh70NE?=
 =?us-ascii?Q?2jGEGY2L/vfmqj/nNNjUPV49USS/rJXZz15illDW5QFW2AwoTHhOZ5iP2mFM?=
 =?us-ascii?Q?864UVTmnCfl2adfoAmmbjgBB1fl4w4D8dXo4rg3Nk0zIxe8uz18pIB0u0td7?=
 =?us-ascii?Q?9tor/zy22xqn8jv5/tKxpXd2ewPUb3X/yIdio6hxOuMXw9d1+RPHZQalxlZe?=
 =?us-ascii?Q?BmfZU0Hha737VI2zz7mAZfoF9hojyQffbgif+he3oqNM0WhWQSqgqH9dRQbP?=
 =?us-ascii?Q?kl9QcWkpLK6202wStCX327ybZSpU1257Gp/6svwoUsrFbHna/jHnvLb5s9Be?=
 =?us-ascii?Q?WrLxj6JtblIag0eZXjaxMtBmkETu34uX6HWWEjzTa+F6esdSOd554F6Yc8k5?=
 =?us-ascii?Q?L/O7VtI+Jd/izAMHiOYJmZOPHQsdURg3UfQiP5FCqjum3Dh7S62PgPzkSqps?=
 =?us-ascii?Q?q/JZnHzwfTmue5u1v1WjWGmw1+ccsJXbILSswLjSSXt1zdGNloE6h4eoFgoJ?=
 =?us-ascii?Q?nUIaz83C8RbIapp++Byc/gk00p+JMdT10vQ2SCT+rxgPEkAngr+p8pxRv3Mi?=
 =?us-ascii?Q?NkrYZzEXMMlizR/UewmsJWZk8Woayc6todh61DWhSbRMTewBP7ZOojooV/g2?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 7F/I7flatsz370JOKNcgYNEO4wk3fB9H7yqRAGEJA/DefZJu5vD32ce7spXPpIB2cKrUlU33DGnBL6a/ZLhkHpY50SbjRMhAPrurTwYyEWtoAVF5+LNJrzj/HxDTVGwSQj6lIfJ90q8Qud3P+CT6IWuNxzgXM+SS6HSYzDrIpLs1v0Vos9pvjMEUU/pxgF8uFRrXSq+E7ZFD7yYB0IIoWL496cIl0TumFAK2Bqw2Hf8=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1601;6:0A5izozw7T3v7o+e16xqFLe82Z2/yE3ytR65cuN4k3WkDY5H27SUrQhxtzojZThC1bzGpHi7bfeNcc4dE+PZ5Es/lPUap6ig1bW6Tl8Fb7XwRD0GB3O6nDFb57h20DksEd32ud1Jfm82uLDjtPWLPgY2t9cnFpXeuYn+a3FFGRdFFqVHmEPZiGCCuW9LIm4iZPmeWmLGs92Vcpymo8w4I07hZmq2SyuUJimx1Bl+9nBTrozLpK4sGRMiocamS/GlkiYTAIksARuBpHIpOlGvG6/VgIS/sx1KvD5PD7rPfuzcx1YC5x2D9BnCgYqx/1YQz7UYIf8BxcCEvwnqJNhNlS5XBGJziWzoyOKSAmL7pN6SbGsOFMOA+eeX2mmtWCIQAGIUg3lZsTBJBmn5lizVQYJ7VIJtgYwgZ5nWIfkcykqWCmtYxW85LuKt0vUG37Q29cKTi87lk3zCLIB2wUc2ZA==;5:xu2PsQ84VRWMLjJzIqn5VEMZ9gi+mXJYr+GZ9ZlK1VtHPbV+iLnK//L4Zp/Vms9yIdUFqyMcuVmDIkd0num4vqRcWxFVCHeYH+VwL6eWu5X4/1GOS/3YYBr2u+KQXP65b+mxIp45I+UyW9s+sz8jb/rmankasSsvOOavz3aIClM=;24:Dy63Ojc6l5nZwfMPIbse2iJnR7ddg0y97CY6bUSKXDjMJYyzGTJMI9eY74Ri/1LOui3EAORZg5qbY2FwMasFPaPb2AX4sqE06GTgWmp3aOw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1601;7:P3JeT3F+PZSdeO5FwcpGl73Hrq49V8H5Dpbzg76Gnx/DSr8+H9eCvFwn4B5MufBI9LQ8nWzCX7vCUF847+Mv56ju0rbtr9q8PJBwD1vCbdYjKPlXv14QH7MZo1j2VDCDw/qSXlptLvjyqT4dv4yOMlaY8rS1dad/Znctwcc9IISTKA80y5kA4m0fyOtdtYeml2nlx3oNOoDVBQuRky/t1F9bF7oy/EckIkX8wkwsDOsejxQT51HLP+CiOBy2lEIn
X-MS-Office365-Filtering-Correlation-Id: 1df9c17d-83a3-453b-7e52-08d5b6bd09f2
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 21:28:53.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df9c17d-83a3-453b-7e52-08d5b6bd09f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1601
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
v6: support the cases that srcbufs are not contiguous
v5: make the bit-wise majority functon generic
v4: move the bit-wise majority code in a separate function
v3: fix warning message detected by kbuild test robot
v2: rebase the changes on top of v4.17-rc1

 drivers/mtd/nand/raw/nand_base.c |   52 ++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..acf905c 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5087,6 +5087,35 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 }
 
 /*
+ * Recover data with bit-wise majority
+ */
+static void nand_bit_wise_majority(const void **srcbufs,
+				   unsigned int nsrcbufs,
+				   void *dstbuf,
+				   unsigned int bufsize)
+{
+	int i, j, k;
+
+	for (i = 0; i < bufsize; i++) {
+		u8 cnt, val;
+
+		val = 0;
+		for (j = 0; j < 8; j++) {
+			cnt = 0;
+			for (k = 0; k < nsrcbufs; k++) {
+				const u8 *srcbuf = srcbufs[k];
+
+				if (srcbuf[i] & BIT(j))
+					cnt++;
+			}
+			if (cnt > nsrcbufs / 2)
+				val |= BIT(j);
+		}
+		((u8 *)dstbuf)[i] = val;
+	}
+}
+
+/*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
 static int nand_flash_detect_onfi(struct nand_chip *chip)
@@ -5102,7 +5131,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		return 0;
 
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -5113,21 +5142,34 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
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
+		const void *srcbufs[3] = {p, p + 1, p + 2};
+
+		pr_err("Could not find valid ONFI parameter page\n");
+		pr_info("Recover ONFI params with bit-wise majority\n");
+
+		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
+				       sizeof(*p));
+
+		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
 
 	/* Check version */
-- 
1.7.9.5
