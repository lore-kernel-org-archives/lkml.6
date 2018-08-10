Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA2C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD65217C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WF2SMl5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD65217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeHJLSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:18:06 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:7392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727117AbeHJLSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9/gc0dZfify1AZUS+ZCxfyxXUDUsTquU6f3WiIl5U4=;
 b=WF2SMl5poyiewnYWrl8TxvYq4vYlyMnx+Z2IrJlypPFK2ER/iDQMohzK3mPP16Ms6OLw+sUmmNEfhuMhCcl4soQiAmpCw0F+P1H8PKjV9jDToQF/JMeMlaEQzJKnGgFwkZFXPejXjcWE2o1xvjODVjxrqVroK9f/vSqPuhR95Ao=
Received: from BN3PR03CA0069.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::29) by DM2PR03MB559.namprd03.prod.outlook.com
 (2a01:111:e400:241d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Fri, 10 Aug
 2018 08:49:01 +0000
Received: from BN1BFFO11FD022.protection.gbl (2a01:111:f400:7c10::1:144) by
 BN3PR03CA0069.outlook.office365.com (2a01:111:e400:7a4d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.21 via Frontend Transport; Fri, 10 Aug 2018 08:49:01 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD022.mail.protection.outlook.com (10.58.144.85) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 08:49:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8mx9R019342
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:48:59 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:48:58 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/6] iio:adxl372: Add FIFO and interrupts support
Date:   Fri, 10 Aug 2018 11:46:21 +0300
Message-ID: <1533890783-13456-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(77096007)(186003)(575784001)(50226002)(356003)(26005)(336012)(316002)(54906003)(16586007)(110136005)(8676002)(246002)(486006)(2906002)(106002)(44832011)(36756003)(8936002)(48376002)(6666003)(426003)(2616005)(476003)(72206003)(4326008)(478600001)(126002)(5660300001)(53416004)(11346002)(446003)(106466001)(7636002)(76176011)(47776003)(7696005)(51416003)(305945005)(14444005)(50466002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB559;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD022;1:GMcQUdNSYckTSaO469aNAjafXBFpYrrjYr5TepGEPuzKRveZ6su9ToIRlIvyU3ejXMSIhdXnGgkTBzEfmws3w+fOdfF3C6qO10cLkSSB2YoO6/zQ7rPCLNbhZMe8L0VI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b357770-ee50-419e-80ba-08d5fe9e1e50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;3:bAA2oMs/0oW8G3O261srFNaQQNFsPHEqumhv1Wkjrrjdx9TxUir1Pou6hQSE2AwTurE0g4YS8WRZ35PJgDET6zWI75JY9Lv3eYakGwT4GlYLI1PHHQnCKirH8xj2Fg0dMuJWDxPMCaBfU93dkHkc6oZN1x+2Z1p6S+iOYXwy130CVHDxWyEBcwmADCXVvt+i44NoNgAib+Hcl8TBlTtcWdfX3/pUfIY6sGq7+NxTw6sBB8rIRHCggmkd5DIZUXXEFzV7SX+IxpFjn9dFFnaDhPy2+RyMjBUfwueC/OlFmCv5GJIS3qZH7vhAo4XdVOS6BIWjwediHUabROWD1+chqWAW/1DZAOgSmA56YfuOtkA=;25:n/k8sQvkd7WkQt+hgImIJ+6iBcLoPWYVLouZSRz+8FWI4V0Kb3IiKG5csfu8WkM71yDJRvma4QFo73s/FlaoZjyGG2VdodCqer170IcPXTGEe2nKoGB6gOYh+x7vzoPG9xu8MT4GDAYab0oZSdubZ4Yzku7Oj3kFjqYikkfjSHxXm8NvFGbZdYgMkumOP9mdpH7/YhVhZz/pc+a05aA6jF0uoSY52dzylpqwsziQWcs3k3vChXWnEwCPkvnFhD7gJfmMyvcvbkF6VHsm6vmCCBkXOttdW25WLn4+ZZHmu/+wLAew/PLdx2rI+yJoOiS/HhUiCEfr4vke6+6MG4zo9A==
X-MS-TrafficTypeDiagnostic: DM2PR03MB559:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;31:0RbCG7ZwH9FeVNfsOjsDMZLrVBL0fsWE7WdVijJUd3rgTby2hvivS5jiRWAGHJVWqbCHBq51ZNtyWBKJBvzedvpNqR1fSSPoXrv/hbQBGufzSf8/0qqSt6/j64yGRogSk/OGtdfZixqmAo0iIblN5PDQYoZ4wxg+1GyI3+/QHsRhZPuScDIBEjFpo9CDXa4LvGyMr0u95bfTgK9FOTWkluiAw70qvmr4u+eUXrufe+I=;20:4dvigPCkKrjkZVVzvrxPFrkkXppAsi4RFyxVCKSuEeU7jkTyxJs++nwQ9iyNbb4LpDEYTK1Yf5I60wSROsgwQkxCxF35HGtaPNj3MEw16/Qmr39qTySZzV+JD6e2a93FeCznrwBCLdSmv9eMLd92PR4u71HsjZa0FLNRcbD5O8kHTfpkvYm8R2l3cag6k4YlXkKJ/gFtP7svIDi77C0hxAPK7y1EeWolADGGyZA4ax80DewsPcGMGUFhWXLvpyC1uYd2BspmQmrvhW4KUj8XytTCEt7wM2K/U6DpKmKLTSE+s5zaOdyK0WuRERTMZLx012IiDd5E5mBos0HBfLnL2O9IbHwyQd34lIGrINavsnfpCRSyh0B6GjkKLxZkumIY/g0gXrIN5NkI28pDVVU8uUaUKaO67ZTvs5Z9dxBBh7hA+y9Y/D64B1SrPrdm21aEh/lOseDnqcmnQO3Wp5KRU911t2oPMNWV6Rl0EzVwpv/r7oQtkBrRjS4b9tqz5KQp
X-Microsoft-Antispam-PRVS: <DM2PR03MB55989D6F365487E17BB048C9D240@DM2PR03MB559.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB559;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;4:N+jKSBuGfcI+FTlpsJx+lM7XHiYy8881GneuWXfHv2UVdwBPfmCC+fGnlcjzjz00Ca2rxbx2+Cm/DEcAGU412UKplsFA/cGwZlox/qGEOsCIf6w/zix6hwtyvmZaWx+4uacahprgSgilMg/2FAsEgi585PyGNNjXlpPix738+S50/x9ADg3+33MmcRu/KSlS2s9sqFFzSpdkyFVdlgcVRtdiM3rq0UJmXtuKC5Ae4wo4189wHCIGBXva61egjbHsVAjZ5NGcxjG1or/qRO8uToJMfCqrBzU5+AAJowmEh6iPzLYTn8Jv7VMp8OpzD5BH6/JgcHXtjOy8PAZhqx2uBVZYbvz4dFr2wFVm9dDjYxI=
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB559;23:kg+ij1Lvz2ic6qj4sWDhCtmoxKvMyutYh2OtN/UZi+?=
 =?us-ascii?Q?VNLp72utSt9WjR/He7dFoU3j9pBNtzUhPIRV/U/2twpTY2nCf8N3J+bdokf3?=
 =?us-ascii?Q?e/Mt651vqs/d63J3Wn855ck4h+MI4Zm9EORWwC9vzunSuHJCN9a8emvPLucr?=
 =?us-ascii?Q?xxKBWxE108r1+5uc5Tmn1bpm4quv3KWZEMoKJe8e7kJsKoJc5bMRx9khXM3z?=
 =?us-ascii?Q?fhPtIOkXZIvX7G1V4/Ki+JgIKyQs1kTwc/0NHvXJJIcPAjC7fJjXCr6xs9fN?=
 =?us-ascii?Q?jd5O2gmX61wEOiDuxBk6sjwFA6gvvLvVJnb3NZd+FuO+qjeO5Wj7LMn/n5PZ?=
 =?us-ascii?Q?CzF5+FUuUPBKc5fxj5U50jUPAVylLzyeGJ+jLkGWMERWp5GdPal+Y+OdMGbW?=
 =?us-ascii?Q?XI3JKYNsjwOzOKvQ4R1A8O5mnkapPNH0IiDk5/2ByAu+cwybCeYlnriZBTb6?=
 =?us-ascii?Q?VmwVzlY/genMKsBsNwl6++YPitOlJScShJu1W/qut+pU3DS/pMZ+fDVyK8Td?=
 =?us-ascii?Q?txUNKfYiJ//WjgxvgdS3Ha+HVE2jUZf8es8vVIaT2FRxeLedoIjtujPpIYm/?=
 =?us-ascii?Q?QhcEo9j6KtF1redw9ACVTVzUBdL/++88JXFoApQN9XU10/dHa3ZnW6PlG3bk?=
 =?us-ascii?Q?RXDMCbR2kLUGNoVWJau1bDlQ25lpivUnl7RI6Ul2XgyNJWo1INp08t3WHh92?=
 =?us-ascii?Q?eipnAPw3WYV7RF/vQv4II3++GUMXQDnIPJM0RxdoA/5R0xcBzllcZFVbv3z/?=
 =?us-ascii?Q?ExveH8Baq/mjUcRpTcjsk3uO2twddCO3SAtpfgVRD5NKuDxKontyu4p9uwKe?=
 =?us-ascii?Q?2KpQPFudXOQTTluZK8tmg06I6b+mYagqADDVHZhRxBqvWvjSDU3nY13OhpNN?=
 =?us-ascii?Q?c/hJfCGT5VNy1L7ehTAwmsb8C7ferXn69Jw2CJRqcNK5AOOd71mjo9AN59tc?=
 =?us-ascii?Q?Ql62Or2miZ2ZtzKV0tblxWWU6qth0dNgHGuDFb0kr8EeHdk12vwzb55jO2js?=
 =?us-ascii?Q?LSIU/GYE1H2zQxMs7EajsK7ItbWSt1xb+Jj+agIN7trZmGRIvrIBPlHQZtk4?=
 =?us-ascii?Q?axvRDcx1cBCcAcuR6zmJmvp9xZLinK03r8N00UZq8TtGRx7C9E3nUwESd2Ky?=
 =?us-ascii?Q?o+LKkpq5Q=3D?=
X-Microsoft-Antispam-Message-Info: VxnaU3qP4mhgZgxDt2U64le7xENEEDTXzhqYK52eWkRyNBfwtr8yJE0o/Qs2iADlDQRpsR2mc2Y7nGr9CQMb046SADZhStBygh6t2OuShUn4Zoy/dAf4LJgpxQYm3xWShiyH5LcaXXFsEmhvdCgjIoV8Qba8Sj7e9aphCr5lTZyxO4hnKLd2kLrZdCsxTJ9HMzqfjTlHNnKPqW89oqUaYSHhX2G2x8cwvL9FQxvtmEnDxTfwXq+403AtjMmHKbNeO3q/KfFVkvjGfD55jZBap4wdsV1cJOXjCZ21t3f/LnIi84wi1zcDGBZBhlCLH7yid/1eYB5mmPLl3hqVCHfzC5f6JF07l3I5l5NeBwo7IMk=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;6:rpCunLeYmi0BplXIre5bjw7Ko+W0CGWz4Q+IiPOkJsr5r6oFtT1I63QggN92WHTTrMA2ZntDCCmeNZ6GPAgX+zzZqDYCefwkCNBEE2Akw6QuKxqoFhcWQPNDsunhP/dsuztwnswM0Ifvl7WEjNwf53bYFPNAxgCYbJ5cTgrBEKYDjrgjwIniQEJ6ivsFY+zkH8+7mwWQNDecXs/fHS1JOl+wlIxDVW8WswSodK+duOTSThrj33W9aSARQPaKMf0NtC7bmvDiOTmFb67nwsLou9fxUaoSnKHxuGW7MG4WfkVJQcH66uSnUY0b6mj4O7ia+XeXtSuDD9ZRXIlCEkuCi2cChLznWhnuw/cHzd0kLXpPJ2kZrYUdDBcfTXxq4TXP9XSkz2bijFHxuo4XvHmpKL3Xo/u9+9wc9ceBpdJensbNn34792ZgzmYQzX8Ple4dUJgyM5Za5HIbCtlssgKElg==;5:e8I212Eh6bPCeVyNlPlhAKvuv5d7O5gAERCLew99AmvjczSw4a69smeJ9hWewyWOscHIC4PucipoS1gW8vf8rNkmEmCLQUu0gRSNuMfaG298431HtrfhgTomS4EwHGDmmx012cJd0EhnFqLF9t/5dSlUyBM9wd7rEOPZ40wJEcs=;7:3PczWhGb31oup2/+vW9h7I3hf++r22NNjApRTSzokS33QUxTZVFWTNp6TMqiKyiNwaVb6q4HoNUu0bU1tc+/E5VSI+YCHwwDI5uCoUjmBjTosFc04aXs8s/5DHwiJQhltENnikPiZD4XCtpMqvmoSGRrbeL1BttDlGBt3pvjkadnS6qCht4t+mU3VGOJku4ji1LQwPEUc5QZJKZ6iZSes9s0GWCzI9fg2CoDvrVRObEvjXy/sOiTeL9cyay7Khy8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:49:00.0767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b357770-ee50-419e-80ba-08d5fe9e1e50
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the adxl372 FIFO. In order to accomplish this,
triggered buffers were used.

The number of FIFO samples which trigger the watermark interrupt can be
configured by using the buffer watermark. The FIFO format is determined by
configuring the scan elements for each axis. The FIFO data is pushed to the
IIO device's buffer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 357 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 356 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index db9ecd2..1e2519a 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -6,12 +6,19 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* ADXL372 registers definition */
 #define ADXL372_DEVID			0x00
@@ -123,6 +130,9 @@
 #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
 #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
 
+/* The ADXL372 includes a deep, 512 sample FIFO buffer */
+#define ADXL372_FIFO_SIZE			512
+
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
  * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
@@ -170,6 +180,43 @@ static const unsigned int adxl372_th_reg_high_addr[3] = {
 	[ADXL372_INACTIVITY] = ADXL372_X_THRESH_INACT_H,
 };
 
+enum adxl372_fifo_format {
+	ADXL372_XYZ_FIFO,
+	ADXL372_X_FIFO,
+	ADXL372_Y_FIFO,
+	ADXL372_XY_FIFO,
+	ADXL372_Z_FIFO,
+	ADXL372_XZ_FIFO,
+	ADXL372_YZ_FIFO,
+	ADXL372_XYZ_PEAK_FIFO,
+};
+
+enum adxl372_fifo_mode {
+	ADXL372_FIFO_BYPASSED,
+	ADXL372_FIFO_STREAMED,
+	ADXL372_FIFO_TRIGGERED,
+	ADXL372_FIFO_OLD_SAVED
+};
+
+static const int adxl372_samp_freq_tbl[5] = {
+	400, 800, 1600, 3200, 6400,
+};
+
+struct adxl372_axis_lookup {
+	unsigned int bits;
+	enum adxl372_fifo_format fifo_format;
+};
+
+static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
+	{ BIT(0), ADXL372_X_FIFO },
+	{ BIT(1), ADXL372_Y_FIFO },
+	{ BIT(2), ADXL372_Z_FIFO },
+	{ BIT(0) | BIT(1), ADXL372_XY_FIFO },
+	{ BIT(0) | BIT(2), ADXL372_XZ_FIFO },
+	{ BIT(1) | BIT(2), ADXL372_YZ_FIFO },
+	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -177,6 +224,13 @@ static const unsigned int adxl372_th_reg_high_addr[3] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 12,						\
+		.storagebits = 16,					\
+		.shift = 4,						\
+	},								\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
@@ -188,12 +242,29 @@ static const struct iio_chan_spec adxl372_channels[] = {
 struct adxl372_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
+	struct iio_trigger		*dready_trig;
+	enum adxl372_fifo_mode		fifo_mode;
+	enum adxl372_fifo_format	fifo_format;
 	enum adxl372_op_mode		op_mode;
 	enum adxl372_act_proc_mode	act_proc_mode;
 	enum adxl372_odr		odr;
 	enum adxl372_bandwidth		bw;
 	u32				act_time_ms;
 	u32				inact_time_ms;
+	u8				fifo_set_size;
+	u8				int1_bitmask;
+	u8				int2_bitmask;
+	u16				watermark;
+	__be16				fifo_buf[ADXL372_FIFO_SIZE];
+};
+
+static const unsigned long adxl372_channel_masks[] = {
+	BIT(0), BIT(1), BIT(2),
+	BIT(0) | BIT(1),
+	BIT(0) | BIT(2),
+	BIT(1) | BIT(2),
+	BIT(0) | BIT(1) | BIT(2),
+	0
 };
 
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
@@ -359,6 +430,112 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_set_interrupts(struct adxl372_state *st,
+				  unsigned char int1_bitmask,
+				  unsigned char int2_bitmask)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADXL372_INT1_MAP, int1_bitmask);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(st->regmap, ADXL372_INT2_MAP, int2_bitmask);
+}
+
+static int adxl372_configure_fifo(struct adxl372_state *st)
+{
+	unsigned int fifo_samples, fifo_ctl;
+	int ret;
+
+	/* FIFO must be configured while in standby mode */
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	fifo_samples = st->watermark & 0xFF;
+	fifo_ctl = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
+		   ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
+		   ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
+
+	ret = regmap_write(st->regmap, ADXL372_FIFO_SAMPLES, fifo_samples);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL372_FIFO_CTL, fifo_ctl);
+	if (ret < 0)
+		return ret;
+
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_get_status(struct adxl372_state *st,
+			      u8 *status1, u8 *status2,
+			      u16 *fifo_entries)
+{
+	__be32 buf;
+	u32 val;
+	int ret;
+
+	/* STATUS1, STATUS2, FIFO_ENTRIES2 and FIFO_ENTRIES are adjacent regs */
+	ret = regmap_bulk_read(st->regmap, ADXL372_STATUS_1,
+			       &buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	val = be32_to_cpu(buf);
+
+	*status1 = (val >> 24) & 0x0F;
+	*status2 = (val >> 16) & 0x0F;
+	/*
+	 * FIFO_ENTRIES contains the least significant byte, and FIFO_ENTRIES2
+	 * contains the two most significant bits
+	 */
+	*fifo_entries = val & 0x3FF;
+
+	return ret;
+}
+
+static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl372_state *st = iio_priv(indio_dev);
+	u8 status1, status2;
+	u16 fifo_entries;
+	int i, ret;
+
+	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
+	if (ret < 0)
+		goto err;
+
+	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
+	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
+		/*
+		 * When reading data from multiple axes from the FIFO,
+		 * to ensure that data is not overwritten and stored out
+		 * of order at least one sample set must be left in the
+		 * FIFO after every read.
+		 */
+		fifo_entries -= st->fifo_set_size;
+
+		/* Read data from the FIFO */
+		ret = regmap_noinc_read(st->regmap, ADXL372_FIFO_DATA,
+					st->fifo_buf,
+					fifo_entries * sizeof(u16));
+		if (ret < 0)
+			goto err;
+
+		/* Each sample is 2 bytes */
+		for (i = 0; i < fifo_entries * sizeof(u16);
+		     i += st->fifo_set_size * sizeof(u16))
+			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	}
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int adxl372_setup(struct adxl372_state *st)
 {
 	unsigned int regval;
@@ -438,7 +615,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		ret = adxl372_read_axis(st, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -454,16 +636,153 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t adxl372_get_fifo_enabled(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->fifo_mode);
+}
+
+static ssize_t adxl372_get_fifo_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->watermark);
+}
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_CONST_ATTR(hwfifo_watermark_max,
+		      __stringify(ADXL372_FIFO_SIZE));
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adxl372_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adxl372_get_fifo_enabled, NULL, 0);
+
+static const struct attribute *adxl372_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int adxl372_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adxl372_state *st  = iio_priv(indio_dev);
+
+	if (val > ADXL372_FIFO_SIZE)
+		val = ADXL372_FIFO_SIZE;
+
+	st->watermark = val;
+
+	return 0;
+}
+
+static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned int mask;
+	int i, ret;
+
+	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	if (ret < 0)
+		return ret;
+
+	mask = *indio_dev->active_scan_mask;
+
+	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
+		if (mask == adxl372_axis_lookup_table[i].bits)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(adxl372_axis_lookup_table))
+		return -EINVAL;
+
+	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
+	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
+					  indio_dev->masklength);
+	/*
+	 * The 512 FIFO samples can be allotted in several ways, such as:
+	 * 170 sample sets of concurrent 3-axis data
+	 * 256 sample sets of concurrent 2-axis data (user selectable)
+	 * 512 sample sets of single-axis data
+	 */
+	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
+		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
+
+	st->fifo_mode = ADXL372_FIFO_STREAMED;
+
+	ret = adxl372_configure_fifo(st);
+	if (ret < 0) {
+		st->fifo_mode = ADXL372_FIFO_BYPASSED;
+		adxl372_set_interrupts(st, 0, 0);
+		return ret;
+	}
+
+	return iio_triggered_buffer_postenable(indio_dev);
+}
+
+static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_triggered_buffer_predisable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	adxl372_set_interrupts(st, 0, 0);
+	st->fifo_mode = ADXL372_FIFO_BYPASSED;
+	adxl372_configure_fifo(st);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
+	.postenable = adxl372_buffer_postenable,
+	.predisable = adxl372_buffer_predisable,
+};
+
+static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
+					 bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned long int mask = 0;
+
+	if (state)
+		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
+
+	return adxl372_set_interrupts(st, mask, 0);
+}
+
+static const struct iio_trigger_ops adxl372_trigger_ops = {
+	.set_trigger_state = adxl372_dready_trig_set_state,
+};
+
 static const struct iio_info adxl372_info = {
 	.read_raw = adxl372_read_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
+	.hwfifo_set_watermark = adxl372_set_watermark,
 };
 
+static bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
+{
+	return (reg == ADXL372_FIFO_DATA);
+}
+
 static const struct regmap_config adxl372_spi_regmap_config = {
 	.reg_bits = 7,
 	.pad_bits = 1,
 	.val_bits = 8,
 	.read_flag_mask = BIT(0),
+	.readable_noinc_reg = adxl372_readable_noinc_reg,
 };
 
 static int adxl372_probe(struct spi_device *spi)
@@ -490,10 +809,11 @@ static int adxl372_probe(struct spi_device *spi)
 
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->available_scan_masks = adxl372_channel_masks;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &adxl372_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 
 	ret = adxl372_setup(st);
 	if (ret < 0) {
@@ -501,6 +821,41 @@ static int adxl372_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
+					      indio_dev, NULL,
+					      adxl372_trigger_handler,
+					      &adxl372_buffer_ops);
+	if (ret < 0)
+		return ret;
+
+	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
+
+	if (st->spi->irq) {
+		st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
+							 "%s-dev%d",
+							 indio_dev->name,
+							 indio_dev->id);
+		if (st->dready_trig == NULL)
+			return -ENOMEM;
+
+		st->dready_trig->ops = &adxl372_trigger_ops;
+		st->dready_trig->dev.parent = &st->spi->dev;
+		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+		ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
+		if (ret < 0)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(st->dready_trig);
+
+		ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
+					iio_trigger_generic_data_rdy_poll,
+					NULL,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					indio_dev->name, st->dready_trig);
+		if (ret < 0)
+			return ret;
+	}
+
 	return devm_iio_device_register(&st->spi->dev, indio_dev);
 }
 
-- 
2.7.4

