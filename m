Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="r5KF7dwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfB0QPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:15:20 -0500
Received: from mail-eopbgr780053.outbound.protection.outlook.com ([40.107.78.53]:25248
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbfB0QPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8j18qpcDCGQ6X05pL0G07gWbp3KdsFJbLPmEHkvu2E=;
 b=r5KF7dwxmzm4Zla9IvUA9sZC1UWk3WIixpGakQWUYq6vrrTY2Jti2hsBTYUVD7bZZxlZGOPFTSFnLgfsp2SwG2U1R2vwnSASo7KNnzY8sttK6jUPRjnHKGEXxam7DPT3/4N9DI3wysL3EGLJBiuJNsK/o9ISSyANHf8Prc8hFMk=
Received: from CY4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:910:4d::40)
 by SN6PR03MB3758.namprd03.prod.outlook.com (2603:10b6:805:69::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Wed, 27 Feb
 2019 16:14:37 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR03CA0099.outlook.office365.com
 (2603:10b6:910:4d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Wed, 27 Feb 2019 16:14:37 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:14:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGEZP1021445
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:14:35 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:14:34 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/7] iio: imu: adis16480: Add support for ADIS1649x family of devices
Date:   Wed, 27 Feb 2019 18:14:21 +0200
Message-ID: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(3190300001)(189003)(199004)(36756003)(316002)(16586007)(5660300002)(478600001)(48376002)(356004)(72206003)(4326008)(486006)(106002)(6666004)(50466002)(2906002)(44832011)(8936002)(116002)(53416004)(2616005)(246002)(305945005)(50226002)(426003)(126002)(476003)(7636002)(186003)(26005)(110136005)(54906003)(8676002)(77096007)(47776003)(106466001)(7696005)(51416003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3758;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33816f2f-77c1-43dd-d450-08d69cceab58
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR03MB3758;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3758:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3758;20:T4a8/j28a2a6pIosRT1T28p3wdIQoB+bSCILmH70U94DxaKqwqO4VEtr++v29chIMiAPC9TG4SIPw8MIviO+sU00Wwo+mcXXDr731eIVez2fuhrg6bD+kxin6MX6KThEn+lYJ+uSZfVL3QbA7u/z+xxfxJI7pYxTVwTiiDRGo17k7HbK3lphHvQdFVjbZI/nqm5AL1lv66+wBU3lgPzgudRBPNwgE2GaVN5k4eZ673ZLjWgTQ6HZ4/IOlqzO65RoReu1jjqiP14Zed8IcRw/ALuPTPbp7fCeVsFn4pJJni2zK+NmlXP/6x7/rd7RJ0DIvAHdYb0YISYT/qcho5bc5cX0cVgvw1Y/sbVMaurrvvbJ9p3X7eZ/szsvzmyh3EThVAZo/w9aV2JolTXA1r6VarTxu/uN76iuxn7JVfaOrQBrwHe7jj0xc8ULKD6Q/qpvGTzPz/xrTgYoq+nYlkXytVz04l82io5LQxnTfCw5XDs7dOlp0kU1sQqO+mRCuk4R
X-Microsoft-Antispam-PRVS: <SN6PR03MB37586F2EF998CAA52F05E2E09D740@SN6PR03MB3758.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3758;23:pxgytP0IFfkGCRsfKIF74XDG5gRzXtkuK53AuwjiK?=
 =?us-ascii?Q?H0upL5MOR43qpp8wtk0OG4vVHNMY2xNUWBcnVTEisNmvrMQYdlCowgk5xoB3?=
 =?us-ascii?Q?6XY1Fz1vrWPKTwBGM2E7Ujkihu2HGIGLvKzUCSjofAKNAoXKvGfyUTSl/YMD?=
 =?us-ascii?Q?MU2sCur04I+b4t0m8bPEDYyrn1LQ2c0beWfKrTL1DBopQAPKNS2Ytn7okIW9?=
 =?us-ascii?Q?y4N84A8IHR+jGR26pqt5sDLWYgKAhpqWVVEV785EQn16vRKUurFHx+0EFGyG?=
 =?us-ascii?Q?FsdWyK2j0+5RH8gJUyzy2e45OoJbX2OXNnm05ItLsF4tINygz/jzY4Jwk4ps?=
 =?us-ascii?Q?EoZrjKwvLCrTTA5/F5CH6uz+8hRkcYpxl9wIf97fYdiBHDGfQHW78b4phMyy?=
 =?us-ascii?Q?iDbtt5uflzmSh9Z/WVngDG2ZGLsyMg+Og2YCtwysqxeyhSiPYQCbcyoEuST2?=
 =?us-ascii?Q?2U96Ydt9cD5DgBwGp/tzld2ZX4WCeJE40NhCoggEov40MVAjFYLNJ9mszbuS?=
 =?us-ascii?Q?xplzQPiDZIqpdXPtQoKRnDP5CU98DSi3wqFd0d2OwNX6YCG24ibeoAr9fXj3?=
 =?us-ascii?Q?ZiQCBtjFlQfZnOvEX6Fmb3TXwD+PTPsIM49cKrxKSqlFaxQZQ85dovZaUf6+?=
 =?us-ascii?Q?PcLeAIZbSA2TNEf7AhBwt8oTMuoOAjX3TGi9tl+BUtXudlO2K4zd27VekXlK?=
 =?us-ascii?Q?7wOVEQVGQKLQcwmxBNAIYAQeSj0QWvU9uHuETN+Jc62+RIy0DThacOz0Ngje?=
 =?us-ascii?Q?IDJgFSIswiG3BhNj4O+zXVZFNUY3pS5eqPy5n1YJk1ejEb+05cqfkFvRSkuL?=
 =?us-ascii?Q?d/+U+SXhB3K2sYs4ke2JmadkyOJBVTLAfeO+sXpSzeoULqQzuKEQv8HJUjwX?=
 =?us-ascii?Q?+WCsEn8Bddy6OPqu7oKDXx6LM25qz7BCRJqwteODO5REw3hZX2pWipfZ5JL7?=
 =?us-ascii?Q?25eqkVtPh8rVe2X6JpYdqJqha6NGTZOpBUvNyg/g8Dy4hiCfAVVjp03ZFktJ?=
 =?us-ascii?Q?AkNERzEo20lBj3m8TX19fznmGzBcjXEyuhBgcFVEGKbcw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nMRiAAqc/rV1dX4dr0WNEZ3Rz/BxvmHXQO0FmWV1CoZFk9/e1Mf7NA/lbCzYLFQzyp64X+J+o5BsUGZI89Y/G5HB89cQwUFa5/EaciF0t/gCEB3efkz/orRCt0kUfy+SlJZMY+ODq8xbGBloOB9p7i/TLQqz2Chgv5P4OhY+4fedAzU42UIMjo7Cg7lV+wq2UhDH8dnnoRnvWBoIyTyhvbmg6DF65OoUQ/gv7XAU70ofDnaJOFco8xDmO3FHJ6aR6jHrlTRrlkrMBO1ltIwEDWbEH2ecPtbBhKD4Uv3K/MXiXW+bNs+GbbFsktClSUVr2bkaiCEcY9GiWEJse2nA9ZHRnafRYZ5fWrLGUIaW2DdYtIxeKbzJgmCPI2vtSzy31X0gwTSLVuaqUotspqbt/ulUxx01pvNeTE4RYQc5ELI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:14:36.5680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33816f2f-77c1-43dd-d450-08d69cceab58
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3758
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
* Deal with sampling and filter freq in a generic way
* Add missing docs

Changes in v3:
Patch 1, 2, 3:
	- Nothing changed
Patch 4, 5:
	- Added to this series
Patch 6:
	- Added support for sampling and filter freq
Patch 7:
	- Nothing changed

Changes in v2:
Patch 1:
	- use DIO1 pin as default data ready signal instead of DIO2.
Patch 2:
	- nothing changed.
Patch 3, 4:
	- give the scale directly in the adis16480_chip_info struct.
Patch 5: 
	- document the use of DIO1 pin as default data ready signal.

Stefan Popa (7):
  iio: imu: adis16480: Add support for configurable drdy indicator
  iio: imu: adis16480: Add OF device ID table
  iio: imu: adis16480: Treat temperature scale in a generic way
  iio: imu: adis16480: Calculate the sampling frequency in a generic way
  iio: imu: adis16480: Deal with filter freq in a generic way
  iio: imu: adis16480: Add support for ADIS1649x family of devices
  iio: imu: adis16480: Add docs for ADIS16480 IMU

 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |  49 ++++
 MAINTAINERS                                        |   1 +
 drivers/iio/imu/adis16480.c                        | 253 +++++++++++++++++++--
 3 files changed, 290 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt

-- 
2.7.4

