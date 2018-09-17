Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258ADECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE5214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S3PqgH/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CE5214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeIQPSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:18:00 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:36864
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeIQPR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkvthCM2OEQiSD14U9XsR0QJMIsaY1BbxKnKjFY4JOw=;
 b=S3PqgH/dilDD2CVPZowPCI6XSHkd0v51ZVADlAEPJkVDCfS5N2r+gOVer6rrhWzhlYwh/VlFRvun/UHSHvbBdsl2uauJ/PeYsTCXI3/BaDVsBOGFkMw9uB1N00TEE8sLzAfGtwRvmMbxdlczQKfYt+o1i9URBdnLZNDqv+xQVos=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Mon, 17 Sep
 2018 09:50:19 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date:   Mon, 17 Sep 2018 15:18:25 +0530
Message-Id: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cebd1d0-6fb3-4ef8-11c2-08d61c82fd85
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1030;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;3:bZvYedIiJUjiM+yJ0fjtr0deK8uW6XTC9H96AhUQTO8NjxEt/j5xM0sdNcWxQWs6IdpB5+6w3qnWLKT1N6BD+tZBvcgVZIXHjHMk0PR+i8GHbopuP5fijPBdV9ZafdKBXXfnjZjlq9K2Ga7q8zsu7iwLpCTEoDG0QUo+ISJUZwMynybYkPJ4M22arn4MPXIgcE2iNgHAuhq6g4/GGawCUCJT5cfOxim7bWGlMgLlJX8UaqJcJzonnU/+YlNUxdLW;25:IeYeZhoC+bxtqRmKxKOijSyMpdD+J1AKgdWzuoiYaDr/wV7MddzYamx37A4YmoOOCLPsRLseo3g0y0QGf5VvVfvJUELsTWgQNiDDNn4C3WZHPfPfn2Uv11IUirAZvchOggFugbprI/sKwBmhtAx9rFm3Afj8GPqfI4OkNMlIhqX+gyG7WwREO94E8vX/7LxuuggG7bf55nM4xebUACXe81PO+wlkz7PY703wDjc+c19dU4DCsnBWs+8kcM4G7Xi6pCo4aRanrma2HX95QVOpuTMf5c5BmBBECPH5jQV+l7+Yx7TGihBLJACgm9/USsx1ilzGeApqbRAwnHOuVZ60fA==;31:xh3pAbb2X+N7WOrUyFmxZY0kACiImuJXfj3QMW5u5XeJkHTP55y7w3Cz/kU59dXTQMdNKxqOBkMj5JJbUmLKVoaoWLykbEKjbACyJFu9KUOU5F7Jp3eAZSE3sOworPCWkqJdMz1ZSoYPf92Ee17RKcxnTAMRGmM/6W/NHdgR89Uz2G3CDbhcUUk/7pQNBttXUFRFkfT9wH7abidr+/o/0wCFvxRznTJ0a5aiDckeBME=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1030:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;20:BdzHb/019y3g/pO1BWbiUGOm0qVQM31v1dk8iUX2LNFgYr8fMDDLgCPjQ+KPkUfBNxr4avHcPgsLh3MIAwJtqtn0FsTxqnwRKU2wiTu+QXCCwmtRDhNUo2P2K75KpZqwWFK5CaE06S/XrpTOHlTDA/99KM5H0RDAFphMUE0XqDfOi3Sh74LzT0ULGJp4v/aA//zWPevA1t8gFUESlWE9CAKuGpsvzViBzv/0Cdty/OK23EjeeL2eT5jBwX0UiUJkhgIPiBnoxGEIB/VTsIMT2TgjmgDAiOUFMZbaZyZ7usJWR8wFhdB4JrxO4OW9lSsLzL+PAPeryhYg2zppkQQ2fnb46j2+2J2CfLfdq5praHTzWGRDLRPnh8VwZuMHBqX8TDOzO2pDq7fW5gavsBDIUZPgsEOelrJpq8iUt7IFoOOhdKKQ2++w+OU4BLsX/msBNm3WCOHUKUCXNavG5Hlznl3C9xmMRenIevP+pXM8bPgHXKrhT3PWEZuPfF9ToJrU;4:I70+Mu7oextb08iBdyAdaRAhTZiJPKYbT7cekt0O8F3WUVM6CgRRRN+b4/YHhz0nZ5/1Nj/c0PJQ19PJZly3JfJLiVU6TzC1uDdzaa7NJUQxlyHQkHHmEpIsO56qnqwz2N/pr/W9iwrqkf8Z3s0E9Feq5Unr+ubX9v/ZUxlk/Xmg8n5WzIcatXdrz6sG+MapGwnNCHM0nueda63uAoGZrMF76X+NTOobMT2OifPBhPDKlRNLfn49t/JdgiHRhJp4hqnr50dfCRsHiU1THcw5idQDBdY1wvls1P+swzkf1CJzr9WTl70oFbJ0zDHDDW7wb9qKc1ju39qvOsY9LGrwBpf3kdHkG8/O4OsGq6+8dyQ=
X-Microsoft-Antispam-PRVS: <DB5PR04MB10301ED9D2A43D30C7F4F02D991E0@DB5PR04MB1030.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:DB5PR04MB1030;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1030;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(7416002)(6306002)(26005)(66066001)(966005)(386003)(47776003)(316002)(305945005)(6506007)(55236004)(6512007)(6666003)(86362001)(81156014)(186003)(68736007)(6486002)(50226002)(16526019)(105586002)(8936002)(16586007)(51416003)(478600001)(52116002)(53936002)(97736004)(8676002)(81166006)(36756003)(5660300001)(7736002)(48376002)(3846002)(39060400002)(476003)(25786009)(4326008)(956004)(2906002)(2616005)(486006)(6116002)(5009440100003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1030;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1030;23:vthJJ9jTmhqZeCE4e7uVGGxDbYx6w8ZSKKzSAYKex?=
 =?us-ascii?Q?qufWxPDPyWlNBAf8oBVSG9mdgirCt/eFlPGCyH7rXETASN1BbRUxor+Q/Pxm?=
 =?us-ascii?Q?mbW4/BPrwGWdAPz7AZKSpN6ZZJ7T0sgFQGHlL0KXJ3LMtZdwgzaXZklpOSgt?=
 =?us-ascii?Q?ajI+2gbc13p/snJvxHp+rRfm5o53++p7fbWexY7Ka0cTWjTuv/cAbwHS1DlI?=
 =?us-ascii?Q?oGlCNphmCiRB3+yn6quTAQTyTbSAs+vZnMrlale3i0hpVKrsjP97IWUOEVJP?=
 =?us-ascii?Q?h1Dtvy/Eg3DO4SrH8FzA5Hv8rhCSKxjjXy+KKxEgbf47bBxFWXlbcKocIHsY?=
 =?us-ascii?Q?ltMzE3+696FUC1LVHBmNKzOlEqiTh2jEG1ETEk930raGsc1lDoFucDAvHAgC?=
 =?us-ascii?Q?HaNm8hNnbwP/n1NiBBDAiDGxXSSaSGLGtf6LeaIa1fyIp6ybM3iPHc70rW9n?=
 =?us-ascii?Q?S1xrq5vUJUv1YAvCAFr0oEEX01TpzLu1MzzpOaCStNL1xhsBXvliXgK8Pv1W?=
 =?us-ascii?Q?jFntCFKC1unId3qiblTAteIicGqPl+MjUl1sVj9jeVcfKlv6xlZFwui1+eeq?=
 =?us-ascii?Q?AON0wyxItJ65TR4N3nV//vz0RaOulhHKeBdqi8lATzBrKQR2kU17klOGdHTE?=
 =?us-ascii?Q?K9gUkz3j/KatqjaIGwrXkG6eXGRllk4h7KEBbRNbZrvzYo52qViMIxDTdmzb?=
 =?us-ascii?Q?igm42/HpvYrAITF9CJxAoK9QFhkpRNMSDXN/r9CuihRuGqVdnlNwFcWhONp+?=
 =?us-ascii?Q?Gg8ySEtL688plKy8+km9ZDh6ICcvWIyS/Rp/VZimBWF+QoAUrjdOu4NkPEbz?=
 =?us-ascii?Q?XvavUhKD7JlkiY1uZMsQ0SZoRYFtAsnOwFGf/FxWaJjoKfsw10Vb1tjgzGrj?=
 =?us-ascii?Q?cT19GY0V50nw7/IzTbODoflpr8dA5SICHNDeL1j+VEZnYO792tQLbX9R9OEs?=
 =?us-ascii?Q?AYifkPzB3MCX0eD/3cng/qPqevJqEi/DQechlmqjlhGS4uHH1xVoRS68TgG1?=
 =?us-ascii?Q?QCey12b6owpkhX+pokWG4HHW+X3oKPbNmYWaIA2vODE2zh/J4MuS/D5lX38g?=
 =?us-ascii?Q?SBqIl1Svqd5OunNWmCcM7TpPjyXEBTdAt1wdXMNA2wJHfENLf9sYamHSn+CW?=
 =?us-ascii?Q?i2YIloA5G6QB5vDeXkNLRBP0j8O46iOwlmwSI1dfS+mWabVgEKwhPgqZZolC?=
 =?us-ascii?Q?KKqCsu9gEU62Z5q4/6bd3s+exN5p2hfYHm9SEQYUZrxBS5YIdfvFiSQEZMFz?=
 =?us-ascii?Q?9YBaI6DY5gT0yQuqG4=3D?=
X-Microsoft-Antispam-Message-Info: yv2xPh5x9Lnnf3SEYolMB1+wlNJxog6x5rZnHtRKbS91a7epJEpvny4IZchz9xUhCzh0O0z54Id1pd7OwttCbCNNShaZjKOIk0z8p3BGkbPrnd/Ra+DaWutcQLuhcM7C/ee5/Qsq39Q21lSVkK6e0wCXyaGT/L6sQcyMNMcArq9P5x4Cow4K0ZTisNqER6ODDx0yijhe+nHvydGbhRm+ovbPHNHdGlkulSonDULCRZLEfl0UjxqQvLQTbuMF4k4gpeBkLZk/vLbjtbGKCNLsk7DIW8iWh/jCzwcipp+S188K9x3cS2mzXKVm5h7DEXcTZ6RCX7ZAHEx74bI8iDKPtsLblZBBGesmjyaBAFrQGX0=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;6:efvvferI+Pxta75uED5NP4hq/sE9ytThilWOUGuKFidjwC93eMQmAMQsCWZ2+YupUOcRolz9Pe8qOX91Jm3jbE/jfHKx8zhMe3j/QU4mhI6LDVDU6CIBkxty9PhUfpqUViGrgLrDy1RcRmeawCMQkHYMWBEHHsFbvayg6DbPEIepKRTsJ2URHdFbaTgx2/F5UG15vMeK4VpVOZIZisS/d9VTSjq2rm7OfQ059PSVSWdqZj6R2fn9PfxGTAsI7Ls7f2HwlyD13ghcsV0djNse252Cic0MUtxbpD59nHe1NP+8sHt1VQKyCcWnQESLnjL6oAm68LDkr4Z0v9+vdBKJ6wwm9zOoKm0yrTwnKyxy4113QUUdJ6XlpxSNuNqnJ4NUnhObefTlq4NMO3TQ7lOpr6geH0EVHuirrRkn+wVclJfye57egwdAAAkAKi3I6Qg+9FR9EIzyjrXbIFrjyBgUWA==;5:dD2AsN3b80vQXGToZnLvJ60rZYeUl7Oa6CpphzG0TNZUcJCqtd2maJeZmsOvLsRVWrjF/WwS6NOlsfFB34olKbQvM+PJvmQCz+ltEVWyKZSUAL9GYdyOCyWFOhboEsw5UgiUjCAda/uJgJMEmSZHnrEEUvm1qaDLnsOmDXBPdp0=;7:l7Dve4l3RIIoXX91wdgRknN3yBPvFJlhLWxgsc4I3aWiI0taexOKaWa8q6De1/h4rp07iWp/daczxRFLGZ7Nv0iUgH0V7AU0g2CsMSn9kLxEil/mtmsfxWaoRANwmGFCBS4xkLFQ6Cbq7znvV4Ekbdzo7LMNm9cAOD/ayn0SgvgyyNrh37HTx3jktcLQCbHZsROphLYbTXnvCGj84xNigfRlWSsVSHdVjIZJFJw0nvD9zgHDFkAsADe+NfHRLSMI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 09:50:19.1374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cebd1d0-6fb3-4ef8-11c2-08d61c82fd85
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1030
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

- Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
 filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS targets.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
   Micron, mt35xu512aba[3], [Read - 1 bit mode]
   Cypress, s25fl512s, [Read - 1/2/4 bit mode]

 Support for octal flash commands and other Octal data transfer related framework
 changes work is in progress.

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=9721
[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=63445

Yogesh Gaur (5):
  spi: spi-mem: Add driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI controller
  arm64: dts: lx2160a: add FlexSPI node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

Changes for v2:
- Incorporated Boris review comments and drop below patches as per the comments.
 - Patch 'spi: add slave device size in spi_device struct'
 - Patch 'spi: add flags for octal I/O data transfer'
- Incorporated DTS and Binding file review comments of Shawn Guo and Rob Herring.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   42 +
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-fspi.c                         | 1246 ++++++++++++++++++++
 8 files changed, 1340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

-- 
2.7.4

