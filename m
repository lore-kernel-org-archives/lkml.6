Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D021729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K2FMFkEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D021729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbeHNTjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:02 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:35184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbeHNTjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie/kTMYpBWQQqKOwLD4wEyD0F9kpfXMhyme2+Omy+ZI=;
 b=K2FMFkELsyfiE+VdxV9xjPEwk9KboG3JBsjUXC36bpeScV32cmn6yDuRnz3126UuyRfnqQTcn9VHCOVbcbuXZa2Suhu1TRoHF66I8cV0TbEhFteS+sqCOupvUas/oBV4+Exan8mBigduBELl4QL0UEsQOPSScod5BUAaM94kmBQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:50:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Date:   Tue, 14 Aug 2018 19:50:14 +0300
Message-Id: <cover.1534264292.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::18) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1ff076e-df2b-41ce-6ce6-08d602061c5f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:7WQcM5lo+qcgiaei+3+2XJh4u0XkIjIsUeuKyZFL3mMdzGCEb6J4PaO5s5/vIlmue7mPhb0/TQb+fswPyOpcsP9G0UWz4QM1TvGKNqn5U49bRjHBHP2tkSpF3WxUCN6KQgbBnXdBNUxAtsFUeY9+C5TklxmnEXH5cWP5VzIKlpgejNrjEY/vyH3OZ7EkI04W0iNyS5z/Sf3mg0Ih3CND+SJ2FP1SV7HXc4mDrvZ3Cuo9XU5HbbnJ1VJIGvWgBKaN;25:57yjIdSEkPZMx2ZgKHb4oeflRxUyW6HUq5OabLwK5uLdx8kDIjfswFIx2pVVqsUZdVTX3oEmWjwQ+/v7HvaS1bZvKa36BhKOtwIu6obZpGRFSZzUqifxrp+P4WYqEhMHptgDDfLYr/08dMQHVYro+7gpMR5ISlAHdtvHWW+EqSGIkb7JXq01ZhGCiIjnNRcSLVDAY/sDAoKr06DIe9iWOMd6iZmrtTDvFKjTPwbMgOUziB+xatkW/T7ROTbCbt2lKoCK3g5X8prdj5iN5P9pDcis/Oko1XBMZQcgiFMk8eH267L+MdkZMbSUgXrOcyeSq0MpRbKkQHjGPmuDZv8ppg==;31:wP/v3qq8VNyKGmrgZ3CeC0JdKyZ9dWHvxVQxfxvze59s6yatZ0NNzfnNhXd61xo/dqtZAPHLjLGzMKwzv1GOcJ53ZwMjQWW3jfxUHU+wYDKJRM8pw0kvIsWtnmzSgerpUkIvJMnmMupN4ov/sgQyUPQCY2OpRiZ/AjwNGRLi2zdHe91erOkNLyG6mvNdyXudh53h5r2AQYv1yU+mYcfLQvfdPZtcr/aVXiIgLqO8YnU=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:CO6OxP39EOnsHU2ThA01ymlGv8xwQJ7jJOLOsSbLKyE0dx8lVBGI8oTxjTObxgayu4vXKNcoq9kwM4kYW36Emn+uUoJuW9lbfH8fNhaUYAZTlfMCLonC+PIvo7k1cA6I7bEpd1Xm+lS2buHONBV1BN0D17rIiSR5htV2s8AApHMntOfuSZ6RlnRjVpa8fZo6dDyV7VGkYn8NDai9oF0LymKfucu5bShybRyUn+JSWTVsCShsjP40otV8z9vNuMhkVDUczeW0KKV4HQQhilnjSiH+XFSOd02e1eepK3hxWTLQ9idxjhXz+u24FOV8LSiPJBaBCmNVgLCWg5rZiFfe7g1vgKb3SKyoSBm0k91+mqvbf1Tgkagx2Eydef5OxFeGT3ncYrpheVqyxQuadgFtBBdATx73Q6yRPmeZ4xiKS4FjrIoJwKVFrRg66W1lUb+8Nt46XxXrt4ym0FaK7bIfw3wi4SclkiW3PJ0BdzB6xjWKJBK/H5hrYo+aL/WQ19Vf;4:1COp3IB92l9NU30HtvHikuXuVK7btbSngpyaYvQaXUDHkRdQW9eYMwcmagatVW0wZ89Sz09NV+SxgmiMo2iSW6dR76IgCVNbi/hzD/HQo8vIx64DFPq19NwLs0+9faSx0cGj0lZIkUFELdWY4rdgUqpDtm9GK9DcLsL8DLmOliZT4Kg1IpG3DPf5Lr9H0LTj0yTEbhIEZkk8RjvM17jIzeOWtdqXykIFx4xjLxZs2VhMSrCXhUdp31HkU+VtsWQRmVBSMb0d6tiugcjdyLTOfg==
X-Microsoft-Antispam-PRVS: <AM6PR04MB42931C4570759409FC65E7F0EE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(16586007)(6116002)(3846002)(966005)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(15650500001)(86362001)(2906002)(68736007)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(6306002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(14444005)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:oFlKhhJ1G+EpVGb2PA6lWl79w4INO03nZEv4FMgsA?=
 =?us-ascii?Q?S6VD3zFYocrGmyArXEVv7v5VZ4yxO6Y3G65BG9NyvewDIlZTfr6yxgx54MiK?=
 =?us-ascii?Q?VGc9EOnnXusr8eR+Fuj/DsgVNMtIzix2sKGgik/CAJntyasdD6uqlhTssZtm?=
 =?us-ascii?Q?fp7P7IsR+b/fi8mppRCodOWTF4kPrlpRSPAcJexDTRkeXFESiRnzo+xQ4YrJ?=
 =?us-ascii?Q?qSG0sxYEM2g0yHUNr5C1gLiW990xgufumz90tMcQvNPHE4/6qki3NBEs3xWD?=
 =?us-ascii?Q?YdfYQ96rE0LdlUtSWBfEMlUAceN5QlYMBpAuZLNFnzsjJhr3PIkOde6W+NCn?=
 =?us-ascii?Q?PafB+5aDJ75IhhVEkitpD0qK+Hx8uIPGg+rj10fSiZdo7XG35NEheIrRVoE6?=
 =?us-ascii?Q?6c0w1Sboqa6h9V6Yl3GPeHuix+euh9SA0+EWaVw7gsx1J573hnfUt3/FaiCP?=
 =?us-ascii?Q?9kFL5PZ7JBKF7eKtqs5xHtfeHTqSSNbKb/BOMMPI7k1W5VEnPJSgg6TthZ58?=
 =?us-ascii?Q?ZC1U4j8SuDaAUg1w804BTVlofhFDtvPyACOggA8pU1hoTEty/aeVr17gbpaW?=
 =?us-ascii?Q?wMITeieTkTNzl9Ff6GV1pd7pcsTB7SRGTjsiH1c9/q5tGVqA2lOhiVhnl+zA?=
 =?us-ascii?Q?iysQwG1Fa9lG1ZKh/sL4hs9sHMmW+rzVkoLXFjiq9CkowogGfXrnY/y9vJaQ?=
 =?us-ascii?Q?ELHQS3iE4ljE6TJwfirRyOccAI1A4n4fLBS6I9Xao/l+1dXn1nnXBEcbtGLC?=
 =?us-ascii?Q?L+ViCp7+TiklH04rLzUcfK8kOoY7LJ+vJkHFFqJcya0+Qh4gBGvxg38YQ6bJ?=
 =?us-ascii?Q?Al6h76h66VrjseNHwmSxaRI9b0xDmEB21aBzUqp11RLhJktB6cYPaTzlslGN?=
 =?us-ascii?Q?iJoXCTja8/Bor+EOhnjMSedwuD6+VapI5mhzuZRcWCqC/G07sfU48X3TywCF?=
 =?us-ascii?Q?LTXISiZoixaocOu95qmEk4llLMP919Zo22ipCLn1jgEv6w/GFjv7XVJbcci2?=
 =?us-ascii?Q?hQ6Igx2EOgJ3emXcJSj99iDnk5RClSeotM8ZSbE7n6yxEBRL6HeAg9GAq/E6?=
 =?us-ascii?Q?pnpjmda5MAtHTpnnX8Alfcu0aeIuiNI0zro3TRVbqhIXcNFdCGRPVRhYGijX?=
 =?us-ascii?Q?iongZSCTbgkMLTuIuCc6SLYmf//vxGV5roNtFx1CgekL+zbZnpEFW7gdnyIH?=
 =?us-ascii?Q?LUAkfia0dshyILH+f6wyeEpe4Py7FapekXJxHK6SqvKmXjVQiivKHXr980+S?=
 =?us-ascii?Q?TTGwpEDY+YWdudVrvAvx0ozJlf1uMwX1a0SIIKtvnyf60lPUT5bvwNNQmlTJ?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: vjxmXSc3ro3Zc7BLdKEJzZpmqZTM2fz/17/pH/yjUnOmAsTYiae5nVfM576fWACsO2g/1P2gdotMSS2vr30MDscf6eN8OY6AcwnTtR1C2iQtcvcBg/M3wi+tFfjYxVihtwpYY6DVL8PrFzARzNM06WW8mA6di3f6bObt4lIh3ufOhM+pr2hP1SPZhQWtR6wDKOgEX30+R+0LoiWiFLChGbRQocObAruAD7tYVIPUyng+QcDWkYeD79/JTw8todxkNewTj7s9pn1zeTYsNOuFqEQaWBEdhWK0qm7PzZ2VBCpgUweX4TfKxZwGctN8xm3mlNPoZnD/yORMmZc3IVJ+toImURKadevhZMv5WjaYE/s=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:PkYD+ctBi0P+u0rBe0bEKiTfgY8pP0kLoyjO3ELy6hi/tad1IVdF6R0lNu0jmBk0QjOM/R2iaRMLkgl55SFiOhmkx69Szb+9T1mkKf8uAsWMGI6ipS0x84G4grAZGibXwHQShWDpqcD2nVPndV80ofH58f0b/MfrdQ1GsFq4z5m3o5rMYRRUTngeS4zp/5SJIzTDKRmWzu6vhb8sSIq5MW07g6/PPWcKt+DCHt3BV6h2TTDdyC+EOHgt2++3NJ3WuGKn1dtNZAGeVwxO6quAn+gSpHuSN/KVL5SlEyL39OfQSsquM6l4DiTARhtiOlx8cMAQR68iLoBHzHM584YAfRzOOFM5belFfwIdh/v3Aeb/68f6NcjyIOtCiAelAYpcNVNYRcJ7QmASVd6ipx4cqAh9qTDctaJsDzUzvxlv6YO84cyb09Lxa9WOMl83p5GefFWNNjtZ81V0TnLUyuOakw==;5:Mm0PDoknPyAb2U23oXTsUaJRAL65y/BVvqSnceUdeaWUZAo3V8XOdtbq0MdIgXARj1twhcHh5D2pP31zYmyKLfzTlPO+QhEFY1LnkmEIvxmUk3MJZPy1l7ofjnkk9s+fbkVBhv7GnEJFPn7eZToTmuD3uWDYWp4AO4FOx2arOt0=;7:GqB+0GqVoOy1H+D8ZG5TUdRfY1yFOlFc7SQW3eFV2a8gV4MZDETcIHmKbPnFEAjU/sKEwpFwMqw03RNyJdLP5OBBHTte+nhGpNEYIn7y2l9K5JnsHyAoNKg66cDDT3BwBZ0LPh6Q9w2FnXX18t9yup+qFfO958QwUCpvGgqx7VWxKWDDdWxPOWzspppDlcplk3XakQMtX7+kMsp7lpRxIKMBK+76VITxZtjYU6IJuXvzJO9VUkrcVOCgmYZPmMo0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:50:57.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ff076e-df2b-41ce-6ce6-08d602061c5f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx7d the pcie-phy power domain is turned off in suspend and this can
make the system hang on resume when attempting any read from PCI.

Fix this by adding PM_SLEEP support to the imx6 pci driver. This is
currently only enabled for imx7d but the suspend/resume sequence also
applies to other socs.

V3 of this series was reviewed by Lucas but stalled because the merge
window opened.

There was also some confusion about how to deal with the dependence on
commit 26fce0557fa6 ("reset: imx7: Fix always writing bits as 0"). To
clarify: both patch 2 and 26fce0557fa6 are required to fix imx7d suspend
but merging one without the other shouldn't cause other issues.


V4 adds 4 more patches with PME_Turn_Off support on top, using a new
reset bit. I generally try to keep series short but in this case some
planning might be needed to get patches into 4.20.

Since the new reset is treated as optional with old DTB there should be
again no problem if reset and pci are merged out of order.


Shawn/Philipp/Lorenzo: Would it make sense to merge this series through a
single specific tree, such as the one for imx?

Link to v3: https://lkml.org/lkml/2018/7/24/713

Leonard Crestez (6):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  PCI: imx: Initial imx7d pm support
  reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
  dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
  ARM: dts: imx7d: Add turnoff reset
  PCI: imx: Add PME_Turn_Off support

 .../bindings/pci/fsl,imx6q-pcie.txt           |   1 +
 arch/arm/boot/dts/imx7d.dtsi                  |  17 ++-
 drivers/pci/controller/dwc/pci-imx6.c         | 112 +++++++++++++++++-
 drivers/reset/reset-imx7.c                    |   1 +
 include/dt-bindings/reset/imx7-reset.h        |   4 +-
 5 files changed, 123 insertions(+), 12 deletions(-)

-- 
2.17.1

