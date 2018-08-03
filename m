Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8C2168C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="aR/Uq/Hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C8C2168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHCPA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:00:26 -0400
Received: from mail-co1nam03on0071.outbound.protection.outlook.com ([104.47.40.71]:45440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731682AbeHCPAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL1qTg+sPvKkXeRz1C4OCz+batvn7QklUtIOlhDKhGw=;
 b=aR/Uq/HrZ3Mlsw9HSrO9ywc/63obWD9GDUOlcsSrj2WS8VWCxR/7+pT+fsxNzH6BOGGPnUCrSSRfWgfUnl0o3dkYjCK2wA9FC+lMrxMHVJ0kd/3U8EXuEQc6GeVFP+FkOF1HH8mz3l+SM8k5s6C8IgI2b5ZuHMeq+WMDHB1ed0M=
Received: from CY4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:903:33::23)
 by CY4PR03MB3125.namprd03.prod.outlook.com (2603:10b6:910:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 13:04:05 +0000
Received: from BY2FFO11FD009.protection.gbl (2a01:111:f400:7c0c::197) by
 CY4PR03CA0013.outlook.office365.com (2603:10b6:903:33::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Fri, 3 Aug 2018 13:04:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD009.mail.protection.outlook.com (10.1.14.73) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Fri, 3 Aug 2018 13:04:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w73D43ax012229
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 3 Aug 2018 06:04:03 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 3 Aug 2018
 09:04:03 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] iio:adxl372: Add FIFO and interrupts support
Date:   Fri, 3 Aug 2018 16:02:19 +0300
Message-ID: <1533301341-26560-5-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(7966004)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(426003)(4326008)(54906003)(51416003)(106002)(316002)(336012)(126002)(7696005)(16586007)(305945005)(14444005)(7636002)(575784001)(50226002)(11346002)(77096007)(106466001)(53416004)(110136005)(76176011)(356003)(446003)(36756003)(2906002)(5660300001)(47776003)(44832011)(508600001)(486006)(72206003)(186003)(48376002)(246002)(50466002)(8936002)(6666003)(26005)(8676002)(476003)(7416002)(2616005)(334744003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3125;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD009;1:Ll2UhCraazpW2Xm4fhq00T74cTU88aD7gsjGb1+DtfjJDcdzTSSgTrdBlHcQgmw3mTxl63YKiHHWVp3T4GEi6IDSJCRDP6dHpFaxYoSO5B7DqsbxAX/OP6HaFUj3m3YI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f89b853d-93d9-46d0-6191-08d5f9419744
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;3:otAo2M6QdJWTdQuyCyWJeQPFJXP1IGXXoiOn8C9CZ6Az2icCdp8+FWR3857S9uDKwLONnabRJ2ie6LseEiozXU6RbULQKu91o6x16GC0RErC2SG0LD/KBHRVTQEPDj0ZU4SpnCGZruP3otVjjnaVrhqG847pp0s1Zmd9bqjTq0Xrvaeag3KfdVvTlAArOSXJ2v6Vtruzd1pRx93aTBA6DSdjBkQq5yuxhzYfTrSvRd16ZDXWebxGtgmJdQZrqMN8b4bza3KG9xyWyqpUQcJeGIUrbfowcLyARyJrMufrOil7KnAr7Hr/rGpcIolKZ57gz4ID6esCDud751Nf769Uw4zsy7x/zND2y415LbDCddA=;25:kKGVw+PwAsdzJP9JMpUe0JrsAtue4ea6Kfb+VMcjyFbGhk8Ve/WMD3SDH72GanTnq21/tAfUQT2AN9GRz1S85w9Ib7XyOT30dcdPUTz6tFH7LeNoMf4JJH7Kb9lek18eDBxXxxqQIXUQnxQs1a4MTMz5UjXDqI+oL1QRRPBICrdA71kCXLUIEM+cQljhrWW3JCI1a2YAhhHBqp2dhEFgp8nX24rmz+jLvrANsgQSpPfyM2PL4fcUcerkyUDwg7//uW7cXZ3bPh/XSNXeIxlJ4h8Ym1PGGOt4AKiKUYLR/9lBmgHy4e02FmwbLEyPlvdoCg7lSoHQcf4GXKi6X/STjw==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3125:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;31:CuDOEDwJIV17qZviQgCSJTFgFIC1bGZ1yTZdolaZTKYsFIyq0hvrEMnXXjlq10NRRlN89YIslcwMiHV7/f0NIpSDYepMiDwhhVf5o5XnBNK2JFmPofUzE6YPDNnOrvpPNgutDhbF968VFqS/wA71A5ds8XQVC3+tm6IZQrqvdes9EpdsWYQCW/TYLGHS0w/uiPJBXYg/3MU6WHAlf3fUwXRhY+ncpzA7/4/qm7/WGVc=;20:H/xm9Gv6QDCF8m5NHC7zbUtnPLxUIYaKtnQx2Ba1TGqRxbnC2B7PCW6FX8rOR2xibKHxYegC/vzpo6ftvE6pYEsQeNQBpiWbcZyzLf6YrtK0umreres9f4U5RHw9MlpuuCaw4+HiKlPHXPla7B8xI7+kc1kQNUSawR0WwhBQQSWbDv3n0gVtB2/LHUAtfFL3dIBvbdR+Tm/IH01yJLSPi7rxnGywyEQvgVA5iIVWM7BMW00YFEqgs5vbCV/7XTHgHOsi1l+PueCI6/tCG4Vsd0XZb1Nufk3QJELgZowinQFH9ZCXSTBj2tQOIp8CZlwdUostprkakFViVzakWkak8uHp7+qhAjPui08hrHJ2zEU9Vm6UjfiKNHdSqbFTKCACJ7RRRf52qbOqF5KmOMpddaZizPVZcwN/g0VhMK/czFWdIIdvohrw2Oxtw5VTHEbZh1of0v4xUcWeummwkhPSyO0lN3NFY/JcH4Mxs5Kv/mnsrIqH0Dm+rc6yxE4SzPok
X-Microsoft-Antispam-PRVS: <CY4PR03MB3125BF0EB97646ECD99163D49D230@CY4PR03MB3125.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3125;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;4:PSu81LYwGSHXO1sV30NcuNigzaHSAgpBjhvS/6UecN/f3AVgqSl/w4psQ5PY9BMF+f1MAC6oPy6iMbUk+Wghtjq/rDMrB6YsClaTK5QIWmuj6rqUjK2xTQOzXcNf28r07A0v25eJBfXZAvoDTzdg95h4QSG0Zl9K9UT0vePO5FmAjVUGSoiablT0/nJ2IDNt85qZ8tQAZKMhHN3swSk8MBbaPUeZ+YhHnJJAXIhO7qLP/XXADE2Fjr/uRMA3jfej/5OBqdU52WIMizMllkOe4qEcsQBwlnJ/WMzIo+kkRgD2OZY4MbdZ5PJbctOhk9TeKBo3sNoZPU+XXAu7y0E8dkEJ/f60+MWAS3Xpqpu1iEc=
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3125;23:GQ1n3xo9G8qOyMI3PZQTSZqp2cXLSAwZsBrZcr4pq?=
 =?us-ascii?Q?g4WceYRgHv0CcZhZmKgLZ10xHoXyxjLOdGiipYH7+W/aTU9xFUEHW0Qzqz/m?=
 =?us-ascii?Q?XoqvSnERRwRsRFLVZltIHXWyoBLFU9qlRDUesfsmCFcGJSbh3B1vmybKbD7n?=
 =?us-ascii?Q?ngAtcPU8jx1P0i7VnZuP6wOhowBclW3Ie+/cJ1RQJ/Q105CU6YgJq3iSaNEK?=
 =?us-ascii?Q?C+UGkn7pGSdq6wFdNotP37ESmloy3rWq6NA5Ut/qKtaL90HdmH8JaAVBMuj6?=
 =?us-ascii?Q?wRPJ/CALNh+5n6Kpg8Y63jO30N9nXo6G/yxNvFAxtm1Zb8kFi/+DP4Vgi8E2?=
 =?us-ascii?Q?LP47mGvVe2XiATwZ5MxGy/XEy86bIyTqE6xuO4sP8BCzOCetldOeStOQaRiu?=
 =?us-ascii?Q?xE19B9c206YeO1GAQ40tLusB8mPeeGwregfU2+WeSG5pIjM4BqzSQjhtwBP9?=
 =?us-ascii?Q?PkdIP29Dsa7UJFnrOkdddz8JQeTeJ5uQNTc2SN0CPjWhMe5jL+c/07FlS/BJ?=
 =?us-ascii?Q?0krQFVtrcAxEb9hY9f/JXvnSm5YcKUYl2D7j+Dt2vE2u6ad8IqXe6F7a9WY+?=
 =?us-ascii?Q?jgb6mrlNEfjmo7G5jPJx3LHORiMiZ6LlSTqOCqoNGpFDO4oLn18oCXUncx/T?=
 =?us-ascii?Q?lwbjtudg60B1wLT88E+4c9sQlivheGsSYowGrdS6UTQ+bPak8TIQ+bGeg9DZ?=
 =?us-ascii?Q?UhtZxxQKx/IYtBAITb7wKqS/4rwQihEZ9F12ZRVVQZcrjyLOst4Xp9oWriLw?=
 =?us-ascii?Q?J9ISe0eIyVdiRTwbyILq2k5TIju+VQGu4VAqsqudi0pejkOLkMFv+BKQNlPW?=
 =?us-ascii?Q?0lnRKq2Mka38m9WJKqzvbigCi+S7KmtMyZcR7Tr12hgI5Mda8MdYDUqSacB/?=
 =?us-ascii?Q?bATwMoF7ENW6Kj1OcSs5EI0M2BbehxXOGu3DyukcT7iL2RdfgJUIU8InM/VQ?=
 =?us-ascii?Q?HX8zezKAiADPFNamsq3gr3oCVUhWj1WjTUop/pLim+I0mggU5Zq8eX/e5wAh?=
 =?us-ascii?Q?xsOAULLkXZIcbj09XW5TdZRfBmt+O7et/O2eetUx5aszDWZEKQTyGnRcdtih?=
 =?us-ascii?Q?w0g55hHm+gAqrFbaYkY890ywCC24skS7OPlOG8XRUjv86jwIvHUFiiFAtrhD?=
 =?us-ascii?Q?+OSPvfS833PURDcQbu/jU0t1ZpEQ2CwiQwa71QYVnMlzWs4BVw2/wcAp7wkp?=
 =?us-ascii?Q?hKMonLyd98fz1o=3D?=
X-Microsoft-Antispam-Message-Info: Umo3C1UALQFSAZwlNvN1DgHEYm94X5VfSWrpJe//MAp9PgsQHfUCtWpU3G6v6aoqH8XP9viKA3FyNhI1KQ7i2law2WP5JZenkjdpYSsQCahE+3J3akVcU0rNUI31PR1Wsgcwoa84EDxPg08sPS7PkNgC6amRn3MxYvy+z/s1NDXzzoEAfz43pYC7W5qoqg7ZXkI+TCybViqALvF+HirlqNURSYOy6VIKBvZ1+KTYwmW7alhBRkfRQluLPWBpYheGtsB7laThzrkEoSVMctwPvkzATfkp/GaT9Co0ZNcz6zG4YPWE6M7ZJ5pRjt/CLQrhFAJwR7GwVkvJt4ggPZxmkHSDeeGsrUOh6OtfAr1jAvM=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;6:/71LibL0SIa/RfNnC/Y1Ct9ooiv4Ne/CsCETYY/SDHgr6Oz/PnIKyDybcEVO3xgxK/UtmdswHqb6/SismTmJtPx8tcDSTRZGPUYfzL2j7aDv4HqDbjFmn/T3KJSR6r4Zf5MVv/IrScjNP1ejv9pakU/3lYDKhWQiC53odxlpgQgk5MnK+8jLF34PgUMNmw/jveULewc5PjczV4JAMbE8S1b2XKYkWLdbiCDPZ2GTx7Dtdc9IBemKS8ZTi5tKnv+7BWAAk73Bq4LAW2x3udw93g4UwLmkKtO8CEgMDSmy5sycBtsSvKWP1rVWyGxIoUOlChzrkdSJ0lpzFnhQQtAfHkn/MVHIIPr7+XuCSENyRpq4eUpd0nDEIeDlKVpEzvoP2JDEkI0pjWmZoH76ld42Cqc/EMwEgGgQixq8DWKPtvRgc1eqTHeIdKzDZzaakak7UgGi58j0zFQ4Gi2QVXAuBg==;5:fGIFkRUX2xba1C2FGBw+KBuFfGFDQdNjO2rxysLYz0kZFaGzbfcGCCjaFNz5BUUQFLyLQiYzWgla5qMNSU4tWDfGtrVOjxzKMjo/XlOVl7FgFoyaZz7yK68HIk3q65aX9EeicnWQ+8TPRkeoete2444SX6T96cp3Rwumf9kudWk=;7:59dn/rnXWNJnpVKIFDpsgSQsRZ1yfSzgTPvBesVLuCH4fdfSgxlF087+vXxoQyK9KG89jvYxuByQ+EsJugCtm1/zgGh1gfFWFBVCG8Ezv7jaSmgy4BjwVjIpUwfxLdbkMTPexyJNJS30bEH8PpEVUe+inZOPooojgevgb0AJZgR04BzffiiP2QeTNpiD1G/EtENJ+EpIq8vCutMAY6mN4x4ejxrCyoHh7vmHsg/j21wY/c1RgNhpNXOZ7coLvBwY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 13:04:04.3668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89b853d-93d9-46d0-6191-08d5f9419744
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3125
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
 drivers/iio/accel/adxl372.c | 346 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 345 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 7d5092d..e31e096 100644
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
@@ -164,6 +174,43 @@ enum adxl372_bandwidth {
 	ADXL372_BW_3200HZ,
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
@@ -171,6 +218,13 @@ enum adxl372_bandwidth {
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
@@ -182,14 +236,37 @@ static const struct iio_chan_spec adxl372_channels[] = {
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
 
+static int adxl372_read_fifo(struct adxl372_state *st, u16 fifo_entries)
+{
+	return regmap_noinc_read(st->regmap, ADXL372_FIFO_DATA,
+				 st->fifo_buf, fifo_entries * sizeof(u16));
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
@@ -364,6 +441,109 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
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
+		ret = adxl372_read_fifo(st, fifo_entries);
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
@@ -443,7 +623,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 
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
 
@@ -459,9 +644,132 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
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
+
+	adxl372_set_interrupts(st, 0, 0);
+	st->fifo_mode = ADXL372_FIFO_BYPASSED;
+	adxl372_configure_fifo(st);
+
+	return iio_triggered_buffer_predisable(indio_dev);
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
 
 static const struct regmap_config adxl372_spi_regmap_config = {
@@ -495,10 +803,11 @@ static int adxl372_probe(struct spi_device *spi)
 
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
@@ -506,6 +815,41 @@ static int adxl372_probe(struct spi_device *spi)
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

