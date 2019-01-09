Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB24AC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68D3214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NizfxGxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfAIJOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:14:38 -0500
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:8672
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729996AbfAIJOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaJp6RZ/TI1fvbn/vkyEdxxAbyLwjows7VDMx1+hEM4=;
 b=NizfxGxnw1702O5NzMQJJTnxoK0RMSFhF5uaw1RegVI7RgEPHZHbBcMTO7WmSSO3eGdsvPWflpjI146OrZFs51WefBaTc0gtBzvx1dFdtewjWO1P3m5kNIh2f0kflTEGOY+V2qnIllxcq12xkJZCAnlPUbIlP+p76dWyO5uykhc=
Received: from BN3PR03CA0110.namprd03.prod.outlook.com (2603:10b6:400:4::28)
 by MWHPR03MB2477.namprd03.prod.outlook.com (2603:10b6:300:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.13; Wed, 9 Jan
 2019 09:14:32 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN3PR03CA0110.outlook.office365.com
 (2603:10b6:400:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.14 via Frontend
 Transport; Wed, 9 Jan 2019 09:14:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Wed, 9 Jan 2019 09:14:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x099ETj4001228
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 9 Jan 2019 01:14:29 -0800
Received: from mircea-Latitude-E6540.analog.com (10.50.1.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 9 Jan 2019 04:14:29 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: dac: ad5686: Add support for AD5674R/AD5679R
Date:   Wed, 9 Jan 2019 11:14:16 +0200
Message-ID: <20190109091416.12060-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(199004)(189003)(126002)(426003)(6916009)(575784001)(72206003)(2616005)(246002)(478600001)(1076003)(48376002)(336012)(7636002)(8676002)(476003)(305945005)(86362001)(77096007)(316002)(26005)(16586007)(54906003)(486006)(51416003)(186003)(106466001)(36756003)(53416004)(50466002)(5660300001)(47776003)(2351001)(356004)(6666004)(106002)(107886003)(50226002)(44832011)(7696005)(8936002)(2906002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2477;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT023;1:QPFVACU+nQkl0jAhELkyjT75ESHpVNj7dGdQJqxMrVcEupjzZJnMUCree+rz8UShLiC2/+Yfcw96pNq/QQJ9NCCjLRvXPEn0zpuDFzEWODOpTkR8cOy74V/ZqWCOq90J
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1939a768-33bb-4eff-230a-08d67612dcf2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR03MB2477;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2477;3:eaSbAxEP2H5ATCh1JCnTMwwCtINGX/Y3Lxd+WVHXUmh1uzynxwvbAiulkP7GOhQglHxkgOKSsIqRXQtyTUzWjddwS4QT5xYnlG20ZD4cdqRt+JwwO+hWWHL+/9eyoCoJRm/OAsFMKx4oKNnGa7L09SVcRdhkTY31om8PX2uZ8MSU/iTW/At1El9jef/lpFCAFOlm3JLPiIc+6ooSw8GeXFBCHSTdAl3dW1YlebD3yq1W9d8pk7wExaDrHc/qw7ByzIxsN+qz3T3qDIjXRJlZfag0BrwvkL+FqY27wRm2m6ZNKrGvKwo61Ixi3W/+4D1tcrT40eByephDDW5QY2Q2MBTD2qsbNGfwQsEtdCr3t8LbUfIUF0IgkQN1OhcOuHA0;25:q4fjUJf2VFZbEx6oDfmhBdVdL/MfVWs0dcjGL63rXNQVUL8hNMG3CH15xMg4TiytgIYhl+RImo/B4lVOhXGwKZfuFhezuxr/x9wYTdWx2EC9ywOa+vUTBwt7Jug0XjlAXHjeBMQJHDjXC7xPUDjTm3rHs/UNAi2DhJwacI4iaTQaGZBol1z0Xe5CS2wy3gdF7fCqX4IraoUVO7qNm0rpfyChpmM6iYrL8+j6nx4M0dnQ3JVknVsn5U3LbNrIHydFcXkrXs3qz+VilmhTSVAeeK1ZqhW+Zs0ttOilBlS3JLv2eKOr8IbUnaacKd1mQmUZ06/EJweys6apZpW0SNaHjQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2477:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2477;31:6j+XkBsm7ujubtVxZ4C+VSeoGfOvo+ZU6xHNUCheYBUD1H7nN6ogHOwj2HLf69GOIxdc2tFnJBSz7ltQLAHUanA/au8uIFTk4koydAGSdUs94PTaxisCcgvoFICpJeuZMXLUuTje8+UmoSJOAVbtO+inihYyjkZ1I2T9mKxa3960NmoCHvXrt8wOYKfzN3qvKT1uK1+p9hbYIULvtORaljpQsI1OlPAvDuVOgpktI7M=;20:QQ06B9f5evCbK7F9XUVov7WnYEl80BZHqC4f7P72SWR8Le7O+/+VxOK91tVdj0LDWXrXJ+oeUDUltM2nj13CMlHsnH7Xh763GEkjh7eqfGy+3WlJkq4Q0JDZFHzrG497Q6Oyy5qyHft03gI68+GYU5Z3MPc2PnRJHLcocd+7AEIuuuiCnBWcwbq1cgKcvyv9+9zvRvC9kp0fhXXKoVUPy1oW7yN5axuTO0QFJBKUEWlQ+ZDIxb7n9BPp/f2OanwsNwbZ0DJNIZjL3vzdIrxa0LePBuKCWKuJ0Min0diMxvTe0Y9UritIxnRfeMGZlAotYzXZyrTmE4WyCd4rMHZ4vI4CYWLbm6Gs378lRtOg4dCr94TAdMxRjB4deo+an64F/H/nDzCfvaAfmJRV/Bzh+PBpIns7p3lU5Cw7CFFkFqjXGDe8PD7a4I8z4WOP9spZ+8BerI9m+Btut2jlF0Xgwkk9ssMLveZoWPKDx4OaBQ6X0rZlUGCx0MtZNdTQKp5h
X-Microsoft-Antispam-PRVS: <MWHPR03MB24779D6C3D30B8253891C020818B0@MWHPR03MB2477.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2477;4:AzliD9isQ3xxKB5GG/O0RLBfqKG4bZaExlN++04VlJY+EhkdsYqn9OIdlzO0H0LU/cqwETY05c3wNhhtS2MA3Ud1ax3MfDmThtEiLcC06ieaVxDFyEJlMwNLwSRoM75vA0XKV3N4lL7Wm9astsK3nkf9vIYrARAMhRMxYbSlUIn45n7RhXlyHUXLpJqTlqoxGCW7qhZr3OzyxhYa1QEdF8erxp0yltj2NuABkeXLDvmOnuCI04DrVkYCgSKv08v31oofAAUGxmHvoHfJ4Cyiwl7lNY/8ilczgdsP/mauF/sZP8YWIjAf3CRl9AJ/htJS
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2477;23:Sy+UKAyDrjNnujkfjQuOOA6FUeWy72WmX5p6kJuFd?=
 =?us-ascii?Q?+6wLzPPaK4IjI58mK6eSwG40uWGyi3swKrX7O2iZ+sN1POVBaZ9z2qRGXxoP?=
 =?us-ascii?Q?NNlhRDJk5l2OFgAo+Od3rrPaqr8ECX58ULFr9wbCy17ZoePVlAW9H7FmgHXq?=
 =?us-ascii?Q?kfNTsvR+9cagWwjoaKvfrlbsEHe4kzlJdTI7/1pmFb7F3YYjTkJRJR/nQgob?=
 =?us-ascii?Q?h7pR6qPCh/tSuYzSVuIeoZ0+3S7ucvMvXn8d8PRA9dkLPpKcdt0Vh5nLbIoJ?=
 =?us-ascii?Q?q3goiqu5iL73kgaTUBofo4uJQTbJ01fh++7PQWJ2pNMdAsGayWGeJczaxV9x?=
 =?us-ascii?Q?v4mg6PsDeg1132Tg8sklhZjn3hPYeMJtF761m/RgPAORH9fLw3jAmGbK+HlT?=
 =?us-ascii?Q?QVFuL+ZjiBeYdvZQZnm5gIdZ3OlACpxLmeGVmD3HtwK4VZZWUW9JqLGhsBeX?=
 =?us-ascii?Q?5N5Z9JzhafLtQ4zQGxmK2LE4lroJJ7L/X2iwMR/7PE3EESQGbUUpDfB1CJ7B?=
 =?us-ascii?Q?2w/Cmd/YQI0GyPTlQeVxeX+AwCfmCbP1xspDkNogi56oi1e15WYphJMnbyBv?=
 =?us-ascii?Q?zxBOayIYjl9EdQOu3eWGbfNG7yEmeIIM22ZMzxCGq3o/Rp1p+9rOyU3YayE1?=
 =?us-ascii?Q?cDBwdapWz968nr8wNouahoon1awx4GWoX0SbwT+wtwGphDowOUcx99/OvvTL?=
 =?us-ascii?Q?LJfW4iNKI2yvYQP99uQ/UJBMg5qRydwqpBn2c7/3Eyb53VxkVcFZNwNN6268?=
 =?us-ascii?Q?0TV8/zsrqR6TMmYe7uiuKh02QuYk4fssSo05ITCQgdpvdaL2KM4V8wC2EHaY?=
 =?us-ascii?Q?ryblONHe+gIreB5XPXBHcH2FXEUUPhHtAbwLt2KdO+G4ft6g2CqEDTI7Rd41?=
 =?us-ascii?Q?nBuz6wk6K1Xx7Ykcq8Fjamj9xAuod9Qk5vtnsVamUDIw+D9gHdgKkwlnTPQz?=
 =?us-ascii?Q?nUa/apXvVtiotunW09c1n1AqDoncDRqQSxPGwA/5CN8cz4gLlC2XWGG31kdH?=
 =?us-ascii?Q?k1l8CTlNKiEH0ZMYS1OnetU13IK8plue+EBLJ2wCdQIe+d2Boa6cBUnXvo7G?=
 =?us-ascii?Q?I9KQDKReSy1oKKrHvTboc41veyo?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: i4Vs/OnEKgWeCoeM1cnwOkT6+zh09oPHjogAN19Gg5nzx4DKQPNGMivud3mbCFG1FvJGgWmbWzqkIfbUSG8xR8DZOdjdtnIX5OzGXDnPsRgb65aaAeh0abyoQ4URQ3nfHz7egnBLuc2lr+hqis/o4TN9zmn4jfDbhLUKMcVEMz+wnt1PZC1IweCEV6OFT1XMyH5PVe84ORnb0kcVQfylCNy8EbeJBiUmwb4mDTVV/Ty7D1+1tTqcARmGx45+P8M0JuGwABiyALPurSJQd6WIa8ZktbbFGXHa/28CgJayvILaLpmnE0/NoupDKdSipb6V
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2477;6:TpoPJs6AKFQzyIHz6SJ0ag2dJ1qMAQkErFugtzGDrg7OmQfgFZmdifEYuHY9zgoNDc/NiiQvziyoH6Yv5ZRHC7auqN1LQa7jKMqjCtS8duc5XV7jLBeY+PxJzDuUPBoLvB7T+fco9/6w7LpHQu0NOq+o/2Z0hhQpUpcdw7gx/kMPLEAAECSsPYcXWIHz2Y3WjxIYVOHdvNnf8PNdc78K4+1qEWnQbRAjAmBvy7ubL1of90aQQpdQrKDfjMUjm19KfR3qLs2niwxJuRsnJ9NOZmZwpbIl/cszNf9jHPFTAswP7YalWD4GHVSU9Z9FZwxd1DtIQAZk9XagGPVmTpmDAB4TO37G6N8qV7utNZCKXUUKTsKmDzRTKytbZHUOL4bzeODW3hy0h+P6t18f4FY+YaB3ZfvFXimcAk/e6p7tk83SRdKUrAJzRuA1mC61RQcCRInBMcon0qvZCEI6TEGUqQ==;5:JbNS3aAzrDLWEI8gsHbU5oaBOBrHbMevaEPQLrw0rBxHyFzZSJ56tYeMnSqrLwfHGC7K1UBDwZJMEUday0gH5jslvetQt4GusyN1DfmS+kBUaUk1lght1QWzmzNFowfzVD4A+s/PVu/TaLoPO/VAk7DR5Re/pnCLwYOdYsthbQF89IdrRLG9bAP2gsgxOk8KRCP1IONBMoEWhN0jPk5Fbg==;7:PVcWtbt+mLofJPXmwbZEZaOzEN/Ad2iQ5r7KQgCLUVXoJhAn+4NW5Yjumq2UVCNv9r3M4GdNdKmaBvyo3/1dSDzTom/8bVeHCOS507PYDxevl81//AOqU6cEo/s4n2Ac0PbRO/nxfhuPuJAzowNnSA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 09:14:30.3786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1939a768-33bb-4eff-230a-08d67612dcf2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5674R/AD5679R are low power, 16-channel, 12-/16-bit buffered voltage
output digital-to-analog converters (DACs). They include a 2.5 V internal
reference (enabled by default).

These devices are very similar to AD5684R/AD5686R, except that they have 16
channels.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/dac/Kconfig      |  6 +++---
 drivers/iio/dac/ad5686-spi.c |  7 ++++--
 drivers/iio/dac/ad5686.c     | 42 ++++++++++++++++++++++++++++++++++--
 drivers/iio/dac/ad5686.h     |  2 ++
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 851b61eaf3da..f28daf67db6a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -148,9 +148,9 @@ config AD5686_SPI
 	depends on SPI
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5672R, AD5676,
-	  AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
-	  Voltage Output Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
+	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
+	  AD5686R Voltage Output Digital to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5686.
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 665fa6bd9ced..4d857c8da2d2 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD5672R, AD5676, AD5676R, AD5681R, AD5682R, AD5683, AD5683R,
- * AD5684, AD5684R, AD5685R, AD5686, AD5686R
+ * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
+ * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
+ * AD5684R, AD5685R, AD5686, AD5686R
  * Digital to analog converters driver
  *
  * Copyright 2018 Analog Devices Inc.
@@ -102,8 +103,10 @@ static int ad5686_spi_remove(struct spi_device *spi)
 static const struct spi_device_id ad5686_spi_id[] = {
 	{"ad5310r", ID_AD5310R},
 	{"ad5672r", ID_AD5672R},
+	{"ad5674r", ID_AD5674R},
 	{"ad5676", ID_AD5676},
 	{"ad5676r", ID_AD5676R},
+	{"ad5679r", ID_AD5679R},
 	{"ad5681r", ID_AD5681R},
 	{"ad5682r", ID_AD5682R},
 	{"ad5683", ID_AD5683},
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index a332b93ca2c4..6dd2759b9092 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -71,7 +71,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	int ret;
 	struct ad5686_state *st = iio_priv(indio_dev);
 	unsigned int val, ref_bit_msk;
-	u8 shift;
+	u8 shift, address = 0;
 
 	ret = strtobool(buf, &readin);
 	if (ret)
@@ -94,6 +94,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	case AD5686_REGMAP:
 		shift = 0;
 		ref_bit_msk = 0;
+		/* AD5674R/AD5679R have 16 channels and 2 powerdown registers */
+		if (chan->channel > 0x7)
+			address = 0x8;
 		break;
 	case AD5693_REGMAP:
 		shift = 13;
@@ -107,7 +110,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (!st->use_internal_vref)
 		val |= ref_bit_msk;
 
-	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0, val);
+	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC,
+			address, val >> (address * 2));
 
 	return ret ? ret : len;
 }
@@ -226,10 +230,32 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(7, 7, bits, _shift),		\
 }
 
+#define DECLARE_AD5679_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 0, bits, _shift),		\
+		AD5868_CHANNEL(1, 1, bits, _shift),		\
+		AD5868_CHANNEL(2, 2, bits, _shift),		\
+		AD5868_CHANNEL(3, 3, bits, _shift),		\
+		AD5868_CHANNEL(4, 4, bits, _shift),		\
+		AD5868_CHANNEL(5, 5, bits, _shift),		\
+		AD5868_CHANNEL(6, 6, bits, _shift),		\
+		AD5868_CHANNEL(7, 7, bits, _shift),		\
+		AD5868_CHANNEL(8, 8, bits, _shift),		\
+		AD5868_CHANNEL(9, 9, bits, _shift),		\
+		AD5868_CHANNEL(10, 10, bits, _shift),		\
+		AD5868_CHANNEL(11, 11, bits, _shift),		\
+		AD5868_CHANNEL(12, 12, bits, _shift),		\
+		AD5868_CHANNEL(13, 13, bits, _shift),		\
+		AD5868_CHANNEL(14, 14, bits, _shift),		\
+		AD5868_CHANNEL(15, 15, bits, _shift),		\
+}
+
 DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
 DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
 DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
+DECLARE_AD5679_CHANNELS(ad5674r_channels, 12, 4);
 DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
+DECLARE_AD5679_CHANNELS(ad5679r_channels, 16, 0);
 DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
 DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
@@ -262,6 +288,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 8,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5674R] = {
+		.channels = ad5674r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 16,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5675R] = {
 		.channels = ad5676_channels,
 		.int_vref_mv = 2500,
@@ -279,6 +311,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 8,
 		.regmap_type = AD5686_REGMAP,
 	},
+	[ID_AD5679R] = {
+		.channels = ad5679r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 16,
+		.regmap_type = AD5686_REGMAP,
+	},
 	[ID_AD5681R] = {
 		.channels = ad5691r_channels,
 		.int_vref_mv = 2500,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 19f6917d4738..4c3e171ce0cc 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -54,9 +54,11 @@ enum ad5686_supported_device_ids {
 	ID_AD5311R,
 	ID_AD5671R,
 	ID_AD5672R,
+	ID_AD5674R,
 	ID_AD5675R,
 	ID_AD5676,
 	ID_AD5676R,
+	ID_AD5679R,
 	ID_AD5681R,
 	ID_AD5682R,
 	ID_AD5683,
-- 
2.17.1

