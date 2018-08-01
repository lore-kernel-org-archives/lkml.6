Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B350C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EF520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="DDoGPh1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EF520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389903AbeHARE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:04:57 -0400
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com ([104.47.37.49]:30402
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389656AbeHARE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtIMqf2td3NL077TAinUxlTufFvgz44gLQ2PR+qTjmQ=;
 b=DDoGPh1TehbjKPh7yZCL5GL29JTUotrc2AdXNn6KFr/IcAiFfYjDbxNg+VNw76DP7TEuvVJ7WW+YsBlaaQIhUeLuVwWvf2XzyUMMVX2wZFVf3xKxfMbwg9OLqO8JWm761Pf+eLwX2YZQxCTBVQk3vZ5iWebRtl4J3Tj16CvZAiQ=
Received: from BN3PR03CA0104.namprd03.prod.outlook.com (2603:10b6:400:4::22)
 by BY2PR03MB555.namprd03.prod.outlook.com (2a01:111:e400:2c37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 1 Aug
 2018 15:18:26 +0000
Received: from BL2FFO11FD013.protection.gbl (2a01:111:f400:7c09::193) by
 BN3PR03CA0104.outlook.office365.com (2603:10b6:400:4::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Wed, 1 Aug 2018 15:18:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD013.mail.protection.outlook.com (10.173.160.221) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1017.15 via Frontend Transport; Wed, 1 Aug 2018 15:18:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w71FIOIO015639
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 1 Aug 2018 08:18:24 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 1 Aug 2018
 11:18:23 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 4/6] iio:adxl372: Add FIFO and interrupts support
Date:   Wed, 1 Aug 2018 18:18:12 +0300
Message-ID: <1533136692-31935-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(438002)(199004)(189003)(316002)(7636002)(44832011)(16586007)(48376002)(426003)(336012)(246002)(50466002)(305945005)(486006)(2616005)(476003)(126002)(53416004)(8936002)(72206003)(5660300001)(478600001)(6916009)(50226002)(6666003)(8676002)(2351001)(77096007)(26005)(106466001)(47776003)(2906002)(186003)(36756003)(54906003)(14444005)(4326008)(107886003)(106002)(7696005)(51416003)(356003)(334744003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB555;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD013;1:MSAsmGfC6pqACY7lKGurCf4lkXrRmHOV3cY2R2jWCRfz6xoJqcVOTQRhCiWppJ+1Ulh7+WkaZcFr4rDEhuxdsGU3pPnTAfn1MJ4OatdwOxbjDgq6NL8gvTqYAeZs78+D
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a8506dc-0429-4641-ac44-08d5f7c206b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR03MB555;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB555;3:8kiH/pvUxLwXvFtWAlr03nzyETEEhVsCE7EqiuoLORTdpfZrV8MATmEzXe1bVfdQgA0/RAA8cHOzXBCdhbnOC0QRzNFcXtf0499iq1GEcLH4C43i4BF0fw+K6ksT5GwwVNVRBH9V8aydOP4HB5nlIa/S7wU/CBHtnnFfYmrGsh/xZe8K9SrpE/sLdsngvsQF5l5hItUqRof9sI/mSwVQR0qJJHkOPzoYUR5cAIHY2JxWmKOBWs3NdKitq+eYE5LnIq8ysZpb8wDbg6kdy6wyrHFU5Xbh3A81jx5+8cBv/Wbhvm10gyNGGQauNIVmn4Y2DQJVU5kmIMVMr9bKUL2XF5HdpkfMC32KbCY3P7h2qsI=;25:GU8meSUyenQ62z6JYs1WGkwRbawUUYR3WG80k/CWaZbvPuUdC84ffXajxOaGihf5AfxILrUGPcRkZHNNIUyXUsqBxbR3jyCDfnv4isVOUqLK+vrbk1GC8EK8zYn90iyNzj3aiHXJzRng+Ov++eLPinnE0PzfHnrsY6Cuyd765tvjO6Nxu6iub2pssTdYY1wLKOlDzzDvfmAArGOtk0FcMCoshqr7fNf+tfadsOJ5TBMARifgEdfKvmDx8FnqSWYg4vkpUAegQknWbkE01S5n0fj7hAt1gd8iIR+8BkDwev85Z4GNgmt0RbcmxwmUwEg6BKA6fQURxlUg4sjdJe4NHQ==
X-MS-TrafficTypeDiagnostic: BY2PR03MB555:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB555;31:E4nzT/BzaSaQLumhM4Hi3Ukr4wfSWp/VwwuPGw5mmDWfLZOshSl4wLjoDjeKWJmgPTUY39VFvetOLqrc0/p5ycMVdbdQyVzvbCI9p3jWDHdzWPgUejLKKdM5huqYyvMCDWzR4EqxYxTxMR1V/F7BUwEZ5Mjlny+xt3w6/Q7C9ZBKR9wlsNbK3erGOWJmesriB/+ecLQGCwEfFRZq5fpehvZx8jSko4tr8tXhYejJSNE=;20:dENAXqLxYUTtsfTGm/ww6g9TgvHlCnHnVKWCwyZUTpugH7I9B7kiOs93rTS/qWvD3rijx5hSrHWkROFAYhLQeMbXhGBEc5jTnr5+OfvihUugAl5cPLug0EbFK7xK2XNIusAC2sCIsNJPkHAqISVzyxd/oA329AH5gH4zyfbolJa5CpEcairv3lBaimMyoeOFSTTue2cWemgGoZbTPeiwKex1LsFB7GoT6X9BZnorfJP+pu1Sx2DO3sx/JS7/7wIG2fCJdPY9+bFtx5CX7NihtD2GtzvQtRxifCxMaHusIekuvl3I2FmFEo56lgw9ktYliQRSM7sQkQ1yRHSH3BPBqorQhNYBMPa2XZp0mrsuf1Civ8JESN30qAt+WNA4IgpMuCqg4+GGMvxHLiRxUSK2yRGvC6j5lnHN67+XSkeaF7FwyFWU9y8HfQ7VFoWT8/iD3NPQ3FeznAnQszs53n5p+/n9NtmYy/hg0j7rZO4goPTLX8zTOQEqEq+eD76s6mWC
X-Microsoft-Antispam-PRVS: <BY2PR03MB55541AE9CD5C4C06DDDA3AB9D2D0@BY2PR03MB555.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB555;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB555;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB555;4:xcuQpOMl9zjnQEqqpoAH8cJrYbgj8rMw1KAmfzoJE3BQhsgYw5aSorIc4S60gSFFMyus34LC/PS0AwobyFuoRUsh2jqTRXeNyK5tTCSQ1Rq/3OzavpSJwyFjmCOmKrmVsiI5IjcHcHobP5e7/ca1Tlfk8lOXqYWK5tmJgQs7B1XOBWlvrAmINx3MLX+IZjAICBl37xw07i2/8XnKi0bwk49TPUXyt+rdU/UD5fwenmJWqfZtdT1atvOp2RL4ejTfGmHGG7j+bvuE58TIlOljIYuY0ECzHO+oNQQ29GribxU2rAyNJhTuf/Yj1sHFuoH4aFT62TwQ5/cSNrDI/bolmTismktzJfEMYClW8JbmKV/UHVMceVNEXfdf0GaongqK
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB555;23:qnpwyqxRe0pzti6o/TBIOY5dOCpdinyTAFjz7xUthe?=
 =?us-ascii?Q?gi/KMB6/w9CMSIL9/HkWO4QXlQ/X1UvIZ8rV75Nenv9w9obARwjWPCWVGq8w?=
 =?us-ascii?Q?p/9iqMUSS2alO5YdUsaXbGu2Vrvpr4itEluZZmLn3uCn3DnhiVjnzQxvEfwh?=
 =?us-ascii?Q?/OAhnk7RupKKy65Z9V0oj3mBEzAPEo6kd7cz2/yaYcxHanUirSeXMzhGin2u?=
 =?us-ascii?Q?pjIr6P+Cx84uKJ1Q6dy4ICR4GC8r6ciDUldggWQY5YssCy+yrCXrr5nB2oSQ?=
 =?us-ascii?Q?5m693gZpjlu68Bw1TG+OVBylib3NQDdU3gDC3ysOtTxPIqKbXNTBt0qBoJD9?=
 =?us-ascii?Q?l5nnxLYtw+AMVo/MJGqr/I89wzl8nzeQP3klD4RROLbqg56czUx4+1MRcQGx?=
 =?us-ascii?Q?F43A3XqGQRcBdWYQpd1y11Go6Wxy588G34UEJwvSnN4mN35A2DWJkQLo6msy?=
 =?us-ascii?Q?lkbhbBGfp5GIlqqAbAyHrMghUi3dsQ6tKQbCi/x14szEgxOxC80PyO3BQY2g?=
 =?us-ascii?Q?34cRH+pmX9WKWl4YVQ7cUE8sBRWEuO0vr1UrXk7eKgngfmEsTv+tpnYQ9+dN?=
 =?us-ascii?Q?aAKRLqMzK5BGMOTteEyI8DbbqQALfVPEYM4/35gKOmS7qXCQeaOy6hMni70I?=
 =?us-ascii?Q?F6tASJWeBILUFlU9fF1ok+TKMtA7niVnOaFKqsqyRrpX/uxPJztwg4plEfz5?=
 =?us-ascii?Q?x6FyUvjlnv0gs1qT4M6SXi/BZlsFh0fM5+xQoitn2aRVukhtcw3OYTOz30/6?=
 =?us-ascii?Q?u2xEb9l0dnuJUISrKMduUp5KNXLrh0d8PweRczVdHEhAKLh3IW3U6waYx1JE?=
 =?us-ascii?Q?RHt5bKE5d3afBHXMrV61kJgeK1VbF5mfwgf7JA9JyISNxgjlr3fIm6xXnPZ6?=
 =?us-ascii?Q?RI6XpiaSk3YCCBL0nUxfRAu1aTfWrds1+5qOaKRlnvXLa74sRuN326W4jI5A?=
 =?us-ascii?Q?W5meQqjMu1BtkWZv/E3Pve3DiU5nfKSbcyCn5+vdzN01sYT1hdW2ikxuc1gy?=
 =?us-ascii?Q?Vi7bPtUss4TrrnNYrY8Qrayn+CH9Qc0BZWCdgigvMuWsRa0RAKLtUXTg7T2m?=
 =?us-ascii?Q?yiddrmI/i8RyLZMC+cX/gF5Pr3?=
X-Microsoft-Antispam-Message-Info: W32qK3DoSUTdz9HkuKT8ncGW7TcVKdpt8JJxLR6GzzctBBe/XXkG18tRSqVaf5G492duT3aQqwXdZY73Gu1aip1GaxEbvEJxaNQX6jVPkpohtrLBsUVE9Q+IUrgksDwK09CPEVTcViUMkZGhXtpC/4pdLoYC7f1boKYH1jv7lmGU6IKle3/K+cw/2zV7ctHt558x2pZ1NVQlCT2rRciZe8LXpKtGIaT14mGQ0URGzX+/kjKkrGu56qPb4jZBWlhUBHwJC15J0BHDTfQrC8j98ndCTV8ECthSXZXFkrMU3+XowUdlfbA0c+74jTognhsovATURkQ53QwS7z8WihXsnR4OBvV1eeFSb+zi4yk45bQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB555;6:eUr15I8jit/3Q8aUAf0SYqj5Vb4bwjGkdBlrf/jMKOAG7RSASsvIMiJLSFWoGW6UjOrpGTG+wi9Js98c+5xUddK2jBMZgn+ygXAB6rpX3GAcu2zHAWFkENd7wj03XdcG5uUg+urVTR1r6fSK3BE1n5HFNfKXl69oPYrdgJ0WaUC5kZaJpm9cB4qFMOWUjBa+RHvOvKyEstymrAvPLHq2Eu7IPZeToC8NnCYmwaiNg7fjX6P/Pj//tt3Y/9FV2y/SL/cKYLbaoABz1FuUOemxmio2trs6ldYTiKa7k9kmsSkffU8G/1Ddti0y5/fUQpdM9qThZ15kFx6I2tpBt5k0ACgVlIYf+VXX74UFIFsTPXxb8enYC0ECjPjQFpX/H/8iBRRixXaJqJ3oZ0OSMg7QTKM7o8EcXiejY02O4cZ3ecd9cPnNIohlwCY/GhePDvzQiVXVt7OsVrNQ9LnvuqGOAg==;5:sPj8FARjM5e5UmXywXNmqTzflXWtSdjSySyu2bk/Jo+ZwJajwtwi6EkQuaIviW1zBKQVY069Jeo8FndZ8xnhtm2+M/KP4fSqd0Jx/P4LdUDBFFocOfBv4wvAy3mSB+ugqsXgIpbrtvee282XHmvd3ODnQHkkVgvJ3Yo8KdUKbi4=;7:bq+E1PKZGnUzZcfBVieyvnB/psLoJ3ezeRNte+UWZRj8jOwpv+9nrBz7riaV7ZB6oRFl2yEtNu41eC+pEfawezLmeYZ7F1ZJm1y73dS9N+Utz/LDXss/Kkny82nG2+uW1AeX2v6+jRQpB16K41uAqyj9VuzyTBtcb5hBN8uy/e5sixWhm04TSXoPyTy50hPhscMCLPqururUnLo7ZAIMWkf6VCt1nMpBhudb6KOu696ia5eAutbjgUGS5Lbo/W54
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 15:18:24.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8506dc-0429-4641-ac44-08d5f7c206b2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the adxl372 FIFO. In order to accomplish this,
triggered buffers were used.

The number of FIFO samples which trigger the watermark interrupt can be
configured by using the buffer watermark. The FIFO format is determined by
configuring the scan elements for each axis. Moreover, the FIFO can also
be configured in the XYZ peak mode.

The FIFO data is pushed to the IIO device's buffer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:	  
	- removed DT bindings changes from this patch.
	- removed the linux/gpio/consumer.h header.
	- used regmap_pipe_read() instead of regmap_bulk_read() when
	  reading data from the FIFO.
	- used multiple regmap_write() calls instead of a single
	  regmap_bulk_write() if there is no fast path.
	- used be32_to_cpu() inside the adxl372_get_status() function.
	- added a new in_accel_x&y&z_peak scan element which allows the
	  user to set the FIFO into XYZ peak mode.
	- used a adxl372_axis_lookup_table() to determine the fifo format
	  from the active_scan_mask.
	- made IRQ optional.

 drivers/iio/accel/adxl372.c | 362 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 361 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 7d5092d..68862bf 100644
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
@@ -123,6 +130,8 @@
 #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
 #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
 
+#define ADXL372_FIFO_SIZE			512
+
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
  * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
@@ -164,6 +173,44 @@ enum adxl372_bandwidth {
 	ADXL372_BW_3200HZ,
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
+	{ BIT(3), ADXL372_XYZ_PEAK_FIFO }
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -171,25 +218,69 @@ enum adxl372_bandwidth {
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
 	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
 	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
 	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.extend_name = "peak",
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+			.shift = 4,
+		}
+	}
 };
 
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
+	__be16				fifo_buf[512];
+};
+
+static const unsigned long adxl372_channel_masks[] = {
+	BIT(0), BIT(1), BIT(2),
+	BIT(0) | BIT(1),
+	BIT(0) | BIT(2),
+	BIT(1) | BIT(2),
+	BIT(0) | BIT(1) | BIT(2),
+	BIT(3),
+	0
 };
 
+static int adxl372_read_fifo(struct adxl372_state *st, u16 fifo_entries)
+{
+	return regmap_pipe_read(st->regmap, ADXL372_FIFO_DATA,
+				st->fifo_buf, fifo_entries * 2);
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
@@ -364,6 +455,107 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
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
+	/* STATUS, STATUS2, FIFO_ENTRIES2 and FIFO_ENTRIES are adjacent regs */
+	ret = regmap_bulk_read(st->regmap, ADXL372_STATUS_1,
+			       &buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	val = be32_to_cpu(buf);
+
+	*status1 = val >> 24;
+	*status2 = val >> 16;
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
+	u16 fifo_entries, i;
+	int ret;
+
+	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
+	if (ret < 0)
+		goto err;
+
+	if ((st->fifo_mode != ADXL372_FIFO_BYPASSED) &&
+	    (ADXL372_STATUS_1_FIFO_FULL(status1))) {
+		/*
+		 * When reading data from multiple axes from the FIFO,
+		 * to ensure that data is not overwritten and stored out
+		 * of order at least one sample set must be left in the
+		 * FIFO after every read.
+		 */
+		fifo_entries -= st->fifo_set_size;
+
+		ret = adxl372_read_fifo(st, fifo_entries);
+		if (ret < 0)
+			goto err;
+
+		for (i = 0; i < fifo_entries * 2; i += st->fifo_set_size * 2)
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
@@ -443,7 +635,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 
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
 
@@ -459,9 +656,136 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
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
+
+	if (st->fifo_format == ADXL372_XYZ_PEAK_FIFO)
+		st->fifo_set_size = 3;
+	else
+		st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
+						  indio_dev->masklength);
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
+
+	adxl372_set_interrupts(st, 0, 0);
+	st->fifo_mode = ADXL372_FIFO_BYPASSED;
+	adxl372_configure_fifo(st);
+
+	return iio_triggered_buffer_predisable(indio_dev);
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
@@ -495,10 +819,11 @@ static int adxl372_probe(struct spi_device *spi)
 
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
@@ -506,6 +831,41 @@ static int adxl372_probe(struct spi_device *spi)
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

