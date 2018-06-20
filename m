Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9950C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8508E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ijxV3m5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8508E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754197AbeFTMYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:24:22 -0400
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:59456
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752827AbeFTMYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TELovyBHFxpr3gLGGFOI6aew95YAhdlBoLmjsqYdeuI=;
 b=ijxV3m5cYpKy49y4d116d4GpHowNeKh0JgQSNBfrjMNxky75wmWmG0txGfAthHcpgDanC5aqnJuTp6S6fwoKHiZfo4r3F+dyNgUCiQvZLedYtrLDVHQ9ru5zAP6o/ZMIT65/Vv+RVs2aM2SH56kA/D3tqMmz5VXCn45TsZ4ZiL0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 12:24:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 0/2] pinctrl: imx: Add driver for i.MX8MQ
Date:   Wed, 20 Jun 2018 15:23:47 +0300
Message-Id: <1529497429-8576-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM0PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:208:55::43) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1344e82e-533e-4cf6-5a87-08d5d6a8bc36
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:BVCf3IpyE27A8P2lJjl4bxpIAKCRGm1rxt5VcYF9eKVAnAbYvDO3AkEYRgN4iGAqgkJFU6hpN+fAILfURjqbGthknk0SwVz9AABQ2GAJjYCHI9fY+42KC23nm0aBrIp77Y87WTBsRiVMIiZmCuATPUUI1kFg/EwbIUgp7kVdFClyWtW012z7dNIYY0lSlXgNiE8uIGy8gl7I5941el6ZLnVoZp2BBuv60rcc6DlyylpCcDxVdxiUh0E/xTlA+GvR;25:BaeW1EbaZEHEiUv65NZrQ/sebjUVJO4mLtS/sMGmdcskzAt8F4Obd8bIc2l8GzbcmEGMRJHIFI9mtDCaexGiUKDGkL0rl+JjtqIcd/d5o0HAm0AL5NPYGQoRRExozqJck1lqjfr2OHDWOg+qZBx+/0O9t5N0S15PcarT73sxikRvTXlA4Xajx7RQwq5+FNHNVV5DVC+mMl6RkbxmukgTkbLahNPtQ1Y8WMvuF2KSDJ3AsYI1kxSM7Rm/tfYuGErMD2i0aM6Z/y1UFNCj3uEbyE4HS8vI7ZuOheupUUkf//noOuVAowvorRxEDhAFfhTIQXq0l8m2Sj59d2zSFI6s4g==;31:rzeRcyzXnKkN6/Lvvun4mwU6Q2jvhwq+iO5rKJ/VyQUK2iA3Qb2hk0sXTPRyBpagVF8ruQMSoE8meN0qb8pT2tsbXXgmSJN2K4DgZkYDdE5BBBgZ3KHDNlBh5sSOWhUBkYMIZekxkx9mvlUvJdkOHOfoR02MdICi03vvoA4GCOioXOawolvoTYfOFJ+qJXSYWfXF2q+oO6xm6x5rkSAPcuhEM582vFG/gS84Nzam1O0=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:Dnhcjx/nGNw4Kj7kdcpHQUmyopLyfPEaKdg3UMr+Ckhi/o/8aS42xtNacPXyYtGLkdlgWQ8tXT35FHx0KBsGropkM+kYJP/g+gM4kjBe11aG3fCuqB3nQOeH0mj9gIUbCKb+lpd6r/5RvnZ0vYC/8YAVQzJhaA/BS6X8PYjZiE+5nnaKKHOKxH6SfiHlJQlGKm7+JXWcRUKF8npFYNM1vhjrImcswnINi55bSDcVUyUmoSppuk8GMpa9xtYZ0u94ksW/kfxRBPxRjGC5BcazBhh7O+4swmI8oGN63TqbKrK0+U04K/Wa0a8yRkeJmUI4z2atkpr+cDeLSDWaOD55PH06a+nj3eTA7UPGLXnoAgfzZjoqwYX0Vco0usAHqXefXRqG7CQrr+pFNGEgy8TvU+Q1VCadKO4YrxX+FNiWtbV7Sot+uAPII5hRM1xHYdTTUuhoM72sZuhi/kR2gPQ+1rlJV5R68/erPIdDmvgkXFg81511Jr7PCyyTyMknU3ba;4:c/wSlkGvkDNPQ0qvhrL3Zb2eaPTh+tKnMhjQJnhM9MWcJSypT8klFVu6DeO+lZw0E4aKjbxWVmhK1fgY3TLOb4z0BRx1oa63wavm4b/GGwDNZ4GBM6ed38fx1hM+wFRC3GEI2hMm5VKfxgeHWUpBVULU4OFDV2qsdrZAelGUCXabW0yxn+Udh57UlxdnZhxJRXhOzPJn1pXkaIyukQVHQzSby6mS35BAif5ufOg3RDYxCE7lfIsfZoSI6VAt2Ku27NhQAx3OKI7584MiaFYZAh3y2a6RLNQVW73wRDFk5easOG03HzZQHWZpE6yhQeau
X-Microsoft-Antispam-PRVS: <AM4PR04MB16011F5B74686BCABA44808FF6770@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(39380400002)(366004)(189003)(199004)(486006)(68736007)(106356001)(4326008)(5660300001)(956004)(105586002)(50466002)(44832011)(6486002)(6636002)(48376002)(2616005)(36756003)(476003)(47776003)(66066001)(478600001)(6666003)(966005)(7736002)(2906002)(6306002)(86362001)(8676002)(81166006)(81156014)(316002)(50226002)(3846002)(97736004)(6512007)(54906003)(7416002)(8936002)(305945005)(52116002)(53936002)(6116002)(186003)(51416003)(386003)(16586007)(110136005)(6506007)(16526019)(26005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:8IvtmW2PmGCJs+LWHauMcI4K4uwWnNf/ofdKj87Ff?=
 =?us-ascii?Q?hax9qd38EjifRpQGGnOFtg2X3FGwD6Dwjm828Xrv/sxsz+GRTDXzpDIJycXO?=
 =?us-ascii?Q?pFWVFhsNS4FfF9rVP9MW+ozWL+/QN16MS8KlDnA0u0Qyo1ari4kXKXoCffTA?=
 =?us-ascii?Q?wsKNyak92VfdMAlfXIkvVMoWwGko/dm4zQo0LH7W+H5v7oGzTY45JkOy+LJP?=
 =?us-ascii?Q?alcQ48rQmJ92C88EzY3u3oMD+rmQsqejZ0WFFyJO6duVNIKFfap8VnHkNIig?=
 =?us-ascii?Q?PxusxMr2k8d8kgkE1B17oEBZc5VlHHlJ8rhYti7abFqescGWre01pGza/Yf9?=
 =?us-ascii?Q?C1DI55u/innK1KNexpcGOdna5aCr8HjitB1fD6fS7c4mcTxqC5WMeiiyzxHu?=
 =?us-ascii?Q?ja6NMgnCBtYCLtq+CwvYfmWS8AvwVVRB0+J6l3tL8ENwcEkdC4IznCesPW6f?=
 =?us-ascii?Q?dSUBu8CVHcm/X2b36vta+E0IFboFlXH8sbC70wYtfpvqhuyTteVjjllp2X0o?=
 =?us-ascii?Q?bd475sgyQqjnWgkQ/rWcgR4XqWJuY3mLK4472TsXgYIbGuevV+Sx0Fcw5L47?=
 =?us-ascii?Q?3b9RX3kGtqaC9Mg4xxvO1i9ddNNRfEHIR15osyDuVKoJMYehss7ygBvMKt5f?=
 =?us-ascii?Q?df7lUH5T0egEY8HbF65cY5ScQOTbvl0AHqfnEqRYgwOwhr85UDV6wDaqCvDv?=
 =?us-ascii?Q?xNsYI6Mr473Jhv3ZbliA1gbfIsbCJnxyLM5ko010kw9vtVU7Y8GdQGGRcvzi?=
 =?us-ascii?Q?NMTX4xTYw8G5yZL6Y2hNuAJ9VbEX8N2h6bU+vBx0EBODRvqZ0v5pVJg3R79d?=
 =?us-ascii?Q?FHqMH0sQWkFLx5wnAZ5etA3dB0bnzAZbuAdAgGtVLeeAADsG0oz/onx9pgb2?=
 =?us-ascii?Q?AffzC1sNznMKyjqMZwMycsQID1pUpXD0NBxsrRrdYaXUuSHTw6QXTh5uD+e3?=
 =?us-ascii?Q?Ar+9WqHL/MEAWS9zzGkCj3Tsi0FJRIy8IIFAbYcY+IwDP4MYzB59aEaNk/Ph?=
 =?us-ascii?Q?QJafTOKik/ZE0dldzqv8bBsorCzA6IxSfWsghslzusAATvV7zUoWWCx8KXpj?=
 =?us-ascii?Q?x13Kbdx7mdWQtIorCGhlMxljt5WkBkWAQiXN+c4tpYw14DQFjZVgBxTB3kY2?=
 =?us-ascii?Q?CMEswSdFNdWe22y4mbmQDLaVrwYsJeaXYK49t3WpcyQyatVQaQgDkQjFTNtL?=
 =?us-ascii?Q?X6OLyeQqvqRjDPjzl1PcB6uGWoIVrJkYIqW5xQFf2YUAp2/VY/9dudgS0Yc6?=
 =?us-ascii?Q?fGMaaiqDpON7IndlLg=3D?=
X-Microsoft-Antispam-Message-Info: gDIFQt8U7qmZ5W7EAsTpdQJhDmQNkDzI6P0bw0o/MRa7NNYzfTqiWwz9JFm+V9/RZv2mU9XuVgFfNqvl/WLqCrid7b5ko+VZhnu0ucW1ovDolyc6ocz211GnY8nLM1tx2wVAfi36TbiHYm/+pVygFsvq/hxlXKtLsErca3K/HrelMZgG5oFmal3KNl+KTAitaOgxY3tKoe0ldH6kSqH5qApLJx+HF5Z6naLHyfE49awv/kV0xTrVpI9zd4r1WJ0FrOlFT5YNhJAjQKFZm5UeNMKgUcaEJ0LLZKsz3/YJIt3iF1OGFlgoQO9PthSvijDy
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:QS0yW5D6vC/1pvj5G3PTkEz/wmVY7loZtWiXveBLKp9tBmBLkGt4l2swfngVblt8sR4kADDGhGLmMZ2qco42vitckmQA3cL/gH4L7FkQA+Ba91oWirmi/OFTDk+47XOq++y1d1VoKYlGZBc1N8nmKyI58vxp1kwP82oMAEnqKCYCFpmK++hWzgJrm5CcbpJ98qABjdrMkpTmjzEAM+A50kKerdzEVX3E7im5MhJdA6zJw+H5NQ91f+B2jPcQEP0b5aZyXtZy6USZDK68iKcrVjBSZH2wrBNtgvQbWPu+6x4JNlCo7BedpLsvvWaHphxuf3yQCWWQFTwlTHBeSCrYd5nU/Nh8u+1yuNv7s2zYL1+mM4yXMEn4mTHoDdra34G4kFY4Jblobvd1CUKidU6Uy+RsACnOsyDEkaXo0+F9MtOupP43uWC17FZPlV+wiNYtRtqcMWOSrbhc6Ew9qWsqpw==;5:Ge5YzDlQYPYNAClae8rrE8DmbKc8BEg5DUja1Al17seDyc2QnVNMMwhMGZGXw5IZue59n5T/iDtIpUcxWbqLZ3sDmoxfoHwiSIR+Y9/qJibrt6k1buGBH8C66TWS9NtjQD8Yb5Levrh6y+hse5cGXgs+Iuq+1j3RayTpyJb7LYE=;24:I2QyJ6CqLIlh5htAq93eHnD9P/fZLm5Xr2IPI+6TXCmik12oxgn631QWTR2e2SdVEJePyMI+v6jZEbgdAEVlb1iNSE2OGl5MkeBxO4WDm2o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;7:3rjtQchHJn8lkI1paJQMb3z3jr+MO3mgx2vPoBWeWmiZx7S3aWS0pyNgH+yRWofpLp2B3a6gVNCw6Gxw4bo9YMBJAVuTXx0fq7qAnPv6DfUfyup5bvmI8dc3uRBcARgk68LnbIEQO8rfGreLsztZYmvkXhuDMSk5QRcChn/80k1KOVKMRJltOtq/FP5LTXyHpvWwaagt4fQEz3mzyJ2KwYZd99Gx0O83XYvIQT17vajb3BKfvyZWv4o2hMi5PyPG
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 12:24:13.7006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1344e82e-533e-4cf6-5a87-08d5d6a8bc36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth version for the patch series sent by Lucas.

https://www.spinics.net/lists/devicetree/msg212752.html

Third version can be found here:

https://lkml.org/lkml/2018/6/20/343

Changes since v3:
 * dropped the SION generic pinconf changes
 * added examples to the bindings doc

Changes since v2:
 * switch back to the 'fsl,pins' and hardcoded the config values
inside the dts.
 * updated documentation accordingly

Abel Vesa (1):
  dt-bindings: add binding for i.MX8MQ IOMUXC

Lucas Stach (1):
  pinctrl: imx: add driver for i.MX8MQ

 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        |  29 ++
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx8mq.c         | 356 +++++++++++++++++++++
 4 files changed, 393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mq.c

-- 
2.7.4

