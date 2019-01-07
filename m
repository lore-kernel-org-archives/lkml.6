Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B1C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC2321736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="AFnwOnur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAGN0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:26:16 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:42336
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfAGN0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG7r/pTid2JeCeGdREFS7UVB9QBL6B6XyYCVIqQSxfk=;
 b=AFnwOnurU6qYDBEJSj94RuMCXsPNDoOyZp4pDTRp+1i9hwZeZBm7Yn61vlZCcyUE35nI0QrRXoLVrozuiKM0dOMiir6SXivq9ypy8fQXY8ok9sSQh7QATQzwhDpSwb7hpgLNejcCZNR1XCe8SVZvJ77zXXBbSbQTcSJw2mhGGZE=
Received: from CY4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:910:4d::14)
 by SN6PR03MB3504.namprd03.prod.outlook.com (2603:10b6:805:3f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Mon, 7 Jan
 2019 13:26:05 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR03CA0073.outlook.office365.com
 (2603:10b6:910:4d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Mon, 7 Jan 2019 13:26:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 7 Jan 2019 13:26:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x07DQ45h032734
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Jan 2019 05:26:04 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Jan 2019 08:26:03 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 1/2] iio: adc: Add AD7768-1 ADC basic support
Date:   Mon, 7 Jan 2019 15:25:36 +0200
Message-ID: <1546867536-4116-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(3190300001)(199004)(189003)(51416003)(316002)(2906002)(47776003)(476003)(2616005)(116002)(126002)(356004)(305945005)(486006)(48376002)(26005)(77096007)(186003)(8936002)(246002)(5660300001)(44832011)(4326008)(8676002)(50466002)(966005)(478600001)(426003)(72206003)(107886003)(106002)(50226002)(6916009)(106466001)(575784001)(6306002)(36756003)(336012)(7636002)(16586007)(14444005)(6666004)(4744004)(7696005)(2351001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3504;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:5vtyhs9PloOA7UcMhYcVc/NxYS/l0duhUnMis3/y2kGwmfiPB3/QKI+rpu+WWTtU/Ck+8EV4nFH5iiFf4quVv9uJ2ZD9/Xz1g/q6oLLbwgPRBkJuYRC1Mx9f/E8D0dEY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9590a72-7088-43c3-e970-08d674a3ad3e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR03MB3504;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3504;3:q+SMFvnQUU9tSY/BIYs7pzhC2leYQrWgirLLPHTrDtPgbHPeGuIo91YqGcrhkNkb24MGAbKBL0kQPUQwIdDNp1Zuk5AjU3DQB6WjZvWGK4Y6jow+pqZnx3rcFxdUUkjwJb5TOTZW7h2GjgRpF1zdrE4EPiv8mAuMlOxqKjmDas6TyKVlFUsc5XR1qqzkBMh9VuoFvRcseZdUB6WOdOcrbIx2uu7AjPMuZAUe7OZSPjEzgfRXs9pZ8tTGxegEyoHzOTfb3x2x7OEYbZ9CbcBKCLcu9V+IXAIUTwSxliP0KZFIgOezQe2LxWD9+OqYzzSWdCuXQGV+9SnGdf6ONExe9XTykxYOfHIpE8ST8jBNkBjUNnZnTG4UMgBrjUplcQ38;25:6vs4vFjkvAKIhdY/LKWgBV9qWvwIwmhWZSdLqWMn9ApFvLN+be0zto9h+VKv9GECw3efTR2mAzKqauckfywYgQm3yC6gvgAG+mDOZZUlmxxhIzyTEX5a331xnMW3fM0VJ1sMkzZGds6CdiKKlxjx4/aaijeygs4igwC9U5rJYwfVcez980hcKCjSnOXlH+/uFJeJzcaH51VOgDBKGfIo4kzabaZhhVk9yaLNoEa5oGaUAyXlzet+EbZ6Wz9LsK83OTMaNCeootcDmDodpwupISq+pwQQ/KvSP66y541eG3CUYGngu0gvWWR2IE8Rp9m2tr3y5agcBM8G5STDRU2qAg==
X-MS-TrafficTypeDiagnostic: SN6PR03MB3504:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3504;31:5beAEKMivLaAtxLfTIpJ1hqpaFoi1aCOPIjrpOuwBbkT+D8QyhLnhkCiIqcQ2goIwmzRz+msB5brOK1CP7I6tGxQ2MYI1GJ9qoHvwlEKJAnzdowMd9EYAZrADRnlWbMjz/8H76qNHdbhCtPOQvDVBeVG1GQlPWjmuxvE/fEOFiIVXOqND8a34QP4pIxsS3sTYYcmJMH1znvyGmT9IzdfABlm8u7BXoXxunOupA1VqWI=;20:Zs1QQulBs/Ha3U25lD++nuSknqpaDqLkMyqovrbcnSSEWwlDsAclSooEIlbzqWHkbXnXBT79pqGgIA2Zf5D+TvEruotXrTvVO9FLAWkbjNPnIaP9Xt6tp8XcGSf1zZH8WcYQkFIJ7rqSIgh3NN2q5Py2GlhQzfT+bVFOp2QgUd0835rsszGw4I5RI1CicjIoWd2Ox3HdXVSU7WHsvY2lH6t35GWESUAFXYByu/T1DiwVZCozRZZ1IYSc3Dv42MsYC/CmiMXgVCr4wpQ4uXWtFLbCygLlHz3KlICAjrlx4Iidfo5hhCnJQGBaWtttEeTY6QLjAMLmASasufjzFPhqiFiXA0/i3ouucM1x+YgMdIx85Hp8E0r8eJgmmfJTuz3K1ximrRDFTlG9DotgxTg54vuZutnyRtmrGBsmfe+kDlYZUzNOvTPXt+xqarRNVeX9F4AQjdflGle7I3vmiWKPoeq3tjmb67f0/WWUDbY63UFMNTUEFcswun0DvaIH1vqR
X-Microsoft-Antispam-PRVS: <SN6PR03MB35048E21BEA4481F43E167269D890@SN6PR03MB3504.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93004095)(3231475)(944501520)(4982022)(52105112)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB3504;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3504;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3504;4:bVaj0zlLPrKoJb0Ir4CJVBwS0xHWq7g5PLQsVjHXytU4I95lctCihyWfgs6trcH5doUd0nVu0WaYav1gs9TWC0DWf5Y4xPveSMyLZJsnp7+lRjB4OrT10/zLM2dLZZ0mZzCSRSo1sKChL9iLwUqi5p25swbxfrbCzISwH89tRreeSLEDKDod50fKDd4C6zliDbK93APcOmgLf1BXsYxWwPSpvY8EonHC4KD2a66JTwgpJ9HCwLcGVMB33og69D9+vPM3GgdiP6hZ1v4TLJ+YVm04UVNSqMuLXArPI3rqjzWH0Hn+iaxKGnTsqETeGxb5
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3504;23:7166DUih9ZWFnqBM/R4K0ibQH7wT+7LzfaFdXh+Po?=
 =?us-ascii?Q?5fw89V9sm7YvbfOC8PIJcfAIlJkXhLyAzAwZK3qc4ZVV/CKtcg79F4h3PDc7?=
 =?us-ascii?Q?rRDr9S+aU3EJ/bvuSi2wRnK3Je2nP6ssmHGKegWw08CoVVagCBIm1VuJ47dG?=
 =?us-ascii?Q?b2NpYejWSRNFWrEpnC+p0CwKHsxMIKcjQGVSa+2MFPwuOwX1gbcZttrgEjSt?=
 =?us-ascii?Q?70QjltlLSfSWih3YBOTUZdZ5g0F4MTXn/GOJjK0lQUat4IOrFo7kVW6Di+eu?=
 =?us-ascii?Q?v26oPS82X8fQW6PwwyVunl4uIXhnLfXxcvx4HmSftXnwMsaVrpf7xOpIpmFa?=
 =?us-ascii?Q?BL8UmSKagXWfCiz0ug7aXhvhIoImopR1r24x5TQCzD/bEiWtbSxTKIyHYZTL?=
 =?us-ascii?Q?xzrABDHA1ztJbQe01yXkuIPJgVa6gez+wPwYBX1e/dpmsr2OzLZfedZ4NsrB?=
 =?us-ascii?Q?r1z+ouFqtPLl63X8DMATxdMrFWdvhDbu844RFuDI7Eaa6+HQ6GFnHszkAzNL?=
 =?us-ascii?Q?sKd+vDn4bUV537BXGf4GVjO4vfm4CJZO9cX24lvX145iX5YqwH+DNp2hvL2d?=
 =?us-ascii?Q?n3W5wAEzmPcPZ1vuP4llIhZO6yCPmKnltKPnreIpHOB0oZOCk4bf4OoOIW9z?=
 =?us-ascii?Q?w4gAh7J15gqopzcPFrCZY2Y3rFWN6h8f0IaACsbdWOUcF/0ZVTbWzPv0dzJd?=
 =?us-ascii?Q?qzV8SaZElg+0eoF430baref7JEeHPviRLknXU7jwLT2TrBgmHa5MuULmKDhj?=
 =?us-ascii?Q?FSnzidOsfNrXQxQZDZjTrijMkWP29kJzAGEIfYKAtqq0CJ4m0Ej/y8F4stTt?=
 =?us-ascii?Q?S/lmKI7YwUpvQE5QNwcyIqGGU5fLuAWJt8GRwuzYdVGh/pt3fUzp4tzaB+My?=
 =?us-ascii?Q?09fsu74O9vfSa2PUaS3OZwYzmdPF94mJYgmEesunmccGqk3hp8fW8o41l25j?=
 =?us-ascii?Q?JYIOhciO/lwVsNeXl1Zk2bkjkE4gt1J2+9uHbGWJ0PsGLEKeLZ1+zWj8WRwI?=
 =?us-ascii?Q?27K6y013lJ4ah2b6qJN2R6tx6JLYApuiM9cBXEu9gEjho6aKpq0m0gSPvNpp?=
 =?us-ascii?Q?ltjTusyzeqhJ04/UK/tAYqwE/nHi/SokTxV2lW19tV0JD0kh0qkXAEPjfnx1?=
 =?us-ascii?Q?JQO2pIpGA8JCKfySUW/qXf7aQMrwNd4?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: q6EGknlPG6hCcmVm8NIvPKnZ7AHDdNdLoX5VfC/6uoCJLV73KbBy2TTebwTEP4Y28vfL8a1jbkN5IpdvrLjjgEOoYImGRno1u3/GjcOdQq8FDTe2/+2zbvdEVnQboKzOtJrBhxi6W8YtYwZaIL7rYMCHEWxvAXoA8yjKASVzj3FEndJvO+SmLB3TKVaePCmCDvceXJhp1mdv6Ce2cTX1t4hAJXgVd14qqLsqKu9JFZ2fxJEf53JcgAa/E4nPoCfnd8DkgfIT7rr5mmVSIm3y/H2sA413oMJSuLmHoY6coHESebIhNcddCACK1fazfO/Y
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3504;6:d99buAP0prw644ZwfmYH5071bQRjhZCQ+s6/8hOyGGD/F9Ger0IKLWbLQA1APcmHKI2Sg6+Z48++0EmmjFp8kJ1BHfvCU6VShBzCtmHDIcSHRlp17nKqz6pzhxnOpYIES2Ga3YR5CyAa71uEChJ0R1/vhHKv2dMsC9fdDRPfu1sgwCnry4gQi8HnRT8u0x5r8r8W7I6t6gMllZNHo1b+oUUZo9u1WBUY1D3nDw/ASON8E+SvoktzKJMyuEUbkJxV2G+debpREHG1oS7kA3K4ypc10+4ntg5ythpt4tPQiN0wFCVnGFGlVdNwLZNAoSdSd9UW91xgNsthRW7tPn1la98sNnChWQ4wLT+KBp1cU6VYK/1c2/NvFuE0TtMIomD2g9wcGSGhyIcCOEzVIsIUwE/7U4gk+Z3aHYL8FJb+VBAPtnv6THa08Exiz6ri1s5sHIF1O9MvhxhiwQTneFy9EQ==;5:tGrdxd3hF8gE9QCNbVF31OCfpitWH6oX0Bw2ORLZ/Bmr5avTRGpE8h4zvNQ7lOSzM6cvcwJj6fqwM9ZbhJMndTI91EGLcrqhsC3oq9N5Jiux+0+qX1mbSw6zeSNr7HI9/FjrLwXMfzHZB+TwcV5SDjC/q97gqrn0i2LGvpoomeUWXgjaqY9s8sHKwEmRptHdHMF2B8ovWhTK5VL/VCH4aw==;7:f7rgcX3LTCGUN0sgb2UuUspxSPm1+PQHpQOZj3qOvTRXfEknedVQIJPfCN+VSH54mGWv4vZkMLDmQZQ/w9mPfb4ruVx6BydMG0SFGITe0wAnq9Y89FennaoHouHdlTBFNU9X5XSMUA9g3C9R2GTTHQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 13:26:05.3638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9590a72-7088-43c3-e970-08d674a3ad3e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7768-1 is a single channel, precision 24-bit analog to digital
converter (ADC).

This basic patch configures the device in fast mode, with 32 kSPS and
leaves the default sinc5 filter.

Two data conversion modes are made available. When data is retrieved by
using the read_raw attribute, one shot single conversion mode is set.
The continuous conversion mode is enabled when the triggered buffer
mechanism is used. To assure correct data retrieval, the driver waits
for the interrupt triggered by the low to high transition of the DRDY
pin.

Datasheets:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                |   7 +
 drivers/iio/adc/Kconfig    |  13 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/ad7768-1.c | 474 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 495 insertions(+)
 create mode 100644 drivers/iio/adc/ad7768-1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d039f66..3ba3811 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -862,6 +862,13 @@ S:	Supported
 F:	drivers/iio/adc/ad7606.c
 F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
+ANALOG DEVICES INC AD7768-1 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7768-1.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f3cc7a3..6c19dfe 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -108,6 +108,19 @@ config AD7766
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7766.
 
+config AD7768_1
+	tristate "Analog Devices AD7768-1 ADC driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD7768-1 SPI
+	  simultaneously sampling sigma-delta analog to digital converter (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7768-1.
+
 config AD7791
 	tristate "Analog Devices AD7791 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ea50313..9d50f7b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7766) += ad7766.o
+obj-$(CONFIG_AD7768_1) += ad7768-1.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
new file mode 100644
index 0000000..7ba98d603
--- /dev/null
+++ b/drivers/iio/adc/ad7768-1.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD7768-1 SPI ADC driver
+ *
+ * Copyright 2017 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+/* AD7768 registers definition */
+#define AD7768_REG_CHIP_TYPE		0x3
+#define AD7768_REG_PROD_ID_L		0x4
+#define AD7768_REG_PROD_ID_H		0x5
+#define AD7768_REG_CHIP_GRADE		0x6
+#define AD7768_REG_SCRATCH_PAD		0x0A
+#define AD7768_REG_VENDOR_L		0x0C
+#define AD7768_REG_VENDOR_H		0x0D
+#define AD7768_REG_INTERFACE_FORMAT	0x14
+#define AD7768_REG_POWER_CLOCK		0x15
+#define AD7768_REG_ANALOG		0x16
+#define AD7768_REG_ANALOG2		0x17
+#define AD7768_REG_CONVERSION		0x18
+#define AD7768_REG_DIGITAL_FILTER	0x19
+#define AD7768_REG_SINC3_DEC_RATE_MSB	0x1A
+#define AD7768_REG_SINC3_DEC_RATE_LSB	0x1B
+#define AD7768_REG_DUTY_CYCLE_RATIO	0x1C
+#define AD7768_REG_SYNC_RESET		0x1D
+#define AD7768_REG_GPIO_CONTROL		0x1E
+#define AD7768_REG_GPIO_WRITE		0x1F
+#define AD7768_REG_GPIO_READ		0x20
+#define AD7768_REG_OFFSET_HI		0x21
+#define AD7768_REG_OFFSET_MID		0x22
+#define AD7768_REG_OFFSET_LO		0x23
+#define AD7768_REG_GAIN_HI		0x24
+#define AD7768_REG_GAIN_MID		0x25
+#define AD7768_REG_GAIN_LO		0x26
+#define AD7768_REG_SPI_DIAG_ENABLE	0x28
+#define AD7768_REG_ADC_DIAG_ENABLE	0x29
+#define AD7768_REG_DIG_DIAG_ENABLE	0x2A
+#define AD7768_REG_ADC_DATA		0x2C
+#define AD7768_REG_MASTER_STATUS	0x2D
+#define AD7768_REG_SPI_DIAG_STATUS	0x2E
+#define AD7768_REG_ADC_DIAG_STATUS	0x2F
+#define AD7768_REG_DIG_DIAG_STATUS	0x30
+#define AD7768_REG_MCLK_COUNTER		0x31
+
+/* AD7768_REG_CONVERSION */
+#define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
+#define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
+
+#define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
+#define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
+
+enum ad7768_conv_mode {
+	AD7768_CONTINUOUS,
+	AD7768_ONE_SHOT,
+	AD7768_SINGLE,
+	AD7768_PERIODIC,
+	AD7768_STANDBY
+};
+
+enum ad7768_pwrmode {
+	AD7768_ECO_MODE,
+	AD7768_MED_MODE = 2,
+	AD7768_FAST_MODE
+};
+
+static const struct iio_chan_spec ad7768_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 0,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.shift = 8,
+			.endianness = IIO_BE,
+		},
+	},
+};
+
+struct ad7768_state {
+	struct spi_device *spi;
+	struct regulator *vref;
+	struct mutex lock;
+	struct completion completion;
+	struct iio_trigger *trig;
+	__be16 d16;
+	__be32 d32;
+};
+
+enum ad7768_ids {
+	ID_AD7768_1,
+};
+
+static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
+			       unsigned int len)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->d16,
+			.len = 1,
+			.cs_change = 0,
+		}, {
+			.rx_buf = &st->d32,
+			.len = len,
+		},
+	};
+	unsigned int shift;
+	int ret;
+
+	shift = 32 - (8 * len);
+
+	st->d16 = cpu_to_be16((AD7768_RD_FLAG_MSK(addr) << 8));
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return (be32_to_cpu(st->d32) >> shift);
+}
+
+static int ad7768_spi_reg_write(struct ad7768_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	st->d16 = cpu_to_be16((AD7768_WR_FLAG_MSK(addr) << 8) |
+			      (val & 0xFF));
+
+	return spi_write(st->spi, &st->d16, sizeof(st->d16));
+}
+
+static int ad7768_set_mode(struct ad7768_state *st,
+			   enum ad7768_conv_mode mode)
+{
+	int regval;
+
+	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
+	if (regval < 0)
+		return regval;
+
+	regval &= ~AD7768_CONV_MODE_MSK;
+	regval |= AD7768_CONV_MODE(mode);
+
+	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
+}
+
+static int ad7768_scan_direct(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int readval, ret;
+
+	reinit_completion(&st->completion);
+
+	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(1000));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
+	if (readval < 0)
+		return readval;
+	/*
+	 * Any SPI configuration of the AD7768-1 can only be
+	 * performed in continuous conversion mode.
+	 */
+	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
+	if (ret < 0)
+		return ret;
+
+	return readval;
+}
+
+static int ad7768_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval) {
+		ret = ad7768_spi_reg_read(st, reg, 1);
+		if (ret < 0)
+			goto err_unlock;
+		*readval = ret;
+		ret = 0;
+	} else {
+		ret = ad7768_spi_reg_write(st, reg, writeval);
+	}
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad7768_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int scale_uv, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7768_scan_direct(indio_dev);
+		if (ret == 0)
+			*val = ret;
+
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		scale_uv = regulator_get_voltage(st->vref);
+		if (scale_uv < 0)
+			return scale_uv;
+
+		*val = (scale_uv * 2) / 1000;
+		*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info ad7768_info = {
+	.read_raw = &ad7768_read_raw,
+	.debugfs_reg_access = &ad7768_reg_access,
+};
+
+static int ad7768_setup(struct ad7768_state *st)
+{
+	int ret;
+
+	/*
+	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
+	 * a software reset. The bits must first be set to 11, and then
+	 * to 10. When the sequence is detected, the reset occurs.
+	 * See the datasheet, page 70.
+	 */
+	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
+	if (ret)
+		return ret;
+
+	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
+	if (ret)
+		return ret;
+
+	/* Set power mode to fast */
+	return ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK,
+				    AD7768_FAST_MODE);
+}
+
+static irqreturn_t ad7768_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7768_state *st = iio_priv(indio_dev);
+	struct spi_transfer t[] = {
+		{
+			.rx_buf = &st->d32,
+			.len = 3,
+		},
+	};
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		goto err_unlock;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->d32,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ad7768_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_chained(st->trig);
+	else
+		complete(&st->completion);
+
+	return IRQ_HANDLED;
+};
+
+static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	iio_triggered_buffer_postenable(indio_dev);
+	/*
+	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
+	 * continuous read mode. Subsequent data reads do not require an
+	 * initial 8-bit write to query the ADC_DATA register.
+	 */
+	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
+}
+
+static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * To exit continuous read mode, perform a single read of the ADC_DATA
+	 * reg (0x2C), which allows further configuration of the device.
+	 */
+	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
+	if (ret < 0)
+		return ret;
+
+	return iio_triggered_buffer_predisable(indio_dev);
+}
+
+static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
+	.postenable = &ad7768_buffer_postenable,
+	.predisable = &ad7768_buffer_predisable,
+};
+
+static const struct iio_trigger_ops ad7768_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static void ad7768_regulator_disable(void *data)
+{
+	struct ad7768_state *st = data;
+
+	regulator_disable(st->vref);
+}
+
+static int ad7768_probe(struct spi_device *spi)
+{
+	struct ad7768_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->vref = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(st->vref))
+		return PTR_ERR(st->vref);
+
+	ret = regulator_enable(st->vref);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified vref supply\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, ad7768_regulator_disable, st);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, indio_dev);
+	mutex_init(&st->lock);
+
+	indio_dev->channels = ad7768_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad7768_info;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+
+	ret = ad7768_setup(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD7768 setup failed\n");
+		return ret;
+	}
+
+	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+					  indio_dev->name, indio_dev->id);
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad7768_trigger_ops;
+	st->trig->dev.parent = &spi->dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(&spi->dev, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	init_completion(&st->completion);
+
+	ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+					NULL,
+					&ad7768_interrupt,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad7768_trigger_handler,
+					      &ad7768_buffer_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad7768_id_table[] = {
+	{ "ad7768-1", ID_AD7768_1 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7768_id_table);
+
+static const struct of_device_id ad7768_of_match[] = {
+	{ .compatible = "adi,ad7768-1" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7768_of_match);
+
+static struct spi_driver ad7768_driver = {
+	.driver = {
+		.name = "ad7768-1",
+		.of_match_table = ad7768_of_match,
+	},
+	.probe = ad7768_probe,
+	.id_table = ad7768_id_table,
+};
+module_spi_driver(ad7768_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7768-1 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

