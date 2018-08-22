Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EFC214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iN+7Mo1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EFC214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeHVRNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:13:42 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:19992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728522AbeHVRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHRf4ipEYLvuUK4DGLdaMc8gjKSxVqL4nlWyFH/4JkU=;
 b=iN+7Mo1eNCQ8QxzW9CiaLkP20O0l22kkRXaxutHRtkCu1FNUeugVhpjtWcEoQDypSBRAMX9IvxK2tEEWLv+OLmLv4HJecDnBi0OZNZaWIN4ia3u3Tnovc5dp8oc88/iVwlLqoXbt/dMPgYsKOXqVllHN5MsihnAuXNCKrAuDjqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1612.eurprd04.prod.outlook.com (2a01:111:e400:59a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Wed, 22 Aug
 2018 13:48:35 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v6 0/5] Add i.MX8MQ clock driver
Date:   Wed, 22 Aug 2018 16:48:18 +0300
Message-Id: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To HE1PR04MB1612.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c84422-9b62-4e3c-2d16-08d60835f557
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1612;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;3:lgnse5xED7aeY+ZK5JX85qbrQ9ctYK/7JlsY9hgkzogsJ70RPJfbiNFT21A+e2q9t8pbxgbtAfXe6x1Pnf7TKhfyz+rO1S1Ijcf3de0G2s+UIY2WmQ0DPDior/PRrE+52sft10zuPHlDXKQGYd+/OiuWhNsl1dHWov3y86oXW0EaE+MQgdLdESfLuQl0OGM7EiJK3wdAkxj5mtbO4WYLjnA8MRs3hX6Vgy7K5tG5Yv5zGAAv/o4rLoXX1i4ii7zW;25:8SZ2js0YJ7PQNLAPadbR01Y+CoEb13VGhJ90ChlOdWl9Ahj4jLKVhkiaYnP9tZMegC9R2JRdMff7WzGHEevxyZCqjkOgevz1ImwC17qit59ftfliSYy8yzfukG66gJKhl+qFaVHKwOGyWptkY8DXo6xHl1kIB+J+OkDNNGQko7Z+YgA0RzPmCYUKlS2TJ/vXjLAh9a/eMdV1r7mZJSOSH+ZIE1mRVJ1Mjk8EcBR19Gnxtj9ISV5wDqafvsVUn1Iw/lnt8r/SS0+mcoZrTV47CEc22R5GvKcOIDZ5PWa8UcqdtJNSE/MGCFHqI398SXmQDejSz5dlXDZrv43YfOEO7A==;31:oXovD4gUmbgdm+lwOQA5kSPzjzcIho7glUaS+3HFtolC2crvlNpucWhnulVTZDrAi22uL6n0x32BepKbFLJlIPI+z6mVJfXKVaQZjoK8+QlE9lEQ4RfLEeZHECmtJ/1guP/unZFicjB5W9XNzMUUA3oxfUXx/Vkb/yNOny8JF5dij6eTmVccYzlbmstkzbdfQix3om1vxJ6cF21UfnIfTWIOGunbhvUtLvs8+lXC1Wk=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1612:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;20:3f2yIO+rvXJr1xPfvCUjvHpdWgywl4mJMCzm3OuuQKOsQmx97ZMCs8HM11oc7fpB5I4GHkk70FVNBztk5HobAVoFv9Dx7c+jaGZmWPmVrUA7D/BxvHQguuN7ITmrAQN3btOQ5LJNJHhBpZPEu7okaBbnUlT+A6MRgw5f1qa6aB/kQZrcshUD5dATewzSfotKV5vZO6JEl1y1xhLq+GJ8NpGPnXKfr2TPIrG3LiyUfnFGIOoWggSPRYgiezFJF/3B40nPYegQLPzOOg8CxK3a6tUhWsW0EDR3phQKHL48lwkfWMaqpPUBeduFdfnljkzlHwHWAIYHBNL0ZGatKqaLKaRacfUkSKIfdAm0uWo32F2PzjECJO8a0BgbbL5Uit/MxOzdx4ijjys4cmPwkEKaDEsqsgUCHvSRUbhPiX00acnHVphG7sdHzejG0J/2Op4L1btlH8MqcEN9sKm52LRsuOlXfmXxgZNON6e5Gc5unCc1xPCUCYdEXhsnulYOgB6V;4:D/WxGhLMkQJLUPrFbX1/Cp28cS6l/sGtcv6Qw15XXMavXq5H6UNp32RlFI1brcja/w9Fb+yvzqYjbL8+seN5doKCaxvI6tzvW4xIgu0gMg0L3kqHljyVhDpkExUyUoVqeeIK4KWUgtwUy+TqsY1L7nnNVO99XBo2HTJIYcz7/iuV8dpDt5Q/qHuLrmxQpucxDFvtgkcUg3tIcorWsvrozzi4g1Bz+pwC5lW5bPd4aoOrzxCUoeIZxNBHJyqrV5eRekj66+a+DdcmiHdkGjNRcw==
X-Microsoft-Antispam-PRVS: <HE1PR04MB161277665C01C38BD7AA8196F6300@HE1PR04MB1612.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1612;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1612;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(36756003)(14444005)(6116002)(186003)(26005)(16526019)(51416003)(386003)(52116002)(316002)(47776003)(66066001)(110136005)(6506007)(966005)(50466002)(48376002)(8936002)(54906003)(97736004)(478600001)(16586007)(44832011)(105586002)(25786009)(5660300001)(86362001)(2906002)(3846002)(6636002)(50226002)(106356001)(6666003)(476003)(486006)(4326008)(7736002)(8676002)(81156014)(68736007)(53936002)(7416002)(2616005)(956004)(81166006)(6512007)(6486002)(6306002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1612;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1612;23:hoca2oM6/B5tfUVYaYsm6owxIiha7ckP20rJDdfL7?=
 =?us-ascii?Q?AGz3IUaPvmaGWK5xeStqlkUlMvfA/3mJCaElr28vEFvcJSw3+oY4DaNX9CwN?=
 =?us-ascii?Q?hAVhJ3oZeHskwoF10b22BK7N2R0/nIdjV/MCXr3HkOlqA0UQTps+i8NEMC4w?=
 =?us-ascii?Q?BAy0BIAW6b5zUzf+JGGpTd6WVS0KdWZkp3VVkfPq08SQUJzVKs4/JTEOPu/Y?=
 =?us-ascii?Q?dxhLdZgV7OdjQSW5JsycKrPf0L3AYfA2PIghCoH0pGsQSrBvkN5KiQL1z0kg?=
 =?us-ascii?Q?szD+3r1/Ju4BXxIIU6rpj2N5YZdotKSc6eMaxnSxWe0RszchWLx1nSCYdWsX?=
 =?us-ascii?Q?9/ETD2b/yPl6HGxTR/g52E7p+OU6M+tMQij9Yx8Er1U9e/3vbZBNwY2p7Ins?=
 =?us-ascii?Q?Vrp+WRiDQsc96aiacBbjB735uF8qLUUXgwYc2zrVceR3j9ottwqqTzar9G96?=
 =?us-ascii?Q?44iLA5OQ4ZigzV+rh4JsBwv3wnOKipLeoYMJnTWuSLqOR7qmP6pMSJX7OUAG?=
 =?us-ascii?Q?On6oGQGFojAD618GEkoYsUrL0pTRwZ7MSxX2ngjhOYS/ENr4j9dINLGvvOYm?=
 =?us-ascii?Q?by7XdCoqtcUhHG1uyPD85zrCpA8PSTPpkK5HEkfIMpMYYixEwFPiA0edd6XJ?=
 =?us-ascii?Q?vCuqx/qLUe2HWgqMMlmXvYxhT80vmdBs4Co05rHsBGfaIEgn0RRaKtvMAF8n?=
 =?us-ascii?Q?M6hIxfe5YbX6XpyW2CXXWDrF30kJIVB07cXxmBZSKGwUy+KrzQv6lQJxjGfd?=
 =?us-ascii?Q?flzxbnePOnYei2m4IqNzd0dqZc0jBZnj62rTIhxIbq7qGddmXX8FgVVMFIuR?=
 =?us-ascii?Q?PBFA+iXihJ/aM46IeBPh/wA2/poDlYIqi97L9f0jQhSFBDWvD0dVUQyXkVaH?=
 =?us-ascii?Q?Kh5dL4+odAAMk+C3nx0JvGBh5hucnr/zYCoE7VFS6606+epFJqUXRfcpKZs6?=
 =?us-ascii?Q?Kheuxh9nFFlNeJTCtBYU9TxUIp81Kx/hb/DkDTlLo9r0Ws1n0cBosHUf8MQf?=
 =?us-ascii?Q?J4sJgM5xhdc3alDC/eurs71Bq2dKe7u5BzdNQyzRFDMIiQXUGrFBP6extz6k?=
 =?us-ascii?Q?lV635Bkoajfz6QMhiHhhqf1koLlfeobF1dQdxUGqgjisyBOHpbSujBSdIVOU?=
 =?us-ascii?Q?UWK8+O7Yyptrt/LhnLbAqz2Y6tuG1SB0wDz9qgygFYZ4AVGtizNgI8WrCogJ?=
 =?us-ascii?Q?dAZXuik+L/2O/CCF+kxIsBXXmbq1HhjUEY9HFfv0f6JcHIddITpZGuXE7uWB?=
 =?us-ascii?Q?XOWKSnsd1g2hEipVDA=3D?=
X-Microsoft-Antispam-Message-Info: fWyHdWV3Ix2OLKfi/lul6OUOaJjI6Z+k2pI4LAZtvy3JapJ2MrIHcesinVfzSI9FQcPvV6gQiu48EU5WzDzXFOnDDNi0KVgIlykiWZL99/5s3DDzI9YYh8eSHfj30CfwvCu6WF8AzY2EaKSAhtlwFc3w+YstYdM4qZZDCTUXJgG9OZFaPpFm4i+No4MVNPz5yBjMM59IKC3B4we4X2//MT+oA1emgrwbEkYVTvOJWc6cxma/unCHNvpNPm1fqwVTicSSxwPdHvTFQAGYjtml08ADGuZcALf9atDDFkl4+oJnLls+LPsfopQv6t6FEeKIoU8NUWxmLFqh0tPv4oztW4ZFAw2dS+Xt6nY/RduV0u4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;6:QOFCBog2XJpilX7MX2xuExTleIZ7ULpzlZWDx5Zmw3K0FNl+e6DUJDYqPQ1GRF9LuQLVfxwi4wEb6qpr/knlc4EzrCBK7scsmaBvfE/EKcCJzwJpF1Lm0l0Rf0hYWKiiOPj/4bfuzIvthC0YxM32xwoBlX17ZBf1iKdrfnUOsbrNXEyLsCZ/xYSL9WJECgpYNGJ/R0LOuwkbgv62qeX8VuwpggV3qiJDTJEGxlRHg93SimPhmh3SSuofqP6uEb6d1NdR0JGuMnrwk70OD2+66i1KbmJ0XjXB4JjuAD+AkfNC4gwyoEu8ovy9tDYLT8RVJ7X/FDxQ+vlpO+lkfu+berFYs7A12DtaVTrCGvOe61L17Gtegfox6Md20QhC4eUr2WM8+7R+kgghR7s1T1qPg0nwFI10J0IP6D9FzYddcSeKuG/LAG7ElgcFfX/SZuvwXFmGVKR/ycAzLzKzhv99YA==;5:LJQIYc9z11ecLJhjkKfPgazynE4NgF2C8QgdfyMTQmnl1XR24pQQQVGBJpeiYrMsPKSGyIGgHE6z3v1s5sXP01qjCyG/QZZrIuM/1zea8o9mTpN6bIW3tPHUSAw34jCULQsbZSSII6inAJtEozNE+VbGvMYuQMDHRyHinr3o/+0=;7:aeUZAxOQ8lJ6v2cX2xg7rdx8KNgiPdhYHi/dQ1w014mnqDLSVnsNKo3wFdfml8uRqa4FVgNNgWlyvebv3cvuxruXVUTuKNEb86pyq2KpX3kCFJLEOABmMhjg0IgRbRNolI0THHANusgEPmCMsKyFdt5HSEVpolGJvBtwKefjy6XmYWi+QLXdHptM0uQgV8xOiovi2hmxuIw/yCBuQCq4XNDg6hXERExtPPSkHpW/z8Jq5vFEyHRitMCHYnFl4Svk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:48:35.0464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c84422-9b62-4e3c-2d16-08d60835f557
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fifth version can be found here:

https://lkml.org/lkml/2018/8/20/83

Changes since v5:
 * Fixed the predivider and divider register values as
   reported by Sascha.
 * Changed the commit message of the 4th patch to match
   with what the commit is adding

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
 drivers/clk/imx/clk-composite.c                    | 157 +++++
 drivers/clk/imx/clk-frac-pll.c                     | 230 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 631 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 231 ++++++++
 drivers/clk/imx/clk.h                              |  57 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 410 +++++++++++++
 8 files changed, 1741 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4

