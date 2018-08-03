Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0784021748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="AJzwGul9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0784021748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeHCO7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:59:06 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:34368
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729603AbeHCO7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ5Rk1roAKLIJQxYFHPBapyTUzho9Ntj1T10J0NTMYY=;
 b=AJzwGul91NdyKCFjSbvf7zy/TQAdMeSQbGTTfBzJdLQYbHijIXOTvuklSQ63TLvFvyAyFnkxLfxJtf3cXM3UzWWW4puNjlk2Bn6GQjDcyZIsUfAWJD0FCtKPs5OWgd+yefEkKJ0tkzASzrNfJlqx82DRi5WMOV11PcMwUbBiIiM=
Received: from BN6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:404:23::26)
 by DM5PR03MB3132.namprd03.prod.outlook.com (2603:10b6:4:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 13:02:48 +0000
Received: from BN1BFFO11FD009.protection.gbl (2a01:111:f400:7c10::1:119) by
 BN6PR03CA0016.outlook.office365.com (2603:10b6:404:23::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Fri, 3 Aug 2018 13:02:48 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD009.mail.protection.outlook.com (10.58.144.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Fri, 3 Aug 2018 13:02:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w73D2lKp011710
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 3 Aug 2018 06:02:47 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 3 Aug 2018
 09:02:46 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] iio: accel: Add adxl372 driver
Date:   Fri, 3 Aug 2018 16:02:15 +0300
Message-ID: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(51416003)(7696005)(110136005)(72206003)(8936002)(966005)(50226002)(48376002)(50466002)(36756003)(508600001)(5660300001)(6306002)(106002)(4326008)(316002)(2906002)(16586007)(7416002)(54906003)(44832011)(106466001)(305945005)(8676002)(6666003)(336012)(53416004)(186003)(246002)(2616005)(77096007)(486006)(356003)(26005)(126002)(476003)(47776003)(14444005)(7636002)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3132;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD009;1:N1CZP3CkL+mOkz6yoxJi4L4gS6uFNalGd7CYy8CR3wunzkTOyAF55d7mKrW/lTWLNe/jBuTKN7KCTrELvozahtJ6Lx9duCUVYHZVthbQ9hqUCdyMRkKpKvENVcu+22rF
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f303956-f95c-44c1-7660-08d5f9416992
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;3:YlxlwuJaPX5bK5mJk23cq6vnv/9hwIafsz39qVjb3xGLhp7tZGoGcBLKMimgT4JFAp5PxBpg+rvTN0ptTrLwyZAcQr74ruCv6amzrTHIa/LUtW58vzebEPcLSUOXaJWT8mq/bQZx0hqKKhY4esGIVLcyyFzBAtbS+pdefFbdTdJGlyCKOjVZBEofyRME+Tz+VEwfzW3/CvfpXPk/tPhYNtyNHFamFVAFbKF7Cf6uDwVE5lzKGRwAHnsIHRliR6hErox2fYbRoun1VyDLvOIe/su4/jOCaHhkzSALbjDH5ew8GL7O0BnKGLZGh8uFoVwfL2YQ2LvAkzadCOS+ItpmviRSIkH4Qyi6O0WqkQbhYDE=;25:8kWpmISjghOrg2EP1oLDGgRLXRuxlSMxXEbAcDShiXWpXmQNLj5UyRMu/rf4xLute01FK3OCKKW8C95Wi/ngDz+54IVLI4oyiAg1pjKAtjgPNAmCKvwziBJyaXL3EziMcg48c8CYY6Tq3eA0IBHNhW4uxqDW5UEu1UuULIfsbgORy6oYvD+2MKpgYdazMLIS9xGuKPw/PwIeJZBttzZyg3Vc78ktzPiJs1VtS0hk/0rNWhK4fbYW+B0G9WTngG/jjiZnYd+yBkcWICYFmgDInsJG8+kbM/FvkxLTBcWo8sH5Fj1UQuJl7bPNpbDkvk0tzMAzhllLbgdDV3GoN7TOnw==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3132:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;31:gzIvmLD8EoBTibv6ecIzspc8+lLUQQbiE9OijQpDOP/LIi3K+pLF/P4H4vCwS7AYfPTTfCViCj6SRNoscE7DeuqwHWXiX31vltbzlT7UsDQvxtMFQsO1A3DcqDuqnRzXkljW3xhcE4L7h3vA5ftJSuVXh9qdb59iCytCCcLom/WFnzli9c52hbc9gFPrJj0iWPsGh3U06xWiGpBPSTQcoCnxxfVWwE5TImwib6bzaRc=;20:trzIfOo2i1Qhl+uiNE+NCqoBbc7heX7Xuv5Xi6Y8Br94LVebnmRuAXme/dIlLoPrA3GLfRm+1MtAEOc0eKcwDjsKow0UD+Qvy1piI5V0NYYu/AMEME3wYLq8/Vj6qxjxMWr+q47YhUQd7zhY7BHdSe6wEm1HiDm5MAWhk0SUo6Q76LmzdTPK8kF5Rbv/6CFijcOZGBkMonlxz/J3Al0Cbauc9wLAdgge0mdjZtpyUhH2pVxKPom8hCFTi+AQrZEm1Wjai2y/TvjGcc61uh3Lqfcvl/dWctEmbEO1MQeyDcdfEUVGzgKcV0V4MVEFeXCvPB4a6rm6Pp8FTzjTB2y7Y0uOPmi5C1fBGIPjfhvNinfLkklUQm4m4tAtpoGMuBkkRsYmzfY2QZTISh6I4JurrTi2pZpxQL4a2yPFGcnQ7FxUFsrlcsvVqlrMKHiPyqY0+t5Daf9QTt7UY2uOK9kJ00eTMTEg29nmoiFW8jC4h3lBhyGUuJz2H7coJLQm3Cmd
X-Microsoft-Antispam-PRVS: <DM5PR03MB31320CBA6E7BFA48F78BC84E9D230@DM5PR03MB3132.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3132;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;4:n950jkCwg8S9WLyVcZPRvUF3LZWkCpYF0IowtEYX5CGEtTSLSYZjbQ99wy0jNNiQEQp+HdsvGhDs+cV44BvWzzPOaoskYHNe9mfVI5O4892xVi0chASfHCf3AK9/Oj8hMmZSbGQdaQUvEurJwe9u8B8GdbV+2XxtS7MPXJRXO/V9ElRgbLOyiaN6Vh1mdRcVANu8vo1Xn90VmQ9a6jOCa51w7RvainWN1kKntGh+YX5mvq1w0KYwhf609xO0PLQk00/tQkruwL627J//h6sWXnpy/PHfLbF5j07Gw9REMp8YHfS132wRzQGOOQpZWZuI
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3132;23:9gAitK2ONp5VLnRfUTmiX7EYtBZqr7XuN00v5oE7y?=
 =?us-ascii?Q?gzzaIsAjU0Yq2XvsujVQ5DEdJCtAXL9fiQcKDvzgua2L43BtV5E0JYtg8qMH?=
 =?us-ascii?Q?MnqCus+3eyaTz7mn4VXpvi0Y0WXvyJOOo85v1mQiUFsAUNjt1v8QRswzMF0R?=
 =?us-ascii?Q?Y69In8BCJ3pSql/yD5yyGLcacM0IuJqPMZ0EVlIFaoIJklPOwFMVNMVSInpP?=
 =?us-ascii?Q?eey1Pwd4Z2/SD7WTGLwGJ0dXtFrAoOSrJlsEcbtD7f6QUowY0GgTbV80MURA?=
 =?us-ascii?Q?ueZotNlTV/3wXlL0CurJzVMFbH6usueFS8zFCUNp9DaZxoepuutbxPAHWRNh?=
 =?us-ascii?Q?d/U4JerCth+5svLKi9+eytgS4GvlTC3QivMlzTR2JGCjw0LqRXYGQvhFUE86?=
 =?us-ascii?Q?vlmb0+FKMzw5RjEmHO+mFIOoq0OUUk4ZpFFIDL3TYTlSOrPN9HYGJCU6EJDg?=
 =?us-ascii?Q?mPI0+Js/QvY9B6ghy4ufRda2HqLBc2BeYhEeknS6qyG3QlYRiSf5fEUUBlM3?=
 =?us-ascii?Q?zbsE2avonQ8Zcz7xN6XZJHU3j3bhlTq1xKPCNmFEFpexJBQ9bl3CKP9RyA7I?=
 =?us-ascii?Q?bFJNwQlmWayTSYQRE2S1FwYZbGT3/b5NeWgsJxywExw3IvivvHtNx1xShV5y?=
 =?us-ascii?Q?ALMpMpANwx+khkDTPi+AMysYLbax7P5BEeORsUPrrV+HRsTjszSO5Go2+nf3?=
 =?us-ascii?Q?akYI360O/55tvak1dhUyi7Cu0P3iyiTS2/Ot49qW8OnygxzKftU3G2/TtKvo?=
 =?us-ascii?Q?4UALCuFZXz86wJ1wLfH/6byqsa3RA7gxuz8uFEtzFkOHgcTXtoNyEY5AYa6H?=
 =?us-ascii?Q?yRnk/3z8zH/Y0LiZJskcImYRWruClbPYTXtyDhHqJTDcfnZNBeBD56D63YEf?=
 =?us-ascii?Q?PQtNBc9SFbwT9zl+ZDLG1DyhKwrizPyLX+I/OwtFUEaa5x6yIgDw2MAVNmW/?=
 =?us-ascii?Q?r4AEWux7658DFVIHRiHw2v69Dc6rfGNL7+Go4BHE0HLnbdGA/BFtYl5y/sQ/?=
 =?us-ascii?Q?0oM2kyQXdgo/7imX5H295WT+gYNmZCPniEz9yy4eae14CvxN6ngkYeRPonsa?=
 =?us-ascii?Q?2uF/hk9/Z2nMihnL8/3EukCNjiszYhSohxnljpyF1Wn/qMpQw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9pFbU0TGtADu6m9hNPLfVoEY3RfSsioE15nwjmKfSoS2g2QY2W+zmyyOFk2uhg2ajENEdQEjv7iaw76LfcSxxGmBYY7Qs1tnC/m9JSJeSdrAhmdVhyoc5EEOsvicd/y0+9wuENkuZOll18/O9ODM2qTKxlpesAb9q0XGf6pnGQNeoWKCQbpwt2wPHf8INV9lp3aaZER4Br9jU5j7WWMkxzH9SD9fERM+ErsFwwgRXJHmSSDeAKIVJmVd7QfgeIVzrkqaw7LgVU6pKitCZzVIWd0gQl2DqDfzINLH+o6LOXGTXNvn0OYVZX/+9WP75phjhWy3cuqkb7F5MhJO0MZJItyQBaciOWq/AkrBsoMmxCM=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;6:F8vwdWXnSozfiYgARPr9gj6o4LJxCgQKmPGqilkNqHLnXqlDS8StYUGfC58BGaIjh2p2GFM+GYZcDZxKQWlciNk90lQ2tyXDTyLtDSx5W3MhnWRfQzqDtMYpxiM6Zy/49sAF701d2do5aQQgwARdUI4OMSRrdybyaY/mBQ9j4Ny+4duIZ6mGnPCUkhCeSA7jcYUBGsa/kPI90jUGROnsWx1eP5vyq4giM43MeH7GgXjs3YpM8ubdG0IxHWrJvZORmnS+mgDJQIEp8yqxH8WdhuBAtXXpWADowvyqCttEuvxCToEftoUSjXsoW6wCXHHSPKAc7GF/Q57lQsVh8v8BMzhXSjjvhvWmNpF10zSAEitGofParLGu5zWZUsEz70dr4TS+kbMBg8MQuYJpt+WTMTU+EjS/y3duj9TKNj1c+IibKGwg/dYNzL2N1H7IPaoHnh0ZFIlyeZa4clU2h6IiwQ==;5:pxUZZGkayqj0jR5iEoTCGA4P6dI/i3PTPQ4kM4dkYg158OK2xbxupEK8ynx5y/YI2QKKu+S1y73QSPvOoMnK9NGif6FcW4ZRbNbX//79byDJZvEi2mnMExxEVAt0mFjS4fygLYG4W5fjOiBxHKYAtQdo3jhZ8nl3KqFMKh3nS4s=;7:FGt7BYSXK+Ei35dOJXIfdZ523SplCjSJoORZdPFCty9L2stUXXKcJ7pKtfFjlPXMa4WikLVmaPaDsMJs56EAdAQgPwz0m5j3IOxdmy9l49e3PHDzudS+tA9d7zc5wXF5KeaD2nJORxkDpDb5x1kYa1xMqQ+IKq2jVhJvgG5K8OYkLpRFUQkfcbzUfuZfjzRP05FSJxeBMatmQh801NZcHeDPM9NTe3rV2ZjUSb1vXXrBreyBp19nFZmMMvXniTb4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 13:02:48.0471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f303956-f95c-44c1-7660-08d5f9416992
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
Patch 1, 2:
	- nothing changed
Patch 3:
	- changed the name from regmap_pipe_read() to regmap_noinc_read()
	- added a check for readable registers
Patch 4:
	- dropped the fifo peak mode
	- corrected the patch based on feedback from Peter Meerwald-Stadler.
Patch 5 and 6:
	- nothing changed

Changes in v2:
Patch 1:
	- removed ADXL372_RD_FLAG_MSK and ADXL372_WR_FLAG_MSK macros.
	- handled regmap read/write by setting reg_bits and pad_bits
	  fields in regmap_config struct.
	- removed the buffer specifications when defining the channels.
	- changed the activity and inactivity thresholds.
	- added two new functions for setting the activity and inactivity
	  timers: adxl372_set_inactivity_time_ms() and
	  adxl372_set_activity_time_ms().
Patch 2:
	- introduced all the DT bindings in a single patch.
Patch 3:
	- backported the patch based on this discussion: 
          https://lkml.org/lkml/2016/6/16/548.
	- this patch is required as the regmap_pipe_read() API will be used 
	  to read the data from the FIFO.
Patch 4:
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
Patch 5 and 6:
	- nothing changed

Crestez Dan Leonard (1):
  regmap: Add regmap_noinc_read API

Stefan Popa (5):
  iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
  dt-bindings: iio: accel: Add docs for ADXL372
  iio:adxl372: Add FIFO and interrupts support
  iio:adxl372: Add sampling frequency support
  iio:adxl372: Add filter bandwidth support

 .../devicetree/bindings/iio/accel/adxl372.txt      |  24 +
 MAINTAINERS                                        |   7 +
 drivers/base/regmap/regmap.c                       |  65 +-
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adxl372.c                        | 980 +++++++++++++++++++++
 include/linux/regmap.h                             |   9 +
 7 files changed, 1096 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 drivers/iio/accel/adxl372.c

-- 
2.7.4

