Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601CFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A12214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CAU6rNAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A12214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJJOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:39:44 -0400
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:22144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeJJOjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjFjto5Wzex9SnMfRixtu1DSRWn5OyPjpMhklWi9KEQ=;
 b=CAU6rNAx+MoarEnmlX0IQlUgYtkLzxmT4WJ6w2snGs+hLHnWdq3B8GUiuh/VsVs09JuZbhjN/2EpaS9EHRDAEW+9wm7j1on2Fzvb2Hz9UzGtMfy7J582VQV/JC9MZPCVwnCeuauTIpXqonmgYjiF8LJYWSlDzC21rnO7zGooVUg=
Received: from MWHPR0201CA0047.namprd02.prod.outlook.com (10.167.160.24) by
 BN7PR02MB5218.namprd02.prod.outlook.com (20.176.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Wed, 10 Oct 2018 07:18:52 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by MWHPR0201CA0047.outlook.office365.com
 (2603:10b6:301:73::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Wed, 10 Oct 2018 07:18:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Wed, 10 Oct 2018 07:18:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43493 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8lf-0003YL-C5; Wed, 10 Oct 2018 00:18:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8la-0001CM-7m; Wed, 10 Oct 2018 00:18:46 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9A7IcAa002129;
        Wed, 10 Oct 2018 00:18:38 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gA8lS-0001AF-MM; Wed, 10 Oct 2018 00:18:38 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v4 0/2] Xilinx ZynqMP IPI Mailbox Controller Driver
Date:   Wed, 10 Oct 2018 00:18:30 -0700
Message-ID: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(2616005)(476003)(36756003)(126002)(426003)(44832011)(486006)(8676002)(336012)(81156014)(81166006)(7696005)(51416003)(26005)(47776003)(186003)(77096007)(106002)(48376002)(50466002)(106466001)(5660300001)(50226002)(39060400002)(4326008)(2906002)(107886003)(9786002)(63266004)(36386004)(8936002)(356003)(110136005)(316002)(54906003)(478600001)(305945005)(15650500001)(6666003)(16586007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5218;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:R7pJIu9gdX9zEHXo3ibC+bw85+f1i7VlTyHQB0oWNm01GIdzgcsfIYkBmc+4tsUsWzMkMlzAEiFoOr0HIYtvGrgivqYKuoADV9Du0X/kkOKwIm3U2TlsiSNkWCyysiUW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5ead6f-f730-4963-506b-08d62e80a181
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5218;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5218;3:hJbO9Fei1ogAOf/pkC165yJ2AyWBgth3L9/jFk6JEt1X6NZe/DP4O0fUVX6KxRLWh6YYkCc2vN4Mmm9VlCol5CTdasrrjGWbrnWF64ivTuE+k7ipdqCsrZL/r4mPfmTL1cOVLKbnAR9J7idKNTECA8oDtTXiPtDENqz7o1eBhsTMotOCFibyvbCMxJsVt2tS1coGWu889oEvXcYNuwfrtxJFcVG4c9MMwq3zu5x6iJsV5vnc2Hulx6dPvPQSeTlFkwGGQ+5WKprmIANfIn6nvMYqJiFWHQ7jp2Qc7z0/G1wyDSeh6L7l66Owu1xz7eoatQ+EQA/5o3jjUgqBIGDaZvXFcHQEjeoKt3waVJAds5E=;25:QP7b8vqAZPaugd2ZUqMSOWT640AnxONU5ZPRlr2/n+62ve0geO9Pa07GHjqaBtuX7Y9s/E0uDWOADa/xah9Pg0XBKcrDjdHZnTZesXu+4r9nFkge/qUZb7PfzmymAk5HouZnaRLrYhat2oRnk6lORU40mf0U1BiJoVEtn3kASHeVCQ/9nGFWEnoXKeTTHeTpBGXdc95QGw9sdPKsvBWAZwrk2SQW/3WcaxSpA6Jy2Rf5S26MvPoFqohs4d0NU82+sEXZLi6LRbgE9wc9NUt7VY64kke1g0zqG6Hls6cYe1tDS7BOjmFoNB3vSGyM7kxpQZBb3FMA5jdPOkiR/ApUxw==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5218:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5218;31:PTYNsVs9urU9m6rVeaepzVZazq4ns3NY1ZQtCPcsFBATOtf1QjZ3sw7Ny9ZbhLJLU7xduzfmQ/MGKVBoHmKF1eSXYsI04G1Nniz9PwcnI1igFb+sHNpWJ/NqHmVPO8PV+gREagVxuo6oHEfggIV+7xBfj8d3H/ISowj6Z7j0Sfxf1cGu8gyPECwTQJ0lLhI1LCd12oYJDzwQ7E706HUJiphFun0SMGHJWT42GHQTNKo=;20:XQBE/QI9ra2VwGAKKghyDIG0YH2koBVxIuXNCvXERcuNwnwCtS7APamavJoDl0pob7D/WUHtCyjaJdWUPC0F+3/5wwiYDq3YMWRlD7v/AtETEEUCZWF+XV0I8zjRWfynEyA/5Ho9d23wxXeDWTg108pWL3bDl4Q51OEkbZUSsF/eAIdQgJ2cKqwABca33I3wa1nhPtgxJL0wyW2u1sjXv4iOr4vHOK6wV2fky9FWgrIvAVhjI1+3wBVunGYovwf4Jx49sQUo/+xrTKk+pfO6TcLFez+amFYV/l/p2nGiRwUj2xM1aSGvupIP8K86xlomNktFk4U4eWcOC4W+ZaaxLYi17gcMrQmCltlohZySmgk6+mGumXOGoWPCtRxVXF3XMT0Sv660E/WRwugcmflSNxNh5AHTsW27hzKQ7eAZQxcr0ekhfHrI82AW78ka5LdnjXx07+KcNpWsKg4Hw2UVAxFBU9gajX8Ksg0MiTnM5ZCP32Pc8hVn9FatMm1dk9az
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5218242EBD232752C477C213B0E00@BN7PR02MB5218.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BN7PR02MB5218;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5218;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5218;4:istq+f41Svjb47vpILKUXiT+e+q7hmhV+OUZ2+xwB6o0gs2D5MFjgHFtLRPVs/TUz4xUriCloeeP8qM0UCwTLFmaUfd8SPN1XJh7vYgRcXFvTJr4Jo5i8UFOps5BQxag/9wiocltLWji8WB5/9Xmmsf1eRX3U4OVHXNgo4ass/SY8x9xra/AstMSH955U7uF9/kCVr2PNNXWQE2a6MLQ52rKJWn3JmXcXiWKqhj7dwykJ/HxYu8CpGYeBVWiC7zwc8fjeHmjxbEbRAH4oMuLNkPF3O2zy8KyhZAqkd60slKAR0bYxwYNt2HMER8PUeP7
X-Forefront-PRVS: 08213D42D3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5218;23:SbYqQeFdoW+uospr72lnjDVDfKrveOY85c5W7Kxe8?=
 =?us-ascii?Q?nEnBjgslDkJLCEboDTFnFxJ18FzmasSWTBI9R6elzcc/978gwkiwAMQUjS7x?=
 =?us-ascii?Q?df2cUIxhfJgZwi1XAQ/RSoPiAQDnTk8ZhAdFAsAhbr9uUJjKqFBQ1Khi2i20?=
 =?us-ascii?Q?N912fy86X75GWEzFrVhLv5e/bmjnBCAy/CUWttP/P2SJmgHYTrA9Pg39fEss?=
 =?us-ascii?Q?ukj5ahYL/2dpjoqq4DHnTMes9mkm+8s2219wiyRbQnmXB2ByREDaw9NHF0RC?=
 =?us-ascii?Q?Y33oCclcVF8VU1mNiswBDyKEUb436nOewNGbuDOClE6HYfdZ+8M4/AC7Bao0?=
 =?us-ascii?Q?C+tdWqGUIXY3EH/ZdXcXEjfxG08XKtWOwI4ujxAuvwaHYF+IDv2m0FDFHBjK?=
 =?us-ascii?Q?ztBtF1t40hORVeYk0JA79suYNELWe5jIIDUoj6YellTbhigBmob3TmW9nfUT?=
 =?us-ascii?Q?y8X3TphckexxBCMXjYXAnkBIu29Dl5pAyP7/m24+1u94UQXMrDRsS1zljiCr?=
 =?us-ascii?Q?6C9PEsaZlH2c4SkwuaK8BkwHHDQeHkAZfkVplZzUBgP8mCz3R4E+gSMp+81L?=
 =?us-ascii?Q?kuCFF7vTuvmDSpHN9BpQEOOaQK0daKo/KyhHVaZP+nRKjO3W5/B7MHOAiyzw?=
 =?us-ascii?Q?K5CntHvrT3bjmIWDHZgahniF2NO/OnXBBQ+kjcy9lZnzTexHBvUbRfZkbVrs?=
 =?us-ascii?Q?TZlsc2VV+BpT5fHGiCoHDx2C8V2eI+JocWacPDZNytEAOTjWsh+ckLrGxoIx?=
 =?us-ascii?Q?ww4JqebOmtPx/05R3jorl53KQLflRRNxoMTWglRCHXZnSWFvntwLBB0TmslJ?=
 =?us-ascii?Q?hlFM1Z3CV/Im0/MBi+7W6EjAFjGhHQX8zAT498WSyVXjMO8iZBiDCsv4DfJR?=
 =?us-ascii?Q?T8C03ES0jlGz+/TrIk2Umc7txCIRPSyTbbI/c5tIYWdZE3zv2r/NrByWQlej?=
 =?us-ascii?Q?gDFSXDhxK80BFWZw/OqGNHP8WMac9yH2Iwf27D8YYuJOvl7HUyShrvm4cgNW?=
 =?us-ascii?Q?tBO3gwqysSM2f/RX32HlQuWHQV5uUgHUIRQJt9yzGKcXRmctxeKabTs9DWFF?=
 =?us-ascii?Q?Pa+ElQHqGfuXatYIvF1n5VnqwP7s7JXoarjg/KdYJJKhKjrBVcvJkDs9CISf?=
 =?us-ascii?Q?tHOVqYULh6QK5w172VoStk2RBJoUQMnPLMf9njr78lkh+VMbeqUXQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: esjIE0Fo9KoJzbYpjr/t0391AwcHsLa3zi30dD8Ofp4Iz5X6RUP0yufzZApMupoBOGuCksrMoW1zJ62GsATlYQLcqyknuI8XLwxkIiNgl4dpJzp3j3tZ0CDrb1jVYaClo7lY86N/BOMRzlHuUqiMLJCl7sdbiPd/rZIUIKaWAl4R6gX+0JsF3VbIbScS3K27Svf/LmhQkeCb7I+JeH1bCiGOSpKdfIf6mMQyQzHo8cC4FJiDCN0IjZ2n3kLHkAKtiA4HKmckjK2wcF2IHB4TYweikGl0FfgfWu9AfcURKfSxpIkxGUZlUfKJGMdPes3SfTgCF/fX3You84SC+X6h/V4zCjl8PwwNBWEXSN7lKbM=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5218;6:87Rxz4THZoRNuUDC0lwAvA4W5/d7LDzSuCuaOFcnS+T78h/9hWBbZOoXsa4MJHs3onaHbCaa5vpJ8aB6Oin2ZZVvVF0UB1qO2TNKg6qRku9BJcvxAR5ECcK28ncngcaCo5SWCt5PBFcw5OGzGJKFpmT4EqwkUvrjuqsRnq1p6HHoqWzL6B7LPEnOdle7ZGF3lxiVQCWp2DJg/GLRqH9uh7Ty9I+kEvZQn3NqQ5YifJh7EiW/SbmLRqzy/O8EURPhkvorT1XPZgdb2CZ5LIV1N9MEMg9zsF3hdgWYkEF0FvMw6Kk93mbxJt//SYwJk6/4b59z4vlnKHdrcEawaTuWXzICnlcEe8KcvJR9cvkyn0uxYIts1Ihwr3BbZmsRarDyqpsv4WOijFzsOActbE54oxNEpf7Imeo07Qx7SlpvFf6j+HBmcDdhGuLQkFldOPrkK8Ik6IqUBmhMcN+v206+lw==;5:xwTdxDjR898D8NVLjtiwszw0zkbIVTIPq2sG3BCadXXjjFeXwR38HebTDRS2vImGEMyMpElDk8Isk1Y2KxDe5Z6jGPJZQQjQxWLjm2Av55sHassSZXHTizzsCmHT6ljmKFQnPuelJ5dC/iwOC5+wS0oEk6dRtkuBp1FzE6uQo3Q=;7:+qHQLuPDW8onfeKyxVs0pDQuzYqL9RsXaXvDgak8fYKQd/45K3yKq70P6u+6pQ+UE2tin7s6U6CQIGMM1l5FZb6QLiSGl1hJgPo1bjmE70md1uVgNUb4pU3c/h7RXCLQPrKxG8eJh2tvIw7tOY9CphU3mUNUXLRcvIQNMwdIWVouufI4Jn5HRFmRL+ygQQs8p/W9mYvwuqTpGwUT3XWnLN6HgwtvJH5DaHqwRBecHiTt2qZzv7v3gfQhBZgdHItR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:18:51.7458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5ead6f-f730-4963-506b-08d62e80a181
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce mailbox controller driver for ZynqMP IPI(Inter-processor
interrupt) IP core.

As the device tree bindings have been updated. Do not have "Reviewed-by"
nor "Acked-by" in the dt-bindings commit.

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
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 762 +++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h         |  24 +
 5 files changed, 924 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

-- 
2.7.4

