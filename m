Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F329C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CC8213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gsq1pgrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CC8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJDPmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:42:47 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:51552
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbeJDPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGcMZ2AeTgDO+/GJndHUs8Vpo1fQYc/rPTxg7zti/nY=;
 b=gsq1pgrNNIOMA1FYf7VCcfMlelilH0wtS94Qx/TCsX6jLuQuvqs3xWT+JDLA/ztEfgEUGQ++IDFdl/xdvh4HDiuCFtjuLqkecuxCwlc7kJEJeMEtaeSM0enjq25egvKmsxrdYmFyvy3QIRWj4nvCsRZSd4SNu3D40OH/IP50cd4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1025.eurprd04.prod.outlook.com (2a01:111:e400:8442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Thu, 4 Oct
 2018 08:50:24 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 0/4] spi: add support for octal mode data transfer
Date:   Thu,  4 Oct 2018 14:18:36 +0530
Message-Id: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To AM2PR04MB1025.eurprd04.prod.outlook.com
 (2a01:111:e400:8442::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2d16f3-14f4-43b0-81e3-08d629d66f31
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1025;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;3:GbiBnh+h0cZ8ZusmQNCPqfxvIjKke3NKXx0KB1rReQTNKLMkIKzWdGb6CXbBcIfAy8UAE302rZcxwLbG3cn8TxPCxBLfInrMmIegyVgMBBkWNhlAayADjti9tXKMdOoimpLSI4F8am0vKKF5TrwJM6VUOBoNjeiAwcLZly0vslURJhlH7V/xJpMel4wtT9q9UYWHwISL3TNs0NEBDthtCswmbwMWWznu8voZ7oFwJDYN/SHT/cFLseI/NG1PhngO;25:XJV9z1JjkMDJz4UAgOfzesvpGIbDl+AK4pGpzMFnU1v7/puphrFHxTvkW5A5WVouRrH8tnvK92PBdqyn7drNJpNGqMYKfVPj/LbeWSp/E45HvAehm3TShFutQsdDZmZnBcJg0+be7NC7NyxIW1WkwvqbIQoa8sovf6GvY14gsMfBDlo34XGxAZXPWre9stzG9l3y72enQekjCQxSM2nORw+SsHI97UbQjnMnSJ854ZH8AWHRpRb9Z+SzaNEpDfUZ9yG5Tk1T1HEzhe+b6yI3xjt+KktrwTe5lDKszKNjTW6cUdZ29xeMEoJaL5R38yQVg2KjVWouS8WGXPEyx+Ddyw==;31:sLf2ERXX5B3wd0wjBApwQVsXTJcPx912JKCIrRb7qozCsj63TFIPCNJtl+aqQDvuCKUgHWok1JCldvU/nAxJv2mhUeoi1TBv2mIsFvwZoNd3T9Ke63M/Avr6bYuj6K5MNgLTRgXZGi7dJG/j0VZ4Q0JNvyJCyT85uKV+m7GQAQfCeP65ZjeaSIr8iz7++BdFsij9sNgg9hMmt6ebQlsk3/fnikfyDyb281z3CzYZPlQ=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1025:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;20:/eM3h0xy6ymaXHop/bQNPD0UatZu1pps/S1FnlpRo+MwOD4V4plvq6/ZrVblNhpHKOWS/oxWY2yeZ7u5IxBttHJZl0o9KVepKbCn7FNwmXuLsCqukV+0YGtby8g81NTFuAHmvuT79w7QabaYZ/AsQbqeFFpp584UDlZky4ge8NesrPmRFRkzT5ykRbkGR3ggQmeSjnOroZ5PXyQW6YjbYk2gI3/WzMfsxT+gzpRoEhViPIivznGrVXMKog1NmDipQwyH3jkZsJu1J/L6GpY5Sb8GxHvJWiP1KP7WR9LkOOnJkzYjQ6PruF+AL8fGLSJA9KtIA6RzlKLZ1q19hSY5tEkHXX6KMa8WAvPdM/VWfrgQ2aiI3CC+aMeYsDXYpeDgx5lLSA3x/ZE1bURWnyHC7ldWgV2e1dyt5RWZad8zLmVXTPm429H2IhtXbmAhXoRMHEdBDqkjjtqxdnjubUqSwJUlgzxmanrA0xegKf/mFEtrEJeHqcQib7hr3IVWeA8C;4:NGuQIazA4Ex3E8/qCpMfLpRZgjV1dWPB02deDtdBeT9Z201hE27zQ6Uavsj5U01mW368WakyRVWLitTpxJOh9Xlex9vRkPNF5vwdImWft4EwiFY9bTecK/E2IbOMbWoyIv/PO0guM39AOTnrZ3Nl+aa7WZddXci8OQOhDKPJjlFGSbltg3cVqwnxi911UTj8BpV/psc2wNCqyCHH5MKIIUJYdJLmzQ3NAKHmOgZw+/I730y9E1JlaC5Ru8uCjYYhdH871ue2FuF6AeC3M+JYjA==
X-Microsoft-Antispam-PRVS: <AM2PR04MB1025675E8FC776E7FF657E9E99EA0@AM2PR04MB1025.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1025;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1025;
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6306002)(6512007)(8676002)(3846002)(6116002)(7416002)(476003)(2616005)(956004)(66066001)(386003)(52116002)(16586007)(51416003)(6506007)(81156014)(81166006)(6486002)(486006)(68736007)(8936002)(316002)(106356001)(105586002)(25786009)(26005)(48376002)(966005)(7736002)(2906002)(50466002)(186003)(16526019)(478600001)(53936002)(47776003)(14444005)(50226002)(97736004)(36756003)(305945005)(6666003)(5009440100003)(39060400002)(55236004)(4326008)(86362001)(5660300001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1025;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1025;23:C2MOlzIxUE6QyA9FTs9wiVF7Fu0R4CRXWYy0YObPT?=
 =?us-ascii?Q?KOQ37cwnMintMh4eMuXQ+gpXjze7L6ty5g55IMg231ShoxA/lF9ZWnPL04bk?=
 =?us-ascii?Q?+1xMd4ZgjLk2uED8FGVUeADJJudVgrMgmQvAZsmJe4qzn4kVvwoIhYrhoy/V?=
 =?us-ascii?Q?75CJYDvkpLr/utUm0owjJvJqsXeGW8WNmL646e8cvp4iSGGKwTrH4IiTYiZ3?=
 =?us-ascii?Q?rcBIbgtt3aq895GrRDnnFGe0WWioQ/AwlDaTJOL2D0j/U2ml8ATraTro61lk?=
 =?us-ascii?Q?PTzDgjVdL5E4OGksTQiGq+BcstdrG4qU69BrIEeY4bXYXJS0R9dhWDI1uy++?=
 =?us-ascii?Q?wdmZjrnta9/7goZ0ggKaM6NyUw0IwjMbD6cUEpy7+AIFgQciZaegAd9n18vp?=
 =?us-ascii?Q?YbL1+8kfyHUw1QlpEsMs8uACznjp9sNHd7zRGxaNNTTiKA2gU4ctHEpcL93u?=
 =?us-ascii?Q?BhwOVXLDYC+gzAOQqSvZKC+GI8L9ie9itMyuyB6Z2MBojMoN7s6v8V97FMG+?=
 =?us-ascii?Q?a8QgoCYvBB4T1uTIlwNUIYR0aTe5ygSbWzjmEr/9A+kaF/Rkgy+BDpZi7/7o?=
 =?us-ascii?Q?/PKX/Prp+RekRlfBvLrKNJaXbf3eK7XAcaqabzkc85sb1JeLllQL19JmjmY0?=
 =?us-ascii?Q?d8XHUZb3motiOVOyaYG+A38Z2EHfyNmbRvbnsMThaDJE8HMdrTiVBj47Xsjr?=
 =?us-ascii?Q?DTpUx4LMRd2IZWiQCX/Z5rkHiGEtGKkJ/KtBvAKss+JCT0OwQA21qmx63Wnw?=
 =?us-ascii?Q?Pn+lD1r9v/m4pMOZ2AVM70cN38njjn9Wv5f9DX6kRq7+C3O77kl8tWgyaBNK?=
 =?us-ascii?Q?m4cR5ktCIOsP60gWGekKoyzHplN7xuVKLcZ7DBb4OHrpheWvm7HdoxN+Z/Vi?=
 =?us-ascii?Q?bJPeveupTQbZRs+FPeNmRHStIl5Dp7i9aJMagRjLLP1ZiHJwEM6kEMwaIQmu?=
 =?us-ascii?Q?7hUXJ8xDjqj/szMLVFbPoVkaGRjZ7RsfzwXPdnLg/cjX0/Ma5bMs3CP+OSAk?=
 =?us-ascii?Q?8itbk9OiP8YlHOvqqqfw3Z54+m4BDCJhXkGCspzz+h18J9TfVH+s1B+xbEU7?=
 =?us-ascii?Q?TjweKvOuuVYjCtAo+xGxcihpr4G07lO9G+IjtUc1AwN1j2BZW2fvaAfj7u8T?=
 =?us-ascii?Q?uz+xJLb7eWcEbzzpcQXK6z/dWuREUQAn6/555wNm05CmncFvzLbUkSZCYntb?=
 =?us-ascii?Q?y0nLcVZ/OgewqN9XMxJF7r/XC+BJ/H86spw+4SQ6dBypaw5bMZMaZ0/gKf/m?=
 =?us-ascii?Q?Tu+P6xaQM+I/ixQQCdQUtCMCMxP7bJvYge6KV08?=
X-Microsoft-Antispam-Message-Info: PodCjmquuuXT0rwcnDYroqf1f2ULkmaIvDU7M5iEmBa967086B0o6g30ACQTdmtPXzM9OThXEMhkzsfbF1TYIxqiswMKL52O6GVjAJFcFX9OeX8xjAjaH13kygxM/6jtoECvPcLP+FZXSZijji7GECKUXjFYqyxy7YAtV8Zw205dkhgHQ/u9eBddy/irjVDmcs4TOByubj4p+n7UzKOHCPdVMOn7jfua2q2hAFlEMLHXt/j9BWThAYDoORUIS12fV2LAnPFTJ9ttC7sMI4LamTAWm6RwH07z8ZM3JuEP/HteGUeCW54XPWZzBmitDOiuwN5kUIA1QBds9nUauEZ0xW3mxrx1EiOfMSvtka6FJJU=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;6:ER2xo9FkY1INmSQo1Adi+gE8MXVa3d5q09lnASAXUNElgCTXESYt8LE1BzA0zfN0AyOhXBzwhBW3iHQFfxNtAdDguK6BYFDZbuNZThHEPNwIKgywvlCJ1CBQzzpURWKJUaEpr1xt58QQDWH1PC9MU6tVMBPk9UJv4ZN7O7Z1BrGpcV4c7WDLY5+DhjxF1dM9pbyCzG0ntV1xCs2SV1FIT1yemjpUP9nKb1kAVwXfMPF+4ZLwYaHDxh7L15WqJ3nu5REGJctS5p7LuSx3K4U10cqIHZri9gV8YKoCnK5aoyUbspzcHaEuV3rggt6gtC2CIkFIwGM4BdtI0iI2eDHk7SmUNcPG481TDDuCleFnJgPn6K875RVQVtLvE7gmPzRP8jKLgNJWIJYFm8BrdzsdbiUpuyJhS1U6/YvGMq43ZGMFrgCdaS17K9GZN6jIXITf7iulU1cwChAW0NqMDruKiw==;5:ipUtcABf5IMzFr1ovSqPO1zpn/hVpcJGLJSA9YxYbSurM4p70emYvXc2zzlyTijpBcR0LPEytQDsKGaacTpDOBJCyOXaYtBisw9NPeQjjpmoKFVPLnS9aXbDj5NWoZXiRYetCT/Iapgj+VZj7jsy2RSUepcVMQ9XjTL70bVxk3M=;7:Zo4OfLtA9yM2kq9bzomkuk8OAuEOJXorT6QhHUWMmzsbnwI6geScWE77olStBbDRcCIfOJT1EkcqYZDrP83tmZq7EpP6jXTkJUa2qfM5xI8lv1zx6FQ8nr32tDdsMbvRSjsiEX7oorL0XB3W363uoAM9+JfwRqD4fLBeBczTpH0z3YzY9Rdds2/iMgpHFQ377FVK2q75wSKiQM+RWxHoXxnJl7L9S8Mn9qq37SKsv0Oura2qa4p2baGEK+9JiWtR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 08:50:24.4099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2d16f3-14f4-43b0-81e3-08d629d66f31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series 
* Add support for octal mode flags and parsing of same in spi driver.
* Add octal data communication commands required for mt35xu512aba [1] flash.
* Add support for Read and Write proto for (1-1-8/1-8-8) mode.
* Add mode bit required for octal mode in nxp-fspi driver [2].
* Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].

Tested on LX2160ARDB target with nxp-fspi driver, below are
Read performance number of 1-1-1 and 1-1-8 read protocol.

 root@lxxx:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 04000000 00001000 "spi0.0"
 mtd1: 04000000 00001000 "spi0.1"
 root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read
 
 real    0m2.792s
 user    0m0.000s
 sys     0m2.790s
 root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read
 
 real    0m0.441s
 user    0m0.000s
 sys     0m0.440s
 root@ls1012ardb:~#

 Flash device MTD0 configured in 1-1-1 protocol.
 Flash device MTD1 configured in 1-1-8 protocol.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=66317
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=66887

Yogesh Gaur (4):
  spi: add support for octal I/O data transfer
  mtd: spi-nor: add support for octal mode data transfer
  spi: nxp-fspi: add mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
 drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                     | 14 +++++++++++++-
 drivers/spi/spi-nxp-fspi.c                        |  4 ++--
 drivers/spi/spi.c                                 |  6 ++++++
 include/linux/mtd/spi-nor.h                       |  8 ++++++++
 include/linux/spi/spi.h                           |  2 ++
 7 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.7.4

