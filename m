Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA320658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EODYBmoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECA320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeHaOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:38:51 -0400
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:51264
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbeHaOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVJYJByjbRmFg5/E79vwlz8FXMJO1aWss5f5vpPCN9o=;
 b=EODYBmoYp0x3OKNk+gbaeAxeHYixv0NhK+XBX6Gs66yHGduigN9md2RpAVWPPuSB5Ub/+SzdvyMe0747BAeAoLeEFdESnWGo8CMVJzggnIDi0ZbIgs/28j+bcbniCv5/sZN5+axwZRqOdEUk7IQdzkIqh+X4JsX12cTUU70hir4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:31:49 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 0/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
Date:   Fri, 31 Aug 2018 15:59:57 +0530
Message-Id: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::26) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd751a7-7223-40e6-62f7-08d60f2cf87c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:7ESH/ngxyWItmlJsan3/ABUEIjGvv6MOKw5ByQfJD3+UOkReN+FGQYBMWajwyMgOx520Ia90vdjMYCdX3rgMrxvz2NKxoKQY8esNcP4UfhhrvxxnHcSEYOZmPKLGhmXezD1kxj0Oo04O0mXlsrceneDQ3sSp6pcE56pxKQHDZEAOo+SsfMl0MTDFzA71Kyx1TMH7WYyR5odJFKWYyYlI8LLvCjObsh7cpR4dhrbuVr7ZDhx9u4B6hw1eCev9y+Z2;25:tL7gJGCVdE4E4Y1nKce1JrdYfUU4LLgBogEFMN6v+EevGfmBPiWk3MHyDMfROKOQ6P8VU98B0SjVLooceH/EeEBwVsJwOJt8tvpzVXPvbiyvE5Gr/Qj2ZUKBAuylPGq6nJ8G5nWHS4GTWsELPYkWMojdaab+CyJFMCec5Wht48BSrE3WNyzqHkcsW72p6oqclcfH490zsLuDl51Fh8jgDeyrVNdITjRihnSBjNU1YkYquu8VMdyBtsrpLW+RzcEXsVWHuQPJI9F8eOI1QsEr/JLt1oPTP6TUlg9P7r2ljoXtzVovKGpdzCsl/nQPvdCy19XRxfsVvvkeJjyK2wr7L966QI3iEBNNSp8YvE3nPcY=;31:C+1RYWHInXWm5bM1dUZtWCKTpcuwxiOJ5+4ITTD+wzgA0jMAoWtcWMhGxPxK2NPnMP0TP5h+Qx+wra1hoRyXWZ+rbPhTvmitDaHV+U8alu2vZlNKwUXRybDOo3b6iqBXjL5oOgzbrjCN/QxWhzsRL09Gsy1dGJ/Xt5ccQIdc8YsLcdlmnVbXdI25SGx8MX9sbbZ+Q4GtRx4lCJZNdhGtdG9avhyXVYzNFGGHg28A1Pg=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:Ib7QJ45ioGnj9QjIz9owR5XDIw8Flw6FuRQ3FuXMpeaPtTe1+f5Cg20SlM1fHq1qclm3YF3nthwzJ55/Y6uzHnVuu1ha5Cuv2sDBHc/kC6P5sGrkQ/iHJSWAuBh/r+Wi30Jjp89QSCyz14iruBBnaaOhgLGWIc39PX6sD0bF63c3n8C+mlJyCQifV9ACHJfCSIL/O8iAvcbv0KXzw36VePnHhvAgSXtxx3IYYNQMkbH/+gdJAOXzZzHjl9UyeZnF7dhx161hFTvocZlq8QXT9qMz2GsXCHYeXexiDBQZWotD8UWJ9eoZXYupG7fu64AyNnHM/XAyZRK/e62IN2mn4QyDNxsemHyHCRMl6bp23PO+yPbIKZ8cQnCv6rsWteu2VE+Is7VvoPV1IdaCGq16jJIZrpb/xvqu1cj2+fGLvTE1WN2NLjGlQATHdmTh7CCNbG6zE14ZMELbAcUIWNRmeZFyiqFJWVEeCOeB4lBDu/vUuBw1olpU7NDR4UhahzwH;4:4dTaWDu4hsluPKQSLDtDVEX2tqy2QoX1tc7F5ij87P19YEYmJ/eyys2X1S7dBEjnWUM8qd/MzNK1faC+rE/i+96UbBAwRgdKOTCCEyXgwNVT0XFR6xgBB2As0V9dQcjJKQnaLQ3mObQeAJNxICyeE3J6MQ5CqrynSGLH/9dKiycvuptn4Hu9LsyzWFTgvb/LobrBydniT628/n/Jc5kcqTajoWcMrOnqaZiYywEaxCriA8K8dRCWFkNuBC9BzSG0clwUqpu8HmHlS0am5qAOCOkMW+zTLw+5+ZDqZR3XaoVlRq+RNiLmsl9Ca8ErBIeNpyDJO2tMrYumBgnRa05tgZOO8lmPgRimbViro6RfS+k=
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034C6A006C7AF92A002F0D5990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(6306002)(50226002)(316002)(6666003)(39060400002)(68736007)(486006)(4326008)(966005)(16586007)(478600001)(2616005)(476003)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:5xRuJJULWzwVORPRmyHcRz3+OhdUdpc5AwUghh4C1?=
 =?us-ascii?Q?O5nx0uFz1iw90gN8Fhi3ZHSpKPyGq8ZQslnQnG1FmYIu8no+21hIOcTDeN8O?=
 =?us-ascii?Q?q1hcp7sr7Cl9J3FtC2BsE2C461b5f227GVeOj3Jup+01kHvYtpvD4LNsxEYQ?=
 =?us-ascii?Q?Rie59n6PBcd7+OLy10pMa0l0qx2sMLmxvXvRxCDK/oeSrkWbxCsW5lIT69oq?=
 =?us-ascii?Q?4k+xYWXo6kyp333L60UM8WECvxWu+wt9j0Dh6bKVBkA3bx30vIkDDv+HPJyw?=
 =?us-ascii?Q?NjlIF7UR5UytHdDUA5+CsHtYaft5ZTRUIOOa0JVjVYTJGetxkQ1Un+Wxa4gC?=
 =?us-ascii?Q?XjViDWhRe8opy6T1sOCw0K4AQqndYyfwY6kprRSiXqb99UyTEPDLyBcygP1e?=
 =?us-ascii?Q?QESh/nQ30P9Ru0VdunkiYffg6s2AgQb/EQQj9QNAd2keVickJ0FSMT3UtHW6?=
 =?us-ascii?Q?uqZa273enpXvmATDM+YBFYvU8+wG2Ut5pbnuJrMHyf6+bJ6C6pQ8lt4muyg5?=
 =?us-ascii?Q?Xmbsh1qL51FMTPTWhYi6vI4OoK9EW8W33KAQ4nuAMgWAknUIgM4NI8rI8rIz?=
 =?us-ascii?Q?MQ7S7dmcKKzvWe0+50fvC6fDPDctNlpg86dJsmcjaNSesMMV+4ftf0xWh/Pu?=
 =?us-ascii?Q?O/Ib/BATXcMSeYwtWKN3/Syj5iPQWSrN5HA26jJX2Z9IRY6yCgemeWL/XcbQ?=
 =?us-ascii?Q?lEcvAu8+PY/EhMvKYuUvi1WqFs2RGsbNrsI6SRFRSl6xPhuXKnO6Lzo5792o?=
 =?us-ascii?Q?W+yTYokjhjTMVwGH9beISNWWI4GpaPKRykt6NbxhuWlj7Qw1Ausmtbat+OlC?=
 =?us-ascii?Q?3C9oqU+0VsC5iiRQYNUqcWPfbVLVUGg7bMDQ3WN/odwoI2zgYL4aSrgtFNIe?=
 =?us-ascii?Q?QlgU2Lr9J0YpgPoNsjHHKJDWuG1OvbfD0jTVgQB3iatccV2+2zF3v0FaPLwL?=
 =?us-ascii?Q?Qdb5dkwLsv6ZAIbTtNsWnXubI3k5Duf1Kv4ZoYrsR1L8CcmZPXG5GW5HD/11?=
 =?us-ascii?Q?R8V29Th5xKvNpE/PDUEJrVB13CCQ3z0zCznmj/X+m+sO16L6vR4FDG3uVSna?=
 =?us-ascii?Q?GzmF4BEZO0IY80gQ6izNAEy3hEFmgbL9XxN07vACW0n2nDyNQ2uh8IrHSosQ?=
 =?us-ascii?Q?vUSxJuvnv2foaDpi3+PshjYUzUlyTDI87CvHSh0fprOMEdfTBnA7n+jtFikj?=
 =?us-ascii?Q?Ys3HoOXzgrAHZcO0vQiFfB22fTl+XUfm5vKBMJxyGXtXf4ZXhBwgLR91Nw34?=
 =?us-ascii?Q?fLrO3uFB1f1FE3Gcoc=3D?=
X-Microsoft-Antispam-Message-Info: 9JqUmdQRb3rRgcbvKCxD3Y4ioHj8ba3x37KVVpMqSF018c8qLwDlLeZVSBwOJjFF4WqPlA7A0PgK2yoLRmldoqfJjK7pw5Qj3JUcB4PeqQHNRyP1HKPCqsJryOeIocJo2mRZhPhbHQpo4UquaATrpC3FnQq7y5XngnlgVlryY1KzGRN5kq5CXzhFUWZEe6w2atSxMPGJkkajc5Li0fO4dgsj23AiD/FvaVDGckQf0nYvK+F8/fGVvTwuxJmXUv4Ioz0rj77xHB24s2RLz0cGe02x98QfWZ21Q44Em57ErESngKfKTBYE1SFbs7onVJy/TBA7W6CVdFB7ICj1WtfWITIKhZM9qcpyGDSRw49LFXE=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:8qlnfaIKyGsWyvz/HX2RS34tWORWV0ve4Xu3xAtodgDZ+vAqS7Oxm4Kv8q9P5DvXZugITh51Rsv0QGPR36SqMsPk5x14XzI4zUGynRqBMuJ/0qi3FzQjPkGixwsmcyQXuTCVeN2KlpmAXdxxYg1GXbmJWhqET5MiLgv4qZvatU+mDEKhhHIpPiXiYf/qM6k/Nbr1kxJhf98kO49Uqp+YT4xIQCwGbi8g7busHNbPsLbV30o9+eNXAR/PmNo8trTOs+ZwQpYfdv1g05uz4I+VF2lypZ8G6R8M8BraoSR332t4nMDqKHfGX2TBvQUUvh7VaA6VweXkcNxpEgmNGm2yB9CtzQmy1DvmOV1ZlVlvyEb4lbL3YetO8xAaDjenwBhqSSQbfpfXx6idDMAQQxbbpiHzsIIguuvSnE5Mh4a16lZRR+jqyGp1Q0QcoIVNmCOV4j+qpxiJzBhsAXSYWNlQXw==;5:isSRgnUe6/0d+erJMykUzM40QJX+OJ9MUufyKU6WDdnt0HHEmEwXcxR74amgpAw/HWerISvV3PrCEb/6Th167Ra3yRRMDyCxX0/hAeAxnLaX0zCw01jtNyYxZcV9B1ABHC2bbVSQISsv631Fso+v2Rv46H7wA8r8wpNQN4baZWM=;7:7bNRAgxAMk/iYk+VYa2o8uXpW0y21cndyGEu8GAP5PougzUDhwPon/grJFYeSgP7lvGfr+bB7tA/qbEua8YThbYlEEI2goebxmGa6wFBhZTFUOqkBd5IOnD5mwFQs98t09xYkk2f4MbpsarUtDuPE4YZsVVJZ+whHxH5GBkUZ5WD8JwFepNcJ5c4voBh+c4eMBsigf1opoOpV4FCHIiKnvf2SDMsM9f40t32F5Ozm0kFYVpb6hLUZjFAV2o+e6tq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:31:49.5289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd751a7-7223-40e6-62f7-08d60f2cf87c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a driver for NXP FlexSPI host controller

 FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
 which supports two SPI channels and up to 4 external devices.
 Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional data lines)
 i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up to 8
 bidirectional data lines.

 FlexSPI controller is similar to the existing Freescale/NXP QuadSPI
 controller with advanced features.

- Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
 filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS targets.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
    Micron, mt35xu512aba[3], [Read - 1 bit mode]
    Cypress, s25fl512s, [Read - 1/2/4 bit mode]

Patch 1 adds variable size in spi_device struct, to save the
size of connected slave device.
Patch 2 adds flags for octal I/O data transfer.
Support for octal flash commands and other framework changes would going to be done in different
patch set.
Patch 3 adds a driver for the NXP FlexSPI controller, driver is based on
new spi-mem framework.
Patch 4 add binding file for this driver.
Patch 5 add device node property for FlexSPI driver for lx2160 SoC.
Patch 6 enables the config option.
Patch 7 add MAINTAINERS file.

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=9721
[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=63445

This series adds below patches:
Yogesh Gaur (7):
  spi: add slave device size in spi_device struct
  spi: add flags for octal I/O data transfer
  spi: spi-mem: Add a driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI driver
  arm64: dts: lx2160a: add fspi node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   42 +
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   21 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/mtd/devices/m25p80.c                       |    6 +
 drivers/mtd/spi-nor/spi-nor.c                      |    2 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-fspi.c                         | 1242 ++++++++++++++++++++
 include/linux/spi/spi.h                            |    4 +
 11 files changed, 1347 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

-- 
2.7.4

