Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F8CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E24B20844
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9c7gjrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E24B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHaMEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:10 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:5440
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727521AbeHaMEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUcJrMxTIlguw1xb+2RdgubEaqGvJQvmMyWfRvHMyQI=;
 b=P9c7gjrL1bEpG6myi+kuo79V1PGN4f04EWhhWM2HNfdMqPeHx4AcvdeixdUGtgA3yNAtjG7tZvFm0/j0By4hlkIQxNEzjRuGSbd57j8dbiWON7gsbWVXrYTUL42qYM/S2/YZXYWDrUAQr39JLRm+lePrfJydyp+R0jZti/7yPo8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:57:42 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        colin.didier@devialet.com, clement.peron@devialet.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, shengjiu.wang@nxp.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/7] Add i.MX6 SoCs mmdc ipg clocks management
Date:   Fri, 31 Aug 2018 15:53:11 +0800
Message-Id: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42cc4920-30c1-4822-a7c6-08d60f1773a7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:PAop0r4mRtv6ZweDBJBFXhJqaJxJ3c/hrpJ3OR2h7aIDVKrcx0/M1seOmFTy3hnTdFyBoKmYzzdW3T6/qM2dNteO1VnNOeOgAGXIl1thV/nZPDtQOMWIBIRaVjsiAAb0QK7dXr1ZuifmPaC85rJXogTtYFmzhTDgmXcX+Q7Is4rPhZSMR8xAHHRYBuWDQNN9arsVf2OcTUovvV1krs4MKIgqAIuR2B9VrLlyShwYoCcWSqBZXpfgGLM5xE5g4Go4;25:iG+jlLbWIcfPaAJyjQy6DBYsI0617LAaZqtrUUGEhXEJZhHreDFc1agwriBiw1o4eMUYNv1s4SLUeWOSyy/rbpYsLok98lS1KsncK2W8l6ukAvExEwp1E5F5IznM0BghWhnCNTIMzaj12r06FgiLnQxds6qK+063JvwTcnPkGbkns1JH3hZG/kcYfgJ5IVja0/33but7lg36kNTICclsMtt6dac+7F51wGVhmADEagEGTn5b8CRH7DZv11L3Oe8xju3hQe/6A0PYklfm16m8l/vy1xjXfmPvOUNtn36XSbNGUjQtN3H7W9N5DMp5802Q/nEDC2mIwROuHCVKaBMuMw==;31:AAhEoHfXoUqa2UdWy+1jE3+CFfPHTWGDfHRqdzstGizJG5kjPsgwrgEyMNLgCAA7LKpQ8FlAgmt4JEV+ALaN8wsNMHiFNtif+qEe/upXUOCAI5dXUWY1VihTQ9SAbzmrLR3FWkIBKm9+tBCiu3UQmd/HYR3jQEPgcAZ5tpczJeBiyAYfgU+RkgwJd/4hj+v2qFKDByH1ZPpBz9GFl/B6XK7p8KC+sfRGfP5u7SY3KcU=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:1vb4qG8MCcnTHh9rT7fRQ/jjEeOk/SQaAvvrMZJd0MP4x/ATULcxiFWf1DYZkhUzSWnGtl1krb1Gy/C66lh/dAgtlWt8aQsg2elxXzSkvujE5Fu342oBtPkT1hr9370OSZvEjuGUy+7wLAgJYcIV6PcMKoie/+jYmCbyXyWxCe7RdkxWPd+NRtwBIoQ9F1jARM3zI64PGXXQKdFRSaO0iP+JMdJLIRvFS4oIyu/qwfgBPvk2H8EhHXkPDntcrGJWPhw7Fh1G1CP8alfA0aist9v22GsGoTn5UhZAR+zoKaAtHrheUUC0yYY/MThzjxC4+ZJGzcTNEcp/g5+b5QWansO7nK1rxzALC5SEEdML4uuWWFUwHeZOaGZ/9OeVYE0FWq7klIzBK94wx46qrtytSwnkvuErRS4BxwzL6/Vm/4UZJICbqXBXXcnpXRMuQQq+ZWxO3g+GwfIv72uM+/RRemr08kIRlIviIaZZupiZcfrSz2VJwg9Jxej8JeBahJ0K;4:W4Lcd4RXmo3uiCNqpWA35RifNNrsWRrvl+minigqWTRuKvcR+qm2KWsa8o+dQB8TtZvdqiH5AWy30Ict99i9ZbLWzRCi5TawtNh1pZ5av0eFZiS8KF5EFYmJZSyP8G6lww7sRdBcZVHZLepzThfOVdYAQTUY1JwJXNOh/2y1kqek0vw0qRcZimMODpor3rxnXJqJDPyXPdtKvWcbLv0+vjxnyx4Wtz3DCoZnctP4tp5xhiqm/cKmnq69vIlGOABk7BfPlZ0/wmH1lHgTMBdeRg==
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3907185ADE56FD41E1ACAB3FF50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(68736007)(36756003)(8936002)(16526019)(186003)(50226002)(26005)(6666003)(2906002)(4326008)(97736004)(5660300001)(305945005)(53936002)(7736002)(386003)(6506007)(2616005)(81166006)(81156014)(476003)(7416002)(956004)(486006)(3846002)(14444005)(6486002)(6116002)(8676002)(47776003)(6512007)(66066001)(50466002)(478600001)(106356001)(105586002)(48376002)(86362001)(25786009)(16586007)(316002)(51416003)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:4vAeoR34QGFZCKHtgulyvPlcC0yhwz/Me3je9Tk?=
 =?us-ascii?Q?4QQIe5kpnEEW6Ma/8h4c9ikijzVNVpFQO+J0E/U1RP+dO3sOSISlAtbrKc6B?=
 =?us-ascii?Q?Avz3EWo07kLkKMpZS6iz/zpw9QqyROpNpzMu0vX/Wz9zkLzIZrDKrKeNVLJS?=
 =?us-ascii?Q?OTxZKIUrKOtBVeXfZjahYiuV4sDavCpPnRLbekpIVkU+amSSXHHEsjFg6FmO?=
 =?us-ascii?Q?F59oACLa7LbRMbyFvtYVh5hplzkHXajzZEuBgbgD6I4n9KK4wBMMyZNJYGWp?=
 =?us-ascii?Q?OD7Bs4GoJeI5ndFPXsFtLq3W20pFeTKKJYXf0/Salbsii5+EDKzJjWScDyAQ?=
 =?us-ascii?Q?KyRbGJ43tIqL+IaRqWIOX1jjVO+9eG/kktxbojwVhtkRjHPIvhX9rGktTF2m?=
 =?us-ascii?Q?OQpF2XOW8FRJau0pd5FTEKRCnuAhRq/rSAtDgsP3Eyx7YTM8sJCUdWUysJ91?=
 =?us-ascii?Q?fgPHT3UzuLCvTi4Wp+/LBFxXBCN6ZVTQBEWrZYalgPdi+pFcZWgGlDVsnByJ?=
 =?us-ascii?Q?5k5pTahFodmjcxHQ5fY+riAL3iEUcA+Ogl20iq5m740XfnfSbmwnbavpuOS0?=
 =?us-ascii?Q?qagabN8mOv7k50OYEFXGyV5S289Ounv4HAZHWbGLJ+59rR9oO4Cnv3UDbbNX?=
 =?us-ascii?Q?0Ma3DLRVgJcQQR+n1gjR2nO+Z8NsQDUcw+NI/rhazm9B+67h7ml0UKMJEkUK?=
 =?us-ascii?Q?JsoerKEshl0l2NhJuGCFeh5l5UcaiPJhnayt3YF2pc+4hZ3I238ZWj/KElH2?=
 =?us-ascii?Q?u+57oJAz1G6kYoK0FDwQRWu/WMxwo1IFHV2thdHjkWham7eZAnmvPe5c5lZS?=
 =?us-ascii?Q?lLZzvxaLLJh78ywD6cPJy6clyEkeCa1+9Q8ujFvJdKIt6sO1OCzJbvTXcY0I?=
 =?us-ascii?Q?e73rc2ed2XUiSA0ref+HOGWgBxqgd07uDoHkPnaL8fEEdjVwrgryl5yx7t9E?=
 =?us-ascii?Q?GrDYOAfTwjQzc9E+uwhANoLAIfMaQxZVc5YbdAXmpylsCRPTdQ9jIX5d2Exq?=
 =?us-ascii?Q?szt+3THr8ws8FEZqkWcBJ0XFbsO0v75KceupDuAS2NIeAF/Aabn4psWrVJjb?=
 =?us-ascii?Q?Z4B0X8CGyAleVQoiiuvn8PsFmVPXlxyhmumv0GNHeV0VZwNt0V97grHEKFre?=
 =?us-ascii?Q?6OUJVsjfZeFA4NZQKkRFk1Crl1NPegsFqoIB043eDhrffVMZ0wkRBeTScMCO?=
 =?us-ascii?Q?78x0rXQKcRLuGZNM=3D?=
X-Microsoft-Antispam-Message-Info: v9loMSSZFsgANGXuteZNGaLwxeDc9ej0FY6r/oRi1zs45OUkuw3q6PeFCLML6cwHxLHBZMGURa16L9T3co6cekAg63tlo2B6G7q9rvSaoRllJtGcQJKH1Tw+JbfDYO7+TaGrIrYspU9SiZkAs5XrNF84p41oOzgTMPjSYwHmv7M58PVgVYDDNNwHtkxZEmxzVK6kyepWgxZd635wFDLoNsUroCjxfGL86pOzgNhp/ppWeWthOa91ZaVg6R+C7q+kw6hm9sKqWbR09V5FoC11kZWp28zwUQHOURngBBAft/8mj7GL0NhYN7Y/K41zHRedOooe9ufICMT4dYUbPPUNMbBC2cv8Q1SsIsCQYQ0xpHE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:pKfN2zCvMRJrq+oQvoq1NOf/5BYpThbLq2lsXIriJUlDiHNJCmLqAmSAukERK8I8tBN8TEkRvfeeKowlerHDFFL9rD/6PvbCPaGjIwxcSF0VGoTkC1fmAHrUxYrp+5gR7yCJhKTijiRwPUqOy301meTVty16o2RfKAiO+JHvAMOwjgbDqC7We8uyFlMtIVjAfVzXme/ptLDjjcykkuE52DrSJD8B9EdGLekZUdQlF2xoNIr4KgFE8rmbj0hLpWf/hlj82/PKi7gBy2vhxRdlE+kLy+qhZCeUn4xiuqxbMrQ8njHA7/1m0FXTjqrw5TndwdmEGlXweRCihIVso6pcHMv1MR9/+RrL1fRNZJgLd+p/T8J2LnUukcMhmOWC2PU9mNsfsI6ex/OXPdUhDeGCyJgzNr/jYJlvq9Vqts27xewTAFiXTOnIT3DJcRBoicQT9vnolRZBpzlCJgAntPn40w==;5:xjM7/Qox24BWi4tAkTy9hZ05CQfarQwbcFxhSBkb4QNu6Kvcwyg9yJBADz3Opq6cb3vA4zSXlEaue1s0iU9pkXPiy5MQ4GXRJ1LEialDPdheVVHbxyn/zxrRIX4Xfs5i55vhEaFkEFFcOZNFJ1WSw76sllhZ/2vtyz3AZzZyqrA=;7:Zjs30eBZersQhROkqfrt2IPJTdOAQUisAD1Lfu/3lPe619ITPsFxtS4BhvvZuudk8112mw+g6eWYW791zuLpsEpm7RGkSOJFhbk8CRdzMNlohSFICnu6tjlHQXhGtAmocZr/gctoBxgpHxquyO9yhBipLy3hSGB+fGOctsqaRZoLJ4jenc1rEPOFLJiiJXxsxdk168D61CJK1EhFBr6jZDs6RGpC8fPCQUkjyk4Hf3zCU22Grb2s4nQmrnNlVl0R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:57:42.8065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cc4920-30c1-4822-a7c6-08d60f1773a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6 SoCs have MMDC driver which will access MMDC registers, and the
register access need to have MMDC IPG clocks enabled, current MMDC
driver does NOT handle the MMDC IPG clocks at all, most of the i.MX6
SoCs clock tree have MMDC0 IPG clock registered and have flag
CLK_IS_CRITICAL set, but some i.MX6 SoCs does NOT register the MMDC IPG
clock at all, it depends on default HW status which is NOT reliable.

To make it more formal, this patch set add all available MMDC IPG clocks
into clock tree, and add optional clocks enable operation in MMDC driver
to make sure IPG clock is enabled before accessing registers, and passing
MMDC IPG clock info from device tree MMDC node.

In order to NOT break old device tree, this patch set does NOT remove
the CLK_IS_CRITIAL flag for MMDC0 IPG clock.

Anson Huang (7):
  ARM: imx: add mmdc ipg clock operation for mmdc
  clk: imx6ul: add mmdc1 ipg clock
  clk: imx6sx: add mmdc1 ipg clock
  clk: imx6sll: add mmdc1 ipg clock
  clk: imx6sl: add mmdc ipg clocks
  clk: imx6q: add mmdc0 ipg clock
  ARM: dts: imx6: add mmdc ipg clock

 arch/arm/boot/dts/imx6qdl.dtsi            |  1 +
 arch/arm/boot/dts/imx6sl.dtsi             |  1 +
 arch/arm/boot/dts/imx6sll.dtsi            |  1 +
 arch/arm/boot/dts/imx6sx.dtsi             |  1 +
 arch/arm/boot/dts/imx6ul.dtsi             |  1 +
 arch/arm/mach-imx/mmdc.c                  | 14 ++++++++++++++
 drivers/clk/imx/clk-imx6q.c               |  1 +
 drivers/clk/imx/clk-imx6sl.c              |  2 ++
 drivers/clk/imx/clk-imx6sll.c             |  1 +
 drivers/clk/imx/clk-imx6sx.c              |  1 +
 drivers/clk/imx/clk-imx6ul.c              |  1 +
 include/dt-bindings/clock/imx6qdl-clock.h |  3 ++-
 include/dt-bindings/clock/imx6sl-clock.h  |  4 +++-
 include/dt-bindings/clock/imx6sll-clock.h |  3 ++-
 include/dt-bindings/clock/imx6sx-clock.h  |  3 ++-
 include/dt-bindings/clock/imx6ul-clock.h  |  3 ++-
 16 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.7.4

