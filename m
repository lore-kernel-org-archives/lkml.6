Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBC720880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="RRZ1Acow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBC720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeLMMrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:24 -0500
Received: from mail-eopbgr740041.outbound.protection.outlook.com ([40.107.74.41]:50728
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729275AbeLMMrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5pdEJsgAYZzmamBlcKZcyQ73G/NvB7QZby1ac0QoFA=;
 b=RRZ1AcowtbGBFdlNHuZJmJQQ/EeYIeAVXPD61g5QOOiI+gyvF0zR8IzBh2T2iQGL+s0pTgK14WOmVhkg7SJ0M8W6I3z69QteaZLaM1NKI8J+6EcDFx3I7qCVVB6JnfBBLJP+VzANm4RwSWFKdteb0GpSxOSgr6t244OEfsm492g=
Received: from DM5PR03CA0039.namprd03.prod.outlook.com (2603:10b6:4:3b::28) by
 SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 12:47:19 +0000
Received: from BL2FFO11FD028.protection.gbl (2a01:111:f400:7c09::146) by
 DM5PR03CA0039.outlook.office365.com (2603:10b6:4:3b::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Thu, 13 Dec 2018 12:47:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2FFO11FD028.mail.protection.outlook.com (10.173.161.107) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1425.16 via Frontend Transport; Thu, 13 Dec 2018 12:47:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDClI13004198
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:19 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:18 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 05/11] staging: iio: adc: ad7606: Add support for threaded irq
Date:   Thu, 13 Dec 2018 14:46:17 +0200
Message-ID: <1544705183-13288-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(3190300001)(199004)(189003)(72206003)(476003)(106466001)(2616005)(36756003)(44832011)(478600001)(426003)(486006)(11346002)(2906002)(106002)(126002)(116002)(305945005)(336012)(7416002)(446003)(54906003)(76176011)(246002)(8676002)(48376002)(7636002)(14444005)(50466002)(50226002)(47776003)(5660300001)(7696005)(51416003)(26005)(316002)(77096007)(16586007)(4326008)(110136005)(186003)(8936002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD028;1:nBdhxTSn9UJ9/isKMiczRIOTOSHVOcCNFK5s5rxwI0kBgJ6n9wNqRLyoRrwLsgQUU5ap1V8rMd58gtSQOAcxZkj2m+p5/2dP9wlGl1hf4421X6kuu9R1RCIjEGdetON6
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63dd6c1-9b1b-4666-4ce0-08d660f91e72
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;3:dvPD5bDwgyxA/hKSSv+XMYgRJ1EpPnVmyoAC2y/8KXQemRS7s7OoES/c2ID/SdUxClWrBzqedbriH9OgKEh2rQI2NyTQZeIPK8KwElRQv+SdUMXvmclqPHUTRGmKFXdapOIKp5xxNxJYaP4+UAtYtT399zzOj7IyRrQlLip9xlcj4vYgHLPtprZyIELsmDT85wCF7XOTbuSI8xn0Elb7nTvC89Tiidt0Kb6BLddCPDQgS3YEp6+JmqOYMBaZZTHyZe/Iw7TcOjBFCz2AXcz+tSnXeTKs4tkQVhIttFHwnQoCi4vkxczTXXiv0YtSttxnK+jfIstuOyzyg3sGA6zgb2GFLyEMI0PiPP3hYJTIH2g=;25:W1y5P3rbVu7s8n0eg3AcdyWK2xXlvQlySe1YJyWKRmFk2iTGqGMFmYKphxlrzIEJzYV4RX3hMYZRpjuZWksWcBmW8NcPuzc4SvDoqw2mJC2cwxyW+UKjmvm6s/4ShoQbxmm5CgJZ5Zz4TE4OEl1540TD1MabS5L+w7mz3hrq/Hg/q/Lmch7UyDK+OUscmUcLreNkYLpEEM6Sx9W+3CpckgAbwqcIrBsHX1CE7+1VciDLLpBCH8bKlGAw+mapNaqyUN9DGueJMKNh+iXLz6Klsfqe4Tt0svAA+QAC7CSXaqtuuI9c94zAyCBinq+T1GSfRuCy8T1B5Il2zITiXSb9hA==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;31:G1NpCe8ks32Lfxmh2ADPzI4Bke/LPGfEsTryD/6BGLE51tGh3jsKFPu/EtLqP+rPJZp2tPX5Z3m5h4goVZtgaULN0i5KAxrqxu0W4cLGg85uug1CPQXA+1gOiRIm+GS9DU5n055s+abgj9HcLoFZcNIvZQvn6kMW4gKFYzT1huErx/L5Z/y2TImqCI7mwWAsAH4VHZc1OyJgZiBVm4mWMD8axB65gm9SzEgIKs8u2nw=;20:gAaXUDEQq3WAYyVMbNHa1sgZAsknjWKaLRd/6U5s0uPn0exnj4BIxOPOO2KZ894tAanfbxzKkTK41nQXU4IqWe1kNGMCx42TdGFd8Q5GtQ/GCC3aKp3qcg9wjuRdC4olcxtxlzkcw8x3xhik0DkDhcuDl/MNtq4Dv4CMocgidcdUxseHhlMT8l913OV+Q2wMkBDw48/7ylwWyO4UHTvtB/GJGpMXDdy2GcJU4efy15uX5H20ScFrRQq3YlrasWm59qrCbXNRfZ8Y98aASi11Poz0SehfRZyTjLH+l3K/ofhvhjiNmSOoynJFj3U4QZXbSGvyg3hidM1VRXfpfEKn9nLkCgO0cjLBrivmoO73PMJ3Cu8hKs1XLkccRx6XWqHNX0gBfCvv56l80dFwYQHrMyujvEYV9euz0TsN2gJ59I559wXBQeqEIYzWNm5RFougqOEFPP+9ELSro8zqbPo+RImAFgY+snEhy6unkrsZL5Ejam2u8NH9I5NWxMiwle+7
X-Microsoft-Antispam-PRVS: <SN2PR03MB22711803D1F8DCE7973A5E179DA00@SN2PR03MB2271.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2271;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;4:Ljax5jct9HWsCpKSv8o23miJNceeepoZ+l/DLLI3NPDjB6F/Ib9A7bG+X5FcHTmzwynnOBCsrkWf4gmMkzy7lnGm/hWwenwdHqrBMytIqtI95SyXcTwu5D/BudK3tce1mF8aZTbex+Er06MoqmyqxzyRa878IV4l1fhYv5kW5UeXMZ0LmUiI6/ox2nMUOlAjvbCtp52kq9Xr//nV8+ZIFtlic4QGq1HjtuyLy3ZUMqk+MZBqADV4g2WI51BniNcsXS1kP4OEGsxvHWpSj6q5OA==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2271;23:t1WGE2zeJhWXNs999rfSacg4AhLSQ4zYKBNkJNYX0?=
 =?us-ascii?Q?FBZUUNYVZWUrUjDuZYeXFyptIwwrB6QrB6KMZBQgyss+2E5GVnqGS0iaRK4K?=
 =?us-ascii?Q?MM1QlrUoLoMCnQAsuSbiVrAvq+dKi/Iv0HgQlli+XSdUhHoHLPMqaaOraHke?=
 =?us-ascii?Q?2vyNNQURs7FQ1mN6ADz0h1F+bfKYGF//sBg3pmTCxwpRhIQu48Os8/wUA41r?=
 =?us-ascii?Q?BbjFr1wRGWectWZeiIqNr/EMElRAbqGsNTkZMDVcj0g56kDlLRuotAZo0wEA?=
 =?us-ascii?Q?ca3uDIOeKIR5HVJTl5lrKiMfnlMlMEjTd2suX698jrtJQO4J2+q23xOwrOG0?=
 =?us-ascii?Q?roksL937gD9116cqpFW5epljDPLIOViI292LCetnjZYXpue/R6AHrlSkk3tV?=
 =?us-ascii?Q?oaKcLiNIMs5FJPb0p3bvBDTnRE4McN/46TgPkniq6cJ+Bkyu3Wd8vVrSraJe?=
 =?us-ascii?Q?W2AbOZAfQ9d3sLbJnKozY/Hbs97wLFtPSmHhXCRPGKAzfOaWqifcak0VN77L?=
 =?us-ascii?Q?yzFILNkwliq5QtFP2dT9IMdtwHiModwiTV59ZOOajnNiMs1y0c9gy6KX4aqw?=
 =?us-ascii?Q?pnac7Oopdaq9c5nLtgE0H1slUR+V43VH+N6kwFFoO82go9qNeoPSt5qnlH8O?=
 =?us-ascii?Q?fCuSGZXVDWcrKceuv0hMnkMyrBZBmK/v0NRcFHxQI836PTVyJO1/jAyee8sn?=
 =?us-ascii?Q?iKFlGANeeu0EBLS7UJ1BbwJ5764zr3K3nF7eE0hQQV5BTTKpb5qckCLE+TMy?=
 =?us-ascii?Q?/8vvPX4BdOlA7qcOhrSfp9UlozyXG1hCBGn3hYY0q1rhydcxEBszwUJvKp63?=
 =?us-ascii?Q?/poAfJIrYLFSI2A8XgaSgFz+dBFEO4qojENwJyuRBLGzQ4Vzl0liyasnF/R2?=
 =?us-ascii?Q?SF4fx0+dgBW5/ccue7I2vZHrhhtoaupdETIOPUPIvm0pqy65L7cldZ0Ro5up?=
 =?us-ascii?Q?KGkKEw1Rm+WgCWKxinUVuHyD4RdJLWqWDhqilG9wRcWUTM11WuUgSSsrSD7Q?=
 =?us-ascii?Q?JACPRNxySFQj/TPbqlqluJDNTbuhqBuBGUELkn3KLCVj4C2jfXGQWOe3Wa1v?=
 =?us-ascii?Q?PKh1vkpnjKRf+V8K3/n3ASfzQV4?=
X-Microsoft-Antispam-Message-Info: 1r8suNGq1cjJq0WtbFhU6dVhC51ynac1JyJlJsHxzo9/7ek+K10G0WEDEOX1VpYdNOccVN0XVNvo1kMxvFikUej8OGMp8FQeq0kADUSeIcvQi2cqwX29kKjG93s+PmGmB+gVfdYVNcRwPzkbHkmJiBQs9rZrlPjm+cexkghWooZhpgMZjOwesaJllwvndGZ4dOOgcBJpTkX8LZM+BAlrVWHLTz4lEFbijIV+n24x7ie2em+zDrsc4wN/GezKOpgWKfeGwI9hUVoJU0tIt+OLOHCffUoEiP+xWM6aERGIyOU8OpKSk9nH52sPwVusvAav
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;6:3zE75bk7hfoOJRV3+eynunb2sqAYRtgEfWlZdZBxcHIqL5lqotASMqdRo8fpj/K6YM5WjtA/5FZlErU6uYjLjH+owevm4Fwq4iyVyIIowFf6+72NMnudjRNMcyvl66ljOWP1vd1+6jVheUJH4scQNqtr/qfpSrISIJSXhG27a/7k150YZlCN7jE4PSEc6Y5xe0rmZpj+2W2aa9DPUZCt/tVJAVlFlmGolQ0prZ5fMgNgiSUItJDnu0jtm7ODnwdW6VB931cusf9MdfuLesBzp15uYA28LfdOrjf+mQi779NSg0YDwDJM2J9Ed1UF06721tJ+BYZsSP1Z4dGhPsOkkX8uNxufJojpA9n7zynwWL2h3MoyWe0XKsXjKcmo+TeDnjPw3/epjSUMB0S96s+evhTuSVwjNUhj5yyBrnqYOXrcRrVuX0YNsWBn8urqkcj1x6QBorW3gwOwX5+0Yw+iIQ==;5:PRGCkyGqe9D6Bkcv3NMEXLWuUiuVlcpKrNspP2SzQQBRIZd1DKogZS0X9KybjbyS6n7O7WqmhuPSfxlCFCSKBz+u2gyef8tVT12X2ejpjJcc1XEPEhz2uDcY3ZHIAfhOyxrKDUelsYWPNat1aAHL7c3etn1Yqz88BNcM5qIYyrU=;7:bmI3dY3pgTFLxzmi+gr9QYgzgV1uLZG1yErYyBC1TgcTQs40ofPlY7rG2RWv5uLsYqp2sc+Bn1JDEnLNRJr4il/8ZimEGXUBM4yvryEKv9bC+j9dl6w4PTxHPiK0NcFJt4WLdk8ieovxnJb+/aqaNw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:19.2340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63dd6c1-9b1b-4666-4ce0-08d660f91e72
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the use of a polling ring buffer with a threaded
interrupt.

Enabling the buffer sets the CONVST signal to high. When the rising edge
of the CONVST is applied, BUSY signal goes logic high and transitions low
at the end of the entire conversion process. The falling edge of the BUSY
signal triggers the interrupt.

ad7606_trigger_handler() is used as bottom half of the poll function.
It reads data from the device and stores it in the internal buffer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c | 116 +++++++++++++++++++++++++++++----------
 drivers/staging/iio/adc/ad7606.h |   6 +-
 2 files changed, 89 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 7191d51..13aeeec 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -21,6 +21,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include "ad7606.h"
@@ -81,36 +82,24 @@ static int ad7606_read_samples(struct ad7606_state *st)
 static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct ad7606_state *st = iio_priv(pf->indio_dev);
-
-	gpiod_set_value(st->gpio_convst, 1);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
- **/
-static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
-{
-	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
-						poll_work);
-	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
+	mutex_lock(&st->lock);
+
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
 						   iio_get_time_ns(indio_dev));
 
-	gpiod_set_value(st->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
+	/* The rising edge of the CONVST signal starts a new conversion. */
+	gpiod_set_value(st->gpio_convst, 1);
+
+	mutex_unlock(&st->lock);
+
+	return IRQ_HANDLED;
 }
 
 static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
@@ -378,8 +367,11 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	return PTR_ERR_OR_ZERO(st->gpio_os);
 }
 
-/**
- *  Interrupt handler
+/*
+ * The BUSY signal indicates when conversions are in progress, so when a rising
+ * edge of CONVST is applied, BUSY goes logic high and transitions low at the
+ * end of the entire conversion process. The falling edge of the BUSY signal
+ * triggers this interrupt.
  */
 static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 {
@@ -387,7 +379,8 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev)) {
-		schedule_work(&st->poll_work);
+		gpiod_set_value(st->gpio_convst, 0);
+		iio_trigger_poll_chained(st->trig);
 	} else {
 		complete(&st->completion);
 	}
@@ -395,26 +388,74 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
+static int ad7606_validate_trigger(struct iio_dev *indio_dev,
+				   struct iio_trigger *trig)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->trig != trig)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	iio_triggered_buffer_postenable(indio_dev);
+	gpiod_set_value(st->gpio_convst, 1);
+
+	return 0;
+}
+
+static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	reinit_completion(&st->completion);
+	gpiod_set_value(st->gpio_convst, 1);
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(1000));
+	gpiod_set_value(st->gpio_convst, 0);
+
+	return iio_triggered_buffer_predisable(indio_dev);
+}
+
+static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
+	.postenable = &ad7606_buffer_postenable,
+	.predisable = &ad7606_buffer_predisable,
+};
+
 static const struct iio_info ad7606_info_no_os_or_range = {
 	.read_raw = &ad7606_read_raw,
+	.validate_trigger = &ad7606_validate_trigger,
 };
 
 static const struct iio_info ad7606_info_os_and_range = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os_and_range,
+	.validate_trigger = &ad7606_validate_trigger,
 };
 
 static const struct iio_info ad7606_info_os = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os,
+	.validate_trigger = &ad7606_validate_trigger,
 };
 
 static const struct iio_info ad7606_info_range = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
+	.validate_trigger = &ad7606_validate_trigger,
+};
+
+static const struct iio_trigger_ops ad7606_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
 };
 
 static void ad7606_regulator_disable(void *data)
@@ -446,7 +487,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	/* tied to logic low, analog input range is +/- 5V */
 	st->range = 0;
 	st->oversampling = 1;
-	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
 	st->reg = devm_regulator_get(dev, "avcc");
 	if (IS_ERR(st->reg))
@@ -491,14 +531,32 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
-	ret = devm_request_irq(dev, irq, ad7606_interrupt, IRQF_TRIGGER_FALLING,
-			       name, indio_dev);
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					  indio_dev->name, indio_dev->id);
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad7606_trigger_ops;
+	st->trig->dev.parent = dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	ret = devm_request_threaded_irq(dev, irq,
+					NULL,
+					&ad7606_interrupt,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					name, indio_dev);
 	if (ret)
 		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
 					      &ad7606_trigger_handler,
-					      NULL, NULL);
+					      &ad7606_buffer_ops);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 70486ef..b238e9b 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -26,8 +26,6 @@ struct ad7606_chip_info {
  * @dev		pointer to kernel device
  * @chip_info		entry in the table of chips that describes this device
  * @reg		regulator info for the the power supply of the device
- * @poll_work		work struct for continuously reading data from the device
- *			into an IIO triggered buffer
  * @bops		bus operations (SPI or parallel)
  * @range		voltage range selection, selects which scale to apply
  * @oversampling	oversampling selection
@@ -42,14 +40,13 @@ struct ad7606_chip_info {
  *			is being read on the first channel
  * @gpio_os		GPIO descriptors to control oversampling on the device
  * @complete		completion to indicate end of conversion
+ * @trig		The IIO trigger associated with the device.
  * @data		buffer for reading data from the device
  */
-
 struct ad7606_state {
 	struct device			*dev;
 	const struct ad7606_chip_info	*chip_info;
 	struct regulator		*reg;
-	struct work_struct		poll_work;
 	const struct ad7606_bus_ops	*bops;
 	unsigned int			range;
 	unsigned int			oversampling;
@@ -62,6 +59,7 @@ struct ad7606_state {
 	struct gpio_desc		*gpio_standby;
 	struct gpio_desc		*gpio_frstdata;
 	struct gpio_descs		*gpio_os;
+	struct iio_trigger		*trig;
 	struct completion		completion;
 
 	/*
-- 
2.7.4

