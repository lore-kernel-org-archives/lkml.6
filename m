Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D6C208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="STc0THbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D6C208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbeGLPrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:47:20 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:48875
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbeGLPrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Pkr5HapcAgR/39eRsgflD5OnXR2OfD9+q8YWWfsl0=;
 b=STc0THbVsm3Eb6BaYH5v52oVH1U8N0PoUWfMxUTxTUIZ1moZJjnMkNJ/ADucvysi9jCUQD9esuJY4MSVG5nZutkwQSRwl8PkW+RGloj8TGADmqX/bP32AW3Jee0lge9n0NK/OJ7Z+OouQTUZYLCPZCiJPIUzT5QMqzV8Q+wAtMw=
Received: from CY1PR03CA0021.namprd03.prod.outlook.com (2603:10b6:600::31) by
 DM5PR03MB3129.namprd03.prod.outlook.com (2603:10b6:4:3c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 15:37:13 +0000
Received: from BN1AFFO11FD014.protection.gbl (2a01:111:f400:7c10::171) by
 CY1PR03CA0021.outlook.office365.com (2603:10b6:600::31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.952.17 via Frontend Transport; Thu, 12 Jul 2018 15:37:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD014.mail.protection.outlook.com (10.58.52.74) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Thu, 12 Jul 2018 15:37:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6CFbCuJ004112
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 12 Jul 2018 08:37:12 -0700
Received: from linux.ad.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 12 Jul 2018
 11:37:11 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 5/5] iio:adxl372: Add filter bandwidth support
Date:   Thu, 12 Jul 2018 18:36:58 +0300
Message-ID: <1531409818-20300-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(438002)(189003)(199004)(186003)(47776003)(106002)(8676002)(16586007)(246002)(54906003)(316002)(50226002)(50466002)(336012)(77096007)(48376002)(51416003)(26005)(476003)(8936002)(107886003)(5660300001)(356003)(7696005)(426003)(486006)(106466001)(72206003)(6666003)(2351001)(7636002)(6916009)(2906002)(44832011)(126002)(2616005)(36756003)(4326008)(305945005)(478600001)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3129;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD014;1:uaqKnINyC4KV8eitZhkOtsCLU0MPYOmJDA3OHOQvhW1yrNf6Ld8pjlBPB/Tq/W7H2zlAz8xsWZdOTkOGuLPu7Jx7QHXw/L4Mt35Lp5XXDGdIk9Rjuuu4ZwARdN2vuQbU
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c275228-d9cb-40ba-1ed1-08d5e80d5686
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM5PR03MB3129;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3129;3:Ne/EtIIV9BC/YgcGJeIMP7Ll8sge+HDRDit/dLFVOBuLKoKs3M7AVnadbblFBxuB8SPrtBMwFoQOOF/emBaTRkuJDUhTnLX7k0RS+RXxOd0tEQQ/HoMMMEJ0bjmIxFIKMR8RTD+yfi6DXLyAtJ6xaSJOIAhurKnC6p0JFaDxclkEH8m3qAWa0yqF1QD6YoNvnoTuGLAI8CW+ON/aMOn0iXFpe1CfFi0K+Zyx3d3363wXlQJCf3+Jt6RVMLGFiQ3tKIYp6BrjpT0KdEoQOKKYEjby6ci2qilvqQHD27ZIXuTJmGVi/Zz1ID84OmEV2KABqIgmvfzcV4F9mYQZD35UGatTwYsYK+AtJv71GYITl2A=;25:tJsHaKefdzhfSdxr4zKIeF+5Ehuph6bIa1qOoAJ62inXHzYreSFX4WIIeKp4ZNkXaxKjnD0Vm/3oxOwJqB39XiaPMBctHei9sAtzXmHgy8SM5PKzruNXQqDMzSIe5bAguUSalGt2IN6KgfpT8h5M6ojWpao16ggG63bLr+dvIHdlYphTmGFPuLXXK8VSQ6+KImbgdnukQK4Ei5jwEMCFFo1Lca48gyDD8k2hJrPlGKbByNaM4jF19pVOH/lGnA2h/uHtXTLzl4P3fbPYTGAsU/m8YgQIoQ4YswrTmRHZAkH2iTrZMnWF7PKAMTfQHDRhTVDObX2gd3LGWBCRB+OEqg==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3129:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3129;31:jZ7MEp7rX1agsq54eHTojcEBuzXSc8DCgrqRrKtfx98arFin6K33Wqfuc7pjBmQb5zHJF+eg+xJchmvKMO/1Cd8tAyVrSYC3l9s+tiuOZCZsPcZzOLvBDOLDc899BkL+GjovHrkzUAVd9MXoPCh7qRQEyP6+zVL0kNywbew3Wdxg4PMQCPYnZfUdwtzDiD1LzU47Mqr7ocaD7gfC7ZBnSOKzKghlD0M6SaY1bhlGuNg=;20:3dAmzJ1ZsV0HPph7CPsWYAV/avkkeX7Xaq/OAvVjm50YtY006iecjb3wIiuTeoxjN6R+h1YNwU4oXVneh1TYbow+YBkpsNEOVCQ2q/Y/Omb2Y0cm/UNP1FoUR+T8vi7LUhCiVEZiGrbIIXyhuXGH2CTqCWtUAQSVTjAvVB5hNe7I5aUAxK/s/CzVr3I2MnsGvA/2QDq2ZhoDmqY5emTs1/QmUb9KByNYEO2Knh8j2XtT9aZcY38z0T0zkrdsbon6jYZmxlB2iub3MS6rLhqGQKmlozptsCYl7Puy1WFszZ7eghbpyC0WB4xNGUpj847MZud5QkICU9dEk7aZ5/Ou6Q2OPZEK6VyZ+McUxxS8Dmt9pGCsen3xMgSy5gNh79aghLe0oTmyXEmFZtK8D7acJbqhpQuj1P496rxfVsiFi5QDZ7jEGYOPeXyIztrim0dlT5zqhLMAZv39Jw7lUPPSQeIV0B26Z6Tld7CZnSOF7zgt0c4Q4cBxfyp5Ad7m9NTg
X-Microsoft-Antispam-PRVS: <DM5PR03MB3129FC091157C4309E8783239D590@DM5PR03MB3129.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3129;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3129;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3129;4:sjHwz8451OnsN093nBwvVRwm+yB4Dztli5UKyypRU/MbwM4ZQOSi47rdg1n4VCFdSncH8VRnF27LrvxVMOBrg4L7vBde8+l2leVMzCbLMyBfaVJyolj/SeP4rm2hhGZKBMZ3B/gcCPG70JvTVOMIr0XeDZfNSiQt5wTElNX16WDaeUfOcrpePP8NV7dFQ8eawgnc1976e9vu7jxsEqsv+oFiBRFiOnXtj5itOMBHkLNWcNth28aKuxt9ZlcimjeHuGSQPK+NixuSw3gt+lKNH8AnlY4LJNyo1e8mbdc7+a+8FKSU0Sd410t9i1j3uFwN
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3129;23:pv0GqCpxKaakG0+f25PzT4jV8vEZUlS/SMUHHxH9D?=
 =?us-ascii?Q?mZTWhDrywW1BW6hG9DnyjxZGIHtJiL8HuzV2SX4v45iVFFQAogluI5mCr4ME?=
 =?us-ascii?Q?vT1OFa+30IjYXGH8q4y5n+j1buHmrNZ9WL6ONkM1MNEL3xCIV577Grfa7D6a?=
 =?us-ascii?Q?DcSlktAWpNJmi0mMGFF3irWlHkDXvRcqevWh+PkGLw1XNDnjf0pY4S5OvlnA?=
 =?us-ascii?Q?GBZG2XmA2WnhF7NY3Yp4q2x3441TNc8kZMBVFxNdeaqCS9fa2Wb7bKQT0fjZ?=
 =?us-ascii?Q?o0bStO5G8Ihgni7UJ27wVEkDyAxZJHUGYjOXJiay3TWN2HbiKaXKY0jvydYE?=
 =?us-ascii?Q?q9Uxuq3sYUDB1194abP3tMkjeMh/In+CdM+30U55jM05/3Drl1va5RqB+IK4?=
 =?us-ascii?Q?OkT51/pjVVyAOK4oeX0qd+yMuzNy0SfhDOnQ9qHkVCNKX7O0IK27gU1eQ1K1?=
 =?us-ascii?Q?F0CtRV0QoD2oAYlwgoaYwqaa82F8orksGAR1/6iWhGv2z4KZJkApWjWsNRLN?=
 =?us-ascii?Q?YoRnuv3Hfiva1akeqMHYYFhLZtvB+xtoIBSMPB8/z0LI1P4w408OPashdVOl?=
 =?us-ascii?Q?caIuMQ7D4s+l2wdcKLCwihhAi9/sjRQN8Cr2ZU6Khub7d6GlWYpvpoNeMKMf?=
 =?us-ascii?Q?hVoGLCrcX0evjGcpiazKF6jox6tiMNIlt7zHSJ9+McGMcRiNqiyIhwchb2zb?=
 =?us-ascii?Q?xVbsoZ/WipGBdNYnDtI8u6dfYL4nPVmyZQ67uX5m1XxhZJxA9mn6iHKoz2Gy?=
 =?us-ascii?Q?dqoY7DBtseP5Z8axsS8AUBOWbu8N8X7jTrStDNw65q0CvVxFszBRS1/ekosR?=
 =?us-ascii?Q?2PS/RLm6LFFhSHJuyNl5+1rS/GNQOtSQTm8il/O6d17TgunsQBU44MR1h7hM?=
 =?us-ascii?Q?MJSJH0VbfVTPFv8rR1L4gxnOkHLM6L2S9XGN+LZVua8LGz3aAAuTxtuT7dez?=
 =?us-ascii?Q?/yq1T8WpBERmNSaknut4SVYQ7n/5Pi/qyGF6eJ2v2T511qrUgcGWIRLJcpYp?=
 =?us-ascii?Q?yI2G+/t43jGqp5nMcCvVSxUX6l7h4me8zXJRcLxw+qwEQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: PtlJRTwrw3VwJgNHK5rRqjixUqglu6xFpNPTjBCtNZvX2+hcCAfg9P3/L10wr78VH4vXKEey/NzyRES+R3FHdnh4ebVxN4tcl7GMgr/yUd8IpRL3fFgjblliFHbdheXB7klPf/afrQ2/PYfFa4C53fR4BcIS4FEwA9XOuhoY97hlhZ3WPGfdfsQVTHTOsi3GvG8uojDNZlJg4Ygf+8np9aQa9WQ6wAxYALf1H3ZsJisr7TvyuKcZGGrKnYmP5ySuecSOdxk+bqQZrSFSpngcJjaFyTFxifRCgRuMcZZNuV9q9ODCmI8udCoeVdkGxiQHFi+Gpcx22ii4F4HlgdkZlgYBeaOtY6zt+w8HHSQ5Qeg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3129;6:PoyjvoZLRS6SHL3QnCTF56rnHpVCFc5Y/700MkoM+HexFkLDfCAPSyhlC6xpMuctEKh/HiUCKqyh6L+i9R/WbinDVA63A+CM/vMz7EsCfACXQb4c3rp83PT4Ojo4kk+3AmPeXlLlcArpRRmbz1aFg6Tl7ivTPCakenndP2VwizfJ19T4td3mIohE38AJOQuyo04Ltl2VsB4hsVcucs/s78Zt+X53HfiKvb4GAqYKB4TlGCP8Y6PUMUn3Hpb69BaZN0rYuDXqEmEJRIIOscPu5T/7gIxbI3xBG/lm9hsqkYCzH4gCHFAE77A6nqOmWLUlAu48dO7SHVaJ+mLy/VtoULWXA0zPWQ9VR+De3ZCBo1kSAEkE1Dzo7LExQ4ueGJnAQ6p541lYEheNSR2iXk2S9AFbKH6vmbXYtqfbIWELKYDXuK5fQjzSXJAudAdLUXvYlKUZRF9FJ+AO3R1c385gLA==;5:XrdTJOtWo9HMqJTywhm/jx6PEwhXJRyuxeqzD5J9hdvEyf5wE2+kTSMvislouXZqUMpeucldo5/tTfub0Efn07Y3KZt6bK2Rjqyxf0AmuudthoKCzO86Do886Tp/LBXRRepYf2HnVVz5bYhVgfEAHmC2ihcLCcRsIXSsPtjzzvU=;24:5nGZDTTUs4Xr4m5GV/Byw7e+GzvNcKYyPnVw6aJOQjdZwCc3wx2ke5CM5zdJVLYhq1TQJWGeJ7rm6TyAxKJvb1I0SATBNWstZeBg5MkUb/Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3129;7:5MF3itqVOtVi6RVOs0Jx/6/qUTZPCDKM3Y+QgwtTVWV1Vg+LV3W+NuOG++PrNw7dzX2NbLOdpTPULwz+ZLPoQTeIU2sJ55IyqvDyRZxIIEQgNE+7M71iaz5Kdrizu+bgSYrce2uGOKflmUhNOqJhnzjZpSp6uZNWrVNbkr3/oL7GiQdqQHSKmBWXSg0gNHp/3yiu3wN+A+wbqWOcAFIPe2s3sz1k+86JPVO5LsXlbsJKD+IX5M3rO3RBYKzv715i
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 15:37:12.5548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c275228-d9cb-40ba-1ed1-08d5e80d5686
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the filter bandwidth. The
user can also read the available bandwidths which are always adjusted to be
at most half of the sampling frequency. Furthermore, the currently selected
bandwidth can be read via the read_raw function, while the write_raw sets a
new bandwidth value.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 498c740..a73482e 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -199,6 +199,10 @@ static const int adxl372_samp_freq_tbl[5] = {
 	400, 800, 1600, 3200, 6400,
 };
 
+static const int adxl372_bw_freq_tbl[5] = {
+	200, 400, 800, 1600, 3200,
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -206,7 +210,8 @@ static const int adxl372_samp_freq_tbl[5] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -585,6 +590,9 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = adxl372_samp_freq_tbl[st->odr];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = adxl372_bw_freq_tbl[st->bw];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -595,7 +603,7 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long info)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int odr_index, ret;
+	int odr_index, bw_index, ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -613,11 +621,34 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			ret = adxl372_set_bandwidth(st, odr_index);
 
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		bw_index = adxl372_find_closest_match(adxl372_bw_freq_tbl,
+					ARRAY_SIZE(adxl372_bw_freq_tbl),
+					val);
+		return adxl372_set_bandwidth(st, bw_index);
 	default:
 		return -EINVAL;
 	}
 }
 
+static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int i;
+	size_t len = 0;
+
+	for (i = 0; i <= st->odr; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%d ", adxl372_bw_freq_tbl[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
 static ssize_t adxl372_get_fifo_enabled(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -768,9 +799,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 };
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
+		       0444, adxl372_show_filter_freq_avail, NULL, 0);
 
 static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4

