Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7541AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB7F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="n//BLKYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB7F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeLMMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:40 -0500
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:53856
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728875AbeLMMri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kfQi7bpIL69dfXpSz2C1J8eQ70byehYytxDW689bEc=;
 b=n//BLKYZ5D84s7hD3qse6196XTsVhz1JvxnVLv035MFN/LtB6W8WVWvdatDTEJWz1TK0ugTJv2vS2m6hOowywhRnniC9+WeJ4uiQrcVLVxt9maR8n0cn366iIpI9lAvlSTIXUhqk8g8Do2o2LMjZbTmyHj8F7kWr/eLb8yiQGj8=
Received: from MWHPR03CA0042.namprd03.prod.outlook.com (2603:10b6:301:3b::31)
 by BN3PR03MB2259.namprd03.prod.outlook.com (2a01:111:e400:7bba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19; Thu, 13 Dec
 2018 12:47:33 +0000
Received: from BN1AFFO11FD013.protection.gbl (2a01:111:f400:7c10::111) by
 MWHPR03CA0042.outlook.office365.com (2603:10b6:301:3b::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Thu, 13 Dec 2018 12:47:32 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1AFFO11FD013.mail.protection.outlook.com (10.58.52.73) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:32 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDClVNc004246
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:32 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:31 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 08/11] staging: iio: adc: ad7606: Add OF device ID table
Date:   Thu, 13 Dec 2018 14:46:20 +0200
Message-ID: <1544705183-13288-9-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(3190300001)(199004)(189003)(47776003)(246002)(16586007)(476003)(316002)(7696005)(8676002)(7636002)(11346002)(2616005)(44832011)(50226002)(116002)(8936002)(446003)(486006)(126002)(51416003)(426003)(336012)(76176011)(26005)(106466001)(186003)(4326008)(77096007)(575784001)(5660300001)(356004)(50466002)(72206003)(6666004)(7416002)(54906003)(305945005)(48376002)(36756003)(106002)(2906002)(478600001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2259;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD013;1:xvWghzzS318FO3OjZTVoCJTwLr43STbdLxU7/f+/3Mgq/45jbM1rDLb1R5M39P65U2t/eTDMzI0LsAliJTN7zCUvyxyJZo1/mV7ZCzuDpEO3kw1ZnJu9c12Ae6fnATUf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ec7bda1-ad82-47a2-805b-08d660f92644
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR03MB2259;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;3:sH/trkpkSUONhKOlW+Pq9vvRSRpXNsVhrr5/qvm82poBdeCSp1cHZQpByMhtwCtE+Rkqt9SVFl5echnA7S1XkUl+p0p2UG82XuCOSkw9vZDeNTMCAC8o3EWKVHutXha7BKTRhQ0Kcx6y7EN6iIxP/FcL+3HwrxcB+m8PBSgi6RqcHZk6Jd5flBA5oIPU3cfk3btyQpdP4kMcxVBl4+S+qrC2AGUiSZo6wKkSkvLvR7L3BDhroDYrzX/Aq5vlkPFB0BIbO2nsIGu0iyfcE6bAbm58NB1cUnISSVlAVYA8JQ/L8gTokD/BhyoV7jDWXk/FWDv8pxHT9Rl3Buxi2UIeKjZQTh3BmOZjzV2MXv2kP+I=;25:rIUXvDVNzRmI7NApcva6jYggr1MrKU1oXy6K/xR+MS6c0F60bl8nSWedyiiLp6sOfSZ1HVm96MtOMkd1ScZUxNifXHIJXkzT/9SI9S1AJLPypbPrwFrAr3JHM0ZRPB5qG4C9mFTyrUlLZYxufwTFFGmRD1tsXf8nrG9K3ECu3EOYJiBcs0T7q7pj15jfamsDrmmocRX8Houylq7nw9hdTb49V7oUqotfVpSUvn1AsFA5IsKZGyvMWLLMEo87mYQQwzqPU8KhLc9Q0/FeoedsD52F6r52AZpbrUAWfBWNuEB+8ejy0QDxVyYnbC7Z8GGiyEx3gw3UmF3t9+5EEPgm73NXyrw6Me/28TZLQ4OE49w=
X-MS-TrafficTypeDiagnostic: BN3PR03MB2259:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;31:MI38jS18rXHBxIIx+PRUa3jbbBxPBbcf+/y9tYtbZU5mkZuojqq1oFkYMfRu3OpjlnDqesj8RluQFc0ojr0PjCOnzMPp4ogt/o5Cil2NQcj3Ckr5QWW8WnRvBHvTcihRBU5phaQhkHu+hmG9Qb1BkRIgyH/cC6mfRFyygGqaCIEbQXCIayPLZH0zGdiZltwitLmMAI3FyceeeblAb/gYKvpR2L1BS1ihi4rtWggxEVo=;20:gMcbVRCJe26DxpSDTmFzdsG72hOIOkjKmUDm7gl+VoowYWz7RBjdIbZFmwoDBEBNvX+c6/AXoEz5LykZFAiqE3+nAkH4ZjrHgl0LJsXZU+id430/zPmFF8yTpWGlLnk5LXSnrbaoDHvsz7fWkvVepBYAoa4zrcJI58Y+UFIH0bGs2aJMs7DqAhtQ+DTvP6JwET9eDyNxSrnXOtao/4EGObEl6c1/Pe1lbNORSJ37PSIfJ/HDk9suYdcYoP1A85Ey7kO18P86Yrwy2l+TjtEHrKSk9a0R5xU5yFDZmXcp/O+NxTG3ULUD7VIbbvpwj4BVVFRyz8E8s5SH8hrkbHoGwGHyySNOvXM/c4+uwkR4zC+AJsRSeJ4nJM9wlDVV4eqR0U+vb8RN065U2gEQdw2ZzKiSzufBa451eNa+lwJHqsGSM8MwM/fm6Mu+vzosZwalp46878MVgqHg67KoyKYKon6pPF+gmOimHxu/l8DUDcRaMChej1nyDRin0kRnF/IB
X-Microsoft-Antispam-PRVS: <BN3PR03MB22591D83E2835F5D90148CF99DA00@BN3PR03MB2259.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93004095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN3PR03MB2259;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2259;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;4:ApgpcwQJowssalRePAFsUMMpsmped+qvvEqLVhQj0WH6wh0xaqB5u6DxfrgoLMkxByp3alDzeiC/IX9ULplBGEPEbFJRaRrYK2eZ8ftHsnYQzvejz4gtan3Ymkv0FGshCeULKEdckNPpxFR1+WN8AWGcWK2b0y0e/fMyuElRUlsTCtLqdlrgMym3KuE8n+QvIZkTLVg/i6TJ9GVjCySbjfW500sVR9hPxQ/WR86hBmaiOYeiw8s5oYAZCji8RSQwzDP8Az+7SzWypXkscBhvUg==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB2259;23:jtPWA1aA8BYJYhr/x1e3qEfU2xBzpnXy4rN/YhM99?=
 =?us-ascii?Q?U7BTN+HIpHmjQu6OWAnw7A/kPG89naqM77V0syqQq6X3R5J3GzhHIy7ncTMu?=
 =?us-ascii?Q?bFWTnExtkRrvYunobC214t6Yz+sjbPL5I7Zbm4PX7uyHIdxbH+gkuiCdbsQZ?=
 =?us-ascii?Q?mNIPvFSc9iTeY6dAxOreu3yJrzKlWxefdjP29GHIRJJIDshXjWusOQr+uyGd?=
 =?us-ascii?Q?bfC7hcdtmN5xSxt96ddvop1hhZOmP6LWNtB6X1kp98+S8nsc7VcMCI+detNx?=
 =?us-ascii?Q?oV2mRKXBeGRuqBeobn163jBjv36M1fN+ajzDi5QrOQIHNc0e2rpnPhruSaha?=
 =?us-ascii?Q?xswAxVDpCXTnEcxmZ4x+cXXDs1NraN0jrxmjaxNIX5uy4eF0V95Tn84T40lM?=
 =?us-ascii?Q?EkBwEGRVvWuT1OOOotbx5SRkX6zdxPtfjuGVoUEWjqlcLtOSJ12xTKowUXzQ?=
 =?us-ascii?Q?VPFf1i4P4FtfelQulTJeCIEA9tql0BurAgdtgn9Aszbs1mp5WvKCkqEz+TlY?=
 =?us-ascii?Q?z+yivMCZ7sK4BUtKTMwExDoO6LMuyNkIBmAu0QUoGLZ8/LOnixHWqxvT5Txi?=
 =?us-ascii?Q?4XG12aZvHXeEgek0wK6cRN/aC6aMMvV8FPcfI5YNIoHCxs7uXSohg1HG60pi?=
 =?us-ascii?Q?NiUCrYIuBNz8JO6462jDAHcG+ntrE6W8CdK7e92iU0yXG5RKlY+RbsaWx3o/?=
 =?us-ascii?Q?Vz6UHlNDmxZWUrgvBCw1b5OIzXEgd6RjyLY0s1YBkXsL87EIyThLwxByUaaY?=
 =?us-ascii?Q?b/sUPEz8J9Dw5hDnkQQXi78JdbpEOSfUrWyBvDXfjNm0Mw+zNSxN35xd+Hfx?=
 =?us-ascii?Q?AqIKqNK9FJPpaa9URttinW5erS8zwrr+KecEMcdnDkEAGS0guqi1Zsom7+NH?=
 =?us-ascii?Q?GkXfispNL135DbolBwn10tzo621KNWuzVZ5pvGDh/A0mOcyluDtzarReLORn?=
 =?us-ascii?Q?m8kv/Nr8AdswTf2hzto8bWcK7FDnCVPvOjhOVxff5uZXIv/+IBLQ388/qXGV?=
 =?us-ascii?Q?BHL4Aa34sszwy691yeFiUPPm1HUTAigbuqZx3nRnkLfEwLGhDMBFxOskZMwY?=
 =?us-ascii?Q?pRNvXJEpoKV/cHMNcAQPQQCOigjE6s9cBsIHQnDVUAS8Reyew=3D=3D?=
X-Microsoft-Antispam-Message-Info: 95mWSF9CpTnf6Ar9Dg2X2ihb4nb0a/0CYCiXVkEuXO31iV8rl39OuOfQuqSe+mYNRv2T8DQlvr8/4trcDFCxBo+lKkVZM3SVRq7IIp/SzSTrwU4AWxv1F0h0nnxm+kGJ5kdyWuKfK80P8LM6PwzopA9YnDYMggAIkLGnXm+GW8U2XHcQ10FfQE1bxDYAoHWtfHxeLEAfcDpQuPlmyFb2ppEHo7B+upC0swbUJ2eDTw7zoOtAq9hqECh0Ub8T7Xe+P0huuiC0qulkfiSEwYhzkmf3HCq/SSxmMixKdA3LlSNdFInB/IE4NglXrENzLdDQ
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2259;6:ZKOjbvZ/a+G20vTRSFed2+E2RPGNdVxTcDXCVGz2aRwZaCLNPLJT1isRMsPocoroyaNsHcG298SjAnBu+vc1ymCId91fqcmu536N2LrrsRhuCfc9bf0z37CFejveBoVIQqvU/2zgONups2Dqxgm3qUHh0BHdj0bLZE1Hi0yHuncX0jkMdY22AeVU5sE9a2yCrQmzYowES4+3SPbl/REnoLi3F8TV4DRSjwQRNmEopjnFC+XpXeD0plB3Ifgj8fkz8su+dTyrNjGirWiNOuapCOwGcIb1bIKILoDOsNf28E0dCeibRfbTzr5CZl3vkmErYDo3EW1NiVlD3REg8DrBEYXLVmV4Ygc8CUyix4Ny6x8d0rX2DruRCrnlRBuNCa4+SMs7FSUu014ZqTMHKXFa3cHpWZjRwhhCxsAv7vtwZUlPgytqWSIKUFLj6gxzkWaVzTZu9biM9Hv65xkhYaQw5A==;5:L5pCQxe1zRrrGVYfGCHbo5N4YwE0L8R5XymU24VtuteJS9hXUxRzwi3Hh/shiHKCYsqHs8LH9ZOKEQ0Yx+Gvt03kKg3+7b2UDqcR8kgl9+BLiP//DUtul03tS/gcJG5uqZ5vj2yyqEtjTZpxSwYgdUUWhlnL1k2rdDpVjonv+NA=;7:kP4vpigfOJ5kjl2yFSJ+5JOOJV6ln23e3PYJ+4uIwrGYJfbmB6GjbpNIIZByCBuAMl0OXoRjbL545So2b6EcvY78V/z8CHm7ZFpdE8Ujba6vvnwx01KBfcPEc3iFOXLohqT6uThdUDC/0C+eWu/pow==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:32.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec7bda1-ad82-47a2-805b-08d660f92644
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not have a struct of_device_id table, but supported
devices are registered via Device Trees. This patch adds and OF device
ID table.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606_par.c | 10 ++++++++++
 drivers/staging/iio/adc/ad7606_spi.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 6269ee7..ac0c7b0 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -90,12 +90,22 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
 
+static const struct of_device_id ad7606_of_match[] = {
+	{ .compatible = "adi,ad7605-4" },
+	{ .compatible = "adi,ad7606-4" },
+	{ .compatible = "adi,ad7606-6" },
+	{ .compatible = "adi,ad7606-8" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7606_of_match);
+
 static struct platform_driver ad7606_driver = {
 	.probe = ad7606_par_probe,
 	.id_table = ad7606_driver_ids,
 	.driver = {
 		.name	 = "ad7606",
 		.pm	 = AD7606_PM_OPS,
+		.of_match_table = ad7606_of_match,
 	},
 };
 
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 9291598..2608d34 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -57,9 +57,19 @@ static const struct spi_device_id ad7606_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad7606_id);
 
+static const struct of_device_id ad7606_of_match[] = {
+	{ .compatible = "adi,ad7605-4" },
+	{ .compatible = "adi,ad7606-4" },
+	{ .compatible = "adi,ad7606-6" },
+	{ .compatible = "adi,ad7606-8" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7606_of_match);
+
 static struct spi_driver ad7606_driver = {
 	.driver = {
 		.name = "ad7606",
+		.of_match_table = ad7606_of_match,
 		.pm = AD7606_PM_OPS,
 	},
 	.probe = ad7606_spi_probe,
-- 
2.7.4

