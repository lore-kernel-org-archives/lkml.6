Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FAE2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KXCw1LyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FAE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbeGJIXD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:23:03 -0400
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:9216
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751082AbeGJIXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi0rPpjCU4+ya8xhlnG8oQkqE/5rcfae3BSLGyyjuyM=;
 b=KXCw1LyGaw0AtH7PlM55clfa/QEpW+C0pX0BRmohy12sWLa9E/I6HTxLHtnsPsb6vjsExDFhYKddABKaRWSWbI+eGhoupDTra8FnynRe0aivEcfsC5VJ7CO/ebhDIxpj8Kzwy8fhPcAaoPk5FeuiB+t1+iIl3hcpmdOUJkszwBQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3223.eurprd04.prod.outlook.com (2603:10a6:6:6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 08:22:53 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 0/4] add memcpy support for sdma
Date:   Wed, 11 Jul 2018 00:21:45 +0800
Message-Id: <1531239709-11693-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To DB6PR04MB3223.eurprd04.prod.outlook.com
 (2603:10a6:6:6::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73e135c1-e659-4eac-3446-08d5e63e5782
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3223;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;3:KfEUarLy67iZa8kMsqrxBYZ6S7HuXKM0e/s9QJ7Aa4unUg6cQ3+wuiB/WezVcLCZqHsSrXQYjVjh4AoG0QCW2wkOoRB2TFg+UTwK3VjF0uKnxTrPlcKYKxfzu36WtO6t+IrqzZupNn2I+4f/tBsHRcNvp8eHOIhldnXbAjXh5SGd+322BRViCUceOv0Ui7JOdMTZQFXO3tM7TMn0xLuXQED16Aa57Rj+rquzWUAHKG0Ly9Xh7JIALgjlN+nLRW72;25:mc7NtcmuSJAeTDGtmXtuY+hU8yOih+LjpeEYi13SGH3bFEX1xwaAlMD35LxWTzCmSMRcyk7TkCclFGihXTGkoO2NYjtXtLcQOTUsKEguRaJ8nXL20WZ/wkhd+wpxf+imnsWnNuR6Fobe9qud8uMzm9VQGKyUfIl3ND/agKrJN4Ei1KNkKQK6ljjSManqAxwN0lqOrlLq/NzfYy14RR0pxuTEY9VrkLYmsseuXguQOnYRZIA/j7BDUDADJlOa7BkrRRqTGd+4hdgx3DqXcP3CGUB36iE9bVSWrlRGQL51b3heGPryVDA6Eb4moN3rgvE/JGgo6ysk7s946390Na9ITg==;31:8SSqiIvl6vxp96s8g7t24/yZ0GbmYYU31yzC+GLnQIUDK9CFGBUqyrDUz0Ik+eenA0+fotjGhPZJwT2Db6DFa94wabHA9ivOuAjEOuBDFV8pYv7ejY5a/Vvsvix8tcNIi9/WchHSJ6IbwxnCwSJQoGisHcV7TWcN8lqKNR6rPzqzu92A8kOPJ5ix/WLfuGbYv4ZxZmeEtZdphNfJwxsWBVEcPux1N/m266kBnSf0Jkg=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3223:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;20:dmxCCrmMj7bc7jFoFlJkv96z7FbKq7l0O5p0Tr06/xHKiLhe3EUcSqIwCekcZ2SvIYpI+BAIiZvynjc0MieplPXuGYWIZ4GbDqV4Z+rp+1EV3OBI/DmOkgLXrOjCQCq7hLtdF4wtAvZcFwmFsboF+IVOTbuldx13khn4KRdi/bQUk31HU7AIsZGTOt7ANQRM8wAECllYBIRoR59rHp4rjrF3727OS+DTxPq9a58m7FdHh0gVHPoWh2afhfwm4InOb8+aK9gX+yRuM/n5V6l75qucPFpNnwdyeWCKjz6K7G0K0GKm9ejfT5diER6d0qrZOJcCO9zs3lB+QqfA5L74QjzJY1tKVCvUmn74A7bWLdbH8KQIm+ln6fk8JETRJc91VUXKCT+2JziWB672uIemkwsvjkJn4L70wcrIUBn+TLcJKCBMY4DyZUJMd3/htl1mq2QKEuDmXQ1vO3SuI57N4saZCK0gU5qPXgO672zCq71ufqh4lm/WVQ7LTtT5wJKc;4:sREnmhavQTe4ylTbOGR2oeqausGK+Q08Rn/MYiPFhyJwD296DNXZAgu27Lz/+BAG0Gy3dQiubSb7oQLUw5ciJD48ANrMUGHqag4jFDxYvxi8DphC2HmOStwUcu/mKF82sfWIImsaM176BOS5j1lVARHrjoz3hPMWplvT4bxeVry0srm9B6zGQn7g2LBSmSiHnJNyd3Afed+LBrBzvuRlJ8QTaODA0ChuEqiUJuNnobUrz5DBAFQCPxFN9ZQLh7+Yis0QYZDDJ/s1jOI1MmToYA==
X-Microsoft-Antispam-PRVS: <DB6PR04MB32238753D7496D97711D0282895B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3223;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3223;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(4326008)(8936002)(6486002)(6666003)(81166006)(81156014)(8676002)(6512007)(48376002)(53936002)(25786009)(5660300001)(86362001)(305945005)(7736002)(105586002)(106356001)(50226002)(478600001)(3846002)(6116002)(16526019)(186003)(66066001)(36756003)(6506007)(386003)(47776003)(26005)(486006)(68736007)(2616005)(956004)(476003)(2906002)(16586007)(50466002)(51416003)(52116002)(97736004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3223;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3223;23:JS4voC9f21ymQh1CWwE6ZUhj79ctPG9BKsXI3FWpx?=
 =?us-ascii?Q?5TdppRJqHrVa2WuO03YKuYp8shTuREMJGX5HSzQo/CIqab7m0Vaq9bMvS+1X?=
 =?us-ascii?Q?OboxvB50GIu7P0Q6PLp6zgjsU1+rirWmyYBqt6BzRrbGUCuf0vmuUU9ymm46?=
 =?us-ascii?Q?1aCC6zm7oPfMK/H5W6cPK7acEPBJ1GPTohuBmMytB020XnicgX6QrxbELZD1?=
 =?us-ascii?Q?vsQwxL2y/UN4gnWzvNIs1qBvd27iuyvR8EMwhtYs+HlM3WldxuT464neLPPR?=
 =?us-ascii?Q?sMKdrfRdAYAeBUr+4Is/TpZE97gGaMsJaqzthxqq95bp6DhioXSYK64s7Tfl?=
 =?us-ascii?Q?NiVLsM7jFFXRLHt9WguFNCOXhVMe6gNnaHg0iX7zlmPETnuHfDbO1Zr0kbwo?=
 =?us-ascii?Q?o1SLSfhARFWfKnwu83UA/mRd2qlHy1iYluPgViFyG12gphrhTwbUlYcF3ZMD?=
 =?us-ascii?Q?VK5Lt3kR60C8MpcERo+OnI1+RmDiREtugzif9MFyxxcMA8FeGN6yoBH5JHHH?=
 =?us-ascii?Q?DGUJIbHi0nXpLyBjKEEs1IYj3ggGw5GBEF8dRJzDA9msdMxtEwixAOJgpx0s?=
 =?us-ascii?Q?yQXHmfE0O6TFiy9RsfMhQ2Sd6FDGDNY8kgEcYrk0J5X6+Pb65TumGMvOTSYV?=
 =?us-ascii?Q?XjwQq4MVLWtHsbvn0TF6DHctosE7jRWbDibEKQVf6qKKvz9ENh1RD3u+/SKl?=
 =?us-ascii?Q?e+WXUZm0jBwlF895HptNGpm9dBTmunqP4Mml0AnXZ5rfJmrTPUNRQCEY98YI?=
 =?us-ascii?Q?SyxABDcJN7BmhNUhOAboZpYL9MYuzyR+VkvDH7Fdo1DDYv+tEPvN1bCkC23t?=
 =?us-ascii?Q?5QRj8UyfON3FVpZCGYH3rY6mTY+B5cYyaj24NUttlun/q5Zuc9u/9FCQdsKK?=
 =?us-ascii?Q?dKthwUlBvkPArVdjRckbailD97Q9bnZ4gEZTL+FKzmjHW3apJ3ucuasr2lCi?=
 =?us-ascii?Q?Aqe7yl0gs8rxSiIEHULyfaamvqFb603BdzOxDuzzkIpFVnZ7oZ6hYoM+W0wD?=
 =?us-ascii?Q?i9qG8qYXcM/dwqg68fYlVvrf7isYNC96HdweWiANgquuR68rgH6SxcD9yxK5?=
 =?us-ascii?Q?cQYzFGP0QTNq3gdRBCEQCFGewZVDzkyAy2103xQty2tOFwpSg=3D=3D?=
X-Microsoft-Antispam-Message-Info: oe/61qoaUot7VrvXkkoB3ZCiuQnlROBiVNvtMH8L6KXyib0byn96Tlmn89wJbsmXsvCDXoVo2KwKmbJFAi39WrjBmifWTGW0Fvc/3I3jwjVvqrU6KTjh7mZ8G68v6DV5uxeLqt8WAhU6/Q/p7RN5J9LEXmDNpIqgnegMANWWI4W6S8pVvEVXLUm4c3LVcajSgML4BHaWGOfQeihqvv6A3GWvpEA9lx4hHiHB16xZzbMuTOK4SzUz5wS1keMasWjfqF0ny9ym8X+8W98Cw0x3+mKjAVsuI5atD2qgcE+WD9TEOJcr583NFeGiuI+Z6okYSaPpGDZREYWtOFsNEqTWx3k/V78QIx0d94S1wtOvs60=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;6:cN6t1O4OTL4WlRwHdjILvCczBzsWM+5n75sRRhxwWVbZLzYRKeMEqhMsh0gczQEREtAs1uz90hIqCxtF6svw4alL25j0rB27lJFInQgHztKyBBM5G1UALHw8v/MPAMqLAIQCANfn0G1nIqEIvqHWE3aV9bovvcgZK6vf8vKnT37d/aEupgFaJMWp7hnXCD6m75z4bO5CC0418Dnow7NPCwILufLwxqvvRC+w/oFIt1dS8tF27jaaMBieGE6LIx3laCslvX/nh8gBwICpPrUYNxw/mLitW6xngrHRyZ9WQfg86MCP7ZVRQuU/1tGvMCVlRRlR2cIrxBwOZsB86fhzdYbXzP1uJ7XRS5y2FsfFPID2gGIwzcQeyNsW4ihlIU15XVHKXncdPm8z0nj+LQNIHtYbyCRBxpPGGqXyaBa4q1NOcaNIh9XVEzHDjj8ue7LIsq5PyFH9iTSyNcfX3Io7KQ==;5:2zmlSzGtkspeprnm1rzxyt+YR7U90AY5puQRzbPA8tYITf+qTOiKl4jPk5E5bVJgwhWwWuORBJ80b8eKAOzEym+ecixIkDHW2YR3aopKVI6WCaHxuuOxdVe/7oEecKkzkU/+qG8xSaLAMmgLpWOBlJ/K5irGmfiUhTnoWgRSqrc=;24:Gw+S+T+W6wfpN/5lMBLnG8Uub95NFRgVZIuH7pNjGNiQg4vGcspPiSb77EwIIibXIzHYIo/SztAYpbh52EWUM1yKb4Qg3BJKSHy7vav2p9Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;7:WnUa7P0Xzq2ZMPm/z9Fy+TVjsHPT8cjlmjZVIQi5x/AADdgds7+AP0+ZhlPdhkurj+Vf3zHZBaS9QJs5kyKZ4U4nuMkGnMgrvRBwe9xIJXz1m17KuE2NFLMebRcjdqKn4BYZHvshVIlzO3EpbUNFfnd8ObMiBpEXzGPAcRC03/oCVTVc96Qa6QZyF6FEyICb9IPcP+0fGsn1MPdwuTysFfiyIzP2IUlHaJ3wdc1pBHhqs8nV44v4NGegdy3QUuBA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:22:53.9086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e135c1-e659-4eac-3446-08d5e63e5782
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config related, so that easily test dma
without any other device support such as uart/audio/spi...

Robin Gong (4):
  dmaengine: imx-sdma: add memcpy interface
  dmaengine: imx-sdma: add check_bd_buswidth() to kill the dulicated
    code
  dmaengine: imx-sdma: support dmatest
  ARM: configs: imx_v6_v7_defconfig: add DMATEST support

 arch/arm/configs/imx_v6_v7_defconfig |   3 +-
 drivers/dma/imx-sdma.c               | 172 ++++++++++++++++++++++++++++-------
 2 files changed, 139 insertions(+), 36 deletions(-)

-- 
2.7.4

