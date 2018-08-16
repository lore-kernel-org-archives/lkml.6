Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6E0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197BC208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q27PS/N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197BC208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391998AbeHPS0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:26:53 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:13040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeHPS0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qriXcPEQvY70TFT6EqgsLIONaZI7q9dtyENROle52E=;
 b=q27PS/N3u9yXXYefnwoTZuRTjga56u+V51bbmnXqbL+3LYhlVZTPCBzj1y+EuahVzOiOQEm/0ONR6Yk2KqjQyd3yIsTOWkikOfnHzEVvQebpsFAuru+zQbv6zWt4twj7I8qF4QzwWtBkC2nximCU5v8B2MVZliPWQ8dToCcxCrs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 16 Aug
 2018 15:27:35 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 0/5] Add i.MX8MQ clock driver
Date:   Thu, 16 Aug 2018 18:27:11 +0300
Message-Id: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0020.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::30) To DB5PR04MB1608.eurprd04.prod.outlook.com
 (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2500ac2b-a752-40c8-045a-08d6038ccbd9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:cyB9YPDbVE8/TXMAWQVO1o3/MApDBTGPH3JIJ2eNK7V8YFN2vGg3ZscGR7qaK9QbEaJtOO1aCPqZrA4+AavXJqrEmnkzsVjmnpNZYYl5W5LGURgtHj6vwSpYXVo/qeshVJmNl5LX1CwhPbDuiBYMA4kzRCwi1HLwBjgwHhQkP5U0UpjSPDmtGj6/iAyEoCu9aKEX1uyXJVZjAXRfIqf4oneBCUR7SDwt4fMitg3bU1RdWskhIw0L8KXkRV1l8Qvc;25:YkATRuYR2tdgOh/F0dtDeSlQWvLX93mts6u4mmybytoB0LrbH/XG0r3aPlo+zWYy+Ycb/ujvvYF/+BiGCvVdVLx2sjiIdmQjm+FRGvnWSfMRxHZUEOQwYqwdMErvoadSKbbmyHU5KXQqQac8BIu1Fx4qGr+UYADYYhKSqH/26wO6e791/jHaSqP1JB8mSFYf3Xy/tMyz2FMWe+APXfoQBLnEmtkkNGNCqIBUlWuBl97Zvy2jXH/+MgRF+T7HxCex8S9nMfCiqcNr20skeRDghtTE5Yp0I8k00U5Wkv67Lh8mq3daSb6KRsuVs3K9TrJbmHNBXHV77OuTluS1eW2iXQ==;31:p39wM1bzFEAxdkMrjWN74RX/qN0EEFW1MA555iJ8+uyKaurvPbA/gj8j7jE2Ci7M6n7gdsJhUPn+w9Sb/g1awel4UolgqkX2IEojlCMXcIwld3OH1pLhiznTuwxwRy2u70xv+ToTZpmb1yMUOcAtV1JzuPl0X0zgfuT3boWC3UQEv3kMflkEk7rJRH0OI5ZNLwigXWOXpE7OcFVg80+Qaw9U1AL7Gwz3RC6ywmRwdV4=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:L99anRQ5f2ISZwjhnJDGIDrb2NrboHhBBc6VjtDt6sI/BScDvdaTHlOa1FHsPFAkXe1XJSrPsHD72fkWnPOcbBIxCs2qH2cTtdmIa7+bzA2JI72TWKOZD6a/Qp2RQUM4FzLV4Zphlf6wW5JKpsrkYTclHMRpAmuR929rKII5hNPtGJlFVM0eBwUuOLxDp34ss93VcIwT0YRF4c6q8pXmB3lf3vtk17YJufmvQykezjiUKZD/0f1NKzywnGRSRr2y0clvw9v8OD09zOUXrHCfDdl1E2u00ACAeGyyu74DsUkV91VpDCnjFTdJgD77RcJXLawPezAX/lJ8S/7BsSHOAdpmrndy7bLcDJvhus8wfd6gjC/UgGR5VIMOcqQB600A5/GXZnOXWWvrRxgwW3uYhFX9/looUns1ude5VmAJhLimCO+9SBB3bAzI0jWzQrjIlnpQB15fYCilPntx6R0h1+XpNz5NwoWydUMipeG3DJprG8kEE8nOFGqo9/PXW8oa;4:vXNghEGRhrK7himWopH86IW1Y8YA/zj44123ZrFApmLzcjYFZBfMCIq3j294MVdCMlpyCwcAAgYODf/NJpzUlsbkXE5snjey7aoN8FxvGk2hKQspE9fpzj8lZaxlwcNvuWHYJeXdYqwZfKuIbqQKqbySD+6Y7E6jAlHIVcFbk/dhlZGdLnnBzeg2r6tYPr/4/qKnxaP14eUT5tv0t4wuC14wiTeyeDVcPpyiXyEWq1Ks72qjJOoY8sKD/n+Q4008Q1o38VOgG4apd807tZ5fMQ==
X-Microsoft-Antispam-PRVS: <DB5PR04MB16086879EE874D06296E3956F63E0@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(36756003)(14444005)(476003)(47776003)(53936002)(956004)(386003)(6506007)(6512007)(6116002)(105586002)(106356001)(486006)(2616005)(2906002)(3846002)(305945005)(5660300001)(7416002)(6666003)(6636002)(6306002)(48376002)(50466002)(7736002)(16526019)(6486002)(44832011)(26005)(81156014)(81166006)(316002)(8936002)(8676002)(66066001)(51416003)(25786009)(16586007)(86362001)(68736007)(110136005)(54906003)(4326008)(52116002)(966005)(50226002)(186003)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:JSG6+HUvoXAsLZRVy5JXnBUTqAt7tAydrispi6mP2?=
 =?us-ascii?Q?x2Ki+y3LYdoxYT7xHCZE4TpDH84hJBquwsZ2p1EgbFZY6flQzpxrbTG69aWR?=
 =?us-ascii?Q?oKn9ZXwecOL/mh1hnKM1EWZV4cUCCRmzlp18MsrZWBHvT5846KFBr0dFJWhs?=
 =?us-ascii?Q?vec48vFK1f4y5Z9QFNEX0UM2Y11mKXe5CUqae2uZ723JxSJWmfoEYHTGNlaF?=
 =?us-ascii?Q?zL1VbKUCy7aWFdC72zHilZIy0Exui3t2WJVY7UAgydTDFpSZ1lcQUAinQDcw?=
 =?us-ascii?Q?J/XEnKRCNmFyPYFNR1WFcRYb4yK/V8YP5WM28WxqnHqrbyh9Xp3CSkSIi6md?=
 =?us-ascii?Q?4MmUdy4kdOicPzc1kcLUNJIPTWNagHEqoJ0tU4H9gG/Lls5uvrJ+KzqzDK9n?=
 =?us-ascii?Q?O6BznXD43ix0ZCnEoi5pgBX1EFUd9SN9ycUsTJSI41O1y6qSRukkRES5D+/M?=
 =?us-ascii?Q?GnM1ghXX071U87Wz4TyA2o8sPZpz0KzFgUItAn3cBisgfm/2vK5auhfAkUEr?=
 =?us-ascii?Q?/yU8CIXFSrgYtMyFXNXlcybu6pZYTYUHhFhBRFe2OoWQtJaorTPpJmjitcmo?=
 =?us-ascii?Q?r6glLwoXvPJORclroA25hHXHp+co4xVN32FQTnYYNuooxuzrja9FK4axa9pC?=
 =?us-ascii?Q?noJ72iQx9Ket3hzXUDW9dDty/zkDA+Q3FDTFApTN5WObpG7DqIHUOOlcq4rj?=
 =?us-ascii?Q?cYtHN77VwyH2rylpTTtTVmJFqE9ySEjvynpmrRTocv4vj4VniVSOBonCrqH5?=
 =?us-ascii?Q?/N7WQyxdADQTPaSO1LN4TWvIWXyXIX5KBiQM03JRJ5g4vkkHOIo8dXFLB0rg?=
 =?us-ascii?Q?W71mHTv1ZePndkCGgKIHNcTfKxwdutIZbf1t/gml7fP5vNi4k1lk+TJmfGLC?=
 =?us-ascii?Q?t8cY7QAcskZADmTtYngrZyHHLcunzdqu/fNmnvhhzHBg2gZ38mayUsnI3iAM?=
 =?us-ascii?Q?WxetTy/YOouR3rJgR5eXPn04UpA8yFo7t0FhAQL/Rd6Ao/8btq2KDDMKNpNr?=
 =?us-ascii?Q?VEyNZu6Tldap1dPKGNdYRGrK1B/g4E5HUdOcsVjSam2vg8fJsTUbPsVVMnHw?=
 =?us-ascii?Q?NUQAcQjbHC4aSGR8c4N98OUwJPjnT+elXxp0i1ZiLWgC43gm+uKnNFker1Bc?=
 =?us-ascii?Q?zoamcrdJwnn9xuF6cejBiB2Og5bJB6R1NO9hJz34I5/ksqrpfQTv6cACXhnB?=
 =?us-ascii?Q?zsosP4HNp4ikr9y2IOzwlYuBheLAe7h3I4szzNUn+5qQg7rFMcsYBEN4fE0L?=
 =?us-ascii?Q?KnPAXmxFJXwoDKOcI4=3D?=
X-Microsoft-Antispam-Message-Info: rUY9Kddhym9FdpMsf0sVtWZqGF1Yt0VBHofpLmW5Xmj6yQXpVXzTbkQIgQMdsEbroi8U8bxs9hV+oxv7ur6yi9bOZuQi/EOltWbYHCT6zETRGNTNQyVblanEhd5yyMp3JQ3yRN1X7WhEs7/84lZugMlV7a/PyHddAB2THHTRZVgyl/U1D5vLYbW7N1HMPhKAFMi/OH+DS02ExFrdhPQH607N2dD96BlWGfXYisVzgBnwuVkcexmCzqN8VgnRvjHTkWXhdXC8OLAyoZ+xOr7Vx/w44vOFTTN9IqP8jGlfkE+3m92yp2raI4E7ja7SE5YAF9GjLxVcNFHJmK0Et8sYrjL0AyHGcypnvx6SiyOd6a8=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:MV9aPNgdjas5DZ5tIDCGZ8ezFOb73w+5vjZSr1aqF2eWg71jGXuat7AKIVkSim7o/VoxTf8IFN1aGTlV1nO7b9eAs4qNKsP4Qq1yXbqfitzlYYJ+icnV+h6DmJ/zbTL11guyBhXqFg1m1VSLkMjhwPqz2E4PACOZGpWIkkuH/gDeqGoRkjZnm+qvJbMA8NxKLE9R1rwXPi8S+OLTA9h1RhzncGGs7O42R3lC2XppOgDr07WFyCFuvmhn6OFKjx3jlXdM3yrysr+lzVyK21ViEXPI2EMRnPlIF26+oTB+eml7UmAhXz30weEOA0KeeNNcguT9PRdvwJ9l5V7j8CgeIN8D1nDBHvJgijTMDmR1njU+Q5Ipofgtftq8BzYWdEhk3I+WfNiL9gjr3bTLGX/Wij+xFU7AAla78Gxu5tkdr++rhaLBVMRSprdZ+FGMMUyXHNdJUn3fo86z3XTfjTbifg==;5:L6g0zvG77NWZly8kpxXz86OuX42cqcBuQ/gwXIPX+1Uket0AB1gp+w4tcKWB5NFejS05XLC1H3tEBtn46wmfiefrj2iKoXypKzncAT9stpb9XT3M2Qu3oJuekEkKRieL9RBhgG1jutXvit03NAwy6Isw9b3j7mw5MCEOIownRZA=;7:FZgw2Yy+RsW5zS7srKIZvbTbSCmk+Xaj51v/O2CgebLZgRnQiLOpXnLpubBqPkRo5bH0jvLpi9KSweiqnCTEMTm/98qLE+QzedUb1sAcjmr8YWtjQoJ6SL7VeCMck2A81uT5Kwf7S2FBIK6JTTC3iOoUUjJ+isKUp3+hK8M4urzxoeLvRwWJaZyBiMYM/PnKXOMmG1FaGsaycvd9s+JlgJsoTi9NcWET4uGANHpTtYv6PAdyYVQ7c9qjPMU/mDHf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 15:27:35.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2500ac2b-a752-40c8-045a-08d6038ccbd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Third version can be found here:

https://www.spinics.net/lists/arm-kernel/msg671015.html

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
 drivers/clk/imx/clk-composite.c                    | 471 +++++++++++++++
 drivers/clk/imx/clk-frac-pll.c                     | 230 ++++++++
 drivers/clk/imx/clk-imx8mq.c                       | 631 +++++++++++++++++++++
 drivers/clk/imx/clk-sccg-pll.c                     | 231 ++++++++
 drivers/clk/imx/clk.h                              |  57 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 410 +++++++++++++
 8 files changed, 2055 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-frac-pll.c
 create mode 100644 drivers/clk/imx/clk-imx8mq.c
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

-- 
2.7.4

