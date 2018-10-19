Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B4ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87362083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="UgSFHnJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87362083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJSPxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:53:15 -0400
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:37430
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeJSPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOS6LkwTXKVxhb8RkN9Ln7HrIDvsiT20hm48wM7yJAU=;
 b=UgSFHnJKIAIwvZVruY0O0jZ5sduMrBc/9rgctAhLcnluYszSFkmRE8oB8Qn0Ax14wKyH3ONH2k3VbpDRVkPnev4YmEMm8Dz5sfEgGLjal30Im/shBim1b1jsXmpFrPE089x0Hp1dryzalH20jNQwhhre+eAM1xtBIF6MtCslSiE=
Received: from BN3PR03CA0103.namprd03.prod.outlook.com (2603:10b6:400:4::21)
 by BY1PR0301MB1223.namprd03.prod.outlook.com (2a01:111:e400:510f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.21; Fri, 19 Oct
 2018 07:46:33 +0000
Received: from BL2FFO11FD007.protection.gbl (2a01:111:f400:7c09::103) by
 BN3PR03CA0103.outlook.office365.com (2603:10b6:400:4::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20 via Frontend Transport; Fri, 19 Oct 2018 07:46:32 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD007.mail.protection.outlook.com (10.173.161.3) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Fri, 19 Oct 2018 07:46:32 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9J7kWhb018724
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 19 Oct 2018 00:46:32 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 19 Oct 2018
 03:46:31 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 1/3] iio: ad_sigma_delta: Allow to provide custom data register address
Date:   Fri, 19 Oct 2018 10:46:15 +0300
Message-ID: <1539935175-8690-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(72206003)(478600001)(8936002)(246002)(8676002)(50226002)(106466001)(6916009)(2351001)(5660300001)(7636002)(305945005)(186003)(51416003)(7696005)(106002)(54906003)(53416004)(16586007)(26005)(316002)(77096007)(126002)(476003)(2616005)(426003)(486006)(44832011)(36756003)(356004)(6666004)(2906002)(336012)(50466002)(47776003)(4326008)(48376002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB1223;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD007;1:xFM6Wkzu4AOHZiVIf9nfJWbcEtaOKmhcGaXODi6Lmzd/6h2lZG+eDqGBeSK4FG/8kc2FP0j55w4pS4+EhBtfd8PH8cko7NQOi5DR4gSKmFgwFiMTvMnNk79y5hy9sIGL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4589269-3bcf-45fd-9bf7-08d63596fd1f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BY1PR0301MB1223;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;3:N0cCmjQHVNE/udv6y5hX/5yRTAno1Oh4T3ngypeR/Tk7gUDKJF4CnS3J2RACCq8279ERXcmrDVo2QdXaqiedD+3UPl/VrZ9ZGSEKnvvn5frDKXOeNS8bQF5UhhsP1t8jbj+swRgDc6ZDFWsEzJL6sz0jgE0NaEhclfFEwyXejdhwVC1dC7o48T8MriR7nUTLG0e0egcu4R9TfuTT5ZmWWuiEquuMYNFmoRYtKCzgjMqYN2RWPhv3NDBlladZMZUoeJtOigRvE+Hh3kyh+bRFbdubG2J7551QMuGM8pjqDDTcw9FVSvIO6Y5q9eyj7poh9SnMfF/AMUMosqe7Jjey2O7kzCuEg5sc09FPIBZKoeA=;25:EEq8pv/M9yAULC4DnboE6atzuiq4jYCXSulr/aEE3RZsoG6dIrA7qsjleZ4/s3RQvQSmIAVZYS3Xi1AKblyOaeojnTaGXcZ7wWKCuPP6mLKhrGPgpNUR2hopRauGxhlI5eF1NVIRmHgXMwyEPIt+Do1RoQlxK8TLh1rMsmbdsFCF7M7EaWGxRq8mBHb6SYQmXZxSS61jW2Kv1VSwnSBUyxmtfjAo9zIn94VXQfrQM8I9+n6LArK0MdpWb+vyyup2F9Vtu3GaFR9j2RPqlyPOYbe/ibK/TAbglXThOKb8t0W+3aBBROfrt3o7wAbCG55m6GRT28DglmTOxmdTw5vyUxbYJMknWWNOzSDIs3RZkR0=
X-MS-TrafficTypeDiagnostic: BY1PR0301MB1223:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;31:jHqv7odFgO1YVOI/Kx3i6mr1DiTCmpZ9YGp9iJhvM7h1zTZvWAguWiZbiSS16vzorT4sxmIstZ9gDYBtfSuyXG23nt/2dUFo95dIi6jzd84iMe7FpSJfSVCxWZX5nxDqC8Tciqzlx06c2H7IZDnCuMqp/u3CfgTTpDQh3hM+JogppIG5weteuM5l5FSDOBMudLuhY6oGvVXWx+ti1IBELMnKdAK/wk0Z3gGCUKSyuSc=;20:G9n4k+L2PHPjqFaOBUQDi9Avj2ICJjZiJy8SvZvJXLn+510WW+WhyXLQQadIX0KGJqQpae7W6WK8p3Pu1a967rgNQVjhi/vOpSoIS6vYouoaSXG6rnRQpSmlhb4pSxfOCv2zaSlwd5khmtfruHhrPo0UTS/nnUHkZRRdR+JZiqjdVRdHtxCt1pm2l7uEpVMXcOQWE14C0TjLJGdKCbuWhOzqg5HWKmbtNfIBvBrTQiKzVbAE4Jnzy1tAAwsOb+odpcc+/z0+XTHju+KqCiiIj0mfEhpAS/QJDU2zp1Ds8edDWXN7+akM+aPhX6ssQoUop6LPcZ53VKL/KaXDRhrH+4rtrOMr1r85iKvDPBrMkkQ4vX7Tvh4cNrr2l3El7NQW4RPC7WZPR9c10VaQnUPegrpknxXZwgEg0E2pcQ1meqJgy8NqiMMUpX5cRWdkpx6bZ+JUgbML1hwD/R+DUm0KMPSECArT98DIn0kRDcc+cTc1KdVbepJYNfVFKP5eEt6/
X-Microsoft-Antispam-PRVS: <BY1PR0301MB122373464BBC8A8F7A6259B29DF90@BY1PR0301MB1223.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR0301MB1223;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0301MB1223;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;4:Ppn1zOtC1n11bduhULivSqX3cJY9gFc5r2lHXnSBF8mgoUkZOnEsZJHgRFvMvODJ9ylCfNq7HXZqC0Ie4MGuItGCRGm8ilGbr/VFkM+pVhTJ6Ph5DcCcI/WxHee7wTR36445r2MkmY+ozab6eGcMlL6sNfBsN4XHtuXC9S6/CsmpCiMmT/DOUQGqZoK0Eh8Pw0r4yChmj8YY3aXgPKIgQ/e9oUh9ja1WLFrJAgPaO171JjCUDjVpBWJ59qDarD43Eod9ESjd1sHqfU99BVycz9u2H2UWHWYVV/jl4pRhoOSvcR/saZxqit+yZeMGJBoW
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0301MB1223;23:hb/chHVlWwHlBlUqh+s3t9jRW8CHeNUyAmcx2V7?=
 =?us-ascii?Q?EpeQCiHY4FBo3KDBJvC6IpL+2sMGttTRFj8ulWzumh7RA5k/6cpm1O+AMFI6?=
 =?us-ascii?Q?vRaXUmhfWXJaYkcknE8+6GdyYLbqBjrCllV6wfbdC+0l/OiCmcudj1kyozYA?=
 =?us-ascii?Q?R7/cwsNdA37wzKZcFzeTO/MA6tzk9vSOwasB64vwktyv+7wMbPR5MZCpdNwl?=
 =?us-ascii?Q?bY+9QDgweVYUbc8Cpd3XQqV/soIUTM1lfWo0Ek5mTfwxdpA87XcnHPoHq5Qf?=
 =?us-ascii?Q?mrqowOa/cOPAbEf5VtIeE4A1Hev7XZfoXHyHkAvWs+64OAp2C5kAfppTAw31?=
 =?us-ascii?Q?albngzC20xEWMBwFDkDEOalzgPgVqQSad89+uRG31WNaQEGVhs8RJVEOWAas?=
 =?us-ascii?Q?SpSnpAPnNkkUHlwEAdzKN7uej/Fy2GVO4J23QDA3p1/RyyBJhqldXFbj7sUF?=
 =?us-ascii?Q?5p4WQ6PKJTWI6m68L5EdcUq+zZEotBlkKy+wUjYkpi6x43otkNOosbzN6Vk1?=
 =?us-ascii?Q?l/fraqNQzWNDlWnI7lJi80ET9WxWJMVYEn23FfOLDxBYB15CakmgXKmofypk?=
 =?us-ascii?Q?XKgHwZsymg5SU3cii587nyMuKONFu2OnH2oLDNp++Q/8Nh7KnVFjvWdDz/X7?=
 =?us-ascii?Q?KURAPryVmjdsj4aD0Go5iteFRnHz0Ilz11WoTqA/ATGxFhOjfhDXBQdusoqn?=
 =?us-ascii?Q?bdQEA+OwkDsfQCDewItksYc0Z5Hjrk63ouCuU5fyaYWtdEtUF4DwqC3eO4zl?=
 =?us-ascii?Q?PPqtvGqLBCVHsazvy1GnON7A5zVfgd6flxHj/xO0Jcr6qgWeTiOEn8TX3mht?=
 =?us-ascii?Q?34Ham19D3icxCxVPHkc+CEJEkarDWozhHvUggE+AyNMaa+nFRBOy1SOF58lw?=
 =?us-ascii?Q?bmg/gJ9PYyfBO87XjSPVBoGvqemrpJafaCfu1nV+BqeWjH0MmkEyvyts3Fmf?=
 =?us-ascii?Q?DorjaE+BJKQu1A+RNodkehQjADOgdmNWJb3wFX/UULsbo7QaBBKZQrfJo075?=
 =?us-ascii?Q?0jhGUnGCQaw1pwRR/jFXr2VwmaA3xWx7lC3wTIAPoBbDohg=3D=3D?=
X-Microsoft-Antispam-Message-Info: J/8AfjD6kLhSWZ/Wc43z6XILZzulKzEc/8q8ggLRkhak86YaOmSIa0SLEybClFjWGFSwb8ZlYp3OdwAJ8I8+DJw7+d7SeZN2Cde3yFgNvgu8cmnGz7ZpLaXHVYHVlmgm01yw+iijLc603/WMFy+HWLngA7p9C0A9EJc5cT0pop5MT1wfsMXOS0Kz7Tf+60D7o/TSZIvf43OFTMPDcA7PpySeuZzRUhIoLS0Qd4+w3GIF0WBRI3kcQLfZHzS7dRx6N1iJJDuo+f/Ap3MPPSjQb3YUuurk0MJELFRU/ew1aVgKU4xG/Q/nYy5oUE+YOmZy/Dpn+RvZSP7LEzAH5JAaYgNxt1sTP4zhWB+X7kde5bY=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1223;6:6wwyKaJi6RAciC7Dalz0ChttjuTLdAB6DQBnx2bnomvaFzUmqqJcN0DswNJ/aaOYr5YdJBOYChE7w+TXe4SW7i+LhNL1vQj0iBTRqYlPEDsPM8fwtgmWyWuLNW1ZPO2kczgvomqeWM5mAx+2T2Ue8G+GUxmOteGWm5KZ4gObCVIcKSdxJz0epRvdnw2LgIsjmHvKPaAowp299G0563OK7WjbJS09qg/7xXs5x/MJcjfmykySjnm0cQSU5T//0uBkB+nu6S1ARDIsOQ9TrlHtOSbPLDEO7NqVlQZKHKAuvYB8LYU9/Z8eekxH+pRYBGLgN1c2NT3HaY4KTVDyp6/TU+7QjBXC67QC9OQtQwfVuehmHd/OrTCPZqLBv1Uk/6oLx+DMPeuv2IGDpr83rs+IdovkYXSi4kBpq5MExyCMq0qbUOv6MjoXDfvO0wfZJbgNJ9nYzra1iVmEQ7rvcQDlvQ==;5:cES7pvFYiPFmL0QmB4rLfRxq1wwDZdxrPZRGYOdDBvBd+jTGwnDLzm0Rgf+jJlzxzw47PHK8PSeHOn2XxByPpkCzKkuJe4fMPA0vYp12V7JMjQmgLApfphcNyZQPRulsnkQ+r9VjDevarl1OoyOr1syTcN/UkcGPOhLnhuGj72g=;7:6qxGQwhcfJIpSiW1pa1GhtVpBmviCMcX745qE3DnWgc17AaRrBhqm/JK+4QPi2ASWLakJFW95dmAwFG1o5U/A4Y3YcbGWgBH11lSiwz7I1eJzqZk6aIM2uzWN5tYcFP31/p22898lErL6GRfVeUlDt9NPnbVmPgjxwGGhkHsl4P/VxhUy0F18fBMhjnFXAQpVJbl9u1fFrIPKAIJNYsMIOMeueGWOa7fKEU7Ua5arnOzt32Kf/0z59wkCxXo1ziH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 07:46:32.6483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4589269-3bcf-45fd-9bf7-08d63596fd1f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB1223
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

