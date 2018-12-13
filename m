Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B5C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3205820880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="eVuHI5g8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3205820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeLMMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:05 -0500
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:24832
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729205AbeLMMrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxv0v0Czz7xX45QdVHton9R2RUNmWaM5Oc+MCB03C5c=;
 b=eVuHI5g8p+uPmUanKPXU1WwkzobzqiKFsbHcjvsJEtR5JYlwNMc4BZ4hLDGiS4tNRTW1E+coH4WsJRrgPUST8kUwjQNQ/JNB5N9ChiPJ5kr3WiEbWTAGP2+GCWlKTX2tyY73wwT+SUHuXZ1CjvylNUYidoCA91gGIJO9b5zQdrc=
Received: from BN3PR03CA0112.namprd03.prod.outlook.com (2603:10b6:400:4::30)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.25; Thu, 13 Dec
 2018 12:46:59 +0000
Received: from BN1BFFO11FD015.protection.gbl (2a01:111:f400:7c10::1:180) by
 BN3PR03CA0112.outlook.office365.com (2603:10b6:400:4::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Thu, 13 Dec 2018 12:46:59 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1BFFO11FD015.mail.protection.outlook.com (10.58.144.78) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:46:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDCkwNI004068
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:46:58 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:46:57 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 01/11] staging: iio: adc: ad7606: Simplify the Kconfing menu
Date:   Thu, 13 Dec 2018 14:46:13 +0200
Message-ID: <1544705183-13288-2-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(3190300001)(189003)(199004)(50466002)(106002)(51416003)(4326008)(186003)(110136005)(77096007)(8676002)(2616005)(26005)(7696005)(126002)(116002)(446003)(246002)(11346002)(106466001)(44832011)(16586007)(50226002)(48376002)(7416002)(54906003)(8936002)(47776003)(426003)(6666004)(5660300001)(336012)(2906002)(305945005)(486006)(36756003)(316002)(7636002)(356004)(476003)(478600001)(72206003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD015;1:pTfJsoi3L2K5IwbEa7EtrF8GTdDhu4DBYhJNTcvIP6K7/i3MTAhhqGN50u+ngjM9tU+8PZUse9wDXZ/c7/e2xwQSMsh7mLgK9tJ4oxm8Y7rjgicOlHpALtn9foi2m0tW
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61862f66-46d6-4712-310f-08d660f9125a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:juZxAJtCxmfx7BMR28iiQKWM6izNwSVYMa8z4anI3FVoTwfIIapH8a2I4HRAW74d9N0Y5bHaK0z6akl6GB3XAgAFQAvtOQ6U0E04rfuZkgOR7fLattJrhD3sNdG5JkUbUC03GpOu8mHQyDySXyLjp7EpuJT0Ei3tXxrvi2TgJJzslj9Gh0paRDeMrWeRgXTzUROgUYDsIvYOJlw3nCWheW5A6IeMjBgeKXFn91V7+jqtY/wnQhRvIMzSGQgVvmrF6HNnQWIabpHURsiL0O7231w+rMDwhFplwUJoDb1euF6puDS5ZWwe+YbqO3BQXBLhD3pP6YF9hYxU/e4HzZ4IOyAjU5R/XsxzasKtN3Qcbx0=;25:7SSl8qPH77XkM0KwuD1C+QMaw5IbuJi6OE9jO2ITDSW7U5sAgykXT7xm2VBJ2YK/EGQ0DfvYCQSqlRsPy4g3FzwzJQKCbLYISVV5o7dpuPsnNkAOJSwY/Oy3bw/ow4VqeeK+5ZLpt13RiZjdKvhuvTQe0EwIjvlZUsaITIFTAdhCisUZxwRqQ0Dtp3Tzn/8wwWscEZJmPndcJ1ybWJM0X8yWc2vq4tv2i37PxqkMM1p+8CXp8uLTCltpuFoKpWdI0Xw0mdok4RADBlBL/teXUtcV3Lfc4r38FxZpwHI5f3r21FwnuSkoS7jTe4TP/fSt3MZ5iSsrMBcGhkCVONhOov/YAWSymgJ9ec4KadzXKdU=
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:1jjldMzMOXSVPcagugat41GWxFlsgd7rcLNOPi39i/ViCiqirgMKntJIpHuNyYjihxWQQLXbZ3QMRJ6SiiUD6AHPWxVbnvdYlgkRP6JI3fezGLxaSTieFHCJaycoGs8+1rWLrHtBe9orwGdDBEPaqvNF0wohXRGi28INNdK3F6nVvWd6aTqFYChUFAZieumyXhAe3L2QMXOR/7YYSqo8jr7NSxdFZOAoCBVD3jtNK2M=;20:Vm9ZpRrZZyTFB4mh6v5ak1D3IrlWBbUwCARwiiuO7dWS6sOGHeKubC5NPI/sae3jmnSXYylOq4ujvSvHpocWfUT9KyoWRql+uNtlIky+JvjA2gMl5aWn1nMGzbo0i4x9OzZkasEpL3OFjMpp/ietyA6/Ok9alBDL5fuTHJQ40qNXZ483OKeLt1WaKhaLA0f9mX1cQm9PsyPljXjoVbwiGPSM349NWsPwRBnHzZLv/VLFv+sTGm6FH/CSQNZQmBZcD438sYV7nE/8MUnGDBfTyOotCxRQENEJX0t4xmdNbwMdFbfHFS6J2vboxjDHQi720NsP9pUmCCb2LP4Z9CF3CjMH1/BEXTN1g2bi5ZdlsBil/+9X6DGvFfVIsDaOBqpPjYpu4rJdGXFwTAEar6x4AvO5Z10mXRg97ieb15uSVIHtYqRpbqaz+cNpal+088tov4egLu33bOYtaEnbTwG4Tyqwruv2oaoU88sX5jTsMsUJzO8v3Vq5bdAo4s4jXzMa
X-Microsoft-Antispam-PRVS: <BY2PR03MB553337628A8B225FDF093339DA00@BY2PR03MB553.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:Oj1sA8NX3I4OPP2Zt8YtIzZP7ZkrZSosY5ctXsckjhPsZRh59FSvAs09HvM2pgwRqvho/zO9Uz4pqXzanEkEKtZ4vUzWr8bc7AbBnsPJ6XgAhoDAyuD5bcumOg9FpWoUd5K2HDGI6Bjmm47a+Rn8Glr+If6OEBG9IXg0AASuwtQSZ5HfsC1bfUqwCDrTh3yHkIT3ss7e/00Pjkyl5uclEVaDJ41jEAxmcCJXhvKwWH5SlYVB6Du+v77G525Ii5mq5BCVy2MFQzFPuCeGWFCbfA==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB553;23:BnMqWYtlq+rqS0PPzI/rXvnS9CnL3qVh19rVYFi3QH?=
 =?us-ascii?Q?2kAVT6uTseK5OeL7UOdRblSsavQaJ5e+f8dBoUkFT6OpMPYEpi/CDuJNzKXM?=
 =?us-ascii?Q?0qQU3b+6uv1VMtHxApTRZVgngimTC2a5L3rhieXTyTQzTQzevTUvbq8qGWVV?=
 =?us-ascii?Q?5uF964ZzGC/7k9UyQDOQKM0FHLIZw3CN2U2RMp36aUUycZSnfg8mGqPQCiDY?=
 =?us-ascii?Q?rxrgEyeXegkVXv8JRzuXNKVHmtsab4nydYlIJNE4J5h+HvAYZVxJleFw8uFj?=
 =?us-ascii?Q?kyIDMxIoe9l/ogGyDLLfILqYpYd9aWInPP1vldnbUdpoOhKIehsy7fAwnH7q?=
 =?us-ascii?Q?AhnjPVzVvyQEymGBzUzmqOqWgtTQPUf+hgt9ehPpH4qAKnZv3lgnJGrpZx4s?=
 =?us-ascii?Q?teyOSVDVKOFAKqkrO/DVoQ9JluRHtBGFVfmLhiuN0hD5e21Oerr2r+8ZEt7d?=
 =?us-ascii?Q?11KmgTTlBDQ2TOWYTAsVFB5NofVa9WOTT5LQkqrT9+KANPGbnqv2y8+jri9Z?=
 =?us-ascii?Q?2vviSTHbzfleoTUhZ6zlMBPBhlgJfqRGXBTGUYzddieAzb2PRgsnO9QhIb7A?=
 =?us-ascii?Q?KSMNdOl7ipS4xy25aqPrW70S2Iii/FsGUqYdKqcbzdibSPzb48JxkAmp3mm9?=
 =?us-ascii?Q?cFuAMGdP60I9nJJiUPPvvDy4hFpIREbaZEbjR6ACmFtUtwdLYJfdDfdbPNTm?=
 =?us-ascii?Q?BPj8v5w+90cFk+MWGU6EXymL6+7WtrJ5ZDrPWyb/wq9GvvUnwTo4spycvqS2?=
 =?us-ascii?Q?K7GaHtX1Q/m7nm6/L5XMAJldzPl19p87zRhXClKFQB/10Aplf8KUN1teJiKA?=
 =?us-ascii?Q?f1ZhQKxuRizbsPhuyDXE3vKj9gSjbha8DUoQO/TGuxkL+lk6fOOlX9DthFpz?=
 =?us-ascii?Q?BzUEMIZ0k3Fy1CVqB2WMGf21/PgboE/+Ob9md2oxBIbZ9OgkDS8pmh/0kboM?=
 =?us-ascii?Q?Kf0DAWcx+f7rgTTWtuHYEsJfrZ5E5IchSckW6hvSC2iMAKNVeNqnaE7aovX8?=
 =?us-ascii?Q?1ovTHv7kMtFoKhescekgpQtfpozXYHCXljPwpWKSnCxxB+JG8HqegTXaA/lM?=
 =?us-ascii?Q?LSiYMWV6MsU0/0notXQtDCuW8W?=
X-Microsoft-Antispam-Message-Info: 3hJbpozYp4i0M+X78ptb8aItXvUR6cDXLGaGHlajBS9V4yik81f86rM4cDWHgUwh+rugq2i90mx2S/eKpCFGvpJyIB9FnNkPZ0qFVOGRNn0utebSpizRIem5d8qW5vcTUJ8E6uH85E6jf4mQdIFO/6Q6fhBKoM5X/lk1rRZ3LDxF1wXVhEyC05clIH4LjjiHVKbLxb/CzyM5gwEgWqSXMIK1CnvXeOBTCUBfBly7+lSz7wiwnlA1AGNzKuJ+LWyk8OVjZtS7hTA7OqvhYobDvxDafmntVD0lgjezW25DbdSr56lxTT5ynIMyHCGB7+gi
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:pgRcK/YXsr9AKMJ0AMcMcetYxA0J8V0oXaHMQ+9eXjnK/QzF2TfGD+1/ABXcaFooxIkEciH9DDC4VHftLJSd2l3QDJ/yxccGpWJdfFi/MY0LLaV89f9TstreAZRIpmiQuSmhsUCukLZNFa/Wh3MGmcJJhafscUw/XPTfil0zC4ihPAlN6mn/ejhu1PNau/D4BlAmaq6IdbCcuf9jCxhot94AmP+CWOPLHRucIGfhIgfW0FAHqOkk7V8dphPbjukp70iFJ0g2u8AXK638CfNzVF9ttA2NKcnuCTjU9igOHO+7dR+e2LogetXeXc9d/9sWLL9OD4ZHGFvPgJ3yi2WF31YwAjxDgTu7WUdgJ7Nj/uMBlOHwLgiZmBegjH8ldmfKCPNYOOCH4N1eiaYVUrF6B/3Dld1rx2TouG84msfhzRJ+7hGFjnERXti2BXvLeGEgB5IbdT2DoS+OV8aILyE2Gsu1MBQ/VT2/c2CTcl41dQo=;5:grqJdNrnZu7e6wIuIi6zZEwwE/5Iz9hYX5l6rb9xV3p1qaizy9mcZCMS3NtlfpF1XnjHp8asZbXuQqEtlB9rpZMEdnjUqJBrr2tjwRecegPhkguztGR4oHWZEYnZmWBlKYSiNOavYReaUn4ZH/1C6AuGdm1GV7uX4nOwglgfMoc=;7:77fMaQPHudz8iI0uS2wgfuMd8Pab+PJbddObZvbtYwStCJ92LtLXv4sAb72bv82y2TccJxP73+TlYSuQgr2Q/vCVssnNsRNXHkCX2WhiqlVkQZJxKP8La3iN6NewOcmKOEYEIYcewqELIDO82jv9Ig==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:46:58.8808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61862f66-46d6-4712-310f-08d660f9125a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in having three menu entries that can be selected
individually. Instead, the SPI and parallel interfaces should select
AD7606.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/Kconfig | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index fc23059..af1bad8 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -4,35 +4,29 @@
 menu "Analog to digital converters"
 
 config AD7606
-	tristate "Analog Devices AD7606 ADC driver"
+	tristate
 	depends on GPIOLIB || COMPILE_TEST
 	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices:
-	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606.
 
 config AD7606_IFACE_PARALLEL
-	tristate "parallel interface support"
-	depends on AD7606
+	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
+	select AD7606
 	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
+	  Say yes here to build parallel interface support for Analog Devices:
+	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_parallel.
 
 config AD7606_IFACE_SPI
-	tristate "spi interface support"
-	depends on AD7606
+	tristate "Analog Devices AD7606 ADC driver with spi interface support"
 	depends on SPI
+	select AD7606
 	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
+	  Say yes here to build spi interface support for Analog Devices:
+	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_spi.
-- 
2.7.4

