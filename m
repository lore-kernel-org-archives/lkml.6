Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F62085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="qfxeodhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfAOMdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:33:36 -0500
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:36832
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729481AbfAOMdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZfJV/ZUVJlyLqCdds4MIpPEbPX3mFiYzN38cqc+Bwc=;
 b=qfxeodhKrFML+MR27WNHta9bvDyDcYXzwA0uMsqILlULh/MLR0wzGca90pPQPpLPO71UNYA947DyeRA8eSpMMlnbPCG4LovIj9E3m13idt9U5YQXRDxFq3FI6ygSSD8M0dRHG35wi1NIQXAjHyMJ1QK27oFp9He64xgNpE4mNfM=
Received: from MWHPR03CA0060.namprd03.prod.outlook.com (2603:10b6:301:3b::49)
 by BL0PR03MB4260.namprd03.prod.outlook.com (2603:10b6:208:6b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24; Tue, 15 Jan
 2019 12:33:27 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR03CA0060.outlook.office365.com
 (2603:10b6:301:3b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.17 via Frontend
 Transport; Tue, 15 Jan 2019 12:33:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Tue, 15 Jan 2019 12:33:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x0FCXPJH007666
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 15 Jan 2019 04:33:25 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 15 Jan 2019 07:33:25 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 1/2] iio: adc: Add AD7768-1 ADC basic support
Date:   Tue, 15 Jan 2019 14:33:11 +0200
Message-ID: <1547555591-2048-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(486006)(54906003)(106466001)(316002)(126002)(4326008)(476003)(6306002)(246002)(5660300001)(16586007)(2616005)(426003)(336012)(356004)(6666004)(106002)(14444005)(44832011)(30864003)(2351001)(2906002)(478600001)(26005)(8676002)(305945005)(7636002)(51416003)(7696005)(186003)(47776003)(50226002)(6916009)(77096007)(8936002)(107886003)(966005)(6346003)(50466002)(72206003)(36756003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4260;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT022;1:fjdbjHaG8eA6AhYu3uCVWWnCuRXcNxiI4zV50kszbwZ0k+KAnURHB3/WX1r+PKjA1tU8mdIvU2hm0u0lACCRsRVz4AUbP9fTMByRBE5xUtuYFZrQBMvSUyO0FlGcajCu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 226c99ba-8d59-48bd-2dc2-08d67ae5a622
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL0PR03MB4260;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4260;3:oV3dg+8x5LJyNgYe7q5bXMth9vko5Dhbk0zWNNgnjpECbQu9nrGg1rbvtFMBm63hy9NOcJ420WClw5vJIqjui8vcfbwwnn0LUqQBOEjXoJXlMwF4da5ojqULAWp+g7gr6EDHW5qOtxuvocP8PwLx4R6F/Q1Rl/WkCxSBp3XHHpTAs5/Y2vVeQOlU2MuyZo0UJarhAOFfZtjjba1CYo7dPwRDjf76VZHdyeEnnzl+gY5qWq/Ccr9j2ex4h4By0hOcoBU6PKuup4lyCkTVAu0ww4FuXROvFDz6bFDmUr7NbY+fdOtLSgjHe7Q96f2eJyzUcIDA3b3FFkFMKASknQlv17IEfo0oEAwzHHvogNC5OUTQTir0cG9RU970xzm6t/IS;25:oJJNqFC2U4gHtUllNNxC2lBL8vxPRVHJimAttifFQj+onvywMcy9V9vVytN4m3AF4erKW+TDod5ZXWNdShuNyuPNwz2wo4EHdiKUdFB2P5s7PP2FLX3Nx2QBZjySmBOA2TuWTRw+chcmV70cMmQqIhiXQks51kbjBWhN8D6TbLo0EvBjI0DSzudbEuhWzyKItM7NVQG4yy1eKsu69p0Hti73M5ZLiPR2eq2a7WmBjtu4XubIS3WOaf412QVZzKDO7jPWOKzhRSsNP9f1Gl6S/A8QomimjIdJc22rVPP2NwVB7RjUvT1+/NDwzzhxUAjr5v3e5NsRgSPV3uDjocu4hg==
X-MS-TrafficTypeDiagnostic: BL0PR03MB4260:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4260;31:3XIEYzLqSEUeG37X/nyz5PrW3VjjFiaBfOmrf+164+YxDMUz3VSA5G6FXq3tO6qZWUUmP7FlpyiUOd+5w/IYcJ8X6SiujiqTdx6BdRgq9T3S28G9AD9azdTp+d3NbDQvyqyGyRYYteiJy1uB8vU65glWTSZHPUYwnPeYHfnC0oiIMdmIjTGXu4SSHIpOKZoEpHnd7Vo5eorfEaIt6COgsB/YoP4uRXEdNeIBotgHYU0=;20:NH7+BPmKhvCmEiK0QGNRFw4knt1vMmuSchLVBWJM9kXPVzU5jOQwNPn0XVCjLRanAUhDhlpF/ENYk2+SCVixyo5oVY6NfZYOD7/+Ezlfmcttral4EUGJf0vMHo1Qf83WRt3MxC9APnKymArf3+/poHf/WrHiHEnd+NeM8sIEI1Csi/pqmi8oN/J8fAf8LqRQFX9CjlfLotp0BTFnISh8PKJE59FqzJc4t0zQExa0062xk3nqCIq1ClXUxLj+8A0JOVVcllhmnYatAU+7OPFFKHAgKHZshXMPOyK7jcRg6qhHh1zp/wba8MHfCLTN0rzfj82snYbYVskbNAiWmtbbbsjYDtm4WCR9TMGsGVsYd3y3yNmtIr+l4O/0yqB1v2c/gHZskyrHSZ2EzVKLgbJpW6NbvpVvWM+5v7mdmD6uoLPTFtlt3LmtedH3bSN8qnIjOE7bI02qee3gRBcYH62CVcLaCltEn4eR9uJB5xutE4xgm/wbFhtmJo2+jqW3KKrO
X-Microsoft-Antispam-PRVS: <BL0PR03MB426042C6022E0B159E6823149D810@BL0PR03MB4260.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4260;4:cmZo3XUC/62Tseyx89ykM7Mz5y/gl8xCdfoQD532KBCneIi16d3tJ/Z0CynxYB1lCNM6GNrjDwGhhNT+6K1bPl3kipWptkUY8byAQkBEJZonhTR5RAWN0CLQdEMUjmcztqaDIy+C3qYj8tCpGh3Zo03sVQpe5rafon9QFrq52Yy2UCcRFAivD9V/Bc+1BZEcJ29augCWApOyaSblXla28jK0j6oKtZbdU+ohKPvIHw0FmiwlWPtZeb1KItwfk9YSr20HKgANEH33lAyLfvufxD6Wc0BZtW0p8S8Zro9UYBw=
X-Forefront-PRVS: 0918748D70
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR03MB4260;23:CQVSt+jFEfX8MLxARJjYixeJKQQg/2pdVNS9bVT/e?=
 =?us-ascii?Q?nBWhIoFZ93zxG5JBVv3X9KrvzjFY5KuUNG9KJmlds/tqVzaqPS16DEkXhJqQ?=
 =?us-ascii?Q?YPX6IRYA7EFLT4fhfOHSxMyU6c/ZA2BCUo6aYe+sAd9FjxCoCb6iGVfBuMNd?=
 =?us-ascii?Q?mUQbYk+hCcn4lQq0mycldnGu0BxKIjjixWTPY5u3zkLt9Ogk00cUxdNIS3ko?=
 =?us-ascii?Q?ZbQhd3n+sN9PGb0BP8cHRuQsUEV4/NOKW/YlmcSbtcdcuFW4wjhu5pZcsTH8?=
 =?us-ascii?Q?lGMx6a/RkL0XAj/GirXC1VA/OQljXhO8vYU17sjUV8Xew8DI4O9ewied6IMC?=
 =?us-ascii?Q?ZW2onDbjzcfx0p/UkPDyCS3JoeZHkZnbAQc6l+ucrA+rX9zV5MGOX32/H+ix?=
 =?us-ascii?Q?PtsGjHwyOOpxAGI0x/dTUfoMZ3p6kpq2jyo8cGfiGbjHTixS5YNaXDcApUCN?=
 =?us-ascii?Q?XSdu5I6q2rZcdqJDzGVMQ+/GvctvoQuHBdML1v114il0a1ApduWJilwTUjs4?=
 =?us-ascii?Q?m7KfpETRVKrmC3/3CyZGFQPimfatXGrCWDFMK4G1O1Lx9FebGTsXlAaK4cjF?=
 =?us-ascii?Q?BilS8FxrWT6RFobBSo4hJn+V7wO60U5A7php05HVkv7XZ4RT0bdgFeBYQTqR?=
 =?us-ascii?Q?slkxKW98Yoyb0zRV7i3qP8FF0tOiFy4SctqmG03q4tT/oiZxpBs+Ckhha9mZ?=
 =?us-ascii?Q?Rwg365CArBEPxi+cF40EOUQe30JuqM4agciREIx7mNbTw67rBbii42r5wtSY?=
 =?us-ascii?Q?ujZSdNjrZfAMiaPsz+4maU9I4UambpUPRCaCAsXHMhDCHJ8CZC8oEW0Cv6tv?=
 =?us-ascii?Q?2Ca6xTAMMrmZVnrJ3sIsq9JomPyPIaYH04ul9F0UMWsqj8FSJXj00v4aoP5Q?=
 =?us-ascii?Q?Kzkj9wlgd/ZVoiiT+k5qYo47RJoqlOcXR/PqfjYDjJmgiW00Z08lFDxp2COP?=
 =?us-ascii?Q?5ySP3hyk2w8JmMwJ5miP/SCiQcMW/izfarKPhnzPs47HvCdTBqu/CVXicYQ4?=
 =?us-ascii?Q?yIUXtv20jbEZvy0Vu/AGReCAMVBmaqy/LdoHd1EgoEqSwiRp4j1rA4mr1M1I?=
 =?us-ascii?Q?eoOyc6EHHB3ojH13S8TcK4KA2nZwxXX7RgvfcxJEKVTi9Qz+A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: S54My/4fg+5A3mHOuByAS/9mOGF9Om/jg4HENKRYNUm8GzSzJrlwYO+aKXEkmxd0Q+M84A7s4A+xlC1LJzRfDYlDcH6zouKAzWg1ZSwYjuK7yaqfDah4vaP9bJ2vaeODwdzsZUU6mABEDHyMax1CDKDsfQfRZeLkwn0bOP2eebPk5RjG08GofQgl70tUSHPvQt3u/vQYQilNeRLA5y8cF7o8Hr3PvzPgU60rY/Fyf0pySPNfmahA9WjwBhJmIaFtrSeiLovUgqJEI7mORFUpn7T/YyeY2rSgFQbK/PE6gzwWj8LRT/OD9KTv+gPuRpT/7sy++IGFahp066tXlqvxglVY/I4/nD/CARgdSbNjfsM9ihOUJ+fKnWCmwmKCR3RpfBRaPVUGxDZNO7fHKJ5OIV1KIADEy2kFJmiKfE0DmJ4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4260;6:3CH4JPwhJJC8ZU5VBn4s85VYwl8hU9N2ADbHinlTZFXOYRmrFfZ/5pDR0a70Z/R4ucXRHjgzhUYm1H/NdQJbXEuPAKC6CoPTQr0zirXZjpKAndsu38TRfsumwTsTes2YLyXcNv9cawtbTokad2+OqiMFZV+saqbzQvO/iXjL0D2e6301hJSUOaZkSqguwQEZd3bCPgQmvDGS+sSsjLut23tNEXvxk5Rd6pem7G1YxcOkseKF4uy/M/VT6rWne3tkpkL1Xekj4RyGS398Ki/142AV8ZR+Jz2U8ie06ZkBuJPNe3b3UQBFWygGY2GAI9tJrgXbglljTFlqiT9YH6oYU2UD6CfVS1S7O0P688qStsMMRBXBbUq6/gaKhxdTlWYIHIcJbjwlD5JeZhzCHBDLFl6bapuvhaQBxiN1sbedahbFZ0KKWwG/7nyaIk3zxDb/iSgG3zT7vOPkxW8TJ/lyaQ==;5:VLpmkDA8dqYHgBjobnLdd/57afrZQwYvSb6m9/6sXaiNpntp4RkNt3tBfLM6BsHk7NjK6lBWOwkdPPJ5O7QRhOxt/OEegnrNqNZEsZbrqMJMYfxH0nEXemJN8OWBsWS6tzqUOY9Z3i6RufnqHhAeNVy0H8f8smBxZ4CXTr958jMDOv82KvMJsSb6MHvKDOpkiLOGTyfl4oPk1OxFx9i0fw==;7:O55GZP7G6UOKxksTOOxDOMubUxp1GQMiOJyezUXVfh+yM6kYUZuZFf+rFQIPLNKHwQG/uRTzJz95Op82nWYMgmxAnx/aDe0xFcpltEivfZeG2HK8xXF0PndSwShvjP/N7RELkPVinGYKVg2Dl0vtWg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2019 12:33:26.9111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226c99ba-8d59-48bd-2dc2-08d67ae5a622
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4260
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
index 0000000..fdcb966
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
+MODULE_LICENSE("GPL");
-- 
2.7.4

