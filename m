Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA33213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xBzJjAUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA33213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJDPm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:42:56 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:23148
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbeJDPmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwcExRxe1qLsQ1IfBjI518YzgsmxnfelDWNuAiUt7KQ=;
 b=xBzJjAUp2WrAChV0wrAkes4Kzh4nctom3jGAm9a6mbcSazpA8WYj/OOQY1k/NfDKy5ZjlxemLDL6WdNQJ2mIl0tqBVRjel8XHpM67ZIVOExB8RZTgwZMgqakH/jgqQdZRPsJLNnTI1InSa3ixONLkFrwmuJW17bH76Lb3zYY1Sg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1025.eurprd04.prod.outlook.com (2a01:111:e400:8442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Thu, 4 Oct
 2018 08:50:33 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 2/4] mtd: spi-nor: add support for octal mode data transfer
Date:   Thu,  4 Oct 2018 14:18:38 +0530
Message-Id: <1538642920-3843-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To AM2PR04MB1025.eurprd04.prod.outlook.com
 (2a01:111:e400:8442::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288483c1-3899-4f6b-7fe4-08d629d674bb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1025;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;3:rsFX2v35XzYpwGn0qybGYrb6tHXccNxbZubck/7JepUln5Sj68YBpNCHQ3tvgEfMU9gesET8c8tN8PXCfsud0uXfnJ5ncpenta/L1elyHoU1oxrAzQCg48Kkvwd828A9IqxiGH0uPJN+JX4tmO22itnMzL5pifYXTMOtJ2ls1HOOVqVeaxTbecV3qnhAZ3n1juqCTUQhs0Pj3QjKNRruLn3ZajYVNw4yGolDfWPIlZ+Kp8wwWa1L14s2G92RTBX+;25:UG6voDoX21tenL0jVsAJ4yYl+tGRh2Z60+7yRPsLl97a0jbYCfj+d591e5/pw6M6bT+WOex6ziPg+J/ewG0w+zdg98opqj51to94i3IC2mkAWcqqkkbOgm2T9HUeoPENNaCfr4wdhv8Xw3nB7mDaKSVzYH6hQq5gXGsyNDCu872baarwsEvv+f726bpIIVa9D5wO7x/UTCDbIG5b8T0IIH8Eh51+DshBLSX7d2GdXFgqWYyylLr8gSWL5TLXTrDhzJ9bmen8MK8mNYyzqM9vs96sRFGkHS0Y0cKlRFDX1PLRL6gcql26l/yzB9hSh7yVaQDm4ohSEJbMu/9TaQYv6Q==;31:/lmnUKD+8/xAzbqNgBQLOOLbQQtzDygWwFweMp0xZ7R9JzCoV6fIskPGhAcQYa+HSqxoD5gvzAOxBZk91Jeb9Cao+foVlFBXqzL2XSq5oI7lYIo1JoYtZmIOg59GHgPckZjM/RoNrxs80kvAQ+20sIUHr4eOU4u1WofBDGwtJg0tgiss+6yUB9RHPOuQbnNM93ROTSd8Vz5Qf1vl5Wg4cvLqyDN/wVINN6a/BTfDV2M=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1025:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;20:O7QedWRtAhej7wVCJ9n/O/4FXT0x641CSJ9GWw5LiRyapW5D5hiTvd7gdAEzWN78Xf/FtPekoUbf0ihnbDzcXSc7wMA5SoMq1zLGgq3I/FlEUQAC2JDnl9izDDFa4Qpyrvez57kJm+IA+Sgg06dj8RVBsOwBbcMkDcIxYZe5bGWA7xkLX/4kDb2qI9icI6hEKsdGE8dSOK29GO9IFmVsitVwJDX52rXpEIxTIfFT02Yt/YfD/oGY3/TmCY9JZiRCkCVjKsUnK6MA2cMm1xTxSCoHTOJhHBSrRhZ1pUtyh4rH5DytTp59Z5Rx+C4xVHYcKXczh2D73Ta90VuVdu8vezyBeCImg2mEZYuM5P54pZjNAt0sUCSOXeBs+imAL+vi2Puus+46vEodLm3Aua+d2ecIAFVU9sjjdgaIoujzvdMSGr0h0qU9x0YirYxAAtfGp8Io17RqZcyA+O0S+mXwzMArvQ3FYIkMA/mbhOuMj+bPi3dh3Vai7VFZXBppTTI1;4:RCTz/gEx82pIMqxvGyExW+ozPVEeKGyh2M/s2KplaolfMOeyldy0wFbAzGTwkvZlHSR2dUIn2eh+FWdSHdZ2KGKIoIqVwHpNqeV9cXy+59aYvjR4BlxDd9miA+DloJCNXjbn6pfv+BKn0O0LmxSmrIoUhwMpKcfiBiIQb+IBxpGavn+ICZiwJmJ4aTlD7leiOl4UftFdLB+wyoNT/8LcLs6wZB4MquskzqCVc1zb+h0PISZxh86TprJh2lhgci+KKkvis4J6sXehmN4hyN/UhD38V9mRAwX2v5TIXlv7nXDb7UhoDSbcZPXK0yLMYo9ySQBQSm/OHkZ+7k4nG6EZLDcPXQbEH/kW+VShezOXtHQ=
X-Microsoft-Antispam-PRVS: <AM2PR04MB1025CEC98545BD7341CCCA2199EA0@AM2PR04MB1025.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1025;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1025;
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6512007)(8676002)(3846002)(6116002)(7416002)(476003)(11346002)(2616005)(956004)(446003)(66066001)(386003)(52116002)(16586007)(51416003)(6506007)(81156014)(81166006)(6486002)(486006)(68736007)(8936002)(316002)(106356001)(105586002)(25786009)(26005)(48376002)(7736002)(76176011)(2906002)(50466002)(186003)(16526019)(478600001)(53936002)(47776003)(50226002)(97736004)(36756003)(305945005)(5009440100003)(39060400002)(55236004)(4326008)(86362001)(5660300001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1025;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1025;23:PZUOgdbkfl65I2KUksouQYgxwNdmLwgvWRb8a1meg?=
 =?us-ascii?Q?sxeUVbDIx5fOSuz7jk65rWUL/yyTiFZSzfxT4PRuee06G7xiTR87UGiE/zxU?=
 =?us-ascii?Q?z5WJe2mWRjtuP45KC4Z7YgFHCKaC5K5j9wepZ6A7BNk+3P6JJf+aK+DGEK0Q?=
 =?us-ascii?Q?mhSSgu43x1ibYeBaLLAVdEpxHQqK0PPq6bT18YmwKEBCYg2LtVPAg3UVKuQt?=
 =?us-ascii?Q?QH4IFCbhFG15ZihJHvJV8mSk8qKxPF6Yk57regJLH1BWDEiaDejTTxk/L50x?=
 =?us-ascii?Q?asCtOGR6aZ3wBxcsuDWzYnr63j3KJrAj/cGCp6EgGhU5LSKq/4OavLGzBP3/?=
 =?us-ascii?Q?PPzfypOluhzm+dMstOngE5m8oZTLfFZsRQxgST1mTznL/kWiI3IC1wFSqVUF?=
 =?us-ascii?Q?jDhqSl6GCRzJQ1aFbD3sQAsIXCLLWe6iI8VRM6MX8fN92Ewv95rRqnNQhNKq?=
 =?us-ascii?Q?xRWn/ifnm195WjgmslW7GlD+YXmFSEkFeR7Fn5zmeFt3UXDePyp5JwezXkrw?=
 =?us-ascii?Q?6lZe5yIT6dlXATnIzeTKu8TdeeJ4g4ttBeWe+wjNdTLJw+2jUqLv9TMcgyed?=
 =?us-ascii?Q?z77ZhRvUkNShEJ2OmBS562h8QSNoP8zRGrdSdsw+J4p6c/6LjQ0w7VHEfOk3?=
 =?us-ascii?Q?xWECxuRZD7vYBO/2ouwVRI0YKcL5XQ+XGAOt2yutIJ5hz0Vz+qLbtOlvSbY/?=
 =?us-ascii?Q?7xmKnCP+6zfB2XjkeWTwijH0dUCx/cxARLqp8qNkDQC7wAPRR5A16IZgfWQh?=
 =?us-ascii?Q?DbNEY7t6RUg8ewtaZOMfSJ4jSDTga11QovyuHeBLQzk5VUuS9BlaBt6D/dp/?=
 =?us-ascii?Q?V3JftxfEpINDx88J/ZhjYs/73np2twfiRrQOOvKvtwJzGaIQhmd1738zydqn?=
 =?us-ascii?Q?V7t9WPao/5nK6HRMllsA3Vi61szd8GJ34iXb1JoSPBxkFaUDPnhIQoweoM5o?=
 =?us-ascii?Q?DUNZTmqho6ZiJj1LR1zUygVYYkqaRzExT/d26T/g6AE2ymZf0KIRryYeYUTR?=
 =?us-ascii?Q?ym1wPby28e3zN0KcquSDFoByEpVIhUZEbzOJGWwnwVX5AZNDC6QKl3NYtj/p?=
 =?us-ascii?Q?j6xm/N4oEWl1cMQQxxsvLNtJ0R0odTe5tXqG1nW4dw1GcEF1mr/iA0pWBUBh?=
 =?us-ascii?Q?ZSlkwSK2BVgj36YZn1Iwi0p709UnWqQgsmdYl0FVpw33rfb1rmllTV+XxgIc?=
 =?us-ascii?Q?EYMZnflq7IVmCQ/8BBLqlnDbQUT4jA/2Va9DrYergFxLQtx6N90Zmp5m/Mmw?=
 =?us-ascii?Q?7LLiZBYLVwrk5UEK60=3D?=
X-Microsoft-Antispam-Message-Info: uSGvtG4i1jNN8QvBxksYv6Kn2Bo7Pwkc6XKgb3ERdIJij/nEIDy4cySMzu205Wu9tYR0kZHkiSy3BqZkJLPIjiFNgwOgLRD3aZd/sBOfOQvAh7HHG4yiefqjbGbcvgRKZ/433T7kPqb3HczbC2dJbx8yacPmcnbeA30720SGMEA09nM/zpRGv6iZRdJ5z8e0K8CykT/1FgbpnaCRdps3CVtZ0XTMJGVixgqRybsQdBoulqk4LJuHaC9aBKbUEtjKYK5D8UeIovR8SDsoAlXBA2q4+AZ4IbRreEGzCGP/fjODbQ25/U53wJFtWrpKfMMW3ldrqgfLl0D2/yY+d12pKGJIC+DQcCFOL4M7wm/jW1E=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;6:oqwVgdiLLjO5+CBVeJcvR1kkz84AucOeNmIF82MKInuS6Dt9h0D7Nce8CreWx4RyoEPAi4Uy53fY0xvAbZTDn3zIOwmiyOm0o94Q35yUglnp4fWTeimgV2HGVkW1PyMMUGpLR+rXq7UoJDY3p9p0PFgV81GovVFKaFEUqX7liWz/2aiqkDIOZM3ah/UNj3WP4wSiPhdw+0i2oMZGblSd25XhljXeoHEACXzo3ffdvTrxsCU0myrfNBrm1kYVYJfg5BY2VwU2NZhkCRyErILK+tiSfwqA0cw2c74f1XP97b0L2fii5CvgEqivybtUusqRbvrA19Na3aO8fEZltd3gMmdJwk/EEZpVmsF204ErTQURDG9DCzosPKjBJjpeUO+6p76kUncNmztYkoY/UhgFea3hX51JhM0ybilX2LSWRAqvnYcXp/AZ8S5le2IMItbnM3JFK8L+/KQ7z9/uwoysgg==;5:kcPsDvY1xj4BlziChxY2hNvwTQnDmrSu9OVSxY9roFKELYLvH1zOZ32ukCiLfBgvw+HxmeQxWxXPQZ+LLbo3qy/uHqyDKiJqHL+tgoWqH8dQDTNqsnydfC3fffnj+fWcRQARLeSPsTqMh2Rh2HYnGgf27kGlKXqQk5qVeD3d7xQ=;7:mqtHeHwEaFXsIf/gH3IClWfxn+TZFrHK9ljDM9lqwavbd2oYSvPExasLLhkq9dfe4a6iumX0mx/mvCWOST7ijl5uV8Mk/C+MzX0qqf9vvqwU5jn29CrxehLzfDNRHoNgZzxBJ23yhs1H+QO3Mc+Y244KOmjFotN3dolCrxLIpO+3m8mgqyIJUX4q2x7X0fQsUSRs9Ze5aO2Jcj0mVXWLzwOc81i6M4wXkr8UZS8sPy8R2K9llm3dbK9PnO3BeVVT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 08:50:33.7238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288483c1-3899-4f6b-7fe4-08d629d674bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode data transfer for Micron mt35xu512aba.

Unfortunately, this flash is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto detection
of Octal mode capabilities and opcodes. Therefore, this capability is
manually added using new SPI_NOR_OCTAL_READ flag.

Added support of Octal mode parsing for 'm25p80' spi-nor flash interface.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c  |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c | 14 +++++++++++++-
 include/linux/mtd/spi-nor.h   |  8 ++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fe260cc..e22aa2b 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -182,7 +182,14 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem = spimem;
 
-	if (spi->mode & SPI_RX_QUAD) {
+	if (spi->mode & SPI_RX_OCTAL) {
+		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
+
+		if (spi->mode & SPI_TX_OCTAL)
+			hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
+					SNOR_HWCAPS_PP_1_1_8 |
+					SNOR_HWCAPS_PP_1_8_8);
+	} else if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
 
 		if (spi->mode & SPI_TX_QUAD)
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6042df8..0587b9c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -89,6 +89,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
 
 	int	(*quad_enable)(struct spi_nor *nor);
 };
@@ -208,6 +209,8 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
 		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
 		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
 		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
+		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
+		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
 
 		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
 		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
@@ -224,6 +227,8 @@ static inline u8 spi_nor_convert_3to4_program(u8 opcode)
 		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
 		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
 		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
+		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
+		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
 	};
 
 	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
@@ -1114,7 +1119,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 
 	/* Micron */
-	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
@@ -2493,6 +2498,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 					  SNOR_PROTO_1_1_4);
 	}
 
+	if (info->flags & SPI_NOR_OCTAL_READ) {
+		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
+					  0, 8, SPINOR_OP_READ_1_1_8,
+					  SNOR_PROTO_1_1_8);
+	}
+
 	/* Page Program settings. */
 	params->hwcaps.mask |= SNOR_HWCAPS_PP;
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f43bfc5..b23c69d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -50,9 +50,13 @@
 #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
 #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal Output SPI) */
+#define SPINOR_OP_READ_1_8_8	0xcb	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8	0x82	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8	0xc2	/* Octal page program */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
 #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
@@ -73,9 +77,13 @@
 #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad Output SPI) */
 #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal Output SPI) */
+#define SPINOR_OP_READ_1_8_8_4B	0xcc	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8_4B	0x84	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8_4B	0x8e	/* Octal page program */
 #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
 #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
-- 
2.7.4

