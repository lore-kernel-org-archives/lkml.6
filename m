Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D999C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06242087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Do0vvZbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06242087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJHSZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:32 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:16928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbeJHSZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB2QgM27OGihwNsPgrLlhl4QHy/J2jyHbRMge+ntnXw=;
 b=Do0vvZbXrRe0TqBhTzTP5WPVBH5oGeD8ZxKyYopkd+V9/CbaAT98/0yycr/ljA/QxUaI2OxKkHvhyFY7c5cEms+2zR69nKO7zCIGSTe7EVyfa/Hspo8InWRhTIQJv16nd2NHXupAYB3KkXZXjZjOg9hBVu4gMBWMFkj11/LH5Ig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 11:13:43 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date:   Mon,  8 Oct 2018 16:41:39 +0530
Message-Id: <1538997103-11152-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b4f27a-1eb8-4d93-94c6-08d62d0f1ed2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:+7d0Z/SHbRSr4PrjUWXnsZpIey8Epg7TsDnfvSqp1uubMYPxksMTB8oIjzAaXgnEI5sIcUJPC2k0YhH4Lk53M3ATbr5iWityyj4f9fC2DSvJL5+wbLpUjUxmOQ1/SUqGSksGMVGTTI5Po4JEq73/SEaZ/wh2Vd0udUU1nVwIdi5TDGMCih3mrEXHctqfLs9gulcAHQOp/yXdz2LojkuGttEc1a7mwwv4dBH39lZ76JXhQ7HSq66YJIWdTIqLNkQ+;25:zM0MIqVYxJU/qhW+re+xmqTzsrXquleDLGxY+HNGjajc1V38tDXQwhVrumrZYMRsQAWX6p1wWLI3ZZD1RJq/mSW2ziCykdn1giLdXW16Ib9ZAckcZ/8y/rWUCLb7yJF7ovrmHjrBYhI3+g3d1Uo/34eG6vjmbYc0lldrDedJ2V3aQ0ZiTgKJkKADiHTFra65z6e1Xgx7Qiz9Q7VTeeTlJwu3g3vJSJL/QQx2WDWFY0Xq5t+u/u1TdjoDPnK2nWewFoRu99GH4TVVNAHDbi4YTcLUDwHGnbyCFaMGIj3QWEUtMmr8MUTInNqZZSqWKI6EMnxvvY7grzwo/1WdtB4cvDi7tEUL4B0dzP9Plp8ciJE=;31:KTJWZ2gEykBTSPDWt2AfRhY04el8eAudqVZdL+xIImUNcgdFZT66OOykZoq5N0nlOWc+1HZjZJaf5gl/ukqTWvK5ckYobXxCP0x3ts8CjXvOWgmz41FUSstQQJYydkN/xw9/8LDOJeJMtgwYxwTCApv70wA67tCoWHgaWBx8ERugB7sksATpoRBeLknMVsOuh2CmCQwLShTjP1m0GSX2a2vHwVbfDLKqcb2JLScYDUo=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:L2TaYwZnubZOwSIoQ/pNVo6RdD7H0+PsbsF5U2dcZVL+AuJNCjsMXpNCMWoaMhULIbUvZ6p8agIMdiLXj9F5w/lLS000S4hECPeVg6A21flBwOMMHV83EuHzRJ2iqkx5qerlTw87JEWIs3BdREmkekZpmiwhfAKjZFBN6AsQCfUJYZGfE8r8azyWrQmTG0jYbA56+5+unBAyNqoonUormf881FQI0cDnWWidCC+ZCRozg1wpAgRBmTlpb2svCChP9w+CK3JnSlqyr02I4l4eVg7G3e1eWBCrSA3L17LCe6nmAe0DUJFlDmojL79V070oHTYXwlp8KYmsJ0t8atdY2Qseo7lnsCsA0sl1rDDwYm5LlEQEv5e9kpUEmmeOVZVsmFCwwxUgi6OnRrTOtVHFSRXHANEOdt69wlzyowoPTAQkMsDKYD1qzCyleCy509IWgQfjr2E4tRufl76pqYMDrMipjuDC5YdtktfQvhK3vvzLN2edHdC4bWXQeGzz+dHR;4:ePIW49SjhMUxuc6c+7ipJ+E6ZPge2u5M0JCjjRWcuKDi0d9Fymb3d/XWbts27Q1PglEittfigCmURM7i5JGkbitambrTTJmNEpyUNy9MuZnYVAxJv2oLU8uqxjGdCERtxt0KSDmH+MfDEk6yDYHwHwM5P9ay8K71vIh+hSWlv3S1jHiujuPsQ5RH2tuv+ubZel8k7AtxS9xae47pKo9yjd8vZ47PjN3flEW3pcF/LwGlVcbk1Z+7fLV3qD2xjR0PuAyQgMV/c3cEOAupPEQ+taK/YRgJmvM+lApPwu+vKqZzqRWDEdta5M1b6qPwgWcn
X-Microsoft-Antispam-PRVS: <HE1PR04MB103456E2A6832791066F6A7799E60@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(16586007)(105586002)(6506007)(55236004)(48376002)(316002)(50466002)(16526019)(6486002)(186003)(53936002)(6512007)(68736007)(26005)(53946003)(4744004)(106356001)(4326008)(52116002)(5660300001)(39060400002)(386003)(5009440100003)(51416003)(76176011)(97736004)(47776003)(7416002)(478600001)(2616005)(956004)(575784001)(14444005)(66066001)(25786009)(6666003)(6116002)(36756003)(476003)(486006)(86362001)(8676002)(305945005)(81156014)(81166006)(11346002)(446003)(3846002)(8936002)(50226002)(7736002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:H3OliEgoYL7zq0kZXhTy6/2iJCxw4djcRuiTPjX3o?=
 =?us-ascii?Q?y6Rs0CBL3dAtC7CeowOen/0T5e2pw78LWaPJhxq8kBjC/jVPwYhZajqAOZ5U?=
 =?us-ascii?Q?bV7+9kBx6pc07A/qipXz/vQ7TpkgUiLA6uyjWDe1QsaH/v1pZJUHskWQw/IX?=
 =?us-ascii?Q?aqtXOXrgGCiCIyQ0SykwIb8NIBDolBmY5akHxnBeIrYW9K5POlMO+0d846ZU?=
 =?us-ascii?Q?P42QY8a6mATOJ2epbzRzaMCcDh9aWCAuGd9xVkzixwz/WQREf9JhYpDKNrQq?=
 =?us-ascii?Q?r0QqnEUHwo0dt6HA1zmlrQKxjSGWNJQk3TpbjNF+BLpFatDzf+OKMwYZhbkk?=
 =?us-ascii?Q?G4z3QNjGWsxvOqurKJ8OQL/u8DfDM2LVq+ugJRByre5qJX4ERXKJhXu47e2A?=
 =?us-ascii?Q?1+deyWq10BRRqnUyc4Cjsj3aM03/bC3K8ieEZm1o/i5+2tczNVu+n1YwnVFw?=
 =?us-ascii?Q?qKvIwj3/H/0yfYaWyhonfAsWHSsBWJlVvaRWcdiiJ/wkDNQGQ115fe++f8eM?=
 =?us-ascii?Q?C/iKHoVpol+xQu+gjLuYhM8XX9hUnxGnJOQMG81GeZGKKOeGESWKH6vFlMXK?=
 =?us-ascii?Q?jEWNOJS3LnXmxq/lNP8zjlP4g5cBkzk4CyvXWFzaJUvigENONjh25ReFn5Oe?=
 =?us-ascii?Q?AvGtAUT0NbW0pKVyHUJJpB/Ce2zPnMOFZCx73Q1UTZ3Z5ACGfdAedL3U9ylA?=
 =?us-ascii?Q?NpSa3P/TeQYc2E6lf+i/EHc41C2lNb0J7TL4hMIv04FTtotrYRcofFc2fiW1?=
 =?us-ascii?Q?t+Ki2FDW8xvCAnF53sC6VjCwt9upKsmzF0ig6XExZAeGmTi+TIAjBu+8qmFK?=
 =?us-ascii?Q?EkpIE5U3DlX+a5FQRrmGjMPxFdi2xZ3FucvJjupRdfzxbuh6o4dKnJKK/w9A?=
 =?us-ascii?Q?Ppr10Y1hCgjk14y+l6egz63W6Pw4QmCWZRdnXApi/EXQw+i82/8jqzjYl+Km?=
 =?us-ascii?Q?CoiqS9y58zZautWesEv9xSgHSqNqzwNtVHXWZroKL+6JhUPAURdMX6bWKlAU?=
 =?us-ascii?Q?LamtPNAsqCOR4RftZhkDkMAia/6taEw+cXnCj5qol3ozZSSxk84hlqAsQeE0?=
 =?us-ascii?Q?91BiTT34yeO2fzsYU4eOONSbqvQRqljwR+lqDrAOhuPa2I1ybgqv+zGraGKH?=
 =?us-ascii?Q?vQuNrqDze+Rjf6yCmAi7kGBi3sMfQEGx3j9hyuHULeePqk2jsaTM51DxPEkK?=
 =?us-ascii?Q?/AJcrrC+dtdl5CM7ZZ+/PMQZbNEtfpxoQtXsSkf6DEqyBJIMgK8S6CGljC7A?=
 =?us-ascii?Q?pL2EKLcSq8j2Ytcar1qEynjHScJ+Gp35KHSMzYV+fN1iAb0lguBZiNjiC214?=
 =?us-ascii?Q?7eOUBhSBvyud70ccb/1Y0FsyBDcFooWOENzBvbnPsKTnrQf3/ld4fm03tG0J?=
 =?us-ascii?Q?Bj/rw=3D=3D?=
X-Microsoft-Antispam-Message-Info: kOcdW83EQj4MJ1jcdizyCphb6gTdlMVMn6YTHzEYbsRpx43tClVgxA+ac4Ozt4Mpuuuwsiq6eYFmJVSPMfrlhU9Y12RgkRWnDGGCCY0pWxUyCOnLeEnmapbSnLfPRQdURzcZmERE0qBsA8HBFzvcppD/NgE68xuCflamnUVCVKTyfIXhOMcfXo+qoqMbNngjAvh8mizsjl1Mf0kOT4G46rdnsQwPQLiF5iDMrQqpWGdlnl6G9WxIfNdQCje+ihV0C/F2oOcPmr21r94fj9EA2Z3jqcgct5dSg6zTOuSI/y96jW8YxZAh1F/RoJiVFlAuOjWoJ3sFvT/+tScmTcwymFcMVDrQIe4zIU32aAJ7Stk=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:srqVs11nkv5KqjWG4kLu1nN1KsOP4P2jktd4G1hAa1l77ClSiJNIn48Qu0//6qnm9/6JUO1SFnrmY9o3t8UiReb5li559cgjPJuKibJVafleIbwAN1/sBNP1TWO0AWQEih0axY3LZMhLsbAFCRAoaZlCJhjiCfwwpi1uR9v+5Cy2lFLbIyKODvGgK6mzQGn7DEOwJT5hbLWxa709VErxTc6L1TpsekwQrR+Pm71hLzgMRZBtZJW/0+UlCZvoL3F04MNg04j7aH3qWTtEFawZ8RpIDmHqtpGH1bPDR1nkNb4EBPVNFJvEGO5I2viZ8TJIMqDD3n4Yn5Zg3THLcnDWCSi7PSP9v/EF7TD8OKLX8Nq0wu+xjy1VmsY80SK0TWda36wgaqzlFm0enSb/oIyXMsyydFmzec48nbBVQ4GryTNCcWRl8l7ejnKQhBBLvRNjfX2RyKhmjxdABj0ETcxtbQ==;5:uPjo9Wn/kntyGmZUPc2H6xICdrrBwQx/lMUpK9iz1FvdAPSHG/8911lRPAd4y2DORr1mZtIIXRBZuInogW5F5HgWP2T4Zq0a0+33ZFT/jLKmXg+4TVeWZg0ZxQYi63B2/Y6WrfGdOqmbzc1wdXW3cZ4lCGZcr2jU04YWEkxkG4c=;7:D34fCiHKS77nbJEl5yBxi2qVhJN71TSoHpERGXdW6c7zmftQeCIHgtFWkI4lFZ0ZagA5yBPk9WXGnoKnDSgTqHoQjw2pg2Or+IVotaT8ZxHFkz9QQrUvM2w/LwYF3zwsXo58pjwYR+Dym8ALsr+r59IM5Tg56A6SJkwDa4LeoQnVu7bb5wl/qVgD2+q0t3w429qjRp9J+BLQgD0EU+f+mSQAPyG1bwvxUunrVlw+E/80J4923lXqSf8OhZNYmpz1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 11:13:43.8912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b4f27a-1eb8-4d93-94c6-08d62d0f1ed2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add driver for NXP FlexSPI host controller

(0) What is the FlexSPI controller?
 FlexSPI is a flexsible SPI host controller which supports two SPI
 channels and up to 4 external devices. Each channel supports
 Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
 data lines) i.e. FlexSPI acts as an interface to external devices,
 maximum 4, each with up to 8 bidirectional data lines.

 It uses new SPI memory interface of the SPI framework to issue
 flash memory operations to up to four connected flash
 devices (2 buses with 2 CS each).

(1) Tested this driver with the mtd_debug and JFFS2 filesystem utility
 on NXP LX2160ARDB and LX2160AQDS targets.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
    Micron, mt35xu512ab, [Read - 1 bit mode]
    Cypress, s25fl512s, [Read - 1/2/4 bit mode]

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- Incorporate Boris review comments
  * Use readl_poll_timeout() instead of busy looping.
  * Re-define register masking as per comment.
  * Drop fspi_devtype enum.
Changes for v3:
- Added endianness flag in platform specific structure instead of DTS.
- Modified nxp_fspi_read_ahb(), removed remapping code.
- Added Boris and Frieder as Author and provided reference of spi-fsl-qspi.c
Changes for v2:
- Incorporated Boris review comments.
- Remove dependency of driver over connected flash device size.
- Modified the logic to select requested CS.
- Remove SPI-Octal Macros.

 drivers/spi/Kconfig        |   10 +
 drivers/spi/Makefile       |    1 +
 drivers/spi/spi-nxp-fspi.c | 1157 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1168 insertions(+)
 create mode 100644 drivers/spi/spi-nxp-fspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ad5d68e..68da874 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -251,6 +251,16 @@ config SPI_FSL_LPSPI
 	help
 	  This enables Freescale i.MX LPSPI controllers in master mode.
 
+config SPI_NXP_FLEXSPI
+	tristate "NXP Flex SPI controller"
+	depends on ARCH_LAYERSCAPE || HAS_IOMEM
+	help
+	  This enables support for the Flex SPI controller in master mode.
+	  Up to four slave devices can be connected on two buses with two
+	  chipselects each.
+	  This controller does not support generic SPI messages and only
+	  supports the high-level SPI memory interface.
+
 config SPI_GPIO
 	tristate "GPIO-based bitbanging SPI Master"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index cb1f437..52c9f18 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
 obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
+obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
 obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
new file mode 100644
index 0000000..1e8f256
--- /dev/null
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -0,0 +1,1157 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * NXP FlexSPI(FSPI) controller driver.
+ *
+ * Copyright 2018 NXP.
+ *
+ * FlexSPI is a flexsible SPI host controller which supports two SPI
+ * channels and up to 4 external devices. Each channel supports
+ * Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
+ * data lines).
+ *
+ * FlexSPI controller is driven by the LUT(Look-up Table) registers
+ * LUT registers are a look-up-table for sequences of instructions.
+ * A valid sequence consists of four LUT registers.
+ * Maximum 32 LUT sequences can be programmed simultaneously.
+ *
+ * LUTs are being created at run-time based on the commands passed
+ * from the spi-mem framework, thus using single LUT index.
+ *
+ * Software triggered Flash read/write access by IP Bus.
+ *
+ * Memory mapped read access by AHB Bus.
+ *
+ * Based on SPI MEM interface and spi-fsl-qspi.c driver.
+ *
+ * Author:
+ *     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+ *     Boris Brezillion <boris.brezillon@bootlin.com>
+ *     Frieder Schrempf <frieder.schrempf@exceet.de>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_qos.h>
+#include <linux/sizes.h>
+#include <linux/iopoll.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+/*
+ * The driver only uses one single LUT entry, that is updated on
+ * each call of exec_op(). Index 0 is preset at boot with a basic
+ * read operation, so let's use the last entry (31).
+ */
+#define	SEQID_LUT			31
+
+/* Registers used by the driver */
+#define FSPI_MCR0			0x00
+#define FSPI_MCR0_AHB_TIMEOUT_MASK	GENMASK(31, 24)
+#define FSPI_MCR0_IP_TIMEOUT_MASK	GENMASK(23, 16)
+#define FSPI_MCR0_LEARN_EN_MASK		BIT(15)
+#define FSPI_MCR0_SCRFRUN_EN_MASK	BIT(14)
+#define FSPI_MCR0_OCTCOMB_EN_MASK	BIT(13)
+#define FSPI_MCR0_DOZE_EN_MASK		BIT(12)
+#define FSPI_MCR0_HSEN_MASK		BIT(11)
+#define FSPI_MCR0_SERCLKDIV_MASK	BIT(8)
+#define FSPI_MCR0_ATDF_EN_MASK		BIT(7)
+#define FSPI_MCR0_ARDF_EN_MASK		BIT(6)
+#define FSPI_MCR0_RXCLKSRC_MASK		GENMASK(5, 4)
+#define FSPI_MCR0_END_CFG_MASK		GENMASK(3, 2)
+#define FSPI_MCR0_MDIS_MASK		BIT(1)
+#define FSPI_MCR0_SWRST_MASK		BIT(0)
+
+#define FSPI_MCR1			0x04
+#define FSPI_MCR1_SEQ_TIMEOUT_MASK	GENMASK(31, 16)
+#define FSPI_MCR1_AHB_TIMEOUT_MASK	GENMASK(15, 0)
+
+#define FSPI_MCR2			0x08
+#define FSPI_MCR2_IDLE_WAIT_MASK	GENMASK(31, 24)
+#define FSPI_MCR2_SAMEDEVICEEN_MASK	BIT(15)
+#define FSPI_MCR2_CLRLRPHS_MASK		BIT(14)
+#define FSPI_MCR2_ABRDATSZ_MASK		BIT(8)
+#define FSPI_MCR2_ABRLEARN_MASK		BIT(7)
+#define FSPI_MCR2_ABR_READ_MASK		BIT(6)
+#define FSPI_MCR2_ABRWRITE_MASK		BIT(5)
+#define FSPI_MCR2_ABRDUMMY_MASK		BIT(4)
+#define FSPI_MCR2_ABR_MODE_MASK		BIT(3)
+#define FSPI_MCR2_ABRCADDR_MASK		BIT(2)
+#define FSPI_MCR2_ABRRADDR_MASK		BIT(1)
+#define FSPI_MCR2_ABR_CMD_MASK		BIT(0)
+
+#define FSPI_AHBCR			0x0c
+#define FSPI_AHBCR_RDADDROPT_MASK	BIT(6)
+#define FSPI_AHBCR_PREF_EN_MASK		BIT(5)
+#define FSPI_AHBCR_BUFF_EN_MASK		BIT(4)
+#define FSPI_AHBCR_CACH_EN_MASK		BIT(3)
+#define FSPI_AHBCR_CLRTXBUF_MASK	BIT(2)
+#define FSPI_AHBCR_CLRRXBUF_MASK	BIT(1)
+#define FSPI_AHBCR_PAR_EN_MASK		BIT(0)
+
+#define FSPI_INTEN			0x10
+#define FSPI_INTEN_SCLKSBWR_MASK	BIT(9)
+#define FSPI_INTEN_SCLKSBRD_MASK	BIT(8)
+#define FSPI_INTEN_DATALRNFL_MASK	BIT(7)
+#define FSPI_INTEN_IPTXWE_MASK		BIT(6)
+#define FSPI_INTEN_IPRXWA_MASK		BIT(5)
+#define FSPI_INTEN_AHBCMDERR_MASK	BIT(4)
+#define FSPI_INTEN_IPCMDERR_MASK	BIT(3)
+#define FSPI_INTEN_AHBCMDGE_MASK	BIT(2)
+#define FSPI_INTEN_IPCMDGE_MASK		BIT(1)
+#define FSPI_INTEN_IPCMDDONE_MASK	BIT(0)
+
+#define FSPI_INTR			0x14
+#define FSPI_INTR_SCLKSBWR_MASK		BIT(9)
+#define FSPI_INTR_SCLKSBRD_MASK		BIT(8)
+#define FSPI_INTR_DATALRNFL_MASK	BIT(7)
+#define FSPI_INTR_IPTXWE_MASK		BIT(6)
+#define FSPI_INTR_IPRXWA_MASK		BIT(5)
+#define FSPI_INTR_AHBCMDERR_MASK	BIT(4)
+#define FSPI_INTR_IPCMDERR_MASK		BIT(3)
+#define FSPI_INTR_AHBCMDGE_MASK		BIT(2)
+#define FSPI_INTR_IPCMDGE_MASK		BIT(1)
+#define FSPI_INTR_IPCMDDONE_MASK	BIT(0)
+
+#define FSPI_LUTKEY			0x18
+#define FSPI_LUTKEY_VALUE		0x5AF05AF0
+
+#define FSPI_LCKCR			0x1C
+
+#define FSPI_LCKER_LOCK			0x1
+#define FSPI_LCKER_UNLOCK		0x2
+
+#define FSPI_BUFXCR_INVALID_MSTRID	0xE
+#define FSPI_AHBRX_BUF0CR0		0x20
+#define FSPI_AHBRX_BUF1CR0		0x24
+#define FSPI_AHBRX_BUF2CR0		0x28
+#define FSPI_AHBRX_BUF3CR0		0x2C
+#define FSPI_AHBRX_BUF4CR0		0x30
+#define FSPI_AHBRX_BUF5CR0		0x34
+#define FSPI_AHBRX_BUF6CR0		0x38
+#define FSPI_AHBRX_BUF7CR0		0x3C
+#define FSPI_AHBRXBUF0CR7_PREF_MASK	BIT(31)
+
+#define FSPI_AHBRX_BUF0CR1		0x40
+#define FSPI_AHBRX_BUF1CR1		0x44
+#define FSPI_AHBRX_BUF2CR1		0x48
+#define FSPI_AHBRX_BUF3CR1		0x4C
+#define FSPI_AHBRX_BUF4CR1		0x50
+#define FSPI_AHBRX_BUF5CR1		0x54
+#define FSPI_AHBRX_BUF6CR1		0x58
+#define FSPI_AHBRX_BUF7CR1		0x5C
+
+#define FSPI_FLSHA1CR0			0x60
+#define FSPI_FLSHA2CR0			0x64
+#define FSPI_FLSHB1CR0			0x68
+#define FSPI_FLSHB2CR0			0x6C
+#define FSPI_FLSHXCR0_SZ_SHIFT		10
+#define FSPI_FLSHXCR0_SZ_MASK		(0x3FFFFF << FSPI_FLSHXCR0_SZ_SHIFT)
+
+#define FSPI_FLSHA1CR1			0x70
+#define FSPI_FLSHA2CR1			0x74
+#define FSPI_FLSHB1CR1			0x78
+#define FSPI_FLSHB2CR1			0x7C
+#define FSPI_FLSHXCR1_CSINTR_MASK	GENMASK(31, 16)
+#define FSPI_FLSHXCR1_CAS_MASK		GENMASK(14, 11)
+#define FSPI_FLSHXCR1_WA_MASK		BIT(10)
+#define FSPI_FLSHXCR1_TCSH_MASK		GENMASK(9, 5)
+#define FSPI_FLSHXCR1_TCSS_MASK		GENMASK(4, 0)
+
+#define FSPI_FLSHA1CR2			0x80
+#define FSPI_FLSHA2CR2			0x84
+#define FSPI_FLSHB1CR2			0x88
+#define FSPI_FLSHB2CR2			0x8C
+#define FSPI_FLSHXCR2_CLRINSP_MASK	BIT(24)
+#define FSPI_FLSHXCR2_AWRWAIT_MASK	BIT(16)
+#define FSPI_FLSHXCR2_AWRSEQN_SHIFT	13
+#define FSPI_FLSHXCR2_AWRSEQI_SHIFT	8
+#define FSPI_FLSHXCR2_ARDSEQN_SHIFT	5
+#define FSPI_FLSHXCR2_ARDSEQI_SHIFT	0
+
+#define FSPI_IPCR0			0xA0
+
+#define FSPI_IPCR1			0xA4
+#define FSPI_IPCR1_IPAREN_MASK		BIT(31)
+#define FSPI_IPCR1_SEQNUM_SHIFT		24
+#define FSPI_IPCR1_SEQID_SHIFT		16
+#define FSPI_IPCR1_IDATSZ_MASK		GENMASK(15, 0)
+
+#define FSPI_IPCMD			0xB0
+#define FSPI_IPCMD_TRG_MASK		BIT(0)
+
+#define FSPI_DLPR			0xB4
+
+#define FSPI_IPRXFCR			0xB8
+#define FSPI_IPRXFCR_CLR_MASK		BIT(0)
+#define FSPI_IPRXFCR_DMA_EN_MASK	BIT(1)
+#define FSPI_IPRXFCR_WMRK_MASK		GENMASK(7, 2)
+
+#define FSPI_IPTXFCR			0xBC
+#define FSPI_IPTXFCR_CLR_MASK		BIT(0)
+#define FSPI_IPTXFCR_DMA_EN_MASK	BIT(1)
+#define FSPI_IPTXFCR_WMRK_MASK		GENMASK(7, 2)
+
+#define FSPI_DLLACR			0xC0
+#define FSPI_DLLACR_OVRDEN_MASK		BIT(8)
+
+#define FSPI_DLLBCR			0xC4
+#define FSPI_DLLBCR_OVRDEN_MASK		BIT(8)
+
+#define FSPI_STS0			0xE0
+#define FSPI_STS0_DLPHB_MASK		GENMASK(11, 8)
+#define FSPI_STS0_DLPHA_MASK		GENMASK(7, 4)
+#define FSPI_STS0_CMD_SRC_MASK		GENMASK(3, 2)
+#define FSPI_STS0_ARB_IDLE_MASK		BIT(1)
+#define FSPI_STS0_SEQ_IDLE_MASK		BIT(0)
+
+#define FSPI_STS1			0xE4
+#define FSPI_STS1_IP_ERRCD_MASK		GENMASK(27, 24)
+#define FSPI_STS1_IP_ERRID_MASK		GENMASK(20, 16)
+#define FSPI_STS1_AHB_ERRCD_MASK	GENMASK(11, 8)
+#define FSPI_STS1_AHB_ERRID_MASK	GENMASK(4, 0)
+
+#define FSPI_AHBSPNST			0xEC
+#define FSPI_AHBSPNST_DATLFT_MASK	GENMASK(31, 16)
+#define FSPI_AHBSPNST_BUFID_MASK	GENMASK(3, 1)
+#define FSPI_AHBSPNST_ACTIVE_MASK	BIT(0)
+
+#define FSPI_IPRXFSTS			0xF0
+#define FSPI_IPRXFSTS_RDCNTR_MASK	GENMASK(31, 16)
+#define FSPI_IPRXFSTS_FILL_MASK		GENMASK(7, 0)
+
+#define FSPI_IPTXFSTS			0xF4
+#define FSPI_IPTXFSTS_WRCNTR_MASK	GENMASK(31, 16)
+#define FSPI_IPTXFSTS_FILL_MASK		GENMASK(7, 0)
+
+#define FSPI_RFDR			0x100
+#define FSPI_TFDR			0x180
+
+#define FSPI_LUT_BASE			0x200
+#define FSPI_LUT_OFFSET			(SEQID_LUT * 4 * 4)
+#define FSPI_LUT_REG(idx) \
+	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
+
+/* register map end */
+
+/* Instruction set for the LUT register. */
+#define LUT_STOP			0x00
+#define LUT_CMD				0x01
+#define LUT_ADDR			0x02
+#define LUT_CADDR_SDR			0x03
+#define LUT_MODE			0x04
+#define LUT_MODE2			0x05
+#define LUT_MODE4			0x06
+#define LUT_MODE8			0x07
+#define LUT_NXP_WRITE			0x08
+#define LUT_NXP_READ			0x09
+#define LUT_LEARN_SDR			0x0A
+#define LUT_DATSZ_SDR			0x0B
+#define LUT_DUMMY			0x0C
+#define LUT_DUMMY_RWDS_SDR		0x0D
+#define LUT_JMP_ON_CS			0x1F
+#define LUT_CMD_DDR			0x21
+#define LUT_ADDR_DDR			0x22
+#define LUT_CADDR_DDR			0x23
+#define LUT_MODE_DDR			0x24
+#define LUT_MODE2_DDR			0x25
+#define LUT_MODE4_DDR			0x26
+#define LUT_MODE8_DDR			0x27
+#define LUT_WRITE_DDR			0x28
+#define LUT_READ_DDR			0x29
+#define LUT_LEARN_DDR			0x2A
+#define LUT_DATSZ_DDR			0x2B
+#define LUT_DUMMY_DDR			0x2C
+#define LUT_DUMMY_RWDS_DDR		0x2D
+
+/*
+ * Calculate number of required PAD bits for LUT register.
+ *
+ * The pad stands for the number of IO lines [0:7].
+ * For example, the octal read needs eight IO lines,
+ * so you should use LUT_PAD(8). This macro
+ * returns 3 i.e. use eight (2^3) IP lines for read.
+ */
+#define LUT_PAD(x) (fls(x) - 1)
+
+/*
+ * Macro for constructing the LUT entries with the following
+ * register layout:
+ *
+ *  ---------------------------------------------------
+ *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
+ *  ---------------------------------------------------
+ */
+#define PAD_SHIFT		8
+#define INSTR_SHIFT		10
+#define OPRND_SHIFT		16
+
+/* Macros for constructing the LUT register. */
+#define LUT_DEF(idx, ins, pad, opr)			  \
+	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
+	(opr)) << (((idx) % 2) * OPRND_SHIFT))
+
+/* Oprands for the LUT register. */
+#define ADDR8BIT		0x08
+#define ADDR16BIT		0x10
+#define ADDR24BIT		0x18
+#define ADDR32BIT		0x20
+
+#define POLL_TOUT		5000
+
+struct nxp_fspi_devtype_data {
+	unsigned int rxfifo;
+	unsigned int txfifo;
+	unsigned int ahb_buf_size;
+	unsigned int quirks;
+	bool little_endian;
+};
+
+static const struct nxp_fspi_devtype_data lx2160a_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = 1,     /* little-endian    */
+};
+
+#define NXP_FSPI_MAX_CHIPSELECT		4
+
+struct nxp_fspi {
+	void __iomem *iobase;
+	void __iomem *ahb_addr;
+	u32 memmap_phy;
+	u32 memmap_phy_size;
+	struct clk *clk, *clk_en;
+	struct device *dev;
+	struct completion c;
+	const struct nxp_fspi_devtype_data *devtype_data;
+	struct mutex lock;
+	struct pm_qos_request pm_qos_req;
+	int selected;
+	void (*write)(u32 val, void __iomem *addr);
+	u32 (*read)(void __iomem *addr);
+};
+
+static void fspi_writel_be(u32 val, void __iomem *addr)
+{
+	iowrite32be(val, addr);
+}
+
+static void fspi_writel(u32 val, void __iomem *addr)
+{
+	iowrite32(val, addr);
+}
+
+static u32 fspi_readl_be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static u32 fspi_readl(void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static irqreturn_t nxp_fspi_irq_handler(int irq, void *dev_id)
+{
+	struct nxp_fspi *f = dev_id;
+	u32 reg;
+
+	/* clear interrupt */
+	reg = f->read(f->iobase + FSPI_INTR);
+	f->write(FSPI_INTR_IPCMDDONE_MASK, f->iobase + FSPI_INTR);
+
+	if (reg & FSPI_INTR_IPCMDDONE_MASK)
+		complete(&f->c);
+
+	return IRQ_HANDLED;
+}
+
+static int nxp_fspi_check_buswidth(struct nxp_fspi *f, u8 width)
+{
+	switch (width) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
+static bool nxp_fspi_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+	int ret;
+
+	ret = nxp_fspi_check_buswidth(f, op->cmd.buswidth);
+
+	if (op->addr.nbytes)
+		ret |= nxp_fspi_check_buswidth(f, op->addr.buswidth);
+
+	if (op->dummy.nbytes)
+		ret |= nxp_fspi_check_buswidth(f, op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ret |= nxp_fspi_check_buswidth(f, op->data.buswidth);
+
+	if (ret)
+		return false;
+
+	/*
+	 * The number of instructions needed for the op, needs
+	 * to fit into a single LUT entry.
+	 */
+	if (op->addr.nbytes +
+	   (op->dummy.nbytes ? 1:0) +
+	   (op->data.nbytes ? 1:0) > 6)
+		return false;
+
+	/* Max 64 dummy clock cycles supported */
+	if (op->dummy.buswidth &&
+	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+		return false;
+
+	/* Max data length, check controller limits and alignment */
+	if (op->data.dir == SPI_MEM_DATA_IN &&
+	    (op->data.nbytes > f->devtype_data->ahb_buf_size ||
+	     (op->data.nbytes > f->devtype_data->rxfifo - 4 &&
+	      !IS_ALIGNED(op->data.nbytes, 8))))
+		return false;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT &&
+	    op->data.nbytes > f->devtype_data->txfifo)
+		return false;
+
+	return true;
+}
+
+/* Instead of busy looping invoke readl_poll_timeout functionality. */
+static int fspi_readl_poll_tout(struct nxp_fspi *f, void __iomem *base, u32 reg,
+				u32 mask, u32 delay_us, u32 timeout_us)
+{
+	u32 l_mask;
+
+	if (f->devtype_data->little_endian)
+		l_mask = mask;
+	else
+		l_mask = (u32)cpu_to_be32(mask);
+
+	return readl_poll_timeout(base, reg, (reg & l_mask),
+				  delay_us, timeout_us);
+}
+
+/*
+ * If the slave device content being changed by Write/Erase, need to
+ * invalidate the AHB buffer. This can be achieved by doing the reset
+ * of controller after setting MCR0[SWRESET] bit.
+ */
+static inline void nxp_fspi_invalid(struct nxp_fspi *f)
+{
+	u32 reg;
+	int ret;
+	u32 l_mask;
+
+	reg = f->read(f->iobase + FSPI_MCR0);
+	f->write(reg | FSPI_MCR0_SWRST_MASK, f->iobase + FSPI_MCR0);
+
+	if (f->devtype_data->little_endian)
+		l_mask = FSPI_MCR0_SWRST_MASK;
+	else
+		l_mask = (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
+
+	/* w1c register, wait unit clear */
+	ret = readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
+				 !(reg & l_mask), 0, POLL_TOUT);
+	WARN_ON(ret);
+}
+
+static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base = f->iobase;
+	u32 lutval[4] = {};
+	int lutidx = 1, i;
+
+	/* cmd */
+	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
+			     op->cmd.opcode);
+
+	/* addr bus width */
+	if (op->addr.nbytes) {
+		u32 addrlen = 0;
+
+		if (op->addr.nbytes == 3)
+			addrlen = ADDR24BIT;
+		else if (op->addr.nbytes == 4)
+			addrlen = ADDR32BIT;
+
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
+					      LUT_PAD(op->addr.buswidth),
+					      addrlen);
+		lutidx++;
+	}
+
+	/* dummy bytes, if needed */
+	if (op->dummy.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+		/*
+		 * Due to FlexSPI controller limitation, number of PAD for dummy
+		 * buswidth needs to be programmed as equal to data buswidth.
+		 */
+					      LUT_PAD(op->data.buswidth),
+					      op->dummy.nbytes * 8 /
+					      op->dummy.buswidth);
+		lutidx++;
+	}
+
+	/* read/write data bytes */
+	if (op->data.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx,
+					      op->data.dir == SPI_MEM_DATA_IN ?
+					      LUT_NXP_READ : LUT_NXP_WRITE,
+					      LUT_PAD(op->data.buswidth),
+					      0);
+		lutidx++;
+	}
+
+	/* stop condition. */
+	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
+
+	/* unlock LUT */
+	f->write(FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
+	f->write(FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
+
+	/* fill LUT */
+	for (i = 0; i < ARRAY_SIZE(lutval); i++)
+		f->write(lutval[i], base + FSPI_LUT_REG(i));
+
+	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x]\n",
+		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3]);
+
+	/* lock LUT */
+	f->write(FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
+	f->write(FSPI_LCKER_LOCK, f->iobase + FSPI_LCKCR);
+}
+
+static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
+{
+	int ret;
+
+	ret = clk_prepare_enable(f->clk_en);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(f->clk);
+	if (ret) {
+		clk_disable_unprepare(f->clk_en);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
+{
+	clk_disable_unprepare(f->clk);
+	clk_disable_unprepare(f->clk_en);
+}
+
+/*
+ * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
+ * register and start base address of the slave device.
+ *
+ *							    (Higher address)
+ *				--------    <-- FLSHB2CR0
+ *				|  B2  |
+ *				|      |
+ *	B2 start address -->	--------    <-- FLSHB1CR0
+ *				|  B1  |
+ *				|      |
+ *	B1 start address -->	--------    <-- FLSHA2CR0
+ *				|  A2  |
+ *				|      |
+ *	A2 start address -->	--------    <-- FLSHA1CR0
+ *				|  A1  |
+ *				|      |
+ *	A1 start address -->	--------		    (Lower address)
+ *
+ *
+ * Start base address defines the starting address range for given CS and
+ * FSPI_FLSHXXCR0 defines the size of the slave device connected at given CS.
+ *
+ * But, different targets are having different combinations of number of CS,
+ * some targets only have single CS or two CS covering controller's full
+ * memory mapped space area.
+ * Thus, implementation is being done as independent of the size and number
+ * of the connected slave device.
+ * Assign controller memory mapped space size as the size to the connected
+ * slave device.
+ * Mark FLSHxxCR0 as zero initially and then assign value only to the selected
+ * chip-select Flash configuration register.
+ *
+ * For e.g. to access CS2 (B1), FLSHB1CR0 register would be equal to the
+ * memory mapped size of the controller.
+ * Value for rest of the CS FLSHxxCR0 register would be zero.
+ *
+ */
+static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
+{
+	unsigned long rate = spi->max_speed_hz;
+	int ret;
+	uint64_t size_kb;
+
+	/*
+	 * Return, if previously selected slave device is same as current
+	 * requested slave device.
+	 */
+	if (f->selected == spi->chip_select)
+		return;
+
+	/* Reset FLSHxxCR0 registers */
+	f->write(0, f->iobase + FSPI_FLSHA1CR0);
+	f->write(0, f->iobase + FSPI_FLSHA2CR0);
+	f->write(0, f->iobase + FSPI_FLSHB1CR0);
+	f->write(0, f->iobase + FSPI_FLSHB2CR0);
+
+	/* Assign controller memory mapped space, as size of the flash. */
+	size_kb = f->memmap_phy_size >> FSPI_FLSHXCR0_SZ_SHIFT;
+
+	switch (spi->chip_select) {
+	case 0:
+		f->write(size_kb, f->iobase + FSPI_FLSHA1CR0);
+		break;
+	case 1:
+		f->write(size_kb, f->iobase + FSPI_FLSHA2CR0);
+		break;
+	case 2:
+		f->write(size_kb, f->iobase + FSPI_FLSHB1CR0);
+		break;
+	case 3:
+		f->write(size_kb, f->iobase + FSPI_FLSHB2CR0);
+		break;
+	default:
+		dev_err(f->dev, "In-correct CS provided\n");
+		return;
+	}
+
+	dev_dbg(f->dev, "Slave device [CS:%x] selected\n", spi->chip_select);
+
+	nxp_fspi_clk_disable_unprep(f);
+
+	ret = clk_set_rate(f->clk, rate);
+	if (ret)
+		return;
+
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return;
+	f->selected = spi->chip_select;
+}
+
+static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
+{
+	u32 len = op->data.nbytes;
+
+	/* Read out the data directly from the AHB buffer. */
+	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
+}
+
+static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base = f->iobase;
+	int i, j, ret;
+	int size, tmp_size, wm_size;
+	u32 data = 0, reg;
+	u32 *txbuf = (u32 *) op->data.buf.out;
+
+	/* clear the TX FIFO. */
+	f->write(FSPI_IPTXFCR_CLR_MASK, base + FSPI_IPTXFCR);
+
+	/* Default value of water mark level is 8 bytes. */
+	wm_size = 8;
+	size = op->data.nbytes / wm_size;
+	for (i = 0; i < size; i++) {
+		/* Wait for TXFIFO empty */
+		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR, reg,
+					   FSPI_INTR_IPTXWE_MASK, 0, POLL_TOUT);
+		WARN_ON(ret);
+
+		j = 0;
+		tmp_size = wm_size;
+		while (tmp_size > 0) {
+			data = 0;
+			memcpy(&data, txbuf, 4);
+			f->write(data, base + FSPI_TFDR + j * 4);
+			tmp_size -= 4;
+			j++;
+			txbuf += 1;
+		}
+		f->write(FSPI_INTR_IPTXWE_MASK, base + FSPI_INTR);
+	}
+
+	size = op->data.nbytes % wm_size;
+	if (size) {
+		/* Wait for TXFIFO empty */
+		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR, reg,
+					   FSPI_INTR_IPTXWE_MASK, 0, POLL_TOUT);
+		WARN_ON(ret);
+
+		j = 0;
+		tmp_size = 0;
+		while (size > 0) {
+			data = 0;
+			tmp_size = (size < 4) ? size : 4;
+			memcpy(&data, txbuf, tmp_size);
+			f->write(data, base + FSPI_TFDR + j * 4);
+			size -= tmp_size;
+			j++;
+			txbuf += 1;
+		}
+		f->write(FSPI_INTR_IPTXWE_MASK, base + FSPI_INTR);
+	}
+}
+
+static void nxp_fspi_read_rxfifo(struct nxp_fspi *f,
+			  const struct spi_mem_op *op)
+{
+	void __iomem *base = f->iobase;
+	int i, j;
+	int size, tmp_size, wm_size, ret;
+	u32 tmp = 0, reg;
+	u8 *buf = op->data.buf.in;
+	u32 len = op->data.nbytes;
+
+	/* Default value of water mark level is 8 bytes. */
+	wm_size = 8;
+
+	while (len > 0) {
+		size = len / wm_size;
+
+		for (i = 0; i < size; i++) {
+			/* Wait for RXFIFO available */
+			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
+						   reg, FSPI_INTR_IPRXWA_MASK,
+						   0, POLL_TOUT);
+			WARN_ON(ret);
+
+			j = 0;
+			tmp_size = wm_size;
+			while (tmp_size > 0) {
+				tmp = 0;
+				tmp = f->read(base + FSPI_RFDR + j * 4);
+				memcpy(buf, &tmp, 4);
+				tmp_size -= 4;
+				j++;
+				buf += 4;
+			}
+			/* move the FIFO pointer */
+			f->write(FSPI_INTR_IPRXWA_MASK, base + FSPI_INTR);
+			len -= wm_size;
+		}
+
+		size = len % wm_size;
+
+		j = 0;
+		if (size) {
+			/* Wait for RXFIFO available */
+			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
+						   reg, FSPI_INTR_IPRXWA_MASK,
+						   0, POLL_TOUT);
+			WARN_ON(ret);
+
+			while (len > 0) {
+				tmp = 0;
+				size = (len < 4) ? len : 4;
+				tmp = f->read(base + FSPI_RFDR + j * 4);
+				memcpy(buf, &tmp, size);
+				len -= size;
+				j++;
+				buf += size;
+			}
+		}
+
+		/* invalid the RXFIFO */
+		f->write(FSPI_IPRXFCR_CLR_MASK, base + FSPI_IPRXFCR);
+		/* move the FIFO pointer */
+		f->write(FSPI_INTR_IPRXWA_MASK, base + FSPI_INTR);
+	}
+}
+
+static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
+{
+	void __iomem *base = f->iobase;
+	int seqnum = 0;
+	int err = 0;
+	u32 reg;
+
+	reg = f->read(base + FSPI_IPRXFCR);
+	/* invalid RXFIFO first */
+	reg &= ~FSPI_IPRXFCR_DMA_EN_MASK;
+	reg = reg | FSPI_IPRXFCR_CLR_MASK;
+	f->write(reg, base + FSPI_IPRXFCR);
+
+	init_completion(&f->c);
+
+	f->write(op->addr.val, base + FSPI_IPCR0);
+	/*
+	 * Always start the sequence at the same index since we update
+	 * the LUT at each exec_op() call. And also specify the DATA
+	 * length, since it's has not been specified in the LUT.
+	 */
+	f->write(op->data.nbytes |
+		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
+		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
+		 base + FSPI_IPCR1);
+
+	/* Trigger the LUT now. */
+	f->write(FSPI_IPCMD_TRG_MASK, base + FSPI_IPCMD);
+
+	/* Wait for the interrupt. */
+	if (!wait_for_completion_timeout(&f->c, msecs_to_jiffies(1000)))
+		err = -ETIMEDOUT;
+
+	/* Invoke IP data read, if request is of data read. */
+	if (!err && op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+		nxp_fspi_read_rxfifo(f, op);
+
+	return err;
+}
+
+static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+	void __iomem *base = f->iobase;
+	int err = 0;
+	u32 status;
+
+	mutex_lock(&f->lock);
+
+	/* Wait for controller being ready. */
+	status = f->read(base + FSPI_STS0);
+	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0, status,
+				   FSPI_STS0_ARB_IDLE_MASK, 1, POLL_TOUT);
+	WARN_ON(err);
+
+	nxp_fspi_select_mem(f, mem->spi);
+
+	nxp_fspi_prepare_lut(f, op);
+	/*
+	 * If we have large chunks of data, we read them through the AHB bus
+	 * by accessing the mapped memory. In all other cases we use
+	 * IP commands to access the flash.
+	 */
+	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
+	    op->data.dir == SPI_MEM_DATA_IN) {
+		nxp_fspi_read_ahb(f, op);
+	} else {
+		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
+			nxp_fspi_fill_txfifo(f, op);
+
+		err = nxp_fspi_do_op(f, op);
+
+		/* Invalidate the data in the AHB buffer. */
+		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
+			nxp_fspi_invalid(f);
+	}
+
+	mutex_unlock(&f->lock);
+
+	return err;
+}
+
+static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (op->data.nbytes > f->devtype_data->txfifo)
+			op->data.nbytes = f->devtype_data->txfifo;
+	} else {
+		if (op->data.nbytes > f->devtype_data->ahb_buf_size)
+			op->data.nbytes = f->devtype_data->ahb_buf_size;
+		else if (op->data.nbytes > (f->devtype_data->rxfifo - 4))
+			op->data.nbytes = ALIGN_DOWN(op->data.nbytes, 8);
+	}
+
+	return 0;
+}
+
+static int nxp_fspi_default_setup(struct nxp_fspi *f)
+{
+	void __iomem *base = f->iobase;
+	int ret, i;
+	u32 reg, l_mask;
+
+	/* disable and unprepare clock to avoid glitch pass to controller */
+	nxp_fspi_clk_disable_unprep(f);
+
+	/* the default frequency, we will change it later if necessary. */
+	ret = clk_set_rate(f->clk, 20000000);
+	if (ret)
+		return ret;
+
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return ret;
+
+	/* Reset the module */
+	f->write(FSPI_MCR0_SWRST_MASK, base + FSPI_MCR0);
+
+	if (f->devtype_data->little_endian)
+		l_mask = FSPI_MCR0_SWRST_MASK;
+	else
+		l_mask = (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
+
+	/* w1c register, wait unit clear */
+	ret = readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
+				 !(reg & l_mask), 0, POLL_TOUT);
+	WARN_ON(ret);
+
+	/* Disable the module */
+	f->write(FSPI_MCR0_MDIS_MASK, base + FSPI_MCR0);
+
+	/* Reset the DLL register to default value */
+	f->write(FSPI_DLLACR_OVRDEN_MASK, base + FSPI_DLLACR);
+	f->write(FSPI_DLLBCR_OVRDEN_MASK, base + FSPI_DLLBCR);
+
+	/* enable module */
+	f->write(FSPI_MCR0_AHB_TIMEOUT_MASK | FSPI_MCR0_IP_TIMEOUT_MASK,
+		 base + FSPI_MCR0);
+
+	/*
+	 * Disable same device enable bit and configure all slave devices
+	 * independently.
+	 */
+	reg = f->read(f->iobase + FSPI_MCR2);
+	reg = reg & ~(FSPI_MCR2_SAMEDEVICEEN_MASK);
+	f->write(reg, base + FSPI_MCR2);
+
+	/* AHB configuration for access buffer 0~7. */
+	for (i = 0; i < 7; i++)
+		f->write(0, base + FSPI_AHBRX_BUF0CR0 + 4 * i);
+
+	/*
+	 * Set ADATSZ with the maximum AHB buffer size to improve the read
+	 * performance.
+	 */
+	f->write((f->devtype_data->ahb_buf_size / 8 |
+		  FSPI_AHBRXBUF0CR7_PREF_MASK), base + FSPI_AHBRX_BUF7CR0);
+
+	/* prefetch and no start address alignment limitation */
+	f->write(FSPI_AHBCR_PREF_EN_MASK | FSPI_AHBCR_RDADDROPT_MASK,
+		 base + FSPI_AHBCR);
+
+	/* AHB Read - Set lut sequence ID for all CS. */
+	f->write(SEQID_LUT, base + FSPI_FLSHA1CR2);
+	f->write(SEQID_LUT, base + FSPI_FLSHA2CR2);
+	f->write(SEQID_LUT, base + FSPI_FLSHB1CR2);
+	f->write(SEQID_LUT, base + FSPI_FLSHB2CR2);
+
+	f->selected = -1;
+
+	/* enable the interrupt */
+	f->write(FSPI_INTEN_IPCMDDONE_MASK, base + FSPI_INTEN);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
+	.adjust_op_size = nxp_fspi_adjust_op_size,
+	.supports_op = nxp_fspi_supports_op,
+	.exec_op = nxp_fspi_exec_op,
+};
+
+static int nxp_fspi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	struct nxp_fspi *f;
+	int ret;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*f));
+	if (!ctlr)
+		return -ENOMEM;
+
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
+			  SPI_TX_DUAL | SPI_TX_QUAD;
+
+	f = spi_controller_get_devdata(ctlr);
+	f->dev = dev;
+	f->devtype_data = of_device_get_match_data(dev);
+	if (!f->devtype_data) {
+		ret = -ENODEV;
+		goto err_put_ctrl;
+	}
+
+	platform_set_drvdata(pdev, f);
+
+	/* find the resources - configuration register address space */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
+	f->iobase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(f->iobase)) {
+		ret = PTR_ERR(f->iobase);
+		goto err_put_ctrl;
+	}
+
+	/* find the resources - controller memory mapped space */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
+	f->ahb_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(f->ahb_addr)) {
+		ret = PTR_ERR(f->ahb_addr);
+		goto err_put_ctrl;
+	}
+
+	/* assign memory mapped starting address and mapped size. */
+	f->memmap_phy = res->start;
+	f->memmap_phy_size = resource_size(res);
+
+	/* find the clocks */
+	f->clk_en = devm_clk_get(dev, "fspi_en");
+	if (IS_ERR(f->clk_en)) {
+		ret = PTR_ERR(f->clk_en);
+		goto err_put_ctrl;
+	}
+
+	f->clk = devm_clk_get(dev, "fspi");
+	if (IS_ERR(f->clk)) {
+		ret = PTR_ERR(f->clk);
+		goto err_put_ctrl;
+	}
+
+	/*
+	 * R/W functions for big- or little-endian registers:
+	 * The FSPI controller's endianness is independent of
+	 * the CPU core's endianness. So far, although the CPU
+	 * core is little-endian the FSPI controller can use
+	 * big-endian or little-endian.
+	 */
+	if (f->devtype_data->little_endian) {
+		f->write = fspi_writel;
+		f->read = fspi_readl;
+	} else {
+		f->write = fspi_writel_be;
+		f->read = fspi_readl_be;
+	}
+
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret) {
+		dev_err(dev, "can not enable the clock\n");
+		goto err_put_ctrl;
+	}
+
+	/* find the irq */
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to get the irq: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret = devm_request_irq(dev, ret,
+			nxp_fspi_irq_handler, 0, pdev->name, f);
+	if (ret) {
+		dev_err(dev, "failed to request irq: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	mutex_init(&f->lock);
+
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
+	ctlr->mem_ops = &nxp_fspi_mem_ops;
+
+	nxp_fspi_default_setup(f);
+
+	ctlr->dev.of_node = np;
+
+	ret = spi_register_controller(ctlr);
+	if (ret)
+		goto err_destroy_mutex;
+
+	return 0;
+
+err_destroy_mutex:
+	mutex_destroy(&f->lock);
+
+err_disable_clk:
+	nxp_fspi_clk_disable_unprep(f);
+
+err_put_ctrl:
+	spi_controller_put(ctlr);
+
+	dev_err(dev, "NXP FSPI probe failed\n");
+	return ret;
+}
+
+static int nxp_fspi_remove(struct platform_device *pdev)
+{
+	struct nxp_fspi *f = platform_get_drvdata(pdev);
+
+	/* disable the hardware */
+	f->write(FSPI_MCR0_MDIS_MASK, f->iobase + FSPI_MCR0);
+
+	nxp_fspi_clk_disable_unprep(f);
+
+	mutex_destroy(&f->lock);
+
+	return 0;
+}
+
+static int nxp_fspi_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int nxp_fspi_resume(struct device *dev)
+{
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+
+	nxp_fspi_default_setup(f);
+
+	return 0;
+}
+
+static const struct of_device_id nxp_fspi_dt_ids[] = {
+	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
+
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	.suspend	= nxp_fspi_suspend,
+	.resume		= nxp_fspi_resume,
+};
+
+static struct platform_driver nxp_fspi_driver = {
+	.driver = {
+		.name	= "nxp-fspi",
+		.of_match_table = nxp_fspi_dt_ids,
+		.pm =   &nxp_fspi_pm_ops,
+	},
+	.probe          = nxp_fspi_probe,
+	.remove		= nxp_fspi_remove,
+};
+module_platform_driver(nxp_fspi_driver);
+
+MODULE_DESCRIPTION("NXP FSPI Controller Driver");
+MODULE_AUTHOR("NXP Semiconductor");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

