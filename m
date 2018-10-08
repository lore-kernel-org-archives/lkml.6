Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F1C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78F12085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w2mJgagr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78F12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJHSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:18 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:16928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbeJHSZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbqsk+g25BW0o+SHJcmj12GuV+okUit+5Er/IlMd5d0=;
 b=w2mJgagrauki66MzP21zNpZt+CQLYXLqtrjqQVPFvl4ZeJ7v5tnY+VnPYiiyH2+yP2QkVoCq0KdWc1aS4YmCU4se/V9tDkDMcOKkyBpIP7OkXtMb1Ps/E1O9ZHN5Se9iWidqMb9L/kAwD35fSOlQpx1oDg2zzKIT01E/sAR8nrQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 11:13:38 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date:   Mon,  8 Oct 2018 16:41:38 +0530
Message-Id: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe12df4c-868f-4c5a-bbba-08d62d0f1bac
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:INZ2CTxBEQw0rP9WBUZICPLGuVJyZ4OYQRcprmemSOIz80afaPqofWxINbJ/OlC3mGyPT0ku24eHQZm1uMtdQ778v9gsUY7Sc1ztvPIXx3Uy3/Inhf7vJ+EDK3TeCeS6KQKfiXlTINTJmfm1W4SuV4jaHEdzxe9TFB9OMZR1pvilHhMhY58MXgKTv+aXKO26AClPTiuhLGwUuLKx4peSYG962ruK35YrVE1s8LDOm1o8HMUvTMJHTxtXVzeeS7x5;25:UzCl5uAYEMd45WIzEuHyjh/p5Qs2UtB1LX7REQ41mxjH8swi3FsXeh8E6ZaD9EL9TpLHAyJ6+p4T9Q350PdsFlBu/BIDmdIO0ylp3NOtzUqbA75hGJ5MVW0PdVyERA6w2suadjAEU5d8kejJP1AiylmKNeSNtMjvo6sJggwfu2G6jCiQiKvZV2lm1PGJcHs8F4NHY3LQccr6EOIBlnS3qnZaxPzI6frUcxiQAwmowLxtSqVA/T5oUcw5QO/Uw5BezyTty0P4mUu4U/Dh3KR/4tkhV7ClyLaCPCnWMDcfQ3Hr7klsafUD/C/wyuguvk7AMYcYDPK+D+TPmbOPJgebytEYqZR0rr/Q0tuWYSGuN7s=;31:8Vr/+A38kilG2GUN6Q7jpZvhc130GXVQ82JGt2aOJyu0wf8kUkkg3LozU8kkP424qzwQS/xAIxkAZ7Aj9B260F+kdNtRkWKribqFPFxVQDck4QPqYCe3qLXxERp2K/2AikITd//ooI2PBA5WScxpnB0++EPaiknyNU/0a2FWFcSN+sbanF8PN9U1M/I77zoPG4dQOml5KIcnOMVa7NosuTwOS4DpVEk1X5aTDmBM/XQ=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:QhJCR/OzBhCX8DgEKRzBH0Nhclt2S3B00Q2/feFP999M+Ixjuru55IsQraWRl2/zsisTkJrXNOw1EpvxDOHr0TokMMEYYnX68oGSf4mmPpP3eP2vkYhJNjGWm1bHwGRywwuYxRxg5h02nmNmzDXCrwa6wJqSTur1NeNPSDyNXA92QUltNpI8LRn7R64aPnyk+7qXRyvkbBbU3RkLYSd4OMj1rAMHx9ZLFHxyCuRoc4afpuHSE6wju+QXHVNVGHgnEmqnIEup67EBS/15uuQvxbHZFWRiyZh9a0OvxwOnQuR5XVuESlYPb0ohbO9KDd089zgy5BHTQNIbq19Kfwd863vHqmMqZkzMJTLIjcOXXgDiVuKv9SMo5DQQrpuy3NVqtDWsCyt3iViOcMP1ZrhrMdTRS6ynt82ImCpZrdXf8xeNTq1EwQF1BgJAkXHrVR6IOStuayGbDxkj9I/BK8RdGGD7BMmdWZUnBDpeY4O8rRYG9oOHxjE4i0itxMBCvg+X;4:Mitx0yTTAldSrBIchoMJoL55JC7XO8ylcop9pvXshjSuhRO89KmKkrzR1n4aFASP/+0cKy+CJNZpQMknvZz774sgC0yIQAZkJM5MWDxJuecQ88GLkwTIkO6gkluP1U19rE5vZiCnMqDw1WPGi2urSz7F7eHMEh6VwZPZ/W4Xtmm5t5fPiOqMi+68w00eokq8cLl1mPLy+iMhiXa6sa/SfVAXpInVCMp9y0b6ciZwQ79TZ9SQZb33+HdEjE8eL9M2uCgAkuNETUrHBhZPm6Zj9ohyE+NsMiOzusr0De7dQA1NIW6eW9QquSWQSSiLNbpOj6aGGGxQNyf0W/JOH7v+DIkHqZweaKOJ6wo7hmhLwKU=
X-Microsoft-Antispam-PRVS: <HE1PR04MB103453A2656E6E2697F4378099E60@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(264314650089876)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(16586007)(105586002)(6506007)(55236004)(48376002)(316002)(50466002)(16526019)(6486002)(186003)(53936002)(6512007)(6306002)(68736007)(26005)(106356001)(4326008)(52116002)(5660300001)(39060400002)(386003)(5009440100003)(51416003)(97736004)(47776003)(7416002)(478600001)(2616005)(966005)(956004)(66066001)(25786009)(6116002)(36756003)(476003)(486006)(86362001)(8676002)(305945005)(81156014)(81166006)(3846002)(8936002)(50226002)(7736002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:fxtCW1xnCSeG1B6ErduY9RsrChg78K27zq0XorM+Q?=
 =?us-ascii?Q?lwJU89sVDMt+r1Saa4At30tNMFfMqITmeMvpRnqJi5591hXJsRoBSMDkA6Fm?=
 =?us-ascii?Q?LmWJbIgJJU2N6e1gGlcLXdnpfPn3IdFm5p5rWMfOHaUeIWrXv3IwlpuCWtn0?=
 =?us-ascii?Q?k79GtwQ7UmJtDdob0r8EBgkloddqN1zelyjxonABDDpDLanNYkt6OqKLaADA?=
 =?us-ascii?Q?7ZXjz2solzzRCdEPd+NmMOcofnbEIxMsaEJdIGoi1gTFqT3RSv2V8K2L7svy?=
 =?us-ascii?Q?Go5bW0a1gakjVrEypDo2zGg7OwcHub5aK1fsSBljAri5Ehafh+1GPZjLq5UB?=
 =?us-ascii?Q?EW7+WwaEI/Wg5xfCPq1GySZqqAyYj+Nw2yL0xWbM06JJfyWjevrK+BRdoF+d?=
 =?us-ascii?Q?zabYwTTOGumBloi75iM2ZDNdkfRO5OiVYrLLktJ8FK8j4zsixZa27L1TVWgv?=
 =?us-ascii?Q?A37/6KYHRx9H/Bf4hG0PaIfsLEXXJg6ezVXUPgJtjKKDyZaIg6QbsxAr2qfn?=
 =?us-ascii?Q?RSU6VKx+s/+peMljnIwXLtrUg2Ae3Ye6NngNitkPK9jGor6VL6DRh0/M2jtA?=
 =?us-ascii?Q?Zlev+LWJ5pRJbc6DNXWhnWBN6a61YP/eDXhbaq+XCLbmxUoupdFHzHrPiafg?=
 =?us-ascii?Q?h/Vm7iQNjZyQc7M8SzHPSnhFkAjkwLHavlfarCQhDwD8GCWhqdyUg9nNSL4P?=
 =?us-ascii?Q?XtRPVPDoAqYkcecsWt3JODcHMloOPXCKKjtk3tPcJIRofVTtyHKHRo2Red6P?=
 =?us-ascii?Q?/VlIboG3wXqA9ne6f6DfPmJSEHUYBF8ZuB/CkRfBZB11Szl8PONRTd6Ym8z5?=
 =?us-ascii?Q?Z4v99MUPbhoKM9fZnmybKPyF5IqvyfWoxcO8s2MMzmv6QYpdVaCzdRU5R/3A?=
 =?us-ascii?Q?LdG58R/mT3gzFzHkNDH32BRFb6+PrXWjJK1XBLMRLZT0JJhe7UBMavZH2DFI?=
 =?us-ascii?Q?MPlA1MEQaKViXCjTvIfBmCZNoi6Gq84dA7DVzkkyPofuLKq94ppyg7Rusym3?=
 =?us-ascii?Q?EKxzOJBKlKvKA7BzrVcmAc+HLbznEz8JEPSDTbdUgFStMgdpV1nlJdWMuhBa?=
 =?us-ascii?Q?Vx69FY2IcgCp3+WMxRCb1xAvOKNEG1EmFRWHK1zkWDuX9ByxXzIcoG3350z3?=
 =?us-ascii?Q?/wxubpkgemK3xkQCAeWdDTE60sKWwk02tRBogufK87KxxRPN+mIfUJA2cN7f?=
 =?us-ascii?Q?NuOtoRFJTxjEnJ0yQ0EGtn6WN8bmLETJbflMcob6F7QSORmb90j7GfPmQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 7e1qiEqSWijBGnYLXMiUqOFljd9Ka4bPYY+C3kVtsIM2pV9cN90HdVMmEXL2FJR5UPRpvV4Q8akNKu5eQLq4wG6AxFbCMVSMrK8nszkH0QiuDLeybDXzYY3VxBNSpsmAaad6FfnUHOncqyC/REncCWC5RAx5N6FcitKmxoT2hO+QIpAlC8WKUbcrbbhj2VYD8sWWvaDl2nYbXvkduffpyqJDjLKJ6XReigl2C9u0vu01zvEcjt7joqdWc5V6qzb8mV71mwPOWodNyrspSVz5JTWcoeJbXJoa6dgIdcuBPpjSUiMyIm+A11NXrKdOWNVxLSJRblIH+bsPo/1LXLtB3Khvv9RT3YdSZ2oZvRZeThY=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:YrkfcNSiob+Zd/xk9HhIa+yeUe2KckQ5dDbUNWwwxkMoBcSZmaicQFuvT+flsVK3jcB7Hc8EiWuP9sldj7ilMJ4zYCNOK1itUVH/uU+NRNmYgPXGTrEYaV/q1aqrK7CoM2vU6qQxAvvo3oNEiTg9533bu6rM5HOMmyqV20S4tIoGsAWX47b7TkwIIPAwcdeHd8Q52WNhZC7f9I3ApHrXeagXRqWRVEPXpYUebV5EWtCGX9klIq16GVlLIE39xk5DJx/LI0bfaxwq2ahEW5RcA+4+0dM4Em4ficPeU+LGfx0lvNx+mzeVMQ0Tg7s5fnlnxuJqcgeK2Nk3r9Uicb4M22dxMqnbieFs8/xeSBDutYjdTuVK+goZy2iF5sOaMdjh1ZXPamTzZCPDjEIpptJ0KacETV8Tv3IzY2Iob0q+2JE8Z7Cc//ALyDQlRiXt+Op5XyMXbATSypDTuoZ4Jv7Nbg==;5:fsqTqrznDVjsAvyLOYCpr2yiHvr5UFqmS0EkHezH2PENPBduvmgiStUEI790gZlv7FGmyafQao2Azz3iw/cc6W1lu7x0gtXCblVfRzJIPnGipSwc52WT5UA+cNt4GC/RYcuNoYuhyRsxMA6W6x4Gr4zMihfpyo3XozM3DSihv6c=;7:iDiyYe2nnF4bKvWjIBYEH0+fWuQwNm1/yXg91lpBV5dxGO5utRv/m0BE52JS6rxVmk2fLTrOvLEq6VnwBehWknAkgeRJC8dR7suWxL2wnkBKN9y+P3tEHSP6MoDq9H5LsdxOCvXIWkOaBUuv1kXsivDht6i3hhuAL/cnuzsf2aoeIgoaymW+gFDBh3gdkt0LLWRkm76QQtm9kJUman4C3zeAQfd0YBYHGf4v18+MTAKUB8R2AjcOQrDRgE3cr1Xe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 11:13:38.7037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe12df4c-868f-4c5a-bbba-08d62d0f1bac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add driver for NXP FlexSPI host controller

 FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
 which supports two SPI channels and up to 4 external devices.
 Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional data lines)
 i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up to 8
 bidirectional data lines.

- Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
 filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS targets.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
   Micron, mt35xu512aba[3], [Read - 1 bit mode]
   Cypress, s25fl512s, [Read - 1/2/4 bit mode]

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=9721
[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=63445

Yogesh Gaur (5):
  spi: spi-mem: Add driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI controller
  arm64: dts: lx2160a: add FlexSPI node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

Changes for v4:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
- Incorporated binding file review comments of Rob Herring.
Changes for v3:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
Changes for v2:
- Incorporated Boris review comments and drop below patches as per the comments.
 - Patch 'spi: add slave device size in spi_device struct'
 - Patch 'spi: add flags for octal I/O data transfer'
- Incorporated DTS and Binding file review comments of Shawn Guo and Rob Herring.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-fspi.c                         | 1157 ++++++++++++++++++++
 8 files changed, 1248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

-- 
2.7.4

