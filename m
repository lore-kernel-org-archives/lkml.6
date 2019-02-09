Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76352C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 06:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A45D20863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 06:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="y+VGMsXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfBIGiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 01:38:02 -0500
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:22176
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfBIGiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 01:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbJdQj3EcNSMNqLmpKhDaoxU53oA49lsZyfDUqe3rPk=;
 b=y+VGMsXXJ6EIWsyxBF/ChrWb93/pbJ+a6fI50H/y45QGPKOukg3WDBH9fH3eFySQTlRVLRiZAMfa9jyrxyNjws8+e17kY8cQcFLPX099gJRWh8DPyGa2iGl/8ttWtGmdnwxdmArIAylmNTYEQ81ANsy8XOMEmoktnbd1Gjh8Z98=
Received: from CY4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:903:18::16)
 by BYAPR02MB5014.namprd02.prod.outlook.com (2603:10b6:a03:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Sat, 9 Feb
 2019 06:37:45 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by CY4PR02CA0006.outlook.office365.com
 (2603:10b6:903:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Sat, 9 Feb 2019 06:37:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sat, 9 Feb 2019 06:37:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44972 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gsMGl-0001lH-Sb; Fri, 08 Feb 2019 22:37:43 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gsMGg-0003ct-PI; Fri, 08 Feb 2019 22:37:38 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x196bYbP009425;
        Fri, 8 Feb 2019 22:37:35 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gsMGb-0003c2-LK; Fri, 08 Feb 2019 22:37:34 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v13] rawnand: pl353: Add basic driver for arm pl353 smc nand interface
Date:   Sat, 9 Feb 2019 12:07:27 +0530
Message-ID: <1549694247-24625-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(336012)(6306002)(77096007)(186003)(47776003)(36756003)(53946003)(305945005)(2201001)(6346003)(966005)(26005)(8676002)(476003)(126002)(2616005)(6666004)(356004)(486006)(9786002)(426003)(81166006)(81156014)(478600001)(106466001)(50226002)(8936002)(30864003)(107886003)(48376002)(50466002)(106002)(4326008)(63266004)(316002)(36386004)(7696005)(2906002)(14444005)(5024004)(217873002)(16586007)(54906003)(110136005)(51416003)(107986001)(5001870100001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5014;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT052;1:pPCY1V67/9kFCwX4Tv9ykRdjFj1V3gTtt6NJBelR0to2CpRSbwXTr+EQimdkIrU6E6ayUWjmSxyZXsYYmTEEhwGlCSTDeAzfSlJ1MNdukh+CHyuiDtk0P58+85B2mN6LH3AsArJx+9Bp0KBcPZjpMK2flCFGxcq3SYmpbiT+6pg=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f91f1b31-e066-4910-a606-08d68e59195b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB5014;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5014;3:7psQ8kL4Trr7xmzUhw9+Bo7VW7YARuXUlN5ixidv7wosThNQjOGiyFlBUDkfP7vTH1snKsFmouAxRnl7cyzMOiwZBK//WBPFQDinSRorYPcw3gsBTBBBFklzbI9p7ZMTlALNQRFZTgTAs/1A5zCYLLvGe4HbqMAFSBmPgvg9HrlElMv0U8dDZYhhi1Hq3PdGhCIw671lA0JPeodu/OvRYH45VPRV3dMnz/T5yeTm4vVAdG7CPA1ZXpvfJQarzjna9XHZy4n1GO4RTkesot1PsFIyhNbNPMKXmusrspL7NmzfZdsdErJLSsuxAlY6J3bZkwqBiGKjJpqPuBatHdqV88aqc540KFXQaHWnEj7IcIr+gjk8X+ilYpscz4MV8gEq;25:tuOMsynLp2ICHZ5PXG051Niqu99AOKpb+bR9pVqh72KW1CU17Ui9A7mfmDzrjSgApWOiuhkSZN7HmgBJITHv24NhUoNQvV6Vw7xxcV9ffIbKp6sRFpcxpXXYc5lUXjX8b+VXVjyxYrbqxZQAm/BXIrlWeInPFzM/gMWa7bF53+zroa2qvJAEBp/0HJEkN4OufjOpzZjlDY1xDTBXDHeQ3dt+n1nYAHW25+BB/w75zwW/lI2tjghQkwx5EuDPConq8RJMkynOEk+SGBiymHrY70U787t6JZrjSklhoU8b1S9j1L/bUZpQznpAA9hmVJuaN2grwTTYCSrv6qV5IAcP6A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5014:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5014;31:DAc9EqnQDB1QqNsYwJbHoOU8/TfE3kkPewl1XmJoR8d733l6KDZoHpUd2u/VQEBIqhoklovSN2fCcbiGJmSMjICmKdP8NN1WyusuZpiYBKL7pJOfkmNwzsAPl3mA1EECqMRaN5xR1azI+E/SXTWKxq1nK9mLQZ9R9idUQmif1LIfiEQKdPQl8sih/eSKoSnsrxjbOys7RgzWjn7wzeAM+4nUVkzcNiuX8KzGmBcvjCk=;20:HVfHWJ5WXBhCHDQHXs/VALyEQ7Vzhm/tc6ebo2V/wdCPr1WB7kMvgqE0Zv1nj56ppbnEHAMnMIpt1iQ0sEuF2bSn53wKD2zoqjo4LD/x1Bdfjyt9AjS2Pa01g0N8nyQEDiZtHxcVIBqzOzX2sRMOIC6iwKNXGnvyxJDv1bAYHBgeaYVbf9Ek+jNU5Kb7hdPu1lsxm5iPBBrjKHXohUSmF/N8qyBJovp2mu7KGgWX4dLMzMBw5xUZmbKr3WK4xNVZqKEPfatFPXStBMyDxsMm0zjzokl5PJmcNJAU0Xkg3Cww5mhHe+sekBzIupAG+0XTmElekzsdl6Vi+BYBk2FecI0hP398ZAk0H6VxkP3ArRlVo1EYMOK2aVsiM8a9tAksXeb/HHufge3+l2Ju7laKZuEe/cxWaFCEAw4u8dXLRteCwja4YeMMc3so8yuADwj2+L9Mh/VOY0muIZ38oPVQZXFDsw34c67GlPinMsb6JdH0gmh1H8wpM/xIjR7km5uT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5014CE8938EAFE1A9194CB89AF6A0@BYAPR02MB5014.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5014;4:9GTGDwXkcVVGnIE78d+F4gIZGCISMU3Vd6yn+XzC7FyHoD5qFggbZg9pllwo7vXU9Qo33C03plgQbm8Jnuuk8MnCLO7h1Q5wReEDjGhHf44IEj75ExcwunCU+4ppG71/tih4c0iSlyI/P1jSq1dqD/lntaplOAtGZEYdN4oMIzbSXM8SBXuhZ73QqCHtRUH8YHE6r9ch75yXigEek2ao0mH27K0lycFy6BmJbx9mJXbLaBkaYdrftqtxxR8eENDmVOGEnt40NiYOkQJE3GuhcLNHN2pYqerVR33Lc24/dqDGrIbIshYGaPEuOwd+DPe5
X-Forefront-PRVS: 09435FCA72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5014;23:3iE5fM52NChhUEdK2d3ZD6wcYUQFfwL+VeG4h0yIH?=
 =?us-ascii?Q?kVJY9wnjJcbg4MQrRj+A22L/YAxB4ovVIBKUEwx7CYCbCKgpYUYjMGVmMgXw?=
 =?us-ascii?Q?7OYG/+ub4UpghvSjn2cv9lIWcejttAfF2LblFjvwNncp1D3dx7DHX4NWGwV4?=
 =?us-ascii?Q?fLQ9u93z5ce08ePsNuhk9KQFKhSd4JGXFpUWvtApqqx+eusO8u5+Vb9oYv/W?=
 =?us-ascii?Q?ArSR9m8S02sG4LO9vmzadsLL9wnemi1TeyHurpiTp5KZ3RbAhzdseRLGPE08?=
 =?us-ascii?Q?+SjyIV1wUMIv2wy6EYSFaSDAtHQHoDuiKkq6NXZ6Zxbd+FoniAZxOUMmYERV?=
 =?us-ascii?Q?yjq/WK/ytC1W0sQ4vslWPAZSwt1HiUKsxleg25gmYQ1c5Eo++ujGYfgBqx8l?=
 =?us-ascii?Q?Tlwc3qDbKwH7ZrnfbaXdY3rzTr8MBChEZADmYtYEN8Xw8SR6d1S1dKvlLzqe?=
 =?us-ascii?Q?dSqTJ3lpOJXnVMj5sQU/ClkTsVzS9dR37IdwB4khASEUqLmD2oKzYorkvZva?=
 =?us-ascii?Q?Q9w4HkfN77ZOlz+soLOBojB1X6JFrJCwl8C3GuzCTGa9QzwmSbogXJAQZ0wz?=
 =?us-ascii?Q?VsOdrR5BMbm4BzPprTlTKzk7mbEZwjK6ZaqRQXXEjJl50zR27wro0zJz6HAQ?=
 =?us-ascii?Q?HJ04iKeVTB8tqB2XTlJOykAby4X0SaTk5bp+cgiZ0wOj56qjStciKA3xltM/?=
 =?us-ascii?Q?IdxdyQvYo8LDpt5G6Cr10KbPKRdd10jr3Vjt5ig6IPpRKtyWj4EzkE2A+i9D?=
 =?us-ascii?Q?/LZZ09vOvUtTq/Ar9mJdJZhRJAOs+7Bwjh5DJFXv6w2Uuo5QxVUzGrVhpfrW?=
 =?us-ascii?Q?3RJNPMZaBFK5ZQI+spMLrEw7ce2N9zgNIJrJIMG9nh0L6uwSADT8AXD6J7Vq?=
 =?us-ascii?Q?4QMp2J657PzGvS8ap+O+Tpd1nUNJ22IMeuV4GIc2HHStB2aCvptzacoe3Amu?=
 =?us-ascii?Q?q0c3txYPdihS9sfFJEPit7yVfbo3CVLJ0r6U1qHDvkUEmPQXaOa8Q1qYy6KK?=
 =?us-ascii?Q?oekvXe8tH5DbP3Dufak7d4mrrbZgxbODOqCLLEwuYTKwgE0/AxpNpIm8LlIh?=
 =?us-ascii?Q?NLAHW9g8f9tPcLnWor9nukFMcG18TBX2wUhYn0+OI07X+NgrE6qBc9Hlmn3F?=
 =?us-ascii?Q?f4Mjz116/olGyTMUxlauH72j6SJx2YTOgxnaJfmzuxqQt5FcalQ3DtSOjxdH?=
 =?us-ascii?Q?/o+HY95Wb8iQikwId783/4DrnxEK72WZM5azVGgkHwga8fSIOgsVugtjA=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OZv2EnbmfhG7OLuMR2LvN9NWLWLfmwF8F/0akU40EmC5Kvdy2DaD7QcKuok7U6f3bYz9Tv0N2a5TtPtccFEc17midQ0GD7NdDb2xDQDTPtHL3yn17NjymKA6ssGUYemPGrftrrgUUvdxLMMc52NkCj1icks/Zbl+pvz/vulvbdEKfWjdZrHhrJfZHb1LcvQn0+lEPvPxBb3+eUx4fzokElXEmL7vCX6Jdkp+4yTETr5D8noYNZ/1VKQ1XkLJ4H+9g9qE2uEwQ0p65sWPjg7JUb8MADCy2s9dgsGlKUgajueaA+4LjDWBgt/UKngQHuB2SMQLcUmzEIcbpPHjFlhGo32djv5oKte39UK+vlhV2jwvHr5gEYER5BMFB7RMa38rwirc2fL90UxTNg/8Vk2rqlyanEyZB1Q30am4JbizUp4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5014;6:98yBmEExE0/+N5KARySM9MlsnXrYThG5DbPoGfGpg3g2ETQbLN4OoTBcchutoZF4kpG1Pkx6BessXl97eocTWQ5CQstoVtKGPEfLD07OAMhAQhDOtqWiBVMSHAB+KREsAgM4dmt79CJf6fhKySLCleA4f5TTh9x1QyOXfYDcCUT1Ynt0mUH5I9YNIuifnQwmv4H1D2Qdvded0DmTPRpjfCZg7RsYm0apKJg78Di/U4+5K0u5DgcJqBWvyoGEa89Jxqn6AToJj7X24JgbZqhhsLFWGN7j1cgA+JYf8CT8hJA1V65T7qD2I8IWecv6z2dHDTX7F52FrVdh9uoRXuweLXahKrlfFIUk0fwf9mxRtRBghD1s4xI0bJ98lNthnXnRf8ciixumT1iPpLH6uJEq0659uqVRXUQIum6JMELg0mh8BBei27mO6tUoNRBGTcF4vm8AUtox2oPZD1eJpR4rdg==;5:7qbtvzS+2ApGVJmftc3fuJvArRnHT+4OM26jryk0HK+mCvm+M2kDS6CrvZO3QRRFAFwgIg3f4KgnA2uzpoUX8CTyXLLPqOmrTQsLzQrxqrWuE0kDzsw8J1Mw1qZ+4qNDVGy6FKf1pTogNNsIP4NecAz9DJ5y9ReWKuMLGEkWllSrNsXLDHwWT2q7t6QRg+yFjh2YdsYl4IkjmNoiL7F/Kw==;7:KetiewqjR5Labl4g0KAt91HEjjoXO2hN0NtrRMrtUcFNvSYI7kQ2OJqNII0h53N7Q8SBaqIkf2fcvCqgHeasRIvz/NdwTKJNo4wsQ389QcbYi8urDuLA1DKjpFLH9Cr2cmrd9S4sqrNQHIvPfPqD1w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2019 06:37:44.3351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91f1b31-e066-4910-a606-08d68e59195b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller nand interface with
HW ECC support. This controller is used in Xilinx Zynq SoC for
interfacing the NAND flash memory.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
xilinx zynq TRM link:
https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf

Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion S34ML01G1.

SMC memory controller driver is at drivers/memory/pl353-smc.c

Changes in v13:
 - Rebased the driver to mtd/next
Changes in v12:
 - Rebased the driver on top of v4.19 nand tree
 - Removed nand_scan_ident() and nand_scan_tail(), and added nand_controller_ops
   with ->attach_chip() and used nand_scan() instead.
 - Renamed pl353_nand_info structure to pl353_nand_controller
 - Renamed nand_base and nandaddr in pl353_nand_controller to 'regs' and 'buf_addr'
 - Added new API pl353_wait_for_ecc_done() to wait for ecc done and call it from
   pl353_nand_write_page_hwecc() and pl353_nand_read_page_hwecc()
 - Defined new macro for max ECC blocks
 - Added return value check for ecc.calculate()
 - Renamed pl353_nand_cmd_function() to pl353_nand_exec_op_cmd()
 - Added x16 bus-width support
 - The dependent driver pl353-smc is already reviewed and hence dropped the
   smc driver
Changes in v11:
 - Removed Documentation patch and added the required info in driver as
   per Boris comments.
 - Removed unwanted variables from pl353_nand_info as per Miquel comments
 - Removed IO_ADDR_R/W.
 - Replaced onhot() with hweight32()
 - Defined macros for static values in function pl353_nand_correct_data()
 - Removed all unnecessary delays
 - Used nand_wait_ready() where ever is required
 - Modifed the pl353_setup_data_interface() logic as per Miquel comments.
 - Taken array instead of 7 values in pl353_setup_data_interface() and pass
   it to smc driver.
 - Added check to collect the return value of mtd_device_register().
Changes in 10:
 - Typos correction like nand to NAND and soc to SOC etc..
 - Defined macros for the values in pl353_nand_calculate_hwecc()
 - Modifed ecc_status from int to char in pl353_nand_calculate_hwecc()
 - Changed the return type form int to bool to the function
   onehot()
 - Removed udelay(1000) in pl353_cmd_function, as it is not required
 - Dropped ecc->hwctl = NULL in pl353_ecc_init()
 - Added an error message in pl353_ecc_init(), when there is no matching
   oobsize
 - Changed the variable from xnand to xnfc
 - Added logic to get mtd->name from DT, if it is specified in DT
Changes in v9:
 - Addressed the below comments given by Miquel
 - instead of using pl353_nand_write32, use directly writel_relaxed
 - Fixed check patch warnings
 - Renamed write_buf/read_buf to write_data_op/read_data_op
 - use BIT macro instead of 1 << nr
 - Use NAND_ROW_ADDR_3 flag
 - Use nand_wait_ready()
 - Removed swecc functions
 - Use address cycles as per size, instead of reading it from Parameter page
 - Instead of writing too many patterns, use optional property
Changes in v8:
 - Added exec_op() implementation
 - Fixed the below v7 review comments
 - removed mtd_info from pl353_nand_info struct
 - Corrected ecc layout offsets
 - Added on-die ecc support
Changes in v7:
 - Currently not implemented the memclk rate adjustments. I will
   look into this later and once the basic driver is accepted.
 - Fixed GPL licence ident
Changes in v6:
 - Fixed the checkpatch.pl reported warnings
 - Using the address cycles information from the onfi param page
   earlier it is hardcoded to 5 in driver
Changes in v5:
 - Configure the nand timing parameters as per the onfi spec Changes in v4:
 - Updated the driver to sync with pl353_smc driver APIs
Changes in v3:
 - implemented the proper error codes
 - further breakdown this patch to multiple sets
 - added the controller and driver details to Documentation section
 - updated the licenece to GPLv2
 - reorganized the pl353_nand_ecc_init function
Changes in v2:
 - use "depends on" rather than "select" option in kconfig
 - remove unused variable parts
---
 drivers/mtd/nand/raw/Kconfig      |    8 +
 drivers/mtd/nand/raw/Makefile     |    1 +
 drivers/mtd/nand/raw/pl353_nand.c | 1380 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1389 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 1a55d3e..bc6c0a0 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -541,4 +541,12 @@ config MTD_NAND_TEGRA
 	  is supported. Extra OOB bytes when using HW ECC are currently
 	  not supported.
 
+config MTD_NAND_PL353
+	tristate "ARM Pl353 NAND flash driver"
+	depends on MTD_NAND && ARM
+	depends on PL353_SMC
+	help
+	  Enables support for PrimeCell Static Memory Controller PL353.
+
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 57159b3..9d3c48d 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
+obj-$(CONFIG_MTD_NAND_PL353)		+= pl353_nand.o
 
 nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_onfi.o
diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
new file mode 100644
index 0000000..1dbaae5
--- /dev/null
+++ b/drivers/mtd/nand/raw/pl353_nand.c
@@ -0,0 +1,1380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 NAND flash controller driver
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pl353-smc.h>
+#include <linux/clk.h>
+
+#define PL353_NAND_DRIVER_NAME "pl353-nand"
+
+/* NAND flash driver defines */
+#define PL353_NAND_CMD_PHASE	1	/* End command valid in command phase */
+#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */
+#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
+
+/* Flash memory controller operating parameters */
+
+#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */ \
+				 (0 << 5))	/* No Jumping */
+
+/* AXI Address definitions */
+#define START_CMD_SHIFT		3
+#define END_CMD_SHIFT		11
+#define END_CMD_VALID_SHIFT	20
+#define ADDR_CYCLES_SHIFT	21
+#define CLEAR_CS_SHIFT		21
+#define ECC_LAST_SHIFT		10
+#define COMMAND_PHASE		(0 << 19)
+#define DATA_PHASE		BIT(19)
+
+#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
+#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
+
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_LAST_TRANSFER_LENGTH	4
+#define PL353_NAND_ECC_VALID_SHIFT	24
+#define PL353_NAND_ECC_VALID_MASK	0x40
+#define PL353_ECC_BITS_BYTEOFF_MASK	0x1FF
+#define PL353_ECC_BITS_BITOFF_MASK	0x7
+#define PL353_ECC_BIT_MASK		0xFFF
+#define PL353_TREA_MAX_VALUE		1
+#define PL353_MAX_ECC_CHUNKS		4
+#define PL353_MAX_ECC_BYTES		3
+
+struct pl353_nfc_op {
+	u32 cmnds[4];
+	u32 end_cmd;
+	u32 addrs;
+	u32 naddrs;
+	u32 addr5;
+	u32 addr6;
+	unsigned int data_instr_idx;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	unsigned int cle_ale_delay_ns;
+	const struct nand_op_instr *data_instr;
+};
+
+/**
+ * struct pl353_nand_controller - Defines the NAND flash controller driver
+ *				  instance
+ * @chip:		NAND chip information structure
+ * @dev:		Parent device (used to print error messages)
+ * @regs:		Virtual address of the NAND flash device
+ * @buf_addr:		Virtual address of the NAND flash device for
+ *			data read/writes
+ * @addr_cycles:	Address cycles
+ * @mclk:		Memory controller clock
+ * @buswidth:		Bus width 8 or 16
+ */
+struct pl353_nand_controller {
+	struct nand_controller controller;
+	struct nand_chip chip;
+	struct device *dev;
+	void __iomem *regs;
+	void __iomem *buf_addr;
+	u8 addr_cycles;
+	struct clk *mclk;
+	u32 buswidth;
+};
+
+static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes);
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 8;
+	oobregion->length = 8;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops = {
+	.ecc = pl353_ecc_ooblayout16_ecc,
+	.free = pl353_ecc_ooblayout16_free,
+};
+
+static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 52;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 2;
+	oobregion->length = 50;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
+	.ecc = pl353_ecc_ooblayout64_ecc,
+	.free = pl353_ecc_ooblayout64_free,
+};
+
+/* Generic flash bbt decriptors */
+static u8 bbt_pattern[] = { 'B', 'b', 't', '0' };
+static u8 mirror_pattern[] = { '1', 't', 'b', 'B' };
+
+static struct nand_bbt_descr bbt_main_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = bbt_pattern
+};
+
+static struct nand_bbt_descr bbt_mirror_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = mirror_pattern
+};
+
+static void pl353_nfc_force_byte_access(struct nand_chip *chip,
+					bool force_8bit)
+{
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+
+	if (!(chip->options & NAND_BUSWIDTH_16))
+		return;
+
+	if (force_8bit)
+		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
+	else
+		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
+}
+
+/**
+ * pl353_nand_read_data_op - read chip data into buffer
+ * @chip:	Pointer to the NAND chip info structure
+ * @in:		Pointer to the buffer to store read data
+ * @len:	Number of bytes to read
+ * @force_8bit:	Force 8-bit bus access
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_data_op(struct nand_chip *chip,
+				   u8 *in,
+				   unsigned int len, bool force_8bit)
+{
+	int i;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+
+	if (force_8bit)
+		pl353_nfc_force_byte_access(chip, true);
+
+	if ((IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
+	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
+		u32 *ptr = (u32 *)in;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			ptr[i] = readl(xnfc->buf_addr);
+	} else {
+		for (i = 0; i < len; i++)
+			in[i] = readb(xnfc->buf_addr);
+	}
+	if (force_8bit)
+		pl353_nfc_force_byte_access(chip, false);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_buf - write buffer to chip
+ * @mtd:	Pointer to the mtd info structure
+ * @buf:	Pointer to the buffer to store write data
+ * @len:	Number of bytes to write
+ * @force_8bit:	Force 8-bit bus access
+ */
+static void pl353_nand_write_data_op(struct nand_chip *chip, const u8 *buf,
+				     int len, bool force_8bit)
+{
+	int i;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+
+	if (force_8bit)
+		pl353_nfc_force_byte_access(chip, true);
+
+	if ((IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
+	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
+		u32 *ptr = (u32 *)buf;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			writel(ptr[i], xnfc->buf_addr);
+	} else {
+		for (i = 0; i < len; i++)
+			writeb(buf[i], xnfc->buf_addr);
+	}
+	if (force_8bit)
+		pl353_nfc_force_byte_access(chip, false);
+}
+
+static int pl353_wait_for_ecc_done(void)
+{
+	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		pr_err("%s timed out\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_calculate_hwecc - Calculate Hardware ECC
+ * @mtd:	Pointer to the mtd_info structure
+ * @data:	Pointer to the page data
+ * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
+ *
+ * This function retrieves the Hardware ECC data from the controller and returns
+ * ECC data back to the MTD subsystem.
+ * It operates on a number of 512 byte blocks of NAND memory and can be
+ * programmed to store the ECC codes after the data in memory. For writes,
+ * the ECC is written to the spare area of the page. For reads, the result of
+ * a block ECC check are made available to the device driver.
+ *
+ * ------------------------------------------------------------------------
+ * |               n * 512 blocks                  | extra  | ecc    |     |
+ * |                                               | block  | codes  |     |
+ * ------------------------------------------------------------------------
+ *
+ * The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
+ * detection. It starts when a valid read or write command with a 512 byte
+ * aligned address is detected on the memory interface.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_calculate_hwecc(struct nand_chip *chip,
+				      const u8 *data, u8 *ecc)
+{
+	u32 ecc_value;
+	u8 chunk, ecc_byte, ecc_status;
+
+	for (chunk = 0; chunk < PL353_MAX_ECC_CHUNKS; chunk++) {
+		/* Read ECC value for each block */
+		ecc_value = pl353_smc_get_ecc_val(chunk);
+		ecc_status = (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
+
+		/* ECC value valid */
+		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
+			for (ecc_byte = 0; ecc_byte < PL353_MAX_ECC_BYTES;
+			     ecc_byte++) {
+				/* Copy ECC bytes to MTD buffer */
+				*ecc = ~ecc_value & 0xFF;
+				ecc_value = ecc_value >> 8;
+				ecc++;
+			}
+		} else {
+			pr_warn("%s status failed\n", __func__);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_correct_data - ECC correction function
+ * @mtd:	Pointer to the mtd_info structure
+ * @buf:	Pointer to the page data
+ * @read_ecc:	Pointer to the ECC value read from spare data area
+ * @calc_ecc:	Pointer to the calculated ECC value
+ *
+ * This function corrects the ECC single bit errors & detects 2-bit errors.
+ *
+ * Return:	0 if no ECC errors found
+ *		1 if single bit error found and corrected.
+ *		-1 if multiple uncorrectable ECC errors found.
+ */
+static int pl353_nand_correct_data(struct nand_chip *chip, unsigned char *buf,
+				   unsigned char *read_ecc,
+				   unsigned char *calc_ecc)
+{
+	unsigned char bit_addr;
+	unsigned int byte_addr;
+	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
+	unsigned short calc_ecc_lower, calc_ecc_upper;
+
+	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) &
+			  PL353_ECC_BIT_MASK;
+	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
+			  PL353_ECC_BIT_MASK;
+
+	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) &
+			  PL353_ECC_BIT_MASK;
+	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
+			  PL353_ECC_BIT_MASK;
+
+	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
+	ecc_even = read_ecc_upper ^ calc_ecc_upper;
+
+	/* no error */
+	if (!ecc_odd && !ecc_even)
+		return 0;
+
+	if (ecc_odd == (~ecc_even & PL353_ECC_BIT_MASK)) {
+		/* bits [11:3] of error code is byte offset */
+		byte_addr = (ecc_odd >> 3) & PL353_ECC_BITS_BYTEOFF_MASK;
+		/* bits [2:0] of error code is bit offset */
+		bit_addr = ecc_odd & PL353_ECC_BITS_BITOFF_MASK;
+		/* Toggling error bit */
+		buf[byte_addr] ^= (BIT(bit_addr));
+		return 1;
+	}
+
+	/* one error in parity */
+	if (hweight32(ecc_odd | ecc_even) == 1)
+		return 1;
+
+	/* Uncorrectable error */
+	return -1;
+}
+
+static void pl353_prepare_cmd(struct nand_chip *chip,
+			      int page, int column, int start_cmd, int end_cmd,
+			      bool read)
+{
+	unsigned long data_phase_addr;
+	u32 end_cmd_valid = 0;
+	unsigned long cmd_phase_addr = 0, cmd_phase_data = 0;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+
+	end_cmd_valid = read ? 1 : 0;
+
+	cmd_phase_addr = (unsigned long __force)xnfc->regs +
+			 ((xnfc->addr_cycles
+			 << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (start_cmd << START_CMD_SHIFT));
+
+	/* Get the data phase address */
+	data_phase_addr = (unsigned long __force)xnfc->regs +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (0 << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+
+	if (chip->options & NAND_BUSWIDTH_16)
+		column /= 2;
+	cmd_phase_data = column;
+	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+		cmd_phase_data |= page << 16;
+		/* Another address cycle for devices > 128MiB */
+		if (chip->options & NAND_ROW_ADDR_3) {
+			writel_relaxed(cmd_phase_data,
+				       (void __iomem * __force)cmd_phase_addr);
+			cmd_phase_data = (page >> 16);
+		}
+	} else {
+		cmd_phase_data |= page << 8;
+	}
+
+	writel_relaxed(cmd_phase_data, (void __iomem * __force)cmd_phase_addr);
+}
+
+/**
+ * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read function
+ * @mtd:	Pointer to the mtd_info structure
+ * @chip:	Pointer to the nand_chip structure
+ * @page:	Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_oob(struct nand_chip *chip,
+			       int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	chip->pagebuf = -1;
+	if (mtd->writesize < PL353_NAND_ECC_SIZE)
+		return 0;
+
+	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+
+	nand_wait_ready(chip);
+
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH), false);
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
+				false);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to write
+ *
+ * Return:	Zero on success and EIO on failure
+ */
+static int pl353_nand_write_oob(struct nand_chip *chip,
+				int page)
+{
+	const u8 *buf = chip->oob_poi;
+	unsigned long data_phase_addr;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 addrcycles = 0;
+
+	chip->pagebuf = -1;
+	addrcycles = xnfc->addr_cycles;
+	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+
+	pl353_nand_write_data_op(chip, buf,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
+	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(chip, buf, PL353_NAND_LAST_TRANSFER_LENGTH,
+				 false);
+	nand_wait_ready(chip);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_page_raw(struct nand_chip *chip,
+				    u8 *buf, int oob_required, int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+	nand_wait_ready(chip);
+	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH), false);
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
+				false);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_page_raw - [Intern] raw page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_raw(struct nand_chip *chip,
+				     const u8 *buf, int oob_required,
+				     int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+	pl353_nand_write_data_op(chip, buf, mtd->writesize, false);
+	p = chip->oob_poi;
+	pl353_nand_write_data_op(chip, p,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
+				 false);
+
+	return 0;
+}
+
+/**
+ * nand_write_page_hwecc - Hardware ECC based page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * This functions writes data and hardware generated ECC values in to the page.
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_hwecc(struct nand_chip *chip,
+				       const u8 *buf, int oob_required,
+				       int page)
+{
+	int eccsize = chip->ecc.size;
+	int eccsteps = chip->ecc.steps;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *oob_ptr;
+	const u8 *p = buf;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_write_data_op(chip, p, eccsize, false);
+		p += eccsize;
+	}
+	pl353_nand_write_data_op(chip, p,
+				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
+				 false);
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
+				 false);
+
+	/* Wait till the ECC operation is complete or timeout */
+	ret = pl353_wait_for_ecc_done();
+	if (ret)
+		dev_err(xnfc->dev, "ECC Timeout\n");
+	p = buf;
+	ret = chip->ecc.calculate(chip, p, &ecc_calc[0]);
+	if (ret)
+		return ret;
+
+	/* Wait for ECC to be calculated and read the error values */
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
+					 0, chip->ecc.total);
+	if (ret)
+		return ret;
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+
+	/* Write the spare area with ECC bytes */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_write_data_op(chip, oob_ptr,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
+
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_write_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH,
+				 false);
+	nand_wait_ready(chip);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_hwecc - Hardware ECC based page read function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the buffer to store read data
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * This functions reads data and checks the data integrity by comparing
+ * hardware generated ECC values and read ECC values from spare area.
+ * There is a limitation in SMC controller, that we must set ECC LAST on
+ * last data phase access, to tell ECC block not to expect any data further.
+ * Ex:  When number of ECC STEPS are 4, then till 3 we will write to flash
+ * using SMC with HW ECC enabled. And for the last ECC STEP, we will subtract
+ * 4bytes from page size, and will initiate a transfer. And the remaining 4 as
+ * one more transfer with ECC_LAST bit set in NAND data phase register to
+ * notify ECC block not to expect any more data. The last block should be align
+ * with end of 512 byte block. Because of this limitation, we are not using
+ * core routines.
+ *
+ * Return:	0 always and updates ECC operation status in to MTD structure
+ */
+static int pl353_nand_read_page_hwecc(struct nand_chip *chip,
+				      u8 *buf, int oob_required, int page)
+{
+	int i, stat, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *ecc = chip->ecc.code_buf;
+	unsigned int max_bitflips = 0;
+	u8 *oob_ptr;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->regs;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+	nand_wait_ready(chip);
+
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_read_data_op(chip, p, eccsize, false);
+		p += eccsize;
+	}
+	pl353_nand_read_data_op(chip, p,
+				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
+				false);
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
+				false);
+
+	/* Wait till the ECC operation is complete or timeout */
+	ret = pl353_wait_for_ecc_done();
+	if (ret)
+		dev_err(xnfc->dev, "ECC Timeout\n");
+
+	/* Read the calculated ECC value */
+	p = buf;
+	ret = chip->ecc.calculate(chip, p, &ecc_calc[0]);
+	if (ret)
+		return ret;
+
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+
+	/* Read the stored ECC value */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_read_data_op(chip, oob_ptr,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH), false);
+
+	/* de-assert chip select */
+	data_phase_addr = (unsigned long __force)xnfc->buf_addr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_read_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH,
+				false);
+
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
+
+	eccsteps = chip->ecc.steps;
+	p = buf;
+
+	/* Check ECC error for all blocks and correct if it is correctable */
+	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
+		stat = chip->ecc.correct(chip, p, &ecc[i], &ecc_calc[i]);
+		if (stat < 0) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += stat;
+			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+		}
+	}
+
+	return max_bitflips;
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void pl353_nfc_parse_instructions(struct nand_chip *chip,
+					 const struct nand_subop *subop,
+					 struct pl353_nfc_op *nfc_op)
+{
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id, offset, naddrs;
+	int i;
+	const u8 *addrs;
+
+	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		instr = &subop->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			if (op_id)
+				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
+			else
+				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			offset = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+			addrs = &instr->ctx.addr.addrs[offset];
+			nfc_op->addrs = instr->ctx.addr.addrs[offset];
+			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
+				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
+						 (8 * i);
+			}
+
+			if (naddrs >= 5)
+				nfc_op->addr5 = addrs[4];
+			if (naddrs >= 6)
+				nfc_op->addr6 = addrs[5];
+			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
+								     op_id);
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->data_instr_idx = op_id;
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->data_instr_idx = op_id;
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
+			nfc_op->rdy_delay_ns = instr->delay_ns;
+			break;
+		}
+	}
+}
+
+static void cond_delay(unsigned int ns)
+{
+	if (!ns)
+		return;
+
+	if (ns < 10000)
+		ndelay(ns);
+	else
+		udelay(DIV_ROUND_UP(ns, 1000));
+}
+
+/**
+ * pl353_nand_exec_op_cmd - Send command to NAND device
+ * @chip:	Pointer to the NAND chip info structure
+ * @subop:	Pointer to array of instructions
+ * Return:	Always return zero
+ */
+static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
+				  const struct nand_subop *subop)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const struct nand_op_instr *instr;
+	struct pl353_nfc_op nfc_op = {};
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	unsigned long cmd_phase_data = 0, end_cmd_valid = 0;
+	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
+	unsigned int op_id, len, offset;
+	bool reading;
+
+	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	offset = nand_subop_get_data_start_off(subop, op_id);
+
+	pl353_smc_clr_nand_int();
+	/* Get the command phase address */
+	if (nfc_op.cmnds[1] != 0) {
+		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
+			end_cmd_valid = 0;
+		else
+			end_cmd_valid = 1;
+		end_cmd = nfc_op.cmnds[1];
+	}  else {
+		end_cmd = 0x0;
+	}
+
+	/*
+	 * The SMC defines two phases of commands when transferring data to or
+	 * from NAND flash.
+	 * Command phase: Commands and optional address information are written
+	 * to the NAND flash.The command and address can be associated with
+	 * either a data phase operation to write to or read from the array,
+	 * or a status/ID register transfer.
+	 * Data phase: Data is either written to or read from the NAND flash.
+	 * This data can be either data transferred to or from the array,
+	 * or status/ID register information.
+	 */
+	cmd_phase_addr = (unsigned long __force)xnfc->regs +
+			 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
+
+	/* Get the data phase address */
+	end_cmd_valid = 0;
+
+	data_phase_addr = (unsigned long __force)xnfc->regs +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+	xnfc->buf_addr = (void __iomem * __force)data_phase_addr;
+
+	/* Command phase AXI Read & Write */
+	if (nfc_op.naddrs >= 5) {
+		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+			cmd_phase_data = nfc_op.addrs;
+			/* Another address cycle for devices > 128MiB */
+			if (chip->options & NAND_ROW_ADDR_3) {
+				writel_relaxed(cmd_phase_data,
+					       (void __iomem * __force)
+					       cmd_phase_addr);
+				cmd_phase_data = nfc_op.addr5;
+				if (nfc_op.naddrs >= 6)
+					cmd_phase_data |= (nfc_op.addr6 << 8);
+			}
+		}
+	}  else {
+		if (nfc_op.addrs != -1) {
+			int column = nfc_op.addrs;
+			/*
+			 * Change read/write column, read id etc
+			 * Adjust columns for 16 bit bus width
+			 */
+			if ((chip->options & NAND_BUSWIDTH_16) &&
+			    (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
+				nfc_op.cmnds[0] == NAND_CMD_SEQIN ||
+				nfc_op.cmnds[0] == NAND_CMD_RNDOUT ||
+				nfc_op.cmnds[0] == NAND_CMD_RNDIN)) {
+				column >>= 1;
+			}
+			cmd_phase_data = column;
+		}
+	}
+	writel_relaxed(cmd_phase_data, (void __iomem * __force)cmd_phase_addr);
+
+	if (!nfc_op.data_instr) {
+		if (nfc_op.rdy_timeout_ms)
+			nand_wait_ready(chip);
+		return 0;
+	}
+
+	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
+	if (!reading) {
+		len = nand_subop_get_data_len(subop, op_id);
+		pl353_nand_write_data_op(chip, instr->ctx.data.buf.out,
+					 len, instr->ctx.data.force_8bit);
+		if (nfc_op.rdy_timeout_ms)
+			nand_wait_ready(chip);
+		cond_delay(nfc_op.rdy_delay_ns);
+	}
+	if (reading) {
+		len = nand_subop_get_data_len(subop, op_id);
+		cond_delay(nfc_op.rdy_delay_ns);
+		if (nfc_op.rdy_timeout_ms)
+			nand_wait_ready(chip);
+		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len,
+					instr->ctx.data.force_8bit);
+	}
+
+	return 0;
+}
+
+static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER
+	(NAND_OP_PARSER_PATTERN
+		(pl353_nand_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_exec_op_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
+	);
+
+static int pl353_nfc_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			     bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
+					      op, check_only);
+}
+
+/**
+ * pl353_nand_device_ready - Check device ready/busy line
+ * @mtd:	Pointer to the mtd_info structure
+ *
+ * Return:	0 on busy or 1 on ready state
+ */
+static int pl353_nand_device_ready(struct nand_chip *chip)
+{
+	if (pl353_smc_get_nand_int_status_raw()) {
+		pl353_smc_clr_nand_int();
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_ecc_init - Initialize the ecc information as per the ecc mode
+ * @mtd:	Pointer to the mtd_info structure
+ * @ecc:	Pointer to ECC control structure
+ * @ecc_mode:	ondie ecc status
+ *
+ * This function initializes the ecc block and functional pointers as per the
+ * ecc mode
+ *
+ * Return:	0 on success or negative errno.
+ */
+static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
+			       int ecc_mode)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	int err = 0;
+
+	ecc->write_page_raw = pl353_nand_write_page_raw;
+	ecc->read_page_raw = pl353_nand_read_page_raw;
+	ecc->read_oob = pl353_nand_read_oob;
+	ecc->write_oob = pl353_nand_write_oob;
+
+	if (ecc_mode == NAND_ECC_ON_DIE) {
+		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
+		/*
+		 * On-Die ECC spare bytes offset 8 is used for ECC codes
+		 * Use the BBT pattern descriptors
+		 */
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+	} else {
+		ecc->mode = NAND_ECC_HW;
+		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
+		ecc->bytes = 3;
+		ecc->strength = 1;
+		ecc->calculate = pl353_nand_calculate_hwecc;
+		ecc->correct = pl353_nand_correct_data;
+		ecc->read_page = pl353_nand_read_page_hwecc;
+		ecc->size = PL353_NAND_ECC_SIZE;
+		ecc->read_page = pl353_nand_read_page_hwecc;
+		ecc->write_page = pl353_nand_write_page_hwecc;
+		pl353_smc_set_ecc_pg_size(mtd->writesize);
+		switch (mtd->writesize) {
+		case SZ_512:
+		case SZ_1K:
+		case SZ_2K:
+			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
+			break;
+		default:
+			ecc->calculate = nand_calculate_ecc;
+			ecc->correct = nand_correct_data;
+			ecc->size = 256;
+			break;
+		}
+
+		if (mtd->oobsize == 16) {
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
+		} else if (mtd->oobsize == 64) {
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
+		} else {
+			err = -ENXIO;
+			dev_err(xnfc->dev, "Unsupported oob Layout\n");
+		}
+	}
+
+	return err;
+}
+
+static int pl353_nfc_setup_data_interface(struct nand_chip *chip, int csline,
+					  const struct nand_data_interface
+					  *conf)
+{
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	const struct nand_sdr_timings *sdr;
+	u32 timings[7], mckperiodps;
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	/*
+	 * SDR timings are given in pico-seconds while NFC timings must be
+	 * expressed in NAND controller clock cycles.
+	 */
+	mckperiodps = NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
+	mckperiodps *= 1000;
+	if (sdr->tRC_min <= 20000)
+		/*
+		 * PL353 SMC needs one extra read cycle in SDR Mode 5
+		 * This is not written anywhere in the datasheet but
+		 * the results observed during testing.
+		 */
+		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
+	else
+		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
+
+	timings[1] = DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
+	/*
+	 * For all SDR modes, PL353 SMC needs tREA max value as 1,
+	 * Results observed during testing.
+	 */
+	timings[2] = PL353_TREA_MAX_VALUE;
+	timings[3] = DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
+	timings[4] = DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
+	timings[5] = DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
+	timings[6] = DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
+	pl353_smc_set_cycles(timings);
+
+	return 0;
+}
+
+static int pl353_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct pl353_nand_controller *xnfc =
+		container_of(chip, struct pl353_nand_controller, chip);
+	u32 ret;
+
+	if (chip->options & NAND_BUSWIDTH_16)
+		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
+
+	if (mtd->writesize <= SZ_512)
+		xnfc->addr_cycles = 1;
+	else
+		xnfc->addr_cycles = 2;
+
+	if (chip->options & NAND_ROW_ADDR_3)
+		xnfc->addr_cycles += 3;
+	else
+		xnfc->addr_cycles += 2;
+
+	ret = pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
+	if (ret) {
+		dev_err(xnfc->dev, "ECC init failed\n");
+		return ret;
+	}
+
+	if (!mtd->name) {
+		/*
+		 * If the new bindings are used and the bootloader has not been
+		 * updated to pass a new mtdparts parameter on the cmdline, you
+		 * should define the following property in your NAND node, ie:
+		 *
+		 *	label = "pl353-nand";
+		 *
+		 * This way, mtd->name will be set by the core when
+		 * nand_set_flash_node() is called.
+		 */
+		mtd->name = devm_kasprintf(xnfc->dev, GFP_KERNEL,
+					   "%s", PL353_NAND_DRIVER_NAME);
+		if (!mtd->name) {
+			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static const struct nand_controller_ops pl353_nand_controller_ops = {
+	.attach_chip = pl353_nand_attach_chip,
+	.exec_op = pl353_nfc_exec_op,
+	.setup_data_interface = pl353_nfc_setup_data_interface,
+};
+
+/**
+ * pl353_nand_probe - Probe method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function initializes the driver data structures and the hardware.
+ * The NAND driver has dependency with the pl353_smc memory controller
+ * driver for initializing the NAND timing parameters, bus width, ECC modes,
+ * control and status information.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_probe(struct platform_device *pdev)
+{
+	struct pl353_nand_controller *xnfc;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	struct resource *res;
+	struct device_node *np, *dn;
+	u32 ret, val;
+
+	xnfc = devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
+	if (!xnfc)
+		return -ENOMEM;
+	xnfc->dev = &pdev->dev;
+
+	nand_controller_init(&xnfc->controller);
+	xnfc->controller.ops = &pl353_nand_controller_ops;
+	/* Map physical address of NAND flash */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xnfc->regs = devm_ioremap_resource(xnfc->dev, res);
+	if (IS_ERR(xnfc->regs))
+		return PTR_ERR(xnfc->regs);
+
+	chip = &xnfc->chip;
+	chip->controller = &xnfc->controller;
+	mtd = nand_to_mtd(chip);
+	nand_set_controller_data(chip, xnfc);
+	mtd->priv = chip;
+	mtd->owner = THIS_MODULE;
+	nand_set_flash_node(chip, xnfc->dev->of_node);
+
+	/* Set the driver entry points for MTD */
+	chip->legacy.dev_ready = pl353_nand_device_ready;
+	/* If we don't set this delay driver sets 20us by default */
+	np = of_get_next_parent(xnfc->dev->of_node);
+	xnfc->mclk = of_clk_get(np, 0);
+	if (IS_ERR(xnfc->mclk)) {
+		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
+		return PTR_ERR(xnfc->mclk);
+	}
+
+	dn = nand_get_flash_node(chip);
+
+	/* Set the device option and flash width */
+	chip->options = NAND_BUSWIDTH_AUTO;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
+	platform_set_drvdata(pdev, xnfc);
+	ret = nand_scan(chip, 1);
+	if (ret) {
+		dev_err(xnfc->dev, "could not scan the nand chip\n");
+		return ret;
+	}
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(xnfc->dev, "Failed to register mtd device: %d\n", ret);
+		nand_cleanup(chip);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_remove - Remove method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function is called if the driver module is being unloaded. It frees all
+ * resources allocated to the device.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_remove(struct platform_device *pdev)
+{
+	struct pl353_nand_controller *xnfc = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = nand_to_mtd(&xnfc->chip);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	/* Release resources, unregister device */
+	nand_release(chip);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_nand_of_match[] = {
+	{ .compatible = "arm,pl353-nand-r2p1" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
+
+/*
+ * pl353_nand_driver - This structure defines the NAND subsystem platform driver
+ */
+static struct platform_driver pl353_nand_driver = {
+	.probe		= pl353_nand_probe,
+	.remove		= pl353_nand_remove,
+	.driver		= {
+		.name	= PL353_NAND_DRIVER_NAME,
+		.of_match_table = pl353_nand_of_match,
+	},
+};
+
+module_platform_driver(pl353_nand_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
+MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

