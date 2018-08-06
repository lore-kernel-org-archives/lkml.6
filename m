Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01479C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9017921A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ckPueOgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9017921A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeHFOQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:16:13 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:34640
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731180AbeHFOQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acLl2sOaOtX0L08E0whiCQuQwyBCI3vOfdhpKgYVz+A=;
 b=ckPueOgZzfFmKkDmoJe0Wgh6PHcri4zWXV/rH1MAQHUtMoIWFYgWc6ZIRTcRN5Gwr/3y3njWq+cqvFKX8kOTGC7M3HR8oBpWb8ySIiwDbO0v+moVAzOBnVuKjJJ4Pfr7NcBDKyaiJhONgdrc0oCh9l2M6NFkdCj/cN4yTcErmZs=
Received: from BN6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:404:23::30)
 by CY4PR03MB3128.namprd03.prod.outlook.com (2603:10b6:910:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 12:07:21 +0000
Received: from BY2FFO11FD006.protection.gbl (2a01:111:f400:7c0c::185) by
 BN6PR03CA0020.outlook.office365.com (2603:10b6:404:23::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Mon, 6 Aug 2018 12:07:21 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD006.mail.protection.outlook.com (10.1.14.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:07:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C7JFX013075
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:07:19 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:07:18 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/6] iio:adxl372: Add sampling frequency support
Date:   Mon, 6 Aug 2018 15:04:46 +0300
Message-ID: <1533557087-10401-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(316002)(16586007)(50226002)(8676002)(7416002)(8936002)(11346002)(356003)(446003)(47776003)(7636002)(246002)(305945005)(2906002)(72206003)(14444005)(110136005)(2616005)(44832011)(486006)(476003)(126002)(478600001)(36756003)(4326008)(54906003)(48376002)(50466002)(106002)(51416003)(7696005)(426003)(106466001)(6666003)(186003)(77096007)(26005)(76176011)(53416004)(336012)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3128;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD006;1:DHQAW9vmOWmZIXkwqRgmaxNKcQb12fvdcxLPptzIkAgVT3IcIlJx49NlogzfLoCw6k0xpilt4FNCHEYvIFE75R663+swkabKFPLRYdvq+JgcsjHhh3mh0GG0DDeTyt7A
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 785c5b77-9f01-40c1-9cd2-08d5fb952985
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR03MB3128;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;3:qj70l0QQkvjo1ulqbTVYoL5/oY2w50ogXFMTh4CiOBLvIx/qL3V4RlHQBCEstH3HkrJvJ26hBSWb2Y+ylpFVcbDOwz3EKole3dcISXv2+UNE64Zu8zXEf91qTslXXSGpn+px+zsvVOZC6z1BjQ/P7vRWTiErHWc9RAE/ekMynT67pLSHtRACST8q8gD3M5Li2bfMzHonyspBkGfpvZ7Rp9fg7pAzDPIyodlc65R65cWZzar8EC3VVsGGCBo4PEMgGFZ6M7QY7dwXmwn+s/XwOR3n3ALG5LShAgdvLftai+EjJJRmCsvSIZaFzjD259wuEV7+ExXB7evr6ohFPwlGE90bDS3MQFDKYV1NnomKVMk=;25:TxrVi6VUxsjRWyBhEeR9jmo8RNufejzv7Q+vqMX6C09hLn7ySG1xRKm5/Lx8iqcMah86qSAbSAlj0ZRqVqzem0YVThoMRURe0L+ucnjf7QOdz9f+P5zKaWUZ2LSdlnqXR513DZCoNV9gGSECPjXSRZoKm+jOBUrHKNj/ljz0JhN/zneGnHszosFeb8hPyRuKGOet6WlXYumAOdM5eoHqLlrpUeO0K8lPNQyhJ2udDRzx/zQksLpIrn7iTrbuT2fCmfKjt1ZmVj70PRLW7V+ILYpRcEpJ2hdfIwLlNlrzacK0CuOrv+1cTE5Uhbxn+ziGVxhwpL+Hktw0BQVpqVt5Bg==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3128:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;31:PCYo6qOI1cZtgqWj48MB4mG46CnwCphIrfks6JYr4+uT+bRGD3XMiQqzCkoE8hdP6VvfKixjb4qu06cw7omYaROKITq9fItFDfOjpWwNNQJHxfe84HFrRBpA9RmcEK4BZODFltzuzSAB9J3lyzCuHcrDYsBDMhd1yMIeOeIGkPnlp5TkwOcFJF7uno3BGo5DYW5gKRuTKc0Cc/yJpHYXf9dZR/qXaEeXE1vV/95sDKI=;20:iNplN20r8sdU1DzLyROaTzfUfZgV71ozNmLz59FWsvHfyNO7RWtYSCpA62W/kEd1xQ6S3NxvKMFdFFW3BR8Ew69Y4APM/TbUtTaoag+uwFVJNtq8jT4tJNmY6/9NaR+8y1ZQor15mtAlzwwk8KLDmBL1WRp9x4hd1Vu1TxsNcsrHXGcvRQDPAIfRhKZlVqJCcejWF53tgudiyZdl7Yrk0paaRS3DI9lKrGQpvS67pc9lsrNUc8TRZ4NyvgBAUt0BIatJCM1c7mWNv4yrcf4jMP4NNPSTcZD3y4C/qdCqwuvrpNXAexkYSK0p6bGtWCpeBANe/CiCKQqzN6iY+ldluYEMuKP0atFeJ5jon/DxuoZkjLTYVZEGfO9Wp4Edjorcj2SvVZBjenD2700QuuVwsOXB1uLB+YCOz2DjsSzph8fxeezAzAAgYZ/Cu8nXm8dof1IxDvcRDjrY3lAvHvKZhPcVJyBrNq/anE9OYpVzRv1fWH4Xf0hDxm+bSCWdwym0
X-Microsoft-Antispam-PRVS: <CY4PR03MB3128781B6E905361A8D8A0CA9D200@CY4PR03MB3128.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3128;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3128;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;4:opgOZrICyVB4xKUp1aurfAlvBUhJOKROp2iMndxxMcw5uUT1mNRh54RYRiuoz9jcCJxrT6T0jo7gPac/w4OkQDJk6Nb3NN1uK0C34FY771ePQt0utoovby7ZfVRSOogkca6v3J+cblV+j1w/vueY7ZmPP7gqBm7bfsYa3uQnMNPeHsSrIrZn8ywbDA05AwidhLYL3C9RBO3GirZUcIg9O6j0Bj0yfbEEnmly6rp/ApGR4brorYE8yAksJQlmWFb1ZBPeMzZzNBgEsoVOtCVbrunSCNLKjiaFzmCD6f0OkkkHozLqln0TedDgc4V2qmgr
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3128;23:MpOIIEtmLPVoNz8iS3bXA8UfcWInEJ8vFSvg6jtTx?=
 =?us-ascii?Q?uL3fk/hiILTyheKHXMaQ47zLVe5E7+D/C8hgB+PJr8TfpEwY7H2FSf4ArlBB?=
 =?us-ascii?Q?WITIzOiNnXzSt8niF56+OQQmYQwONVUppRZBbhnhsKL5+4JABRYY22wmezQq?=
 =?us-ascii?Q?Zkbv8U4E4UXZuU73DrwtEeHdS1B9yzJ/ob34kUJjo2rHjYYt/h96BAE3C0rC?=
 =?us-ascii?Q?TdnUWKNknLIaYpn1z1IHcgi/2EQfCnvZGT49T9pq3L+BtutOzczWaAk+JwmU?=
 =?us-ascii?Q?YP2qjiZ7wVotqZIYcD7VqncuqjHv9KmJZ6lF+xSt54L3JoBoeWiRzb0yr+Bx?=
 =?us-ascii?Q?Q0Q6sIBl3HbonWOhR51zn9I5wEn31b3lj+IB9L4SKkcmEjTSwSJDr4uVNlmF?=
 =?us-ascii?Q?ql/hyKTFdvhQbjiyO+zxGMQKLEhEMzh3vGrsHGW1BJRvbePxvZ3Uwmm1ycmq?=
 =?us-ascii?Q?IAVJPevMwvkUcVZkVARNy6L6xEG9shq9AA7PdccXcqSXhnoVWaeUbfHkyRh7?=
 =?us-ascii?Q?JFZgMVD6Rh2pSdmdPmQOhrxM/bbwtxgu/vshgz8ME6u7UXMSp0Zul7Rd4rhZ?=
 =?us-ascii?Q?Kdt7HC6R+01Co51WhEItk1XgB04nGoX27QA4wHtLM2cLPqqYZqquDFbj41gY?=
 =?us-ascii?Q?yBe3D+M5bipXvncot1bCa00a3DogKIgTgB1Werp7v+NLPrHZ5SPQ8RVmEamC?=
 =?us-ascii?Q?mK8tnTq+frt7j2W9+8kX+ERC43uA6Xmqi7vKXy0RjHcptshynldar4zAHNVu?=
 =?us-ascii?Q?KnLKq6ajMeb7Rv2SbGh0GWp2vl+RE+Opx9BHJuMzMiYg/C5G5IXH7SJ93URQ?=
 =?us-ascii?Q?zl7pO7M9Qi+P6EmleC11HgzjvGtq+YWxzvaJ+OHTin3/gU4/bLA4TPpgRYVF?=
 =?us-ascii?Q?5loklmdwDFkcWPY97TQOEMdQsnMZoHpWUYl1ryebMUit0+a4mpC+5T0RvwjI?=
 =?us-ascii?Q?R/CrE+PHx0YKEWITKd02+cO51fbUxKReDjQfRBAznFZioD8c01yu9mopyt8a?=
 =?us-ascii?Q?1zDhduyZrRey+B1M477XWP0o5H0P1o6AxbW21h52PTIdC0eW++L9B3kC8V2D?=
 =?us-ascii?Q?rpvUbqP1JQjTk3Weg1iHkZRCoSiGDaeSPQbynHdFk56gzAaFw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1yH6+vL2SpZLibyf8H4TzhwMc6AwvR5+7lMJnSzNg3OA7qmxN6RyVAdzyPxvF+t7wobkAoVNHTS8oUTvcu8Hc1K3Ua6y0jhqIeyGOW1tbvFdRYEWkS1nn/nuLE0+1QM0Yr1iBUh5ObYH1EGfzQIaVDXkjzqmNXIPP2s0xWKUXLG10vbShYZwNBdtd7DGNcI6GRctOw7ZK2xTu1SJm7Pr2YKIOU/J2XtA/Pf2ZKAgx7kk7evoIoON+qO7UjG4WzKMBLfVdo+7y1euBTnU7Rp44IYbuKMBTnib71PwlVdACCX97ifmB5Bp65iFlnmP9blq0SHgqW8mt3vDbho9JKD3S9CmEzets4F4qMphcZgxgbY=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;6:2JrzlTPxyF7+qYzkq+w/uVdl92oxWgBTtyO5bBtxScxiG9a6c30FpFpRoNsDF1XODsy4O6Coz940S1ipGyhUzrUr+ZitK79XGHSKQTpYlTI4QKAQfWtDX8pqr/6AH0F1QpYh11Z3zWs9D034ZOrz79rrisDgKwYG9U4ilfVC9ouoxGZG24rCH6Rq3f3BRMpgdzc5sczLcB04ee1skqbYK5+yw3NyjP5pbHkRxZiUWkpfVNPEnhMITmRBvvy6/oLvhK4OAsSSRx6nATT2jaWQVD/OWfWnB90dFDTANvwGaDCwRHRsFnPUviLhh5JJ9UwE3pDqye/8uKD4TisJqD3EvVmn//G5CtvE8IoSRC7DhJL0TbMx2vSqsIuvcwa4a3ixvOx9vFw6DYdiIPoN4QscZBVBDS6CYpUU3SBh8KtrKDTiAtYml8DJbuojR4lqTTbUlzJZw1TKScQ4fa9lovgLKg==;5:W+A8WdJqDx4YNxLEYFOF1yOEgExVQuUzkeRhVEUgrTXzvoFW5OeG+1uGho/X1PI71UZLwwu4sygtJCCm0aVh8EpDlRaOgRHY/pIrcmDhjz3LCqa7G4UAVsMYsdC5stbAK1Tbv9aU+y3T8G9GpZ1ewoRCUdIo80Wh0baV5oIIgQo=;7:Qhn895ANbzm2QoAQzDay6/MQBT7s3bZSDWghZegolUkQ19gcT5pO0XXRheXIyyr5AZL/DslfKMWHNeOn3L3RRmP8ghWDSXI9cUYcBiA18LHrsVB0HCzKD/xQQNlC+Jvf0sqVufheb3p6lY2PQgk0+fqF1VJaAbXGDGkgNT1AW23umkE/uCLfUqRjr/+poJyKvj2sGL0kfxBC55z/F37EofMPj1rY7W5eJ3/xCWVw/WWNmL672pWxVRrrWzxJyZ+W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:07:20.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785c5b77-9f01-40c1-9cd2-08d5fb952985
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the sampling frequency.
Also, the user can read the available frequencies and read the currently
set frequency via the read_raw function. The frequency can be set via the
write_raw function.

When the frequency is set, the bandwidth is also checked and ensured
that it is constrained to at most half of the sampling frequency. Also, the
activity and inactivity timers have to be updated because they depend on
the selected ODR.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 623c32d..d991d1c 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -223,7 +223,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_find_closest_match(const int *array,
+				      unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val <= array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
 static int adxl372_set_bandwidth(struct adxl372_state *st,
 				 enum adxl372_bandwidth bw)
 {
@@ -631,6 +645,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = ADXL372_USCALE;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adxl372_samp_freq_tbl[st->odr];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl372_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int odr_index, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
+					ARRAY_SIZE(adxl372_samp_freq_tbl),
+					val);
+		ret = adxl372_set_odr(st, odr_index);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
+		 */
+		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
+		 */
+		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The maximum bandwidth is constrained to at most half of
+		 * the ODR to ensure that the Nyquist criteria is not violated
+		 */
+		if (st->bw > odr_index)
+			ret = adxl372_set_bandwidth(st, odr_index);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -763,8 +822,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+
+static struct attribute *adxl372_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxl372_attrs_group = {
+	.attrs = adxl372_attributes,
+};
+
 static const struct iio_info adxl372_info = {
+	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
+	.write_raw = adxl372_write_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.7.4

