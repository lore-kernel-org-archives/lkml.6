Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92062C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFC52185A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x6T5g4TP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFC52185A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeHQRPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:15:02 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:15904
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbeHQRPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF7I1ZornfwB1ppaK8+XTNNWJeZtft6qIECbt5DkjR0=;
 b=x6T5g4TPYBWkTTfhgmBqqKfuQ48DWFQ2FjWEnvxJq58JjayIbwEaziP9n0n4UfAjWRuGgL947I8lBo/iAtl413HLiscw8tgPWpAYg7X/QOAeRsQkj7DZ6pATboDuYFApR2BaNG+VdoOwcRrJ8cxhj+AGSGc9Qf2Fx6lsXN4HnLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 17 Aug
 2018 14:11:23 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 0/5] Add i.MX8MQ clock driver
Date:   Fri, 17 Aug 2018 17:10:41 +0300
Message-Id: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR05CA0200.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::24) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fcc7b5-4091-4674-643a-08d6044b513a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:sUBOAltqUKkseIU7Zm7EV16/uS1DYs5yBMZE1mHmEGTY3t0k0tTi2BujE7Dl1MUbPkyZudQTfRIBLXwGy6nZEGXQGtWqZSFKQptjDmF005rOlnT8Ab7zmpMJ54x/RxToT/a9hKxs5rA0/IDI/tLEDuDMxxC+Rp4dUJGSrL1y/dcZjXqGFS0vJnmFwk81bLTxEAJqul2OKPFOtgi2dE+7bVocmx59CYH4U4HxdSDhBryHZWKSFzEOnElRaCzKtZjT;25:AjKtsZGvdkggJgugXiH4i2yi/rpzXPw6xacUsVg75gkKS+wtjRNi4dXmX7cPEe+yM5hvqaqW7IBDbbbVbP4jamv10UlJbnzQxp+GkBugt7jFcrSyy1aFE6WmJUoGxCrfXw4qLk2hIfe5NdxmESxlWO3OFVwVU108K4rJIg8Ie+7ZFX/ZrAcfmspl0zO2P45zXNirfUC3WzDSX+JfYpBm7/OQoG0Tok1GlK6vD7NTCBYc3uCpwOSt7PogbgKsIKWbCFojccJHpCJoCzPtei7u8kl5WwIpsxjhW4eIVYLVg150Pd5Q9n1CejDuUmLkLVD+qC+BRuG8GzbW3uleVrFoYA==;31:inPvutegGx1XGepavQwh+GfyWMtg8/7Sfs64mdLcLSQZv192J6j8scvxKVAnI94dEXvtCvwcGhR/dWSjThDVlJj9oMMD8/xGG5dNEmP60HD3JJAEILNEA2ao2/Bne4cQx8Ua2ZaLgoIZIruzgcZKg/FTc0b+Ls6JGt8hh+K3zgt3t3fWipWkHv0wI2w6z7yvwdz3vkJaEUpOcCT5+BFiWd4dzAnxqPdty4P2439NPZg=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:1z8I1kGgVXq62LFVRmphqxLMvZSANvw9SFDl9s6nl/DWXtIyIVVqiNutFqy6D+ocvLER0r0cb0M14Yhxqe1OKskDuXLhuuq1lOGMzQV4G/60GbQJ4JYMBrQY30YODCfm+fuPzjpFai4NKCTzJokMKcBJz8UgC1e21vnymBWoieE1K6FrNJzHbOoDg6/KdNzaKBD57+GMv84XWwvKFKKX8AaTqayR/Ad4dwuIkqJA6di7n19Ey8mtkE5MyvwxRfVn0cHhG8QZOTMHW8bSO+ETRpWKqjlseZwvLXWD0J0t2kFGkmOiNIhLaUZlOlzPYO7Bcect49pcI7h+o0SUhTPbFPcImNlB8ozsrqsjniLpnx8J32zjdhxyTS7uiuD8NYkT7F1Rajj7RIzQ105CVrwocJWNPcJXE+1PPLRvV0BRqUIjuU2ySyxibBiOkrvOCAQ0ldtBHFZcD4HvsbneWVXbmoWFA2XYiQFA3mehRESRLHznnnYmAKpV4r9twiPtlTiQ;4:/mp8PWL9J+0s3Rz94wK0g2cHbZ0ew2Y63z6HSLsiZCVoH/lTGJbkiLDRHwawrPy8ihO2aZ5rGs1AOxYoTlFK+h3ziA7H5mgTnYgsLEbu/4JLuna3GH4qZ3jTdeB5fTZWQxF2LhupgyThXII5b7AJ93VqJX5vOmhlAfor0RUgHdVkoICZTgypAwuUNeGorkaARpHEvsBjqF5peZbfeJdbdm3cuop0u28Xz0bWi79D1OutVTjysGqIVxOLZmHqAWVi3SLH5UIOpvn7adarFXTcdQ==
X-Microsoft-Antispam-PRVS: <AM4PR04MB1601B290FAFF91B5E27E9944F63D0@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301062)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(50226002)(4326008)(6306002)(50466002)(105586002)(51416003)(52116002)(6512007)(48376002)(106356001)(86362001)(6116002)(6506007)(3846002)(68736007)(6486002)(36756003)(386003)(110136005)(478600001)(6636002)(97736004)(966005)(66066001)(7736002)(54906003)(956004)(25786009)(6666003)(14444005)(316002)(305945005)(16586007)(16526019)(5660300001)(486006)(476003)(2616005)(26005)(7416002)(186003)(53936002)(2906002)(8676002)(81156014)(44832011)(8936002)(81166006)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:9PXBGbIuRWya6PmYSfQiJDDfwOdjKQiHb/CxZ+4Mq?=
 =?us-ascii?Q?YwGg/yd1/0QVO+4x1vBnPUgiFFCjWUfsg9aZOHRoCNgV8lCeFEn8MguJon3d?=
 =?us-ascii?Q?qRYBQUcJRZkqXmNvt9vDZIQYe22VPRHUZC0xCznd1Cudo3wnBJ8QFzBC98kh?=
 =?us-ascii?Q?pD5hyAZjnOJ45YCaRrPmdPk8WvvJY6wl4j5aKs57gTOhusJr7vkMbpOoBUa8?=
 =?us-ascii?Q?rWRTL4zVaGkD451Mxy8iXtP5Q8bRfwyEl79BB6W7b43p8YSaMbRc1/PYPb1+?=
 =?us-ascii?Q?P9Fo5HrnIn7nsuf/Ts2VOGoO57GIzFgV0PF101+lzg/j9+BMSpjTJbEzRf0R?=
 =?us-ascii?Q?JwgNdslUH7odjw9MiZ/qMV3OonsdzNvm37daTD8OzLSr1AWGSn+3nudzCyTR?=
 =?us-ascii?Q?TY1RLhDYD/pHt3nv+Ki2j9TvrzyEEEaUK89md+ZsIv5sVMEhmDVnUD2jhXlp?=
 =?us-ascii?Q?BK4nuoVK94ksf1UgY+0su67YFh/TzetZ9Nt9pQuTwesSJ9n8hoiVLTjJduuo?=
 =?us-ascii?Q?272fr3ZiYnqqWZyzbh0JcGUpasHPLWTfAWOzb3G2mbdbTRAWAIdDKffKXDFD?=
 =?us-ascii?Q?sx0Sjj553+lnZ0PRsncbvN23kjxlQLVAtu9OPbCn5FtFFh2m79I4RTnkTlmW?=
 =?us-ascii?Q?2LVdZ6IPQZP/qz0f1ZVVDSJ9sQkXZa75TTD00NwOLHNDscTWujko5/Sdae3M?=
 =?us-ascii?Q?nXPv4lAdpZAwTicS2YRIewHPs4MU4BpaRNIP6jGGIa9aroCEp9ZNuGZJ47g8?=
 =?us-ascii?Q?j/nnI9wEvPD7TjOFRWmowvamrQcImX4vfKzjgxOz0KQ8+piUCqud1Jt3dLgd?=
 =?us-ascii?Q?eZsaLjSdMAcfLlZqCBOS9n7z/J+CrEY5f9Lv4dSz6vmFHVfFzWMgXlHfhFbG?=
 =?us-ascii?Q?dWJp5fy+MxrDh3fx9gRSrSr497gK1dImMoSW3tR5tpGv4tqVVUcegboBfkLA?=
 =?us-ascii?Q?sNWh9t+QqTmeY3mmw7Djp1Hm3w0psSVMu3uKzD4g+f0pJfP2s4P+DEHRTF1W?=
 =?us-ascii?Q?l49tmKOv7w8uObI8t+ebelN2jWKUe5gxpQs41e/hfRZJEgFHjZtcgp0S0cVb?=
 =?us-ascii?Q?r9fmjAYfGf16smphGBKno3/Si1dfs6uMjRo1Tix/I9KIAOTGcXYuA2S8EjgP?=
 =?us-ascii?Q?9FIAiYmD5JBuUtRT62+/Y6vrLGoqCXeX4zEm2irYgnHY+NKThFejMt6epSdf?=
 =?us-ascii?Q?Joi+W5mLw8LKqQqFi1ta+jkDzVkOJpYSIpuw5wiEmjA4DH5ZPV6Wfiqxy0cS?=
 =?us-ascii?Q?JniNbRYWR192lyqnEA=3D?=
X-Microsoft-Antispam-Message-Info: lIm1ugb9iKESITkXaXF9Ld3CaiRBSn9dTWIyOqMdyLA82aUyqruaig0t2gvWUrdnItNQ6ADPSNb0pCc2ib+SGBGYm+uA8xBOs++8TRl6VO/ferLefwYZ4E65FOdrMtd1Sw6Ocx3yTibVfhJhXakOPcubSgbskiOSvzxvuWGcN104ZrH4/uyyqrR631faVQjPd0mz2kC4qqrhx0TxJPG5AGzUNB2HBe33QgcdNnjBd94QgtaWi1O9tkDFVf0CpGSMPSige9RtjRVhHT7geEMk6wc/ksekenSJYvrRsBqqJq0SKt6Qc3AIWg7rCe58YwJlytnLftTm3hO3KkpgPW8Dy4w04B2+Ke3iyeZibfQolHc=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:8UDt1qg/kQSfXNRJVhWuMQ1+wV1R9i8V6A31scyUvVkzKXlW0r9hl2sZBwsa/rSKX+8P/xyWmiBcd9jSj+2mYJBqVe4w5niihy236bVZuhWS7PebJcGDCfmC7nk6uYse63c0fUSPH8HnFAQT9jRPgQBu2rM982gFKFPk3qLKGAXpdoUDITqGgwsZpTJrhW8zx9y+yBKJ0osAulXgRQ5XDFuqgWuU0QkuermAdcRRRAthV6/Y0Ip6zsDL641VZvR2OXY0hCTPwDBXidJYBX/AK5gEFOele9yLPBQhCxlsDwkWR/vw/+/iofQM1gtaPfyc3IVkGb7ZHJ4LoqHag4HffMQz/CsVLmY3lNhoOqNUgRnYUwIE8kLihbloqU2ZTCIVuxucHE9CFy48ynH5Xy7X+wRmheK/KvXN7NpoJK8K/MXReaowUqzEej0tE0YPI4hjknNSGbMKrfDlig04oXixuw==;5:8ot6QJn0bvLx/AVVUQ19web7gEI9lXQvz9Q3VmtGzVy6bxpvB8rnDRSSliIq5tTvRdhs5aEluLpUSkvjPuuLO+fAf/WT0yNkMGe+s7Vjr4LmGySOY0OB02SHDx4FutwpXIOQ+nGSOSfaG0PAVIHVc7Ujk4rJJ6mBw1NCFOp6aiU=;7:E2nlM657CHoneUUoyXSgkNm2Iur4lHHWV1FwZkhiFv8jOe6VE6RPzOSoEkQDQxtFGV9KNNpWkLsj4Add3v8+96n2frMD/M+O/akphPHppXXSJpBbsYNEe9fGOQG7pcoRI2dtTryoePlwXraE7naqXqfj4743F/n0qf1UrVocdMDP2W26AwWU1C9C6mOxcLkI9InMqf88DWhFjMoN7WquZPlTZAbNeU9ZnnFSSWxqIUHk5BemeS+MjKtOGxZdi1x9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 14:11:23.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fcc7b5-4091-4674-643a-08d6044b513a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fourth version can be found here:

https://lore.kernel.org/patchwork/cover/974998/

Changes since v4:
 * Implemented divider ops and used clk-composite as suggested
   by Sascha Hauer.

Changes since v3:
 * Added a composite clock type to get rid of some complexity
   from clk-imx8mq. This new composite clock type will also be
   used by all the imx8 socs that will follow.
 * Added back the reviewed-by tag.

Abel Vesa (1):
  clk: imx: add imx composite clock

Lucas Stach (4):
  dt-bindings: add binding for i.MX8MQ CCM
  clk: imx: add fractional PLL output clock
  clk: imx: add SCCG PLL type
  clk: imx: add clock driver for i.MX8MQ CCM

 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-composite.c                    | 126 ++++
 drivers/clk/imx/clk-frac-pll.c                     | 230 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 631 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 231 ++++++++
 drivers/clk/imx/clk.h                              |  57 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 410 +++++++++++++
 8 files changed, 1710 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4

