Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5DA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rw7CwTOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5DA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754445AbeFTJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:42:49 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:37599
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753774AbeFTI3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXw+Xw7NAieSR/MqKMKQJhOmvV9MNrBgy7mgNp56SjI=;
 b=rw7CwTOwnVt0fSQ32QPabLVPG0mJ+fP0v+COxMFW8+tFsTDaq0FJFoA5WoNAP22yoCcqy1fWEH/SEwBamA7daiX25Jjv7o/B+HHWDUQYHk7GqGKbexA78D5XvzWkSENenFfsyRPHzN6yQU0CfZqofsA/UG7ypawzaSFL3M3+dPk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1610.eurprd04.prod.outlook.com (2a01:111:e400:59a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 07:24:42 +0000
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
Subject: [PATCH v3 0/3] pinctrl: imx: Add driver for i.MX8MQ
Date:   Wed, 20 Jun 2018 10:24:20 +0300
Message-Id: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com
 (2603:10a6:203:51::11) To HE1PR04MB1610.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0042ac46-2748-47a7-2ad7-08d5d67ee4bb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1610;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;3:ZO9onfhpvHQmOa7z5QZy529SDvApTbqnexvS6cxTo2R92AD6FYeVFO0q9/ql7YqXQUrGKEQ8Q7vYFempcSjY+sD4Cso9FOpiZGJKVDBNloOipO+MJ+cbh5kGCI6waSYwGAux9iU0Tv9oPCrFps9QT+IZsRUzv9unzNEpo7YOeVYwhDOZfnNs1/rnEHqIxpAjkz6saD7bTLXffxN3i5NukMnnPIAYsfPvy9aC0m1TgGzJ7RDoXsoVXxb/TlheH8Ej;25:mbS+aSJxsQ23PFk58AAru8i3we8pqLSoNbKyKZ0vm1yBKW3DrBrVWFU/JrDLnd0tepL8uOkKHEvn94t9as6+d/ogtTSEjuUUGsNzCa/bEv9djwHsE/T0pVtLV0KXdYEFtCRmXKuL14WVyXhNpSRXpBg3JZTa/6c7gr4Uk0FUQHf5IoWPjO1MoH8CGLJxR7gDiUxJjwkifLjn+EgVybiPTskyAWFs9tEFF2FxEoiRKq9CBmBjB1PWNMWAEZ6S4draGW0uhHkli4jM4+1juKw3x7dIQa2hL2EuyJ3c68OWJRtvnPR2RqD3x51MCH0JAmVhiFilpGqyxtjk2+0JecyXJQ==;31:3IF4+E16i5CEAXTz7lvvq4fb11RZDQs5iOvNZzOTSoEwV5wv0nWuJ5AaaA9sXPJ2UjNSPX1vuhobu3wdboAYOst8WyiSmVD8lF5pH4L82LuSMZOPXHXWLMKVB6WHSvW6ZuJHBYHbbk4Ja+OwQMdk4Gmm7H75w0Q5Wo7Mf59L6hq0G+IqI5r8EozIM3EDUgfGNtXt2aqxbP+OS4jSDBvzxawLT1N7inNi2ALNGLuLdyw=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1610:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;20:tNKorxGJGYl52tD4Xz29Q5YymXzTg4SUdIqvf6xu18Q6skHmmgd7rHFYPdD8jvO+Q3AkUjJJBTWHlbthD024J+c28z2G0+NFpFT/70slSIFv+nHkCwsgO4D/qQqlXmVlhAQ5yW/QtPxfsProddw63N+vhMjcDWyMh3YyGjIMIcKpWPTnobsuNCNBauQV1dDiOQwilFfeD1xaYd0SREtM6XZhNa1AteDjUiileG7PcQLxgv8Ytu+I2wC6XSJWiAsnpc+soiFyIXqyGrgKfgkWQ0eW//A+H6muGmeBk1jarqB3JlfrulRn0YQ+k1Fe9DV8zvbVhV6U7ZJcTMhjqx8z+aCqjlbZe+N3Scm552B/ehX+SEaX0NLNOz/fLxTQUI60TK+yTdfRQFXTgyjZOlPF76bmJDNh9xqcEQ6k7EJz+J1vEAAQ321mB0oX8wEP3SAaXnBfTUuB8No+Dg9XYUDCVemiSDhhgL5HWAMSwH8z85PBAOQvIgDUnTxs0W3S8Cqm;4:en1DeR5do9bFgNTzLamCooFWmwFw1w7neELdMVY+jxfcKOY6W9aur4pTkXZvEeuXSiLMsWBfDE8uvJwqhyjssrm3MbvpJkNarf70FqSv1/TFWneVdTpsNmgJFwKnBy4xMXRlAVZmAboUPa63SwB0zCyGYSON7icJV/51gg+aJIyYITALuN9Lldk7UNTO5RTAqdfIZ9F6rYTDlyzrh9lK2oBSgvgZqoxovuMmFy38nSxFe21ly9VIzaPo2HgJ2l67WnGidbRyVIAPLVMGmnZcq7SBIE2Sf21mwdfP6Sk/vgtR8dLJJQ9dmdrP9vd7e5/O
X-Microsoft-Antispam-PRVS: <HE1PR04MB161099A1495A7E8AF02305D2F6770@HE1PR04MB1610.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1610;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1610;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(39380400002)(189003)(199004)(47776003)(66066001)(54906003)(16586007)(81166006)(966005)(3846002)(6116002)(110136005)(6486002)(8676002)(81156014)(50466002)(51416003)(48376002)(476003)(305945005)(2616005)(44832011)(956004)(7736002)(52116002)(5660300001)(486006)(7416002)(97736004)(6512007)(6666003)(6636002)(50226002)(186003)(16526019)(316002)(8936002)(6306002)(2906002)(53936002)(36756003)(478600001)(26005)(105586002)(25786009)(106356001)(86362001)(386003)(4326008)(68736007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1610;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1610;23:vQqvSCTK4wghGr4RlJpGcYXioat4OZfX8ZhdUzjWM?=
 =?us-ascii?Q?M32Pc/1XzbRLIcyYGureqHe6uFs0PRevR8/qQAdq/7mYqjtYgRNhiDkWmqB8?=
 =?us-ascii?Q?Nleh6FsXIZlYzTx14Rm0QeLAvUn+1/sHxOLjHCMGH0OzvfseQluN7mXC2u2N?=
 =?us-ascii?Q?3Ibb1Rj6ojVnyFjj+KlSM6uI4ApVYHm2jHi7ohaagtENZwOS87g+6nYIMTSS?=
 =?us-ascii?Q?mDGBkqD2bizzAD/KhasoZronhnfzAIQUR4C2qu/1GRkOfNQSdW3KEQQe4LPX?=
 =?us-ascii?Q?OsUgUmxPvd0ZDVTmfO2tCdbt5Muvx2XrLhFoyWuG/29IABZpLYrsqHLfO+VA?=
 =?us-ascii?Q?1hjhMGhkAJZmWxmQv1lszMfEzN1C/OxZ3Q9fugTSo0cywdocnatofH3cYWRn?=
 =?us-ascii?Q?OqC9D1Z1m/6ITcz1RpYfTh1Q9OLhZiapITi3pvbfyH5L2hUAUCDVKcXI2YV9?=
 =?us-ascii?Q?G++MiQ8t/8BbkdcaVT8dwpmDELbccDZM3HqHWjdPRDpHK0FnBggRAKv5zoR9?=
 =?us-ascii?Q?N1NGBIZX6M+CrgIm74UMYlAo2+e/48VptIyBlSCpPvE84N3WUOH/xXFG/rcF?=
 =?us-ascii?Q?xr2jVoTvgRoOlXXO5s+mx8m9ZkUw0QNKgBwdiHE3hD9EDdmh/u5wPZQLo7jy?=
 =?us-ascii?Q?lzNu2qxcY5YdlNzGLdOPylwRRRUW95+EwkSes8MS2bz3C2XPohwyIk3kd7T/?=
 =?us-ascii?Q?kL3uGafU/3cHMX433eKPFkivqn58qSWbkQEAarF1YT051pT2SMXwakPxNZYe?=
 =?us-ascii?Q?hmAHnu4AD3PK3u4Kp3UcuogLChL//nBNmZzPWak+NP0l0OGMkVgJ6LzpzABl?=
 =?us-ascii?Q?/RemdL3iVwt7m2XFNdit7afSzDCo9vRBnrOEZZtjMH/43aHYqy+OdRS791iU?=
 =?us-ascii?Q?T+GdBl2anolOjWQrwLXl8DMlijTnxuM7g88J2DHG3PiPnXpX6oi94IPS7eI3?=
 =?us-ascii?Q?3KaJPLBD7XQ9s64mKDgVjttOU0w3sebyFtJmjdr7VuRDhj7wOyD3DwbrbdRe?=
 =?us-ascii?Q?FoBLJVpp4EgfqjOSL/wgyhrlJ8XAOgHoYfNzxK9UPSqgYG4nLm7pGckgOJZT?=
 =?us-ascii?Q?1vj6U2R1z3k5JC1x436RI3MRe6j1TObljB7UUGbw+g0AMubEoS/S/UE0Xads?=
 =?us-ascii?Q?AgmsstMdSGdn/gvMPkebq+lNcE1N81vb6geZPRCuE4rJetvh7No32Y+Um66S?=
 =?us-ascii?Q?FmQqafqcO2PAQfL9m8WBQOmeFvGMw+hWAHxUNbocprzC5V4uPZN7sTGLjT3O?=
 =?us-ascii?Q?ELNNeFSyUETaThTf48=3D?=
X-Microsoft-Antispam-Message-Info: bzjL0JObXdXqypsInmo7kEciQ6vpiQp4HD9mnnyShlG1D2kaJdsbPvWMZmCuwWJgugbac3D8cWgm7rhO1Up1byVT9WIYi931p2+7JUFMXW2eOaiQSaKwlDhdAvZNJYvSAjCS32BLV1Ezdcc9ytS8YxK8tEM2KBvI1tZN3HlfqlS1xpklVoXfPzbpUvf4EjiLEC7G3Bst8c4dcogWkLcnkW1RVIFvqa9qLbDi1Cjj+lp1y41cCoQjUjMb1CKpGIQ1XTVVbdVPPYeodHLekXSkCx3HdlprIaNz0Q1mFLfUQTAs7hqX3qUlkhetYvJk3CQ7
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;6:JFs3O5X3v3xdNmAuOqaawThdHvBhJOBu+jgEswbdttHxeLBSfUSK/e+Gw7B7Fu/E00VRymumPBGH6+FyTv/U//d1IAlZoaEOU4TeNtDDE8uk7B141JtOgmOqDNXzVoD9D/l1WVRSLxBMYY9oRCAkm73Z8g8kHRC87XaXunDnUK/2gb7SsKXeHRtW/D4gsyhLyRoNghMpnVmkigGy0UahLs5zdilA9JsIf95mW8rhfQfJ3g16Az+mzsaEjbkHpzq3SzvVWZ6lqEfVY9EavfPwcnatRZ/kpLTeylPue3FnFUk5mxtdr08fvK86YHka7DzcLIH2ASyrpzb0uFMeGY5xp4SIgyYOumazZEEDSrpVzDM6nGHbKUAaa+Lcxzr36cIC9Sr5CZmpK+kbmOaND/uaIyUknj6y/U1rVfGJYutPZVYWgATCw2Okp/XU0jyxJYBU9Q1RlCJZ6lhlsm4vmPkaHQ==;5:MH8+XWfxKHKD+5SRStsnnZ6BRQIkUnTvJoYWTRBveuK+ViyG0gjVB1LeheNIsj/V7HwiGOcf7NgtWfw3p5jelkP8pNzpg2HtZ102iQo98rZyg0zYgmAHleNv0QE968y2nnhcDVDK0dZYYSCxmFGNDXJh/1NtxzGVP8/arMvcnzU=;24:aooQkXi3mMOTcvLOmclPns1PdL4p/hKIWYWqeyW54q78j14Yc+MaTLKqqRQciKbRJU/17WtmefS8/p27FofjxassVNZcsAp5h3pMpd30Vcg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1610;7:kTIRBk1hpyMhwF8vpESsTY8dKaotFXfFw2ds+YNz/EXWWV97pxtjAOT0cHnFvpRCixIqOmLyMPA5QIlfaxDp4rBebQd4b26CKaDoh6XVMKf5RGYuxDwEwi7uNfhUlV7L7jPHXOND1Vd9MCroxN1V8p/tyzdp3FCFI/OxugYOo6z2Jr2ggdLDMaWcETBW1kCszAJLW8cI6NP/QrYWp6Kuz40RbwSmD9ANaK482S+HJeGvKHRw3kSegglW06f4DQeV
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 07:24:42.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0042ac46-2748-47a7-2ad7-08d5d67ee4bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version for the patch series sent by Lucas.

https://www.spinics.net/lists/devicetree/msg212752.html

Changes since v2:
 * switch back to the 'fsl,pins' and hardcoded the config values
inside the dts.
 * updated documentation accordingly

Abel Vesa (1):
  dt-bindings: add binding for i.MX8MQ IOMUXC

Lucas Stach (2):
  pinctrl: imx: allow to configure SION with generic pinconf
  pinctrl: imx: add driver for i.MX8MQ

 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        |  13 +
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |  19 +-
 drivers/pinctrl/freescale/pinctrl-imx.h            |   4 +
 drivers/pinctrl/freescale/pinctrl-imx8mq.c         | 356 +++++++++++++++++++++
 6 files changed, 388 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mq.c

-- 
2.7.4

