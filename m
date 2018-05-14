Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbeENOzu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:55:50 -0400
Received: from mail-eopbgr20092.outbound.protection.outlook.com ([40.107.2.92]:12352
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752325AbeENOzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:55:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 19/21] i2c: riic: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:28 +0200
Message-Id: <20180514145330.4857-20-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:1P1gjiNGh5fihZQfM4ac5nIsm8HQkAYYUnO7DeL4HeGkXwgEMXimO8bh7be631FckWr6Q8qb6RZ7T2A1ONbNBvcrkVOwn1dltd7Xgl9jiliKTG//AWXSHECdrVH2+rIBfd3Wz8RLZhqfPSJj4aWz5ZDpc/vmkHOEpR5/BqJbg42/baze33Y4iI3Wj9fZrZyUAsv+WsLZEIn23G01h38DVqFdZOfX2EtGdmLe73RmX4qhfLf15nZgPNtm7TtKB2OS;25:gFLsR068Jy+sLsUOo0LR0gRzIJ5rmqVgkmchyD4xXiCZykzaBmwzV0IcE3LzMgOWRXv+PHEEpKz9CgN5tD1igw0R9gwirxFKE0qdr620BH9lW1UoYN5XI8xgchJQG2qz9EuAogbe5XCwJ+XpdrSMhyz/w9VNIs92TtUJfPScGxFVXaLZhnHfPBw+b2KZc79UFonREPAKx1dG2lrXXoMI++i3j6No19grKhTXdD/cSDJo6RRCLfPEQzAtQn2FbRRWKclrgvzq6VKaluQYWOJPGQVMGktSfMH4rccLCtc9BTonDLuwBt7K898DIVbvqMjcaYkfgVZazpUAVbdKW9t8nA==;31:UrcMqepQiEyoEP94Gts7pqDPc8VwBNJ8Q0akp2Jht79vssD4zvz1hICDUcYI0d1kq1y4AhCzMJ/Dxohu+OPaYfz7tx6KZH7Nteb42GWrM+6EP1ZeLcNjN72wxEAgp196oMNJtmQ6gCoWa0Y/Alb4WAcnuoYahs//g7aedLaN+XYktervQwlwEn+7kXJEZJxoZbQQbFYdIN7d8o7hJNyaoUEuQyUlkFseBXL/Ma2sIz8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782F55447C4A2E89AEC3828BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Nq7brudCE4WKLcsRBZjMByARuYiu5U+GjyUsQlqgDrr1ttwd6iUmC1yG4V1MpBQkxcLvr+YvzBL00JLEdWdJ6EDxLmbXOqKXILa7D5TR4F4EfUnYmcNEgs1x20u2REm5sdZ7+V7iqVP22z1X7JlPoWV0TYSumjsPHrPo8xrFw2Z/mOuneURCythc947pfxiUTfj39gMvqhOqU+6tyPQFLnsDSYdtztcKA0C1Yfbde5P/m0yvYdi/8cEzUUzLBbAL2CbGDQhZ6a505NAWphzuGw==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:hMc+qiJQIais7tgnucVRByf78xt6y/c1rGlCsf2?=
 =?us-ascii?Q?x2Hzd/uVXxVe0669MUBSD+kA2m7mu++qIfe1yUqH/WbqmJHo65l7/N/QFJDX?=
 =?us-ascii?Q?H5oSZjiKZRcavIZMQ4aqh6Z3bYanp36wG4plFs80GKId0rPCTziv3HhQG3Fi?=
 =?us-ascii?Q?VJO3d4NmDQkEBUPvdPi+P+0j8oZno3ERM6+hcBZT67HuMBVRfQFWxElLLLQ0?=
 =?us-ascii?Q?9U3mAU1MKY2t2FDs/y1htK3YQe5WYFZM33+1bB6bJkLEOIDcStqBIG+Bjgg0?=
 =?us-ascii?Q?HIW2Cr1o5BoDz79AR4W0Ut7qH+oF/dGsfp8zujbLQzwoRn2EBZzZC5+iuu7k?=
 =?us-ascii?Q?ro2lO+R9FXEJfkxQ4qCAOHTkMVj6VHHUbGoOVYZwvzSHKJl9iEfaWpwj55Xt?=
 =?us-ascii?Q?xpJoOGXaIXoUcCH8ZeXiCRdTF3dNTL6I4k4Aeyy1VVs9RWn8T78Atnuf8UdX?=
 =?us-ascii?Q?LFTrziEX8xG1a7Zic8wsvww744K7Rcw/SQLm/wF/l5tSadnU9zVjcYyGRv3y?=
 =?us-ascii?Q?hEdoma04KeIXuAVwP/o/oGzNi9pt83tKVheVG1DjXmqUG0RK9n2MhrcEBL0B?=
 =?us-ascii?Q?P/fGzS66eyT7WV5XL2l6r5q9uOP179gHUN1M+KrKBfLOgjJ8UrdO+nqhqdPu?=
 =?us-ascii?Q?TiMlrUfGHWRFD6Fcz4R30jO+OZnJNJF8/+o6vg4MfJ9aV9ic+q+Ww1hIJrDn?=
 =?us-ascii?Q?b4wugHUmnevqMNB86BDykZLbrQribsbMfE+Jncq73yf19JUMhxK4aVbwOuxB?=
 =?us-ascii?Q?R0QWjdK8SRP6pO2Mo3emMpd3aOILzrdHVAk8gWwetfBFYoH+3S48181wwOYY?=
 =?us-ascii?Q?WWJEsAP1QujCNOFjogWI+FuckIfx/6sqeXat/RkT1+5ipY+z1MDw7zh81sg3?=
 =?us-ascii?Q?3IpR8CpNzglDL5MLPO09kZp2rVqhYgXZWdygA24fAYzvyL/r4b0gyHjQel7Z?=
 =?us-ascii?Q?EB2UkGXZHXrREJdplEB9iX2gZxoDR7jz/+Zml+RZBiDW8pm9UOG6MxsrwW7O?=
 =?us-ascii?Q?rfF1jZgiw4FZghyiDdBnpi2mkv4ShU7aWx5iuJu0GynX1f62oYVxFd6KVmQM?=
 =?us-ascii?Q?XTSznYn+zaEkEMO6GePkIB1txXsssTWTPAVHQ6bu8ES+GNfhV7H4me/85rcc?=
 =?us-ascii?Q?9dGFeOamy/emyIO15j+ZMQ44gOO5A0+pzbk9B2lMNC4sYzGN8nv6xwuF6Iyy?=
 =?us-ascii?Q?ZfSipfKs6uALD3Lgok/qgjJCLzOIjx/TdKZev0EQaGx6yFe23BT9wov8tHR+?=
 =?us-ascii?Q?kPdi3yRsKe+KG5wyuUIZ8BTnkp5CDI6n8ShYOirHCu05keyyPH60lYRxh1s3?=
 =?us-ascii?Q?0MRPt69peKk7g2YqAjfPp0YTDIxD5nO8Ud41DZtaWvw3v?=
X-Microsoft-Antispam-Message-Info: 7kj1wzDI+BwLN4BCL1A943ZrLhD1+JcFExH6vSmXkC885ielBk62iA/HvmIqRnZAVIbHnmhmcIh/N4H43G+FHoc01quf/XyrzwtatVJL5Kyr5dYglJUL3rq6sQb7lfX/uJZsZBOXwKTGDACMBOVp884XRCnNYPwHWQvr8AVGg74y0uJ/6OPkaC/xUM+d6bu6
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:4I1REJciekc/UwqDgbsm2sy8/ZKOvpWAW9U/afzV2uPrWMZIx+L8yvcUBa9CcSBD7i3M4wZ3HBTjDy2dbu+OZsvze5XenREpZA16T+b3beKWqNWDJGImoH7exkzigF/dcXQpHwjMioooYqmegXgM9fQRkYsm4QIkm7dabOd7bDvwUHQO/cDCjK0jXFjYixcdMmsVaScjl8/Pa7k+1kohW14tXcxcN0Te/e1xFDs72P8VyAmno1E72678UKhA/0kBoRVOFeCKPo0WfTRoj5bjKIOx37meoIz/1kxfgkBJhHf7e9Nv+SVNwdgpb+XJmTJLm7tyLT1VSlFQ7i+PIPybWvfPa/t/xr2+x0gFrSwLFUvtHlgDovYTNdToaQr4R0p+y+aDTZLnlPH9hKriP1Whm1tYebYsx4ECuOFTLlNAowApv+xpl+D3Fod3tXcRZrlRJyzP9H+qAvUAg2qntwMGXw==;5:WZG1WaOXY3jfj0GgzUMuEOWFHE4cvD2Rk/H4+SPQSlkxrYap7MD7AL7hVbZhDZw6YjzOnntRkarLagCwJDrDkl2/0sobl/3yM8C7WnfxQur01NrOA7uJ2BI8L8s37vQ2VGiyvvBl+64m+/Z0b6RigvQJcd89OjAGlmLkaz7XDPw=;24:woXLqMIbMHRapl+HGTHYEiDMaw7p+IZ451WdhcZoogoBRndtKPPcbqaddF0cPOpo7lxKQFEnUdsQChKOBVxawjSBqzlA6T9eQof1F2lQVjs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:lI3ixjOpxnDtpK7ZZ+qxDMRGk1P++oAcz2x3wX8iG3PRvlqRmeewAbwRIXAD/OCydblvfO0WtqofdDjVXZqYzcm8kt9E/OSvU41jyJVLThyZK90hu8vjfRy1jiIsIUVZlrLyDd5jaarCJ2eGQoxVlVAUk2UJfUtxJB/iNLhbI600JBM3FJeZ67UehaOEnZ3OFtmemkDGtFWxVdLjqQZ1/nFHwes4JeXoBU+BkaEbuGgDqjpCfsYXWCDBT7mDEDVC
X-MS-Office365-Filtering-Correlation-Id: a7512774-fc51-4767-928c-08d5b9aaaa20
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:58.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7512774-fc51-4767-928c-08d5b9aaaa20
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-riic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 95c2f1ce3cad..5f1fca7880b1 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -167,15 +167,14 @@ static irqreturn_t riic_tdre_isr(int irq, void *data)
 		return IRQ_NONE;
 
 	if (riic->bytes_left == RIIC_INIT_MSG) {
-		val = !!(riic->msg->flags & I2C_M_RD);
-		if (val)
+		if (riic->msg->flags & I2C_M_RD)
 			/* On read, switch over to receive interrupt */
 			riic_clear_set_bit(riic, ICIER_TIE, ICIER_RIE, RIIC_ICIER);
 		else
 			/* On write, initialize length */
 			riic->bytes_left = riic->msg->len;
 
-		val |= (riic->msg->addr << 1);
+		val = i2c_8bit_addr_from_msg(riic->msg);
 	} else {
 		val = *riic->buf;
 		riic->buf++;
-- 
2.11.0
