Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F9F208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="JqiVeT5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F9F208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeGLPpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:45:40 -0400
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:45664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbeGLPpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/1ALXtfTxzC9TjckKMtpzUkeMzpE12NYsMUjdcBcvs=;
 b=JqiVeT5+poKALGz0cAZk8DKVaLLWAQXjrL4D9sAiWa5HnrIjUfQ3XSluP2uqc5l19Gdio5QvI9WMxZFaIMHrrv2CpbzzpZsH1tH3cHN0jPWREydxqjAhlPbB+ISa92jlOSyYWSWS3uY5MlL6dXWEIU08JqAWb9/pOx8cgWj3C/o=
Received: from BN3PR03CA0069.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::29) by BN6PR03MB3122.namprd03.prod.outlook.com
 (2603:10b6:405:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 12 Jul
 2018 15:35:34 +0000
Received: from BN1BFFO11FD025.protection.gbl (2a01:111:f400:7c10::1:138) by
 BN3PR03CA0069.outlook.office365.com (2a01:111:e400:7a4d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.952.18 via Frontend Transport; Thu, 12 Jul 2018 15:35:34 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD025.mail.protection.outlook.com (10.58.144.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.29
 via Frontend Transport; Thu, 12 Jul 2018 15:35:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6CFZXNL003386
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 12 Jul 2018 08:35:33 -0700
Received: from linux.ad.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 12 Jul 2018
 11:35:33 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <rdunlap@infradead.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/5] dt-bindings: iio: accel: Add docs for ADXL372
Date:   Thu, 12 Jul 2018 18:34:57 +0300
Message-ID: <1531409697-19957-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(48376002)(8936002)(8676002)(50466002)(246002)(356003)(2906002)(305945005)(7636002)(36756003)(1720100001)(2351001)(6306002)(106466001)(47776003)(336012)(486006)(7696005)(478600001)(51416003)(6666003)(72206003)(16586007)(316002)(106002)(44832011)(6916009)(476003)(186003)(126002)(7416002)(4326008)(2616005)(5660300001)(26005)(77096007)(107886003)(426003)(50226002)(26826003)(54906003)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3122;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD025;1:juy/4D4bHRN7iodE/C+dbeZpA4oTvHjzy7ylHsIeWsWSAB2oTjKrFXgVjRZ1z5lGkACUjyiJlCP+7mcLqcEpXvrw/+NKVsyuHrV5mWjBLIxNTnujx8gtTFUVchqb7inS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7373609-a7bd-4a34-26e6-08d5e80d1be6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN6PR03MB3122;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;3:3kVJzmUKx5oEfoOPKrUc5zL02Q8Q5jfcvYxBSjgIldrhrbUuGq1g2G2RsIh60kqEp8Av8jIW0Vcg9d83+M+n3U5yX2+5g1R76yR8yyUYHngh1k1gmDsaMBvS6YvSt0VoagBIzyKjWrU53i2LjEL0cki4AkTC5XqL3jtDLzdcTy9Iu+/zKnpFMPlbJ9GBOLAR9TGWcyUIwHlTTcXm6sRtV5NMIReLBm50gKTJBMAR938ickz4YJbVhoJQkUphkRysTr69CmPoogTORosI55EOoYqs/cR1lZVuboW9coom1rT/hC9AZ17CiJUBFpu5EMqJAfZA8nvbk1qS7k3jaIRenm+jmkygDZ7QJORNL0DXHjo=;25:eoRY3Voqsd5UKw2eb6mrBJjN+rfEXAeLkqJ+9s/T6jhCRBOoag7AnUkL7eb7VKuiWZg8sWzmSYpy2n9ud/eZYXaU2pfMCZyeMw0DLGnq52ZxVRnpjelvl50jR/7U/3yDvHzplAZTxwkUHythHUgnbukrLZ6PdedsQ2p2XWqa2S08a9/tW43nUARYGn3cMmWuymR06KIyOdCaXThrN0BAUSOHu7BiFoaO8qHH8o+Zsx2e/AUFdZpD2Kjz67vwa7fNEQF7NljxXT+jcLHaKa0jD5XPd5jUqOs7A4u1lqCO7k2QOmXB5JhaQBn3qsEjDWpN/eUgqi9oRHZcYsj496Sp/A==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3122:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;31:85VKLTzr/zsK2RHymBc1K/9B6lDB/bNl05bvHNlGBQVuMgfucPuEehM5eCdT+AgTaMbQzr+e7F/vKQmB8Oq8Y0i+F9BtW0sz7lIBrA9mn500c0PjOS8VS6tlUxv3C2fbRC/FawH0yswYUjcNmWjnpD/SclNOP6ZOsN3mgYaRRntrmd6kFk5dETSNDNhO3Tr8g66zJFPSY7877YyMPvQmh75cEgTg7fw56ujXpoJMRzo=;20:JlQSFe+Z1HVWHfupxXFBaeCwIT54nl9NeWfIQF4poTKZDmJTVErMi1PXuorZH4jgDjQBwOvK4dvN1asxyx41ZxKiZWwZnVBc5wc2dPbOMAMxSAmPoKy+rKHocW826HJqT7I59pD+VTWGB9g/20ObiTTJC/wztk4BigqjnXvzm1DQ+3r94OnF//+F9OUUCVIoPyoh9bgEb56Re/oCFYDDroZz3QpMAOXRnOXyfjIdV2Ydyj5PaCELzvRCsUxHTKN+ncGL0P7cVk3so22n0IgvoXXtoiYWreYbFLKoPdUKP3G1sHi1zTJ1cMn6a6EtAEs+jLPiCVeRzMlrDGDdFYzSv6n6w5gzCL1B2opSJy/Cq0WSs9twvZI0w7lTha8I9clrsVay+vVmViffWDM5VSxbdVaUBqq1cpcS2VNI80sOImBbTQD29EoHH1zgVQV8FXQ068g7+SSLirCiwttelkGc2IpI85cet9ZyywXAWrWQnipsGdeajvfgyKbIom4jpr9E
X-Microsoft-Antispam-PRVS: <BN6PR03MB31226214576E9D4E973F47579D590@BN6PR03MB3122.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3122;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3122;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;4:tqfDyTnPzEs7yGj7FcVbg5DCyYXJByd9iffbB00TuYxOD0jX6V3mq3K1Y+5Tbqwal/vCsPBy+Z8rXd/ZgcBgNLm1hYXOgiHm8DU9w6oN7ueZnRhsRP2c46F8B6XG5l/teKAdqd+MU6+gIQJbV27K9r6cohZSJJXXtA0uzv1faO2NKoi9PUXUOOVEpgjmc0mYdkbvp+YxOhg3IVvnCUetm1PnLqzdA9omRCKacuYQJZFis/FbziQC42I4qggPVS/NMxaLMuz9H8w5VvUoL0P9glRyMqs3vITUe/Yos5RBAG6eN64b9skjKH4gw0+wgMWVa3c4cgo7DeYSvuQuaGlVFoP5/oZyuL6B/C7w2BDydY6B4wCt4m/AKk3Xitnbnfpi
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3122;23:yItEtuywKZN+rE3m5q1NjhtavGrM+q/tq9+riTgbS?=
 =?us-ascii?Q?oP5hOfMmiZAAehbKqDuLv7cK7QfC3CG4r0uERw9xxx/dYVB83c/4jwYZlMMI?=
 =?us-ascii?Q?9bZ0HIyXp3n5Klh3mj4nfhlbQJ3RNfnZiZYqtAGelusIwKwkX/Zggk4tm9Oj?=
 =?us-ascii?Q?4atrvxL9KjJeo//0CMMb6LtZSNGfeVfE6H2GZ1QbgPnOciqS/p2FacSFpTmE?=
 =?us-ascii?Q?StjvGMuUtPm37jTiexC/nOD2YtezIyGJY6LtpwWnQ4UaXOzpbBwhVd9wKfgF?=
 =?us-ascii?Q?8/7utKJGPyA1CNEqZwZNbV89KfvuTXUVGmp5lLRw8ZB9RatNRaG52VOtebPj?=
 =?us-ascii?Q?KwrjmuJcNSX1FekmsjuXk/osuV9XS4ap8ltozeEqlfp8sKbBaTIVux3o3iW8?=
 =?us-ascii?Q?Lzv0iKbXroHzcZwqTxldrUVBcqlh3Nefoc5eLfgLP87s/OaTW711dFYyA+L9?=
 =?us-ascii?Q?ShoY7CLra6ZL9f2fNMTgcz5pIpEFUK8Syr+tLdd8+IDaRHqgLtg3OlO8lvfI?=
 =?us-ascii?Q?rVWAzG6eUgTr0PeW4tc/sg4UrKsGbPkWCbAuiyqD3UU9Okvy9v2pl2u2zsHo?=
 =?us-ascii?Q?2BaO3gbg4Ip3e/OgIHM7e/3YwcHDvx6XsJ75INMqX3RPouLLkWJ6+kt+9cGv?=
 =?us-ascii?Q?2ZvHblkGP9yrLWKp6WGeX0hAxE9/wgr4V/UwDE13I2l1dKbDZjlSSYr1RUKJ?=
 =?us-ascii?Q?61v+UKq3RK4w/uU4iNe7xaa+K5ZH+mAO2cIyZCcLkcS5rsnStvL0aTq41Z1p?=
 =?us-ascii?Q?yN4dAPpTh97OkYgio66NhRCk1orQnveklhAhzG1J4HxhtnrJmIxvYuZ62SvE?=
 =?us-ascii?Q?1Dt+4a97st47pdbKTeTX7RJICf3K+AYKkAAWwqHbNRD1HHalth4fIlGCFrVb?=
 =?us-ascii?Q?xNd6C65mpMSQJIS7jIbSXLtS370tSApDBD2B7vHRVigp09CVlUnrZFzYIvfH?=
 =?us-ascii?Q?l8RSxlcnm9HjqFqd9aGifCx5TMsYPUv1IKaD1J5iJz2qCOKeJHwhRVnHDLMY?=
 =?us-ascii?Q?pQsAr2fjmp8MbWY9dkV/P8tze/S2/i4TwWfB44mGlVlxXDhM7Zw5htZg7CT6?=
 =?us-ascii?Q?OLYjVO0ZyVLtNAe+lM28gYDePPWdMp42vW3OysYxHH9SfrJ2AEdp1hOpp7lz?=
 =?us-ascii?Q?njYoOZ/Bus=3D?=
X-Microsoft-Antispam-Message-Info: iFyrJ0i1kDdVl9Cs5fe9cdzsvnGOz4N3AoSkfmwzSE0hAl8pxyJhKAWxFrLF1hS8dAxirCvD9/5ro4IRcLj+r2X+jNrWkDgivQBh7XgmF1kDMe8vBUIbYUPMKynIFCUV6IoBrlpDArmzHT28wC3CxTWGoY8lD7L+0kH2pFGoQV0E7gxKcy0YO6JH3WGH+jItYKJH60Nf39qAITpspy+wHYulYUcUE4e7qUBMeP8FT19d1x2f6Qg3pM9gzf/8VdgbUYSdzkEo+QVfKdB1qT84cInLvM5C8Jm9P+Gtg1J3JAzcA7I0HtljiFoO0qHjwwBVFVf2VhfoBnjFoc3fG0g+JaEFBQewpMIeN8cxFz3WNpA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;6:PyFw5EnTBfoMPllUNS7MF4PCkJmkRrxKQOICfd7mL0S13Qi1reAxCHPJqEjrsI/hAwivf8lQQG29K5eyMYvrZxiFi/J+ybBODqpvf5vYY55P7+p8jbjUewohzwi0upbPJv4tHR8kZ+84jCb99EKUm54iO6CJgs6uvaGaiP8EzS1VJDiSP4ZZhp8QiLdT3LlhclRpLbzyELUsDC4+FfWmC8hQSSlI/8YsBoc+wjUl3OJ3diUZ1SleIPMBVpVAFO9c2AdMGDdJJlqpzhbaKE1B3mQDmy6QOI+6ndZ0z5ZuC87che4E73LWzJSh8U2gfWm/ZH28RilsCDW/DxZvDx7EQBvpYaV6i3R7jt+xJMi987uos9isdL4Pr0KF/XOauzbO8eAhKEAdc58ehTIrXHaEfX6dGaC1ygOt3EU3xUbRiqMFQSm87F7enZl6R+uRdyq7f7kzA1Mycs7dT6rSTSBTTw==;5:N1ZhQQGiRGoTJJDD68zLTRE3oHJn/qzmys41oDoU7T3cL53zQ2k3szg85McL20GEJJJBJf7v8qL5v2UMOPbTootpcBzWxDFo2d10/TAMc2UpSF3ZW1P3ARiMm9wKX3qLMF5yzS5X6qn4g4MhPKMpFZzyW1k2SE7REhBtRz1Zk6Y=;24:e61lFY8b+KxrtEGCdtSZT0tTbwMTw4U0X3DuYCcZtKj44MhshX/Cg4obYQ6IyW2Rg6csfCkqtYzuC7+DzHqz5QgGpJLiMROKJjufvcqO20I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;7:dJCWvlmKuEd5p+7azH8Hu+/QtNxDKKjkWmcCNND9X+8TwbtJaZmtXlK8VSm9gX0jY4WPBtUokWsnaEsHfjKZY9MTCydg4DN8g6bdkNMwE7td4vYc/i6W/BoZlCRzzCODUDfI3J+0wDQ4gds0ocdio9JinuWQzxonY8147sZJe4tTi9pshydky+STK7EH/diNAYUaM6Vd7lL45SE4t8HoX8AGDiq2JaKQIrYxXRS1L98YDCIBzDA6MFXf5q/jmOiW
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 15:35:34.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7373609-a7bd-4a34-26e6-08d5e80d1be6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree binding documentation for the ADXL372 3-axis digital
accelerometer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 Documentation/devicetree/bindings/iio/accel/adxl372.txt | 16 ++++++++++++++++
 MAINTAINERS                                             |  1 +
 2 files changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..fea4baf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,16 @@
+Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
+
+Required properties:
+ - compatible : should be "adi,adxl372"
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+
+Example:
+
+	accelerometer@0 {
+		compatible = "adi,adxl372";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ba47bb..c8dd09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.7.4

