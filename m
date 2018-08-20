Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A27FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DAB21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ZPjw2XaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DAB21570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeHTSMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:12:00 -0400
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:35068
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHTSMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKWSUXAIMtbpWiphXq4n1d9x3vaS6ny7bpN4dYwKROs=;
 b=ZPjw2XaJ5QHqtpyhH/s8sxrqiVzHIAs6NmI9Mk1922Cph5oxvc1ExpbYh78EUZcLtojr5KR6nLBWDJBzt8Wip0Liexfs7Pa0DZjwMwUZBVubFpBxjHUKDaqDUI/LAauXR8kS2InrnYAe55wqjnBDAmpqXDLV49JEORGxIOLJY5Q=
Received: from BN6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:404:23::25)
 by CY4PR03MB3127.namprd03.prod.outlook.com (2603:10b6:910:53::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 14:54:06 +0000
Received: from BY2FFO11FD009.protection.gbl (2a01:111:f400:7c0c::108) by
 BN6PR03CA0015.outlook.office365.com (2603:10b6:404:23::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1059.20 via Frontend Transport; Mon, 20 Aug 2018 14:54:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD009.mail.protection.outlook.com (10.1.14.73) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Mon, 20 Aug 2018 14:54:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7KEs413020220
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 20 Aug 2018 07:54:04 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 20 Aug 2018
 10:54:03 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/3] iio: adxl372: Provide validate_trigger and validate_device callbacks
Date:   Mon, 20 Aug 2018 17:53:43 +0300
Message-ID: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(426003)(336012)(2351001)(53416004)(50466002)(7636002)(486006)(316002)(476003)(305945005)(15650500001)(2616005)(126002)(44832011)(36756003)(106466001)(48376002)(186003)(107886003)(50226002)(6916009)(14444005)(6666003)(8936002)(4326008)(26005)(106002)(8676002)(246002)(47776003)(16586007)(51416003)(356003)(77096007)(72206003)(478600001)(2906002)(7696005)(54906003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3127;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD009;1:wI5zR10VB1l0eBGHqZ+MCUugzwAnUumaz54TT78HY8KhBeGKvLfxSV3xOPTzgXLnkjSFzH1+rDgxIKQxFga2rjsczWzn8q6GKPpn+RhnElqr5CeRGDMLFTdey1oGfxyT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 139022e0-55c8-461f-1c05-08d606acc68b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR03MB3127;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3127;3:O/Hh3qiDB9ipL+ltfhovC8yxBySzSFbpHmBbHQBfXL64B8WwuIsFx/wPQcIbRhsKTgzVFZgZZ4RcW2itOGpd44/jJhoCdHmjG9dULS6t8NJAvdAxYV8n3ehYDMfAe7i3l8lAlwrtmaSVKE7gBhwDZUZyHH2PghC5yDA1XpPCZR7JQ0Q0B1mVUOLulSy5AlrV4wxHaJ1Pmt3Kl4X9Z6+FSZ0NhQHjvHjJnvFabSCCo8i2olkmCx6tQcWcKLkfg7uPXGBN5+a0jdJWKzQGjqHQuotT567EBxq1286FkaGuBsoIOgGfmflDji9OnTwUvog5NELyHaxGZBDoFxAWlpApAJ6LBjxiu796Dk5Oi+DzkG0=;25:v78eYkcSYYrpWLOOCCn5hxAgueeDOeBg8Xcoig2R+1L++MfWEgW8iB1g5ajgjqsIJPBaEtRbuWJtuhJ98+nJ7aHvECpa0hTHTjXAPva6Do4sUYMP7tVDFpsbtDg2QnlD70/5eQtrP8r5eKHXOj52Vn1GEnHBPYSELLtTGZhkLLJd3Kvx9CpKzyoJHsHFG15oMdV5lsOMIfodyWniA6CF6vXAvkc0jyfh9mEzsJF5RWKVIlGe/OTF5SkWaMRjIpLMuShazlJQiaLSw5bzaSW882bICZH8S4NqYDSJtPNyJhgfvbuXF4QEVOUjLJUIN+cCV9HRs5zj90TeY8ATyszcow==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3127:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3127;31:3eXf+OOTzlNgAYy3wVlQulK+/4vikYRRBKQT8JCEvShiB0Nm8R1DA6rYKIuLU80JXVSUTzH9hk25+kqTsQO4jlm0R1lwca3imBi+9ZhY4OwtNaTkYqnAApp1VchQbS1yHd0BhvplZSqHZrT1dJ60ia1rnCy1dPaeYWBnW8BKBC4ey3hrVNIAtEqIXbLAbtD6kGooQWoNKkhpjaocriUdtASRrBF2S+H9NKokPO0KnEY=;20:KjG5VCsplov/WGwvKaRVzU2bnZUZSkcsJKIqIUVRsvxLyYJLNTtJp2p4EE6b0VczPsESULB8eHdW6JYRTbFNLNPOU+NpssELJf9ExwOlV1bAf/FCZJ4PZgpRkW6DDAsZfgeceIqf/FJLLTg4Vh4We5t+J77WJ0uqkOCnLWA0K1bhrOjCt6PGfKA7a8HP/KfD0xCqoWAyBEyc+QUmp4dp/V9JxZ24bQOPRxQmUFAfbK3eHdqpdYG6ruYCMCPMypm/6Qz8faAZgZmPeXVFXO0ND75L9tEpvcQmAyNVfx1Ak8i6OXj6jEI4rF+XXK7Z/24NVJIyfB7lf9eIdAN1OaRVWAjVp8WD6mvnfV7oEyZsstJVFhRsnoC6LavQR6wM2NDoclE1joUxO91havL/dre6KJaQ6goL55jbPTrwMF39w3tSyCVBa4upN8jvj3ZnOUTyHN97dVCYQEJLPmkLdj9hLjfZA959MZPKindBJ2GS6pY1Nj+t7jaPJx0Uiq+o2+vI
X-Microsoft-Antispam-PRVS: <CY4PR03MB3127E6DCBD60AFD60D3463139D320@CY4PR03MB3127.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:CY4PR03MB3127;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3127;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3127;4:nAYsOizuderhQrsJWI7Q+vTlD5Zck82MuxoKMBjcyJSIMgADy3sp8bE48eR60vphnm37WFreBA04SQa10AqbCbr5NMMLxjNPtO0+7rghlGv5TwJLLTUuMyk+VcKYV5z2yD5M7Zm69R5zAg/BUE5BD5yo/sFOYy/Rd6qrAEgEWaaOJuoQr+oev4kBpEMROdDHbxHj16PgYchABFLd8z6eS3QqXWVmjQFrTnlxAxnS/L7KSfsWGf/pztCslKjLz3bJv39w+w2Ov2Zb1BJpGVmnS7SA9QrWAckVc/6JEPceqPcbcSejNaC0oIqWsueCmUuk
X-Forefront-PRVS: 0770F75EA9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3127;23:e20ZGp1P4Rir+H+yAvnN7SAPQR8dodqfKB3M92l0d?=
 =?us-ascii?Q?7WwVFMqUsK+yIYTmV+LGYL8X659LtKhzagHEKsnvzsDXtdAg9nYvTZ7WPZ6j?=
 =?us-ascii?Q?oAeVUq5O/hTTkUyNmI8GK5z1ly+ebuGYZgtho1nZlFLus/GI/bEeFjR0FlO1?=
 =?us-ascii?Q?RghcpPWljz56ZsXcE/GzrtOmpKz4Pf7Y9lvlHn2DpK3Eq2ziAnTHiw5oxReX?=
 =?us-ascii?Q?52Ab/zGV1o5OZxLTAZjGUyHORNNc9MQC1Br9tVhd1qHN5ECk2f51wUnlG85Q?=
 =?us-ascii?Q?Jx5JLV8MgWO4+DHCQgHrtApVZqMzHz7rNCn224JETBxjn8gNGwPhdupjsFKK?=
 =?us-ascii?Q?/un96/yXgAwKRovCkUbRzvSlOx+yPY5rRuI4S0vpLtgGW+txwVtkZ3c0ZqWI?=
 =?us-ascii?Q?MU3STfDvl3pnBPD+ka3RTp3U/amtzH9a39aolwXXH1wLLc2w18MVZyCcuuDN?=
 =?us-ascii?Q?rsG1On/9VWB07K5RemH4io9sW2pNo4VgVqTb4VuSxbQoQhAgRXHlo9lv2PjM?=
 =?us-ascii?Q?/tOLi4iY3zXcEvo9JqE70+yL3pohlR8uIyqxFnRkYKKGPsWKwX04HwhwCoHH?=
 =?us-ascii?Q?4ItfSwJN0E/sHGOX+c3YpkWX7Ae/a+arvV9eGaPLc6cq0meu0aH5bj/+aLYu?=
 =?us-ascii?Q?mvRRfLMLMpmWhvUgcfFfTwBzy3RzaOPO1ENYREOnA7bveJShgzOuPGqfhDKP?=
 =?us-ascii?Q?5XAiah9NJ2qgNzIHfd+PgMyQLTCo/gYr7O98qWdIxCKAgHaK2kZ8iLzpH7ZK?=
 =?us-ascii?Q?ZocQ7ZacGKiddAMZTAk2lSROBYl/XW98qroLRKFrfD6LqMHJFYUzNrsmZoND?=
 =?us-ascii?Q?ocHDIdnUxDfKLa6M4QldpO4mSO4mT1KQ4L71KADvc+2KA0eMA9/zh1+TE+ix?=
 =?us-ascii?Q?wk4GE4UqCQ9h0HL7oIV5MSfvofv40tcOrRufSd3byYmC+Q3GzcEwkxaZsCWv?=
 =?us-ascii?Q?ec4FPUWLfl+JJXtjQ9P/q/Y6xzyln58Bth457B/QlIawl8/AaffnHW4K117M?=
 =?us-ascii?Q?8irq4NLTWuNzHgkNd4zeGRn02UtTmovSQ/6DA0ifUP2JZzgv9KTUNL+rOHM8?=
 =?us-ascii?Q?1PEULqOSUQVL4ArHqzXKWP71lzu?=
X-Microsoft-Antispam-Message-Info: n+10REI/PbX96qJcUoZ+ckhYvRCysp3qbuyH12kN7ObSUIWDNBQtCXv5KxyYfJXyy1jBnqLlY8FG116I32XVYjZk3WfNQAd95ZEIwSVjkTo3CgjWQ5l5sp04/ycHLCZL/OZKHRy3cika/IN0hAP6RsPrju7RA9uReTYrH6S7p7rJh8h0RAxb3urNTIvtLZShtyptWN1hHu12xMt8KjE/sjijA7Et7ZQ7IVmQOhQGgOTpHyI2XC5qAmEsoVGZ++UpspVNi99DhYQV3s8IdOhZnidVZoh+matmBGtfTVAw4+yNo+46kJAw3D0UU7Wj+reQiStxp7KUw7ihIRJ5uBd4slFm0eJAcHlV6uop2y1/i9c=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3127;6:D/aPc5ATgno8OKEcUWFyUVcZyM1mKhL7d95JTRqhylcUXn74NkCKfzOPam11YyOSn+BkceRLpl4IkTGxPjegL3uQd5/qhd3He2iJNpw/LceDsrzcmFZO58VWINXmoHTkfuq/Jy6i6Xy6PANkzCrCXxdyL7roA6IJqtxWfG4+2Ge1Fv9scRAiNNfq9n3frsHn4EU8CfDKZPvz7r1St4AgeknwsJAAG0bL6oGCiezhKYWhOLunJ9VYpDYqD8+4TAF5iMA922l7B3De1n/XNPJeBhs/1NrEFIEIsHKrpFMp+5oFXFfvBwKGHXrMCabFmUdLW1C+QymJzG9tDJB8wO4+/lywTs2cowbNn+wGj4uXoWHZkXkWB4SkycL0YKR9hpMio9PU4guQbDfAj0UtZtF4O5j6SmTa4K+935jnOcjVcu7BZXvwmOTibbIZd5HuItP00cyWpiRA/Tndhv7lkVpw8g==;5:dmpnP+9G8i29ipeG/JK9FhAhkpTTY4e3DT6Ls8Szli4kB0lqN9hYU6zlIX4Isr/JjI0iwA3iBuk78bMhfOBH9s3/bXC8oUtE/rTt68Rt38sBzfz99rrQ6v28UV0JA/Hyhjr10F0QFAAiORiwetMHNmu6IElY8CrHTY9A6mALR6c=;7:bruWpNZj3Ins2FE1GI09Pt+8XczpF6RAXm3B3025oSjXml97n184yLofkan54TyuJLKVn4Rvy13ZVg9uxIZOnFcQqOIUIUKdUimWSmZjuKH0rRNRi/KmtJ2C9SMzbLXZLHBwdFkZeke4ynd8he+AzxqcfQVmrF5waMIMSktmK6Un4sEqXdEqTMtKMKXuVeIwgCIPcF/1NbbEKZhTadOfM8Gy3Fy2s48SDqQwl7jDj31JjeC+NdtTiSmvuiemdFl3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 14:54:05.1838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139022e0-55c8-461f-1c05-08d606acc68b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a validate_device callback for the trigger which makes
sure that other devices are rejected.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index d2fdc75..5a039ba 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -762,11 +762,24 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
 	return adxl372_set_interrupts(st, mask, 0);
 }
 
+static int adxl372_validate_trigger(struct iio_dev *indio_dev,
+				    struct iio_trigger *trig)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (st->dready_trig != trig)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct iio_trigger_ops adxl372_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
 static const struct iio_info adxl372_info = {
+	.validate_trigger = &adxl372_validate_trigger,
 	.read_raw = adxl372_read_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
-- 
2.7.4

