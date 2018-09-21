Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7053C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679A821547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oephnl3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679A821547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbeIUQMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:09 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:3040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389795AbeIUQMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgEtXBTuxQuE3q7ZPfKJ7UDjioguVAzI4DbhsANwkrU=;
 b=Oephnl3BP9Q/wplyqFwpre82fPelRp8SVSkaompVuL/UpMaFk1dKcbKM1Nfjj3U9N0EBc3IyQ/1Is4q6gbqwC9Go30GwQkmgNbmv+N8dStUiGkDNRiXWrhuykWng33tGXy7AxChJ1m9cg83EdKwf+74Eslg7Vy4QF32tSFFN/PI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1028.eurprd04.prod.outlook.com (2a01:111:e400:8443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Fri, 21 Sep
 2018 10:23:46 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Date:   Fri, 21 Sep 2018 15:51:58 +0530
Message-Id: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To AM2PR04MB1028.eurprd04.prod.outlook.com
 (2a01:111:e400:8443::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e614a62c-a80e-407b-4cc9-08d61fac52bf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1028;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;3:hkGW13Uxr/8J4Z/kW+pdEelGE2IxsanL0yD9IulQ+gse+kahRkrUCahh2mFkj+kli5+YvxZloay0PmXrlECAg3lr++OZapx8OCIA8hC6iSbKjRYoZDSK53qYPQxF8VsKuJiv0+xLALNYlIUb1pTPcyV7qaDbCqZL9K2MB55us2NEERUhcrXa6t4axwWPihzSLjbS8XTiiXWcZqbKkYIo63I+JQ69P8Er3jhpmqcJyysma1wRLxn7/LyymdbT8TKO;25:HzTQOdd7FflAHqWY6qoEmO1fcfhUabgvzCa1hqw0VaF63s6VEap/5riGgZeEUAEwS6EQopyc70i5nW0atiAkPwLHwrCjTDtUeA0sOTKoeNRSu987arcCa2qVwge0aeN3MZtWyv83vpkR1n+fdY+Z7KOGWFEGKSMWWypzymplUziRQ1hTsZaePkJHcLFr87FFLTSfW04scNB8bkv/BGq27CKZS2ex8nrTDFmHKzav4q1h4TJJDtfhKJerlCADRozrrv2Kv2bwxqGw3ozAEGo7ERfbJOGdnOwXJhEVSKqwH3ewA7fqkr3bKS0kvNvM27j4TCbTTzCjXudAjO7uoICaWQ==;31:TsWzVYDpRB+EAJ4qWxwycwmhfXhmWrYafdHkcA0/NxaqIDSo6NzDrVmeboQD4IJZfCIMidESCRXi2XVavkMwvTCWL79tmZ4i2a+cmNG0tbSkX5RHzf3ZLUmGDR0dL2lixaoEAr9AHhi1PdjYw51SB8VNhUMbSeNq/yNP9ktGTb/EUPhJIxlffaT/HGYeR0ulMwAf6DVlFP8Ho5Xq2SMHE6eKrTbZtIGJl8e30ZoCfpg=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1028:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;20:mWnO/0vEHDXdrYAUNpu00fYtBKzZQakWvsX+qOHPODi7qSNkeAjBhKRnhMlb8/JLjETBr9TXzy7e3TSL/m4FYYzliizeNF+L5/owYKRPAbJ3tGqH8VOM+QuiUXJisVZh9oqziEFjQenbJ2rYtCemZJQ+iCM545UN4TjF5/J6jevrBlHVJlgXNb24reMVHQMMm/Ga5ly0CabvWFLsK4l2zyIEVz2fcJlHuCGjtLyKgibm1NDmzToL5/DxMQkgQGG7woN4ZVGSeqe4alo68DiaV/K1ZtSFG822G7J3ymTUdt7i/BnNmpjJ7o5UGj1LlIli5v+FFHM3kDZY4mJHEJyVOkuZmLz8/lWZ8yA4bvOIVTa2cDj4cIP4hrKnq1sUupRyNDLpmBGGJTitOXKhXK1952ulQl++ycS9WYaw/zrGOLZEHe+BemAQwMZjohra2ZpX3H3ZoGcAHseNkvtQxw/vb9YsGO6v1DHHADisFZvj+Lr86KL30Fhh0cDGi8NkPxJR;4:OJV8xslLDZAfKOLWDI+ABERHJHzEP9d81nvFRvh1TFelKMNT76oWrVIkWzadIKkWEXg8oYN5anlkVOZWUPa1UmEkodH8EKR5ONu5HAUZWlhuEqMw1tDclGgrEUL+nL5NoLSNgd8aDMJEnjF4JwnSJA003/OjKcWXpiCIjrjLqARKksCsqgfOhc73CKu0SyQzaJAU1dSLWz1M3ZufeEkFRxILV7u6i8XXIYqqTIvcwu2HeDLcQ1Jd8Edh+5pt6OZOieGElxt9cXW+9fSWGEK0G0ojsIeAROlKhF6Gtw+dzsVT2yXkZIE2vsYGzIu7ANye+MF6txAOe6BXqVV6/bg7ieagkjoGu8pWaWymfI/o3Ak=
X-Microsoft-Antispam-PRVS: <AM2PR04MB10280E60AAF9F92E87ACF2BF99120@AM2PR04MB1028.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(264314650089876)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1028;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1028;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(48376002)(105586002)(305945005)(2906002)(6506007)(25786009)(16526019)(186003)(81166006)(66066001)(81156014)(8676002)(316002)(2616005)(39060400002)(956004)(86362001)(476003)(50226002)(26005)(16586007)(486006)(966005)(6486002)(386003)(5660300001)(6666003)(52116002)(5009440100003)(47776003)(51416003)(4326008)(68736007)(97736004)(478600001)(6512007)(50466002)(7736002)(8936002)(36756003)(6306002)(53936002)(106356001)(6116002)(3846002)(7416002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1028;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1028;23:o4PBakcMkt2NEMBC25so6qbxL5oG6QCwF2M4nkeME?=
 =?us-ascii?Q?iJ2trq9FQgLlqn3O98Nm+ZxBY6WhG7awLKYztGjKdWij3jD23iMaoPO7FQfQ?=
 =?us-ascii?Q?drSD5+IHWBiU025gzB/CC4NX43Dx0NTSwpImP2Hm/tSDWgQJmEzbGg8E5rwQ?=
 =?us-ascii?Q?66on3GSBaeVHsjLkCN3+KhWxqaCCE6KUdYi4d3PUeJeQT+HeJ1yKpXcIGmUI?=
 =?us-ascii?Q?ixwnPnhdcpzjdQ1BdogFrymJMDL7jFaiInnY94paS0KHE1L0Fm2hbCRrB4Rl?=
 =?us-ascii?Q?2FU7kBKFaDk6u+4xyZZmUt6p10OUuORWkjQ0i9wMTc6/s9OlnnAAwYHsYj74?=
 =?us-ascii?Q?0pIrYChyalXBhm5mUP6wCLv4ILMwUOC3lma4N8PmCjTTVi4vFyW8O4kurN+u?=
 =?us-ascii?Q?l0toSO1x9ouwrmwLELA37bKahGgEuHBjQt8wn0VQ5CX/765DaT4PynPMeAlw?=
 =?us-ascii?Q?EHUwICL150VYhhabU2mUDmV+SPyMC3JqqVoS4/oOT6VYnQuFFP6nQnt1w0JZ?=
 =?us-ascii?Q?scP6cx/Mipbka6F532XZLttpn0IGi6oE5smc4a24ZIsujS0T6nMD5IvSSyeF?=
 =?us-ascii?Q?vKPm1wtIievqRdRA24UvmOUMdM1gvyp6V4wUoxbGdkQJw55mv7a+UevFOPjN?=
 =?us-ascii?Q?IEWU6pHCm5PeVB4sDnDF2pHL77laEe3nCakg2aGRMbG8OcUYEHhkmJW4IqCk?=
 =?us-ascii?Q?r1ReIuR7mXNuXfSoq5CzwUwC7cu3oD3A0tUzfyBtIbegh+l4exj67MTGw5po?=
 =?us-ascii?Q?5TS2DJAvWX66jo4FCoP3s1O9ljPcq/eXaKAM1mK2eV76yR3iaWWTzX3EI4pC?=
 =?us-ascii?Q?cieknsck4elIaWFgTRPin+4lBQqpgrY7F3vDyIa7TAGA1+TkaC8M89gZSqcO?=
 =?us-ascii?Q?xurG5JOh8RqhS797eWigsG8K4AZ7fwDOHYDPooB29uw/PBNSqrQRo8BwIww0?=
 =?us-ascii?Q?F97TIaLVHd8Spu5ZwZ7iPMFbWew6Xrm5LGk7elcotNZ0Ly6Y4JCNgBRTPeAK?=
 =?us-ascii?Q?EMtvzLsg9yRXoVTlwslFdWwNBB/heqHevT/4SYwRWY9KqP1WDWa11ljg2IcV?=
 =?us-ascii?Q?Nc1XhXHLnxZFyVdGQ2cVvw/nJHhzpepuVzMce8CkjBTpGQszXgnK6LAqZG46?=
 =?us-ascii?Q?7EZwT9Od36NddX7YUUqr4oy/tSxFwk9zAS5oTD9VU5twbKtOZq7TrglcIVJM?=
 =?us-ascii?Q?Ko/LLy9lBXfo/nXX+tzUgv2rMu9EM62lFx9MNNm1Cly/rIvPvhAUKDc8w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: EGsRSHG/JaQ5UYeTnsJfJUi+Mv/Cg7+JyMLagrAqA3CKv93zXZykHIO0Ja2tH6oa/HHvRMor2GGILdudnplUT4yfHR05SngS2MzNuhc88CukzX7UH2EKhm4RXLGHLb2U4Gvip/qZXnBv3zfwaHckBVj1Ih7twl5j4F1+fxvKWikiIYaLRvgpiBNiMsNGWS6wo4r+P9HMsFspv3mRaZ60BzbFKkbNfyUebIA5TCslyr2239+Y2+pCmufzu9c5RuoSUMzOmtMJYdOJOr4NvrJy3gCzwqiqYbxYCf4ijo8su1LtOtjzxuhjQ2eKnddejOcsQq40CiEJSOZZy7nnsZe8qaUQXYephhDqmSusPjSC2So=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;6:rD+/2qRg3nmK0drBm8dJwSZVEWw57pt5F73xyfqdWPiUb/QSPHOOvvUOFXAGvZVVPPrsCnRBCQnCKAy4ML92ZqKKRCuZcP3pCUNtazyimCL0mIVYpzJhFefvSwpGpthxn2/TDAlPjzZbCUt+Av8ZXD4YlBITBIh0MvBmH2t0FRDkFM+5MCIDTFQrdRWuWMXcgVjTittCfOO9njljttvimqBbocOXJ8C9XIWm+2LiPXVCI7YLrMZNMnmGTZ4G3KpdnugTAbH35t5rXzaUj6sWn3mSgCcJZLHPuPWW9+/vSImT9ZaTPvMXUNP/L5uC9iN0AON//KTpr/mgsP0iYxxhyL3o3ucT1zgs6okqBl0h+47WkwVkOKmrb6KXJTPqOrgkxM70saGLAMppRtix+ggv7FP3cfB47Av42tBLWfwVn23aKci9t5udCTIu0OJDDk1pN1kGbAcgnTaHtc1pd1QKzw==;5:4WcO2CjSClKmyfFgDE3HukaHUW49THqJ6FfeBHMBuDAXrRBnjYUaIaV5HchXRDH92AvtRmeCvMYRAU+hYhxrLjWFxHmZGENPk1NL+V58iEbXv9UiWIBJStjlmAb0po8kvQLXJHQtosPqC5NyPJZufaWj806SwiOcouyMSWoQzUk=;7:U/P1tkT35J6xcLhbTAq3/8crPMA/wg/pX6IgzsW7AkdT8NE8mUoGMxsBKO/crOv8Hd5a5T/Jo7t4nA+OuxnxZfuFxT5VbkQ4Vw3/9mcOYET51NWzkOIntY3H2qfXu6JfePyTxXkHR+/00AZ4zuwXlzfQrM8OvuTayFTrl7Ji5ACi8w9JUhzv68Jky192B7oJdEXTKgLtP5YFCzJ5BHQGafG7PctSjYypzvlVulCgLGrWoXS9/yMAbeJeLW06Rusi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 10:23:46.0406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e614a62c-a80e-407b-4cc9-08d61fac52bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add driver for NXP FlexSPI host controller

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

Changes for v3:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
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
 drivers/spi/spi-nxp-fspi.c                         | 1231 ++++++++++++++++++++
 8 files changed, 1324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

-- 
2.7.4

