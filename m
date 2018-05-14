Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeENO4h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:56:37 -0400
Received: from mail-eopbgr20094.outbound.protection.outlook.com ([40.107.2.94]:21184
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754070AbeENOyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linuxppc-dev@lists.ozlabs.org,
        linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 16/21] i2c: pasemi: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:25 +0200
Message-Id: <20180514145330.4857-17-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:Fm7VfqmdS6jZZW0bHu6yxPAoUI2Al2i7oRbr+et5B2DMUfawLBp1NV7O0A5A5VEp0mlB3fHwQhwKphIHz0xEDAUIa6B0g06pXeafSBLAXP2j74QHWTsIqg+yYYae0VkvK93dXeApMpsLnlJeOb9176TL5qhnOo5Jsun+qESxfbupLKJhBExHOIJduMJJMtNCvremKrd3RvOdcOqtGU/LSPkbMt1o3ZygmpIUEH0y2Wcn8WALWXJ+xcBVaT+1btQd;25:I83ZHYNsO/XKDfbeXcj9zgZy66HqyLnIL111w9nRQxgzESXHEm9eCbqQFx2jqpRNN3uNU4JJAuu2Rlhtxb643+mU5HRgOqPrFoHguk+n2D7nXvYNnGWpBPg28z8t303+oqU1lWfjOjL4sKiEdmiXpQObbLrBl8iGq1/MkxfeJn3N3G0dpBTT3JGQv9jwRYOB3R8cvSLcpwuTshrCO0PzKNNS8qwQ/lbsjB1R6FNfR+LBKkT7yW/PFD35NYyk3IoO9uBqxMqr6DP4i+qrA2PVBR0Z7gHT3CyJLVLVZjwsCXERQdugS9dQOk3FQIqCZUwOy/u90XopSQMZSqVKtJK2fw==;31:o2Y5GCEsS+oNjY98pkC7EOQCWJcHx5NkV7V8Iio51JVFWA+kMetYxsWDM8lByMr9NBqaAPHDPlN0sSOhn/N2YKLBBaoj0M54Fm8gMymvHoDaBQW3i+/RvgofEhhSOWXy8tuXY+I9nmp7nEW7nalJGJ2qlcd+5HO7qWhnmdx25UKBDgNxl6suIeE3GDaEWxphn0NEAm4NqkpNHAu1bdj0IrbZJfcOl/9SV5Ta+s+iFXk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782913EB2A836F04C1F9A6CBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:LVOl4fl+YZNGKAbg0l1hKqJeIT2rC4kvj786Kez7f3zN2i63g0qgNkE5Ubu0Fr7zIEj6BAT9QY3dCBrz64s35dRqqhsBAsPizs4W8L2YdciMSXmuUhra4H9OvNyOPP0YalYTrtgEsJbnG7s1PSZbRkS1SjfS35h9X9b5of+KIHIuelXPvuBp4RWJGs4rfFV1AvtyTYcIWEVAdjGRvMsm3/yFXftaL1uxQxl3RAq5Mt/oZDvjZwtaA7zb5BRbcTVpUBvCSiruzMAWRew8X/OSoQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(59450400001)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:iYuDD/jz3stfjfUBW9F9hkH9sq9BclbgemrLGjj?=
 =?us-ascii?Q?uGIaxNHylOmH/tPa9isf7359mN5+8y+oiTqya2+IceGThaQmWrUcU+wAkVGJ?=
 =?us-ascii?Q?pZGDrk7kTCSeMjhk8rF5Bw51zK6+pzBSSH63ITWzClLavOtt12QyuJsVXbUg?=
 =?us-ascii?Q?cZ5r3LHbRbFU1qELimZbIcMeV4Emqi01RCONDchIqA17DtX901hq7kEkiLUV?=
 =?us-ascii?Q?amjeKXuTDHZOjUtmGkmJzzsrE+XFoTEx+w0kgK6vnLKCpNIYTuwnkXq7C9Ih?=
 =?us-ascii?Q?JGCbw+dTJqm2RKaOWaM8JFkRXTL5e6yvi2E+BE+JBkqy/UoSC5r8RUG6yJuX?=
 =?us-ascii?Q?jDWgVxpB05Z955NiRWH3HUry8jIJxrlc2scfuDA7KrDIKtStYDJ1BXATlz/S?=
 =?us-ascii?Q?7LGLMj7U+ydj+27WXVyHz0IiyEPECT7RPEyZa300hJ0+d7tAlgpkWQrpHta+?=
 =?us-ascii?Q?Bs0ufWsaHh6eKcxGK0rbEcsD59e/w2IcU40LfrxLL3U5HWIDEkYdb4k1Tj+a?=
 =?us-ascii?Q?DYdoSwXKofQx2Y4PrjBrIxxMIa1BbdDVUL9aQUWHxCqfnO3yA3lyaNP4Wo4q?=
 =?us-ascii?Q?oQ9RH1mnU3DJk4Nlig5ExMMgqNEM2uLbALTL8AHlXODQuKbOOxVctP0zKIaJ?=
 =?us-ascii?Q?e57W4Yun7ErR40RKhi/YsVaaS55Zg0tQ2g40rkjwBkIKUsgfrgEtnI7th+Yu?=
 =?us-ascii?Q?dbJlySisyfwxOmzC/FGK5o4p+hjaeHcKG5xrPoGNk/Uq/ooqDsBaj2im2Oae?=
 =?us-ascii?Q?wUXkmbJ975IY0oSV8cztddBCig++WHDveTazXOocXs5Hc4+ccC1iun3ixObp?=
 =?us-ascii?Q?X8c+lSELYiVL0Dtwo/zx39i9lNPmyM/V+ilSu/lpRlfYn4KzhMeHkDoCFyru?=
 =?us-ascii?Q?q4iRf7afsaCc9VhL3aOmI5UN26K3jJLpygHTJZL0DpOBdKO8SpPXzYScP9Ea?=
 =?us-ascii?Q?gsTsk+6EJ1yziW96leLzSR7rYpMdfE7SbRMLl0cfr3HKP6a2EK12v5zbN57M?=
 =?us-ascii?Q?icaft1OdsjbLhmpNWh2S5b14lBsIqGIcsGzdgcEOwpwLf2pCpXak0Q0Cq0sP?=
 =?us-ascii?Q?+MGucmzR8RXZ3f0q+eVUKPYILGyQN6faifzDDJyr0LiqG8GPgfpuWaNeLE4E?=
 =?us-ascii?Q?D+8wrZUmLTlgPSme8ilHtvoV6GnBk9HRhmJEXCX9NPzteuTOclIouQLu9TYL?=
 =?us-ascii?Q?Wazgn9v9kBPy0/E8awQg64E4uth79hSfOCRirAtWKWGrmd+ve3eDbNul3AI4?=
 =?us-ascii?Q?mg3KyDE09DSGrQ49iFdkbpcrAo0uI0xq/s4sxWzuRNrdIFUSB/dp7O6vRhpp?=
 =?us-ascii?Q?ogxjNhuGIstnxY5IH8C5Ijp7mFARt4P+A3knFqEnaGMv3m3kh3ZSSfvENOD5?=
 =?us-ascii?Q?oKSnwpQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5eTM+LQ8ubQoSs374nGGEkcRurt3cIobzR35KkwCfkUMXKdgFeW0bbsyY5ZkGa1oDJVP0aA/24jQCq84+m846TqLtt5jgL5CgoIKVnN1dEmL9ZkfhuWfS0rm/k294ADp74yi4V11x0riHZ7ShB/gC22gJ1J6ymKZVILgZ/J/p7pNsP8UH9eVOFxtVfmQqLaY
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:Vy3A6qngrNa+Dfyavc4Ova29dH/TZgb06c4OjnFSjDyWxCId7CceAwgxZ3LcU1RilpGCAGaAu0b4bdMF02C7eyutkt7Y1rlsQGCIfi00VokkjaoTFccJtXuCEOrLTlEr8HHdJK7J3Z7EqIsS2wt6qbJ5HxAn8c+krA5NCbxDFQU8C29l17SDaa3TbVmY/oK+LlfV7Ww1Yjka1jOPQ1Ne7Jq1DoIsDDxIw4NR+eZfan1BP7raM0OKKoeNjDSwr501/mtxXNP1FCF55FufBlwHLne2S3nZKt150zIjuZW0e0OZ3sniP8frIK+2FuqITXj7i1VwrOXa6v66JfkMmE6IwpqquUx036ti8IrP35VaUJRKLHr5/0kJemjZ5pE6j5K9xdJVJke/MYI0OjRvKv+IMpCOKpVaKyaYvLVK1ZBa7ulqsERl6KZSz4JQywSd+Pe2hldCgN+1vuPUanJ+D0puFQ==;5:xaCwjUhLDXHMKq900EQ+eVtMFfzx8vyqReuMflbtEVJf8vhXlzdap7qbA32q5h8+LsMzsqSRtKuT2fBPex16U0W2c+k7SKWCu5OlXP3VlWIv/Moju1270HB6VCslUKSO72CoDEZ92SXPrMKRwI/ZKGQ7h83UL5HXrx+Cgk9Uhqs=;24:TB6yA6Hu0kGLmDpsHH+3q4JBJ9hE7rZCfSfAbf9rsgwize0rkGcBFgizhcmJWcGkzc82UAYY7/AuVr+ohEdmt9tOuBdSbEE4V7OJR2qJjQE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:AqiHSQ5sH6Jhe7oG67tXlnBG0tzDEjT1MUrQhW3QngqxwFBTTceoWjXHmkVlltnNTcVZp8heUPFQRmZ7HQGlRDG3mVJn9ynRSP36y+qqwDU0NrEhNVQTeTjrsHplwUitRevduQq7d1BFmvvoR8GC8NvKMMSzSS6lM4kLKy5xhUEbSv9B31/1cVw2w2h/JHFa6STEHHqFhBRByWarbxBXlKZG+NSBIjahMU/fzEAN90MR4e19kklet3AcaVwMYnCi
X-MS-Office365-Filtering-Correlation-Id: 59c7737d-6dde-443f-13d2-08d5b9aaa5b4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:51.4195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c7737d-6dde-443f-13d2-08d5b9aaa5b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-pasemi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc92a024..55fd5c6f3cca 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -121,7 +121,7 @@ static int pasemi_i2c_xfer_msg(struct i2c_adapter *adapter,
 
 	read = msg->flags & I2C_M_RD ? 1 : 0;
 
-	TXFIFO_WR(smbus, MTXFIFO_START | (msg->addr << 1) | read);
+	TXFIFO_WR(smbus, MTXFIFO_START | i2c_8bit_addr_from_msg(msg));
 
 	if (read) {
 		TXFIFO_WR(smbus, msg->len | MTXFIFO_READ |
-- 
2.11.0
