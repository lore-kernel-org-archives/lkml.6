Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeENO7A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:59:00 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com ([40.107.2.133]:30201
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeENOyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>,
        linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/21] i2c: diolan: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:15 +0200
Message-Id: <20180514145330.4857-7-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:5+n8d/sm43ZFauauA/CBFxjg0H6F65MzvirfSX9P9/Z1f+NaZZnvHgLcXpIhjBln9TUKCXg6/CVxWqU9XG+UILZjVDqFQgqACLSWdT9NrR9pdqiT4C/JRD8/oCr/l61RkbVTa3JnF7bcf11rkX+CprMnovJZ/oPo7iwGAF2yqVelaEbXCrnBgyTWOID+h/XFXMY+IHBJor0sGPkVL8NlPc0k0UeXPp0FM4ZtwJeRTs3OS8RgleAJ8Sni7JSnN/5R;25:rDYUUJAKtJShx5JQvBPhYB6MHNK2wqmypuyNQNcRiakoyUca9uF+/wezrY9uZxTYtPwsplAo0EZADIMGYjIKA9eTzhbhSvruNhh6vh1dXJXCt33XK4U9dPK4LLnF5YO6UfJdyWcDH+BFuGHxtJeSEIluvXgRAP2nfm2CYX2s0XwBgqHXYPCKisPxiVwlDddq0i/zrLYFppblX6ctdRx17ERvDSBtMp8qHZlE3m+3MrGK2h3+d8ErSmxdOxYeMmplmCA/AulKdk6iSmL35m4ZYfbLSLFDWZUcYzo6EsWNkjJIcQ/kbN7JDQw7SpAkBXCY/IIrRFIaPCydyIg7wayyqw==;31:u4oO9IpVgME6d1fidm5unKDAtQz2c6733jCw0WV/mn1DhIzsfFnZjUGlQGa0fNo9q+6WG9X6HBe+tZnd/v9bqL5t5PgoxJ1loPIcDzp0K1RDUyXHP6tonBPHCOtCyEqfX4fx+y8KDRoDOqW2a+WjBAEznAjAeCnAmxcGijzbZ+kSpF1Yv6VUvlXzPkWGLjvx9bkq80z58MiigELZyHCMthhICahogqOhJeS8WdvHROA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27826144D312D20128316F4BBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:l08HRs+Vylpikj5+sIKpLbrtSrxedpCtPC/gYfez1QFVhvRvpjsbOt22cCysNfb+LMD2c01leqIsIF1FIw+oizpBJ4IBgXSQYo/3spUFVPxNWMuSgpb6kvPyfcvWsaIPxkkC0mCcQmNgSvj+m9vZbRfxr17Akpjftv2Dunqe1WTmNAZmUQud2XyixRO97iuSYh9Ng3LEAtyaUmhAGuMOVBHhRYxPwX0Mm/Kf2hj7VYOI6LwrNDzpRQt9X8DGhZtdi/e+hxA5nz3199cO8aE3HQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:bn8EEsyyxQ0cAHqypFpGfWC1p68qvqPECVg3LP3?=
 =?us-ascii?Q?ajTWBo1GTLlN1sMUGon30uiAHtFeP6VxMPILakZlK+EAY4Lfx6yjrN95boXb?=
 =?us-ascii?Q?Fsn+wHOXycxb9JEHS5N3/NSfNbfRapMlp4poTedPrgss7lYL1f3CHQPxXDs7?=
 =?us-ascii?Q?QTfoQA+w/zzrPa00eTkVonLuhvOtKRO8+gq0OpMvM116cPf0MwvjKgKz5TUK?=
 =?us-ascii?Q?UiHVTkHMTSERXmHQ+v7Qy5MmHgnrxtUR+FFGP0PA51gk2lUuO6rNv7NOJLkF?=
 =?us-ascii?Q?P+3yJXSmsf2q8lDK86+PifEPvi/Sy42kogUkQw3qe0JZJUstfGl120+oxggD?=
 =?us-ascii?Q?nDCFNyGDC65thp237wCyOf4fqk6AXLvXvsD0HXVFARp/br3f5O+cwv4Icwhq?=
 =?us-ascii?Q?xPBJqUCCGSgnoLHBlXDQ8B3ZR4zUe4YqdPI/x1vvtseznc7Bm34Y1MaVtS2k?=
 =?us-ascii?Q?GHCCAXXEqxg794Smg30YeY5gigyYd4Uk+GFYzomqjb+Oh1XVek+mOcfKtWIm?=
 =?us-ascii?Q?KoJoq2EXhiRXndgq7ReGfdyxglX32Mq/+pg5eQn65L1MmLEs54l1UbwbwNxm?=
 =?us-ascii?Q?AQkS/oA4bt3K+GY8gfHHQqc/2r6BLRk5uocZlIcwSQY7vY7OojKiUr7MDqDn?=
 =?us-ascii?Q?CyQTujmD9drNm1Sq2cXGN6fWVyHl8lNRtZeQueX+HrPlTYo1f8/vmS5qg0gF?=
 =?us-ascii?Q?/ihhgw2gVsM4PoOy59pBRGlk5KvYmaE96FU2fnmmTDmvpt5t03iMx2PW6sQy?=
 =?us-ascii?Q?edi0SR8IxcepHWSdrtp67iIlQGeVJkQ2iu559djPG1Y6dKuip7l6A4N4XhvX?=
 =?us-ascii?Q?PShbmuOiaYab6NtcM2OFANh6jbrQSxiG+Z9FsuC4Ef32LjkNnYh6Rs0ja4MH?=
 =?us-ascii?Q?j0W3hgR12cDmgp871l9gsjLtsu2eMaV75psQikT1rku9C7nzoqmPuFybFMYr?=
 =?us-ascii?Q?ApPv7E4NKsk0PM8nJ4iWpQJF25nOEh4pqHaHN34Z1niDu9nIeCom0eU5zezo?=
 =?us-ascii?Q?jsXTrBdThGoZQnGXQ1mr3otCA8xXw9TxRGFpnbhnWCVw0jB/ufffK+uqInvq?=
 =?us-ascii?Q?u+gYjUdOxjJaBuEPOybcCYNOHBjza5EogEu074LKowpQBtq0gSaiK07GXBfW?=
 =?us-ascii?Q?W2ZGEiQPF1rmBHF+Ncl6GO4W4c6fv1c9GfJkLxAhGnLXZVt5Ec64YXL6YTGi?=
 =?us-ascii?Q?AOZLgYHmDe4ZCpx/zwomv323g4PfglJrK8ndMOz48Aa3abtI8NCJGckF3Tjx?=
 =?us-ascii?Q?T0wmuSROz4F1sR4FAjglcZ9or9/q2D2wpBoBZ9OMBQRF17H8JmJ4/HgYb8vg?=
 =?us-ascii?Q?m+6p32cuTvlcbF8JDI955QZQl+4ZNm9AdCTkQokK1MGJD?=
X-Microsoft-Antispam-Message-Info: 1z5+6OKgcXHnWlOjZtVR4pxptVUkZmH4UZKZ/7IPwQ8jfdNsdUF6Mt86O+PK53XgerwOmy/Aonak3hiqk9F07LeAF7OUEN5Udi+XQZRAGVcUZCW5cAEjy4xGwEHW9UkB7d39iuofzGxDLYODvL5YMj0LPLzZN7MybEpH9X84WvxzS+zO3IWD0Y7Qu5A1r1PT
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:5cPZ0Ky5DDiYWDulDs606CdW+WMgJa39H+ihh29AAz+ppnoFHGdJZi+obChqLlLJXrpTcFaH4IymO4Q0lYSuU8stDQ4hOuiFYfC8GnwmonvmpZry7PW6GQpJS/h0h5Q3ErtNE4jngLyX9R2xk3S1tS7G8UUjlvbUFTKl9uL9hMNH8A1KlrkSGJ2th+dPOIM2RFSWY0k5t24HHQ4e0WPdfBHUtj3tq3R+bK0LTCc2bbfcbw023OId3oK+k0rgZYB+u3Tq1BDBCcufcv85bx+uMVpnJ+O8Smf4QHl6AeUi32cHhmGkHyouFW340vTknGUpHJrkn6Rt9+o2Vkshburbp4YiAY7FD/LzlMb1h4Ta63qxmBm7QIqb8DQQg1buH0hdIUB+CxIE0rQMrpzHSijjqCRnkmtMq8AgpbeHHw+UVLBsE2YB1DgBddzxJ94iw0CIDuuYwF/sWSvjDG3LUEAv0A==;5:5OITH705nPdSvcdsaTiHQ7IXN8h/a2NnOQlnBbg/KQ+JmhTZgfVh39sKSRLjz18omqqH7JbMery+EevU9cXqMIraClrPZ+c4Vy8u8tWPPWcrmO6E7eFHppoG0d5DfI2qKvnMIt/vhWZW2HxgyWKg4XNhgfL8JC29ROejArkbybQ=;24:6rAqTTxExJTh4GLmwTgVyx4zJ/dgXncTK1DoO0xYX0qZdJG7lkYPsF5YyC72Kk1+pl5nFrPhPYWkqGpsyFu8ma4/simWQqsthObRIvDrZ0Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:Qv5O8G4DbHR2lGpH2NfoS2rf2XhOCTJaGcU0kZlHVpz2LQ+P0vSk0kZzxXYxDhenNObJq4BIsQ8q6UbH8idrPd8aIBdPqQqk04SXXXrGV+GlSqPUEKHGWbg7DVY/fDf7Zy5bWlnNI99LPj5r0GWlmD75ZM2Jc1ZuBKB1FJ70DpmGlOXGTIegxUsSdaZEeSKxE8nvsTtkhwoChzIL2zFMrR27LIUHJpl6f2lfI68ezwq+sqq6olXP0r4YqkYUxf3J
X-MS-Office365-Filtering-Correlation-Id: 14ab58d2-6677-46eb-d97b-08d5b9aa9463
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:22.3256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ab58d2-6677-46eb-d97b-08d5b9aa9463
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater and allows factoring out some code
that is now common between if and else.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-diolan-u2c.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index f718ee4e3332..3f28317cde39 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -360,11 +360,11 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			if (ret < 0)
 				goto abort;
 		}
+		ret = diolan_i2c_put_byte_ack(dev,
+					      i2c_8bit_addr_from_msg(pmsg));
+		if (ret < 0)
+			goto abort;
 		if (pmsg->flags & I2C_M_RD) {
-			ret =
-			    diolan_i2c_put_byte_ack(dev, (pmsg->addr << 1) | 1);
-			if (ret < 0)
-				goto abort;
 			for (j = 0; j < pmsg->len; j++) {
 				u8 byte;
 				bool ack = j < pmsg->len - 1;
@@ -393,9 +393,6 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 				pmsg->buf[j] = byte;
 			}
 		} else {
-			ret = diolan_i2c_put_byte_ack(dev, pmsg->addr << 1);
-			if (ret < 0)
-				goto abort;
 			for (j = 0; j < pmsg->len; j++) {
 				ret = diolan_i2c_put_byte_ack(dev,
 							      pmsg->buf[j]);
-- 
2.11.0
