Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB97ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4022075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wYqbsosD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4022075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeGRORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:17:55 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:26695
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730920AbeGRORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oizwUQiYCq/o/mOVpOaD/VnGzEZGysw4Y9AKHhwRxB0=;
 b=wYqbsosD4A/X6oPaVPNNS/ZiaK5bu30kkiQEyGwHu12Kno4KXpHVeOhiLmqY5qrk6O4qSOd56pC5NE8ki3HhLdrs9Qu7cv4N3qmLLt5rw3MHCyr3gsykLnHo1//hdoapWLzlQlJGBx1g4Lo6+3VdDbY0Gfk40niYS4CPW0ge6+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:39:47 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
Date:   Wed, 18 Jul 2018 21:36:54 +0800
Message-Id: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1da4e02-7e9d-41f9-7ec5-08d5ecb3f012
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:26T+L5sqhFRXtlxHZdbJmlyM2M2ChsLLaiTZvl+ug93vilNGBWzDQwOOfbfej5z3Vk21Mm1MplHGhgiiHfl14w7rZAH9bX6mq0NhwdDwfmfJ7yMa5WwEgiYhDvjkHWQLaX5ixomAiKHjXptcr6xMbvVFA+tg0K3tDOG8BAY2y9WsX4vhHBLNU2ryfHeZ0BLFNbxzmGKC+BeqInULSrNXIF/3AqmrGNJXdaaNxRZBsjyk4wALRAbdTLnJ865zTEH8;25:ptHN0cTj7KyM0SNeHPzslqzpY7r5PaLQXWIJv9umkNSY3/54qgih6tFwKlGw6hDHObgmKdpipD6shUjSZbxJLml9I+1tNo7AFw9qQYDQukQSEwbQZ9lw6z3JhszCfxl5fRgGj7Npuc4J85K7IP6b5VK+OiwOpKCogYYrWj0DvauIsAd/7jvPTTHPfpf5yS5ljtKYghZ437Hc3pjk89JnSUzK8q3bJi/pjXExapFrpKdqSZOpQREDbXZl4/m9pgAxoOJBFuWe5xhstHOZFZlAEj+/ECnlbXqgRht9l4cSKBV4OI/IDEMdXKrrJHA457HFGfXgN0x/FFzQWaeGx6+t/A==;31:0DC7nOZH6/tNddnDOK6uTFWokMX4K0TPZxa0CxJciRYz2ZPluKttIa7xuiusnpfkrD1JekirafDCnqZTXyB3TuDn0qYkUdfJS3R3Y1spM0iZI+TYEadoVuuRJl9kEMtHXsu4XfU8FZWmngsqYugibhOCS8FDsglXJPTQBuEqztKL5wSMpCBZpfCin8qmQIFX7qvaRdF3OLFEDUT9rayEGpAO2O8vXebNuZ0WUYjE7ko=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:kthHit2UlD0eSgVYp4CMc2FgbDk8l1RC6P8bg/A/pArrPlfyoPnuCz6NZ7mF/ynhID4s5YPmBZjD0GTBpJtbtiQBKNVtmcHhcfTO8z8+ekkwikQqUlAV0ugtJkl3UCVWfzhenqYcMW7lGw1W5GfgN8Ajlb3ac0gcez8c8b4IzWZWOhs3LimBrHIC9QJMbdRwBWFggyfUMUkNI0UiYWGLNmOOm5OOl0Ll5Pirq5v9EUn2o5H7qDblnirMhE1lX3Fnn657DCy54oTdXOHtVYh7VmWfcMd+Xp93HJAp+t9tLoM43AbeId6ViGTnQNMm/URaH2po3PuWmGIveO6FzBXEU9heot7h1f3BO3VRXAwU9CP9zmKRk0TQo8wK7SGWYSeaRGj0Kb5HPnWPyJwmmcPwMGFg9KuqgEns0X/2HEk7IOx1macuSNNluP4KW6rL7q3zxZkzKprHL3ln1MR8kep9hkffWAKk9JTyXmrBe3XTwP4yG4gkEFd1SALqpXSl6d1J;4:y9UVwpyU+Cos4I7yGhYxF/gLrKgVhc43x/XqHmyw2zpCFWbp2vDzsgDoKVk8M2YHbRGRxsBTdIQePZwuW4W8r0dU8TxI83k/PrPQAIXeW2jHhG0/sRqpc5F+OGCqoxsv0wAVs60ZJ7ygr2LgtLu/Edj92mng0SWQ+8cc44vwRrlO1/BOHNtmVRIRumX28Df3G7UzxbxwsabDy8n5NpFSLmmBObjFk4PZdVtuvmLhmLP15sg0HpP+NTPHM+8C68EdXwBtZUOMEvwGFAqkfjkchQ==
X-Microsoft-Antispam-PRVS: <DB7PR04MB42194D0207A763912834528280530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(68736007)(186003)(97736004)(50226002)(476003)(956004)(2616005)(86362001)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(6306002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(966005)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:4XAU1q6WUV8Mv9dpv5sldfbWkrG8Q3/U5DX5MVjup?=
 =?us-ascii?Q?Kp5FYYutVDBIAuol48npNQxEL25itJZlZkGFsU6AXJ3oKZmcExJt6cpg9vwk?=
 =?us-ascii?Q?R/z1jSjqVWZZv/yU4KevMWo6kIGoKt9LxUo699QPm76DmliBF/z327ULqueF?=
 =?us-ascii?Q?BuPLhtcmmzXxht90xLzRSDFjLu2tjA/IyB+qEnLdVZqSOnzfuasPqXrU1vuc?=
 =?us-ascii?Q?lEwMTHLN8THd+EjHYhmCxgq56AF+0DHQxtes2rfCtVB0BKFPKN8MJB02LS6j?=
 =?us-ascii?Q?BETzhQkLm2zLmSeqNt2/4HBQHjnJtkpk80YCLDsc+iLZMs0OqAGQfKiS9cbN?=
 =?us-ascii?Q?Lg5bYR+xdMxFEtknBrWcUnF0Wtg9fWgT2W65Vz5H+xSxtOameMtuc6u0z6Hq?=
 =?us-ascii?Q?u/XNfv44wdtZTI23rmhWsIDzGeyw2haWE53vsqAjlEw26YRIu0wRm1yXfHG3?=
 =?us-ascii?Q?HptodzmA0BnA1GebPmJWZ6QDnOVvqeyu7xfEBDJLXTgFM6pSAoKCEJvHhyEH?=
 =?us-ascii?Q?qvhOU08IwKHoAfbXHSncF4Ih2NfJVLTt8psfA6C/sH87+4JZCtO9jR0/kcek?=
 =?us-ascii?Q?+c41A49F3brsxUp8OrSHY5EADo/lDmpVw96Js7anz4aMadphUZ7VKl4Hg1PS?=
 =?us-ascii?Q?iXu12KpZZSMNcEWn43PJ50kbmH1FzeT4AqPVS9RDK7EBJG5z5Zxy0RIZbAod?=
 =?us-ascii?Q?URvQqvuXO7uLTLVCKHxhJwJ4jV+bxTuKpD0KE/UB0wfCdRWuE1qZP9/Y1Soa?=
 =?us-ascii?Q?ggvJcpzyp49s+edHrAUa1NIxAcEqT0TPe1AKbGs0JitxKBdLu0E3Ovh6QBbR?=
 =?us-ascii?Q?hTWlvZjY2doehilIlw5oUdRSvsAvkQ0OJdfLQfcc3o0g58r3H0uLzRsxKV2b?=
 =?us-ascii?Q?M1Tz7kbUta0tLdpeBFaZRdXTvw0oPVnLv4Mr6Ie0pP20rJS7pxAxAyzn1zua?=
 =?us-ascii?Q?QzbqQZzvtLOfC+xoTKVDZX0PmeeQHwWJmdFzQe8qD0yYHbxXyO8H3WOb851b?=
 =?us-ascii?Q?QIsVGb283lo1kVKJ1YHicZALzTWq+CwcstHdpvzgk53/nz8o2ngbq/TuCVvH?=
 =?us-ascii?Q?Byv/uPp1MDBoYvErXDa585usmfgKiWHhtaAecyQ2NVhMHTdZCV4Tx3a55cwn?=
 =?us-ascii?Q?PNr8OGvNZqv6bs/OZq5zS/wOHLltGxwgbCDKr09gIgpV0C/G8nlF3WNej8dv?=
 =?us-ascii?Q?dKIjae79D9sd/s56wdRNAYmtaI08EwJ5ZKD?=
X-Microsoft-Antispam-Message-Info: mDdaQxcyRUzeT5ZvcK5vw8RHDSU5ohi3VAe0SVEYcaWbbSwBuG1kSsAjfhcHPHvlxuHEERx8qAOp48ehelVpgbM+m46YJMrZsnl9AHQ+aCoCJmBGBoy0nQ85wnSklb51qPuPCkawCrNNawemI3iWFsNfU3P6U+MvPpKmkAcflVnUztNlzVoGBMPrbagnNRc0CaCDYxThAZ0pGdYFZjEmCD+JvAs0QMiGHZePXE/fzHDygT8a1j8kDCs9MM7sOdfWPbeTLGluRG8q5jSpgQNEALFgehWn85S93VGM43Y8AK8dF3sKRMsxxIoTa6LsEQKnhayRRTiqV/4KL54w6d+fnUJU30A2hRbwb5EbMqd7cSQ=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:OiAD94JqV4i5BQxx2j3dyroD5vWGr5hoQHTWEpagNf+c/bIXPGsJ9CkuzSdnSxLMOMKUqM3vDaZesTUWRjvYFcbw4tJP6CITZMu5GqWyC/l4C+vKUSwKE41KNifapqyp065EJdSwTIRkH0DeByx3i0QEq/rbZQBJShAZ7STX4OONNyX7xuGB3FGdOTQ+o1yNBpM5e7TJ4H3GLu52AzE3r2mBFLVSKWBuZAj68smnapB25SFpsaJcQ3LqLnV58kmOiwDw9wiPHyeW3wgJ58l830TCGGbmnOSV6Q/vXVHo/bMvTxpXocxSubpBIKJFHARcXNJztOGo+C7EgMHV8NgO223khHLdLyb5tqfeaGZOGl4qEFwQaRlxD+4B3E8hy/FYSlGaU6a76uLV09Ystoa3fyHOXSb6ttsBW63zp+RMIxgYq/kBY7/3qh9n7BGPxHOpF1ckk/d9je0IOFGrgS8qow==;5:D9ZR/wxyfss/51lygcXQkz6MOYl3MDu5/KrK/G4xZTpiE+rG5WP9n+Td7tytkkrrhphDK0bn8QHc5c2yx3CQ/8RuaPLT1kvii2/KMnp0dvxefv2AAVEghR2+SsmNwb6BzZB1BSjwPYEcmus2p27JhjZaJlB6aHU4YiiNjt3HQ8I=;24:kVqPM1r06s1XMcY6SUWHMlaYf/aT5WA4ats1z1uTz79Nn47Iukr9aBpiK6Pw7zhmo3sway1Y7p3sHL/Opn3BY798nN7Pm56Gx3isvMAZCCA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:PqzozeJATj5j4SiODaYEpY3tnKVnOTLmP91VhXx1+T9OWzLoa9NxahKKeVSkx3Y4nKjbthr8X0jkYr887cjuFQxp2708DnJ8moFIaqzBhnsuBJw9Yt2GMMTJDk5HzY3CjY28WQ4paLjVzqG+gdIMt2wwey5UNHy0tcaNdrj9z+ze5vUOFnvoLZzfJwi7rLjSeJmJeciN6j5iI+Zro+5NY9CakueYoMA3HgxFlNyURzdfAY/HWfHeVOcqf4MIXuzi
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:39:47.5555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1da4e02-7e9d-41f9-7ec5-08d5ecb3f012
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebased version of below patch series against latest clk tree.
[PATCH RESEND V3 0/9] clk: add imx7ulp clk support
https://lkml.org/lkml/2018/3/16/310

This patch series intends to add imx7ulp clk support.

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

Note: this series only adds A7 clock domain support as M4 clock
domain will be handled by M4 seperately.

Change Log:
v3->v4:
 * rebased to latest kernel
 * make scg and pcc separate nodes according to Rob's suggestion

v2->v3:
 * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible racy
   Others no changes.

v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
 * use clk_hw apis to register clocks
 * use of_clk_add_hw_provider
 * split the clocks register process into two parts: early part for possible
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.

Dong Aisheng (9):
  clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
  clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
  clk: imx: add pllv4 support
  clk: imx: add pfdv2 support
  clk: imx: add composite clk support
  dt-bindings: clock: add imx7ulp clock binding doc
  clk: imx: make mux parent strings const
  clk: imx: implement new clk_hw based APIs
  clk: imx: add imx7ulp clk driver

 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
 drivers/clk/clk-divider.c                          | 152 +++++++++++++++
 drivers/clk/clk-fractional-divider.c               |  10 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-composite.c                    |  85 +++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 209 +++++++++++++++++++++
 drivers/clk/imx/clk-pfdv2.c                        | 201 ++++++++++++++++++++
 drivers/clk/imx/clk-pllv4.c                        | 182 ++++++++++++++++++
 drivers/clk/imx/clk.c                              |  22 +++
 drivers/clk/imx/clk.h                              |  92 ++++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
 include/linux/clk-provider.h                       |  17 ++
 14 files changed, 1166 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

-- 
2.7.4

