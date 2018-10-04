Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2704C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B703213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WCn6sK4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B703213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJDPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:42:51 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:51552
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbeJDPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQEcaeO393Qd9mbvgueJWC0CFxQBHTEkSU/fMAACmUQ=;
 b=WCn6sK4I/GTgDk5J4BzM3y0qhzIF8ONUsbhbo2p1Li7NHsDikwTs+8FOjprM+GKRpzSoAHZaO0VAZebGLpnq0JiNRr78aEDPif30lW3cWxyyLlcNdcVlC19F572Mh1bS+2MzWzYWarj6BnGuqbwiGkHNQQV4yqwv1QrbM24ZevM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1025.eurprd04.prod.outlook.com (2a01:111:e400:8442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Thu, 4 Oct
 2018 08:50:29 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 1/4] spi: add support for octal I/O data transfer
Date:   Thu,  4 Oct 2018 14:18:37 +0530
Message-Id: <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To AM2PR04MB1025.eurprd04.prod.outlook.com
 (2a01:111:e400:8442::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19123110-63d9-4cf4-80de-08d629d671f6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1025;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;3:zQHAKYLxmhFc88mN+ewTQVrAvv+3ATR62mt4HhXG1Ry14BREzg4PumGQneK+MlMNFaGWPVCfkphcxE5ME+rELfCnC6xP0yHS6ZdQtMth2yHijM8b2yusxxAXziU+w8iewWA9t6eoEBmAXA8QiNlzBqXFe3cYxRgivJXTbwd4RKzKuWnUtl+ugXDliYGLdAZIvbm2CBe6zN8jojCu8O2C+iBrt87U+yzIljo5pa9Zd9Vy5NKfFRCTIRXZFbK6evR1;25:aDb4IpRc7e9cLLbn+NtydcfQ5tTBTefKjcw7f8D1g86dv5KpMDWLMmkr19GQk75J5tXTpkNOTglSH0xiBdL7QTuiGQG8nopU35y0S+CIWa2e/k+GAe8cipg5KwqjVnw7B/6ipXLhoIa4mlzrtE8By5vROKI818yABQlXrO+C6E4wuOT3wr4hjMNgxcWaEFY+tL+ndHDz2C071oBhjSIy/0qvEh3ntISJBJ+7GebVhq7b+DACxbz7iYJn4yU3bJCs7/XL7vD3Kht6SogDuOkQiz8kdYkcPJ8x91+t1pZvev3RKboR6IJ4zBksx12gjRLAQSWoVOFNyUP9jyzJZeTzmQ==;31:4lTfAivd9kDtM0caH6x2g8tqQkDQsgwcEoPeYWAHGJnwRL/IXqM6lUqrgICHCzs/YjVs4fFmsmvy8fVnCrhmismsR9gpqJplZ9505gwPSdwExw7avmUW+lwuXps+8/Q+2Eadpi/cyGD4aHxTqm45jsu3YGvCL62FnFBjC45OJcjiCeUsneec/GKptoRApCCLVpZEwwQLV6LYfUBz3OAw3rlNxvXOQWKjeaC9UMlnBRg=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1025:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;20:hjm4DH7l7x7fqKwCJF0k4DC2CnSRRStsllFrZwWMJubETbX5UDJ+wlGAzYYh2oIKHvlcV4pWaSKhH0zXkw72HgGzgaH2aSm4/0JLc46e9m15T8KQhf3X4ondkTcHxz4JLNDCIOJNljbtbJv76JMWi2S1csGdaIoU+TrJacFjO5B24A4rEeVZJikExJKzRP+bADsG1zWtaMcL9+KvfnuDVIEb7Pjy8OovSbIgHL3LCVXhrC3vAAvgJjNboZNlSUUj36qQa74ePd9FxJixB/3tT970M+m8VpL5y2qe7pXo9gEE66Sx3QvdOl9ETCMioQ3HcSn5ZNRbuV6K85xJennt3mL2Vn73UDUIn8fLH8CLck3jkknjw5+JWx5CCwDyoV4LOmvGbQNx/LLjvsIHcxlWC4wjB66nW/V/L8K7kc0Q5LVrttmpxeL39XW2H1piWSX1m2XLJaQOEfK7YD021aVg3eA/gWOmZKRbPYBWmId0cgzp17UTz//BfeRmpLuuh3Mm;4:7wETs4MOk+F9fkuvQYHjwGAo2wooikmFkaKLOsW0Og19mYRi4noN2P9yPDlNYeg9hn3mZ+zmfPSsismOBbgeSdoHkqltvHPbl+S+CbEWQp0Vdp1BzVgbfvqB1USKOV66tfmiKUfNx6OHGf5HdtmeJAm5TY5TiF1jx7/be30s9vQx1L8oAPJA79Zm9BSJR/lA3cwClZPOAZCEI5C5dPpPicXXAcl5ingMH7/kau0fnEHtNSkQcHyTnDlNY7O00jA1t/dM1q7vPNt3M8Q7WmT/s0MLkS0OzkowiRTmmXEXlbGapykPW9CsjJzEBn/Kzz1o
X-Microsoft-Antispam-PRVS: <AM2PR04MB1025FD7C97A7C7EF6F14F92B99EA0@AM2PR04MB1025.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1025;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1025;
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6512007)(8676002)(3846002)(6116002)(7416002)(476003)(11346002)(2616005)(956004)(446003)(66066001)(386003)(52116002)(16586007)(51416003)(6506007)(81156014)(81166006)(6486002)(486006)(68736007)(8936002)(316002)(106356001)(105586002)(25786009)(26005)(48376002)(7736002)(76176011)(2906002)(50466002)(186003)(16526019)(478600001)(53936002)(47776003)(50226002)(97736004)(36756003)(305945005)(6666003)(5009440100003)(39060400002)(55236004)(4326008)(86362001)(5660300001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1025;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1025;23:4AQ7UHAeNUay0EXPVC9E/AyKOFOY2JoS4w3Z0RDLF?=
 =?us-ascii?Q?qqCwD/fdyU/AcUNfj1anOmFfu+UPjAn3tvLL7RVnwyNPC7/TazTm4jLidyRG?=
 =?us-ascii?Q?42qs3WpKr1VlCLG5JMSUp5Ce/PL1bsvOBl7+drx91gQKLao1IeWjt+E9gfI2?=
 =?us-ascii?Q?i/zV0fMHg23txLgtEndUC9ZlxAtJGyhNjaQ+hg69OEPtJw3smtMcf5qp1YP5?=
 =?us-ascii?Q?4nFZbEcx5NEmmbd7kQr0154Mo7f+dj2yfSdF3VQV8vITTke9NHgd4qiz2t/f?=
 =?us-ascii?Q?NRVfzRaITFJetqoEJoTvsQTYGJdbK4D2qMMHxEU19c/woVaQLoujeFSVJNsP?=
 =?us-ascii?Q?efxIFNngQWDlo+2ZO2v8tZEgNcOG4DPrP+kaHYqzDXY54Qcqa0obq8yOy2Fg?=
 =?us-ascii?Q?E7lKnn5hUSHZQYFy7kZIJAeRc1UztbDNK3kABz8MznHMIcANi4M6ViNzCq7D?=
 =?us-ascii?Q?m/PZq5jCJzhIxGHkRUQVQKvuN820hXdfJFGCxO0bRnWl7a54LfL/9qhU5pwd?=
 =?us-ascii?Q?ZPPLgy1b0kqLnmfsS/66J/VbcRT15yrs20w48Cegkyywm9yQqFVzxuyKq0/Z?=
 =?us-ascii?Q?g40c6IAqGsX3mjL36tBpCMTmO3ytgnvoa5tDXcQ8U3rkK97KC3oe15JaE5Td?=
 =?us-ascii?Q?82LUKJE8b3eYzMR6LZ+ngHR5SkZWnqAuUl/mdj2yXxi8vyu4D8eMpSFsqMUS?=
 =?us-ascii?Q?HCoA5ol2PBnl7lAnYAx9bBV8he5d0RPNbA8MFw3EG+2Kd6hJXdCnRo6waQWI?=
 =?us-ascii?Q?UZkyLkbrFkJUASjfmwcghPL8s8pQrtAXOc+6FihNder0HHVhpFAFUpp/csZa?=
 =?us-ascii?Q?W+qmmW7UnJWNvdc8pfnjWYUpAzYMcFQG/sPtLCaiQg5RgmlmJRNIqnCJkrU1?=
 =?us-ascii?Q?09zuU87na3GAXbBNRCawoWU0NeRCXFpH/UaFC6gnCGV7udnyPEW/B0j9bDdx?=
 =?us-ascii?Q?yfTMPjtgSwuyz4CeDHpwqtBAAMfXBUR/n4ylHHHbZlrCATwZgnu7gsJOvZXI?=
 =?us-ascii?Q?WfxDH0dY9C/pl6WeXaaopef+rFfvBbUhi+FENm56VFiipDPfnGnkzH5X9djO?=
 =?us-ascii?Q?3DHUOLzY6NHwIVUEjzf12XBp3rrTeyEDlxIX7dimHMjkXwcdzyWpfJBK0zgZ?=
 =?us-ascii?Q?0GVI6iUaLOe/f5icvCc0lKjjmn33F8IXYheGOgzOeX1qAkGekiqZeP3cpUuq?=
 =?us-ascii?Q?YAjrFHVr34DQuI9NngUhtN9ODI2e0VnFARPKefr59aNVbpGQYcnqC4jHtfCg?=
 =?us-ascii?Q?tOFvYu/7E3VQbpzPLHAePs5ZLPT5QjQBX5/b21G?=
X-Microsoft-Antispam-Message-Info: JDIVgw9tC3rvxwUyvZSOWDvuYTT66MxgcoW+jskZZ2YGNktaeM38IWshQ+GTSrXdR9hsat4O5ood+hgBjS0gwUtujEo3uAcnPWbKfBSuQzy9Duvem1RnD/Hrb5hebNb2/pTIs5LV7JS7dqMil6RG+tKU1qjWn270g6t1C85dUyGZIMcueCBFHNXTGnsUR61CoPf2t9MuOr03GZ41v5q55IXFbRtHSxgtwGQtDiRzkpjWRi4pDP+ZiMCIJDxmaZ9oRDdQU1fpuDqBkwY1FuKNEdLzOIdQ2t/t4yIERZFG+6wGgjN3voSF7PzV4wNq3BQz/zwO7/qlTdbbap2pHhYl3xLtKZctqlWhuTLfgVwzQQM=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;6:GK+5rKus95UqtSRXjO4WQFvNPH9t9Wkt13QicLXjvjP0bgccJmOKeDNVCr8ajwizf7qJ5PSf4OEgy0f5ZgDdEcBH8hIIbMizYd1O3VX2wjS+d4O8gy/iY+4sPti2t5ZPPZz1lP6kMJ3VjmFjRb7xOqlen1ZhvahxKicm9cwdI87Ki2YtBlEld+gX0A9XJqf7uZ/1+aB67Dt3E6qbQZBikIuXCNU1Y/oE3vLqCN0FWmnNkDDFXJtkOhbvovOm9Y12sMTMjRwHXdynaYoaJC9vzOKLC+T6Ec0rKD1/5yTLhsHZAbJ133zICT9k9jdQrB1tTuK4UKn5M3l2OLGLbF6yQOKP2VHBPHMloJGge9Pd3pT29FcxRenCa96D0C338l2ZnnQSyrieg6z30NTeDvP0+g3OpS4pdim3YJaOXgnbHtIjyteebWPrD+lxywj80f8JsEkfvYNVOo+BZC0Lxl66Xw==;5:twMGnmsCa9zCQidB2kLuckocUTGyUgd53uxvm6CVPtIqrTnDbUt+h2y/buOgP6JX5mh+mNZDgoBvPAznyu2djweWWREYWkZV/2uQi10BdRK+UOCj4S/aRfBIAbILV4nX6zKvpO1vBWY2fJytGslpn4SXVA5uGd2uN2WyDE3gUfM=;7:lCPiiO59YbKU8a32t4kiJ3WvTR6UhIkw4bsW8rdLRdpXRK7g7lRhnkKjdP1QwY9OAGV9UuQPcpif5I0KbCFZ+8XqeCoeK3t4DjpIuJ54Aa90xkqjeZs5yrhFZKZVXKFsVP+kJ2LcXwmV8Ci71t4nWtUCnqjE4gMdDuWLaDof7XUOyGU9QtJS8jdaQDVOVEiCivZMrQ9ec4GunYGvBfuRF1Ip1YI7NudyQB7qQmt1CrDI2IqbxrrngkFFNbEd8hQn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 08:50:29.0673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19123110-63d9-4cf4-80de-08d629d671f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octal I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/spi/spi.c       | 6 ++++++
 include/linux/spi/spi.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6..80f672f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		case 4:
 			spi->mode |= SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |= SPI_TX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-tx-bus-width %d not supported\n",
@@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		case 4:
 			spi->mode |= SPI_RX_QUAD;
 			break;
+		case 8:
+			spi->mode |= SPI_RX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..2d21307 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTAL	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.7.4

