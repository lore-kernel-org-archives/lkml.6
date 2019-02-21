Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48235C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD052084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GEPup4WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfBUNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:16:43 -0500
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:33178
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBUNQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHZaXtQ0enWbhkR303243cStdxXwLWp/km0Q1fx1trs=;
 b=GEPup4WXEg13skink8sKrezBmgfKiPLqFhLX0R68QwkI9YX10TimnGIYS4JH54+Od6Jd6xGEqVfPmWm7XroM284B9aunAUq2E6VyuiL5CS010jiEPguj3tRtcRZAhWG1B//sugyz6ytyleWFPPXiU+WkxuE6LjXjx24l3plY3e4=
Received: from DM5PR03CA0045.namprd03.prod.outlook.com (2603:10b6:4:3b::34) by
 BN7PR03MB3745.namprd03.prod.outlook.com (2603:10b6:408:23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 13:16:38 +0000
Received: from CY1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM5PR03CA0045.outlook.office365.com
 (2603:10b6:4:3b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.14 via Frontend
 Transport; Thu, 21 Feb 2019 13:16:38 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT059.mail.protection.outlook.com (10.152.74.211) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 13:16:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1LDGWkO003269
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 Feb 2019 05:16:32 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:16:32 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/5] iio: imu: adis16480: Add support for ADIS1649x family of devices
Date:   Thu, 21 Feb 2019 15:15:01 +0200
Message-ID: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(3190300001)(189003)(199004)(110136005)(54906003)(36756003)(6666004)(356004)(47776003)(7696005)(316002)(246002)(8936002)(16586007)(305945005)(7636002)(51416003)(50226002)(106002)(2906002)(8676002)(106466001)(426003)(478600001)(336012)(50466002)(486006)(186003)(72206003)(26005)(126002)(77096007)(116002)(48376002)(4326008)(2616005)(476003)(44832011)(5660300002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3745;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e251c15-741a-42a3-20b3-08d697fecf77
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN7PR03MB3745;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3745:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3745;20:lj5bpGv0RUhsFfbQ8TltPTDfaWLr1gIRw+CFVASA1yC8ERKYfAs4r0CiJ1vn0oQtgUjk3t+G+oEd3NRLiBHiDjcyoDBhyXlCndCYl/+YcpfCCuQcWZmJrWslqNuiwG8liCX65SRHVS9BlvFCufWtVecJsJzgOllRR3NNQG7zmHjeudzuAYu0gYOgWDz1OFgc1V85OPr9Ju1klhbO4z+8zHDxfYWbmITgQeYWqUFufhCEvcg/Ze7VqcG0odmwjww+KnNEOEJxxOncuQnylM5j6JNvoHm1FFW3t8adzlS2qcBzf4zqgZ+UgsnW6Z3Wweb9Y781pZHvvO3tkWLsEli1j1E8hl06+q9UDZN9wGS5LphFKSZDaNCA4DVyvd4C1JrvXRczdekbvj+DmZXQKneNc2lxgcVReE4Or2QSe+hjd8qIpdAyUa6r5x5RnMXEdZqJ4mtEGRtfa42Tl9HHs+gqWr8zQ6+175FvXa9RS6bUdSOsZyoaHK769DQXdYYmdKmq
X-Microsoft-Antispam-PRVS: <BN7PR03MB37452A2ECA469FDBC62B0F539D7E0@BN7PR03MB3745.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3745;23:lEQOjp0gftDicS1kPIjPGa4OvhLCvo/YTQmPZmK5a?=
 =?us-ascii?Q?mzNmRGxPXzb1RVgZkR+z9cAD8frsc1VcbYNVSTABb6/rdZyfKs/9w5f+xc/6?=
 =?us-ascii?Q?IrLX+7Pr6RUFRmOY36Mcn17OmxczVa0RRt0/cKcbcb12FbtmRZzUEZnkbulY?=
 =?us-ascii?Q?90shZeW1mzt5vQ/NSlW4EaI8+kJuVQRiSxdNTZVsZzCWMzElqviLSPIgYwu7?=
 =?us-ascii?Q?/9c8AoJtLL+Aa8S/9gZVQ/KTPI9kGT8LdoXoAiR180p3AxEw1au6J07F7C8h?=
 =?us-ascii?Q?YSkQH/98K36GT6HI63BxaVvWDIky+5fJFm17x+nLF0amQ4oCWnOO5GNDkHBP?=
 =?us-ascii?Q?UbsnMs74eQSEbmXeTcvbty0IC435ee5/huE53oEB0qMl9nZvJ1gWkNhxVkZ6?=
 =?us-ascii?Q?lF/T91NzdH/THaGlKq8omdXB9iombehErQQIjd0IEGmnhaPATJj8BKE/zEXm?=
 =?us-ascii?Q?0D6jbGFihSJt8X3Lus5f6aesPfa8ZBrsg4XLUkbEqj9ajyIBKW/gVFf1gFWk?=
 =?us-ascii?Q?hiyZvSzSD3oY5UMGIgEkaCOFLz0K8/HFfbM+FiC1sIjagBiqrC05QfLKzcxz?=
 =?us-ascii?Q?Umwew378xWMuG2CGF+51BlQTUw2mDqyZVOK/3mgwZaUKhEsDQnWhos5zUOzD?=
 =?us-ascii?Q?8knk9dypnXH9sZ5wP4E5cFkxzyJwrJz9edh8H6/ZyFgbO2RxhcR0e73cl05I?=
 =?us-ascii?Q?8ZpfGd3naxMS/9T8qzz/m+IBla0HwP8w5x0UA8iXyEqiIwQe1tDCHHij8vcr?=
 =?us-ascii?Q?jF0u/Ys7x+SR9hW1XrxcNTp8zzWcshquXlxZc9M5fftW9n7VLnSHyZeo83M/?=
 =?us-ascii?Q?ZkKVada7FWsQEZg/sfiFcu+L8rccGYBNtnOdapUBw2lkUcM7gx9HEpnBMxpn?=
 =?us-ascii?Q?MxdQJcY60WSBu/o7hd24zIs6/dRBszq3nZ0THUAjZTyURn4sKvM8/qw5xugP?=
 =?us-ascii?Q?yZZ1C7o3KAS1VFyn+8Ck2jijn8SqjJQHKaBc2T33xvy3coLbXE76UT9hzQPv?=
 =?us-ascii?Q?wYZ0BKdZMTgIgweZaXy8k3SO81HTsqt+d1rVXApkgDUVPkjp+2Mel1hhKvNw?=
 =?us-ascii?Q?9VhuQUNcibJ4dq/cC9utZqFalXX9OofgrsHFtMrQ2+eCyO1Hw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: q+E7u0eHc8bXwjILbU7quzMR62IB3Vgfs7xkNKw1vrHoFnt1FNvuHdCiZMLiPH7o9jRh+jv7uwItRgWYcNiIQ2wyHo7D3AbezfftsrpybOjY1GHd4nXElqgAo38N1EAVSaVdX9W5Nkg54V06A+OtL+IPxTIHYAl6QliPWp1icG5eMIwf1EDWf6XgGU2YyNLHWsPHIwPXux48W4pds0XkUiecsTvzYw0fLwK4D27XaQ8dLrPDic00edPz8cD7guJkTN70WrkffyfTLVeufNoTwfsPlTBfMKm/xdvjNeLb+c9IwX5k0VxI8BBBpD2uRH/Ryo1vNCdFZP/o5PnAxeoO4AgQ+zXhFZMhrzQfUbKzkAGT/iloQjfgNCy/u7rRtiJkYPn+HZ7KEo0Uxk5l6kRf0t6eK3uJNLz6T4GQEanZ9xc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 13:16:34.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e251c15-741a-42a3-20b3-08d697fecf77
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3745
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

Changes in v2:
Patch 1:
	- use DIO1 pin as default data ready signal instead of DIO2.
Patch 2:
	- nothing changed.
Patch 3, 4:
	- give the scale directly in the adis16480_chip_info struct.
Patch 5: 
	- document the use of DIO1 pin as default data ready signal.

Stefan Popa (5):
  iio: imu: adis16480: Add support for configurable drdy indicator
  iio: imu: adis16480: Add OF device ID table
  iio: imu: adis16480: Treat temperature scale in a generic way
  iio: imu: adis16480: Add support for ADIS1649x family of devices
  iio: imu: adis16480: Add docs for ADIS16480 IMU

 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |  49 +++++
 MAINTAINERS                                        |   1 +
 drivers/iio/imu/adis16480.c                        | 197 ++++++++++++++++++++-
 3 files changed, 242 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt

-- 
2.7.4

