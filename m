Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B626C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5D221565
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="auIQ2hHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5D221565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeHTKaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:30:55 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:40384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbeHTKaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+9DndZiCQchssjHkVQumDiyzajYZSGP/yi0gueuhOE=;
 b=auIQ2hHZHdGf1cxnaQ2/tudpmkA6VjDgTQ5kxBknTBOgCaLK9xNj38aI6cC0vQDSWe2/Ecvs4GyRyaWfPCrhBfIUgchmrf44n+QS3tQa87fWz8Lo+rw/LbCc9aBGajptB7fdxe7W8nd2/0BwGTJpnRwu5BbR6WoxCC5+rHSeHFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 07:16:18 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v5 0/5] Add i.MX8MQ clock driver
Date:   Mon, 20 Aug 2018 10:16:02 +0300
Message-Id: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998617fd-f169-4d20-3884-08d6066cd457
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:N2ohkquQCF8msMei/NKkOLQ8WpVZpGDQ0tnmWBk+TRXFzKu6E/ZX5VpntU+npIdwH4qLIQKHKMj1x8hH7ILbUi3G5kjMEmmn4+Fyg/mAXppPniruNE3mifDOpyAIKZkBMwNxPgDDpV8uHAuO8dRUpjpFokUM4r8MRny/6eFnD/A8Bukm47J0xUWwgKFKz85JKaolpHViHwEc6hEftMgzuzRFWJvXsa/OdScrbWwbLQXfGbFkc8Up5bzdrmcsZiaK;25:h4EW7gU351BZAjv5S0qKVresMWocxEat2Oaz89e+W/+EqnVWOs6ovW2f0tp7qGBvyghXLmqWXtyFkL2/IPkf1CD/jSJfbdys486Ci9yhI64EA+Ka1C7g/wmL9sEhdSgrpN6UyNPAQWpcbPZLKpHeA0zgJjrzV+O/R0vLoPr144+vFx0zmPX88jStLyAWWUkmuywVojuKQbnGAKNj1jhnSCRs8O4WCEnR81Zxzml1olVuOedNvqvIwOkMZh8teOyX0osMXZkOgkD0DRuvYXRPTBhvNe3qL1nZ7nKs88pYOcg+crIzMWg9XFLZceY0nKuN9aROaNymOqndNkbboHADXA==;31:nii4oWXZbRV8Pp7Mkqqt4KZeCPedVxJMk/w/FaToe/1K0+eUm9uAS1kZYfLmbu7RZ27xAg8ub4bf5fL/QZDPCM1umDCj9GYZ6Y7vftxWL43ZNg902Hx0YfEw9ErHzwbv8OE6Dk4T2OgYKPmzejXeTu9JmDRQMxxBl5goANV+uEZvQ8O1Lk7trdy2ixk0VWRQ391Gqns17z/x+yuDg5urU/RHZXH0QEnAqVwKvtaUN9k=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:Q6csSJrBPHiIeDB+L8o/BqnfCLIkPwRN2Ns+BcsTn4UuL/K4/SO8cxonlF4Q01khtKkmzoiExnAgYXnHexJRj4pozIKRd2ev19dUmYa4JnOBEdcqcqr+fQfoEonAOHOwcCackmwbIrHmWr/yOyA3UXIdoxXcddoWC0/5o+cWDdkY7D9jldkKfyQCMLjLAkLc2FDve4F12POpUMwhjD79tcD11uERvePi41O6mQKDmXTmPOiPhnKQmeFog9FsFJPyX4fkwHd5wGQezZ93DJCB9gqaGH7pqMP//+zKXiAHjAT7qrE3gO2KkZj+VPucgP6tt5oJLQzqHCtKqwbj801jk89X1ifHIrHsipHKRwZhiP6557ifjSveW43znkIu81pIEguQO+o1xcZhIqd1+v4Vp3kMN3PsSrZAgC6vjaLSBN2JfwWnYjXjG5Qf15mbjrxWVqRi6y+mbH9GZx8+OW5oJcdzvrUHnWpCb9XzUrnB04ZhyOscgoCKpEFfK8h4uVju;4:nWT5IBkvrR0jsfFVVPpB+FMtOpz0EjV8TCLCtV2gTHgHAKX9i4A5PZTtncqNr0UeJvR87lA2dtAHzo6XwvlRWlbJ8pLVLAsMhIqyEZdpiVU/1Vi0armBckDyCPyLzzuWL/pKWnLoA6ElXeBaZepxxHVW9BqdK6UC2c3OPIbeCAoOe+XSDo6gRz3Wwrsgu4LW3SWwEYMoObBEWr39dHD5VqKDfl1e9I9Yd/cFVLjpSj10xPaJ62VboEFiHhAU3TvRPsaiAPAXXKM24KnHnnaTBw==
X-Microsoft-Antispam-PRVS: <DB5PR04MB16083A25FB35E033E69E56CAF6320@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(7416002)(50466002)(6636002)(6666003)(305945005)(6486002)(14444005)(48376002)(4326008)(25786009)(86362001)(51416003)(66066001)(81156014)(81166006)(316002)(7736002)(47776003)(44832011)(16586007)(110136005)(52116002)(54906003)(8676002)(16526019)(478600001)(386003)(186003)(6506007)(6116002)(97736004)(106356001)(68736007)(53936002)(966005)(105586002)(3846002)(2906002)(36756003)(8936002)(50226002)(6512007)(2616005)(476003)(6306002)(486006)(26005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:SV1lYsi8pcxY9+VNV2IZ1ccSqfgHTijenO005E8iq?=
 =?us-ascii?Q?WCFDVuTarNEaTTLpbKzFe88DF7X2XidDLAYhNu5xCIKWS/spY7l6Z08gNZw7?=
 =?us-ascii?Q?rBd8C89HVXgjnEfsds9YAz8duGdz3ngFTX+qlwjTzQom0YbDpZW4baGSXWO1?=
 =?us-ascii?Q?k9kS8zek4RORTtrJzatk9xp/QFWJKbizBa8XcYLAVFJWQNU7SzK1XVGnT7xj?=
 =?us-ascii?Q?N7F8sGZVXIonj2b255c1PF4qM/nSojTATEwMlQJMnOjXbabf5GnyCaHQE556?=
 =?us-ascii?Q?mmd4GqnkZvxyBK82RIpZrt9gcxXTmUd86OTzf+WjX0WRdYrSNp6f47aAxXi4?=
 =?us-ascii?Q?zA+dMnfvEtlDYM034kOu+OoummTLtJnGl6aA9UCWl2Bi+3rUiO3rF0k5E75g?=
 =?us-ascii?Q?rMY9uxNx2l7FbdIT4jEKnX5TIdW3BcRzwCiFoCpardn42e9tT0mTJIKXYEaR?=
 =?us-ascii?Q?U42G+hFYShGuwjG9y7ajXSs4XDD1S7R6LD1hrAw5pijTs/FiaPk1jkxkdibu?=
 =?us-ascii?Q?Hd3xlIWRjQEdeJaqqNP5/geFyBB1Lbpoc/fLsxKMctBm5ReRvx0kzf9Xco6w?=
 =?us-ascii?Q?ifeu/BvjZkCmmHkirShefafXmtvlcKF3EgKHdQGBvR9m5uFZvrfZ3IojkoK8?=
 =?us-ascii?Q?hfzXdfTbqgjgZv94mYWmjt/t+Fe5nfK7EWAnQDm+essOmVAgoR7a/Ae3NCYD?=
 =?us-ascii?Q?sZfkVmitIIorvCzC7TBuGpAfC0coAHn0bia0J61z4gtxPn7dzVDuYWK3V9Mz?=
 =?us-ascii?Q?eWOXO/gDs2gmOOx/T6H6eH/IGSFmaGYFu+M4sepqakqb+7lTDnhqLU40kttu?=
 =?us-ascii?Q?Q0PYaW+PVOA3S4kQlM7iQX9YfCaGnQhXWKmK2ME31ukkF2XKdirl9deOeycp?=
 =?us-ascii?Q?DbmGDvZBYj2hue5VzBJdOt9Vq63sNsCzPA/PpNBao5LMKNpqDgJtJU31NeAg?=
 =?us-ascii?Q?t65vzt0/4aA9+/kQkPWYvlEr8rvJ1T0JV/txEfZI2iHQ+OjbuiT0oJC8umSH?=
 =?us-ascii?Q?0R4roCmnIs+Ncisl244UjWHEtT+B2k8IjJGnHNjS9rcqg/Znx/IwcEPnQt08?=
 =?us-ascii?Q?rI97mlDmXK7Zo2jCKDYks07SjQwDnxEPImIUKOeB7w+Fd7JYqZ727kE0IOcu?=
 =?us-ascii?Q?iaGDsrQI0+SHvcy4HqPQ1OrdMkbzdqQkAn/GfSKjy0QWJeek26y4tYAT/JLO?=
 =?us-ascii?Q?C0dmNA26ZahrGOGBroFtcI8ZBvy2scuznrUJ+uCOLGvB1ohizHRQhDmpuDMj?=
 =?us-ascii?Q?NYiFBgEFn5bEWk4q68=3D?=
X-Microsoft-Antispam-Message-Info: /I5KTghFXsSiM31rEKpJ2YmVHlG/aPNQlQ+FnhDz7sKnQxjZOWaFoxcQq4fL2TrgoDBiBKIjMZogNKZXbYZegsq0XeG77YC0XUpnsAzDqMVKyi1MoxEsxPpVMMhStom/fRZmsA4Proncpvc/NiDbYONnXSXRRE4uVay5IN4tGpLqLum6MVXTbA59ObvOLW0nxUOECYe/EykYXp7tEsZ4c/So2BtZOB3iOxmtvE/XafTYTgG0yw5SI9Tdb5IwmyP/rqSfJgS8hTpefkknMxKdZ9KtedSaiFSJr3pE4kLKNxAnszUDyFC1D+E1IQWUQGWtiOZN8gbTUb4ZOnS39xcQtVtUicllWv110+8gkRh4n00=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:sgk/DSy5GVAp7/0I1ZcVj7idyKjE5UnQuQ761fWlsruQS6vGeNH0MRv/TbLwh/LvIy5cE0YjQ2+xKbtvWcPmn+laEjU0g4eyCINM3OHuT8P/Gdj/LqO1l3aXlpozZzleW+Cz/4JW/smGHoI2ZYyYL+KLTzI85P61OBOlT65FBLgBnire2ReIlkaI61DA21BUXJ8NZw2P36QhPC/VgZMxfWd0onFqgHp7JDKwKW6jX2nAvUNfTqZj9oxsKL8PAgOnCZzZaa9vJFSWcfZQOO+yI1u4GXEJGWnAUC55ks7uavD5mcQjiqotO1Q265QQujyk2sS3lnaCsbq0h2KacAIaqd2l0lAq45iWfs7xxXSsWuwISGuqgM+Pla3x0LDL0qHSB3v1M88KA+mjoWaEnvE1SN+g0ZFLwKlMmpEGsmv7A4JZs600uF+mvxq8OzyXbZtWdGIlazUQHdVQnHlYRdyeCQ==;5:x3yzV60e1SXzrOtW2Kl/R5txbUqbYPnN9MoyIUUSy+qINNPkLCwiMP7dEoaP4MTwszjQ7Aiz+aI4jRF2fk7ZBL712tGZBg8LQXYg+p90voaTy53t9fwDzCCm50jhcjaKDJZuA+nHHf/LzVbubNpTGV/v0oPyuuu1RyVkXXImGj8=;7:+BVu4MtU66eacQCOD60fUnhsl633Fe3oKi/0JiIzp+gMvf/t2nVb949b3rlRGuL5Em+jtQfQybMXBu1h0dryH91u+Odbv/ZHboN9ZPZIiU2+PRZQLB0cXyzivb0T3Vh9FiZ8ccwTqH9gWCNW/HjLpHOkHzMbyuTI4w6jR62L5p7wYcg9opNWOOXim//jpKgyp6exHDB3pfBBoo9ujyN0KGgxlYuDmZkbfEgxQxM4sFNXWvhGZNGGF79BvhNzxSWY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:16:18.9473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998617fd-f169-4d20-3884-08d6066cd457
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resent this time on the right list (linux-clk instead of linux-gpio).

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

