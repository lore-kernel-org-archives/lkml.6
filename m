Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4823BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="PqDjhdWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfAaQV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:21:27 -0500
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:47008
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbfAaQV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj7LCDbGDIjlXuvjPf05VdTKsSWFjwzxXJdqxdhtv4g=;
 b=PqDjhdWmVCLXQa0YRH58sa9D+Z1h8l5CfS/QtCaT+ET1dXlrhz3tsDte9L/C/rVRaMXTlAwubbxnuPhMaMQ1nJt7V1hwBsCWwiMKuvM9f+pExpWPp4s53MlsXq57/hZRiN7Fm39ECK/95YGAHUG2+O+qdR/2gg2dMW1g6WvbdsA=
Received: from BN6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:404:23::31)
 by BN7PR03MB3747.namprd03.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Thu, 31 Jan
 2019 16:21:11 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN6PR03CA0021.outlook.office365.com
 (2603:10b6:404:23::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.16 via Frontend
 Transport; Thu, 31 Jan 2019 16:21:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 31 Jan 2019 16:21:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x0VGL9dv023460
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 08:21:09 -0800
Received: from linux.analog.com (10.50.1.104) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 11:21:09 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 1/2] iio: adc: Add AD7768-1 ADC basic support
Date:   Thu, 31 Jan 2019 18:20:51 +0200
Message-ID: <1548951651-28405-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(8676002)(4326008)(2351001)(246002)(7636002)(8936002)(6916009)(50226002)(36756003)(6306002)(305945005)(53416004)(107886003)(106466001)(77096007)(26005)(186003)(426003)(2616005)(336012)(54906003)(106002)(51416003)(7696005)(356004)(47776003)(14444005)(316002)(6666004)(486006)(478600001)(44832011)(126002)(476003)(16586007)(30864003)(48376002)(966005)(72206003)(50466002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3747;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT049;1:KqavNjttkm2r+XSa1ghtG54KmkqFJPOdPAGeM43sngiH28cCHocJiHEj++bAo8PlZrKV8UU1uciw5Qq14Kzx+Ftu5Rss1lsz06MODsJWHGLZPGjBfICUCLj3Zi5z6XxVML63B7ElwTezSOMp9cKwgA==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8cc8619-ad76-40fa-e61c-08d687981ccb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR03MB3747;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3747;3:jGIeIdsoJrYs4zk2hhifoGO3io+9acTwTC+czY9sQQ0vgBM+rkH7CJ6eEi1qZPiha5LWLTyesFhxblnWiRR3+wsb/mL+PCdqsMwLGJX8m5gXmB4A8rhgd3IP5XHGDElrUvjXny0TM3JUA64n0MFI45NwYKgBLiyBm4P2oeThHR1bvQFmjrJZL1KHljEOcSYjkkzHghZGHGPdJ77rsKc/ODY9sn8ROwXAZQIXeTTCYGGREk+E3maaahiKeKMlRa1B28OaGJ2+j+Jc8YsZ2G+0ny9gP+4nzhViSAT6xqcwnn5R0+NW/OwNzjQyRXkaW8DMWJHXCU7noNvS5g/kdcMDnj4QLsqZpq2s9N+wNCoJQMFfhRx0FNFwhLIeAjpfNyAy;25:wRbETpTHUUzFrpeL4gSy9aKLqAhjosh7sWU161q9Co1p5ui/x25B62RfTT7isCDWNzxqGyeWu8lQWh/VfxxJgYUmanZ+tIr1x9BZ0oSkQt8RLubY2GC8RTgy5bV4RiCSZ5IWoo847U5D8dVsvOaz3UBJYI9vSw+hwDMMOyFrt5Ph51daBAA9nhvARFZFy/DRb8ozxzmvpyGdduT4pzoFLlHmwCvEAAC0KLJo3rmQGp2BvDdYxhy5vK1ELcClfScAsa5dR1Qi1EfckYZPlQUCPAHzoOX/6QWmEZEpRYU3R/iRNoKKlyLuKwQa3B66zIeAFLtReJ5S3vBX+Ff4pLtQew==
X-MS-TrafficTypeDiagnostic: BN7PR03MB3747:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3747;31:LnkNLV5i69PHqDGw/HHRjkHUCTlgTZ3q5kr6DDlS2d1OG/4+n51nDc4yhT7PHqXlZo3nT0J/pLhEgU2/j6s7E+QbA/TXddivX4A5ULwgjYoSVwnhsFST+FRObfigaTM0CmLjnNyvcmK+BSDn9/yRrwHJDpgwRBQH91myHDlmci2L0JjFFLB4iN+pOoukfQafI6cGpL/WNM4FqOvmT0BSuyyBJJIMoZ8wlon4s5kgE2g=;20:G6ePBi9Sqei0qfb/JYIxtJwaLZqpVdyrT5Dh7omzWGSLcciZDSlCjYeryDn/ymn+yRj/ndQ4v4kLuM7k+czmZvaFsaxBCHM4HhGMpM92EybYSa5d1oSFRLBCmC3RShCYxGz02Q6sV0+pbQqYnrggwjBswtBRwMqz1c9dPZp6CJYlEIfW90kF7qCWVgNnMaVPaNg1+06cWmygoWOMVLBlLr287iO3cJ7Bz0xcsn1rCLU+0b3K+68bbNPWCabkgzPTzTtUWT9IU+WDWKhxFY+Su0RgZLE9P6Ufg5dzjzRscm0nAUJOcAcH1AEbWwJ0FM1IB0cjxugb3mwLqYeHoX71TzWGZFwVlAMp+61zqKPb42wysDYPLA60y7wo1r0wFvAeC6Bu7fGag2p21zaQQOsELsgDNV+aBX/eJzdsRbwcupwgbMEaYeSc2DkzbjqJDnqVtem5CEG3T+wgkX1/772cdSknHHprNJQoXEh47BRgcR4qWy+qsutr0YkaUXGxfQhp
X-Microsoft-Antispam-PRVS: <BN7PR03MB37470C0D3CB4971C0DEBB03E9D910@BN7PR03MB3747.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3747;4:mVbi9LiwHI8wGko7/GYLBDtfR0tZUdLFUJrhI1SEQ15G4GoGL8/u6Ys3NPdX8TippQ1Z193ItHkaCB6XPvVuDfxQAJ093tS9kRjlMujL0frI6soHYfCaQYDWV40hFDQtJRDU4bXwZupyVGJyvjRiuSeO5269MsMjx3499G57u1agzTi4sC8boCeTzAgve+EDAY6ZNPCw+5wVjP/UkHMYg9bVCx65STfBZxIr+CuBP6ZGnLKzRoDpdgnrAbJRAt+U0EtQABhsRlFXzcrjTnMr+8NmYe/OTKakSN+/mF96QpI=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3747;23:susSVzZ8YeAaCwpbcy0FWYQtZYGnJQSVuru1jYpns?=
 =?us-ascii?Q?N5AxNBo88sXnAOh44AmAAi6ZPFE72RX57Wf2fLtnGGocPjdEf65nOmqwJom5?=
 =?us-ascii?Q?m87KAUYdAtLTizfFC/oNM7PzS5+tYjcUfsJHFDivuxPV3zmVGfbjB1MASVtc?=
 =?us-ascii?Q?7zE7wIid8JL1W6ZnKb9YZOWWtWaN65g8mV5efw7ZoOVaZKgRdCtcSOkr5y4C?=
 =?us-ascii?Q?amfQBHi/RiCVl2GP9oNs+r5o0mpYhw39oRWctwkgmayKJfNy9KTU9Uob/weg?=
 =?us-ascii?Q?cYNIPUcNlTfGVGHvl7BOPMHx3YcrEYNL3Ff/U7JLgUgRHMGu8MwLUbK7jOxW?=
 =?us-ascii?Q?aewe/77s9uf6jqg3NVdV4egdCM0PaIKoDQbOX0+Ni41ivb84WN1N0/PSqinM?=
 =?us-ascii?Q?Ru0lqBQjpPeY/n6GAsX+uBEkGA5m+aDnHMwNsnh4XmrHGqdBPWKuEaG6dU6h?=
 =?us-ascii?Q?Ykx8bp84cO/yjpIgYyy0qqrMtJ6Uqxe/56UUxnbFgGODYbCvmGPwJi9H5K8J?=
 =?us-ascii?Q?HuyB2obyts7Ttkp3vV/aXN+S3uOzB6DelFT5E9xxJupbs4AIWfngbX3mNR3q?=
 =?us-ascii?Q?MGssIV//7h+CEEN2TFgTiDygRR7H3ITj39IF4nDQ4+gsumAlGxxfmBPI0BMi?=
 =?us-ascii?Q?nbODPMT99xih/n/bvW7XzH3g7cpKhdfVl0E3qOQ9M6ePqnsGiSHcBYzBD2md?=
 =?us-ascii?Q?RW4PskiEU+bog7TKa30H7QIodaMuJ0tTPiN7Za5kKdT7i89nU6D+O3U/e4E7?=
 =?us-ascii?Q?fn+wLcfJPr4uAUjrR7m4kEMKr41WfP4XJ1BFOsYv2xyHY2ibiGv5hxgmzG2f?=
 =?us-ascii?Q?vaxWRyWKm6WNYuXlWccIPBdGVLGdqv7wLPcW0k6AVjf9Monv6VJvGJ1/Q5Za?=
 =?us-ascii?Q?rCz3UpavXAL1Eooqp/qZMaklW5Rl/8hNVJv70F037SIS2cmCYweVF+87J86h?=
 =?us-ascii?Q?cXFMJsAmGNj/78j9G7pdmD/2/lta99C/7qqVIuMkxX4L7CfHl0yJ+ybzzTkG?=
 =?us-ascii?Q?FDzVscIT244khbHz5Q7KkKVovJlYWx0AagLAYLoYy3+5QLTMNexL0IqcZmlr?=
 =?us-ascii?Q?rYVDjF2F+AO62TXG3y3I+GRSlha?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EpJNFLnP+G6fLakyAKCZLfoEdKEIPGAF55uD6CiJ5xj3HV2xf+T6Db0p8D2dSXEWYfHE0Z3cdws6N5RKOJT4SoU5hVZoA035rfAQ6KbG+DFJtZPFpGZ103JbzE20JfIjwMICbSJ60utcWoFf1tVeow9XatOdVOmB+VyPSBze2DuEjLoq8UjU8W3F/k76uy2XQbwCSrJvxwUjET++SYsWwDTPG4LB8lsclYalYblvfS0dIeFXJK8OCaz6YTUX+uL9NN8t9ibUH0eIf88jOQTaVWPkI2IxsxDsW80ofBk/w9YQtM9+lPkM+rCKr1XceP3Gds7hnz86ovdiN8KzrIL1RtXvL3cBGTiHaatXrqb1ldMtfA+9b/3JMOhGtCX9f/WNt3tBEFPHuQbHxfP2rKDNBaBxQDjdEjUTCegKibqyBYA=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3747;6:EQ+1i/WTVSfwQJjuJJaGlE0sJhrPQIvw9yWM3E69OXAigKN4arRJUPC9PDEOAPiMgUiFclck3ttd+qLq9+oswRt3a/xkavpIgCdP5pLXyVJ5k/0FD4z8AJl0Hsn9ZjcrdNeOKzQuc67ST7dwdFyini3D1ODEMzjYgyT/qQRx0cu39NTRzkqpK3MiBu4ZhUmbD47qyYvNLR30/SjsU8PgUBEj6KNX5hHmJ7zLgmgeXsi0B8OH0Zire3+Ik25dVwokRrwfxca0BLihQ5eMYUnWhLzuG0ZshVht8uMuyX1Ui5/bVmHrVLh0HARYALq7iNecjyIGJKsibjDUOaDx1QcJ0zM+fLWKizhR+FwsGz05E1i1TU0UBRjUWoWagzi2puEZejcL2defXkFQvkWie7W4S1cp0K9Teqg2M1pGxkhbEUr/jxJnVVLRucOz0F4nSH32SK2NEPhP6qAT/8lRAHlyvA==;5:0k6F0kEKB9Tz18HIDYSFsMX+CqffJIqqh9NSRD5wV1b+JX95Sr7b+3RroCXOmVX6iASYva3v7iE2OChmAXFq3lvMfR+UruQvvkfdXYS9Q0VBNsCNarTrR3of8dwjwURXieobW1Fitu1dQoO9SAFMmxdrll4LkISSao+DhX7ML6NoalaHjXxtJ7PpeBqtXUsiFSLq2ice2V4yWm3MYhlNQw==;7:/LC3L4vzii0lk3WF5B0Mwuv/Cpz7nA0Oc4T+RontSmpdGA4e4XHdGkkb6KRllN3pUqZVBPPMnDo90yENoOWbpi2wkmhMporh5QnC+TPrVOPP/gnyka6grRJbEZLQA3HKf2Q+gHmdcuOIpi6rHDrsvw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 16:21:10.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cc8619-ad76-40fa-e61c-08d687981ccb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3747
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
Changes in v2:
	- Added values to all the elements of ad7768_pwrmode enum.
	- Removed the ad7768_ids enum, as the driver supports only one device.
	- Added a new data union which is part of the ad7768_state struct. This 
	  union, now includes a d8 field.
	- Used spi_write_then_read() in ad7768_spi_reg_read().
	- Called spi_read() instead of spi_sync_transfer() in ad7768_trigger_handler().
	- Used the devm_request_irq() instead of devm_request_threaded_irq(); called
	  iio_trigger_poll() instead of iio_trigger_poll_chained().
Changes in v3:
	- Changed module license from GPL to GPL v2

 MAINTAINERS                |   7 +
 drivers/iio/adc/Kconfig    |  13 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/ad7768-1.c | 459 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 480 insertions(+)
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
index 0000000..78449e9
--- /dev/null
+++ b/drivers/iio/adc/ad7768-1.c
@@ -0,0 +1,459 @@
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
+	AD7768_ECO_MODE = 0,
+	AD7768_MED_MODE = 2,
+	AD7768_FAST_MODE = 3
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
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		__be32 d32;
+		u8 d8[2];
+	} data ____cacheline_aligned;
+};
+
+static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
+			       unsigned int len)
+{
+	unsigned int shift;
+	int ret;
+
+	shift = 32 - (8 * len);
+	st->data.d8[0] = AD7768_RD_FLAG_MSK(addr);
+
+	ret = spi_write_then_read(st->spi, st->data.d8, 1,
+				  &st->data.d32, len);
+	if (ret < 0)
+		return ret;
+
+	return (be32_to_cpu(st->data.d32) >> shift);
+}
+
+static int ad7768_spi_reg_write(struct ad7768_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
+	st->data.d8[1] = val & 0xFF;
+
+	return spi_write(st->spi, st->data.d8, 2);
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
+		if (ret >= 0)
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
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = spi_read(st->spi, &st->data.d32, 3);
+	if (ret < 0)
+		goto err_unlock;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.d32,
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
+		iio_trigger_poll(st->trig);
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
+	ret = devm_request_irq(&spi->dev, spi->irq,
+			       &ad7768_interrupt,
+			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			       indio_dev->name, indio_dev);
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
+	{ "ad7768-1", 0 },
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
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

