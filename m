Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C702084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="01xH7YKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C702084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbeKFH7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:59:10 -0500
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com ([104.47.37.88]:52953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387983AbeKFH7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbxTvEbStBynuPsF5GmXvttaelREYpQ26dNpB3FIbSI=;
 b=01xH7YKVZvcTEahXbYiEJtHPLTxoy4YOy6grmDbMNyL9zRn3npxLSTUtDs2FZYpp7kGgbMzcDc0e/h05EeAKnWA1/+7aBw8dvBRxNcSyTHNKiIcNb6ioFoDgMOMNLDJsRU2bNkyQYycZF20ysGGEd92xLirk4ywMsutBjdSVVys=
Received: from CY4PR02CA0039.namprd02.prod.outlook.com (2603:10b6:903:117::25)
 by SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Mon, 5 Nov
 2018 22:37:10 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY4PR02CA0039.outlook.office365.com
 (2603:10b6:903:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 5 Nov 2018 22:37:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 5 Nov 2018 22:37:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gJnUb-0006vY-Eg; Mon, 05 Nov 2018 14:37:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gJnUW-0001x1-AZ; Mon, 05 Nov 2018 14:37:04 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA5Mb3HE014118;
        Mon, 5 Nov 2018 14:37:03 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gJnUU-0001wf-To; Mon, 05 Nov 2018 14:37:02 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v5 0/2] Xilinx ZynqMP IPI Mailbox Controller Driver
Date:   Mon, 5 Nov 2018 14:36:59 -0800
Message-ID: <1541457421-14820-1-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(126002)(36756003)(305945005)(4326008)(2616005)(476003)(107886003)(39060400002)(486006)(8676002)(50226002)(8936002)(63266004)(81156014)(81166006)(6666004)(186003)(26005)(77096007)(44832011)(50466002)(48376002)(356004)(106466001)(426003)(47776003)(9786002)(336012)(106002)(14444005)(15650500001)(54906003)(316002)(110136005)(478600001)(5660300001)(16586007)(36386004)(7696005)(2906002)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:bratf+7AvzYEWfqAXPPBRbRe5Yj0kq6W/ixoBxbP7CBiQNNyjUPjXPRIAcvzdNdv9yl/vjknurVCzPWgmGg0JDuAc+GU1obLWlPYc88fKBfKyCWrm8l0BLnvGGOKR2qZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d596cfce-d401-4a20-b495-08d6436f394a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:3QYvEUnJ2YQM9YzW5mNyl4NARRXH3K3pT5lAYfqAQ6/Ho/uxp/6WMLc5T91T47Eh5Fppdjo/JmUKMmh1Rqlb06S48J4L4ae752ZkHdT8ncD9gl75r/yIa6GGMzgo0kpAAGXFZ0LIR0CS3LDw6WHqOGdU1mEvZ6XyBHftTyRY13G3seu6U7CYBwDz1RMlxwb5YA6Jma9E2ln2KnrB3oHnVmBzkY/l+1GRXfUpFI2zgNRtmAbveW+F2Z0rj+/c891VTMIDQLDLQ9eFD+pKvtyTwtU2ov4WlcS/Fi+kv9ZcWD5kt6ZN1yQIyhe5/diSvDhGu7svgKWHUp0XHCm7mtdPHD+XtiCJDmE7sBL2XnA27T8=;25:AprAOYTcQiUv1HovgoDwwZswRuqU5uKeb3hYERPjQvCGPsBo6b0vfQ65H1jD+i298M0hBQGSDggGCQBPDw9ZHcxEnDVC/uEz/ujcw+JAJCjqdsy+GZzIpx0+ptiemgJ6c7Yc1uDX0fj+Z6NvnawYhsN5ufzvW1V/+9hC4N63gqBlCgVE/CPnsQAsaCthRjKtIeFcrrQeMXdk/NisRhvBb0LLwmyfz9Mg8SqTT5+obGb0fH28smT43ffc5WE3neqQHjNva9A8CmhAa+7ahvUp91J67cGZYPNahRAKLuUMc/B85eEHyjrepkHh/BdRe02WQqwcbMz5Fi957QUUDpccPw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:qkop/RBejh3g8tkaG4RLCPv26XzAGbrsFTS9oJnx0D/lLz7Amq9lTDX6iSK9U84SMiwTvJ9RskLIpKG44mE5cZMgK6XVSyGHoDvDWNzfZETy9zA3wWHz7ucwC0QnnLbODtOK415RH0rJwKetfTrrqnn61/0xAzvIBnAaCCljv1dtgbm5nbcl8jnFvtWTldX1cPDp0Ds10E+OlNKNhhrVmXWTX2DVHEYopw8X0U7SsEg=;20:RMOacR28ZWnO+iG5zOzuZy+8yjr/7IHhQZDHvAFxICecHxycbbQmUuKz4Ca1C2nUZVTjzos9VwJq0YKowUh4Nig1hiRhamP//tgZfvN6Gv0IjiDWRb+TW6f979CHg2aLjfdpZT/pkeilD8mdW8dxHDr5iMQOSGZsSAdm9vFwSKQ9r2hqxd8yhk6+prVziP1ikS2+dYBgH3k2dARxk59HggUaJR/pZpqeDEPSkpVA5TOAWzA/xePt4rMjSsUzFE/AlVqxQTd8+bf7BcoSeJDsHF2Y1LuTkbps4yDOwkRzhS7yz/bkU0Ai1wE1Isydudva4nhmzwS+u17ibAuI9z5uFrkLXsI3PEQbTInQLRD3KCJRkUxXIEH14P8fYA/U+OIFVh7j2wMF8nxqrZ4KEt7560e2FZRIeLhTZgBYVfJ6xd9ARTCYEKyx4U0KZTcjQB26KnDLfz1cVva8lZgrhaefe0WFyZOIj9KX9i8w3ubJVns4HW+ziT/WnJmEk9jYL7fo
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4464BCBAD7E55B47A6ADDB2BB0CA0@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:dGna7bNrenSE/tQXjB3a9kJlrrqWOIIdbQGeE/Ns/Tf4XIRoDTRLQahCmfp1TZMxf8SVJlHj6TLwKXF6Rpz9n5xUVrSBfzUjwTasrjv4A67dMmmcDL6gmKJK+1WesRyY0zc0KfRm7oY0yF+Cb8LxFJG9PmHIOt28DtHaqGIP8aAdXntcVy9waqreOzTGCv8Cz9uc+z5X8q67ybagGSRgspbLLC5v3j5ay4lS/N8waQHkQPmfJa7JW2Qw8YiiYrvEcXkC6YNfktCbTG4noKwOOAAWNkOlILXXp4zntzUS3uhBRMy9wRFy7GjLDjDOZqrc
X-Forefront-PRVS: 08476BC6EF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:zpXo6H6yb+keMw1aU/cYKka3siU+CkK0zrM/Rlxs2?=
 =?us-ascii?Q?yNRNWIqxphHh7syoFQt3LEUPbTYNU8Rlt71O3EvRTZs4JOMuF/TFXWt3GFlh?=
 =?us-ascii?Q?OIsgeivEX7T1Gkbl5bYofO+ExAThwM3sEVo3ER2SYyhOz0r3vYmEW55AyUxA?=
 =?us-ascii?Q?fCXgTTGCdQ4By0JaAGDwUJogqyql9bL/qeQk1J8RncBHKJBJLSf06BjaePaC?=
 =?us-ascii?Q?0p3to+SCAUfFbzWAJjkZ1i2GX6ox8+eWHNNAwfQKq1jUcg1JiqALw95je2DR?=
 =?us-ascii?Q?kZjH2p96E17TYhjw/UpkNQDhLj2d0OzZRLefoYCDYUMIbxfZAlGh4g/ooFki?=
 =?us-ascii?Q?rxt/pTfDY93tNGgCVRzo8GTVWUrqqR0HN8r4Us7VFspegUNgD6Zy+1AkDzzT?=
 =?us-ascii?Q?cppyb3/SF+ZwVCX921+NRlfsOzFbVic7bzqIdhYQGCW5oauKXyVtQvHlHAFP?=
 =?us-ascii?Q?hjFfeuT8znDCS8ZfdDp0TMwwhG0fBLJBl3gfLZlrI8xkKCqYbGeTjXLhFOM7?=
 =?us-ascii?Q?3K9/gZhdf1LQ/MtPKyk+f0igdJCRfdtfQ0y/jWJTd/AgZuppKMRQb8CmDnGa?=
 =?us-ascii?Q?nzOYMV5NkSHShn1TvWQ+QAMYfa/PPTVoEsCiS+7IIrbZj5sw2JHTJ2p5jin3?=
 =?us-ascii?Q?Hp++YH1mm0yDpnE55mq/t1lUNTEEg5yHIOBAi/59lMUkwj/Dy/PwRPT0vgA/?=
 =?us-ascii?Q?jp4ulXrsR1yBcOF0UTG6MHa9N/1YNnqloiwTjBsASuSfaS9vKteFiaxXcHQi?=
 =?us-ascii?Q?FaKAm3ogd0Qo9BdKSN1R0J+Yu4EhzH9P9+tjXtcFJdeLVZCmD7QgLmFHibwY?=
 =?us-ascii?Q?dJ4SzKey1s4EzjDrofZm62RxHAvln1dBDfSLSJy9eIOlbSe5q07RRlaE2qvy?=
 =?us-ascii?Q?krGWA1Xxa5LH6dTdRXloQnKwU7faynVNmhEUoaF4uo83m8CeAN2ZZ6SCRF+1?=
 =?us-ascii?Q?QF4gmsbEDXmIQA5/jkUAMyTpD5Il4mfZibaZJGZ8a6t7UiQWGXBksAYo8xXK?=
 =?us-ascii?Q?ubVeo0Emk9yasSLl0Gs6ThhhfD4TbIvbR8c4m0fTjIcURnahu0IL94r/+Xfl?=
 =?us-ascii?Q?REV218oAzuJqYbuE1/man2ocWLNF8UmIWp+4IjwvfqFbFO5hm5EPcP548sNX?=
 =?us-ascii?Q?JVYuJCX9syej2M7c+ObOnjwquGRSCwg?=
X-Microsoft-Antispam-Message-Info: FrGSVPEZ8UcQBrPO4lU2C7Z1/m141wXPKc0D9xaQsWREZNXmD1XAiNN5nLcfFVmnXShi0ohUNbpONekaE02pBSwm1GPvdHkBmtGoKgaSYedgdqCca0nvIg4ByuVgzRMgOV2vxs/yd40Lsw0hnnt33k5hSHmpV6oLAqLiBQZ6jvAe2C7EeDSzGdsHO0wd8dLgRZjgrMmQgTxqBdDoHZl/4SzjYhxlUoReU67W3YzYVwmpqjFtRmNdyWGVFA9Hp4lu2QLw8uqqbt+aTKhg8mxoP3EAPCJKRxYyfeNh1R9epAuPFi2s/WvaQHigOuvUEpn2iI6SLeILI5K+Ek95VGXQQV2Oh4yTGeFkZ2VyR/wu8GI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:pvbmwnQ17SLLu54xyCStFWwB4XYdIRZVwEuZDouPBUCIl6U97JlPXZ35P+QFvCo9UdVrA2XKFiIX2AhZxEN0a9ywAtBQJQ0W4bCjRWPbJ0zf4jeUIicnCC8nal9RUGXT7N/H2LOlSimzNry5xnti+9UEEZW+yG/d7mFkRAsIF25HPF0k2GqqRy74QEpk0zUwHKPpjTf5sCB3xcEhebgStll6VmoLIX2SalB7nZrk7xEQafzO34z5aWFMyPm5e++tM6+NngLsaRc1lI4xYgEJWKbVT9ot8CsNL/ycB4AamW8kPjlhPTfTBRjhshSCXWAM8uZ7arkBsId7hCJDSOIHZeDkKf8G3MBZolW8wGnhElMHAVgTaPCXb0qa5pxDL+tHagdCtf1scQ50cAenUIClV3tCKu68KHfH0XPsdb3Pa/Nd0JAPQtiwOpawWMkoCgqmvLeMxoWZUuMz4CvG9zcEwA==;5:8nx9/lQ0a/1cS8pREJDCtVgg3Dwkx9HflDjKfcMZfKY4r/W7QvKz1NBsq1jeg0QDk96XaP+7zTk8JxIKUcqC6LC/XNFuV6lfRFoZugujgGrW9hQsNBMagXvj8wFSPLIG6/HNdrqiLi01mo0IOqTHaU/m6f7vzevxpKMX7KDIp8Q=;7:YWPYJ1Mli4MUR97y2G/TRjAMZ/D3HBQVXw5AdKkMERNvTdxtI6d4u8f6DfMgF2TMDaU6X5/zlfStnBuz8G1glMIyLnKyxTK1BS3u9hXbPgM0jwritikOvcuItmAoYpfHb2SngC7pHBrhF5XSZ6sg9w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2018 22:37:09.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d596cfce-d401-4a20-b495-08d6436f394a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce mailbox controller driver for ZynqMP IPI(Inter-processor
interrupt) IP core.

As the device tree bindings have been updated. Do not have "Reviewed-by"
nor "Acked-by" in the dt-bindings commit.

v5:
 - fix check patch warning on write a paragraph to describe the kconfig
   symbol.

v4:
 - make IPI mailboxes as subnodes to the IPI agent device node to properly
   describe the hardware.

v3:
 - add NULL entry to of_device_id of IPI controller

v2:
 - change SPDX-License-Identifier license text style in .c file
 - replace xlnx-ipi-ids with xlnx,ipi-ids

Wendy Liang (2):
  mailbox: ZynqMP IPI mailbox controller
  dt-bindings: mailbox: Add Xilinx IPI Mailbox

 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 128 ++++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 762 +++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h         |  24 +
 5 files changed, 925 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

-- 
2.7.4

