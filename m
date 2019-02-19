Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93791C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FAD21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="u+bXc0vS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfBSRMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:12:48 -0500
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:30946
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728086AbfBSRMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGpGMwAUZqGUdD+p2LS5LbkMBkIzcBs8AWfX8kMpnac=;
 b=u+bXc0vS7ra4uVD+4wtIxvG5UTSff8YiNngI8S5yyjUGrouGjqBS+fVlzmrbb9C5rw19HcNvyEjYla4/eMFDZFna8UJ0tUb5fEI4bIaMhj5LroGY33r9bicozaF1VYj82v0Qs5x2A3CVVugSz1sJoYuJli0/7pTyvcXkA4DtvQM=
Received: from BN6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:404:4c::34)
 by BN6PR03MB3058.namprd03.prod.outlook.com (2603:10b6:405:44::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14; Tue, 19 Feb
 2019 17:12:46 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR03CA0072.outlook.office365.com
 (2603:10b6:404:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.14 via Frontend
 Transport; Tue, 19 Feb 2019 17:12:46 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:12:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHCit8009103
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:12:44 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:12:44 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 0/6] iio: imu: adis16480: Add support for ADIS1649x family of devices
Date:   Tue, 19 Feb 2019 19:12:12 +0200
Message-ID: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(3190300001)(189003)(199004)(476003)(2616005)(426003)(336012)(6666004)(316002)(246002)(72206003)(44832011)(116002)(7636002)(478600001)(305945005)(5660300002)(356004)(7696005)(126002)(486006)(106466001)(47776003)(4744005)(51416003)(110136005)(16586007)(50226002)(77096007)(186003)(26005)(54906003)(2906002)(50466002)(8676002)(4326008)(106002)(36756003)(8936002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3058;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a129c8-3531-4efd-9ad9-08d6968d7786
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR03MB3058;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3058:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3058;20:3WnQUVDC0TFIgrZTksXbmw3iFPCJsOFJRnEojQ+gCljGDvtBzBN5t8/MmMNSjjfeaBw6HlP8/diwaKsMq6uqvIFnSgspnMa2Sv5X8fVWjgZikIRNz+bLhU0Ac7+NgRakozvFNb5nbBfLHtzQGQ/ppGYsYu0Z7qMYIuRyOpfxPH60Z6Th31DiI/rWjeibRBZ0ehAcmo9tNgSVmzgjeMgAuiiwQPjdZGN8f12uqKKUAyBdwMPiK8Q8i5TpBOR0XwDCFjtWgIxidGLe7A2oaymGaqQAGEh9Wj51yCujZIvUwsKVrxtk2Iv1e7RLxCmCXQJLFv7YXa3kyr2v3e0DEvhnGOAbmZQc+KNH+7ituKET2dXeZ+BwoDdXNNHMLYvNSJk3pi9X7zu49IB5XMBR1k/kp+bqLwmHMnlbyG1jNYw2u/U+pIfbdoTKWO02wRi0yhv6ez74UZjEGa5QPa4wKO4lZVsei618zFHmbrvuiMaJbG6DA44hHRNdT28+NJ4SdG+m
X-Microsoft-Antispam-PRVS: <BN6PR03MB3058DF9BF2AAA63B5CE50E609D7C0@BN6PR03MB3058.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3058;23:Bo9UL4DnDqZ+EfSsi3s1ZJZ84SLtPdNOL/wStL/Wt?=
 =?us-ascii?Q?IFqtYwx74WTwQC9M5mDpWfV72D/lzW0bJ920zs8mMGlNYYl3rbd9EvvP5qxx?=
 =?us-ascii?Q?6mRCirXBjgTr8DIYAlZ3eWZxoRjnQznQMSGh/l56MeXzDDrWMXDY536Aommb?=
 =?us-ascii?Q?0be/gw8whypIpNxVcq9fsf+VvKI6zb+XLXd+E7No0DP/FQn0H4pYLQzci3LQ?=
 =?us-ascii?Q?jWAODpC5dz2SnAiBz5cLKmGtzdpSYKcxY0y+3s3bvvAT1Wb6hOtDo0sFiMIQ?=
 =?us-ascii?Q?SoNUtw0JcV3K7vZEBTsLT3I8b8ismBI3s+n+olf5vNWSxt6DeBWE/lYb5vbI?=
 =?us-ascii?Q?P+LSHfOTmtDZr+k82yz5PHPwbJiX1uLP5r+n0hf9PF8uGveEhtR0qwrdhASi?=
 =?us-ascii?Q?Hj6rIJ8WgSsguBH6CtbLAUy/qeobWCW5U0SrjPiqR30wJTNRhFLVZXIAWNRW?=
 =?us-ascii?Q?o4TWUvovMIWiK+0u9msf9/7APFQtP+HyUnEySTILzS0xMME3Dfbb5K7OqVLV?=
 =?us-ascii?Q?kO2vGvDA2A6mFK5F3S5am9/g7mq2UibedFUM0rATmFKVfSUUaFtgo2VAsUcA?=
 =?us-ascii?Q?vOzP32t33KtlGMKyVvq+D1f0nGWI00EzszKi0aHmmL/tAnzxgJhsBG25hftB?=
 =?us-ascii?Q?OO0I4e7KjcH4bkpzy6fvUxXQbspncdSLiGWSKkybonySIxc+umc/Y35WDkvE?=
 =?us-ascii?Q?c3wGXPM8crOCOcZKKEumn6hGeKWbc8uYFG4JMC9k8v7wOGUFuHBdGPHLm4Jl?=
 =?us-ascii?Q?ua34+lff5yxzHB/0ln25L9YfP05Hl7WkptligrtpSag7/S66eq1akZB7kT6y?=
 =?us-ascii?Q?1KXUBnetL6rEmZ1Al5H6K+MOBgdKjo5N+la5aV3IN461xjrHb0WB8YYV8CMQ?=
 =?us-ascii?Q?vMF3+iksM7G9Kw76eViRceIAxe4B4PbS+chPymkhqwMjydtnwAwDxCOJ649A?=
 =?us-ascii?Q?vBqIxg13ykOb2WXS8umDt90E/LjbmYcEGIFy4taouyxWJq7Z02WwiDadCiQP?=
 =?us-ascii?Q?xobNdEVdkFIwSJdFW3AeX1q?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ltPECj1l6EARwgIcPUw44hCGWcTOuohJzjgmRXNRzfm0tY0jsuUgf2IUnCUGLme7E9k+Mqv38d4jppU2GbzinjX3gkwV/WPgdrQKg/cexiiF3NYecgpCmhVMc852iXj2CLu1ZJgh7b797nb3YipdTjMy7vC7ZNRlKCwpLPmZXZs3dTEd8V/Ja78nFRau/zKDvKE8geiDHvrcXFUwdkINOIgPbZKIKLhPor0Qdbpghegg+I4rLfpCabaRXx/3rfF4hzjJ9ZAVUmXnwzzFD1A7tMdauhNHkMOT1GGu8xnBnRHLt2nywdaorfPSmcsJsbuyFvIHyTlRDxQxyg4n4GMMyuFDXsLw/H+lSRurH9ua7s2S6a0ui5gZHuZhE+WHxNvYEsbC3r3RPGVkq1mSJj9IDNXUzdFzdMxAdskoRPa2KY0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:12:45.5195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a129c8-3531-4efd-9ad9-08d6968d7786
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has as main goal to add support for ADIS1649x family of devices as
part of the already existing adis16480, but on the way it also deals with some
outstanding items:

* Make drdy pin configurable
* Add OF device ID table
* Deal with the temperature max scale in a generic way
* Add missing docs

Stefan Popa (6):
  iio: imu: adis16480: Use the default data ready pin configuration
  iio: imu: adis16480: Add support for configurable drdy indicator
  iio: imu: adis16480: Add OF device ID table
  iio: imu: adis16480: Treat temperature scale in a generic way
  iio: imu: adis16480: Add support for ADIS1649x family of devices
  iio: imu: adis16480: Add docs for ADIS16480 IMU

 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |  49 +++++
 MAINTAINERS                                        |   1 +
 drivers/iio/imu/adis16480.c                        | 198 ++++++++++++++++++++-
 3 files changed, 243 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt

-- 
2.7.4

