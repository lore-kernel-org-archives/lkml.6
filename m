Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13E4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF7F208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Sn8gdJLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF7F208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbeGLPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:46:50 -0400
Received: from mail-eopbgr690043.outbound.protection.outlook.com ([40.107.69.43]:26881
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727366AbeGLPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qew+TNfG+p/SFF0f53gNDpSpFHtBV+QFcgfAdX/4h3o=;
 b=Sn8gdJLzdFJiDg9Z/Y+6rLg7rR8cs+7quzDKAYRvqnJQpnZMy+wDuQLNDmrH3x3j3R+iFvk86pzkpQWFU/VfGhB7L1fhe1mzZME+17vvv6TvlQvXxPCzq1zm7BCslrAmntvz84zspgtQnopkQAsr4NnsmbdtWW45yroPPjDGqe0=
Received: from BN6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:404:23::33)
 by MWHPR03MB3136.namprd03.prod.outlook.com (2603:10b6:301:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.22; Thu, 12 Jul
 2018 15:36:37 +0000
Received: from BN1BFFO11FD020.protection.gbl (2a01:111:f400:7c10::1:185) by
 BN6PR03CA0023.outlook.office365.com (2603:10b6:404:23::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.863.19 via Frontend Transport; Thu, 12 Jul 2018 15:36:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD020.mail.protection.outlook.com (10.58.144.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Thu, 12 Jul 2018 15:36:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6CFaasm003890
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 12 Jul 2018 08:36:36 -0700
Received: from linux.ad.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 12 Jul 2018
 11:36:36 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 4/5] iio:adxl372: Add sampling frequency support
Date:   Thu, 12 Jul 2018 18:36:26 +0300
Message-ID: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(438002)(189003)(199004)(36756003)(6666003)(54906003)(426003)(186003)(107886003)(8936002)(8676002)(2906002)(26826003)(47776003)(72206003)(106466001)(5660300001)(305945005)(7636002)(4326008)(478600001)(51416003)(7696005)(6916009)(316002)(48376002)(26005)(246002)(336012)(16586007)(106002)(356003)(44832011)(2616005)(77096007)(476003)(126002)(50226002)(2351001)(14444005)(50466002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3136;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD020;1:bSxMgYROJ32FOqsiECldpObSVLwXzsRsu67n0BbUVVZKPC07CiP9GyCoHgkBS+Wz+34ZzgYhlq+02vX5SRmELBHmKXmzjH9bLqUBv3Vwc6gVnxzmYNIZS50meRCeKhnl
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 176292b1-100b-4942-1290-08d5e80d412a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR03MB3136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;3:pvYH34mU/WfQvpBTufAFa061Dq0nAd0YuTztCQHtCvHcPJDvUUOSjKPRie6YEL0iHxYBX6HqW1fJeazRHB2ovUoQrXUsL2fCcHZLRd52eYgdBM/V7apeqX8/XaksYqJv62UKOJ+ZzjU2CVD/8ZhB6jrR5w82iVqol5fxEuMlDlhOFI/w32C8VlbYoGeAEHyh2WwCqn0hVx2rMaBcaJxu3FdTe84iQv3Q0Dk2RoUPe2S3HNU+LVJkRF9/SJrjtazKaiq7lOP+e2/khVru1E7Z+CxJfkevDR0vGXVP+oK0hkhhhYceNsbSimfOVk+Jzow9es6ikhqZArLTdFrhSlataNay/EUpTEK6wPzCNC4nYQY=;25:gHZ2q2cXDud73acQniqfI6C4rRTQGWXjNZybYzHcUxK+dT1ggvw+I+CnzzI1sBx/f793Acxec5Y5loxv/8VOiYyxw8/p4JALDHdFRrYfCX3rqTmNTb1Z+lp+1on33ClVHhlrOJiWzPqTSH3WjQkqFtv63Hq/IJuRjs0OW6h/68fJPeOhB6Yarykkhu+D9PWayuwrBJH7bR1y2rQQRCBmysK4656lM7Z2KyqTW8kFh1BPJV/2XZ9MLRugBvLnuJ7Ppm2zy2d2hCyaSoKllMpDrODuDYoLVOx5k4n1SouPitQg0GZjdsSS0SfyUw0BSlINQM3Xy4kgb5GCyx7X5olLqw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3136:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;31:DUC+hSepvyV5TvDJM1GdljKxrEz/HA1KB1luB+2aF2JR7n910QVkGee4lFt2jfOa2isfRblSKx7lue2h5HRAtauZNnxsSmk+kboDBtLXsEJwPMpA7xquEAAtiGrqZumO6iu8p1ikhz3ROhIU+QNWRxHIBL6L2BUBE/VSlaGEtks7ZLmCsuzYkFuw+7VRMsm59Vbzmfj35Md0qih7pdTlx6F00pSe6G/5ZqmO+MptRtE=;20:DJJaiRR0NOz/YjslI15lQq0s4mZuD1qD39FL9egRMBlWXbuv6wH5HCxjARKgAcsrZCCO26FnxRWv2bXdg9n0AQI+tkEbdL090NkxKO9WjrsHgBZqmfYE+V4q9XhaGdYXlixEkXOVmOTPPe5nCEqQ/jP9MXGE/BCd9aBuqWVl2Pm9Rpq0xsUkKOMnfK9ehZV7PVIw7Nn+Nuw9nfgwGiNRcRz4VgwiNW37mzoLjfeWMPP2npU75VEqiESmD1okE77VbZFLHn0LAVoCrY4NFY/67pKta1f+nIc8d9EZdsqX2OguY9UFIfclwGzFvUrz32RW27PYuzuOYtmeodcnEz/DvbVgbV5IkFgmR5E3uyD4k9Zen82hFCgpHo+h66dSkFduG38d9eK8YK6KrrHnXwn0RDtoU437ULnrO6Kh5DxWH87XD7f/VDKs/tfqrx95Xn6z/Rmwwo+kM3JRxEZhGKnFZWzgda+FAzQzgikN6CXbqHEODSWcYA6n4NwYBgFakIHT
X-Microsoft-Antispam-PRVS: <MWHPR03MB3136380054DD59D3DDAB10999D590@MWHPR03MB3136.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;4:7RzQ8XPdYoEfT6L8+QO8B6WKsqcprr0C+4VsCVSapVf1MU0HUZEaBQTOzzJ4saXWvh6Yjevy4nx+GbFcqRnmw5uXoNf19BBOCtMvxVQYpHIjQ5IK4teJgdxBM6rImQW+LJ/XzE6OqCSixbmHQzg6/O0Rytvn7hp+ST1bMfodoIoXHc3+9AZ91TKlWphX9i4Atq3d0E4dkvH91+NFv/RJ3PvtsvhHoEZEbFhrbOy9brKSxUzQMOCQrZ3r2OFu+0hZwlT4dcMntTr4L4iYry6oKJram1OGZ6bJ5shtXN+rZOlU824jdjGPoZ19bT1XMlcl
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3136;23:u0+gph1DZaZrJtw0dPLLBI05ZFJ9670j32O30wKqy?=
 =?us-ascii?Q?g8dL1uZal/LSJdx9jHIfaUmimKa1ZZ9eAT5LDcjMAa3FC0eFa8K762OW6Dvu?=
 =?us-ascii?Q?fylIGnGYy+llFrJYRaYZu8liYv7KrtcJs1OcpNPT51apRjnLrE9dkHiBWyGa?=
 =?us-ascii?Q?sHvx1Hu7wezy+OLMK/lXx1m7oSLDPyKkrttyLJyWvk+M9OZcE/JFuo9Mates?=
 =?us-ascii?Q?lsjEc4b5feEgMuzOMhLa7Gak9MCfzbda10TmPUO8P9kFIVYsVWn/0A8a3T3G?=
 =?us-ascii?Q?SHSYRlNqq77aPKphB1oZ30f4pPmQDswrLPa1BgFGkUayhEgeJbi7d9Jr3II0?=
 =?us-ascii?Q?Ohi46H/MgXUrxFsU8sH4xM1X0h4pKhG4yFMXJ22DbYLwKdRoo2ReyqsjRvGT?=
 =?us-ascii?Q?4DGNtXxDM8WRiheFyLITPY3aOtdC09CL86yBztYweNd1cskpZSCHmN07+MKB?=
 =?us-ascii?Q?bK0KCxT6jf5wGEdPiq9jXh9S6ZYcY5b3yiIkDI9qc16+TSO6IYSDIJHGebqr?=
 =?us-ascii?Q?oUimoV13/MM0C6dlEBQdDUCFiSqMBLTNulRlFe7pcHXZrdivWJSNW0H1yVk+?=
 =?us-ascii?Q?E3+uADdyf5p2PH/7gpWNBWbj3RSATJSMPngsokCnhvqjMdJijqEI/8ycpvrX?=
 =?us-ascii?Q?IdqGpRyhD0Et0yXQ8gO+wzOWiUw1A1M7sQOnqZQ8H1fO5ugnJi3wule8gNS7?=
 =?us-ascii?Q?Ytwz092aSZzm2I/jr+6VZzrI7GehRr2db0aHFOLTDe0GixhvX9x8l812md3E?=
 =?us-ascii?Q?sJeuHrUw1BRTuD4CE8zqtnRAnfZcgS0/fbnq0u4TuqAxGQpMdSWDrBbM8gu1?=
 =?us-ascii?Q?SFiJlt/fVcxONp3LpW3IhMDn8ZXeqhdx29OSFNW+mRLHFhuFVZPeDeJXmfZE?=
 =?us-ascii?Q?tp9l+kSsETr0Vq3F9oxdeiIg1Cfau8wUvaqrqt4Wc2Mcbx6JRHxF4ZEkRzzd?=
 =?us-ascii?Q?r6FDmHNUoJ1fBfbNT6GkiJjeF34CHvFWSQDakv+LhgP7UqTBbPRzuPqZt2B7?=
 =?us-ascii?Q?Fl4gpHevRDDBbp5iV8XofmVwHAU4/wrYcl7Ub+dJ21TRqoFyfgO6gcwcag9h?=
 =?us-ascii?Q?8vuzRg=3D?=
X-Microsoft-Antispam-Message-Info: EaJ+pO0D+NdN1xv2OXbXiRXIUc/KXgs13y+gzYRPs1bRwuwb0GjV38FytiW/eKanoQNkYArgrwQdgmpiyZulLJcuuVJoRjBxIC0U7K92YqYWMxSiF8ssKZPMjJpInF+5w7fgUpzQejC0rdyfuxTjPqvmvDibREBqgtoSLcaD95uMHj1Quu7RHCRSggoKqTlXa0zgeKe3ZBo1aUw7u08GfLokpNRRg3xr3WnZR3m2CLWPOYIIeGCiqAWI/vMWcMCWkMrEfUccwfzop/kWqfe8a6Fuc3gomIXgiiK3FxovltWRCmDHQRDCJQ+R41atOwF1NjT4B5AUOlZlfBEgEuwfSOv0WPjC6ozYZf/qfe0Eo+8=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;6:BYorwcJT7lUvfusyFaTVYHgQG/WcMAnTTzHVdQ2reBua5/G68FagbPb61CgIBAYMh+6cozsE43I1yWYxoJGEUgLc3dQOgZXwaJh2LVttmIdoBg82vNnJXmCW5zxa87/vqZpcS5qqB36NUBiHy9MaoYQJtwQYoyescI63RnG5yQaiyts9LtdYS31UySdrlsmU67XmZl6YclM59KMGCEemfero9ufn8XLAedznchIEVTMjwRb8iKrbU1NCh3Wot65MqyEK//hssxX4cFz9SlHJQ3RiKTH+xyMMqHWzzaSxioN+UbvcuvOn/Tb9ipfSgCjYoJYS3eqKRsPB5lWYzNcctPlwN8jQxoCKr/P+HIXCoY63/z4T1ORN3AynCCUo983aGsg+VEMZp5FKgD0jOVjmidekXF54TVmAstB36Cp8CayPqKTfQqMFzb1L76YmOxV/Sd5TeJeFuGcKqkDemr5adw==;5:2xGsFfTOEcGdKJR5DswSyoo0lUUI+lGyiPK1NikGAfVvkMk7507eWu+JRb9mSBl7wpr9O3l1l/kfIpXrCnQt0a37vbMaF3JlOpBhq0Svsk4+deyTN45sm2Eu+L232wHyGeC6XuCIMTcL+YQwyJD6ubv12zXZtQvPjW0anjoHK2o=;24:Q2IzBa97FijF6WWMz54tWM2Ci9yHJ9PkX9vaD6r77wrSJ15zxHVf7vRCjwplQbculgiDmKy70Tr5yG2Z665JaFO2Q5T2oNY1UP7M2ykPuV8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;7:e1z043S9yRxoUbmMs8GVjhwElaLcLxfWwMaDDYE5VDAhIxSspVir/8aPeFbuuz6Ga/ii3cgjEVNi+RSd7Yx7WMnBdPGDorL/OtrFLqC38Pjmig5cMSHibBbCabK9998BjmbwIbPrUpDBnT0PRvcRrpDBTheSt5PypaiPTrffjODd8ftC95OtxdoH062/Vn6VQCvkmKtlM4itaddGMrYmGHn8h01DXQyOhSmR1ZekcNymF7p+HNApeTNeyyzZX0fv
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 15:36:36.6570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176292b1-100b-4942-1290-08d5e80d412a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the sampling frequency.
Also, the user can read the available frequencies and read the currently
set frequency via the read_raw function. The frequency can be set via the
write_raw function.

When the frequency is set, the bandwidth is also checked and ensured
that it is constrained to at most half of the sampling frequency.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 645902d..498c740 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -205,7 +205,8 @@ static const int adxl372_samp_freq_tbl[5] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -291,6 +292,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
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
@@ -568,6 +582,37 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
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
@@ -722,8 +767,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
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

