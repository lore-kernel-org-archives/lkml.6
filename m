Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EC62086E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3bGG1xEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EC62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGSKse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:48:34 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:62240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbeGSKsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcYVSwMWFK0jNTK4gT5+r9eX2U1CbEU3Nm6J8JrdyJM=;
 b=3bGG1xEPcUJSNXEeb9ORXdf2M84WsQNtstXAC8GYf2Y1wK0ZXx12G8pZyvNoJiCP2sBRNne+3fn+Rl2sTBaKUxJGtQeUy0X3zA2FApfZUwhsbDTJSZgljDPVedn5BO0Jzf35hlxU62gHIPROepWHSLxZginVbNWZIjpv2Bn1tjs=
Received: from DM6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:5:1c::38) by
 BLUPR02MB081.namprd02.prod.outlook.com (2a01:111:e400:811::11) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.20; Thu, 19
 Jul 2018 10:06:04 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM6PR02CA0025.outlook.office365.com
 (2603:10b6:5:1c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:06:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:06:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43924 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5ox-00005L-5h; Thu, 19 Jul 2018 03:06:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5or-0003wa-U5; Thu, 19 Jul 2018 03:05:57 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JA5p7F008714;
        Thu, 19 Jul 2018 03:05:51 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fg5ol-0003vh-8q; Thu, 19 Jul 2018 03:05:51 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7035E1215B5; Thu, 19 Jul 2018 15:35:50 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 1/4] edac: synps: Add platform specific structures for ddrc controller
Date:   Thu, 19 Jul 2018 15:35:44 +0530
Message-ID: <1531994747-15196-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
References: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(305945005)(356003)(2201001)(81166006)(8676002)(81156014)(8936002)(5660300001)(90966002)(6666003)(106466001)(63266004)(103686004)(4326008)(6266002)(107886003)(50226002)(50466002)(426003)(11346002)(446003)(48376002)(110136005)(336012)(16586007)(76176011)(26005)(186003)(42186006)(316002)(54906003)(106002)(72206003)(478600001)(36756003)(126002)(476003)(2616005)(44832011)(486006)(52956003)(36386004)(51416003)(2906002)(47776003)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB081;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT021;1:tGmBTaHRFhAsMXKnfBQJ6KXEWygOEygrt4/Wq1a2RJwCwlFloeIchU3Oxk8M8wC4Ic9FJlI5hxGQW+Z3Ge8x+jgdh7wVf/YQJot50kNAYwtJHo338FRT5H9/WaR4Q5aq
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f959efc6-2f30-465b-a543-08d5ed5f3ccd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB081;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;3:BtluwEgJh8t+J0Jnf5hzqMrDzmW+Mun62vaO/RvlI+x453N4GIjdtHYfZcTtkCtCEGoc2GWCHasfzkzUaLLEWZ4RdtBQcevXybMVHhHQTz2QvM3/US0/tLLHFPHMQYlY1yK7GVCjt0januS240po+ZQMYtrE6h2PnoPnsMx5RW/rL3WuTSMQtmD3vhGjg02Vh37I6FSRGd5mb+pbHk3Zo0JW1J34DbMBM6mbYsZTvWnB9RXLLJ5hxKYEji+7Wa4y/mb9mlUJw7cCE5610B2dJVkCFbR1FDthu4rIZCMBoyoEAXXY0hEjyw9ZCnV/OmLsJwdjl93VjHScVQc9gf6Kw3FGICQvXVtdTjE1lIGO2kU=;25:t5sswvpHwkGDchdeJQx2NwWU+aliHypDzdZUGQmsQAbGBhSMAaRmJ5aLXc8qasIEmkxjU7mnCO5CaIoLyhKgpHkWKoi170lVmD7N3GzuQ078YLJa4rPX1b2mbNY1rDKLyDvLFPBhRS/YH1Bu5oJsQCmqnl2Nil1OwZ7L6lhvKE4MGn+iE3Xsw/H3dXXhL9J8LwhavkwzyvGnaHgDkR+ODMkUkp4GVl6c6WlI0cTseSF8Um66/fi0ipvr0Ew07aEfN0onVaXCJvKHLd88/hisbHviommm/5Fq32AvfHyzYyL5HWQ/0iXhw6ZG2PmtGZu/IWt5BhFxuFh8wEkKwWNO4Q==
X-MS-TrafficTypeDiagnostic: BLUPR02MB081:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;31:IZupVwlGUH++44aevOKsDz3ITSIDLEsfA6m9wf8yd2EFoX3UdVYFrzi+8+sF46P3Nk6sotvNdzFz6xcD0YTK+kVzf7HiMjVmKINLx0fUjcn3FuuHnC0Cv9LIE42KKbcUMw/8HxwlvKVuFS9LokyqOik+WCZfut1XpVFPhzIMC3p8EKGB2ZJYzhzaFqmBYLWzvEwewYbyAsW1YsP6MY5+8AAEjCMqRDPRLAdFHWZ/lIM=;20:ulqB78txu81GSQzIztfQPUGIimMJzXaMEldv0j5w2LOzTEplGdWWV6Vtv306i/wWVyBPo/Ygpi5YtUZtzfQOjQ06ZyAmBKz3sldkh7GZATv6ZSuKGC7a3x3HkCfuxiyEud7cKNBjZVQCp8hQt6g1bFjB/ZxXqvzY3Sghgt+jSVxOVU1rWahxbwWqtauxH9DyGSszTD+29sCw4wAW9nNY8RFfnCPkVSClk+cNH+bHuu1nWsiVJjbLGiLKJ6yELRNtO+q+2voSDuCD2ZE3tbV7kS7k/QPNkInbBmHfIV2N9e8UxCBDQAtbVn4TCrG7l6jiMbX2hasye6ophUtXYx66aEti0HtzaRKOneH5EvHJYXCX9Ex4J1eKIeD6+WHF62q6GbiRmhF1iobUXprnyk03469ZEFaVVRocX0vygmB3FWRCsARCMnh3/i0opGUxrxsx8e8krVmnC0ZTD8Q96Ua2ojEBwmPOQVbl4/+yUneZTg9ZsocERuB7hwuwyfawt9ar
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB0812B7B54B2BC08EDF89F3FC1520@BLUPR02MB081.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB081;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB081;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;4:2cvzBzCvQ5LvctB2ipQ9dopmtl2ELKf+ZOUBf4rBAUO6+j0EAm9G0L2oyN9rQR/wUzwSfFUkEoqsNBIHizvKrlZZO5e07EmydjoOGYwaYFj2jrNbcmAnlAxOCyaiGu83LzomG20TbFYOQ2aKDM+pFID/gawG+nAOfTF/2ALnOEnQR2jkHa18LUwD7LMoHV8LCPK/r4b9i++3E5Faz3yXTbqy9sGIwTwe+5pj9SnMeokqjy4PeXP+ufxP4iZSnb0cGBWEl43zGi+hhEM9bd7SyjF34/yu21NbphxhV3k/f6ZXsaneoRugxamWuqkwUGfF
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB081;23:j3PL8HYXb8Orljwn6HEDAOaqDIwe9U3OQRc2xvFPli?=
 =?us-ascii?Q?DjPUKSEWlzMFiy8NRpnTiClgrrtUaYmOvbt6dX73DgnCl5/OIX3sC2DDPsTv?=
 =?us-ascii?Q?flHNX9xqpgaod3Bmc2avn606HlS+lWWALIgoOpGcq0PpkOTzk+Undx7Wis8I?=
 =?us-ascii?Q?RsdMQY5fcXFaODJt1Xbu/uux6DwzqkThHcUoYXp/nDBKy/TylE8yamPesJfP?=
 =?us-ascii?Q?X/+BAqZJMw/vlNl8JtCVABvv07qROSeIR7t1QDnJWTJKsXrPQcwPwTZgJ7el?=
 =?us-ascii?Q?XoSeWim9ymQO+O5J6ETtpiRf8N/HqF+16of0CGJK2WbUyRz7FKTzHEeeOxiv?=
 =?us-ascii?Q?/KVcgbFPIkinWvSuCu6XQ1xjv1IQGh9vdRESTEaFvSM0DUu6oM65jQ0aLALi?=
 =?us-ascii?Q?DgzkUOqVZTIMNeOyBNMe4Whiub9sAfZgGEo9bX9QoxVrO7bJaCk1Lm1DXaXb?=
 =?us-ascii?Q?3op8KDyNrAXOBHpaAeePjsDNoyq2EbvyQP/8tbOeXzD7KmspyBV0LwodhWxR?=
 =?us-ascii?Q?QUY2UB7M9vYCmmIjegdBG5koOFuJ57qkIp/Vs+XQHt48ZBnujrwR+NWvLCV4?=
 =?us-ascii?Q?cYYW14pZXAKR2RyBX/vrZppoJRHvBiwROz5Q/9w/uKe2zWMdtzXBW7ULko4u?=
 =?us-ascii?Q?k9YkruWhy1xiNusEJq3io4l50p8foaBKo1SIz+LHsHaouy2F7wXqu2eeA3Yo?=
 =?us-ascii?Q?jB2u9GAUOd1Lc3FkcnIYI5aqMUGlWwSIdQKBhnOCbZ76tP3CEvSN3WoF/EpV?=
 =?us-ascii?Q?XMmwE5OnMLScAZu59vSYBH19rB+uu4PelmPdD73hsHNDlPR0y1myOWckImhN?=
 =?us-ascii?Q?fX0hX1nXsMBXmdJ3iWzBW3YqNJ18TJgHrm5MtJX5iPzJdGT14qD7t1GbW7Aq?=
 =?us-ascii?Q?NYxb6aFN21PrOMdc/nRV5PpzmXaaapq7NL0EFJjcyOacCf8yYxPSQBZpryZ0?=
 =?us-ascii?Q?JBT7AFV+x3v0euDpDUVSBO8zAnRDnBgOlLUmlcLZmQLXZd+yQdzZlKwLMnSO?=
 =?us-ascii?Q?wLDkewz1ltLgUwpqLxFdxUbQmdaN0TXhvlYlyaPGPQFim/bgLYH6R9ya3JJJ?=
 =?us-ascii?Q?DikFgOIlsslVEcd1680T0Ss46u0weo5YwxB2UHNBhVJW2Obe6fdTB6bYJJq/?=
 =?us-ascii?Q?F2hjahbkkJ1hP71Dx4dMT1rdAo9Yt930MM/vTxYWo1h17Bo5CvhGm4nnKkIk?=
 =?us-ascii?Q?sHIyK6NhlYRic4+1g39HeBV4T2ZYlNNH5CoIwqK5rmrLFqeqTv36JUzEZ7vj?=
 =?us-ascii?Q?pRMQwM5psh/0lw57VqBmTAv1bTwjyoq5fTqSX2?=
X-Microsoft-Antispam-Message-Info: 3PmVWkqflQqSTZxhZvflwexfhUB1Ma/7UAzBj6aT61AVlQmSP5RdTh5qK28uRas1lsLEVw9z+TIs82ikLO8aqewhotZbndunmTh9rkduH2Ks8iewsQ+8lI8zfjq8SGDz824zRJfFakyFp2fUYhjHaatjEXThCMpqQDGEIu1HWrVJqrq++9Ll3v/Z5RCEolhZHAnVr95Tw2pCiy0q/OIO1oPKnd7LHZGpfoKCoi0/gYhMdGB2zNC6yinuxsUVi7GQT9hjx0EC57hqpKdfUSIAtfMh5N9vfWwskKYrWARxfb28XZM3zjPzmLQ+EaSNo71OLuwFk1bTPUglBrebldcqmMHo56d2T6I7bK7kzBh8quI=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;6:avCufgmozcI6qWAUpVfFE85BS4H3CP7UO8WJ02nx+6KkyAbr+aSMBrc1F+UE8TtcCiqOpM1R5ALnbADH8kuCVl4jdR8P/V3+2LkSA8Mddr1+4hiHircznCvbh3ZBs6STgXkfveUP3KParPX3TDLrnLYC3Tx/xP/iIvM/ocmn/XABtwbbQUTfryg2vvD5GEf5wSe4+CKOA6x3wN4Z2N4gjEFlFbG2yJnwyvBz4L99B0znm/roajIL4RE85onxorKHbux8kFoPKcl6f5jZ4dn5XJCrSWIDwV8oAim61zWQHsu9zzwfHXNms5ZR7UPEWcvFJYKCiLF9grVQ+7lJZjoXqUcgGlslSJx6CsirjYJ5M5CiF2H9uu/Vz4OAfeRWgHdn/0u2tAz6vGSwUG/NGjVmmHP1kGyk7QQ0SZ+FPldIDuFexAFz/IFFuc1t3CsL9GotLLCNYVEctQsEq8/UqRCDaA==;5:7otd9f8RQO+7Nkz6X57WMzRHoRt59Y04uOiMmclnWD6JA8ZPr6+2XyXbTOrBBaMgUaNvi+RAkk2i9VkFtDMLVElpzn0YEF1uxA3/MQZ3hyhUBHrGwfSbgbIvyOcHqTdVtajXdlvlPo4v8+Msze6QQTZZESmKuIJzEgWVajLWDMA=;7:PYWyGcrLoyNpT9IV6XWwdfq+hYav+ccR38FGMEww1oKdvm0a2lfMONWRry6+yWLy30/SfHFRyWISXFJH3cOW8O+vHKvd9dGis3ugzEZfHVuLNs6RdZM2NqNfalGQs3STRqPxhox/aJ85vnwG/DpxVYXXlS85BY8lLwoccfpZxV97kHoB4/XMysWLTh3D2Jh0aQgPsqIZPlxLft8CxF+LOWypBxmRPhCZRm0Yz2W1c18ZHp+lKkf7c/SAACjJ7yKJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:06:03.8079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f959efc6-2f30-465b-a543-08d5ed5f3ccd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds platform specific structures, so that we can add
different IP support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 70 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..447396e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include "edac_module.h"
 
@@ -95,6 +96,9 @@
 #define SCRUB_MODE_MASK		0x7
 #define SCRUB_MODE_SECDED	0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT	BIT(0)
+
 /**
  * struct ecc_error_info - ECC error log information
  * @row:	Row number
@@ -130,6 +134,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller
  * @message:	Buffer for framing the event specific info
  * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
  * @ce_cnt:	Correctable Error count
  * @ue_cnt:	Uncorrectable Error count
  */
@@ -137,11 +142,29 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @synps_edac_geterror_info:	function pointer to synps edac error info
+ * @synps_edac_get_mtype:	function pointer to synps edac mtype
+ * @synps_edac_get_dtype:	function pointer to synps edac dtype
+ * @synps_edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:			to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*synps_edac_geterror_info)(void __iomem *base,
+					struct synps_ecc_status *p);
+	enum mem_type (*synps_edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*synps_edac_get_dtype)(const void __iomem *base);
+	bool (*synps_edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
@@ -242,7 +265,8 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+							&priv->stat);
 	if (status)
 		return;
 
@@ -372,10 +396,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm            = csi->channels[j]->dimm;
 			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype     = priv->p_data->synps_edac_get_mtype(
+						priv->baseaddr);
 			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype     = priv->p_data->synps_edac_get_dtype(
+						priv->baseaddr);
 		}
 	}
 
@@ -423,6 +449,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.synps_edac_geterror_info	= synps_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks				= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -440,13 +481,22 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	int rc;
 	struct resource *res;
 	void __iomem *baseaddr;
+	const struct of_device_id *match;
+	const struct synps_platform_data *p_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	match = of_match_node(synps_edac_match, pdev->dev.of_node);
+	if (!match && !match->data) {
+		dev_err(&pdev->dev, "of_match_node() failed\n");
+		return -EINVAL;
+	}
+
+	p_data = (struct synps_platform_data *)match->data;
+	if (!(p_data->synps_edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +518,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = match->data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -486,7 +538,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -511,13 +564,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

