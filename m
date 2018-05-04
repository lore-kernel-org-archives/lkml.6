Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeEDUIw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:08:52 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:12691
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751522AbeEDUIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:08:48 -0400
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
Subject: [PATCH v2 1/2] mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter pages
Date: Fri,  4 May 2018 13:08:12 -0700
Message-Id: <1525464493-5006-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: DB6PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:6:1::22)
 To VI1PR07MB1616.eurprd07.prod.outlook.com (2a01:111:e400:c546::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:VI1PR07MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;3:INh9cSRp1TI3rwq+lvVmFKC8Qsk086q70lK1R4houl9bdOI/ROMOhzdtsbdR0YVvPwlJxzXGz8dfZ/Re4+jFKGPAQSo1+9YR9YAFRRAMKyQk62aDJ6x8sHMKVjll0O3HOJzlU5W5P6hgxJ1cvR6eR1rOzOUirPpTj1vifZYTXgSJ9MckfOhUisG+dZOtZzu7Aqgaw7pr4vehV7Z4AgsJBnGDepH6w4eTnBKS6+oi9W2FFGYhxKSIJhiwuURk/S6ph6ZuxssFDKd1Sl9s2vo3N5A4eYvr7oq+AbV/mO+J9z4=;25:Pa6P4kLGFnQW3l36GwTsgTQwrWkTwrd0UCgc3kJFBEqCoFtmPpc7Lg6YiAoUF40v6lXYUDSWd6ao3FBYVJjmZuRAV7OBpe1mkwLOuF7lMHWdj6lecjW7fgNFdmGEU/huJ9A3ZVnr9AOtggmdVmzdMW5O6mZTWVr+BVfj9VzBES/31QxeGmbj4gZS5yBZd7EPJpRdiy76jjaEW+jx6pR/O79po2qbZTn2CA44u/vtAdjlZ+sRDbm1CJWHWkisb3iheS7H6nxB2tDLT3B7/OnGxPkr55278592V0n23uv0Aho6ErzqkD8zZDDaFB8UPb979qQKGZdv/7Fqr2rsEG6C0w==;31:FLKPGwzaQmhE+H7Ti6NcLWrGwNVOh39XVTDxwK09XmHxOtQu0rrekZ7HQkA/HbGQKQMHnSbAzECXSe2gdky8LunZK4xNNR9zoj515x8VGq6np/TIlb3vtHeHQXoCQErHBFwenTvdWY/Scau14UxbZOd1GDqEDGMHg5M/TmiUjBVp+xv4RWrrzSVxl2AFDtiung1wct0vPwskLfTehImjVIbLemMuDjDYN+Kyu17V568=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;20:acWmwfdqZouZp0WLtWir/laZGriFhQVTGtY0zix51nSlYSJVynngZ7zpbYoPGZ4mlDVT+6QHsgf9bus2n5H7hjr5uds84R6c0+EuBSEsBbtbQdHCPeSgeyHxZ6HmrTPfWKESaVSUVGgmCT1snMiF0Mup1WgOdBxoBgDCtg9wno98GQ7PWa/McffMgYWPqldIUoashB8VhACZGFJBy55qirIdpcqiLZK+ExyHv0WNOQiQZcBsjiji5FLf+NGhn806VIej6aySs1tAghb+0ffE7jnJLSm6bubC38MZXjS9yHW6nBVTWLjX+dmORDjUlGPpldERrDRmme2yyTHSEhZiS7xp1N1NQkfmzXNzMl7w7NnHqZM8vy+bE518lhU9zOYZ/eyzypfy19uyzJuMBG+ZePhZsFRgXmbpSd0QA2wS3do5YjPg12oxUrGbxD3iaAvBXexMCRdR8SFrHoadzZ7IRYO+qkFN6xKEzZQ62Ah+tKW9xgbFhUUAricwkM6w6wpS;4:7djlnsJnYeq2hNog24Kt4k7snCG46j3mJv10/go7dJl9G9vzvT9hndswqNNZV0E0XKHe+NSgwUjWV3YGvozhTfwoOn3abaV9fftiIiNzgRjMnxH7f6zJS1vSYjUWw4984CBTNCd6LjZlY+P691I2hZekWirsZDxC+ZOx9BrAChL52P/UvrZThLfUUWDqsCvepKnkHBI0/MKk9WPVR4K5146rI3gb+Mk6PNOuD+/xwHrz7W0RUHRF9wynun+oODKc1GYl3Sv0BCoLbrc73jjmYqTScwtiFijJBz5MjGiRP1HL3cK3s1UASzyNAOyLYgZKQomwhtyrXELlxX8Zxa0puRYCkha3E8o4uiwRveeXxtY=
X-Microsoft-Antispam-PRVS: <VI1PR07MB16165EC535F315DB0DA32CB281860@VI1PR07MB1616.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(806099)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1616;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(86362001)(25786009)(4720700003)(105586002)(2906002)(16526019)(186003)(68736007)(6666003)(5660300001)(106356001)(26005)(8656006)(6116002)(3846002)(39060400002)(48376002)(66066001)(107886003)(47776003)(53936002)(6512007)(305945005)(50466002)(36756003)(7736002)(51416003)(8676002)(81166006)(81156014)(52116002)(6506007)(386003)(478600001)(4326008)(8936002)(16586007)(316002)(956004)(6486002)(2616005)(97736004)(50226002)(476003)(7416002)(486006)(921003)(1121003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1616;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1616;23:yveRn5+eNOIUqkZGGHZ4yOf03Aa27sCgLaslkUgEa?=
 =?us-ascii?Q?ivG1gJak3z4w0JU86mM0Aie7HjOS4TBMgaBHGG8gqY93wlvwcGJWKAMa01z/?=
 =?us-ascii?Q?id32b5loIeQWMnme7tI8biggg54MdohR4thMBigHtafd3B6vEbRRrwzORra7?=
 =?us-ascii?Q?mv1jiXPCmaaxpNxW18Sl6xDUpCObEuhplNoG11axO9lQQxmr8EzC/Cb7uRbw?=
 =?us-ascii?Q?fEcb2OFQA65T/Pruj2M08AKItjbZhGGQE6PcdeNKRT3FIOIdzkGIsA9Gl69I?=
 =?us-ascii?Q?dxR3wvKE5hktVbY7kvkIINt8/wKFulfyy9BxYxw3NgToIX0+VtT2ZuCdyiDg?=
 =?us-ascii?Q?RvHJaXLE9AWtRhuBFUGGv72tkfYdQoj/+LXN/KsQSrZ4WCgQCjotB2QEOTve?=
 =?us-ascii?Q?sMMAfB4xbkNK94pYupqI2KIiphunPAj7X3od5gbbfjl60pS+eo4Ky6djR2Qp?=
 =?us-ascii?Q?/WGZR6h5kHgRaEmHJBUL2/POZy0i5b4iG/4VXnf9W6fKtzm7RXl9rQ9bQBke?=
 =?us-ascii?Q?qbFGLXeApeSFMSK8kySE5YYnYe3XGXViTrxLiwqrvHknJyW91LHlwhPi7atU?=
 =?us-ascii?Q?WJEZh5WHW6tGlvWUevV/Tum2Dbn372naxjkR77RcuTpK5KzDZ4L6ZvpJ27fm?=
 =?us-ascii?Q?Ji/jaTGyRlqkJwqlx3enRnmahzugEXpC8rcvBqKjT7ElgacE6+FdMTnhPNAF?=
 =?us-ascii?Q?dfQ985WMrULw5nOaStJQPYTOJXi6YkGkA0c789K/cttehQ+a65ypTnm1fQDs?=
 =?us-ascii?Q?LY7pOFsX8BWqwH6v7VvalQHfnBfL85jWuanQz7hjAuJSmFJ8eIDsRl5dkSNg?=
 =?us-ascii?Q?BhsKjNxqk6WOlEl6515BQC/fKxAeGXv7M97ECwucGIvtp2qkJl77IHGDsjiP?=
 =?us-ascii?Q?nNfnPAKAjJ2P66QgjSQb9qyl0qlKfNDfG9UiJOzrt0OxGrQtLo2nMpkirGYe?=
 =?us-ascii?Q?rEoLEWFh8kobhivzRxWQN51H9TaPQbFmg/guvuoK6ak8vGu4E/D6LRFT/8C9?=
 =?us-ascii?Q?+OEgqYVBdMhGHaNxfqa1srdDORYvRleCVk9xqsZ/jCUn8PHOGfELUv6e5f8J?=
 =?us-ascii?Q?lMYbo8EXy/fqzRsLW1yQLaY7Q/GXvtqQEKyngX9Mv2J5FDsg0k/GtUWGHVnz?=
 =?us-ascii?Q?cPzNabWSjgvfrbBlCrhO0suRaxHqpQSgayd2lQGzErOYm8ZcGJnfLySs03l6?=
 =?us-ascii?Q?mbyk1XVa82yE3bhTd3KlSBnTtc9iIbVRbcGYrlv3X9711azADE+8F6DbzMFA?=
 =?us-ascii?Q?DdzbvikIzvemeWXujDbGXVCwFXIqIDDtvbV727Y?=
X-Microsoft-Antispam-Message-Info: 4xTlj+jvQwPMMe6mX4BuuPje5Djrbg4/MxZ22nx583DETE3XEWfC1ig1KQPbHdyS4V1lJU2uxTqLdHS+pwaiVhfFJUaJGNsO30xcIwe9xsDzgEjh5IbKLASEOw9bKBJjMN2MWklkM5+MDuf6jAK2j7Uzush13G9B7vKPlRoIYNk8qy3kcpyORxE0E+UdhVxMZ+DHy3s2+wVFr4cBTRU1e5yiZe2YX76TrDFE9ZYa6Wk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;6:GylzoRbRhiUOXeuS95w5nUBa62c9LkAVem3+NpePXSJzUegJzP6O26tU09p8Wuab/aQsx+1WWHGe0fj3mgDtNnggpnkJTzryY167KNSELQBxhMxas4I0fFRBiO6n7D7fvf0gcvnf9IjtKErIz2oTFeSCh3FaIEujkR/EQ/61EyDTo+KjWyDMLqhrY5bS30Ejeq2eGT1nw2rJCU3QK8d2P9AC5HcG6uyjgMKqxI1uW8bcgz4d7YUgYVzizBOsnsVKA78xaDlSpXDc44EEmgrOPaaC+HDQqqqBu5+gG/UZN46iao7puUkUZPPa4D+cNYWJPwuQwrBQzN95xqHZf0NZTfxGgcb3QByePZPaJbAgALo6FX7z8KLYN0+hqeC+FTBnVGF6QXqVV++UZSKz5Vn2F8AQ/Q0RjxCZ1EoGrcVBTL/wCBJxmq8hyev/oW+7lkzdYV1K8/XKYt2aznBIqyg7kg==;5:KZnB44jb0nqBr2JcDD5VDPRHDZxExEv74bxHkQknuy9Lf5wMEgCruXZq8Ld/StUidXbX97RS3IWYGWSuxz4lTlI1JT+fcYvL8/H6Pp0GVN/0X84w1lZ3sJpjkcW110JDEFEVqVK/cW3aazu0Lf2tIvc3+yML/2ec+S5ax1DsMWk=;24:PZh1GK6E2f11kmvGE6N2idI9or0knRh2ZeWvdxVrYc7MmoW1eV2onZiCNkCg9s3lFM+ySlVcrZx2YtTAZHJnPLEjUYd0OvzR3umFa30t55w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1616;7:ahnd5ceztOEbBt19pXfcM5lYdbzMmCC4XdOdx58b+yIfenuvXQIQizVt/zzyf2wscMfN01Yfi8Uq1AeSsihwR1gtYDJlO+5ivf8qxkj88lE7OhxKpwYluXzhJl/FB3PxPWlrwsroDW4tvlThLAVa3tW9ENgzE/vhFXTuqZecmV5yHWFjJJguc7E/Q3XMp8bxniyTOTqV5qifiSEKm0CDKe348xjDD8rwCdkmQbcPAl4dG5G6PaYH4oYSZTcLxF13
X-MS-Office365-Filtering-Correlation-Id: 45accf91-5a49-45f9-5619-08d5b1fad737
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 20:08:41.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45accf91-5a49-45f9-5619-08d5b1fad737
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1616
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
