Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeEHVUg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:20:36 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com ([40.107.5.127]:19200
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932133AbeEHVUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:20:32 -0400
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
Subject: [PATCH v4 1/2] mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages
Date: Tue,  8 May 2018 14:19:53 -0700
Message-Id: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: VI1PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:803:64::26) To VI1PR07MB1614.eurprd07.prod.outlook.com
 (2a01:111:e400:c546::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:VI1PR07MB1614;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;3:kxfOVSHhIf53pl+HIhk8PMlfA3ip6Waxl/5TYg3/9Er+WwCB6ZokHKJjw+/zsqZgjWh3Qwnv++403gh7NZPqLpxkALjvbI6oOvPYiO3htl/Pdhbz+e/0y4tKKyjwQ4x/tH5iMWd/93fOtwV9ngCDtB5GpCfgZr1bJFyBt/XG9dl3qL8LCTqhVEpCCoxdtiqBMxlK1Hz2DjY2usrGgu8uY5qg0yRo2ebx62su7Qc5B1MKH4V8YfylLhfrKw5ohAeYbiTQtO2OEZncUlFewQdcTKtHScP/nmjogmc/yJ1mDdk=;25:usb0OBhdtLQpc3YUR029KwXruwlytnwUFlXncn5kmWHFhyPuATZKWQgE2lAabxMZgLxNcbvrbMwAm179e1o6rcBnvbs7m9455l33Vi3EXYFUOrtA8DHg4i0eUS18S+zVmfaNSdIe7LgjgAt2ikoKdDfbqFP5pNTM842KVbJUcSy+AxUuBAirkRynVXCQOGUblokyQtgNfwHZHyPsovTuLh5NqO7VEf1/znPkCJEH7lz5CXB/X+smV7S+Qej3VeLv8KqF4kDn/AlY/VlS0J/uK3TylHooXtynqv206+sB8QHcrkYxgjdQ2vAlIdKaB5PMF+TFn1UNuhAuDTpyj+utbA==;31:WpVXkX4yAwhwo2t3dL/RsHXB0SIg9YO0eJo7i04YTT46GiQQIJISS6Zlvx4ab395kVj4lzQJvuouDLVwXPhIk2U/gMqVq6+EjdJwu+zId3Q5gjq+t6TaszPaxdk1LW/R1FSThfbSPuR1a2x4pGspPz5vQQsXpRvdtZBGDf2G2thzmPsbt3HSUuGqkwTf0N31XXg2rMDslfZsl8tjsN1+bDL6UPjIAI/eO+FZ1myvJT0=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1614:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;20:YG1mPjBaU3sLNcJQbdnR6PDVhBAFlaJwwHZFVZt7ElKpugpYafIM6w53bF3W2a0xz2MfdWaYHpXWd8pJiInGMhh9no4NO9hFELUoGWGa4ahbrJ1c/ot6iYnW5UFL6fyRM79ETGJmkYgGw+Oa33bFWBcmixhwMRhg1tiRfFYF2fsMd/GblpFh9lcs9c6bQKxRVpeBHFTlBI2azD1nmb8D1gZkXiluNCxWNday8EpeVO/xYupvs2JJdDitPnv5IvZpgruDjdCxWwGddGjGpPvxP5TKvBHXXMQbWNFSNLeMF2WD3x0iAkI5mfXwyZqOoZe/TOR0eV8/FIMedx4Lk+xxoLd0M+u/Dw0lnk7ZwET2GAQjbNeG5wY15FPnapCxkIDZm/2rYLV885KLbXkXFSyRZbWZXd4S5Y1Xub1LqyqnvsBemfaAOYKtZPNCSZJIrHBp5KobCfj2XrZyu8FLOfZj69oCxkTGi+aROdQiCqwpu/baeiMw9EuSuS62ytgPz0xG;4:yTxvB6Gx2GpmzEhGvKTvBTS+Ud2DNXKzCTy+vohFkgvdOe/aYwgohK/jZAUIEaTRvvdhi2MrcEvr/U1vnsNwGRwEI3RpRf9pZ5n5a9BK0wKnVSwTJAmXyxx6maRpKnTsRS6gojbbJpyAlNt9gn8/b3PE6IsONuu01lXcrkBxDwV2TsZ5TsRyso56oZjh7k9va19phMVSMfRJIAhw3+xY8d+D2rX2H8dce+DnTGe0QV5DtyxcNW8+NvCqcrmZgHz7s3TSiAqab3G+TRxDtV79H7CLlpIGTjjYpOjx9C+BDLNbFNFNPF7KE5auXS1oulbjFXC1EZa6LsYsVnrBu3xARkd0bSLU9QCf/oQccle7VEI=
X-Microsoft-Antispam-PRVS: <VI1PR07MB1614598418C55AF80CA071DE819A0@VI1PR07MB1614.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1614;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(81166006)(8676002)(81156014)(66066001)(47776003)(7736002)(68736007)(6512007)(486006)(476003)(956004)(97736004)(8936002)(25786009)(50226002)(305945005)(2616005)(186003)(8656006)(4326008)(50466002)(53936002)(51416003)(86362001)(39060400002)(52116002)(2906002)(26005)(6506007)(36756003)(16526019)(386003)(6666003)(48376002)(6486002)(6116002)(5660300001)(4720700003)(316002)(107886003)(105586002)(3846002)(16586007)(106356001)(478600001)(7416002)(921003)(1121003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1614;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1614;23:eVDuXgoOT62Qigui0T2HSTlzkN4iyGJeyB66Ytol+?=
 =?us-ascii?Q?Inx5c83aqRBTEUnrYOreJ7VuRI0XwGIlj10BprCilG6RFNONsYRfg/5C6pOn?=
 =?us-ascii?Q?J0fobe0pDcKoRObmbcCKKobTXjq+3yZ57XrRbl90OWuwhSepgvABJfqVefcq?=
 =?us-ascii?Q?6Sv+5BC8DyIYd+ZLJvkogu7g16Ret83tdiZbxfNBJHhsXtIaUMExVI2ZiNvi?=
 =?us-ascii?Q?/nepoivukBs8p6HEueuPH06L2JEp40Ftza4pKoqmSO4zeHI67Dqa3w7KsKd8?=
 =?us-ascii?Q?E139T0OwZfqo2hVfdckimil5Mc1n1j8z3CbbUBUUWdFOe6Xs4H96S2rJsTDi?=
 =?us-ascii?Q?3vBZZjvLwodHAssuR8/AueMnhCTjy3GoRVKqsYEFXX50xrRzzGQhFNRq42qn?=
 =?us-ascii?Q?qjSDbl9PU5DIZq1cbH8X3Zl2SaYx/1FqC0ewkCanU7HNkAPOCkNR1KmSfQ5A?=
 =?us-ascii?Q?qocx2q4piHyp7yaZIgwfsO471OVEix/buufk+n6sf2l4Lj2aUrVRNdP5el7v?=
 =?us-ascii?Q?Hymw9WKJZTPb9sGUydLiyQNmmNUpA/KPgyZXQTrHkNk8BGCMt11uPKFAmMjx?=
 =?us-ascii?Q?It8guTQGVnRfcON9Del74hVvsLHYH1LdIzDj+TE9Cak66kfmY33aT6bcS1Ep?=
 =?us-ascii?Q?HCU19JroXW5DrOWoEUkkJlEUH/VpqYzJ9pf5Xp438Dv7Htd1bAOUCMkSnuUV?=
 =?us-ascii?Q?Xd63dWPap+YNIsO53mjO0dNvQOx+h/PBofa7irRaV5Hq1RWkLWjKmzqDikN5?=
 =?us-ascii?Q?qPojcz+sJjKipCMTcLvZkjXYLXjBYEAXLm8AEkmsITuYLOpCDBIkNmyjh1ad?=
 =?us-ascii?Q?y4oTp/7rDACI+mwW1kQ1uOe9kIs3DEYIUBZKXh6QojxQPv4sH/GDUyaCYMxV?=
 =?us-ascii?Q?ZKzJbHKSsSYRyWRJMtGzWshIXcPn8pB2EcFxRfEmBDX3dHw9I9RtfKnG5o8O?=
 =?us-ascii?Q?/xE8zsds9lYR20pGg4PNMC7FPf72dQAWYkynJA1ws/yJmC8FWlBGFPCyN7mB?=
 =?us-ascii?Q?nSOIeTvqduq6n4qjasgufLMQT6l5ojzinN8Wp687cI29oJP92LfT1pGm+udN?=
 =?us-ascii?Q?KfMkBUiow0b2QNLD/kM7+TRKg0vQyd/IuZ0iYC+TU7mWfOP462lfbNI9ssLe?=
 =?us-ascii?Q?Tma1m7IZ9RZq/A+XH3VqIiprPCDYZicsU0CkUUYmsnr6ZJWCh2i7w/qXqyUV?=
 =?us-ascii?Q?BpuUC83yZHaooka2p8CZ2zgpSrpoEK5Uohxc1Y+ASAL2PlYbWPaues7MrOYw?=
 =?us-ascii?Q?M4hosXvmHyb+jvFKL1eQKC9x2jQmt0YeQhD3TeB?=
X-Microsoft-Antispam-Message-Info: s7DHC70Ym4rpvovFlpTK7Bf8TR5DiFaQBB1aOU+k/IXNz40eMigxrA3uF//aEKd31Od4/ISBSuANzBAWxkpIwMzumfYnPVTxU1QLSXtzXq+YhmMWxWk7J8vj7DUIMSwvi5WpqK+alEFXMWeRf/2GMCPn1O9xradYRC8UHNBAFpVWGhlLKN0PakOSuHcfhnycpqkCN5g1N/R7yqqI4yxOitMMWmjB4yWNfw8T0HoowJs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;6:MkaL5/6xgKM9kKJqDRg3zSlf+PBrGRpxgBADwMTRys/BO8LYhuxMTWxuYij673oJiUdNPEVHd9pSPI/Atxc9rxQg4aSuvvvmb8KfJML2nmRSrvZPJDGpD/ZmT376JHYzxKaP/yJKoFNT9xNFYASmmsR9+asr8ZXBAk3xHRlw6a3Ai3G/pQLEyy354MhYW7EMaXcT3TzlXF8LMXhuulYLidiw6eFmup/NnVwnuTNDPBevNTnbREtlduoZN6VnzCHtHk4bR1i8XFZBC34X/S7qkHgZrKuLdjC1TdLS9drLzGz1qNohKF5QuatEWbOMx6f2doCUYhqYoiaeWdVbVn48uBMARQ09p0qj1QewF2/3KHsaaqpOcEzlrEA1wSkBBFNiKVxxskXGUUYG12sGwmNZlXQ8DMczC29P6qIJgA+hKKyfFzmOcY42U4Au8//uemtQDCvo/WtnmySRFaTzIcO/FQ==;5:3GgtIJ9Wyn8hkMC2JjnuEPRLAauB0Rdk59LVMRrsNI278cdQ4+miPtcLn16wIGFxGeqbs5qnCRpoofu4yrfuptGXldC/lwWSlZvw2a98iPkwJDgyH8TwXsqvI9K5NCzZnrF3RqAL9KQSwIBtRJo2IqhQS5l9urMRRGyh/rwr7n8=;24:f7pPcC7dXzWnxs4Qt9vfHs7MVOuhCkdaM52UIHUFNQrnvzf3fe+WU54NqyoGu9bUkJkDIyIgWIuXGNhxZJFCeHJQ7w5TMQseu8jQAf6xj2Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1614;7:JT1C8DzZVo2DMIHa5V6UUm9fSter9RAqH9TdVxOqZW47v7mWlLeF/tbPM65Z6Gft/sNV38qMTTIXZIsqAoLi5isq2hx6ovC8bgEwUBJPuVw3G93mMMts110NxwIWBBBWG2TqPd1Kn5rjp8JPV5rH7Zlt/k+0hJ+BvgUYGUqaG+W9XYl93OZYlpCX8O8ImV21rUQ/EC5X8UuNWBYozlNcIFflG/d55i4ZfWvycpn9upsZ1AMl8BpNzhqxCvi+BNxb
X-MS-Office365-Filtering-Correlation-Id: 443c2511-3fee-49a3-d38e-08d5b529859c
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 21:20:25.3463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443c2511-3fee-49a3-d38e-08d5b529859c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1614
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ONFI specification (Rev. 4.0), if the CRC of the first parameter page
read is not valid, the host should read redundant parameter page copies.
Fix FSL NAND driver to read the two redundant copies which are mandatory
in the specification.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 61aae02..98aac1f 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -342,9 +342,16 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	case NAND_CMD_READID:
 	case NAND_CMD_PARAM: {
+		/*
+		 * For READID, read 8 bytes that are currently used.
+		 * For PARAM, read all 3 copies of 256-bytes pages.
+		 */
+		int len = 8;
 		int timing = IFC_FIR_OP_RB;
-		if (command == NAND_CMD_PARAM)
+		if (command == NAND_CMD_PARAM) {
 			timing = IFC_FIR_OP_RBCD;
+			len = 256 * 3;
+		}
 
 		ifc_out32((IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
 			  (IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
@@ -354,12 +361,8 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			  &ifc->ifc_nand.nand_fcr0);
 		ifc_out32(column, &ifc->ifc_nand.row3);
 
-		/*
-		 * although currently it's 8 bytes for READID, we always read
-		 * the maximum 256 bytes(for PARAM)
-		 */
-		ifc_out32(256, &ifc->ifc_nand.nand_fbcr);
-		ifc_nand_ctrl->read_bytes = 256;
+		ifc_out32(len, &ifc->ifc_nand.nand_fbcr);
+		ifc_nand_ctrl->read_bytes = len;
 
 		set_addr(mtd, 0, 0, 0);
 		fsl_ifc_run_command(mtd);
-- 
1.7.9.5
