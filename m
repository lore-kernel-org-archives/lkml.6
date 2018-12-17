Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F81C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128D420645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="t69Cn9oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeLQMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:25:09 -0500
Received: from mail-eopbgr810040.outbound.protection.outlook.com ([40.107.81.40]:33440
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbeLQMZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTKwXQ5CLNBCPOn2zNXVn6JSO3H/Q35XSt7Wj/6E3/o=;
 b=t69Cn9oCuXItWQ/I2k9aJqDIBXqE5nn3YUKCiCuxTAwyJ4QiZNPeV9Gw95m5vm/Wt3J6EpDvFbkm3tAB8Fn7uoN/ZCNFPsBuXeJ5PzqQDpkAV8aYMLkH0z3EfhQ+v74LzOZk0z9YWhMGeFII16xX3lerhMrY/akHLIkBZWMcVDk=
Received: from DM6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:40::28) by
 SN6PR03MB3517.namprd03.prod.outlook.com (2603:10b6:805:41::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 12:25:03 +0000
Received: from BN1AFFO11FD006.protection.gbl (2a01:111:f400:7c10::126) by
 DM6PR03CA0015.outlook.office365.com (2603:10b6:5:40::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19 via Frontend Transport; Mon, 17 Dec 2018 12:25:03 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1AFFO11FD006.mail.protection.outlook.com (10.58.52.66) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Mon, 17 Dec 2018 12:25:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wBHCP2EV016567
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 04:25:02 -0800
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 07:25:02 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 3/6] staging: iio: adc: ad7606: Add support for threaded irq
Date:   Mon, 17 Dec 2018 14:23:37 +0200
Message-ID: <1545049420-16484-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(3190300001)(189003)(199004)(8936002)(54906003)(110136005)(72206003)(47776003)(478600001)(14444005)(48376002)(186003)(6666004)(356004)(106466001)(5660300001)(305945005)(7696005)(51416003)(7636002)(36756003)(50466002)(2616005)(53416004)(446003)(7416002)(2906002)(336012)(44832011)(16586007)(76176011)(11346002)(4326008)(426003)(26005)(8676002)(246002)(126002)(476003)(77096007)(316002)(50226002)(116002)(486006)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3517;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD006;1:Q8YyPguWkgo48IJnXHOVktMmWCAwkqHwZ+1xoV3IkQ8hW2d//VYrnVIYt860EydVn7kdlC95B4ApwiHFP3LK61Mkv5y/cRRFFWVyT7Ko5mHJToauhA3V4Ir/jxiOu32r
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7853e3ce-0fbc-41f8-31ff-08d6641aabb4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR03MB3517;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3517;3:Y1+EHuEV3OgPPN7YujmthcElbRwYMvSYVgQpnKKLCn0U5gJSnmLWIxLFhkGjMZ+CpugVAQ5dsVW4ZCoM3TWAVgpm0YZNCL5DrRa+QkUiz83Y/q5a4Bp2ct9npkD32Qim7lSRwZIF1Rc7n5HQyv8ftb/ll9VQAeKHCRYXjcu5N3R2+g7bQpCQatkVtmEx3XFkVmz+JS4wOuJ/ruH9UbK5WN7os3HKVX+2N89zxhoHxl7oTCqKL/1rNeydzTrvEzd39zGpnnrYFWyzA4TasjJZL2FyJzaAzOVyIDAITdpsIrMbhIKGEy/k3+4S7JBNTBG9/tIZQKHR4jB8rsNINIdTxW9XiNuRGWFF/2yVsSP2osA=;25:/3KNP4iON4Yegc0lJZQO0oYkceOxBBBjPFzGRJcVax3TPX5B/TGjmvzyL9Vz74TgiRCLooAwp/Ws/V9YckpnKtE/HUK6dTLw55HMBvsbQ2K0ckzKYurtUnmx73yIxdS/Fh7mC6qxe7CrRb/vgVb/mtRJbSI5udopjzdxxxtd1Saw4zGHuUciGWjQ1DDTKOmK4V0RLpPtPytR3TIPtucEHH2v6XQktBsehgo9HZKNqxZkR32G4q5Jw6bW43oSSEDJtrf3xqwSfh7THHn6Kx4Ac+3oHErss2wlFH05E1/EKmA5o2T+Gufc7KvkzfEOFdcnYuDPonP4UcED9MUTdxmttQ==
X-MS-TrafficTypeDiagnostic: SN6PR03MB3517:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3517;31:9mcEGizbE9vk6gfVTUVN0o+xb1dVjJJA1YeXoFWbvsh4EQZ8OUmBRlgH+N3EJZvR6iJA2nR33c/Jzm9VyihkxmqIzhIdi6vZ+leTdD/EBW6S/eg8f4WW6euQ+NCKTgUOKiT3PBUuckPTn2vp4I/skGZgcaVUGg0kMzUWuwUxRwcFhFYqeVAnrO4eFEJxdE1VWCEXoTgUw55ZJe4hbO08MZS5FCIN2A8GdLQUABA408Q=;20:E2FZssSwhCixkpyLZiuTlzMo7rql6ovatTBJ0Cae3NHvU0zozC/g0hbfX2J0S7sYILnsSzlyQ5PIjKg/oylVTWkhNYMDtG9T9jr+5aCSQSxu9fH1KlshdSJYfQtuQHsrlEAg5JHWHkXXCvFnwdWnrYV2W0MBn1zJFNuKiuTUSaikGYa2+PfFfcfzMNMYlvi3Zz+/rOhfotHe9wLK5aAFORyBfle0rlGxywmEPs1WRkXgitQTBRt2abY2y54uUCifF9jgs3itYUO9vuwTxbsIES93ZAmy1pqeuo++My6ghNgo5m1KUWTUiNdYsQie+Zu8TNqsnEoBaDBRbuYTjkNg7A9+ED43CMneFN3xBbWqw8wbDqFleNpYJQAVpzmNepcPvr67oYWTzDOLD2lMgKEodXUyT8Kr8QgrGDssVRhy1dhnJ/j+QwVkzusg+6UNGpJzKn3/veK4xl+cFezm1C0hUUsUqR0KM9vQldmWAMzS8EG9z+nDOiI5OpN87rZWNWZb
X-Microsoft-Antispam-PRVS: <SN6PR03MB3517A9D12C7241BA0BAECE1A9DBC0@SN6PR03MB3517.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB3517;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3517;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3517;4:wZJjQR9U+LH+ZALGjTE+kKCnadJ+fnRQ9sRcdladujA6BZjhcHYeBiC0JgW39VHtLlMHQ+Jk1ru4h1EBK1rkNhyu1ZTGpdebSJ+JBUq+OBKdOyb/KLzyjKb2wLON4kqpjblpkm7qg8BJe7dNirP2CAu7/bxjS58IvPvbh0pVOGsrDGpmDnFL4hEDcK5qSQmm97S/VSH/b1Lf0+b1PyUp1ZVd3LgVv2v09VzCWXVOR9g6qhIpbRqiILxH2QWBUpXb+NfpaViEGz+XdhR2M9iC5g==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3517;23:KI4wJs3ikkgwiMFgGhNQiv8FSgUUDFg6cf6JhLJ8J?=
 =?us-ascii?Q?YN3tVfTncrPHOHxzVDGamzX7yx+BPJQ+xbcjhESD8SWPCJi3hfXNRvL1yKla?=
 =?us-ascii?Q?Yac4rDEb/4p1U8yAP6xss0sA15Q6aOJQZ04q9APmUHCcuJYwWhav8mXLBu1K?=
 =?us-ascii?Q?9HqVa8z52hCehbpH7YMOJ7w6UBq2DnNwsbk1V7V9reeAHNTN/gdKhAbrLYY/?=
 =?us-ascii?Q?Rvg1S26sUTuryk+6LJOywVvmhgEB7TLeUcIkTmJHgL3dDBdQFxjxtIWd+yCF?=
 =?us-ascii?Q?X3HVwUCuO6189JjZmIc10+mbJuF3B0cy7lUHBfgGhrF3fnlOI/rNY8uwACKe?=
 =?us-ascii?Q?hw79Q9JeTc0pEU7ye70WDkTq5uVCQx3+qATkHRKLDAAuIdAAH3ZAgL4/BG+6?=
 =?us-ascii?Q?bdhD9ORawH44//CrMFwWA6l5rqgEWcTHXJL3B3oQ5vhQ4W+ugCStTcOe26Ff?=
 =?us-ascii?Q?GzjIewgF94i3pTXb6RJSTmNciq/0p2hPEi7M65/6W3hKYvvXKtNKKGZrEMEM?=
 =?us-ascii?Q?cxWCoVgj5JhRxz3kd6SnxG2fBIp4/8lju0zBruLCWc3EyRRBBAb9xybkp+GY?=
 =?us-ascii?Q?XOqv4r8AsAV4V8msF/FEmfgfNwEifeUC3UGZBp039f2tZARvCSeGhI5q+8ZZ?=
 =?us-ascii?Q?le/9MGwh+7Rx9pxgGx7Xo/q3U5vDE4Iy4xUnD2aNi07Wmoc4UKjy9XXfWpkY?=
 =?us-ascii?Q?M+x/HCf9RFQQMqNA9oN/fxulcFLrT+T1LudrFrgBVI3NCdVle2f3qwuYd27B?=
 =?us-ascii?Q?hvVOE4iaDvQ5mibpzO2tx0UGAT3a0FaE3LOMTxh4yGYdVADfDV+NlL6UsP7u?=
 =?us-ascii?Q?isuGzof9+Tvi5lIQNROrC6QNIWfWYlDWtT933WG9G3d2MpBl/Ba7v6huyueI?=
 =?us-ascii?Q?zFOHMZdQbqssNESkyxms213kRbcO+6lfoNmRhjz7gNQ6GCYIr2e0ieaH2ae/?=
 =?us-ascii?Q?uItVnejLL47TmgXWoxC2r8YCg/WAddlJ77xLg8x86sr41YI94ahrVhrEhEJD?=
 =?us-ascii?Q?2/ZdKm8Gv1sEqASQBqK7Q9bfAS6jc+L05busQe0laJaU0+S0GXWOelmdFqPb?=
 =?us-ascii?Q?TxbHkTYFVzV+qlTmqDOEb76jKbm6LzxSNqEOH1NF5aeUvEcx+wFmLdfUQd/Y?=
 =?us-ascii?Q?z1DmbpyoCk=3D?=
X-Microsoft-Antispam-Message-Info: PySwJbSJmhFM76BwcydHq4nBurylVjcYTRlclzwvtlJ/BjrB0u6BlUj4nWXWJyrbYWEJb72pMqFJjfDouV65g0/EatY4qEZMjzL8wIbxDBN5GDWbAqDrlKTXeCFEUlRTGOfht8x+iEy3wnbQ2OTRxHeW/C7GU9tnTeNacf2O2PRO6F/wolK0DfHYQSvzbpP2VKuHCwKnZW6aU6KaOdMnnOlFhldI3tfNbh0hU+FG1YCL4V0qHRgU18QV7EqquiR/fnrtHXdXzjH5tPE6tkVGBWbBbeGi8xcmuV/nrtDJQpMLT2lI1IadVZm4PL9gY1O8
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3517;6:J01Sl0pAEtlvvwEj2aoE5bRe6QQT/m9pZa8LEf5V+ALy5XR9y8eiIQ9YsVvtQVSH9hW5DdiEKCwGzLcPJ8UzO+CrdznW7IR3Rtj5iHfFRiBBsJW0UyJ0SKrT1ebjdajR/qV9U2VnF3SBWLqd0NB05ecEuhZ562wpHQgIpKb8+bsbkGMrP08tni48302Fgah4QA/c68WC9edCUZ4m3DsR2ntHjJsyvju3K7LayCLfl+CDvz0V/G8swFXqlQgkKOyztS898KxUZqIGmYgYJeSoWZVa8XFUy/x0zThtGT0DbXBwrC3PfRifTMOdabkwSUppYAdieu3bZXv6AM5a9KS+SopKnIWhySLcrnzoBBqzXiJzhNbp7ig7djQIV/BgGaxYBkjCq4i/ZJQSrtr7xwxU5KcISG7p2s5XwbBbpD9x2jRNj1oLJN0oqWLHKbGAMrgx6Om0NWL4udzWtyqgWwgY+w==;5:QqlpK7mIyH+hDsdxBu/6W9GMmq092xa0hUpQ6smKvckRxgRMKvRDRLqgO21yLBiPphWeRKri6/h9rhwh08JGPVLDFJBbbxwoW20tGIMDTIqv5dbnyQOjvOhHD9WrcLHUsj41v2C/FoysalXpWmBeySTR1t0pw5N53InBuTxIH+Q=;7:MLNgZUh/bqOaZ8JqvQ/PRyLHyNvLijtffIhryte/W+73yPZytV/SQyCnSfh9uieqbOlw1GX+gqqAAcW3cSPh37RzJnCmIveOtM7QhN5Cx9IQl63PN3AtYrRYEZxut1eZi7Ix2AfGH3cTHXZE4SVBkg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 12:25:03.1050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7853e3ce-0fbc-41f8-31ff-08d6641aabb4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3517
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
 drivers/staging/iio/adc/ad7606.c | 111 +++++++++++++++++++++++++++++----------
 drivers/staging/iio/adc/ad7606.h |   6 +--
 2 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 97b4a83..5f0712c 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -22,6 +22,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include "ad7606.h"
@@ -86,36 +87,24 @@ static int ad7606_read_samples(struct ad7606_state *st)
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
@@ -366,8 +355,11 @@ static int ad7606_request_gpios(struct ad7606_state *st)
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
@@ -375,7 +367,8 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev)) {
-		schedule_work(&st->poll_work);
+		gpiod_set_value(st->gpio_convst, 0);
+		iio_trigger_poll_chained(st->trig);
 	} else {
 		complete(&st->completion);
 	}
@@ -383,26 +376,69 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
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
+
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
@@ -434,7 +470,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	/* tied to logic low, analog input range is +/- 5V */
 	st->range = 0;
 	st->oversampling = 1;
-	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
 	st->reg = devm_regulator_get(dev, "avcc");
 	if (IS_ERR(st->reg))
@@ -479,14 +514,32 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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
index 3e12fff..9a832d2 100644
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

