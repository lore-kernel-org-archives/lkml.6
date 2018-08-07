Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F0BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D612C21502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ho/XK99P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D612C21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbeHGRJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:09:23 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:52795
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388523AbeHGRJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU1mVXRgLVmJvWGeAIuQOXomtms0qT7vnGiXZGkhiSs=;
 b=ho/XK99P+L1INWebImhmDktU9ou02gfMmPipt5VynggGQfP86BFtRCLvR3nE4BXb52mVWpm/2R3Yjr+gjzaDQoHYrNVQtHJHrnXLjQ33r4wJuv0mOlgF7v7vmTceP/QWsraaCHAJ0iI8Gj+xbhc0WszkQE6lXAVZ+k6EjzGAzbs=
Received: from BLUPR0301CA0017.namprd03.prod.outlook.com
 (2a01:111:e400:5259::27) by BN6PR03MB3123.namprd03.prod.outlook.com
 (2603:10b6:405:3c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.20; Tue, 7 Aug
 2018 14:54:19 +0000
Received: from BL2FFO11FD017.protection.gbl (2a01:111:f400:7c09::145) by
 BLUPR0301CA0017.outlook.office365.com (2a01:111:e400:5259::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Tue, 7 Aug 2018 14:54:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD017.mail.protection.outlook.com (10.173.161.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Tue, 7 Aug 2018 14:54:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w77EsItM017770
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 7 Aug 2018 07:54:18 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:54:17 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/6] iio:adxl372: Add FIFO and interrupts support
Date:   Tue, 7 Aug 2018 17:52:18 +0300
Message-ID: <1533653540-24796-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(438002)(189003)(199004)(7636002)(186003)(356003)(486006)(336012)(50466002)(2616005)(11346002)(8676002)(426003)(48376002)(446003)(126002)(36756003)(4326008)(476003)(26005)(44832011)(14444005)(305945005)(8936002)(246002)(77096007)(7696005)(76176011)(50226002)(478600001)(51416003)(53416004)(106002)(110136005)(54906003)(106466001)(316002)(72206003)(16586007)(5660300001)(7416002)(2906002)(575784001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3123;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD017;1:945Hv975R1a4WqoQW29PRSATvqKpGTxR2Qm/2fyf9LIK8QdUCZ0VZUfNxHY2KBLLu0PUYysxagK3iVPgPZFKudSU8XjFaw0w8/dKJ7MnRCb57UPx9RQUmeNqWjku9rYR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cc62e44-d937-400f-2ec3-08d5fc75a735
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR03MB3123;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;3:3oKNXyX+rYpqP4UYQ1+A1o9A/Np2vL4EUBAhcMiocNcs5/gdzm6iHWBz26xydJ7nxS4ct9pqUj7T1J2w1s9eCzrVyEhg/7F8yVg92STNycTgs014/qB/ZB8OIaEmhiK6sVcHBLB5aZRv3ljBKYwyXTZdn9sjuzmtsxGPdpgyDWXj40oAFirSoDBxAEanhOU8j9EdID9m6j7Di2sjy+AIf4AqukUEGWTSFxs04FJIJaId5c/TCHzk2Z49qSXpInoZm0Vr75cRcDjwXUBDrNfNvzUFb+uuNyP5WY5F88ZQsIzOynbhvTG1+LA1YvlQv66R/YFRgd5YTOhZdwuLdCidiQ6wFEud4JKYsW5l2NltN1A=;25:mIZIAPDe+OqRoJGlnL/9ay2hD5uw91RasMOmaNGa93WmOu+gnZcZGi+eGv94otJvoCIN5SxFei/WfzCsSCHljDK5SEfk9e+IuPALNyPGm/Di3gPXT75TIOgKjokaaRqDvqBgP9sMvPwyO8QSCW8mSXWgB3p/ZE0PNedVgT+dfRalXa+rU5OXxW7R+sehPgWvuNSsZKbGAJQ8BKalaX91E0fcBS9J3WLxbxxSyL7ZUNtGBq1RjxqsCbf7rwLSKWizH2z1qZjJtGMFsW0gKMRVnyI5Rs6M0aMmt76IQn5VXk7MpaRuzZX6bX8+bHU80LHqNc7yfruzDv48O8oPU/2lVg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3123:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;31:jqJ0msodlu4gK9dsr4om4F5DAJWXAMdaCSw/5WuYEsA6iMAxkg0rGsBg2tf5BwAFM9wR30npiDkTd6OieerkKg690aPsecg116EcgJokDOwbqUPBPzlOyvuw4VizwqksfCwcCJCsXWg9ZlDmtVqXl/c0+45Gq3gZRBmucJopz38AUlZqhCB8xHeBo3kIVcIdScYFUBsz17r7EFbpDjh2X2dSITNJqZsnuYAplYGqjjs=;20:uCy78/geJDw8T351iKPBQBNaE+KhvRqqdpMd8FP4NwwTq9VUx6UosugNeQyPeq6uzplvU6HYc0Ic6vMBYiIF/8WIW1iD8iD94sryRewyHKlR+BlvZJobWHhLRwp2dJ06LUY2Zl4256Uf/T77aRTPDK+k7xBKkaHxRZ4VBInyr7/r6art92d2HXrouFYTzH2uvMJlocO2uaGenbC8oI/Oh5uHwfK0h/PGnuYA3VCJ8xcwwkFzabRcV+psUwpDoc7l3eO9g7uVsmCmxi1G53akMQRi0cPPp31FFWprfSKyB+zb06dkRd0pcQdh1KmfKrb4er32MMSC0/PMKYpMM2i7JsX82dUqHwt/OLMu/O8CcqM2/ldphBHkWRVLtBmEzC80MlQZjTAo8/zbwXvwA9FDUKHpk42xk99VTRwQtbhjFcjn1L5cACnE2OTlfLHaAUbvbV16cYC9vF3mfzbt0AzJ7WxIe99BvCROlgq5eTNhwOt+VA+WA4cZDldczY8dvorl
X-Microsoft-Antispam-PRVS: <BN6PR03MB3123BFDB4604CDE2D7203AF99D270@BN6PR03MB3123.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3123;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3123;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;4:s/9cDC+C0TEICwwruqns4upJLXTBYXrrhGf7EqEgK2/VIStcr84wFUuuKbS3zCK7dtkcBHzoIj8xiXJgUvUYYbwMpYk32n6C8wY36NXFGNQr+3mZpJ7jd1SyLEiVLeqX9caKRWLk2ENlfTLczpng+kkMDlwFqwLRdn3iYBTtzHwWY9uzQUJkhnQgFUWAYRoK4ciK3oW1ihtQAb6V0C7UhPR6fmEEuy6NlNgpShSsRwYFMrrD/rF6dBMWMQjglCnOv28DUo0h0KavtLZFJuMV1Hs2u99lWzEpoSSvU+LEROBi6GaERkXLT4MKazgCEpupFL4mktHQdP6C7OhekjLMOvYUg8VXtwTGoV8qdiQF6Ik=
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3123;23:PF9c24624+T3OxVfsgH88HFUEN4c5iFOk9ahpLhVQ?=
 =?us-ascii?Q?H37SnYAj6/93jwrRR/YGhkpYPF28OQA/gWx0uOwuhYMhUtHXMQ8Gtg8mnkOe?=
 =?us-ascii?Q?43X6clYBRhU+4mm1yI3kqMVOjxPoevh5pcux+NEWKfoaEL89zzYeI7RNmZKN?=
 =?us-ascii?Q?GeKnNbLtoYGY7bS6EY//HUc+DVAjV5VYKdvV04pwz/IOmBg8UUL9g1uE/Lgp?=
 =?us-ascii?Q?+dG94Y4xhbHieFQwnjYOLPYcvuMyClpa793BUUBXRWXJdQb/WOFCUCNGhlG6?=
 =?us-ascii?Q?X+hR9KaiUk+UXwqJebHx7/i3ICV7+9jffXeIz21w4WM/IrHy2FEKxjBYC8Dy?=
 =?us-ascii?Q?Fk6UwW0Q/Y23vdf95+M2vxyOx4YQ/D3G24/WKZNQc1XrcwigK3/ERv1+RPUI?=
 =?us-ascii?Q?sTHxJn9Zj5YjM4DVRd4Mv3Z1FWZahzieN8mMlOuFw89V0aWIy58LhVjWKNye?=
 =?us-ascii?Q?w6brYAQ9P2LoTODx968xhB1ejZYY6oh1t7xDPYG8tOiB8Au4hJ7d7DTRh+Nq?=
 =?us-ascii?Q?TtzJcMCZKCLl+h5uIWhcl3z0of4G1xepLKEomnSd8LICQfy4qWP7gdjJhyN2?=
 =?us-ascii?Q?FcTN0BAOczZI72izaEaaErtdB85qjHgQSHKSVBDf2f2R0/iJ0pl8B3Gl+h5t?=
 =?us-ascii?Q?J4VRFO4jhDQu3F9fznVYwFKR/81h150ZnwbCvM8SxNiHM+QvBwO8XiV4QePK?=
 =?us-ascii?Q?/IYwOBPEF3j+d6uN835sFwlQKE5ypxaCA0Fb493gGU0lYGuQDXf6x+he8uIs?=
 =?us-ascii?Q?vBlHrv3yHyBLycz9RvTyhmQFd/MHk6bfng5HAs+K3HLU8ONZNR8LV9ZZCecx?=
 =?us-ascii?Q?zqufonPNmXmHOuU8cTsxLGvjc9LUpkymPJAwiO+xgmcBQ9y6HdVps8Q7fRGj?=
 =?us-ascii?Q?UMycvhcWrecoOjhOqS5tfOoUmZqB5rikZp8+dMZU87px12NF68Uwd8n3sAYU?=
 =?us-ascii?Q?WNUab59UuygDjfgT7NLfVxm9Ajalzv8cHC/OdqMexDaqT4hxK7+iS/B5cJMr?=
 =?us-ascii?Q?ZJSzeH9QL1F7JJJCI6EO9uxt7ADxR+PzK/69ya3ykB6Vazx5jCmyTg6SGM18?=
 =?us-ascii?Q?OfXIDagfZqkzYkpCxJ58pyaA5qhH8ViK5FAJCAwCzuWU20PwQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: IRw+5l/GXjC8OjvTO3yw5R1qFBfiGkVT6Is2v0pmyirTVe+kNurofHJYcYrMNCR6mgyUFpo3LSgEsdFNeUpfZqkTLdpO+FJsd1DPSBHWGn+2JSjlXFh2EmOo9xA7uOlwDFX8kBaA/U3AfNhDEfTX+rzx5x21ItzjkOpyxP8wrfPpYsvtLZRgDyQ7Avwm4NmBkebEyMJiwvQ8hsuS30lTONET4I8xAwoDuIeBcS2ALn0m/PuSAuPTH8JnJSIeXXbhQaLqBA/jxpsmeuZZW56ont25GjysSIrOfNKM/GlDO9QbobhAMl/EF95CiCQIVI/j9GX3cedZyx2BLgb/tT3QWA6yqKgL1VQYFsCXTG4twvg=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3123;6:2lJdY5OxM05/OZV8ZJWAWe0j0qw9qe+IWDNh0iNK+ev6DDl1xSVrZN5YsZhqC2uXyWzQTIOwYdYUPiQcpMLdTqIU4KGg/3j03c6Qw8OcMIUw20D4ZggEa2umWyeSUTbxXu4hg1OqHNsZZ0lg0l7Q151nXwma0fOfMPwkIN0Sop/ReE7TGMIlqJPGiIYTJKE6B998UUObxOAghJy+vjlyDd6u8wludtz/U1uGKBt0i4kIKfNB1o/Rem1JvtiiAzIcHZaktm8pqq42eIJhsPES8hTKDueIl6ZToJiHnKfn7MfHmrRx2uJ+SuI3+lfK5FjRMSxV5HZThyeKuDopyNqTrIhFke3Cr7+nJ2CVydTeZEDmYJgLvR2xQZ3GvIgzNRYZOAZws0DQaZ2s8cQwKWYweqDbi7idQnKtdlYwfrGZZe9YCocJjAYKK03vs+0pRN9u/tfIYpdv0n3UVcBOnHM4cw==;5:6cp3NifQhfejelqk2himlQ1EnqikLaPCegv6/4/Ru+boFfX6NuXdaUzwMpnM/3vLmmGqIEMLnqI3ZbOZWb8DCa890D3Yb0pvA4L1RMDllosKpYLybbykIYwr6QwzYgFxpyZpp8Fqr2GLB67YCfo1zz/QhGO7GEYPNlDki/ynBrw=;7:+E0OekCrL57+YgRudk2pFJ2Gv6rT5b4ZsQcbswn8js7MNdUhjcnpl6orkxtNZiisJviAMrrzMXwbmUVOg6jNF+r/LwTUuzlwAEcB1a0+GDhzyFvpsUS9qS2/GwaUjeZ7Kgs/0bhRoLv9ww3nEhrBhHyjqamLn0ACiWn1P+KnHpLHISDmtTY+5G3ESkEKvyfKUG2rUUlZ7nIYU9MXAw4mLhIYtAud5gCuHM6DgtSaIqLE0B03voRXsWQ8MVPy/9j9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:54:18.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc62e44-d937-400f-2ec3-08d5fc75a735
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3123
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
 drivers/iio/accel/adxl372.c | 354 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 353 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index db9ecd2..dfdceeb 100644
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
 
@@ -454,16 +636,150 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
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
 
+static bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
+{
+	return (reg == ADXL372_FIFO_DATA);
+}
+
 static const struct regmap_config adxl372_spi_regmap_config = {
 	.reg_bits = 7,
 	.pad_bits = 1,
 	.val_bits = 8,
 	.read_flag_mask = BIT(0),
+	.readable_noinc_reg = adxl372_readable_noinc_reg,
 };
 
 static int adxl372_probe(struct spi_device *spi)
@@ -490,10 +806,11 @@ static int adxl372_probe(struct spi_device *spi)
 
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
@@ -501,6 +818,41 @@ static int adxl372_probe(struct spi_device *spi)
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

