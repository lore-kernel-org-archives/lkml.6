Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeENO5o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:57:44 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:36671
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754027AbeENOyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 11/21] i2c: imx-lpi2c: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:20 +0200
Message-Id: <20180514145330.4857-12-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:Hl+Nz38+nVRryCpjXyQzrCd355/NEFpmKGgcFzAyCp1xWgSRpPidiTDiy2WU0jIbFc9G+Ns4BhFaafOY7I4m4rFHtMkUm516baU/FERyGqL+fKArV+zoLj3PCRt+G4K2yZncxMzE3indYjXBk5UvQZjcAVVzRYoWm7tNbvrSvNGqnVRHOmaLtvxo359pQBtHNMJ/7iTTFw6zMnl7IsOef4tv9Y2X+BHdS4dmas5Jb3bJ3zxw6ps0EQSb2qVimrtZ;25:4rPMEUBhh0rAaQKxm1X9Sym4fTKoMzemVpFnlDLw33bDJaCGIwFsiSYmd4AQx4PyhJ5xDNM3gmFywP8+MYrCGMJL9ksgsA4km3eF3LRXqUWt85nTt6QhRQCJekREcDi94h2RegvoAEGjEhQE4Jh1wdwPexN2CXEeLetQFOyUYQ3HA4S3wgQFhUtZ4aO5WfEnmC7sq1tWmKwerTBAWwkBvIef1s0SmZDhgPoG9rmpWLsrgBYd59V2eiJwm1Jpp78T4p36ftwPkFOTnZ9kU3v8lKGz/h7LMO0rRQj3mcD/RW0i9KuycBi4D7ZHf7yvlgTFpyQeo1U+R3BMOye00BsgjA==;31:+cOkD+Q+FA6JObjIJ2Ihg+TnNi+auK8Pep4/A8ruAS4S8tMZUCoK3ZZ4jbmdMh6PdkpDSfLNdGec/yu+e7nKxctBRSq/otQWDyrTuNO7q8S7zjFfTRiAn7c8ZdyF6JS6SaRSOs2yBEjw6NdJ7WA1Jc/vcacassbmD5ZuS3ubhoXri0kwEcxPJcXRIYKAciHWT2+AP5/mhsDiDV7dypN0QLiRAIxeh8QKFDuenXaj7gE=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278278EC86844A2A7E0EA80CBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:tTQcE8sL4ucSRT6+Mdbl1YE9QMM907uMAoexNHi4d/YoLCDl20Sp2KH80CZMQq2TzyyWzvBA7m87e4kNYNhMuzevKSaWK8g/v3BqqIF0wThV+F267xRq2DhWWk2/DMbEEPW6KE0wR0YmZ94LpPA02u4nSGSoZKYGAJKo/O1/Ii0INwi2TonVcreoQaYkiJS+pUYP+h87PteyXGx6NbUbpsv9E8cp+l2ucyIeLkCO71A5zx+fCD3DXxDiL1InhojvRFMF9hSo1f7rdKC9Kr2QOQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:toF8VKeSLzeVmziMjdfuOdFLop6yc8xsuXUvtnU?=
 =?us-ascii?Q?2b9b8WuM7992AJT0MPDk1jErEcIw8W7XI4tXaL44GVQSNZxntRr0uuRfJVAv?=
 =?us-ascii?Q?VTz1A3p/FlDrX1SxukE/Y8kI4ldYfclaCTZ7ibjrvoSo+1yR1JTT/Gi29Ohz?=
 =?us-ascii?Q?mxwzH1DZibwFC4ha06QouyIHinIpJ8MJlSI8fMkrnvRgIGJY88zFI7mNF81G?=
 =?us-ascii?Q?x9AGF/nZ/qXRI95h8Nal3tYgzDZgSffAMUxgX8CQPxwEXWxdwbyIEbfaMPnr?=
 =?us-ascii?Q?I317QQjWnHwIMysKFe7ipRv2ILYkQIOFp6keTue85LQ1ZoItwIbnFS2MH9rc?=
 =?us-ascii?Q?d4V/DlQYse+ZVEqZ/TtrBlpE1Qyei8HNbY74aKJzlCHaxMgwhW9yIuhzE/xr?=
 =?us-ascii?Q?v6BAUtvQrlZ3lEsJpYhMNanmFS7rnUO+0qR5hNAeGTYLkwYwrzIHizOaovJd?=
 =?us-ascii?Q?pcL7GF3E20cb/eJgSmwV+m3ZOMQ4H3n3BJVET/zxtePBgqHuxUeeTj8oXPuf?=
 =?us-ascii?Q?u6FITlveA4GWwbzBSw/rCKyaQ0X2Di4r+OnyRaSkmVwBDZ8LEdOUVnp61PAT?=
 =?us-ascii?Q?ZzRm3tKetzDbNchwdLtF+zLuKYA/1pB3tEnPzfGfumJR7sZXfQ2QxNQIl1lp?=
 =?us-ascii?Q?Cdv9b/o0rT0QHzWW4UlModAhAb+9TYR3rqO4T5EHA+IYr5QrvtqvbUm0JqNE?=
 =?us-ascii?Q?+D3mJKJl+7t0xtKTsvQQrBP7hSAK/3qxx98oYEsV1By+0LM1XBPPmP/HHPBQ?=
 =?us-ascii?Q?wwnEcNeKrDpRB6wsSHxV5FwUeleXb+p5kvJBdD69iCFWSFNhK1GiEn6Qp4+e?=
 =?us-ascii?Q?7WHuBxbmLP5ie3VIxy9jxeGOs7aSRuElfTNtLmAD+cvDC/cxrdh+nSlR5ZM7?=
 =?us-ascii?Q?eETznaFkd4YbEe75pIMB23qrzWbIJr/PcuwnqL07W560p3A+pdcQD8Y8cSWm?=
 =?us-ascii?Q?lIvduKxGKB9K3qkp3DPA4qN8QFvGyovQ+cW+e731no/TaosZ50UngejHJAfY?=
 =?us-ascii?Q?7Ft1gMvKWttHO/wIklVO9N1Q7N4+AkxUkWW/XWAjXhHXbnxACHS/2j+Iei6M?=
 =?us-ascii?Q?i2F19RMsaSgHO8EcIUbQeFstcnR6g4DRh4OvICRu2tM3jLNjTDUkaIinBs6N?=
 =?us-ascii?Q?sfW3SzCp9WS8YgT14nX+o5YntRvjDPcj5LRG9uLMLyIrReVZW7to+27dI3W9?=
 =?us-ascii?Q?1+zhCAxmGbBC1tL/lYNNhdo5K1BWRGLAk68HWmt8KttdW/dgCRoUAXprZ/+R?=
 =?us-ascii?Q?Ffb5HwPJe9EY4i4ws8JEIswYuJ1Wour99Fb7NqdoHtVgGTSpSxdbkaB6rySG?=
 =?us-ascii?Q?GqCnVIN+ykrkHc14qCO3Ul2yo0mA+5e4k+sV1fIHybM1p?=
X-Microsoft-Antispam-Message-Info: 6ekDAVHemOVGgVPK+1lajY0BlDzpBUNTOCoDjdkxPVNDDN8cpY+ASitCwbu7G5g+lJ41UfbJQLm4nIde1u2ZgzsGnLPdZBoDkSLzF57z/7BKzCaF6Ylt5j63rj2VoH4sBPGjgL6SzDb7qKzZW5HNiRPbbZNRMX+1nBnkcq35jdrRtu2XwfviLXY+RmVZTBOh
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:rjAvtFuGnZ0TobRY7/w6UKzhyutF9v7yvrpBxKC8BPvIKmyaYGe8rDk1myymz1kBreqGqt9J0usZCJTwqxoW7lluoj60oOiKezOIc2De91B3crx0ZoQ0sgsTDkdc6bMz3sVVCzCtm3/JWtadkV7wmLufrqkCekvouG8TnqLAUVBrNrIBIeX0lDrBrD1tJMLTvoS+sFzCWs8L9oyPAb6Il+7yeCL3q7e7bZzHBUh7XKxurmQ+KNXEemU8fOhN73oE6Q3Wm2BLUAkWh5UqwD5yIdtJMF8ciDvWQB/CkY72Mvlbzbk+rr9Yu726aMJg1aeVaEvSauCAPEgwGQUjFWIaK6RAtmonUchrOK6q8CxgJxB1FYqfU7c2LxJGXdrC+cC44AZqkSiYRfCos55sR6AhNTNYeiWNkzebxA7KDB7zhPZmqBXRNxi5GFy4t/JhsTh+hhH3Tzw7ov/qZwMI6dO5Wg==;5:JzC76ME+xJ1DGjII8ZDRVq7966mCNrZCbyoir+7S52oMxZhwxdnFHoXuAlHn/8eG57fVBDMgNZGJdaVk+v9tAI5tyRItwOrWgmicir9YRzI3U9uyS6rNtYfpZf1e8O3huerKVn838YbMRG8j3R54vZrQzYdSGdeDx/nUN9lWAEg=;24:P9IifktsljVnepL8RTv1TEhO4Q3mp585EzndbuGNwDBktDHYiyUGZCL21h+B9S2IM1CuH+/Gcy5+HK3iT7lm+q+OWLBpFpwd8GHrDCytp/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:STYfa++oNIoMkcWw5qOGim5FAvLICZ2XdRaNcEiFprsyEbSfiSDg/vVDGxYhRBo+AznVdO7XSKxtp7MCxJtvhURX7qASpZax7tXsrsG2Tc/hIrECuBjoTGG7EdH7Ws/TFpU/K0LN81UzGDps3kp0S0GpurJwl6FJ83+1Rpn7fPc81KxkfGsJPlgnMqmh3H2p6Wl7G1KR44JcrJoX/MBxAndPWCXxL8Ay7lCiSZ13YuFGZRqWTk9MC9Tf/UkAn8QF
X-MS-Office365-Filtering-Correlation-Id: b4122574-79a6-40c9-27cf-08d5b9aa9d0d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:36.9507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4122574-79a6-40c9-27cf-08d5b9aa9d0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e6da2c7a9a3e..159d23211600 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -180,15 +180,13 @@ static int lpi2c_imx_start(struct lpi2c_imx_struct *lpi2c_imx,
 			   struct i2c_msg *msgs)
 {
 	unsigned int temp;
-	u8 read;
 
 	temp = readl(lpi2c_imx->base + LPI2C_MCR);
 	temp |= MCR_RRF | MCR_RTF;
 	writel(temp, lpi2c_imx->base + LPI2C_MCR);
 	writel(0x7f00, lpi2c_imx->base + LPI2C_MSR);
 
-	read = msgs->flags & I2C_M_RD;
-	temp = (msgs->addr << 1 | read) | (GEN_START << 8);
+	temp = i2c_8bit_addr_from_msg(msgs) | (GEN_START << 8);
 	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
 
 	return lpi2c_imx_bus_busy(lpi2c_imx);
-- 
2.11.0
