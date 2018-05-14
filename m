Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeENOzJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:55:09 -0400
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:36480
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932507AbeENOzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:55:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 21/21] i2c: xiic: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:30 +0200
Message-Id: <20180514145330.4857-22-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:GSfZJ5mYT1kyPk4PG2aDkHobtIevaoQOB3lAIQ+fpRqxD+6mUW5FphiOg+9cNiktIvDNdXWJ9qbrTslPlxze/Pmjgt6ewBvBT2i9LJucbxMKAuRSwEpWZo9uj99hJSgvHbObYLwRHpkVkTahA2LVEuZ9qEBBnNfTsU/QVYURB5v9YdYFGy2VJgm8/dBp1SlJNtEner4g5yx66J2q7jWrG6qqnv3dNBokgC4UazxCPZXrpRbHRQIYmJLd0eVKRnMX;25:SQR4ZJ6qkmEHq+i1caynMQh/KwBl4BbdU4Vz0Va9QwH2I8qR3kT2PJXkuHLrSeivsrwnvdg415d72LoyKc9Ww9i4mKUHXexIMiISfe8zfMMIH13MjQk/caanzIXznNUGQuOuSwQhIQjy9A2625AVywzDvJKLjMRHYU3SzCcY3Nh79HC74hbgA9ezJ3ii7JAHFTL6IY8Wmb90Zf6eZzLae0KIYkCx9VxUTBgJZmlK5SXI7lbROiS8AHiEWqyodpYQzral7MP6RAy08sV/v4aMeDwOif58ylTssY0jwtNGAKfPE5Z39WSmH+/gh9JSx9iq4iow3eCPBt9O1fv6So0gWg==;31:4mCYCVjz3RyLJgRzS2yDe6g6kS54neCeE1RcQrUfZW+oUICl4HQlWRdZzMC7PmkeJQWXc08pIppB/b/I2Tm5AhPtd0ypu3QR7FVeL4oy2UEuBLp6Vh/5wWxxS6BWWOLysedUd7n/Jl3QyoreKFhUBwqjDZQkYCDP1o4jc21wMqH2Vq+E8uJEUCev6GKwRQhruA/iTk2cnd2vW+O4X+nKHeav+xRIL61MRz2kjVGHvOM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B4CDC3F85E09F29FE9D5BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:lnIoiM1ntQFuJsRHYKXV2R7RH3kV6YJTLImGgSvDhUG5oaQKIhPjO3Pybl8UsyNFbiDraqUPECrlUkWLmFbaTPX0HNynUYd2QqbsLUBlGJI3Nsa1ZKCC85wbcxUQRw2n6ZrxaCUAR/YVzHAZXMk4IyJ29uXh1mka1r3TGZqYTb8j1OhJAl3ZXr3bnXMd8Q7/fuit/ImVlCvJ9qd8LDlw8k3rX4KIezXQaxXWKdAdYdK/6S4s8pEoHFGFy8J+1Zqtym7OLsRouwhDgKTIlDvWsg==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:Vhmq+xHAtP7x/whOhKBIhagqkZ+8tN879aww9rn?=
 =?us-ascii?Q?wLu4YezXgLn3W7BrcYidSfCurNdj5Tb9P84qB+VC1+7b1Gic/PafyJyd44NK?=
 =?us-ascii?Q?8ldwwEyXV0GAZK2edeGSjouerjQa3YlYMu0PQE3CLCi930zeUjTRNuM4UZbP?=
 =?us-ascii?Q?CdeXPOoh7fAOOayF1JD2JLNCu9XlSJ6mddU19fsK83ynh5GadjE0I7WnV6/c?=
 =?us-ascii?Q?Eero9fAubTC6DmvLHnfieiQyeKkZmv6SINL4N8Yx4OxwciY3o/OghqZr4hcW?=
 =?us-ascii?Q?bJWJyPEFuPh3wj6huStYuodvkxjOsU12VA6WOYefl8ac1qWiL3y1AfhLPUGE?=
 =?us-ascii?Q?zT7PX0VcPRfX0zTGFgbAD/xJUjvtjO3cVswI0GbpbDwS9iRZdk9i/i8cAYor?=
 =?us-ascii?Q?oqXFNdYtUrcMm6BpS31cRjSVOQyHATEzbKWqn1vJ/nVD2UA3ZrbXtwewR9XU?=
 =?us-ascii?Q?Nl5HFbCySzbYUXaNxlrv0PYSc2/K/4zijaF6go3dt77R6+AAyoVKsSWV+iEA?=
 =?us-ascii?Q?8Daro7p6THDM2OpfJDSrlJVBLBVU/kvMM3U24xcKkjCo/spDZ5RGPb0x657S?=
 =?us-ascii?Q?3ea9c4MELgdaV9rN6u4LzYGjOT5hupocGCICJyOcoJev9o/m1AYl+WJByDzH?=
 =?us-ascii?Q?YdPCXD1kUfHcUQ0ZWafyns0auzkKQ39YX/JXQ34fvYKpbr05LExMPf4McMSL?=
 =?us-ascii?Q?zC9BufyDFr3wZBNPg8KQ/EgAQ6SV1uxiAfdSOoqZ/oo8OofzOkFAiIjYxcYX?=
 =?us-ascii?Q?zflfXJGrUIHeL6iU3GQ34VudYC75b26Ie6M88fxUDfWnI+pgFlF8KnpVumGa?=
 =?us-ascii?Q?9eQ44UBNduj8OMw3214sUfHySzbm47u4lDvcP0KyL58jC+FQ/p381nzLY37f?=
 =?us-ascii?Q?92/YpuAJIwLMBncBjmQ2AJICtUUQl5+o+s4cr5S9XiftlfAvuiWWy5C5euNs?=
 =?us-ascii?Q?P2zeJcUuwxEdsuar7URmU7tBf7SStPOeyJ4E/1ykRi7sxW+ayAX5+1MXynHl?=
 =?us-ascii?Q?auJMM9AEcxNgKiOYz+PIb6UbPbkgBoNhjbTecUKCKPsn2qUjVA5SKlIufB+i?=
 =?us-ascii?Q?HLS5dlgEZKHPvc6GC0MRsK5uBgPCtddrv2aR70c07pRfgtXzcMmemYPkoQiu?=
 =?us-ascii?Q?9CFeZcebRIVrz8rragBF+wofXiSJ3lR4JAovjEnfaa5KJD5Dsuxh2xlWuDBT?=
 =?us-ascii?Q?Vcxuw4ie10pHoImsJTL8BkOQu9w8vlurR0KgWhLmed5RfKo7NNBUOB5/U77K?=
 =?us-ascii?Q?Dr9lBrY1gsy/Fzc6ZHuC6F8XrJ2jcoRWSnbeyaBcR90+8wXwp5RwxTLnjYaH?=
 =?us-ascii?Q?Ul9KFySwOKNSjicMumlhnesAJgjW1ptQ/H4dosWmQbiCm?=
X-Microsoft-Antispam-Message-Info: XWhAlEbtVTdIoFVDQ2xHwEdf/BDTnlxST9DGGVwQjogFpuetezJMpaC+rDYEc6zs9z5eiYGLZZkhjNJJKAM2spYmB6dhKIMb1rzoBGYzb2M+Tr3WQSrlBBL8edvyIGG3iEASKoMHh5HISBiu185gHo33tkmY33tqCpK5ZGbxeaafX4MHjc7pKdz1j7MOzJzd
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:8HnGeTE0WIh3ADI64Drc3sFATiTLsn3ZO9DNiouesKgQrWET2As5MH6Ss6jTKCX3X0LvefNkznLaVrU39+f5YoWRMyOJYi8IXQjs6NvgBH2u8duiXoCMrFC+UfjxcoirQ5QR/vQwxYjuzOZwwAquEnamSi0krXvnzRkSQyNNT4B/oIoNj1KylEJ2VYQ71u0pkXDo69rVa0xi/puundSAogRcoCir8GC2R69pHCuGSfqO6UBy3pSpyPyW7IwwTnbErClmSDZYig9yuY5/en3io24LaVjp5bWQGqDP8RNNkBO8qUhUdgi6QSYPrGQJhYcWstTcMmVPoNZ/Gt0KObaDVkib4zaQCtdF9c+/lD1cT7AfHZ0y2ZVxkmZN382UJAKxCvJJDxDoHZXO9uHDHjYTGCwMt9M3wryhhfzzCIZ03oHP7cvIJf5DXYoIAO8GjQO8hIMJJnps1nxUXvDe7415MA==;5:3mIpHkMcc+gThY3zyoJU3uHA5JO7RhmKR6SQYaZo6av8IbkoT01Ro5KoeshBiTBwYCegmpyfNSnak9NEccWStasJz526FrWUF8LgeKyE0xecz/eMT4vpQfql8mlnxi9dWa25LzJ83GyR+S/h0JHLnDGclhIPT2dzcZvxJ1e+h5I=;24:IT4IeO9sZVAusUFujoYeSmFI2un1EEIjtPa55gPQavRCfldj3haUKYlVvHZHExidoPK0U9mi7HJMtjpZCGO62ViK4FHNBlGC1EcUhAzD2cE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:X/m/5we67wjom0J08mWzMKOyLYmGnwWd4VbYXlT9IJqbzUGvp2P0F/C26nSsbZAANV4TZYcrEWemYwo/K6+jTyKCtBzVGnTn/HS5ZfvTjSyvTvucqyjvu358WMZeibCrGVWbB9dyHZsU8uOE4SON6VLaHka5lhHXQ4QRn37cq26vnb0ukxrnZjZGI5DLJv1uSf+1SbOZEEYJCIIx760kxgI7aDz0ykQeuDjjkqEvdMeAfNqQvQIwX4vk5igBJ1Lo
X-MS-Office365-Filtering-Correlation-Id: d450c387-d1dd-4271-944a-08d5b9aaad6c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:55:04.4196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d450c387-d1dd-4271-944a-08d5b9aaad6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-xiic.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c80527816ad0..1818c3b5c8d7 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -143,12 +143,6 @@ struct xiic_i2c {
 
 #define XIIC_TX_RX_INTERRUPTS (XIIC_INTR_RX_FULL_MASK | XIIC_TX_INTERRUPTS)
 
-/* The following constants are used with the following macros to specify the
- * operation, a read or write operation.
- */
-#define XIIC_READ_OPERATION  1
-#define XIIC_WRITE_OPERATION 0
-
 /*
  * Tx Fifo upper bit masks.
  */
@@ -556,8 +550,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
-			(msg->addr << 1) | XIIC_READ_OPERATION |
-			XIIC_TX_DYN_START_MASK);
+			i2c_8bit_addr_from_msg(msg) | XIIC_TX_DYN_START_MASK);
 
 	xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
 
@@ -585,7 +578,7 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 
 	if (!(msg->flags & I2C_M_NOSTART)) {
 		/* write the address */
-		u16 data = ((msg->addr << 1) & 0xfe) | XIIC_WRITE_OPERATION |
+		u16 data = i2c_8bit_addr_from_msg(msg) |
 			XIIC_TX_DYN_START_MASK;
 		if ((i2c->nmsgs == 1) && msg->len == 0)
 			/* no data and last message -> add STOP */
-- 
2.11.0
