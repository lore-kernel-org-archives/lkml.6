Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E8721A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="g2B1swlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E8721A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeHFOPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:15:49 -0400
Received: from mail-eopbgr700065.outbound.protection.outlook.com ([40.107.70.65]:11392
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732212AbeHFOPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmjnRXg50c4AyRCNzrQD/6LswK8s9EitSloYraVYQRo=;
 b=g2B1swlhAch0cuOIYGqiy+TK039V5V/GpOpXgUzXgENYyteWA4QldcB2D/NIN4PZMulEPxfcnm5zM5maPe7oQrTuSpzubSoPlD46oKOc6WyZB1OvQEi38z+HlZ0DZy36y8WDvdJbh2mDhvdmfwLNP1HPK0U5k3GCgASTIIGrZyk=
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by MWHPR03MB3133.namprd03.prod.outlook.com (2603:10b6:301:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Mon, 6 Aug
 2018 12:06:55 +0000
Received: from BN1BFFO11FD023.protection.gbl (2a01:111:f400:7c10::1:126) by
 BYAPR03CA0003.outlook.office365.com (2603:10b6:a02:a8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Mon, 6 Aug 2018 12:06:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD023.mail.protection.outlook.com (10.58.144.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:06:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C6sSL012962
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:06:54 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:06:53 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] iio:adxl372: Add FIFO and interrupts support
Date:   Mon, 6 Aug 2018 15:04:45 +0300
Message-ID: <1533557087-10401-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(11346002)(476003)(2616005)(4326008)(47776003)(426003)(186003)(106002)(2906002)(446003)(575784001)(336012)(26005)(486006)(246002)(77096007)(126002)(7696005)(51416003)(76176011)(356003)(478600001)(36756003)(6666003)(53416004)(106466001)(14444005)(44832011)(7416002)(305945005)(50466002)(16586007)(5660300001)(48376002)(7636002)(8676002)(50226002)(110136005)(316002)(8936002)(54906003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3133;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD023;1:XV3E4YcNaABUIfP9OTe2Z472M92o3ckhKuUHWKxOY8f2Ct5+SrclIudcPT/urBBZ3dyi06Tx28PeKJrBxTGsJGI/6Qp3BbqZvwY2bfPlL/Fnmu+XGCXolhvrGvmnmZ33
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d99b89b0-6da4-4749-febd-08d5fb951a55
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR03MB3133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;3:u0o1vGQFSXQzEyOFl4xIPUhSYbCND5EuyxtjgJTX1IrzYw2c7l1+JxXYaOE6tMjsHrY6X+E/n7I/NXcrlJXvgMG2o7EcQvnCSs8y/Kbn2M+em0whZ8adx39CMWfxYIeRd2xJLadeMwZG0x1p5URp5tDjxKudpuewwje1BRFsVTrMgXQHHiJmdpXrQyfKl8d4Jgc/ZQAJ1uEQxczPYw1F4TrmCgD2VdQ0wBj2tn2hosqz05lsbU0D9Pqdzeh+Vv2JwbCgjwOvq3FI00WO+/Xx6lJ12SLAmCq+GU8PVAkXKZwNdd5bQfc2pUpa1f+8uhnAdK8UvQgcVSw2C9OtQZJZhW/T9dACvyFTpaamYm0bHrE=;25:seR6bJG3oy1ze1Gq70PH2v5O5Jq7/SLRtULroz+fi1HBZbd3R42JUc1iZl5wGt8BzngM/YwfPTnu0WltduJ/8I/JLk7FG3EWRR6kHRVOv+8nnovhfh2n4i2WQMoq7VqcqL6RNsPLtBGOhNK0LBAntHvkVvyTFiqBp8gQszSCuTyXMgO4Vm0AnWzr4icFVJbUfrUsj55SQqQmv57sZRhc5gygb2ZnAyhFNEdBJd30DqiQ4GbbezJIlPSKsUsmuIfA8EB5iXd9QFS5UIoXLzFxtKU3Svxl53U2qOXTbEs0jt2eLlsqqCriLIUqIrdxfIMv+0tZ59ujtnzWdyJvSVGbuw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3133:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;31:UxPzVp7tdbtFsA0P776fPeExwgZ9Y1NGqOLyCGoCsQkF9quvSnqKLLW1ClQVIEKcPDJCLLIDxOyRMLRGYbJlzuBsMiwBYzoPbBAfYFQTQ1noHUYOcgZHJFodBGIC68zW2J0obvOmGKWUJIvbr3Hb0D2344cP0XnwrwPuWzBOrC8v4WEtsOQ2/SX62eBsxugnTTbWWkQz+ZqnErYOlhgGccsNIZq1Ae/j7kOUvxLTcFA=;20:jIvbsMhORnfZb9ZK0LbVdD3lKYnwW1LvCKEzpxVl7hyadHxr9CvK3rgIwUMNNZTH3j8CpJd9yM3FLEolky4tSS9s+tlms7Q7EbpscAd+6Df3nvZb9FnO/UYTjfedpyqVP3/q9AF9QoX88Bkb1+4c5KaMlGtAZ+ALecTNSC6XADhNoEAO/Z6QLuLcg4QdmmMpLqqdIGrQcOdakJQrpQkbiGYTxZ/wursk3fJPSXGCA1luP2lHwV1GpM7nH7JNGz+E1O13JUULhpongM/W994H3UU8Y72Yben1/Nt2kqF5eMOC2qDsPVD5gXgUIoK/hAQRN9yrs3aWnlMtqjQElwuaE4A/fCdmCpHK7yhcs2YzMDIF4PQ2jyqTxLDQkZiZ8fJ1sIK+V7Gtqz/aAsRTv9I1EDKo7XFgovNaxpN6k/wslmZn7lJT8vUuCuocMACX7ytPkDsF5gHWl+ZneC9hiJZmPEdZCEzBqlwj7qffvjVaDEXwxopHrc9CD76iGkfVVYfa
X-Microsoft-Antispam-PRVS: <MWHPR03MB31330ED0F48E91C9A7E14F209D200@MWHPR03MB3133.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3133;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;4:vjCboWdqmO34aVAbhxolZMVsi3oJqaF/uSuMR7Fbu3jw2ORIYNfeIfARwiY3GM/7W6HzFur+pkgaYcySdVU4ILX8vZJXYS97jRVQsE46ieWzkw/Mtv+bi7/qkPZVJngWccbiLCSR4g52/Vb8up09XJ2T6n7kdzFAKddXg4cnEpUg9pP6qje4OsRuN8VwQnCQG4fZ0qnOv7YvTy+oNRj+XPqiH2FkSCszNv6pvlIowgfwi1m908LW+c1WqmFQ6GFSXFf/4nIkOQkm+LyX8ZWVjUygW6EYThuGpMwKiuFmvJEubAKAUD9w/le1d0v59TbofTh4VqRnHhGe7gYWDnOLjQgRGMBiVYWojw2t012BvoY=
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3133;23:c5gJfFoLlA3UTsteQ3tGzCYPYK3Uq/sFjOtYb7sF/?=
 =?us-ascii?Q?Ev6tLKjqdVektyHlVor9u14n0e7mX0bQamJM5aXCvssTwZ83+KRH+3tmMdy9?=
 =?us-ascii?Q?LFBeWLYZAR9anwNfTUhOINuizBDlupIf3Ue0H0jEv0soXDP3h/AH/Uvewlsd?=
 =?us-ascii?Q?ZjXNDN1EiVP286YHifkEKAzttYeVz3dCYF+AT4eeMiR2SpiWs2bUwkhmRnzR?=
 =?us-ascii?Q?PrzotNJB++ej/18pMAG914Wb0vZVjGHBg/5iacKZA+ZREIaHfETU/i//fZrB?=
 =?us-ascii?Q?S8/TlaOHw6+aZ7xZDP1cTP7/RI6lWbcT1/X7/TQX3oHgM5mSzs0f/3BXvSio?=
 =?us-ascii?Q?t66IcvbZCD4Bvq9D0dL6IkNxOBOYUjdF2vf1o1w966ttMyRrB+ULnrfGZrx+?=
 =?us-ascii?Q?Yjyf7h82LW7K3VZwgqD62ttkrox09qsIunLeaZDpDQRoAYD7PvqsNKqA363m?=
 =?us-ascii?Q?Zkhx50XtxJz8nXAzHOp62+yPzanfpwsFCv6UI5iQFXP/995cx5r/VcGF/SOF?=
 =?us-ascii?Q?VT4JA19GaBUCTxtaAkrG2yMpo0ULrQjDYN9DANhkNNAyKq9pkB5AkPuNRx9A?=
 =?us-ascii?Q?ybRgwkLBmBmTqbKmuYqZmdoehiJkgtjW3aXd3rtDoSLSCZl6Sw63WK3b4f5H?=
 =?us-ascii?Q?640ds/9JiK4gwFYEJlzJnScHQO1Xa1HzRBYmsjelKhJl4XM5/dg3ybyrQ6Kq?=
 =?us-ascii?Q?JOoNaugJzSJL8luqdUAAdfV+/RYrDPRUmhgtyFIu4eT9mTYQnEzuZ4tEgN0U?=
 =?us-ascii?Q?RjV1+d6LropoymDLkE7S2bkreecMyAWbEAH2pZr7dTqbRPRzVZKveMFZodVE?=
 =?us-ascii?Q?khSu03GoYRQRtaBtxcjCVOtxKBEd3UaTL/k6fX9XoynsxOhkQ0PUc1SzbA9p?=
 =?us-ascii?Q?hnnUK301oGQN1Jn8dANCOIQ931jyuYFOYDG0rsiBeeGRuU4S9wcKcGOoOwRS?=
 =?us-ascii?Q?wwvUrtTu3w7YPQMJ5rdUD66GXj0lBttO6KjBk4AKqAv6epSo6N+i46zQ0tOs?=
 =?us-ascii?Q?KoZHaHYtZbjZPUK7vz+6ig/66L6H+tamZjOwlzVJPhM3coPcZJGBB/62rg3X?=
 =?us-ascii?Q?8DltrGA/Xpz2h8N5CJhpdGYdIjSM1MrC0G0X1Ev6fLa32K6x26loD1+Iecd0?=
 =?us-ascii?Q?gZAkiBD2Ig=3D?=
X-Microsoft-Antispam-Message-Info: AGB6WHhu5l1w3iRQQn1Ns1jvj7Z3qzWGGDHhz+zAu9Hmr62/Vgqs+GfCmcL1306zY3tTy3RGq01ryyOMK/CJ1PuEGYjoq8TKnqT+DrLw94qQDsv/aV8VZiRdBLdiC/K781Ryclxwrdjw4AnXY4e/+EuWEVtWn0pE6Xq9TEvtdHFEnUPdS4Q7jN1RHmQ1TjHpTuDv90XmC0nqMloy0lOVu4bZSbwlLEJi3wJ4tqTfRaZQt/BaB5uUaPgNojRUo461knXy/pVuKV4BNDLcicS7PmELsy5icPuv0toANgqgppVe6kw0j1Vlhc7o1Gmm0aEfaITyIrektKEBKIxXtns1RyHlBpCuG+4zsV2hBhzJLS0=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3133;6:+lJc8lBuhv2mY/y91xSvLTT+3CE7Y/cVmuLcHo7I6AhNPbKfAGn9wu46LQZ+otJ3LOuQfK8NMqipkA40FZYEMG8CW+v8/6LuPhe0otMjTThBS7FyEhUKnC0fmBq/712FkB/BEwThp0F1Eqqadq5BXn7kxxW8dACDn64N/LUKv0zw5+KgG6JhXYjMy2rt66GcPA359G3YeE1QxOXyJ11b8iurXiIginqRnngIJcBJJnX23qikjDH3WKEwGopHC+SL9BVUirXh/96Ni8Y26AS14Y2tAlCVrlc5fNrg6aei8FMi8R1b50pCPJKrpZL1gLoB/LQs4lBWkiuwGWe3hdziZoYn/IGdNDuY7bM0tnOejGq4zTQ53TdNS4oOhdSxLRN13QZAyYJcOaMX4yvHduMNO2N1AV8cAsRBnayFswLFFH09Q7ieUcQOnGtvp2pgWCJWjjCobR/yRq4NBba6rgw+Pw==;5:qc9n3QBY7xhUMgum1NmawEOUoIXmaYg1WfJ6Ld48/JQpYKvABhH3lXgl8JXcCPkLuKLQBVvnaGk4d8qgZstkqkYA+FijrcKBbzlSbN7xHvv6rAiZTvhPZnj2YxgdT5RrbauLXk31ikvMDLJpIzH1g+Qlow4/1oSQ/gPrOlQO4TI=;7:FjYDOjSDNVXaDDe0c7eg96qh5+zcZQFPZFlmba14McFYAcf7IzLU8hUGn7bHB3Cc1WVxEpmXMLGXgsuevKLkLit/CssKOcRGpCphjCMyLV05SbnMYALxtNkYXi0RK8Uui7yWA9avcUymLF4+IokLnLD8Rl5H2Nb06wVgW+4equDMvatKNufgLRPiKTiLVG/rUwiXOY9EInVbEDke8pFzpSyjIucI+eHsq2xqhoyn9n6Gd0B21pMB6XhsLjNo6kLe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:06:55.1460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99b89b0-6da4-4749-febd-08d5fb951a55
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the adxl372 FIFO. In order to accomplish this,
triggered buffers were used.

The number of FIFO samples which trigger the watermark interrupt can be
configured by using the buffer watermark. The FIFO format is determined by
configuring the scan elements for each axis. The FIFO data is pushed to the
IIO device's buffer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 348 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 347 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index db9ecd2..623c32d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -6,12 +6,19 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* ADXL372 registers definition */
 #define ADXL372_DEVID			0x00
@@ -123,6 +130,9 @@
 #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
 #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
 
+/* The ADXL372 includes a deep, 512 sample FIFO buffer */
+#define ADXL372_FIFO_SIZE			512
+
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
  * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
@@ -170,6 +180,43 @@ static const unsigned int adxl372_th_reg_high_addr[3] = {
 	[ADXL372_INACTIVITY] = ADXL372_X_THRESH_INACT_H,
 };
 
+enum adxl372_fifo_format {
+	ADXL372_XYZ_FIFO,
+	ADXL372_X_FIFO,
+	ADXL372_Y_FIFO,
+	ADXL372_XY_FIFO,
+	ADXL372_Z_FIFO,
+	ADXL372_XZ_FIFO,
+	ADXL372_YZ_FIFO,
+	ADXL372_XYZ_PEAK_FIFO,
+};
+
+enum adxl372_fifo_mode {
+	ADXL372_FIFO_BYPASSED,
+	ADXL372_FIFO_STREAMED,
+	ADXL372_FIFO_TRIGGERED,
+	ADXL372_FIFO_OLD_SAVED
+};
+
+static const int adxl372_samp_freq_tbl[5] = {
+	400, 800, 1600, 3200, 6400,
+};
+
+struct adxl372_axis_lookup {
+	unsigned int bits;
+	enum adxl372_fifo_format fifo_format;
+};
+
+static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
+	{ BIT(0), ADXL372_X_FIFO },
+	{ BIT(1), ADXL372_Y_FIFO },
+	{ BIT(2), ADXL372_Z_FIFO },
+	{ BIT(0) | BIT(1), ADXL372_XY_FIFO },
+	{ BIT(0) | BIT(2), ADXL372_XZ_FIFO },
+	{ BIT(1) | BIT(2), ADXL372_YZ_FIFO },
+	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -177,6 +224,13 @@ static const unsigned int adxl372_th_reg_high_addr[3] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 12,						\
+		.storagebits = 16,					\
+		.shift = 4,						\
+	},								\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
@@ -188,12 +242,29 @@ static const struct iio_chan_spec adxl372_channels[] = {
 struct adxl372_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
+	struct iio_trigger		*dready_trig;
+	enum adxl372_fifo_mode		fifo_mode;
+	enum adxl372_fifo_format	fifo_format;
 	enum adxl372_op_mode		op_mode;
 	enum adxl372_act_proc_mode	act_proc_mode;
 	enum adxl372_odr		odr;
 	enum adxl372_bandwidth		bw;
 	u32				act_time_ms;
 	u32				inact_time_ms;
+	u8				fifo_set_size;
+	u8				int1_bitmask;
+	u8				int2_bitmask;
+	u16				watermark;
+	__be16				fifo_buf[ADXL372_FIFO_SIZE];
+};
+
+static const unsigned long adxl372_channel_masks[] = {
+	BIT(0), BIT(1), BIT(2),
+	BIT(0) | BIT(1),
+	BIT(0) | BIT(2),
+	BIT(1) | BIT(2),
+	BIT(0) | BIT(1) | BIT(2),
+	0
 };
 
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
@@ -359,6 +430,112 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_set_interrupts(struct adxl372_state *st,
+				  unsigned char int1_bitmask,
+				  unsigned char int2_bitmask)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADXL372_INT1_MAP, int1_bitmask);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(st->regmap, ADXL372_INT2_MAP, int2_bitmask);
+}
+
+static int adxl372_configure_fifo(struct adxl372_state *st)
+{
+	unsigned int fifo_samples, fifo_ctl;
+	int ret;
+
+	/* FIFO must be configured while in standby mode */
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	fifo_samples = st->watermark & 0xFF;
+	fifo_ctl = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
+		   ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
+		   ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
+
+	ret = regmap_write(st->regmap, ADXL372_FIFO_SAMPLES, fifo_samples);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL372_FIFO_CTL, fifo_ctl);
+	if (ret < 0)
+		return ret;
+
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_get_status(struct adxl372_state *st,
+			      u8 *status1, u8 *status2,
+			      u16 *fifo_entries)
+{
+	__be32 buf;
+	u32 val;
+	int ret;
+
+	/* STATUS1, STATUS2, FIFO_ENTRIES2 and FIFO_ENTRIES are adjacent regs */
+	ret = regmap_bulk_read(st->regmap, ADXL372_STATUS_1,
+			       &buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	val = be32_to_cpu(buf);
+
+	*status1 = (val >> 24) & 0x0F;
+	*status2 = (val >> 16) & 0x0F;
+	/*
+	 * FIFO_ENTRIES contains the least significant byte, and FIFO_ENTRIES2
+	 * contains the two most significant bits
+	 */
+	*fifo_entries = val & 0x3FF;
+
+	return ret;
+}
+
+static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl372_state *st = iio_priv(indio_dev);
+	u8 status1, status2;
+	u16 fifo_entries;
+	int i, ret;
+
+	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
+	if (ret < 0)
+		goto err;
+
+	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
+	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
+		/*
+		 * When reading data from multiple axes from the FIFO,
+		 * to ensure that data is not overwritten and stored out
+		 * of order at least one sample set must be left in the
+		 * FIFO after every read.
+		 */
+		fifo_entries -= st->fifo_set_size;
+
+		/* Read data from the FIFO */
+		ret = regmap_noinc_read(st->regmap, ADXL372_FIFO_DATA,
+					st->fifo_buf,
+					fifo_entries * sizeof(u16));
+		if (ret < 0)
+			goto err;
+
+		/* Each sample is 2 bytes */
+		for (i = 0; i < fifo_entries * sizeof(u16);
+		     i += st->fifo_set_size * sizeof(u16))
+			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	}
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int adxl372_setup(struct adxl372_state *st)
 {
 	unsigned int regval;
@@ -438,7 +615,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		ret = adxl372_read_axis(st, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -454,9 +636,137 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t adxl372_get_fifo_enabled(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->fifo_mode);
+}
+
+static ssize_t adxl372_get_fifo_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->watermark);
+}
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_CONST_ATTR(hwfifo_watermark_max,
+		      __stringify(ADXL372_FIFO_SIZE));
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adxl372_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adxl372_get_fifo_enabled, NULL, 0);
+
+static const struct attribute *adxl372_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int adxl372_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adxl372_state *st  = iio_priv(indio_dev);
+
+	if (val > ADXL372_FIFO_SIZE)
+		val = ADXL372_FIFO_SIZE;
+
+	st->watermark = val;
+
+	return 0;
+}
+
+static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int mask;
+	int i, ret;
+
+	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	if (ret < 0)
+		return ret;
+
+	mask = *indio_dev->active_scan_mask;
+
+	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
+		if (mask == adxl372_axis_lookup_table[i].bits)
+			break;
+	}
+
+	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
+	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
+					  indio_dev->masklength);
+	/*
+	 * The 512 FIFO samples can be allotted in several ways, such as:
+	 * 170 sample sets of concurrent 3-axis data
+	 * 256 sample sets of concurrent 2-axis data (user selectable)
+	 * 512 sample sets of single-axis data
+	 */
+	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
+		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
+
+	st->fifo_mode = ADXL372_FIFO_STREAMED;
+
+	ret = adxl372_configure_fifo(st);
+	if (ret < 0) {
+		st->fifo_mode = ADXL372_FIFO_BYPASSED;
+		adxl372_set_interrupts(st, 0, 0);
+		return ret;
+	}
+
+	return iio_triggered_buffer_postenable(indio_dev);
+}
+
+static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_triggered_buffer_predisable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	adxl372_set_interrupts(st, 0, 0);
+	st->fifo_mode = ADXL372_FIFO_BYPASSED;
+	adxl372_configure_fifo(st);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
+	.postenable = adxl372_buffer_postenable,
+	.predisable = adxl372_buffer_predisable,
+};
+
+static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
+					 bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned long int mask = 0;
+
+	if (state)
+		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
+
+	return adxl372_set_interrupts(st, mask, 0);
+}
+
+static const struct iio_trigger_ops adxl372_trigger_ops = {
+	.set_trigger_state = adxl372_dready_trig_set_state,
+};
+
 static const struct iio_info adxl372_info = {
 	.read_raw = adxl372_read_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
+	.hwfifo_set_watermark = adxl372_set_watermark,
 };
 
 static const struct regmap_config adxl372_spi_regmap_config = {
@@ -490,10 +800,11 @@ static int adxl372_probe(struct spi_device *spi)
 
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->available_scan_masks = adxl372_channel_masks;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &adxl372_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 
 	ret = adxl372_setup(st);
 	if (ret < 0) {
@@ -501,6 +812,41 @@ static int adxl372_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
+					      indio_dev, NULL,
+					      adxl372_trigger_handler,
+					      &adxl372_buffer_ops);
+	if (ret < 0)
+		return ret;
+
+	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
+
+	if (st->spi->irq) {
+		st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
+							 "%s-dev%d",
+							 indio_dev->name,
+							 indio_dev->id);
+		if (st->dready_trig == NULL)
+			return -ENOMEM;
+
+		st->dready_trig->ops = &adxl372_trigger_ops;
+		st->dready_trig->dev.parent = &st->spi->dev;
+		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+		ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
+		if (ret < 0)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(st->dready_trig);
+
+		ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
+					iio_trigger_generic_data_rdy_poll,
+					NULL,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					indio_dev->name, st->dready_trig);
+		if (ret < 0)
+			return ret;
+	}
+
 	return devm_iio_device_register(&st->spi->dev, indio_dev);
 }
 
-- 
2.7.4

