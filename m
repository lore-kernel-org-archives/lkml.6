Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A07C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0D020657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="rN5N4Tes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0D020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJ3B0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:26:42 -0400
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:28569
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727694AbeJ3B0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oicB9Qr+LOr7lpn0JdAiIfIMbK4TJboZDMN5+F5PtVY=;
 b=rN5N4TesVFJUwhFkSxBwTGQvnS6ldKumyfCYN2loPWE1Uc3wTR7Ev/9ylkxMfPMXyybh49h3bLHspPw6wDI3nuBi1s8wyXAVoglCDPv6VpLyYz9EQRs1XAFakLbLr8No2iSarV/aV1a+xIdhpgPXKGU8HtA63E6Mijt7zWwExQY=
Received: from BN6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:404:4c::11)
 by DM5PR03MB3130.namprd03.prod.outlook.com (2603:10b6:4:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.27; Mon, 29 Oct
 2018 16:37:14 +0000
Received: from BN1AFFO11FD022.protection.gbl (2a01:111:f400:7c10::102) by
 BN6PR03CA0049.outlook.office365.com (2603:10b6:404:4c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.26 via Frontend Transport; Mon, 29 Oct 2018 16:37:14 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD022.mail.protection.outlook.com (10.58.52.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 29 Oct 2018 16:37:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9TGbDSq009284
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 29 Oct 2018 09:37:13 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 29 Oct 2018
 12:37:12 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 1/3] iio: ad_sigma_delta: Allow to provide custom data register address
Date:   Mon, 29 Oct 2018 18:36:52 +0200
Message-ID: <1540831012-2758-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(8676002)(107886003)(50226002)(356004)(6666004)(6916009)(8936002)(7696005)(47776003)(54906003)(2906002)(316002)(26005)(16586007)(51416003)(5660300001)(106002)(478600001)(48376002)(476003)(72206003)(186003)(53416004)(126002)(50466002)(426003)(4326008)(486006)(336012)(2351001)(246002)(106466001)(305945005)(7636002)(2616005)(36756003)(77096007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3130;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD022;1:ni6L0o4XsjLAC1he5uHJGlxAlGoJ+EdyVsBoIHKj+SmjEFA0Na4SHANRkxOA4FZPnQTU0mSw+C76CoYj5kc7z9V6CG9oWKT8LopwkZMJVSp1LK1ot2msn0KgGfejvhZx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea74237-bb39-4399-6b92-08d63dbcc87b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;3:XCb0WwVHgDWvcaUiMTQ3UsicAPgttltp0IZWRWO1/UbGkHJIye/FKjGoStqyRrOgOjvV9WjXEAGQMQiaYSWhvFDJg20G4j1x24KoQcq6+3/LsJBXmob5J9IlEl4gqBFblYelDOHL/KSk8y7fU/bltlGAd1f1Vvz/zLV0MADrlVTzNoVwk+GSMehZXRNvSMvhTXtWfLW4CbyfRWYld+LdywENrRXm+ggp+1+IInvcKcVADftFypykK0vBIJO6K8WAsjpjOcWNV54j1WXDbLZdk1hv79a/Y3XwtD/ASeGfXYtNz2k5KC10Rq3e3XyaZXDX6S2nfqhXuwV+++56nQqxsSAADnX3RZgiqIgFoOXI4cA=;25:IcfRwq7yiEQ57VZ4RooJRROrO2WV+2TDKg3ZU0LFhgy+Z/hFU4JTCezhF8SBStFRsgRumS7YQ1Wj/9MTqIVdNV1jNnsciMFeSp69muy6U/yAVlPgdj6yCogDoOE7rSfjc+RFHZTmG5vspCJIBhbdGZuGX07OtmuDt0VHOoe7kepmh2J4Nyt2C4msGtS7j2BZvkqzO8BWc+G/kFl+ewgU+Q6OKwlD3SSx0XCHjYhW94noZB+JY5Hu50VnP9KCpjlAy1zUZ9qx2qizT6A3asbJkncc03BwtGm9F5+RConMPQMTfdGMO++Esg0vnokI5Ldgbu05LZsKXvqWMbz4lv2AOA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3130:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;31:uKcmyxG90IvvMvKFWdwPiiYpRKiz/IgEFls3rlcSSc107ed5vKsG673t1uwNoB/w/sFXmDBx/RBf8Ne8wwzB3Nd315yQM00UMe/Z/3DnMjilsPXM90KxN5EQO0x4+JFKi+98njwSSTdf9isoBguU3M4ylhVKaaV10+tEYRzKtCaG+4D2lly+QT8r2YPk8bzj8aoo6v/UUD+H6izJqVU3NciUNdqAud/YN5QXQhYDjLI=;20:RBnOtoP7fX1n7cKCRZGpgoFp6A29pD593/NRzr2be2XE2ADrDmWoJGFVbsBfLYBjbZIdr9BsmaSSkjnUF1GdsPuXaJPqGI3ctvxeXQxDhTkVP2kM4A90OUfdwpcYo+NmWXOmQdg09fSVP1z/let4Oa+fURe4JRznsYb/3m3P+fZ361OZMDcuYq5hpvbltcnpAF4bPGln7G/RTyTGxRWBy+K2LXZK4LNyivT6URrQWC0J+Ls2IaY6p2mBuLLfp/Gw6ipDaI3vDi+tI0cAzTOug5dyVQBO7iGZnFLetEnCEPYZbbkU4L9+sPJN8+oybGIYe+KZWPuOe2h48gcVIh/CxO7MVS/poAITC9pYdCFrMHMxMMe5RAjctNwLb3TJKKRlqo1emzJvHRYVEYISxzTdPSrGORBOA9nRG1eRz3kRtE8ArDdXwCW/d0m53MUm7FAyX1PA1df8Leq8ZWh7/1Y0eKLOcWSgCn3Uvvk2ZDZd7ijbS1RtYRzPbGFFl13PINEY
X-Microsoft-Antispam-PRVS: <DM5PR03MB313022C17AEB5F83605D03839DF30@DM5PR03MB3130.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR03MB3130;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;4:X7OQfDRKaiqpBuiiVn8BWWXN2CZn1cGA+Yzzpu4aInKSpG53D0lxOPuHTq/6JySqqEDP48H21TwEVcV0AAdNALC8kaU7+UhurCMuZDJhBwKfaavar5t7xM6XB0RuuPeJnGKfaDgcvEbPpt6ESrO1RLc8Gy6qZi9RVcSmo/1oKLxiNIQjI5LXfu+Si3vdJDTGdp/taQTptvxWvc4OlvEgjv/DcfZ2azIMyS3nrMDrVpm5Cz6Y2tZ6vaYVIdpeH+db8O0Y8bx5HjetOaU+dGbD/bVhCTfYlryWP4dmPOWJRNo7yY6blYWpYtDRYByFzb7x
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3130;23:q1SADiSqwhfSyZN41k8N6q1MSDD/O8/iYXX6sfKP7?=
 =?us-ascii?Q?Cud4Eknwq6oIa5XXenwEUAv1t0dD/aa+omcY0fh28y6G+LN3UQeb8eVYkmVi?=
 =?us-ascii?Q?DNBZdzuohVPqRsrCGiNQFWO+ghPVQ+VI4zYSuuiLTDSoWb0jlJZS7Ws0s8b3?=
 =?us-ascii?Q?Df8v00T7twMq1/VtWfww6GaGTlMULRS4OF5Pht5cNcOMjKRmDUpeB0tR3faj?=
 =?us-ascii?Q?Zotb8OuV5+qmcVZHQQNYuFCcVSR4G/3mbFhsNHhu14uJUwoOpcRatmXWiaoN?=
 =?us-ascii?Q?a4H43TIpHzrlF/2QI0QPn6iTwbT/WjuwHmKFoFOc+Yy3E4zpo0l66Lk0K4dO?=
 =?us-ascii?Q?S0bpc8A3qlvNxXzb6k0ATdg6kuK1f3u3+P89To5bTg1Rp4z6GRAaVXB+Vdhb?=
 =?us-ascii?Q?1i7bcVmDObyYXvzFg//XVTYqy0WLavtKDTbomYDAOR5W9fCgNlH+NsyUnPva?=
 =?us-ascii?Q?UtOOmehoYeF0QdSe7p4HitOfPobYBRWc5GXeBYsREzfVaT3mckDnMaI9gBp+?=
 =?us-ascii?Q?K9QYObh5/3J5j270AvAOO6LHSEZAwM+mxNWmmYnHZ/Ba57mADh8TNOREIc3Z?=
 =?us-ascii?Q?jWQcMyovfmWpxW0H0RN+qmVr/98a5sE9ksMD75BYHMCg4KgD+acsba9RXOep?=
 =?us-ascii?Q?JEoSZ7SCsGO+Z7lI07fp6AZwRR51H56i/aOcsp5pPLxWHM5nPvUPEfD3jX2o?=
 =?us-ascii?Q?sfy1s4dzksJE7eiJjRyOI+OAhKgwPnw1NhRgYZfv07HcluHyLMEVAzA6yYHJ?=
 =?us-ascii?Q?5VCmCPxRN3b0YMiuvjpHKMLZ4BaZn/HqCrIH6NlOIlBMUkDhZ3ZzWX/kagp1?=
 =?us-ascii?Q?20f5dNA3kHsEtPZU1c2ZBVAGZERiOFBpgrCg/yugR23S948x8WVyqDQfGTO5?=
 =?us-ascii?Q?bG9YBjevjyfx/ExOaPTSEOe+/j1M1KrzeLM4X9GhmEgKBpXnvcp/Qwwx+6/9?=
 =?us-ascii?Q?97qbjB7tR5U3JuPwBqo50x3fJqy9/58kFp3hBbsoNZ8/1DWRDBRL0LhXRZIw?=
 =?us-ascii?Q?DdsGQE1WJ5F/xbujWyvCAUaZvyIWv5WypzkVqoNQeDyiA=3D=3D?=
X-Microsoft-Antispam-Message-Info: OGxVU18gc8sJeMRNcjuKHmeAflV8l130jl5OtvUysnT1cbJgsKZ2GB7MaGfrle9Sje78ZZEdp3VbXY0W6377O/9N3rHxMpXyhZCK7qPIG6YkXYiTwWwfHggxQHulIEMF+qozewUPgR09hNnKA9/97hwO1zL2/bvNwLPHIEMwcAWp5eM16J5S3CS8sZRKc+HNxrcNqw2IlCTcF67gCm/s5FQV9C42XryZ/4oVxHju0MTGqn8lncmWzuUcJ/NywtWQZatmPWiUPqFCPNWJ6kAOoZ6xannZykrWXsY5fMz6gDPNOasUDknOdhb6ihry2I+tlO+LhuG+6G6smd+xfRG/fl369oSTtj/RisjW2od2VsU=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;6:I0LrU7BPkv0AUz7cJ6sKPSRGUirbQZ3Fr6Y/R5Uhyr5ToSgbuX0iUuqWymY+z2P+ye1zv6BEXlf+qZSsyzCTkPdznqZNl1DyXFHTVSWDILFgC5NdXdaucP64mc8eiO/EPvTCwHwpay1nCC5xcmpHo36WI5oeOB5q+yHjIc1WoXmv4WUvtC2Nu9DAcYXkW4wAnxl5BXKWb2opE+gmk2jrzHm33auFI+xVJutKbRSEziF2fG49B2i52C4me85moep8sC4P0a25s5/aWmPE3NAjJ9wAubZ0CaPrSv5cHs0sjUHpH1pQ1L/JEzArjhkaemzwrkukdJ8Z8tMjOzO14R78cLNQIbzLDAj+hPgegIHT5zvJoAXd4bxp2Qz9LTKL0AxL1bxvG+0Yxw3QcEAyoGzcySo8ovfU/6JjGu14XV0NAk9U1r0tQjSpgfvSy5tBJRnHjlWE4XgZeRstrowTiT/K4w==;5:xFEzAvyHaqu+5YrvQBdFfPMXbq4wEXiTQNxzGTVHOHeC4MpIsReOYYvzHzGytHSwt6HrRQofWdnIqdkNbEyMV60V75AFzSNHEPxM31Kq5QqdFQjPbhSYhpEvqcI/rrMSww4btJcLezEPXbEuuzhMh9K8WBs/2IE7yQCgBhtG8So=;7:Ms/Uzh1s5mUdFi9fOwSvJ1ygihUm/SP6NR3fwxVsNxKLhWg4aBogXGnEDyHevrofp9G85T6euOeZN6yB/BKi0ph05sWTDrexDJcCxPl8/kH8AjkT/4WBlBUOZbojLxEXv6VHPqu5yV14tw8W4F73dw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 16:37:13.8212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea74237-bb39-4399-6b92-08d63dbcc87b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some newer devices from the Sigma-Delta ADC family do have their data
register at a different address than the current default address. Add a
parameter to the ad_sigma_delta_info struct which allows to override the
default address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added this commit.
Changes in v3:
	- Nothing changed.

 drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fc95107..ff5f2da 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -278,6 +278,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int sample, raw_sample;
+	unsigned int data_reg;
 	int ret = 0;
 
 	if (iio_buffer_enabled(indio_dev))
@@ -305,7 +306,12 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto out;
 
-	ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_DATA,
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
+	ret = ad_sd_read_reg(sigma_delta, data_reg,
 		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
 		&raw_sample);
 
@@ -392,6 +398,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int reg_size;
+	unsigned int data_reg;
 	uint8_t data[16];
 	int ret;
 
@@ -401,18 +408,23 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 			indio_dev->channels[0].scan_type.shift;
 	reg_size = DIV_ROUND_UP(reg_size, 8);
 
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
 	switch (reg_size) {
 	case 4:
 	case 2:
 	case 1:
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[0]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[0]);
 		break;
 	case 3:
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[1]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[1]);
 		break;
 	}
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 730ead1..7e84351 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -39,6 +39,8 @@ struct iio_dev;
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
+ * @data_reg: Address of the data register, if 0 the default address of 0x3 will
+ *   be used.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -47,6 +49,7 @@ struct ad_sigma_delta_info {
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
+	unsigned int data_reg;
 };
 
 /**
-- 
2.7.4

