Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932529AbeENOy4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:56 -0400
Received: from mail-eopbgr20117.outbound.protection.outlook.com ([40.107.2.117]:36375
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751498AbeENOyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Korsgaard <jacmet@sunsite.dk>,
        linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 15/21] i2c: ocores: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:24 +0200
Message-Id: <20180514145330.4857-16-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:g0m6GuOLijH68R7/c7v+ImLRxj7pUaWSCltCBN26bXzmlgiTmQk9ECRN3h+OWn3ypfSnXKBsJX0OBoHk9vSYx3voJgXoM0eWFQMhbsP9Q+xTcLR/y3w4dA+Qhc4wKq7AMWquZ0fOr7EtgJ8VnI8UBJZ1wf5OCAckjP0hMvmU4iPRTsqtfsUpfGNrrkss66/N/ORfvp12L/awGcsxZYcgUCjRvK1Tsa1/CPf/X+ZTHuj1ZJmflAqKae2n8FbWLxuH;25:R0OnZnOjQ5MwfvKbM/CVXh5i9cIX159PAHWMxWWRLWRw8m5laWwzJk5ww6iyGhiWBF2AenRNW46k1XPiftlL+rD/XRmVE4xDd8oTPjo7inPP1ZsCc2DfhOZXoVbIYjizPlHcGPlaXK1yx5d857J9dVHERgithM3HAG25Ah+D+9gD2XosAm8sRe5c292dHCbVGEQa3/YWSQNzdQLAjF8Fk5zpzlzwTm8PBYVqafUS/t1Mr5o8kmRffIiXkACNIV+cjj6bQ2gjwo0Qh0oA1aPC4N4J7Am8FC11+f3gTsnMoCUIXnujkoamj6Kjxvu77cRClInBF7KQoMyTn0Gf5/HRvg==;31:H8TtHWNrF0KqjzEfY1uyt+xahPIjiFly/7Zsih1/20ZebE2zw8bpkF8FVrzT0lBqUCbdhSxIhSQNdHhLA0AJ6l6c2QU91UjOP2H+pWu7/FHSB9+sqwevx2MLmupsNOxwaqCMMiwkjvAnfEEMFpyhvKFgwHAvdNecXkpNBJp2H02T8cPc/T7C/vq4rXttlCmhXG0gbpsEAjl9aYTQtogtYplNq7xfuIskqV5vGls/LrU=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278277AD14D3A481182FF82FBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:URWvMe6sktb1lFj6hLHUUZv4/jYbrBUmZ4qTU482SYN1yB37Kd2JvhUyLOEH4uODJRhBqTqWkOclspbwmWwv+gXxDePbmwPBrClGVQSo4t5FZMQ7n4VAWGA9DfH2ULVQaJ9Lqeu5N7pDW/4U7hRkF2/hNPBPktAmMhzReWTJuGtQby83NvAPJxrTcZgIHmqsIIcH9wubS6vamJq23xTgW2KZimvbXGFbM3zjtViZgdQ1SDvahEl07Kd6iuHQECaFWFD5oMykJUfUzLLh0v6UMw==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:f75m/JdmIQub/FxetTK9HQKT01cur8YVgZPCLLN?=
 =?us-ascii?Q?kRMGIJTTlcC7rWT4KS4MVG1toSfqBvrjblpT432j7TnA7ow9EOVwm6GQPMta?=
 =?us-ascii?Q?FFvp0+LKh0fbjEdPpM5b8J1ygAR9+iCTkwHJqBKM3yYdJyvNZvv0S1ykmrpr?=
 =?us-ascii?Q?mg2D03GqQ0TFkEzjU7s3kAdGQhsTCFAVrf+xBB7vwOHa9qy7/jL8z7OyLYVD?=
 =?us-ascii?Q?TypFfCNU71cqkMTirNP/eX/Wo1Q79rW/FUzQoFEJXMAPAOARu9bYEkp9MUh9?=
 =?us-ascii?Q?/6zBkJkzND/6y+qhuwJbCoEW7hwJUYgmNYgnOQ4G5CoNXpwoi9ABF0BxQKgB?=
 =?us-ascii?Q?BcYtT51k7LaGVBXzr7C8fia3X2L9ZAzEC2jYn6hzXp+DfCfqw+nLjUtitPH8?=
 =?us-ascii?Q?lrplImctIoiYbeXwvT0f7TknFoTR9mCqIKlLsSGuHYioyVVT0ZgaJU+bRDJx?=
 =?us-ascii?Q?nKZuPOZnvdt60RUBPwLETmESW7PTnghlkO9byOZipvyaHhbx0c3Hu380BdQb?=
 =?us-ascii?Q?SQFpXuq3wuNBEXav/Zzc9TTrrAH8MI3Vnx+K4skLZWem8ptP5DHpmZRUh2U+?=
 =?us-ascii?Q?GI+Y35teCDUfVwbM+sXGVL4BCkUSrANmyGKkDIb9xSgPLnN5BLIzdg6JFMd3?=
 =?us-ascii?Q?sLYIh71oB+hrNTI/gAZHdz1DKJ2yQFQ0jfQgqfMeVjLk6QkVPPEXLQSjOw5i?=
 =?us-ascii?Q?JirWiJvt5Z8JilDtRCGI5x+FhK7BSF/91cofb1vQ21UQA5BaF3JSyuPW6lfq?=
 =?us-ascii?Q?DuCEVGTelH92LpIPM+YpyAGzzkVaofrA7SEeEs4F9N+MbS+FZUjrrkyWNFH4?=
 =?us-ascii?Q?Juo6GlUU8WUBRJ5BtklQPJ9nWf3lafQoKiQVer26SXaPHHn4Y85pFuXiuPAE?=
 =?us-ascii?Q?aqQNxWadYZ2+RSAXqYURMrySYHcG04de/7uMqZlFNS8FIabg6tRV5hdekwEN?=
 =?us-ascii?Q?yZ+d6dxIlOert1VvSFyzWfcb0j4rK9PyGkTttzpEUMxOooFhQo0ZbzWtvpg1?=
 =?us-ascii?Q?41JPOKLGirBGHRjEypoCgTpkZv6clnaWPVBk7knBFr38TXJ13f5zYNaRQ9Wq?=
 =?us-ascii?Q?BJ5jWr8ZQP8ofUA1ToMQNj/A5rd/juXLspK16QnTzja1qNMvegM90xyYdXCJ?=
 =?us-ascii?Q?Iy5EvbtHO4Syi/zC1OHDFenoPE9YC5sveU3oTy447xEFSfHb59VpCF6tIHnW?=
 =?us-ascii?Q?VcgWSAkthJBK6quCV2tOfpu/ZJcxfJeGywTVNP5/cQh5DsTuSjKqjZfN07LT?=
 =?us-ascii?Q?5/C7nV1Zj5paDkOOSNWdbbGo4oU6kgEfx/kq45xuwYnBH2k8RkVxrHGTvNR1?=
 =?us-ascii?Q?cQA49fwg9alkDDy+JeMEzrZ1EEU0IuYdvgvSyQWVYhROZ?=
X-Microsoft-Antispam-Message-Info: KsIcKpu7w91ovHst3e0vlpwEUNooXBS9KN0opk3D5+2jli2wSrsCp9WrZ8IKKelHajVTKKXL5pfPZz5Fk0hszpui/XpTrlgOrQvK0pDVchXx7aIkTow37TUJPnIQqmnqGFdG0iC/hpDv8woLwetwYgtlDBSOc0LmRA8btXzL/BlgXSNdPjGWa60SUKkBzcg3
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:xDT5N4sf4Svt8J/XRaFnnDj+NcoOXABCVKavOz4ZYhlkD4wCI6wWJzWaVErJTdNWTruBdi4ePA8JVYR8nqz9Ewh3FpST5lt6wdQ0KdzxyF7vVqfjXdl2AEzjGU+ugV5foYWgQBulF+qq/mo6J38n+y0e7ER94x+urH7THinbB8yvET6m4xb3qVEWm8wV/Sk84+871ICwEsoa2qxCMbW+diTqumBezXx28IYU3jakl5yUuQxvqJKCNpCR4x54lrj1SCuYltKSvM59gSEILWIfaFHrGtog34W/Lhf0IwBFsUiNN6221sOSqbQSreJK5hdOXYMAeZSh3LvAe8OVNKGwWUmR/t9Jig3WMUbj8sMjr8VV3TkbejyABGfOZqao3Ewt9NyzVUGcjEgxo0qLNgY0GYjcYTL2/A3fcqXniKj8psWltmVO1iDhxh2c86/e7yMNSGu+svMfOLvSnYHsLrFfQw==;5:t8UaZaq2fHVJtuikb/BM7wUirzQfyTyt7aX6F59q6gwH0h5P9Qj6cTjLqYiLDmTGcUezapnyTRPXePjXrCWTQR3WNusCFj0cCp94N7cPTeSXGFtmK/T0PPcxJjrXU6iX1oLUlVmYd+KXmiIK9Ml6Cgtiu8UwxxsB5ggGkI78jV0=;24:0rFrrsSjMRLDwZ9S7/GR5oJsnM204QVat49UurALjostALjor58ST4M768GZ6jM6WShXFdm1gpohhGok3A9QCaEtglQ0veG7cfsDd0r1OPg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:9A+rUa1phDxeJLcsCAAzAJSNJJhOI1Zw9P+ig0uE2wyL34hTQzHYAp4v/f9Vhh1XQx8IZGYfRi/CQ+2bablv0z2sPTd43GF2DdMwdP43aP3gZeotkJnJ6X6BGARV4B7QzRmxFwnWSYjbJf/4U8Jh+f8glj67Bnl9iNx7+ZF/XJFL7FCHydrsGLNsSX+6KAWCT5RVdukz38OTLAKcWXjakecxa0PAarIMcjc7DScJJMarD3S6jBHaaqU/5BVDHhp0
X-MS-Office365-Filtering-Correlation-Id: 2389fdfa-7204-4556-ed43-08d5b9aaa3e7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:48.4039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2389fdfa-7204-4556-ed43-08d5b9aaa3e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 8c42ca7107b2..a540916689b2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -222,10 +222,7 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	i2c->nmsgs = num;
 	i2c->state = STATE_START;
 
-	oc_setreg(i2c, OCI2C_DATA,
-			(i2c->msg->addr << 1) |
-			((i2c->msg->flags & I2C_M_RD) ? 1:0));
-
+	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-- 
2.11.0
