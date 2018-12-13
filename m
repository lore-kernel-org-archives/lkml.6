Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ECAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="dC00G2Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A867E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeLMMr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:28 -0500
Received: from mail-eopbgr720074.outbound.protection.outlook.com ([40.107.72.74]:28833
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729225AbeLMMr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWFL2uo/8KGnRySlMmlcnuGqJfvFBR9uH1B9xwVjpP4=;
 b=dC00G2RxVtYC+6itcLvGsBxm1sjqIilenUu1psKY3gYuBvxrPf4F/0Q4CpPOUzrcggmuvhWQqEN6pD16EebA204tsKhJabyPrIDgEY38m3G2AaYaigLQ3BdeYkGhBuuWhvuAQwvhXa8ERrActjOu3FPtP3XriHkj50mgNNUepUc=
Received: from BYAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:a02:a8::47)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Thu, 13 Dec
 2018 12:47:24 +0000
Received: from BN1BFFO11FD018.protection.gbl (2a01:111:f400:7c10::1:157) by
 BYAPR03CA0034.outlook.office365.com (2603:10b6:a02:a8::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.20 via Frontend Transport; Thu, 13 Dec 2018 12:47:23 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1BFFO11FD018.mail.protection.outlook.com (10.58.144.81) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDClNGH004213
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:23 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:22 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 06/11] staging: iio: adc: ad7606: Use find_closest() macro
Date:   Thu, 13 Dec 2018 14:46:18 +0200
Message-ID: <1544705183-13288-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(3190300001)(189003)(199004)(7636002)(8676002)(8936002)(7416002)(246002)(478600001)(2906002)(50226002)(305945005)(110136005)(106002)(54906003)(14444005)(16586007)(72206003)(316002)(48376002)(36756003)(336012)(116002)(26005)(446003)(476003)(7696005)(126002)(186003)(2616005)(11346002)(50466002)(106466001)(77096007)(486006)(51416003)(6666004)(44832011)(5660300001)(47776003)(356004)(4326008)(426003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD018;1:3P0u6t9hgtlkOkRzSO6pvWUzcM/tEYLz4tXgXlZ/5G0SivWoTyR62Pr1EVW4v9TXdjV+h3JBw0q8Nvez6HHVe9tnqVMz6lpufpONzpLFVadYEef4uKQBn0ACbF076O57
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f3b934c-5365-46d1-6ae4-08d660f9210b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;3:M7OTkumRoKCLwhPVjtlCQC/9rkzIkikdUDrn7LnC0lGcwfwEjB/SkmUBAIdi3vCoSbJbjuUNmeV+I7nn8dKrzZ82pWqo/SqlarWlIxBoK1BI3L/R8ApnS+qwwYcTqW2EGGTgM/+Low/HO+txEtY/D0DEos7+Xf1FgiK8fWqAgTRK4mDHCyleH7THdD9KoqGzxfDuwh++CGI6+rmfGGmVEyG8iPM7j9M1SGpCcVel2w8ROhBRZtbEmYdRxh2ywUBKt8x/TX63+OAbPyWYv0Gi5tfWurvp/sTFP0nxclJ9ahPJdaResn7NYz3EvN0W+K3azJ/6PoSLhGXUekk8h9fM3A7KGiiwBGj4nHDEqmABJdY=;25:h5aWS8pu1LazLm6xS7+5WT9UUWhQAAwhgVrnYFjYyj6SFRZlKO4LQta2N0a2YJiSf65OLqkpNVLg12WY7ABVOTHYcjaybiXXTyPnQP39oiMOtH4ROpOzKZcQag1McZOO2h4z03j/XG8toy/qxe5Jkg1Z1JVSPYk0n/CVqPPoFJPcndWYdFMgLrC/k4czSGYqDbVMVaHgTyxH7FPyPfGep4qjJy5JgsK+x9/mPTKlmCZIulHZbnQTqDbbwdaYRvOY9PKOMDaxy3J5yUBP9WtcLqnLuud6wUj2bejcqdZt5WjPC95pCuO3jhUnwFPzcubK8NjDVtzxNrAui5fygZ0dqaw1eStUkldCAeQwOZW/JJI=
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;31:gPqUPhPZFPGIHDQ7XNLqXc+Q68yRS4Api21fjcZUXfyAE7xvCXYPsc1pjQmEhaKoePUUp1m+Mf8/isbXGWOHCADy+ZIgnE8rl9Kk9kwyRH6XzGh7AHiBTXt7E19EO6sYwwJ6uIP4jVTbDO1Xsd/UWQQOuE8ds8mHVlL2l8GAvkz77XjmcTZfaHjDkzIYtPjNzigPL2FgJuk/yQ/qsCOFDI5MteUxOIaxdnyGptya+Gc=;20:YORMritm0dQnAb/87dJZ5dFdYLhh2BxRq8sOHUhIZ7lTQgNYMoJ+oRwK4nwiZurDfn+zq1nCPhQhco//excEA7oWjppu0DeAicmS74/asR6UHUQSU0blD9K5IYlmn5XAzLkVJgperlRnDpM6eoXAe6x70/QK5BEXnvI+Ro1akj00wxZHgvWdZ7oJBKajGHCWncrvFYOaq2MTeSdz3CirpRdh/TvkOGg0KuAQvC9ISaap9cc457qG3eURhWu7xxoGc8vX0K1Aqx9eAs3sxdL5TrPw7ch8c5F8IKFMt5WdVSsxzRMcUa5iyRuX8CCrMHoyO7hQFCbV6/NiMcJnce2Mvwn70Cf6mis0i1bhySwQ2dEGiw4hovaFlm6+kKlS0AUiiWEOrNLmDNcjS/7fOs5GNy85yV94kOHy9HwWRvRnaxkPv31O/efu9R0gUBvQkoMT8vuduW6VrQ+PAbxSXcafApn25LmPDstlNlIegQRrBm8HyoeJ5dShAlwlXab6tCyX
X-Microsoft-Antispam-PRVS: <BLUPR03MB55270C2D334158BFE271E069DA00@BLUPR03MB552.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB552;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;4:iDsuFjiSUsdDFWIF2X7yef1j5g5Cb8fnbxIW5a0YZuVc9WNzYr2OVUxVPDDje2mTAH+LBHX8JRBd8uxJbpx4yX5txbuEELCkmUkyCw9HLvn3XTOkMhTb14Zt6cYaWH/0yZE4mZ0/jIzvJeOr/WDZBbfVaFU0ap6ivEFLYYWN6zER7izQNk/Ysyfft40ztw+ZQEuH1/+R7tpN1F4PinLtL8Jalc1fc2LLiYvYQFw6G2RhI1gvCtQCnPCOBvt0okeXBMHsbSwhBU5FaqJOq3Voig==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB552;23:0m3+xiFtoD7i+a+MKpXqHyMQAaYZetTzZiufpCJ0tl?=
 =?us-ascii?Q?dRm0q7RSZqgNp5znal/NTYy1LgQ9Zu5pvDPB+PfE6Wz53eAjHwWFNNfm6wpo?=
 =?us-ascii?Q?P9dVg+FvvPqGWM0XEFVkJ1kYIJ96PHq7vztbjqHDLLNCDxvvkf3uVGYuAm/h?=
 =?us-ascii?Q?1rIB3w0bJbk906WYcp7Gc/T0XIZJv+h9ZBrnLvprVghnAeekRHekoKDt+d2Q?=
 =?us-ascii?Q?44lWKwxNHMAYY0Yvz12jC6y0E367ynHHvXlNjP/lJphJw4aDqpYIhkaqyLPU?=
 =?us-ascii?Q?ySdbPLT+QHblMI86pHvNc9dlZGNADSd4ZstJt5UVrevPK2i46M4Bo6GS9Bv/?=
 =?us-ascii?Q?b3svweG8kGElLBto2MM0q95XZbNts2AZv8ABKQCJYK8kT/cRuYDsnyvfRQAU?=
 =?us-ascii?Q?9f4wgqRw0vhl6NcUQ7lVmsTyRwT1Hrf8ZxlnnUGDqReO6aUORskR4Ngg5eJj?=
 =?us-ascii?Q?aoJKY6aRxf4mlNrFgcS9P6ozpCl0l7KY5miSECde4eB3tHelSRJkOvMg9jny?=
 =?us-ascii?Q?QBlFeRMOkCGPrlNIdOI12hGM3e1voYd/+2R3v0HEvx2Q4zdYD1shzPF6Mxii?=
 =?us-ascii?Q?vWziu7J4igUX3t1U6e0+pEbOFTbqMWGx3tJovicYxUhKGVWibotQ/cyie7QD?=
 =?us-ascii?Q?Bfk6/bUi8N9SLhWCJHbJ6bmCIn8ggHuXc/fI5ZAigGjfpaUalbhjoG6peqPa?=
 =?us-ascii?Q?B0oQD5OBeLiCSk0wkI1WLHoQLBphj5yK4o1YBsMqxrY7HdbbSx9tHyWbm7Ou?=
 =?us-ascii?Q?NfRxWT1gM59dtx+mLoyANcnLpclvCVRLRiZcIIrQFxYLzC+Vxqrz2Sh9rOOf?=
 =?us-ascii?Q?TyaS7SLAItipBRjiv6nxLYah+ImlJaU8ICKz8bjR2fu8uv6xkCSsW9FOEdGH?=
 =?us-ascii?Q?EVbeUKGhU+Oud/XUcqdtvpN8XFKZ64HGcuZXpV1IKkoGRkEPZf75xq+vOK3C?=
 =?us-ascii?Q?TP+jo4nlh8SqR4JE63zEqB+i6KL5tWj3PftPXR0TDRrhaJLpp3sz8ivDk3DL?=
 =?us-ascii?Q?kj6Jud79p94Cu9puTBh9fwN/hrMtDbpHeIZhrAF5n7Se2K2MeR6bvGGAsIE3?=
 =?us-ascii?Q?9ncfMDX51/SE2hUE+joySk/IZjvHus35c3QD8LfJLnV6HKrg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5d5V6RPZ2d2SWQDFE4GBKjP9awsCoXlTZYAnYhxZHTmxM5b9fv8/aatb/K7hyaRAe+J6Ekh3PvJ4Up90Jk9NWoG49CgtFPJG+IucW/hWLFC2z/e5LK5ckjUj0nFVma3Rdw/5HhrOhlQ/E2uMbmO3WW/DlSgzhZNhkdzO4hZFMQGFOYGV5N+YhD6XeJt3hWikwB58MIcbgCRS2Y7ZH5Cx288wxSimcoCrgKoOMW9ipaU+BQSCdLaud8vu22J/Udh4DC6llQmd+PnB/4+vmpkMwqZ1Svu4FdUZj2MozYieRtc5Avmhdzq6k1fvm0QUAxH+
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;6:77dhEsXPaexZr0+nKDa9TpeSHKbtQZ1yxVql9p/HQrpc/qZrni6CypmHFCD1Clqi59iswExUeFXjpDoUzQQbZ+4gABx+pYYTtkG14vqMV48bWGKSniua4XNJtnMtAstlFOgR4+1Il9cHOIu4G2ylbFKXysxAUG5rf4S2gGdYO9VtDIltmIEDLgcT4FXWrig08/4JwJpUKGyv5duRJ2NTIKEFTt0Wmo3AaEtB3xk0qhrgirf1iZVW+pw7/trc1u+fG1iXwjfHqFmyQ0bKK2LObRRxvOr49XvRG4phWCmQQYlDdyrjLzICEYnk2vdBI5g5lini7mUgYKYebMw0jEBzhL+PCRkM6eFNI2SC8gRHQSeJQTcHVpmrcE1tM5JwRFMnqemLxNqZpYHa3jWZ7bcevsIzWVNTpvNqxdR//o9T/nRSL4fXNQ3lTGcTuMvMt2xWH3P33URiTdXCW+m+fzFHqhhrFXzyoRl9yFDsOEkXwc8=;5:nua1ojlvxfi8dK/tbl/7K/ieIiTBb/wOkX6fK5Ow4OYf0nTDwqQCnqaG0do7EQqxddwpryzp0P8Q5wL6HPNqGOSVy8g0CaG4RoJo9uCCJegLt2gKiQEXwcAnylepiKntO1weKWFJhf7J0W2Q18+51Z+LqAUjfUQqHPrTDHrRnS0=;7:jc3IdERtkyGDLjDb7wCojVHJetCRuhVnl2mcaqUEabKFIdQF9yohbwodu/L+4+K6XHithJrVg4HiU+gv/0iNDOYgiDwiIUQevqm9IMVog8eKr1uKOV8hTQn6HgZl5LaVQUhcfRZv6G+UVBpTsVfXQw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:23.5616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b934c-5365-46d1-6ae4-08d660f9210b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking for the available scale or oversampling ratio, it is better
to use the find_closest() macro. This simplifies the code and also does
not require an exact value to be entered from the user space.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c | 58 +++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 13aeeec..0925379 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -30,8 +31,12 @@
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values
  */
-static const unsigned int scale_avail[2][2] = {
-	{0, 152588}, {0, 305176}
+static const unsigned int scale_avail[2] = {
+	152588, 305176
+};
+
+static const unsigned int ad7606_oversampling_avail[7] = {
+	1, 2, 4, 8, 16, 32, 64,
 };
 
 static int ad7606_reset(struct ad7606_state *st)
@@ -148,8 +153,8 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = (short)ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = scale_avail[st->range][0];
-		*val2 = scale_avail[st->range][1];
+		*val = 0;
+		*val2 = scale_avail[st->range];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -165,8 +170,8 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 	int i, len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
-				 scale_avail[i][0], scale_avail[i][1]);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
+				 scale_avail[i]);
 
 	buf[len - 1] = '\n';
 
@@ -175,18 +180,6 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
 
-static int ad7606_oversampling_get_index(unsigned int val)
-{
-	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(supported); i++)
-		if (val == supported[i])
-			return i;
-
-	return -EINVAL;
-}
-
 static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -195,36 +188,29 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	DECLARE_BITMAP(values, 3);
-	int ret, i;
+	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = -EINVAL;
 		mutex_lock(&st->lock);
-		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
-			if (val2 == scale_avail[i][1]) {
-				gpiod_set_value(st->gpio_range, i);
-				st->range = i;
-
-				ret = 0;
-				break;
-			}
+		i = find_closest(val2, scale_avail, ARRAY_SIZE(scale_avail));
+		gpiod_set_value(st->gpio_range, i);
+		st->range = i;
 		mutex_unlock(&st->lock);
 
-		return ret;
+		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (val2)
 			return -EINVAL;
-		ret = ad7606_oversampling_get_index(val);
-		if (ret < 0)
-			return ret;
+		i = find_closest(val, ad7606_oversampling_avail,
+				 ARRAY_SIZE(ad7606_oversampling_avail));
 
-		values[0] = ret;
+		values[0] = i;
 
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(3, st->gpio_os->desc, st->gpio_os->info,
-				      values);
-		st->oversampling = val;
+		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+				      st->gpio_os->info, values);
+		st->oversampling = ad7606_oversampling_avail[i];
 		mutex_unlock(&st->lock);
 
 		return 0;
-- 
2.7.4

