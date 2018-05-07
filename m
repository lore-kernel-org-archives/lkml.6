Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeEGQet (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:34:49 -0400
Received: from mail-he1eur01on0105.outbound.protection.outlook.com ([104.47.0.105]:10878
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752529AbeEGQek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:34:40 -0400
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
Subject: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to recover the contents of ONFI parameter
Date: Mon,  7 May 2018 09:34:15 -0700
Message-Id: <1525710855-8159-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: HE1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::22) To AM4PR07MB1603.eurprd07.prod.outlook.com
 (2603:10a6:200:25::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:AM4PR07MB1603;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1603;3:1Ki0qa52uwLbljrVaUzJMnjaE6VhR5VcCJzbW8xGY2mwRAkpGk3Dhj0dicm5ojZU3iyCNkuo4rqIgD1RCPb+g1lgQAg1hfC8WPfJ2i1CTA01tYudETTBzBwkQHt+J8wD7wwrm4wNGKXSCwh9X8q5R5GfBDiPiy+vG3ZZKYKhVYftTmYcBRIrFNZs0o80QPxu4vT8GvpIqwiwTzNcasC0vfupXhQN6LocIYWD/80QU3h3VjvvMpyCUtoTijN4dL5ci0vRRra6lEcdmq618tjJGtD1dH5tO5MV9bM4DYAAE5A=;25:s9UCLkPVHXUmUHsWELn1stjjeO4ztOApNLcURohjJ6JeSj/ksz3tCiE4EW89iskwaPKLm7wPSaRjGwp69ywCqHTPgLwtgEUCYyJ95h592dwYwuxEXv5fUX1qNNug8pXfLTOULnGdU+79APv1uzvsxiCA7b/O9pyDv6wKLBNCQrNoI8RnyY2z6CZdhy6tqlo5cqc4Byiys0avq+HG0PmWfOo0ovRVPDL4oz2vpJOikIgIkfzis2waMR/9Dtg6xQI5cj+x4PL+cxYRswTJO99SBBNpM7voBieTBYw5FssbiEOsVZx3WO1CfyKh0QEkVGoC0HIz0cR6zEYYs0bjOM7lEg==;31:0JDoWiPGd4hEApvuvu3iH/zPSq+bWIF7TwWK1nj9gHQABFjv6bxgZ2kvmPeXbZbpBT+yopq9/vYpm4MfaX0z5ZA5PjypraBAH3DY1epiM1YdEgiy6ETKYLEr7cjLCG97rY7ro1qFEysHe+wqWnA8oBOBwF050RtQJ7BVwEQ8TxXJMn2RZ592kSdB6mwbkMgi+JKl3ycMiMcrnSyLGM34fAD2SO8VBdoH6BsJmXfyBn0=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1603:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1603;20:TVv6op9SJjhDP+JK6fJpjGbD9yX8ggcj6Df8x/nKtstcVIaVBz+sp2WlvzAOyey1J3GKFiuU/kuv3PxrjuJ5t4EiD5/IxZLWnjuTNiEPf0c0LKhlVRVqTBEkXuUstSKABTXRhXCsC1tob0qmc/wUIydrICwRMcQJneNTHpYgHgGLnxQVf6J1oEJAR/VTn+tmh4+92LOUame5uVmv3yFUmbZjc8643U/3YhzBmgB1eQaIAx7cxUoIIgHJazOFE59mUpPXgj13+a1drrNVi03EGmZHW4uc4U+938RJZnK/nIsmZ+V7imV7wkC5XQSouPUOE7s2AcHZ/ftV4bkIfscQq6f0m7rPd108HBYA2LN9zE3gY/EutL3o3BcANjaSfq0i1jYWMQWfX1PySDVKh9kff8qbEwjBwarCZeGgGvYyIVn+4flxKHdLx37+2Br9qhT8L9QkwyxRS7ah/JMF6vQqXyXgGsFHIDXl7Gyx19/C9s9m4LF6rGOPNkdBjnHyJ6+i;4:qwuZcCe0dUgwiqitehaVaesVLaknuioqRMmnGxXXAB/z2wpbjJePUdlFSbbGuwTlvius5/vDsHfEJwlSasyZzLEbACSVe1yIlUHhXFgP50rY2JXCZOIoPszhL9d0ABo4yEx6buabQLLx8YcJdPB8dh6JufwUq2Xe5hDw/lZuOtATtFuDLBgaFv49XiweCjLWTtvScszSBaef5sY6GwLE3HCaVBfdTtf2NfXsPPDO6djHwvrzQI7p7wdkTg99ZfCL2SjsLt6Ql53O6SKxFvNjNRhKU7Yj/CTP7JXNGCcHntdzThROkr8UvILUxROxxWrmmFTfvmUV7NgWDlSvVTDb0geErjoMqyPpu1mW2eWeMWY=
X-Microsoft-Antispam-PRVS: <AM4PR07MB16034092E06DB9B284905135819B0@AM4PR07MB1603.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(806099)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM4PR07MB1603;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1603;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(25786009)(305945005)(5660300001)(26005)(186003)(16526019)(59450400001)(6506007)(386003)(7416002)(53936002)(478600001)(52116002)(36756003)(6486002)(66066001)(3846002)(6116002)(47776003)(8656006)(6512007)(51416003)(107886003)(68736007)(316002)(105586002)(106356001)(16586007)(86362001)(48376002)(39060400002)(4326008)(50466002)(97736004)(7736002)(2906002)(6666003)(4720700003)(8676002)(50226002)(2616005)(956004)(476003)(81166006)(8936002)(81156014)(486006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1603;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB1603;23:Fwd7Dpi5WxfL2MU2++vlnvMnDxoft49MgrzGppHBn?=
 =?us-ascii?Q?snpBZubJIfTCVQGb39RsceZAfA2ytv9/wFwO0lx2fw4cq4Adawv5x/iLsr6V?=
 =?us-ascii?Q?jeO6+S98a61XjyXW2aS5DVOIG849aCbL4b5aDCrn+d6JiYBMllUWoMVeRnNJ?=
 =?us-ascii?Q?qY0hSbRyCb+hdcpDIlPb92Pa/KkXPIvz47wIG38bBUQ0T8lM+v/3gqJVMH98?=
 =?us-ascii?Q?rAKcsxP5v2r8t1Mp/kg3TfGagS4euudS4ZTIR54cSkvFhnE40AIIGOwg37wh?=
 =?us-ascii?Q?446o3K/Md9sFHgoqTQeck48y1Yuk57XHxZ9etGacMvCDRKy6FnTs0T0Jdqaw?=
 =?us-ascii?Q?Dq3i1hIAP27HAybD9mQtHrPUZiwusBfB5052MwWi/DP09KhYoleGB+5KCDRc?=
 =?us-ascii?Q?5nOi9g6R5f+07Ts8D5zNamcaKvPlzm90Nh3EM8PuVjocOJqd2DeCUzDfr2O2?=
 =?us-ascii?Q?S+xLPcC5SAV0404SCsp0waorfLn/5lr5SscSHqprgDb8rILgPjIMN5E7QMtj?=
 =?us-ascii?Q?lLSIZDNwJ4bygkWe63O0/PeaKDTkjG+yQiLOKpX8LRX4AKaccZEls5cjDA0m?=
 =?us-ascii?Q?W4xGHWoc574R6LyH+z4Q2KjY0Fwf1iq/WmUAYhwVDHJDz3iaEsjCOG6bsbRt?=
 =?us-ascii?Q?xBGZHmwPZ1YCcqeElgkQ65S1JIMAWBXBlU4XbBFzAV5SxjNVSsUFDkrFIAq8?=
 =?us-ascii?Q?IZEWFGrSGZbAABl5uApgmGEu82bE7Me37nUU6hbUNopvUeU30ytfSnIBdraK?=
 =?us-ascii?Q?AHG114Sn2t9VhZY2GHIoHqC/DZRG0pOTFqgtRFv3vlxT0ZZK1m66O/xpUSka?=
 =?us-ascii?Q?WeDhdCDbja3KhLuVt3B9FSz43SMopKVsPzHEmIaUCRS6uVARkXQf023PcMez?=
 =?us-ascii?Q?U9Dgj+soVTsfB8WELomeF+SUNdr1jRuW1Ez0Mpn95XzPYds8Hi6aI6tYTOXW?=
 =?us-ascii?Q?6qkDrHQsypetRprsei3KA5d8G61r5A0+PqKEquyqKf7hrJCl75rkHOuoeMYO?=
 =?us-ascii?Q?O5sty2T3eigDQdhy6oBqwlmh1u8qY9BZBhIlWK3NL1T1QZMIb0xvAFR9t6n5?=
 =?us-ascii?Q?F0nhJx3nCxQqP6yAmDjW11Y2M7ZdDAgLWEym3nMkMgXijEImKOucRJYzGPMR?=
 =?us-ascii?Q?bRiAlEtZA1ljBwj57dXR3pMxldtS31eedr8BuaQMQiyXQ3JdE+aQV0+emXfd?=
 =?us-ascii?Q?xjyc/RWv4UT53o2R73CJomtsPkcVE34+Dei6aXJVKmu4DFFs55o71RTlVsVt?=
 =?us-ascii?Q?Ar9MPgMw6uVr8wNPuk/4JM2Q+dXacwJWrPstLef?=
X-Microsoft-Antispam-Message-Info: KPGuAUzrbpeixv77u8JHqE2Whjjrw0TwcmFCW5oLvwx4isMebIcqeWpKAEIULM20Eg22Woiycrr+0Iv4NBkqLx9BN+iH5RDos4BblTL9UK/CcVrgG6cBaxhgkRVu0q6Y7BQExHsycCQCo9+5tWR6WwjBVYRh2J0ZOQ8xP8+h7gfAjfzGRt9HlHJvvmMVdCsoGkGjaSRF7N8ONDOPEM48TXTQjT2b/N0Fsnyhg5qOvrU=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1603;6:MwD0jvwhv9uCfdc3MhKhZN4ps9alb0YbbhnnYaX07HE557oJiRsJ/D5/il0BcSZzVbjkoNQEOrP7Mwq95zXMSxsF3q2TJNNnrOfUEElw1CPsHkw3bkr6uHrsg+HmF8fkTZnhkOyUdRrjsEGBZPGFLJbyU1GOt1fXvGk7ju4XcpMZPudkApXR6KYhAMRBbAm0vMWAP7c0VB7MVjGVYxbvnspv0sVMXlmBdV+6M29+dHyOaBCpBgQi7por1iqI1C/Yjm92zRi3AqYU1K+IiSTjHznzU2GiwuLHN2CsgDCbEK+nIb2guPzd8f/oDLIGiknvR1rwhm4IGSBYv0BtTXWn4Rqud/a1jwxXXtNm9aO9tfWZ3P2eKuSQA4wzbCxu56Z9LPvP92V403+TG2MP4EqQejDSvgZraFKa32e/uieRVUycos3uYQ/EGuBcGuJ8Z5T4HyMqfN+0Hkihy7QOV0l2Hw==;5:uh4DzyNfxXRHE3lKdSPw2JVZ/Pg79riUePR/IZtsuuuAF8GNF+CBX4i9gW9Xe6/AI85a7HySOkSsRZ46cNMeC3Lvo1IvA89YA8JuXzXLqJ3JzL6m7KWGmF08SQdDNYWUUA6ZGDvokFCR6sTXC802x0gOwVTYTl1E2hHa7RLwp50=;24:6+dlamEtUjHGATmr/1yhhSS9TYAg6A/q8j3IFk1H1cf1YAgRqhhsvjlHn/tWF1kligsS/vK2PwiiCjcW7dII6eYUM81SRBmrfSBOHtjNzqM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1603;7:nu+LgsKqdbJDLNaU6/JoX7p4qk2ju/ZSlbiDeW8qlDWBIoDBqnNkbdfZKYauasnNG4aNlwtooTCk4T1ls6j1uyzSZhFR48tEB4CmIFSi8AgbZAuDgNUu1SfXTn7vl5v1j/R0hPFqUwWhW3NtnPIJbVVe568dfjNpPdWhEFLiTRkM+QOm2wzG/qs8TrAKQhjr6dBAGwQGl9UpcYbuyRMgPmJoWuP8AWZ0s05SXMJdfsOiIqmT9Kka19KK6f3OVHNU
X-MS-Office365-Filtering-Correlation-Id: 7a8d0ab5-78fc-4276-2e6a-08d5b4386c3b
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 16:34:33.1288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8d0ab5-78fc-4276-2e6a-08d5b4386c3b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1603
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/raw/nand_base.c |   41 ++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..48f2dec 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5086,15 +5086,18 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
 	return ret;
 }
 
+#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
  */
 static int nand_flash_detect_onfi(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct nand_onfi_params *p;
+	struct nand_onfi_params *p = NULL;
 	char id[4];
-	int i, ret, val;
+	int i, ret, val, pagesize;
+	u8 *buf = NULL;
 
 	/* Try ONFI for unknown chip or LP */
 	ret = nand_readid_op(chip, 0x20, id, sizeof(id));
@@ -5102,8 +5105,9 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		return 0;
 
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	pagesize = sizeof(*p);
+	buf = kzalloc((pagesize * 3), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	ret = nand_read_param_page_op(chip, 0, NULL, 0);
@@ -5113,7 +5117,8 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	}
 
 	for (i = 0; i < 3; i++) {
-		ret = nand_read_data_op(chip, p, sizeof(*p), true);
+		p = (struct nand_onfi_params *)&buf[i*pagesize];
+		ret = nand_read_data_op(chip, p, pagesize, true);
 		if (ret) {
 			ret = 0;
 			goto free_onfi_param_page;
@@ -5126,8 +5131,27 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	}
 
 	if (i == 3) {
-		pr_err("Could not find valid ONFI parameter page; aborting\n");
-		goto free_onfi_param_page;
+		int j, k, l;
+		u8 v, m;
+
+		pr_err("Could not find valid ONFI parameter page\n");
+		pr_info("Recover ONFI params with bit-wise majority\n");
+		for (j = 0; j < pagesize; j++) {
+			v = 0;
+			for (k = 0; k < 8; k++) {
+				m = 0;
+				for (l = 0; l < 3; l++)
+					m += GET_BIT(k, buf[l*pagesize + j]);
+				if (m > 1)
+					v |= BIT(k);
+			}
+			((u8 *)p)[j] = v;
+		}
+		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
 
 	/* Check version */
@@ -5220,7 +5244,8 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 	       sizeof(p->vendor));
 
 free_onfi_param_page:
-	kfree(p);
+	if (buf != NULL)
+		kfree(buf);
 	return ret;
 }
 
-- 
1.7.9.5
