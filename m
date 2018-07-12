Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5454220878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="paJNK5k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5454220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeGLPsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:48:52 -0400
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:27505
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727642AbeGLPsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ6DAGBoou4fGBLS086Ei3HL6U+7jK8Bkd8PUR68UFw=;
 b=paJNK5k8qbeVR1yvJUc4DjZKPcgfFQ01LhWX1bX7X+rGyv0Z46qLYEz+Fg1D8nQgqCCYQMlOnAi/+yiV97Op4XP+QLYNTgCgMx4USR7o3YNJo9x5QnTPnw5v75B4JAy1IfXKeShm1CLoQMlvHNSMtD5qup+uJqs5PDt70pZeQ30=
Received: from BN3PR03CA0099.namprd03.prod.outlook.com (2603:10b6:400:4::17)
 by DM5PR03MB3132.namprd03.prod.outlook.com (2603:10b6:4:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 15:34:38 +0000
Received: from BN1BFFO11FD018.protection.gbl (2a01:111:f400:7c10::1:151) by
 BN3PR03CA0099.outlook.office365.com (2603:10b6:400:4::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.930.21 via Frontend Transport; Thu, 12 Jul 2018 15:34:38 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD018.mail.protection.outlook.com (10.58.144.81) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Thu, 12 Jul 2018 15:34:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6CFYbMV002810
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 12 Jul 2018 08:34:37 -0700
Received: from linux.ad.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 12 Jul 2018
 11:34:37 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC:     <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <shreeya.patel23498@gmail.com>, <mirq-linux@rere.qmqm.pl>,
        <thierry.escande@collabora.com>, <himanshujha199640@gmail.com>,
        <gwendal@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 1/5] iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
Date:   Thu, 12 Jul 2018 18:34:23 +0300
Message-ID: <1531409663-19846-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(126002)(44832011)(476003)(246002)(48376002)(26005)(72206003)(966005)(356003)(186003)(77096007)(51416003)(50466002)(2616005)(7636002)(7696005)(486006)(107886003)(54906003)(6666003)(478600001)(47776003)(8936002)(26826003)(6306002)(1720100001)(336012)(4326008)(106002)(16586007)(39060400002)(14444005)(2201001)(5660300001)(50226002)(106466001)(305945005)(36756003)(575784001)(426003)(2906002)(7416002)(316002)(8676002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3132;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD018;1:6dWDGyLQavZs92HztNyHVhPdD6ic4glJwLrSOWMnXsb2ASEO0R1Aq2xL2ls4ymH9gfql2yPWRgzYjYz4TgzhcmOW1CP+Vr2GoYjmBmvg/8a1dHUZrVUWblhlU20gfAqr
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a950b2-960f-4cb7-63d0-08d5e80cfaa0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;3:/Pmfbry9+WmOV/96Tt4RYQCuZX12QdfSvxZZP/hy81qh9xuHtw3EhDMbNTlvsj5l2meONLO6sZgOfnJXw9YK2CCKCrmT/Y8rcb7ccISgs3s0YwR5rDBTTL77KmNcyJbAqmgfiNqutgjEqzoRFxqicoNfbLRPMvdzp7z71j+RMRWqChiBZahOHmAr2re5qIEBeIA7aPzOYW5SH2jkVttjQ85dkVyUc2SIzXSiOFflvqQdZh9WY0qWCne5QK7P+xMDJqsS4p0hqsEhpMrMIUPDA06ELsY6neYowjZAuH7bcWzI6LIn/fgp6igJ7f1Uc80AUTdXFRd+ZcjFEH3xCajYB7MArqPsBg7jSz2kvc5a6s0=;25:n2LYWFIvF1hcoCKPBDADh3O42MrPLAnlAj8g7pNUeJUjLArHu1lFbsMdJZABQ7iATks3jrLb0ChzOX/FVxYgB4si8o+vUjVQ9uYSEl5J0pVCMllmm4/SbMvgdN+JPJwqNW/e1Niii4MUxKJaIu+k6TsVK7/3oT/m4c9mXNJt8G2pUws2H3IBKZLBPN8yKONR41GH4kVH44TY//iGuKmRGj7FAVoacuv4QcH1QzNqXLsD0jgaBCLzayqZKnF6d4Lys0WeMPOxXd6ZQ1rD4TmWGe82CoYU6FNQvF7uIZ/uxK8dJpPfYgl12HHhnX4f2eSHPBraTzFzQ/Hl7+5EqkrXJA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3132:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;31:ZyR9fpoL7YVkJyPluo41lD+77DG5ZCXAxTbCjz6sva49e7iojCXokP1sgv6KY0ER3aFQTyjsA/7DCarM32ZOnbluCDm/GEdzhwU22Q7BLORoqP9B03eF9eNgstrBojYaBI+viTXVQ7AFJ5eZEAZ7ifGJy1eCNPIcyFlPmuNhuCb8t83oblbWOKiM7qxVOKJrNeaJJC4N8/Tf7CKqfCNu9cUAr/2hNKxRQ2rPpLovCUw=;20:djm+7hQYbkulcOYJwcptCatcNrX8mcnW08P/RCQKDmfF3jB1pbnqqPWY14696sWIpIBhVxkvDtQWFohSvsWvbZnVg2wtewbTjxr6IguKhciF3Mc9kyS0U3L/gy03IfoYTb6qusRjK4o+3Kk7WCYAe0q0npRRyj1CO0DIxbg1OydAZEt4gjXMdR+Wdjl98S/5GKdKC9Vn/FTvA0kV35toJupHx/H0HT0/Wr5jZT3Ix34/g+RlJTYDaCUe6ls/qPpX87UFVT4E05jQbwi/FLrIOQIwYAluzMFgRASE0x8UxhsOB98RQFxudA0TWFWutHbfCAZGkD4d4dFE8y8QRe/qgV+cOPj/znK/ycseBEemPS4QLfC2GC/m639UT7NSvFNfjTgUJsxYDEll7wlhLqecMJ6tTbvcfNjaEf7kpTlr1/3CzbZU/9JweHn8FyS093x36c4GbRhYTrelHxqIL0yHUoOomqVmP4tscKFh5+dSYxiCrfSBG55wQKMQaNu0Ttsz
X-Microsoft-Antispam-PRVS: <DM5PR03MB313267F2E641ACF1A1767A0C9D590@DM5PR03MB3132.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3132;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3132;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;4:ctmM16qq7Fybjz/PRh/W5/f14D2qqZm3ZpkHJvXf/u6rXllqwY6HY4kJoUNp2cR96FExEnMYw6LdgCt9YlvV41UvDFyX7/wdJnBx7IgnggLyrgJKDZGI+miqizDzy3Si9Ncoa9W7FcTARA3+HQeCrQM4qqPNZsx+diwdiCCSM4aetmzfaOHxVIa+0iWXmm3MV0vcA5iRoU14TUkduaqOrl8xZdwrU/cdfCSoHNvqQPdNqpVm/Hie89JclP2ayc0LzdyymKM0bcc3m39VZtPJnD4tk9yDQWk/0P+/Ee3R5g2cBZgVK7LcSFqLIUmkLjnz9XT3kmd4HkmCzb3Og9jS7gKcWO84ba/vyn7DEInKA1AuSbLc/3T8TDLupmHZ3qj3YUUuG0eS35Qd5G/2oXQV5bhU4jFZhkyns+WuErrO5Sc=
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3132;23:DJIWxpHveryyuSjWlQQaaHPjn/FY4vveZjBdcAyXf?=
 =?us-ascii?Q?Rlv/owdMtBkSZHol7d3Hpq9eD3Sq8tdocs0MxIgm0r8mtixFMJGYicfEKuiM?=
 =?us-ascii?Q?p8sNAIK11zaMCuuBjh0wtjtHx/3rFT0S/3/zTMnJsLY6WaJkv2s01+1fN6bQ?=
 =?us-ascii?Q?B4dwOB8WPTYYFGa6x6mBpsTxS3inkxBxVhgPEOMTGaR6QEa3Fe3S/+MRF26m?=
 =?us-ascii?Q?E5W23ZKjNFG/LEjId8pBEd7g6UV6sVHNFhxf5Q25mKUoVQjR5hpR3bkDmlUH?=
 =?us-ascii?Q?nWc5JaO+BHHI5BuTG/aDMaNn6HzwV76kf/GxW2erZg3u+SyukO4Iug7roMUv?=
 =?us-ascii?Q?cpyW3lnxUdw3ro9CKWhKr+HJDOjz2HFU28Pdkp3XgqirS7jYvYZ5yBRkITEm?=
 =?us-ascii?Q?9X68WOLWvgLUOi5siO2bTS6K86rkXojD8uoatraM+mrnheoT13abp3723KXb?=
 =?us-ascii?Q?zSUL0p6+RZtuHcEYihrtUzNIFHtGZ/RtnNOm0F83FSRzwx9Jq9xUagJRj2pI?=
 =?us-ascii?Q?kwY6vK2H4dNjeqqOwOt1kXThobM0W0TOrFUhzZmbOFqbn1SsnD2LgNxEExyG?=
 =?us-ascii?Q?UxIGTjs3IYctRwnVYGZ+UTES7nsKBoWISzAX8VB0fi86GxjBJsXLMqoik4R6?=
 =?us-ascii?Q?s1b5ETfwPJuVOgg+gUylNOcF/UuulOtpbB+RX4qOpGlR53med2MV74OX7zn0?=
 =?us-ascii?Q?7xoJr0WXis9rJKqJfID+eCTiNsb6V94V9AWLpsRbOcQqANbdkP7QP3gN5+2R?=
 =?us-ascii?Q?W5N8wYmcWIY9I3mAO/yhUzEjsP1zr4x29gf0GPJ2SwM6zRVJVlSEuqBAxxj7?=
 =?us-ascii?Q?V0LohFIUKdDbr2Uvn+xHXStDHQ+XDtKFlUtsAx1ZXbShcuDk4BhgdFCOBMa4?=
 =?us-ascii?Q?d/UCnPEsP2Vcy+youykWmuUx+xt0cfF54rU7gG83ncjw9T8HPMK4NRff6yy8?=
 =?us-ascii?Q?wejTjFu6bbCwJkdmgRhjmKIzsFNO0TMLltycupzU9jd+wslOke4ZIaMxapy+?=
 =?us-ascii?Q?sFRSqb8ivkot26u7km8v2enDrFKdtr3JVN7aplmd2TvUhNS7hp/WiR6MfI+D?=
 =?us-ascii?Q?fA5zMnIUsv1OSGg0/q1TDvZVRLB1QyGzIDfp03Va4YTwTHBZ5nWXRL5GH6Kg?=
 =?us-ascii?Q?ZcKlDKlI8asjFM0kggIKgVqrbJKw41hwqxWlv/cSHOl7Ygl8QSwoBTYCT0ch?=
 =?us-ascii?Q?JyxzWnnzkvWHZU=3D?=
X-Microsoft-Antispam-Message-Info: H/FqEWx67TfZHy3GvrsRfi7hZjUxMJFnzIsoCx3InFXzrVw36FyfTIXpKOse3N60I00E+WDyMnZfEwxIxvMMgekGbGWaSEe3qk92czOGTd6oVZbantgHyjX2Mfr5aby+g2l1v850fQrSuqpCwIEOhrIoLlJBIXLUT7dR8eQh2FnmrsbFBrrp9OECg7rqazNI/8QZz6vmo+Z9s9mnfjEnsmzKBcw1o6HzFuqpVoDLgKASMGU+1U9hPGsa3NqiP723gPKuLloYwqPMtlbq00JsV1cJQr5wpPmhZ4XuNSXm0k/VTEUBzLjWYMkMdeL3c9RUFP4Yy1P7DTvaGeKXSvCUjTnGD9/m35K+XvEk0D8EdME=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;6:IsbWDgzN9D3EPbLn268UUIUbNOGxd5aeP9/x+p0ikjvjV3IBxwFOYQ4BKUmOiS7GMiyrN8+BV5w+THl4Oe1bJAy1FU16PyqKFI6i62oLZlW47OfhVOCoftVVLEQp/wmgE+uaw7XiaceVW9dTzekUAPCvQcjY7/JSFTsobFQ5T4K5wP7lN3oYNw0773tXJRfXdu76WZ7M0jsSdLCNK8mdwtKpaq0C57fhA7uy6xuasMfqXJQNqftKqIrzX3KRpfRH4uJLKSAdrGs/6UXO01vGzpzWHoHTVAkLLcFrmlMKOaRk2OagHrJpelyOn6+Dys6ZtKVwkiyO73yJ/L9v4Evn/MuwcC2KATIu5iBIYzVpsDryyaTDOXLt7DM75zXcRie2XeiSklat9Md/75iv5/iVMrnxBTZHO4rvuF5vecDXD0pXtmB87rSX9JuVpDqJX2wpzG3ySz/924zHe5LHDIr4Qw==;5:GLOc+gYCfsnLhS0VsCXSSoq5or+7AelHHJuyzlil5Cd3h2MVvB9mvCH7Fmeu6Ez27Je86YsvTmKKS5oXotOLf6h0Pf/ZRMiVgV/EyZoXTJxikkJ64ZE2IccVTcqIz6LKtTs+WKduqwLj0SDl56NjiclFO3fvKhsOgcUSdDp4tfQ=;24:A8obF0T1QxwDFqN2zGhMibdmOg/C7+H4Jvn5IEiTUpxAGAk1DcfblfELGLSouJDfFniJgyJfjGbvxenvXZfBxL0TFfGNvP5w107K6+vfb7c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3132;7:aEHdMqVCpsBW5y11G8puLZOKLtU5J03TEohfsjPBJTjqQOI8Clc+Xyk2mDPawNkXzTDpi/icOCy9A7x1bri01PucKdf1Qq4O8cDCzgLIm8nWdcWoP4/d63uMflbOg0fWvo2XMW+QaNFx7+5Rih3t4lMUJp18JLFc6i02prWDlkdnuHeUuYtGxonHxoXnKyJ8QcMHzA6CalV+9EAeOBVuSMAx4dHhCpJgOtXkLeICGvCMeTHiqObWTzR1QWz5Fwd4
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 15:34:38.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a950b2-960f-4cb7-63d0-08d5e80cfaa0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Devices ADXL372 SPI-Bus
Three-Axis Digital Accelerometer.

The device is probed and configured the with some initial default
values. With this basic driver, it is possible to read raw acceleration
data.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                 |   6 +
 drivers/iio/accel/Kconfig   |  11 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/adxl372.c | 483 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 501 insertions(+)
 create mode 100644 drivers/iio/accel/adxl372.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1028..2ba47bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/input/misc/adxl34x.c
 
+ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/accel/adxl372.c
+
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 62ae7e5..1b496ef 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -60,6 +60,17 @@ config ADXL345_SPI
 	  will be called adxl345_spi and you will also get adxl345_core
 	  for the core module.
 
+config ADXL372
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to add support for the Analog Devices ADXL372 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl372.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 636d4d1..5758ffc 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
+obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
new file mode 100644
index 0000000..62ce238
--- /dev/null
+++ b/drivers/iio/accel/adxl372.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* ADXL372 registers definition */
+#define ADXL372_DEVID			0x00
+#define ADXL372_DEVID_MST		0x01
+#define ADXL372_PARTID			0x02
+#define ADXL372_REVID			0x03
+#define ADXL372_STATUS_1		0x04
+#define ADXL372_STATUS_2		0x05
+#define ADXL372_FIFO_ENTRIES_2		0x06
+#define ADXL372_FIFO_ENTRIES_1		0x07
+#define ADXL372_X_DATA_H		0x08
+#define ADXL372_X_DATA_L		0x09
+#define ADXL372_Y_DATA_H		0x0A
+#define ADXL372_Y_DATA_L		0x0B
+#define ADXL372_Z_DATA_H		0x0C
+#define ADXL372_Z_DATA_L		0x0D
+#define ADXL372_X_MAXPEAK_H		0x15
+#define ADXL372_X_MAXPEAK_L		0x16
+#define ADXL372_Y_MAXPEAK_H		0x17
+#define ADXL372_Y_MAXPEAK_L		0x18
+#define ADXL372_Z_MAXPEAK_H		0x19
+#define ADXL372_Z_MAXPEAK_L		0x1A
+#define ADXL372_OFFSET_X		0x20
+#define ADXL372_OFFSET_Y		0x21
+#define ADXL372_OFFSET_Z		0x22
+#define ADXL372_X_THRESH_ACT_H		0x23
+#define ADXL372_X_THRESH_ACT_L		0x24
+#define ADXL372_Y_THRESH_ACT_H		0x25
+#define ADXL372_Y_THRESH_ACT_L		0x26
+#define ADXL372_Z_THRESH_ACT_H		0x27
+#define ADXL372_Z_THRESH_ACT_L		0x28
+#define ADXL372_TIME_ACT		0x29
+#define ADXL372_X_THRESH_INACT_H	0x2A
+#define ADXL372_X_THRESH_INACT_L	0x2B
+#define ADXL372_Y_THRESH_INACT_H	0x2C
+#define ADXL372_Y_THRESH_INACT_L	0x2D
+#define ADXL372_Z_THRESH_INACT_H	0x2E
+#define ADXL372_Z_THRESH_INACT_L	0x2F
+#define ADXL372_TIME_INACT_H		0x30
+#define ADXL372_TIME_INACT_L		0x31
+#define ADXL372_X_THRESH_ACT2_H		0x32
+#define ADXL372_X_THRESH_ACT2_L		0x33
+#define ADXL372_Y_THRESH_ACT2_H		0x34
+#define ADXL372_Y_THRESH_ACT2_L		0x35
+#define ADXL372_Z_THRESH_ACT2_H		0x36
+#define ADXL372_Z_THRESH_ACT2_L		0x37
+#define ADXL372_HPF			0x38
+#define ADXL372_FIFO_SAMPLES		0x39
+#define ADXL372_FIFO_CTL		0x3A
+#define ADXL372_INT1_MAP		0x3B
+#define ADXL372_INT2_MAP		0x3C
+#define ADXL372_TIMING			0x3D
+#define ADXL372_MEASURE			0x3E
+#define ADXL372_POWER_CTL		0x3F
+#define ADXL372_SELF_TEST		0x40
+#define ADXL372_RESET			0x41
+#define ADXL372_FIFO_DATA		0x42
+
+#define ADXL372_DEVID_VAL		0xAD
+#define ADXL372_PARTID_VAL		0xFA
+#define ADXL372_RESET_CODE		0x52
+
+#define ADXL372_RD_FLAG_MSK(x)		((((x) & 0xFF) << 1) | 0x01)
+#define ADXL372_WR_FLAG_MSK(x)		(((x) & 0xFF) << 1)
+
+/* ADXL372_POWER_CTL */
+#define ADXL372_POWER_CTL_MODE_MSK		GENMASK_ULL(1, 0)
+#define ADXL372_POWER_CTL_MODE(x)		(((x) & 0x3) << 0)
+
+/* ADXL372_MEASURE */
+#define ADXL372_MEASURE_LINKLOOP_MSK		GENMASK_ULL(5, 4)
+#define ADXL372_MEASURE_LINKLOOP_MODE(x)	(((x) & 0x3) << 4)
+#define ADXL372_MEASURE_BANDWIDTH_MSK		GENMASK_ULL(2, 0)
+#define ADXL372_MEASURE_BANDWIDTH_MODE(x)	(((x) & 0x7) << 0)
+
+/* ADXL372_TIMING */
+#define ADXL372_TIMING_ODR_MSK			GENMASK_ULL(7, 5)
+#define ADXL372_TIMING_ODR_MODE(x)		(((x) & 0x7) << 5)
+
+/* ADXL372_FIFO_CTL */
+#define ADXL372_FIFO_CTL_FORMAT_MSK		GENMASK(5, 3)
+#define ADXL372_FIFO_CTL_FORMAT_MODE(x)		(((x) & 0x7) << 3)
+#define ADXL372_FIFO_CTL_MODE_MSK		GENMASK(2, 1)
+#define ADXL372_FIFO_CTL_MODE_MODE(x)		(((x) & 0x3) << 1)
+#define ADXL372_FIFO_CTL_SAMPLES_MSK		BIT(1)
+#define ADXL372_FIFO_CTL_SAMPLES_MODE(x)	(((x) > 0xFF) ? 1 : 0)
+
+/* ADXL372_STATUS_1 */
+#define ADXL372_STATUS_1_DATA_RDY(x)		(((x) >> 0) & 0x1)
+#define ADXL372_STATUS_1_FIFO_RDY(x)		(((x) >> 1) & 0x1)
+#define ADXL372_STATUS_1_FIFO_FULL(x)		(((x) >> 2) & 0x1)
+#define ADXL372_STATUS_1_FIFO_OVR(x)		(((x) >> 3) & 0x1)
+#define ADXL372_STATUS_1_USR_NVM_BUSY(x)	(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
+#define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
+
+/* ADXL372_INT1_MAP */
+#define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
+#define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
+#define ADXL372_INT1_MAP_FIFO_RDY_MSK		BIT(1)
+#define ADXL372_INT1_MAP_FIFO_RDY_MODE(x)	(((x) & 0x1) << 1)
+#define ADXL372_INT1_MAP_FIFO_FULL_MSK		BIT(2)
+#define ADXL372_INT1_MAP_FIFO_FULL_MODE(x)	(((x) & 0x1) << 2)
+#define ADXL372_INT1_MAP_FIFO_OVR_MSK		BIT(3)
+#define ADXL372_INT1_MAP_FIFO_OVR_MODE(x)	(((x) & 0x1) << 3)
+#define ADXL372_INT1_MAP_INACT_MSK		BIT(4)
+#define ADXL372_INT1_MAP_INACT_MODE(x)		(((x) & 0x1) << 4)
+#define ADXL372_INT1_MAP_ACT_MSK		BIT(5)
+#define ADXL372_INT1_MAP_ACT_MODE(x)		(((x) & 0x1) << 5)
+#define ADXL372_INT1_MAP_AWAKE_MSK		BIT(6)
+#define ADXL372_INT1_MAP_AWAKE_MODE(x)		(((x) & 0x1) << 6)
+#define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
+#define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
+
+/*
+ * At +/- 200g with 12-bit resolution, scale is computed as:
+ * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
+ */
+#define ADXL372_USCALE	958241
+
+enum adxl372_op_mode {
+	ADXL372_STANDBY,
+	ADXL372_WAKE_UP,
+	ADXL372_INSTANT_ON,
+	ADXL372_FULL_BW_MEASUREMENT,
+};
+
+enum adxl372_act_proc_mode {
+	ADXL372_DEFAULT,
+	ADXL372_LINKED,
+	ADXL372_LOOPED,
+};
+
+enum adxl372_th_activity {
+	ADXL372_ACTIVITY,
+	ADXL372_ACTIVITY2,
+	ADXL372_INACTIVITY,
+};
+
+enum adxl372_odr {
+	ADXL372_ODR_400HZ,
+	ADXL372_ODR_800HZ,
+	ADXL372_ODR_1600HZ,
+	ADXL372_ODR_3200HZ,
+	ADXL372_ODR_6400HZ,
+};
+
+enum adxl372_bandwidth {
+	ADXL372_BW_200HZ,
+	ADXL372_BW_400HZ,
+	ADXL372_BW_800HZ,
+	ADXL372_BW_1600HZ,
+	ADXL372_BW_3200HZ,
+};
+
+#define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 12,						\
+		.storagebits = 16,					\
+		.shift = 4,						\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
+static const struct iio_chan_spec adxl372_channels[] = {
+	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
+	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
+	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+};
+
+struct adxl372_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	enum adxl372_op_mode		op_mode;
+	enum adxl372_act_proc_mode	act_proc_mode;
+	enum adxl372_odr		odr;
+	enum adxl372_bandwidth		bw;
+};
+
+static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, ADXL372_RD_FLAG_MSK(addr),
+			       &regval, sizeof(regval));
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(regval);
+}
+
+static int adxl372_set_op_mode(struct adxl372_state *st,
+			       enum adxl372_op_mode op_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_POWER_CTL,
+				 ADXL372_POWER_CTL_MODE_MSK,
+				 ADXL372_POWER_CTL_MODE(op_mode));
+	if (ret < 0)
+		return ret;
+
+	st->op_mode = op_mode;
+
+	return ret;
+}
+
+static int adxl372_set_odr(struct adxl372_state *st,
+			   enum adxl372_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_TIMING,
+				 ADXL372_TIMING_ODR_MSK,
+				 ADXL372_TIMING_ODR_MODE(odr));
+	if (ret < 0)
+		return ret;
+
+	st->odr = odr;
+
+	return ret;
+}
+
+static int adxl372_set_bandwidth(struct adxl372_state *st,
+				 enum adxl372_bandwidth bw)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_MEASURE,
+				 ADXL372_MEASURE_BANDWIDTH_MSK,
+				 ADXL372_MEASURE_BANDWIDTH_MODE(bw));
+	if (ret < 0)
+		return ret;
+
+	st->bw = bw;
+
+	return ret;
+}
+
+static int adxl372_set_act_proc_mode(struct adxl372_state *st,
+				     enum adxl372_act_proc_mode mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL372_MEASURE,
+				 ADXL372_MEASURE_LINKLOOP_MSK,
+				 ADXL372_MEASURE_LINKLOOP_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	st->act_proc_mode = mode;
+
+	return ret;
+}
+
+static int adxl372_set_activity_threshold(struct adxl372_state *st,
+					  enum adxl372_th_activity act,
+					  bool ref_en, bool enable,
+					  unsigned int threshold)
+{
+	unsigned char buf[6];
+	unsigned char th_reg_high_val, th_reg_low_val, th_reg_high_addr;
+
+	/* scale factor is 100 mg/code */
+	th_reg_high_val = (threshold / 100) >> 3;
+	th_reg_low_val = ((threshold / 100) << 5) | (ref_en << 1) | enable;
+
+	switch (act) {
+	case ADXL372_ACTIVITY:
+		th_reg_high_addr = ADXL372_X_THRESH_ACT_H;
+		break;
+	case ADXL372_ACTIVITY2:
+		th_reg_high_addr = ADXL372_X_THRESH_ACT2_H;
+		break;
+	case ADXL372_INACTIVITY:
+		th_reg_high_addr = ADXL372_X_THRESH_INACT_H;
+		break;
+	}
+
+	buf[0] = th_reg_high_val;
+	buf[1] = th_reg_low_val;
+	buf[2] = th_reg_high_val;
+	buf[3] = th_reg_low_val;
+	buf[4] = th_reg_high_val;
+	buf[5] = th_reg_low_val;
+
+	return regmap_bulk_write(st->regmap,
+				 ADXL372_WR_FLAG_MSK(th_reg_high_addr),
+				 buf, ARRAY_SIZE(buf));
+}
+
+static int adxl372_setup(struct adxl372_state *st)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL372_RD_FLAG_MSK(ADXL372_DEVID),
+			  &regval);
+	if (ret < 0)
+		return ret;
+
+	if (regval != ADXL372_DEVID_VAL) {
+		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for activity detection to 500mg */
+	ret = adxl372_set_activity_threshold(st, ADXL372_ACTIVITY,
+					     true, true, 500);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for inactivity detection to 500mg */
+	ret = adxl372_set_activity_threshold(st, ADXL372_INACTIVITY,
+					     true, true, 500);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity processing in Looped mode */
+	ret = adxl372_set_act_proc_mode(st, ADXL372_LOOPED);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_bandwidth(st, ADXL372_BW_3200HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity timer */
+	ret = regmap_write(st->regmap,
+			   ADXL372_WR_FLAG_MSK(ADXL372_TIME_ACT), 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set inactivity timer to 1s */
+	ret = regmap_write(st->regmap,
+			   ADXL372_WR_FLAG_MSK(ADXL372_TIME_INACT_L), 0x28);
+	if (ret < 0)
+		return ret;
+
+	/* Set the mode of operation to full bandwidth measurement mode */
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, ADXL372_RD_FLAG_MSK(reg),
+				   readval);
+	else
+		return regmap_write(st->regmap, ADXL372_WR_FLAG_MSK(reg),
+				    writeval);
+}
+
+static int adxl372_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adxl372_read_axis(st, chan->address);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = ADXL372_USCALE;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl372_info = {
+	.read_raw = adxl372_read_raw,
+	.debugfs_reg_access = &adxl372_reg_access,
+};
+
+static const struct regmap_config adxl372_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+};
+
+static int adxl372_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxl372_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st->regmap = regmap;
+
+	indio_dev->channels = adxl372_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &adxl372_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adxl372_setup(st);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adxl372_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl372_id);
+
+static struct spi_driver adxl372_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adxl372_probe,
+	.id_table = adxl372_id,
+};
+
+module_spi_driver(adxl372_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

