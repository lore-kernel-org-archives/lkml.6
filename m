Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874DAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A2620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QKzeUK/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A2620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeJaMhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:37:07 -0400
Received: from mail-eopbgr720054.outbound.protection.outlook.com ([40.107.72.54]:65248
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729146AbeJaMhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3JMmO3sZtae+iUigaCJ8lUem90KgSheSRjTWO+7zAI=;
 b=QKzeUK/DUTZJ/ewWOr/8g+TZKE4NWbC5HdHAE+hb5ctu1gonanCHbKoIhl5eAyF2mvubraZwFIC8KfEUoa8AefY03W8XrlPDR2GGiW8iMK2vlPSeQt+we1x4Zve8ZsL15p8AKwWu3mMqWSaiWpYYAaBBD3dBUsDckyKXO+sXkis=
Received: from BN6PR02CA0108.namprd02.prod.outlook.com (2603:10b6:405:60::49)
 by BYAPR02MB4456.namprd02.prod.outlook.com (2603:10b6:a03:57::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Wed, 31 Oct
 2018 03:40:47 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR02CA0108.outlook.office365.com
 (2603:10b6:405:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21 via Frontend
 Transport; Wed, 31 Oct 2018 03:40:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 31 Oct 2018 03:40:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN7-00012B-B5; Tue, 30 Oct 2018 20:40:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN2-00039p-7U; Tue, 30 Oct 2018 20:40:40 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9V3ecDO010799;
        Tue, 30 Oct 2018 20:40:38 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN0-00036w-3H; Tue, 30 Oct 2018 20:40:38 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>, Harini Katakam <harinik@xilinx.com>
Subject: [PATCH 2/4] net: macb: Support clock management for tsu_clk
Date:   Wed, 31 Oct 2018 09:10:21 +0530
Message-ID: <1540957223-30984-3-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(336012)(186003)(47776003)(426003)(11346002)(446003)(2616005)(476003)(486006)(126002)(44832011)(7696005)(51416003)(76176011)(26005)(6666004)(356004)(5660300001)(77096007)(107886003)(39060400002)(36756003)(8936002)(81156014)(50226002)(305945005)(8676002)(9786002)(50466002)(106466001)(36386004)(48376002)(81166006)(2201001)(63266004)(54906003)(110136005)(106002)(316002)(16586007)(478600001)(4326008)(5024004)(2906002)(14444005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4456;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT021;1:3eGGPQFrhN+1GIrbU0li3YGxkVOvCYh6P7m+gDAWud1FFoSQgGjWcWr4T4N8njBkDNsqYh/N9BRYDvloIOhS5ZX1xQsnEpD116PXnzz/sy5l35ip20qGlWbgq5mFFMMX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e562397f-14ba-4177-a60f-08d63ee2a460
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;3:68DhvpT5RJRGuGCDvSuVgqV5h+p02eQ6l9ES+bOCLbem0OIoiMJkMdgtM7+u5QeBIkGo/ybSw5tYxGcNU/6EaxGrThGawjETEvANo9vqBqJa+3BK0VQIdT81VI0uG45d9RI/JhFl3TOLYGLgY3ZHWjUZiJqmm0HCg14BP9EiTNuHmydTZ2rVSbecDiTs7sciVDGIjfSyPJyUchmSHSATPTd8xkdtR6yA9QfeVHmDrzr3nRyQsLtmreguTRyn1V/FQJL5TJWWLWDzxp38xNDmdu69W6VgLEsuo4Kh6xsv7B8jlIo2odD2ZJC8oAJWhcTokruzD6qVcyvn5BUo1R27ozYXxZpqTk1Xyhcf/LbUZ1M=;25:Bii1GL6Gz7f1MaRNyh3tnaBV9WTif+PyQKYajevLqgU7ChGFAmdoFjr6eN0hQ7vMWkBeo8Gmfbl7kUdNv0n0W28QmSTyR5hCggfP/pv4lTpNaZqHRBqonq4Hc/bpCOrRFdQdTchvVokTXYnvwKJ7j95SGgK8oFk25nsL0jNLP2XTGRnpM7TmWEcU2lTTicHKi4LSW/cDO6PqjT7iHnQQnjMBax2rjD6F30WZ6viK//XxjyYHrCwdad4w8g4IduJqWc3vcy05XCe0V9rRoF6JZeNFEZVRJeFS5uOYUo8E3N88fc8RckddSew5t+pU4xsZ2j4W6ioMZEGqySJvCZdecA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4456:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;31:yAbj7VeF+AyaeHiA6iw5SkNosy02kLoW5HZLhLxbiJUDtw0mE8dlLalXVsPjTjzJDaLZDdahVfKrE/b9gADrjoc7GVRlOLdkDsF6476PIui8lenC+1IQVv9uSiaOh33HV/TkBd4ViZQf5kZI2dW3F4l2Wy0+0UK7kLq+dVmYMqJYJS9xB75OAWwO9Tp3V9CQCpCzaz/9G7JhsYW8ipsI1DC6TSO+fqwfn2zXiE3GwHo=;20:lyuwaKRWQE0SF1w7kevcPItzIjJr3AzqZYZmRVDGcdDQXXEmeHAXKT1VEYRRcELZVlgjocLdNbkdCqEzHOD6fKU1lVf+ZKlZ4rNA6qHcsxQrp7R3EQZspmguyiHShKS1Xu7pPYDDhlmyN8jqtgBaZ7f7GiZB/wIcy0UasAANWpiXWxd8XNRoKDIMBEnRTgno9tkd3C3sAmd2TAFUPtnusYcr/2kGHqXt5ksPK3buKzaNWyigPunTAdZ5VFJ2Xelp+D5yKTKxIRcFknmAz+FKkJrsvJXIEXgoWOZb7EWrHZZSr/NHEgZe2qIl8gK5Tn1NoAR+YWBbJFY5xsGPkSJLK5aG+B11Y/qOhRBZMijN32yerHPbf/2kYe6GULeSZoN9e9Kd/ybSE6fp6jAbn9CxgmNK61vY92RR4JH6WN/l6P39CCeSoIZP5ixVjF1WB5lBIXbUd1LK0BhECDj49fgRjPDdeDZHWZRsgk2MbD3KSW82fwmbAUr0Lq2tbbYDU5OV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB445636F18742B34AD57807FCC9CD0@BYAPR02MB4456.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4456;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;4:hIDd/j4VFN0MH4zLahBKttJjV3c1+FkCGUd2NXMWw1t35bWe+hFYZ3x6cLqZdQK751rwUkureqZXBdMtLin9kkJXF2UjsFjK1yyQq5yVm/BSc8LTpeIJ2u9I/02l4NNWrUaSdNO1+/aacZwBxm9KNve1emcPOaE/YUYVozvgyk/0jOIm4pwxDqTtUhxYvgGGcxp93MpNxXkCNvXxudLxo28CnJkiGEKVdrKG5wm9mdAQ9tcrWq2AuyG94on8StPYy3xFflgy03oQfSKH1znVmVVbB9NYI8wJLUtkbRF/V23coVL4KoOZHsjszrX8yFUD
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4456;23:lDGFm2YrYD5NuFZF/rHZ2sTUwCqyeMwsBIKxUhNZY?=
 =?us-ascii?Q?DKOoWe9CI65Uq/z8lkJk16G7rUB4CkAlS5XJS8YYIJHDvm5k6lXGHnLVp+y/?=
 =?us-ascii?Q?7HQm5YD54/WIv3vTQrtWcM6x0U+plc9VtyVUks9YVoOTMlo8nscpJ1+xPDRu?=
 =?us-ascii?Q?lvhGNHM85z0C+xBw5cn0nc/dGuCXwxlQMRZzZe5DEb/PiI6lt56TYbA9aN8x?=
 =?us-ascii?Q?laQ6lmDnqhOrh2z4fTp5XDODxCT4nknAy9Q3S/WhdqNlWZ8uAGIXbq+Qex67?=
 =?us-ascii?Q?x7JWUUqCGWQ0sm7pHkn3qIbe+vLcfbfGw+57rYIxZwzi14fNrRbsCeyAViBD?=
 =?us-ascii?Q?EQQyA7bKoFQRpp8TQ867msIG59z10xMbv2J2bAlHpZfPMY03rBYnJTCtRDWV?=
 =?us-ascii?Q?SmzQxtW7DSkmuHxOKNGYBCCKUUzd2Q5s7aRS3nZCSdip0NGCoo7SAFl6GLre?=
 =?us-ascii?Q?U/XvdXoGdw5hTfwtx7ZHd7CbmaWiY3eiGsVNIFViNAHJ1yNVynYFHwt0+r4Z?=
 =?us-ascii?Q?Q8WBV3UBpqZClxI3aYkBPwKkZBH/KoqvCduycWaHXNHBzw0VYroE8NGgm+Jq?=
 =?us-ascii?Q?GniqAvlaajuP1+3eUg+XaR6R2MHtKncVBH1RjUNycAN9SoJ6P0CD3FAFoD/H?=
 =?us-ascii?Q?7o5S63BQDe9H4ddEhN5qWSbE4URLc9J84Mkp2BF1BNGy1sH+BkAqNqrkgJIr?=
 =?us-ascii?Q?FXX0Br2q4/SO3NQ4y6dQUB/4b2N8JL9bjXJAlK7+gz3G3hE8khT8JGMj/a0R?=
 =?us-ascii?Q?N6mu/dxfJoS7vNclPZVt/nUEd+J8K22l52KmUy+0X2/Mofl9WyMUVQ39b8It?=
 =?us-ascii?Q?D7BJn0n969t1k496+Io67M2xpCmTXOeewgOhEyf7tU+ROjkCUTMSRRwpdsW/?=
 =?us-ascii?Q?yw0IpcHnBm+X9Helwk6DHMt/7sbot4PvywXlzZu8FRNfjnSYlHq6ZYzOuIRP?=
 =?us-ascii?Q?IyYCD0zBI3oftOzmlmWLpq4KEvKESFPOe2bDANxDoMInGt5pke9pTgSBeKmV?=
 =?us-ascii?Q?o9gmaZnGZN1JHzxsqB3szOsrH1B304kMBp38G2XOmeGlgHw5y+rhowuVS2Ab?=
 =?us-ascii?Q?fdfbQ8sSiFOlLAG4Om3jOuATP0zceWkYR6xlKkI0cpdqqC5amuIiPZ1rBPnR?=
 =?us-ascii?Q?man9CXxuNvjDC/pKFXdUhKLAxO58ZzYSUDvWOIXN7lKd5YtRA2ZB/bVKUNA9?=
 =?us-ascii?Q?Rv+/e87JEs7fp52kVnZp9YAdAwFKG8tdaQ5?=
X-Microsoft-Antispam-Message-Info: e7fKr951ZG7IOLgjhvqQi85W6qiIOscZCKvqARq/c8/3Ona7GnRm7TjwkTSdcG9kpvx34Lb82f6X6QqaY1kqmnoyloMG/9nXTtjep+FWx5toLSSz38RUklI3j6lQmIimlhU0Z+XOSoVjSh7xCgctaZYhQbruBYTfQUsrbyvsRi4eSAUtvfBA5d/MW5/x7V0ha3PinvQjnpvX9z4hpLcUSJScDkRp8jb8XK9XgjJkcXcEZcIokeLKc7ep7Hh2Si9srAtP5LTjhL7avSTTIFqkvIjIsI98TWDM/gEEcP7tX3bLTcQnUDDAOFmfAG/z6CHTulfwqLF2k+guxBLIUvPzSld5TUTRBlfHziMtWxrcPEs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;6:52GRVk5hlnu4CLbTdEnYdMEKC0pX75e/DRH7s5SYxLSaqT/gnUki/Dn6aGxp12bPc2vqn+fTBrQMDAg/2ZZfQkx5N9iSyrjrJfwy1HO8h8CKfZlM4Xj/GCYHBDo25Ki6ZWxwEsaJSv5en7PW8RWaxF7PRO1+WQZg3gcWjje5kW+7pwjF137wymuqW21IWlDxsfqBJoy6F9PBS4es8eBYLRGYyErEHFhprC8Q+EosOgy/CBaS8m5cmCDAS/lpek+EDRP+W39lB/ladIv4+qV7/AgWLnOsxBLuyRt1Tz5DzLVo/Cu1wY8lYEQrxfo6UGxCpqe18PiLLDpSkrbVISfYTal2S9xlC3Wmzmofc8ilFTv+u5qEo6FEo7tyvy7xVx2kwKQRz4K5jCpiMRHCEyCYDoQKSbVX6LFF4BJmgmvv1pHpyV0wfE0748xBqNY19IdmPrV1g2DzisvAWNlTss/2ag==;5:gYZDEnPJzECbeakwTarCfUpPk7+w0GF/92EuK7MATTAHGgrnzvuKBok+HvumOV0fBvs9FE7/MHmoOrB4eRp7frwg2RsIU3YejyUXLAt5Q/ea1XtY62S78vYjhyvbZD/VbY8ELLCigKLVNy+ha2Et3O+5/ip54UbpOMSBL0u8QZ8=;7:VLPqlShlUkIA5n63kq+B4i+g72JTTTI5G1NpxBm6Vkbu17eSZoWq/GDaYgWKfFH3YGA2Ace9u3OTqayzSmCXjwpyAK+uPoxA28YGszCXM4G6Ux4rBqk+203FoEk2nDz9XC67EqoE0Hf+WAsYb5y2QQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 03:40:45.8488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e562397f-14ba-4177-a60f-08d63ee2a460
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

TSU clock needs to be enabled/disabled as per support in devicetree
and it should also be controlled during suspend/resume (WOL has no
dependency on this clock).

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 3d45f4c..6f2b4b0 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1082,7 +1082,7 @@ struct macb_config {
 	unsigned int		dma_burst_length;
 	int	(*clk_init)(struct platform_device *pdev, struct clk **pclk,
 			    struct clk **hclk, struct clk **tx_clk,
-			    struct clk **rx_clk);
+			    struct clk **rx_clk, struct clk **tsu_clk);
 	int	(*init)(struct platform_device *pdev);
 	int	jumbo_max_len;
 };
@@ -1162,6 +1162,7 @@ struct macb {
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
+	struct clk		*tsu_clk;
 	struct net_device	*dev;
 	union {
 		struct macb_stats	macb;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b4e26c1..7ae8d731 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3304,7 +3304,7 @@ static void macb_probe_queues(void __iomem *mem,
 
 static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 			 struct clk **hclk, struct clk **tx_clk,
-			 struct clk **rx_clk)
+			 struct clk **rx_clk, struct clk **tsu_clk)
 {
 	struct macb_platform_data *pdata;
 	int err;
@@ -3338,6 +3338,10 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 	if (IS_ERR(*rx_clk))
 		*rx_clk = NULL;
 
+	*tsu_clk = devm_clk_get(&pdev->dev, "tsu_clk");
+	if (IS_ERR(*tsu_clk))
+		*tsu_clk = NULL;
+
 	err = clk_prepare_enable(*pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable pclk (%u)\n", err);
@@ -3362,8 +3366,17 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 		goto err_disable_txclk;
 	}
 
+	err = clk_prepare_enable(*tsu_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable tsu_clk (%u)\n", err);
+		goto err_disable_rxclk;
+	}
+
 	return 0;
 
+err_disable_rxclk:
+	clk_disable_unprepare(*rx_clk);
+
 err_disable_txclk:
 	clk_disable_unprepare(*tx_clk);
 
@@ -3814,13 +3827,14 @@ static const struct net_device_ops at91ether_netdev_ops = {
 
 static int at91ether_clk_init(struct platform_device *pdev, struct clk **pclk,
 			      struct clk **hclk, struct clk **tx_clk,
-			      struct clk **rx_clk)
+			      struct clk **rx_clk, struct clk **tsu_clk)
 {
 	int err;
 
 	*hclk = NULL;
 	*tx_clk = NULL;
 	*rx_clk = NULL;
+	*tsu_clk = NULL;
 
 	*pclk = devm_clk_get(&pdev->dev, "ether_clk");
 	if (IS_ERR(*pclk))
@@ -3968,11 +3982,12 @@ static int macb_probe(struct platform_device *pdev)
 {
 	const struct macb_config *macb_config = &default_gem_config;
 	int (*clk_init)(struct platform_device *, struct clk **,
-			struct clk **, struct clk **,  struct clk **)
-					      = macb_config->clk_init;
+			struct clk **, struct clk **,  struct clk **,
+			struct clk **) = macb_config->clk_init;
 	int (*init)(struct platform_device *) = macb_config->init;
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
+	struct clk *tsu_clk = NULL;
 	unsigned int queue_mask, num_queues;
 	struct macb_platform_data *pdata;
 	bool native_io;
@@ -4000,7 +4015,7 @@ static int macb_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk);
+	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
 	if (err)
 		return err;
 
@@ -4037,6 +4052,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->hclk = hclk;
 	bp->tx_clk = tx_clk;
 	bp->rx_clk = rx_clk;
+	bp->tsu_clk = tsu_clk;
 	if (macb_config)
 		bp->jumbo_max_len = macb_config->jumbo_max_len;
 
@@ -4152,6 +4168,7 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(hclk);
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
+	clk_disable_unprepare(tsu_clk);
 
 	return err;
 }
@@ -4179,6 +4196,7 @@ static int macb_remove(struct platform_device *pdev)
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
+		clk_disable_unprepare(bp->tsu_clk);
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4205,6 +4223,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
 	}
+	clk_disable_unprepare(bp->tsu_clk);
 
 	return 0;
 }
@@ -4225,6 +4244,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 		clk_prepare_enable(bp->tx_clk);
 		clk_prepare_enable(bp->rx_clk);
 	}
+	clk_prepare_enable(bp->tsu_clk);
 
 	netif_device_attach(netdev);
 
-- 
2.7.4

