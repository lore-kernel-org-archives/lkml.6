Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE617C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92238208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="m03G2K0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92238208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeLFNip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:38:45 -0500
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:46720
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeLFNip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nmJeZCSQ30hmEDeE5BlneD7y6oJs6tWIk726jgwzmY=;
 b=m03G2K0k0tbCPtpVhGy7s+ChzoHxDhkbs1DYgLUBdjAzUMdrbPbrfD1ljWfgTVREG1mWepKO7Q1kE4kCWN/vuMEwE/aF7DOr8WwG2ZyYjDq8SvjGPPAIue8PoPITO21M6dRfmAtbDScAFDSY2tEvkCjOcIZhyXHqryq4qFVEH3Y=
Received: from BN6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:405:6f::32)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.20; Thu, 6 Dec
 2018 13:38:41 +0000
Received: from BY2FFO11FD008.protection.gbl (2a01:111:f400:7c0c::129) by
 BN6PR03CA0094.outlook.office365.com (2603:10b6:405:6f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.19 via Frontend Transport; Thu, 6 Dec 2018 13:38:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD008.mail.protection.outlook.com (10.1.14.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.13
 via Frontend Transport; Thu, 6 Dec 2018 13:38:40 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wB6Dcdwg022544
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Dec 2018 05:38:39 -0800
Received: from mircea-Latitude-E6540.analog.com (10.50.1.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Dec 2018 08:38:39 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Stefan Popa <stefan.popa@analog.com>,
        "Mircea Caprioru" <mircea.caprioru@analog.com>
Subject: [PATCH] iio:dac:ad5686: Add AD5310R support
Date:   Thu, 6 Dec 2018 15:38:30 +0200
Message-ID: <20181206133830.20488-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(189003)(199004)(2906002)(246002)(6306002)(14444005)(478600001)(53416004)(7696005)(72206003)(86362001)(8676002)(6346003)(106466001)(26005)(107886003)(2351001)(77096007)(5660300001)(186003)(7636002)(47776003)(316002)(54906003)(1076002)(966005)(4326008)(50466002)(44832011)(6916009)(51416003)(305945005)(486006)(48376002)(6666004)(356004)(426003)(16586007)(50226002)(2616005)(8936002)(36756003)(336012)(106002)(476003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD008;1:BI31W0+2MwA3cBCxl+Z8p3HxX9aobB+Or2RLmLPr5mIbpC3mccTsEPj7aUBlc2REEDxsZH4qKiohRkulnm8sTbAifn0rGYpODDO15QJDyWG/ndK+e00teGzHTKZ/p0YQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf7846a-75e8-4373-dddf-08d65b802252
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:IYAyZWPv43qUaS0wUC5N9GyMMgTciMZ+knjubr/EuHY/czfbxtfVn1gult1XKA2wQJW8oSC3ynjih2fGOTRVcr0bUpFQxG+KcQoVH+JuOiLl9bI7sANHogC8piUF1R6WkF0GnYV0B6GcnfqXE5pLA/KBUaScEXnaG0EdDuqKFhyYTTxOqeEu47ILFDbPWzlZZ3SRD1wx7A68XtJluvWGj8tNxbqtLTd7Ig9rPBTODj4pPMDuztwb/hygbR07J8NPw8nurzpjv+wWnEVmXe96vD7G/4WWVv0tL7ubtGqmxEa6tElUaiXeDLDtakbXnqQX0zRQcFN3Nzh1gzDF/LXSiW3uzZjZB+K6pYMX4Ns0nEk=;25:PchtyjiJHlq3oXX2rAxxz0QT3pKZ6Y5lU7IemspDGokVFe6vkMXK0qOPlXcRYFlbZYOWFMmlYKBSFqPkHuAX8j6EeFvSXmBI/3eg9fPXThyWiEzuc2Kk437GbwiMn/tqhCUFK/UujkmTHuNp5DyfF9Z4Ho5SZqlfTEywQ86UDR9ZBSmY1d8/LazcKiwjNceHgmuBwKwOzWB3cwa39ZzpkRFharNiXdxuFZdGCODWpE4lS6eWLLgYOA6KUSHoBFV0xeZwEaX79iea4uRuU9zhbJJQY6Wa2aoq7cx81efkT0pe5V5JgmF255MU6eCmcC1JpmrrFM5650yV95lEz42Ttg==
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:tu4ZyfpI7asAHKflVO4njW2qCTgku5CpLQvCjB3GIGVAFgJY5EOwPHa4kuqbyqiBUBvMTGDv/UQdd6BtTN+oStsde0qG+14CMkNSdms73YWtkO+k1/vGsVg9Vi4/aiy9FJS/NRKJrwuujn+Ihp3/puZBv9GHwy/ZegLRVuIFVy6lqov1knASU6p+bhVe77Woaag2NCJLDdXYua+04KVMrSW7wqboYaDB98ukWh8CBbU=;20:RkFpss/9iUAim623H5/G6X94RH0PlfebXr2jVW4RH6Zh+zwXDUv2EWRO9Go8x768bJhdvBUzSptHmKcbOl7PLlyW1PKU6r/dFJotmyKvkbabG4bxncNNmTRKGVQAFKrrSjcNlB2e9IpUNSxWMJWe9m0lgdQGKODK3DIiogKTZV4GUa/3xoQ3MuPQM11nqCQpda8h7uMlgyuHrm/0UAuD9VerIDLbMwSdVl15Ifj62YNqcxTFz7Jw6NG61H2seUfsZu1UQfLPc3dNMREPluQOfau73kA92lrUdmnTdDe/zVCC4aCOAj5/FBCf4MkkVm2HHcIGungtWtDpzdppr+AkvO/3pTw9/YGMxs9Ci92TgGSYYMG0yzpvFS/tLZRU44KC5h5ZjMbOkGXLKB7Wy222L6cfZp1pbOAdPs7RTO1y730b2sHf5mZFfDXYENRFY6QRlpyczbjVSPRhNE5BSNoRzokozDE4p8cor8T1j3A+UCsjdk8SM1YTzmFewtSY/YxY
X-Microsoft-Antispam-PRVS: <BL2PR03MB546EE72C011430469DA35A381A90@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(4982022)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:gz4gDGMgYla5uHO/p7HCrT24zTQe9fApoEcpAcAeRbtx+JPuBKRp33KWJ8LCWjacXXbPyCJw2JnRnwpIB/TUnk6pEPx/0uy+ZX9PBBIOvDTKNguamWBPewNT0nLbEuVR+hKz6FJuA7DzPGmp1z9KX2WKoT/+1t2gMbK7/x1eT55p68vlhtkf9VidTOOvA8yJFpgVJUsO/XU7MGsdCt3FcRMSRauueh/dXLCZA77cCVArNs2VLp/QmoEZme4OzYoIKLNGBmLa22eHm3PbkqZA8w==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB546;23:VWXQuhChxsuF1EfMD32gjJsfo03cRDfkY/tmOjiwt6?=
 =?us-ascii?Q?FupZIg0HGPhILzzSNeWcbBaCq1pwvPSiOIqe7rL3yBhsIyV8WbuS0VwC974/?=
 =?us-ascii?Q?kWboNXa/URwxDLdIMIm27pQ7pO2KchAWqTzYwzeWfplr5F7T0kt0e74RyB32?=
 =?us-ascii?Q?4GUxHnDdhzwXiOAH7+mZJGmS6QsW4MmUYiLHnL9omoA1Spp7a0AwHXBE+9ZY?=
 =?us-ascii?Q?uRbt/fj47G7YBn+q4GJL17mkkHgt/i2s+foE8Q7vbFxucNPxxTRCuOG0F3cE?=
 =?us-ascii?Q?mLYlaPjs97tySLETIDGS2wlcjNBlBPary8YBFfOTAFN3kpyXYIegsjOsUWJi?=
 =?us-ascii?Q?C0FXI379xVFW7TkzHHPFqikWnCmcDIbRsMiwbS/2jcqwkp5O8YzlsdGyHv2C?=
 =?us-ascii?Q?FRdQBL3jKD3/ZgBBSD9/ofsan+42JZzfFqJgpsVcIi8iB/j8Cz30p97N7Q16?=
 =?us-ascii?Q?nmvfSNQKzMz1uHAOqmLZafAdKsKuNYC+6wKpUp0asKPJy7XpW0fuZFhu0eLd?=
 =?us-ascii?Q?2CSdUqUTulauiY7Qa1+AVcPl7Mln4S//YGsnlB1Lx2gVv5QA2XlQG6hWkp9T?=
 =?us-ascii?Q?3VCMfWZlPoLasVXKJ1kEPSgQaC26g5ia14b/nCHeyEwC9JPOubyhLc1JdX5q?=
 =?us-ascii?Q?ldz/Ptgg+0tiM1IhmKa9j01bmj329t2UEd9csplDJDu/zDeAwm3UpSFwXrRi?=
 =?us-ascii?Q?XSO15Ubko4ANzG0X2Gdp2gDvUosPxnl49eudniNiutbE3ZaTL4orYnS2NHJO?=
 =?us-ascii?Q?Ajy1fZgJvjseJhsWkzV1GCtLy53hUorTwNtHlubtFA12nGfo4WttD4dL331Z?=
 =?us-ascii?Q?dAtCEHy4MIEYh3HiLP5NDaJxMd7oHvK7ZkGNyL8oZbBJMrx02sK+Vlm9lABE?=
 =?us-ascii?Q?ozYZGL7/+U8Cogj4ISUqRntLvJ9VumotYhyD7yWagr91Q1stizdGNhp3+Wal?=
 =?us-ascii?Q?kvR6IgGWhmhtA8NT5Fwl4PBtvD2CFz/PDJlK2wSr+eDS4gmJSPjdDViuYZd2?=
 =?us-ascii?Q?1L2LkUorSy4T+LPzF9pPibHZ8jdzteLoGGlJ4Zz5F5weMsIjG6uoAktWxFyw?=
 =?us-ascii?Q?JcrE80zFwMe6QqtbUkoXDqhB0W3T6qx5R1t+MO16u+Xb+1ePDV2HOP4q/Rbv?=
 =?us-ascii?Q?rhXIJpwMXCuB8jm/J0tlK/Xrzoq2l5?=
X-Microsoft-Antispam-Message-Info: G+JH4Vlsd+YsYovlpt1JuNneIco6kjY5cRilpvalc8v1i8mRrK0p2TgzZ+cBxgRz9yJ4G4kfV+ILN15xcFyZ5Jgt1+0H9JnPqStNA/UoRp+nkArSNwsNFSzIWKu7uFrPyGZMV5NTSOj5gnV5CTAtK+xQLRjJ+UXd2wnFdV1MH7e2scOhcpKz9rgimelyboN6UTj+xsdsjgc4yg9U5obWG9r/tXsx019Dm12ob5crs2IVPAzI7QxgjDUugc2QGai5X46jDwsDkgLtA1eA89hZd5UjbFQQ2LvPyjCjuT1tRHLzwDpAS4YOlHTLDruebiCmQ3VydNRQREcf6OSL9tvTMb8pG1Tpm3Y2qWTtQf0pO1M=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:zhG/cm+mvUaAeLSBrkx8c+YME152ZKTIC9hsrhXWh2gzfVdaf1N/mzQDI/wR/c0H3S74FQDK17aemRgOPkKQtivNtXNpMTdh2btarl/HDftxZITeTKRSogNEopTxm/FXEEbigNHsXOVVaZI1AtMZATVZQdyC0N0FmmPPyJgyghNb3eqcQdcE4o9xb8O5B051ebuj2JRuYDBaQZenPFGe2pcVAjrNPSkH3FEKsk8k3HBMbffcoCHbrttMyeUGCcEAw91ckzV2T8nDfZQOuRlszL512+SoSLG3zHtuYmd6zoZ8mx9iW7CrPTct8UDgFssAy7zGpUx5rO0MfmYErJ9TbfNlLWqetpsofXiYYhdDlmS4wUteTQ+UM2WdKzI1io/lMHpW4DCqA8fGbDA+5bLm4So6HF6rjH6KyqhQT8NoENw2RSxZ3b5snN578gVA8RCxs2nq1/T7KKSzKoVrUR5yWg==;5:3bn8QcQIj+UT1K5xvRQ93Hcz/jL065G+Nzmsi85Dh3pI+g8tFA7pgNEH+CgaexdRIK3EQ9FbA8R+i4OPufJzcFh+ZXwE3Om5bdPF5UCaR7qW7LrsJ8pzFcQeJMDF3yDk1Qmb47PvdYq7PlcwsIBXW68sgDSiw7iMC5HnW1WO69g=;7:0ZO5OxMJmlCkqprkVNqI59S+Tll5PqSYeruRQx7ezk0CSMFp0QvcNU7/qfN0DjY7uJalPaCzpeZ7mPb28oE5+s+UhR67NJh5A5yN5jxrsCdmTiJ6+odMiFzXG/DT0R/yddoR17kvRYBb+Lp3zQJWKA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 13:38:40.6332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf7846a-75e8-4373-dddf-08d65b802252
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The AD5310R is a single channel DAC with 10-bit precision, which is
part of the same family as AD5311R, except that it uses the spi interface
instead of i2c. The device has a built-in 2.5V reference which is enabled
by default.

Another important difference is that the SPI write command operation is
16 bits long. The first four bits represent the command, while the
remaining 12 bits are for data. In the control reg, DB9 and DB10 are used
for power-down modes, while DB8 is the REF bit. In order to accommodate
this change, a new regmap type was defined and checked accordingly.

Because AD5310R does not have a readback register, the read_raw operation
will return "Operation is not supported".

Datasheet:
Link: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5310R_5311R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/dac/ad5686-spi.c | 21 ++++++++++++++++++---
 drivers/iio/dac/ad5686.c     | 16 ++++++++++++++++
 drivers/iio/dac/ad5686.h     |  7 +++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 1df9143f55e9..665fa6bd9ced 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -19,6 +19,12 @@ static int ad5686_spi_write(struct ad5686_state *st,
 	u8 tx_len, *buf;
 
 	switch (st->chip_info->regmap_type) {
+	case AD5310_REGMAP:
+		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
+					      val);
+		buf = &st->data[0].d8[0];
+		tx_len = 2;
+		break;
 	case AD5683_REGMAP:
 		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
 					      AD5683_DATA(val));
@@ -56,10 +62,18 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
 	u8 cmd = 0;
 	int ret;
 
-	if (st->chip_info->regmap_type == AD5686_REGMAP)
-		cmd = AD5686_CMD_READBACK_ENABLE;
-	else if (st->chip_info->regmap_type == AD5683_REGMAP)
+	switch (st->chip_info->regmap_type) {
+	case AD5310_REGMAP:
+		return -ENOTSUPP;
+	case AD5683_REGMAP:
 		cmd = AD5686_CMD_READBACK_ENABLE_V2;
+		break;
+	case AD5686_REGMAP:
+		cmd = AD5686_CMD_READBACK_ENABLE;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
 				      AD5686_ADDR(addr));
@@ -86,6 +100,7 @@ static int ad5686_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad5686_spi_id[] = {
+	{"ad5310r", ID_AD5310R},
 	{"ad5672r", ID_AD5672R},
 	{"ad5676", ID_AD5676},
 	{"ad5676r", ID_AD5676R},
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 0e134b13967a..54ff76b93366 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -83,6 +83,10 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
 
 	switch (st->chip_info->regmap_type) {
+	case AD5310_REGMAP:
+		shift = 9;
+		ref_bit_msk = AD5310_REF_BIT_MSK;
+		break;
 	case AD5683_REGMAP:
 		shift = 13;
 		ref_bit_msk = AD5683_REF_BIT_MSK;
@@ -221,6 +225,7 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(7, 7, bits, _shift),		\
 }
 
+DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
 DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
 DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
 DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
@@ -232,6 +237,12 @@ DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
 DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5310R] = {
+		.channels = ad5310r_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 1,
+		.regmap_type = AD5310_REGMAP,
+	},
 	[ID_AD5311R] = {
 		.channels = ad5311r_channels,
 		.int_vref_mv = 2500,
@@ -419,6 +430,11 @@ int ad5686_probe(struct device *dev,
 	indio_dev->num_channels = st->chip_info->num_channels;
 
 	switch (st->chip_info->regmap_type) {
+	case AD5310_REGMAP:
+		cmd = AD5686_CMD_CONTROL_REG;
+		ref_bit_msk = AD5310_REF_BIT_MSK;
+		st->use_internal_vref = !voltage_uv;
+		break;
 	case AD5683_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
 		ref_bit_msk = AD5683_REF_BIT_MSK;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 57b3c61bfb91..19f6917d4738 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -13,7 +13,10 @@
 #include <linux/mutex.h>
 #include <linux/kernel.h>
 
+#define AD5310_CMD(x)				((x) << 12)
+
 #define AD5683_DATA(x)				((x) << 4)
+
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
@@ -38,6 +41,8 @@
 
 #define AD5686_CMD_CONTROL_REG			0x4
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
+
+#define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
@@ -45,6 +50,7 @@
  * ad5686_supported_device_ids:
  */
 enum ad5686_supported_device_ids {
+	ID_AD5310R,
 	ID_AD5311R,
 	ID_AD5671R,
 	ID_AD5672R,
@@ -72,6 +78,7 @@ enum ad5686_supported_device_ids {
 };
 
 enum ad5686_regmap_type {
+	AD5310_REGMAP,
 	AD5683_REGMAP,
 	AD5686_REGMAP,
 	AD5693_REGMAP
-- 
2.17.1

