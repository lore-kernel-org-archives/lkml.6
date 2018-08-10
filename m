Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E04C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295B1223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="SigCpVJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295B1223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeHJLPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:15:52 -0400
Received: from mail-eopbgr720073.outbound.protection.outlook.com ([40.107.72.73]:33760
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbeHJLPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUhSTTFWjq9QtTKogSkoK6OCRvNrcnQJQ5bYOOrEfBA=;
 b=SigCpVJPOIQQDocK5gPfu6kC1pCHHgcwVtUGknpcy5u5N16GtcJUJcwAXwMMwWsr5hYBaYXikvP2mAWvCY6bXsk8HzBoUUJ/uUT/PVfP7CNJ13GX6dMWDK3AJcXyKq6/KCabnOe/aQH+VGw7siS9+OAmpOkzKIsIZNGurFneyGE=
Received: from BN6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:405:6f::14)
 by DM5PR03MB3132.namprd03.prod.outlook.com (2603:10b6:4:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 08:46:51 +0000
Received: from BL2FFO11FD016.protection.gbl (2a01:111:f400:7c09::144) by
 BN6PR03CA0076.outlook.office365.com (2603:10b6:405:6f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.22 via Frontend Transport; Fri, 10 Aug 2018 08:46:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD016.mail.protection.outlook.com (10.173.160.224) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1038.13 via Frontend Transport; Fri, 10 Aug 2018 08:46:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8koIe018856
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:46:50 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:46:48 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/6] iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
Date:   Fri, 10 Aug 2018 11:46:18 +0300
Message-ID: <1533890783-13456-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(438002)(199004)(189003)(44832011)(305945005)(486006)(246002)(446003)(11346002)(2906002)(50226002)(476003)(426003)(2616005)(126002)(356003)(7636002)(8676002)(14444005)(1720100001)(575784001)(6666003)(53416004)(106466001)(7416002)(5660300001)(47776003)(6306002)(26005)(4326008)(106002)(54906003)(478600001)(16586007)(110136005)(50466002)(48376002)(7696005)(72206003)(76176011)(51416003)(966005)(336012)(8936002)(36756003)(77096007)(316002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3132;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD016;1:s5h/zcSlvlYAfaixPZzChEAZCJCckhiD10L6fCS7auTKAdw96p9RCt2qL8iwHLdx5iZpmRw/p1UsSvFWR9VdyImp8+I8SxLcjFT8a46oQMbzR9qbTOcNLlTXCLnaaTBC
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b6a164-173f-41f6-6322-08d5fe9dd093
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;3:zNmWnazztKe/XOeM1eaSGZ8JgkY+Plg9M5P1qdOCpxyvvdIqzrslkrfX2ZaGFJ+GwXbEUrYWXBEGYvgE5pOlNxjOpmFY/6t98/L61BLYuMFoW9n0cDa+pPgxk+XGCYUrI5e+9ASNkIkwBwP6UKCHtFdKtMNVs2RcH7AaSLYSrv9D52daQLgkLtwRWcX2JZuyoi7thbfRfGvFUaW6s2Darxm8+jtrQC7C9TUNUFXTHGBqPS6JCTAlrvJ+4iKp6wa/9zHjBzJSaKsvRMCsxesl3zIQjC4b5dDs5QvpwT0dk31bk98MRyabxU4UbXpHdvq5pKSta0s4Xc7qcknQfY0IBdi65nCjhQkwICSzRtjfQkA=;25:MElYYjoooauAdOFiMW4w+G5N/woWQNB+phMhdE2PpS9GynxwqZ96iTOjazGzaA/sz98pOgHEGORVaJ5PdgSAalaZE1w6oBupxggrKx5rWsylPAZSsa/Lf2BFfS0h+0cEEaykB+3qy2e9G/xzsE5GqSEf4ApXzLgmwG1B86h/roEhkhrRMAGs4zm+gf7YILt4n43GEio/c1qUr4vlgoozGb2a8zQV2KoF5ZkI3Ov0bUQniyDtIyjYbkbN3frWO89VVmmsTl2eveFvHUNPJsbjVbeE4+HFWVUGylBDQcbIOZPoRekAc0QDKZAgAXI8FFc1kcFFrcen59ALfA8aHzls0w==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3132:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;31:ZZaBfKDONtKcox3LrjP4mAxI5D8Oci+xnabX6yKoC+ar0M52MVi38BKa2eLYu2JuULRVz9Nje2/KYESumLRhQLSiT3BqSYRV7c6UJJAAxBGtIhzh0LTN8pmwqErK5BtsicGKVmdcQAYU3WkNQzva8vQ1w/QCM+2bd9TowonYPBUUb2ZoWiFFSMA9ZA9noaczSqOh5BN9wDVSlKrshW3N7syGtA6O+fonwc7fpTQ0kDk=;20:92bIOseo79vybicLp0aHMeu2oIBmk4nNueeswqtfGtdJsTN3rW6pw9dr9mH5LMYcJjjyv26fuOuSHvJa2VNqh6xZ+cpYvSlUPsDSzr0zm/1wIVWCzBNrHudutXD9au6vQgNsBDstKx5ZZ3H1v+ZhosSfL1ZSFc5Bc2hHsK/tL7wyjwS/djvwc0w7LTkN+iNx4ZXuoLn5DFg2q+cgzEUrItqDfvPBdI8Hmzx9ssT2M1qT4qQMaPPOugymiDFnBY/q6Whu82rgdYocDk53we7RbFGzvA8c0AkVH8i09okm13UaMdcdv2wYFzwb3NEPWdPC8In7GgE41gw6rkpWFXEdZr8HPlYoqkUVNvSwtySXh3upcEmDkqswRu+0T3nfjNItA8FiJPu5XVDuItU4C3Uk7tYlRk+vkq9cGe2c2l1aqDPAXjY2RhmSUG6C0mo8ba4H64+Z8GiMSYa8huowAEe+FsPiw0RJo/UFPqiPHQh+JRHYt8U3CnXGLhC/5zMGriyU
X-Microsoft-Antispam-PRVS: <DM5PR03MB31324E4C5287AFBB958A48639D240@DM5PR03MB3132.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3132;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;4:8vH6gtifcFn9oCw4nN1wjhzOhF9UV8gCmtzB5k6inxxswVv1JGuekf9VfAgUugPXRsdX4KuK6REyaYfj0Qb1n7D1EPVKMxL5yIjjN9Qj+mOv69UN57M9YS3lP4k+jXRzuUqoeRG+E8Q1vFjO2s+efz3fn6VfJuGtT/Ii6M89dp+l8wbAGasrRiC0nHd7fLAhatF4EPN6OIf1tk9lRTAMfjAijiB4TjovCKlLEps6Od8peyo5ahZOS6+3wX6CfhOBl6qjmzJDwEyL8JoPCRXXEBopQsPqWXxXLxql3Um35Zay8MjtESreMAGoQ2wzIwshEYDcIUH/6zdWVybHt+dLt1ds5i1Zn5+lMfgX3+tyUE0bPB5mmH1ry++pYMs/Lh9pUALy4zFFLnxpt1Pfc7LhzaEiLzKxIgRgRu19Qd0+DGU=
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3132;23:MDyRv9Wcjqep0JIJgEHZrVQfttXPAcBjE925XZJJY?=
 =?us-ascii?Q?1JMqNBucV6GVUNQ3YJW3bqXcZ6oXzRuNA4Upa5ehckQ2FesdpHXPSw3qQ4lK?=
 =?us-ascii?Q?L9QFONFqfctP714opCiEVsGG81u/Ntet41dSDrrO3BFex/dkQ4X57AYgsEOR?=
 =?us-ascii?Q?pYR1uu+RLRmbHhZNIcgQAOdBtWf0KMLeeG8alQwYbhaX/dGq9KWrdmt/eC5l?=
 =?us-ascii?Q?veLlm1+mmU+DBVli+kdVM00of5ogAZlEQUrJZYUOD6SIcXQ/XtHTE/VTOsnG?=
 =?us-ascii?Q?zbIWG8hBph3sclLDIF1/VjMBzxyk95Oj+Sam1zatlj00aRjZEvWXVhF73/eg?=
 =?us-ascii?Q?PiDRg9243RSTde/1sglSju8GzDaN6nriAtY7HmNq0V3KBMZIxqS9+lj4Q8BR?=
 =?us-ascii?Q?JKyh+YDKKURFEmQZlk8DjAB8wZMz7AawzD40UrcrEZyhLuVNgUrTaOsFyrZ4?=
 =?us-ascii?Q?fVpU1ez6QrN6h06H1BsX1RAYPNGIKUPbRz3dcSmNk0qzvL6ba+P8Px32pQq7?=
 =?us-ascii?Q?jsI7JbBM53sDV/gFaAAIECshWMaBhWin9hXKcBXnL2y3D6JHxq+JV3wj0S+U?=
 =?us-ascii?Q?OgAqDQvpW0ZI/T/bCM9qb++E6NmtNhvmi3ZHxmB58VTPfqI5Iua/NCYMSfiR?=
 =?us-ascii?Q?6xhaFkfT/vTVBfGHklMYaQKsr9jG3bnIPyitJt+yECodwo0ke35Z5qXTHw5X?=
 =?us-ascii?Q?bJUvsNLdey3oJB7A6+jl6OMpi4CZ1yhYozqr58+bbC21Fl5CrVBkN++hr3zd?=
 =?us-ascii?Q?sRAw8MPBs4GLDk6owuldSuC/PNqIpiFdbqYIaCoaLT2ZBzcNmpAiRU6e6KNH?=
 =?us-ascii?Q?RmFCUh4BY7WTG2vzXY9fOAlU6NsLT4HvlkvlQZsEOafstkVsqpI8h+Ma3HGT?=
 =?us-ascii?Q?FpGmUb2nzr3czTUOHAMGb3VMINyIN2mw4S6KQRTgWo0b2BGf18LDOiYksLIT?=
 =?us-ascii?Q?cPtHHIYRyJRIhqj0xPEq93T8DePu/+kvZHxZnw2sUBPsqA23nHsIvJX5rJBz?=
 =?us-ascii?Q?oA9DCJVCm9R0PmZ3DwoFv5qAdqxQ1MRUtLjfVzr5A9deNCC7BWymgi1qyPXF?=
 =?us-ascii?Q?1I1t4yvTg+5AugEUiZIsaii2yjhJsBYDxqTS0OME+NwHNaA1JDbnRMQUPy2T?=
 =?us-ascii?Q?DcEgyiQ6bwonOWY8tiKDODIF9Hc6DOf2o7Ln0zERbyNUydQ2TA90NIvoCc6V?=
 =?us-ascii?Q?xmlYLOqvAhoUWc=3D?=
X-Microsoft-Antispam-Message-Info: F8o+rkrrjVBSZ5oPgf8ENW6rDWe0xRz1Pf5U8gIGbOjhfQYA+Di6ltONE81FPbgmvs5F5tN4d+6Wz01QBOuslwFYz0k2vIWLHQo3fA1WBYyOiTDO/TGsy62h9AAcTE2Dl8NZanBly0Igb8s7ZSlfH352RxHqw6de4hA5sYLxjzHJl3wp7mCB9EfQBwWHCKcJRiaE+12jhxxf775DItaxXKUmfl1Z2j2NSH91HttXNaUjf70h7FeHo1/cag6azwqRxdw5mLMq+Z/fahN+QsQgQ4HkBYiecgoG6vZ3UIeWbCyAWi5fmzEbviXrSjT3QZnKbZ8jzLIpkbMsTfLB2p8Manhn9KhT6pL+VwaAabCiqec=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;6:tL3AVmvGfqYpd1EAUjYamcGk5zLhFb0Mk5Gw4QqrolTtvHsrd+sddVpxa9KH6hR89UFZRA6r/OOZZc4XIoPj7VL2IBSQsq5sZgrIx1B2ufutZSAcroJSCOx+wyNNy33K/dGLLnHNvcy1scSg/RVBQpuJ/vWJ0L7jz1SHpPIZ9RAnQc9e0mmeoaaekD9IhWrtPq8Fl9yj5U6DCAHvRhknBha+B3oVjfwA3Ymyxjqmd4MF/l1A4rtvq0FOlI9AeXTrGK0tP6hXy536ZNt2gvHkW506f6yOYpMCA7EyxT4S/TB2pnqGnH9X0ihjvNGkqsqMHGYf4n9mzGeW4FvQJT0tRw6Jd8GXh/YngMZpRq8s+YUpeaHicn2TYqGqo+488C52J93FRBmpfytQ4OFy7oN45At9ZR8QYCp+rbGsL8G7K4A7fXnrlO/sRSpGZS8XET38d42IVALKpVeJ9LFDTVubNg==;5:jLxsx0hb0fCDjb4MWYGgvwlXQm5dgC1ELBR0LoWymviDZYgxSn2XiDoUyW8hNEQrGN3SJ6w8eibWKZwYNRS2r94BKru9MxG+RMC4MZ0UxyxMInVMJhTCr6HkCuNgkZiciiPWFDC0BrNnaTJJRhS4q/sSFQ7+AhXhFRiru7uad/I=;7:FvLQxufLEVUKngx3GGSRVFQaXh8QwXPTbXdDK0zx/bc9otcwOuxVCcmkR0QhfixqmBlpCuIHADBuwTR+ZNoQMc7bqsYQVT8oy8KdjoEh4VnqIyHDymDkYPKUc/nMaxorvKKL7yqUSZFWL0NnX60Dfh/1Qkf1xVHsza8F/XdUyrzysxNwcksNQZxxRZ3DUyXujZ2aY18QoYf1xtqfGeoiGH+C5lhNbZYZcpTGuLPgVmv/bz/xlKM4wyuHKlAaoUqg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:46:50.4339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b6a164-173f-41f6-6322-08d5fe9dd093
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Devices ADXL372 SPI-Bus
Three-Axis Digital Accelerometer.

The device is probed and configured the with some initial default
values. With this basic driver, it is possible to read raw acceleration
data.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                 |   6 +
 drivers/iio/accel/Kconfig   |  11 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/adxl372.c | 525 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 543 insertions(+)
 create mode 100644 drivers/iio/accel/adxl372.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1028..2ba47bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/input/misc/adxl34x.c
 
+ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/accel/adxl372.c
+
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 62ae7e5..1b496ef 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -60,6 +60,17 @@ config ADXL345_SPI
 	  will be called adxl345_spi and you will also get adxl345_core
 	  for the core module.
 
+config ADXL372
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to add support for the Analog Devices ADXL372 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl372.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 636d4d1..5758ffc 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
+obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
new file mode 100644
index 0000000..db9ecd2
--- /dev/null
+++ b/drivers/iio/accel/adxl372.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* ADXL372 registers definition */
+#define ADXL372_DEVID			0x00
+#define ADXL372_DEVID_MST		0x01
+#define ADXL372_PARTID			0x02
+#define ADXL372_REVID			0x03
+#define ADXL372_STATUS_1		0x04
+#define ADXL372_STATUS_2		0x05
+#define ADXL372_FIFO_ENTRIES_2		0x06
+#define ADXL372_FIFO_ENTRIES_1		0x07
+#define ADXL372_X_DATA_H		0x08
+#define ADXL372_X_DATA_L		0x09
+#define ADXL372_Y_DATA_H		0x0A
+#define ADXL372_Y_DATA_L		0x0B
+#define ADXL372_Z_DATA_H		0x0C
+#define ADXL372_Z_DATA_L		0x0D
+#define ADXL372_X_MAXPEAK_H		0x15
+#define ADXL372_X_MAXPEAK_L		0x16
+#define ADXL372_Y_MAXPEAK_H		0x17
+#define ADXL372_Y_MAXPEAK_L		0x18
+#define ADXL372_Z_MAXPEAK_H		0x19
+#define ADXL372_Z_MAXPEAK_L		0x1A
+#define ADXL372_OFFSET_X		0x20
+#define ADXL372_OFFSET_Y		0x21
+#define ADXL372_OFFSET_Z		0x22
+#define ADXL372_X_THRESH_ACT_H		0x23
+#define ADXL372_X_THRESH_ACT_L		0x24
+#define ADXL372_Y_THRESH_ACT_H		0x25
+#define ADXL372_Y_THRESH_ACT_L		0x26
+#define ADXL372_Z_THRESH_ACT_H		0x27
+#define ADXL372_Z_THRESH_ACT_L		0x28
+#define ADXL372_TIME_ACT		0x29
+#define ADXL372_X_THRESH_INACT_H	0x2A
+#define ADXL372_X_THRESH_INACT_L	0x2B
+#define ADXL372_Y_THRESH_INACT_H	0x2C
+#define ADXL372_Y_THRESH_INACT_L	0x2D
+#define ADXL372_Z_THRESH_INACT_H	0x2E
+#define ADXL372_Z_THRESH_INACT_L	0x2F
+#define ADXL372_TIME_INACT_H		0x30
+#define ADXL372_TIME_INACT_L		0x31
+#define ADXL372_X_THRESH_ACT2_H		0x32
+#define ADXL372_X_THRESH_ACT2_L		0x33
+#define ADXL372_Y_THRESH_ACT2_H		0x34
+#define ADXL372_Y_THRESH_ACT2_L		0x35
+#define ADXL372_Z_THRESH_ACT2_H		0x36
+#define ADXL372_Z_THRESH_ACT2_L		0x37
+#define ADXL372_HPF			0x38
+#define ADXL372_FIFO_SAMPLES		0x39
+#define ADXL372_FIFO_CTL		0x3A
+#define ADXL372_INT1_MAP		0x3B
+#define ADXL372_INT2_MAP		0x3C
+#define ADXL372_TIMING			0x3D
+#define ADXL372_MEASURE			0x3E
+#define ADXL372_POWER_CTL		0x3F
+#define ADXL372_SELF_TEST		0x40
+#define ADXL372_RESET			0x41
+#define ADXL372_FIFO_DATA		0x42
+
+#define ADXL372_DEVID_VAL		0xAD
+#define ADXL372_PARTID_VAL		0xFA
+#define ADXL372_RESET_CODE		0x52
+
+/* ADXL372_POWER_CTL */
+#define ADXL372_POWER_CTL_MODE_MSK		GENMASK_ULL(1, 0)
+#define ADXL372_POWER_CTL_MODE(x)		(((x) & 0x3) << 0)
+
+/* ADXL372_MEASURE */
+#define ADXL372_MEASURE_LINKLOOP_MSK		GENMASK_ULL(5, 4)
+#define ADXL372_MEASURE_LINKLOOP_MODE(x)	(((x) & 0x3) << 4)
+#define ADXL372_MEASURE_BANDWIDTH_MSK		GENMASK_ULL(2, 0)
+#define ADXL372_MEASURE_BANDWIDTH_MODE(x)	(((x) & 0x7) << 0)
+
+/* ADXL372_TIMING */
+#define ADXL372_TIMING_ODR_MSK			GENMASK_ULL(7, 5)
+#define ADXL372_TIMING_ODR_MODE(x)		(((x) & 0x7) << 5)
+
+/* ADXL372_FIFO_CTL */
+#define ADXL372_FIFO_CTL_FORMAT_MSK		GENMASK(5, 3)
+#define ADXL372_FIFO_CTL_FORMAT_MODE(x)		(((x) & 0x7) << 3)
+#define ADXL372_FIFO_CTL_MODE_MSK		GENMASK(2, 1)
+#define ADXL372_FIFO_CTL_MODE_MODE(x)		(((x) & 0x3) << 1)
+#define ADXL372_FIFO_CTL_SAMPLES_MSK		BIT(1)
+#define ADXL372_FIFO_CTL_SAMPLES_MODE(x)	(((x) > 0xFF) ? 1 : 0)
+
+/* ADXL372_STATUS_1 */
+#define ADXL372_STATUS_1_DATA_RDY(x)		(((x) >> 0) & 0x1)
+#define ADXL372_STATUS_1_FIFO_RDY(x)		(((x) >> 1) & 0x1)
+#define ADXL372_STATUS_1_FIFO_FULL(x)		(((x) >> 2) & 0x1)
+#define ADXL372_STATUS_1_FIFO_OVR(x)		(((x) >> 3) & 0x1)
+#define ADXL372_STATUS_1_USR_NVM_BUSY(x)	(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
+#define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
+
+/* ADXL372_INT1_MAP */
+#define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
+#define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
+#define ADXL372_INT1_MAP_FIFO_RDY_MSK		BIT(1)
+#define ADXL372_INT1_MAP_FIFO_RDY_MODE(x)	(((x) & 0x1) << 1)
+#define ADXL372_INT1_MAP_FIFO_FULL_MSK		BIT(2)
+#define ADXL372_INT1_MAP_FIFO_FULL_MODE(x)	(((x) & 0x1) << 2)
+#define ADXL372_INT1_MAP_FIFO_OVR_MSK		BIT(3)
+#define ADXL372_INT1_MAP_FIFO_OVR_MODE(x)	(((x) & 0x1) << 3)
+#define ADXL372_INT1_MAP_INACT_MSK		BIT(4)
+#define ADXL372_INT1_MAP_INACT_MODE(x)		(((x) & 0x1) << 4)
+#define ADXL372_INT1_MAP_ACT_MSK		BIT(5)
+#define ADXL372_INT1_MAP_ACT_MODE(x)		(((x) & 0x1) << 5)
+#define ADXL372_INT1_MAP_AWAKE_MSK		BIT(6)
+#define ADXL372_INT1_MAP_AWAKE_MODE(x)		(((x) & 0x1) << 6)
+#define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
+#define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
+
+/*
+ * At +/- 200g with 12-bit resolution, scale is computed as:
+ * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
+ */
+#define ADXL372_USCALE	958241
+
+enum adxl372_op_mode {
+	ADXL372_STANDBY,
+	ADXL372_WAKE_UP,
+	ADXL372_INSTANT_ON,
+	ADXL372_FULL_BW_MEASUREMENT,
+};
+
+enum adxl372_act_proc_mode {
+	ADXL372_DEFAULT,
+	ADXL372_LINKED,
+	ADXL372_LOOPED,
+};
+
+enum adxl372_th_activity {
+	ADXL372_ACTIVITY,
+	ADXL372_ACTIVITY2,
+	ADXL372_INACTIVITY,
+};
+
+enum adxl372_odr {
+	ADXL372_ODR_400HZ,
+	ADXL372_ODR_800HZ,
+	ADXL372_ODR_1600HZ,
+	ADXL372_ODR_3200HZ,
+	ADXL372_ODR_6400HZ,
+};
+
+enum adxl372_bandwidth {
+	ADXL372_BW_200HZ,
+	ADXL372_BW_400HZ,
+	ADXL372_BW_800HZ,
+	ADXL372_BW_1600HZ,
+	ADXL372_BW_3200HZ,
+};
+
+static const unsigned int adxl372_th_reg_high_addr[3] = {
+	[ADXL372_ACTIVITY] = ADXL372_X_THRESH_ACT_H,
+	[ADXL372_ACTIVITY2] = ADXL372_X_THRESH_ACT2_H,
+	[ADXL372_INACTIVITY] = ADXL372_X_THRESH_INACT_H,
+};
+
+#define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static const struct iio_chan_spec adxl372_channels[] = {
+	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
+	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
+	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+};
+
+struct adxl372_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	enum adxl372_op_mode		op_mode;
+	enum adxl372_act_proc_mode	act_proc_mode;
+	enum adxl372_odr		odr;
+	enum adxl372_bandwidth		bw;
+	u32				act_time_ms;
+	u32				inact_time_ms;
+};
+
+static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &regval, sizeof(regval));
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(regval);
+}
+
+static int adxl372_set_op_mode(struct adxl372_state *st,
+			       enum adxl372_op_mode op_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_POWER_CTL,
+				 ADXL372_POWER_CTL_MODE_MSK,
+				 ADXL372_POWER_CTL_MODE(op_mode));
+	if (ret < 0)
+		return ret;
+
+	st->op_mode = op_mode;
+
+	return ret;
+}
+
+static int adxl372_set_odr(struct adxl372_state *st,
+			   enum adxl372_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_TIMING,
+				 ADXL372_TIMING_ODR_MSK,
+				 ADXL372_TIMING_ODR_MODE(odr));
+	if (ret < 0)
+		return ret;
+
+	st->odr = odr;
+
+	return ret;
+}
+
+static int adxl372_set_bandwidth(struct adxl372_state *st,
+				 enum adxl372_bandwidth bw)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_MEASURE,
+				 ADXL372_MEASURE_BANDWIDTH_MSK,
+				 ADXL372_MEASURE_BANDWIDTH_MODE(bw));
+	if (ret < 0)
+		return ret;
+
+	st->bw = bw;
+
+	return ret;
+}
+
+static int adxl372_set_act_proc_mode(struct adxl372_state *st,
+				     enum adxl372_act_proc_mode mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL372_MEASURE,
+				 ADXL372_MEASURE_LINKLOOP_MSK,
+				 ADXL372_MEASURE_LINKLOOP_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	st->act_proc_mode = mode;
+
+	return ret;
+}
+
+static int adxl372_set_activity_threshold(struct adxl372_state *st,
+					  enum adxl372_th_activity act,
+					  bool ref_en, bool enable,
+					  unsigned int threshold)
+{
+	unsigned char buf[6];
+	unsigned char th_reg_high_val, th_reg_low_val, th_reg_high_addr;
+
+	/* scale factor is 100 mg/code */
+	th_reg_high_val = (threshold / 100) >> 3;
+	th_reg_low_val = ((threshold / 100) << 5) | (ref_en << 1) | enable;
+	th_reg_high_addr = adxl372_th_reg_high_addr[act];
+
+	buf[0] = th_reg_high_val;
+	buf[1] = th_reg_low_val;
+	buf[2] = th_reg_high_val;
+	buf[3] = th_reg_low_val;
+	buf[4] = th_reg_high_val;
+	buf[5] = th_reg_low_val;
+
+	return regmap_bulk_write(st->regmap, th_reg_high_addr,
+				 buf, ARRAY_SIZE(buf));
+}
+
+static int adxl372_set_activity_time_ms(struct adxl372_state *st,
+					unsigned int act_time_ms)
+{
+	unsigned int reg_val, scale_factor;
+	int ret;
+
+	/*
+	 * 3.3 ms per code is the scale factor of the TIME_ACT register for
+	 * ODR = 6400 Hz. It is 6.6 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 3300;
+	else
+		scale_factor = 6600;
+
+	reg_val = DIV_ROUND_CLOSEST(act_time_ms * 1000, scale_factor);
+
+	/* TIME_ACT register is 8 bits wide */
+	if (reg_val > 0xFF)
+		reg_val = 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_ACT, reg_val);
+	if (ret < 0)
+		return ret;
+
+	st->act_time_ms = act_time_ms;
+
+	return ret;
+}
+
+static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
+					  unsigned int inact_time_ms)
+{
+	unsigned int reg_val_h, reg_val_l, res, scale_factor;
+	int ret;
+
+	/*
+	 * 13 ms per code is the scale factor of the TIME_INACT register for
+	 * ODR = 6400 Hz. It is 26 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 13;
+	else
+		scale_factor = 26;
+
+	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
+	reg_val_h = (res >> 8) & 0xFF;
+	reg_val_l = res & 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_L, reg_val_l);
+	if (ret < 0)
+		return ret;
+
+	st->inact_time_ms = inact_time_ms;
+
+	return ret;
+}
+
+static int adxl372_setup(struct adxl372_state *st)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL372_DEVID, &regval);
+	if (ret < 0)
+		return ret;
+
+	if (regval != ADXL372_DEVID_VAL) {
+		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for activity detection to 1g */
+	ret = adxl372_set_activity_threshold(st, ADXL372_ACTIVITY,
+					     true, true, 1000);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for inactivity detection to 100mg */
+	ret = adxl372_set_activity_threshold(st, ADXL372_INACTIVITY,
+					     true, true, 100);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity processing in Looped mode */
+	ret = adxl372_set_act_proc_mode(st, ADXL372_LOOPED);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_bandwidth(st, ADXL372_BW_3200HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity timer to 1ms */
+	ret = adxl372_set_activity_time_ms(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set inactivity timer to 10s */
+	ret = adxl372_set_inactivity_time_ms(st, 10000);
+	if (ret < 0)
+		return ret;
+
+	/* Set the mode of operation to full bandwidth measurement mode */
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static int adxl372_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adxl372_read_axis(st, chan->address);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = ADXL372_USCALE;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl372_info = {
+	.read_raw = adxl372_read_raw,
+	.debugfs_reg_access = &adxl372_reg_access,
+};
+
+static const struct regmap_config adxl372_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+};
+
+static int adxl372_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxl372_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st->regmap = regmap;
+
+	indio_dev->channels = adxl372_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &adxl372_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adxl372_setup(st);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adxl372_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl372_id);
+
+static struct spi_driver adxl372_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adxl372_probe,
+	.id_table = adxl372_id,
+};
+
+module_spi_driver(adxl372_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

