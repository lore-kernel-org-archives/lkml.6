Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF46C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90A21784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="thQ4eY3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E90A21784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbeHCTvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:25 -0400
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:49648
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbeHCTvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6Tqd00q99GCo7Zqz6V0mcAdefcyuAndIi1uNYaDR7M=;
 b=thQ4eY3QXuVtmncr+GYIZmI4lOHnODT6naiqyNafFJmLDttEFLN62PlzG2b/YiKknIuUFE9wIE1+FdGbIJYn/WLxMg7HDo3IZi/q1VP4jScfx10CysvJTgnF0QQ/4BSK4G64gQLw0HCDs2YT2g9VfwNsuAQbLvhqmq+vHOZ+X/o=
Received: from MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) by BL0PR02MB4452.namprd02.prod.outlook.com
 (2603:10b6:208:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0053.outlook.office365.com
 (2603:10b6:301:73::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGt-0004fd-Vc; Fri, 03 Aug 2018 10:53:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGo-0007cn-SJ; Fri, 03 Aug 2018 10:53:46 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-8F; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 02/11] firmware: xilinx: Add Zynqmp firmware driver
Date:   Fri, 3 Aug 2018 10:53:19 -0700
Message-ID: <1533318808-10781-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(438002)(189003)(199004)(81156014)(8676002)(6666003)(50466002)(81166006)(5660300001)(2201001)(36386004)(575784001)(48376002)(39060400002)(356003)(4326008)(107886003)(305945005)(63266004)(7416002)(44832011)(106466001)(76176011)(106002)(9786002)(14444005)(16586007)(50226002)(36756003)(77096007)(47776003)(8936002)(316002)(2906002)(26005)(426003)(11346002)(446003)(478600001)(486006)(51416003)(7696005)(336012)(110136005)(54906003)(476003)(126002)(2616005)(72206003)(186003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4452;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT056;1:F4jMf6J/39XBmifXqxNtYOZTCZpcJZZ7MSycw/JSWOiK+Wtjsi2dwqcZqUV9h0aPg4Rki7CIrBTUcY0XwQVGuJEcx8xz9UWJN94nfuwCqdSEx6xfT071vWIxylTdBnj9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df491755-30fb-454a-d0fa-08d5f96a13b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;3:u3DQYeOwlKNEyTS7MxxHk3buRABhOUox/VC7HOVctIBNwPnMSAKIwXNqdNOoWo7uw/ekvkX/hze4JFl1xtvmtGg6BAg3dRo+HoC2CP0Fi2k6Aa5aur4STSN+iBc9pvTnhnixAX5gGxwuyAir3pVWw71c9sh2Cb+8Pyle9CeD8m4gtLpB6bNlZ/pSb8g4gioqVdRRa1mP78N5FxAJIE3Hix/L/N8hSO70ai+w6/sE61pIhy/wvw4zWdAVK/+/PXZIc2HwA4FvrnCuG+9oaMFyo7JAcs1QPss2r3qB2YnwVikz77yfJ9IJ/YWIiQzTLlF2KvhQhLsz1iv/zi1xiSbpSNKJFDBA4ZPduHmO+VHN5P8=;25:LXJ2Vp0S2PhNyuQpuooRWPDEQCDCFctChZ7NtQBffAH7j0HpBmn91ZJf/UvJGyN+WaoKdJaBpJOWInm/kLyzpa2/ra1jyqhBAn2fsPuzZ0Xh7c+5wDJ/qJoW/FedMTKQ7uWhGwb8HGxOavMr7R51Nud12+loQJyUCKrOCkAIcSv+1tA+QMSOEGkDzKsWkEA02WmnzFl7xqKwyMAqLwgw5TZdhL8Wp+EMs7tU5VkMqpxVRVb4/UD5Fy2lLoVZRQO9MY5MJeCv6WIvuA0V4ufw1GhFfJvLRSIVwHWONf9GjGuEmuWl9ho6Wv40bR+2smxGToxoH2xooQnhZxbkLbxVdw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4452:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;31:gAD/0l4A22RMMz3cA77FGvYUYsqp7N985YvCQnxLWHoCHncGUMZL+KmuVQcYhKrluSa3gW0YAxB1QQk3b7NHltL454qdM5hlhADX+WeP/k8jkyahuhHWc278gplw74Zi6AiGSbTV9ybUcrYnyTst1AA6QgRd/gUAYLFQ9KhiZIOWfN+xjPjisNhmqjrx3fzaKZsQ2eGPWATXw/IgsnFG88uAapDzoNTzeKbn0H/ZHjw=;20:m6IjijVa+swdSqlECYcegH7AeaWGnFJZJ67tBzrbOBgVOBKKlXLmYQrIyVo3o8Y1iayTFD5fHw4+0xPN14S3QUR8Ie8m8slJvMTi3d6HAH+75z95ngoHvp40xGmnnLFGrahkxoP44ACWkEGr8Y14jyXjnEzZGxuRqD5ewoA84bsH2Ks8V3t1E9MId75x+x5YAk1ITtmvYDdlfkqp/R8V5BjLbVA4iNkpHft/9bYyxEiI7PUT39DpgHjvnHaHXxEj8PfjHHVMObDr0uciKD5EqhviW2GB/RKKnSxU6PHFj0ACl+j3L+NfBkHbaMD/Pc797Z4IV8ZhdJCbTK18Ka+UqIy7hHDDYI9mSMx8FtsMsCGGnTfoDrV6Muj6g66b91/d5CsHMpkFRREI7htfE+wTpB4pNSxnyF13T5iiIsdnxKFWJK4h/Ojoy8Gmh1MqKGguoKbGszzoKwgnWlKW0W9aFYYmZTb863zqWSTtrOwZqsGTls6RX2lXPuKMZtSkEoho
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44522F11AC356B8A5A575B76B8230@BL0PR02MB4452.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;4:S1wOMZKx46XEgQla1475Tc9TEw2kgWJkcVsL0CDFGaXSOMIIY736AjSmYireGlAatx9RbgpQFaPlM7TfODrR65ZHyghGtvEDcC/7CukUAsgmZqGxFZZMO83wP1xGYJNrT8L+VM0CtATBCVyiShDY/3nrQBh9CJq0zQpwengwEZLJgGrcLbEm4XbMkIXljMG92NM5qZwqgi14GWXuQL5irl54VviDeeH/in1QGc5GfwwXcpfTOPW5ayhm7NsHZx48kIP48arXJ5yCvptPDFOS8TeI65FU6nbGS8aPo8eh9q5UNCNJDwzXu9n0EE8KoES9
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4452;23:4SmKEBJfIiPDNKrH/YSFqfMAsxGv8UJjmXMIEw0O1?=
 =?us-ascii?Q?WCrOK0AkD60wh1VrqwSP78kTCrAjLDvbbtFalM2I/LEYfqFfpJwIercxDOEt?=
 =?us-ascii?Q?VgcedzlEIQqUtbC0J2HvDHHoPDsgcBrXIvoobF5RKReA35NCBIeoGiYIcOSN?=
 =?us-ascii?Q?ugKQ8FNtMiIZoHeMrDx6S7dkqOZKoheFUXw7KV5hyggAIw8aBqOcU9TfjSpV?=
 =?us-ascii?Q?E1NcLHv3ZYER4p+lZOpzG3JCqZudgIrMMwyveYHy054HnHUFrSEZEsWhiGm9?=
 =?us-ascii?Q?5jxUEAy8r6Q7nwXTV5nHSRLEnLhzIHT4IgIVoTLjNKbx3uvEMiR08IOVEvPY?=
 =?us-ascii?Q?5CdqIWTcRk7IqVlu+XL932/hKvLili2xCyHCgnCWJditDGrodQ9KZS/llESb?=
 =?us-ascii?Q?sLq0tBAfjrME9ZDmwLkq/XftOthxOGGbvnD5FIObG3ZUGq9mFCAs+PHtAzXv?=
 =?us-ascii?Q?Z58fBUyLtuewBVVhdJ+Zop2eluuScCthB8Vj/2Ck7l0W08AGUCf0hR6CzV0n?=
 =?us-ascii?Q?LsB03rXYg9c+VgphTBp4dUfpGNPtuWUt/2vs6niIC3QzqjW9cdKbHewQxdSV?=
 =?us-ascii?Q?1ydut5wiHtvNJW928rSigYQnQfXSvsn/rEhEfU4WtgL2eUbwIG8yqy1J53AM?=
 =?us-ascii?Q?PCAoO5sw93MrHfKwkzjTMxbPkmgFQihDTSP6VRLxShXBWXg1NUOM3/LwB2dh?=
 =?us-ascii?Q?4smSrGALhrtH6FxrIi0rFCAXLonC5OqfWRHYEqRvBaXKuPP7x1NSAZNm0Iqo?=
 =?us-ascii?Q?pC8nGKGq1P5XM++d/WyTJcnUrexbHy/H2Oy5hJ+4IZgQF7ZpmRnNC+5S7+ib?=
 =?us-ascii?Q?KlYI2Ik9KzhzzZHstAJFWlpm1R96f690Ay9srenY9eiNzWFOv02ziKRmVzu5?=
 =?us-ascii?Q?PveAbh+si4TMZI8W6p/uAPAVNTQSavu1i8jfo+yk0Fq9CpulFZ4xFdZyFLVz?=
 =?us-ascii?Q?ctNHzadPlBSxPe23iLw09WFtR03WoY777oaeIFr7Ck2qANFcr4ufyfrtZTkB?=
 =?us-ascii?Q?qrcRlQvHBf3er8UXfuZlAUCH6hq7MqqJV+dR/RLXha2j6c/nMVjYzaJClO7S?=
 =?us-ascii?Q?nPYdYHjzd6QHqgwW9rjMAiVOKTlGdc1TK7w5f95aPTj8tUnm2DcG4ETgmwPW?=
 =?us-ascii?Q?+brxFSzI0/NPOZsKwggzEHqUbI38ORgpBgDQIauzfcM7CMkicWjj9e4Mu89+?=
 =?us-ascii?Q?IpWpqfVPG8EusUadmXGIho2Q+o0e5IaTCe4VEtdafXpd0bk0DFYs0Q7tCQs8?=
 =?us-ascii?Q?9xLftF0sUZrvNCRUS9iOYZ6Io4cafWKbaO0loT8miGi/ZlI7yS2qjANQ8OoO?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: ObHRcJQ2jkSQpY5UiBfWVcNMi05wJITzCqC3BeHsBgex/Ng76kHth3MQil0pugeSV/naYECXZ/jJV6MKsFPn0O0KxxJOkpJokDW66j++z1RVHu4/DsiZV7HLoGScM3N9WismFf+I+38POpikFCkxOiA0u+ISx6ChMYX7l3nJy5lNqiX9iWwGxeFTuL9IPAaHpEn6DOJYyQ0gCEPEa4FLmSRxhralMue8/12g89chDC6gw95CCsU+VqXz6McDfor9QUHwbNqCmCDLQYsqB80GmqtLMyXElKkdnFFraNMqkWlaacxZnzCx+qthGxJrvezoFmgjJ7R5Ox6pGfMxrG13BHupGYvRiZ4OHz+IwtnPCvw=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;6:XK81hQCF+KkaMNSs/mcaTYyR8PWkHLLrI2U4yLLW+SCAFOSUBl3V3qBHu1zpLC80CsqoYXS3ob7XU4T4Oxgk+zVO2MsF/jF0IItrehOOcpVPakCNUdAOuig0tGuWzQ9AusgGk6AnnZg6JisxKeWbLqR7SP7geIiiP7fPICdIJkCZJDiOpO8GKkQWM/1WgS0lZthwl3FuubAJVN9maCr26C42RkdqkrsjxK9MKsXB3bZreynylhxDt3KTtrMB457mWhR++1BQ8D1bX2GjMZcmgOAZWhTRd76e5AhO7jAksiNiboMsnPZwnIralVQTmhas8kbNrWhZ1/xrqwBd27+qz3kmO3Sp75KHpEc1nvXSg5mQjKqmKoq4od9YwzpB8s3SQTQHpkqf9rblumRDL9prSFWy5IU3rleCB+H9HP53PjPA/aIuCasb9/8whaOViYL+wz9dQP+3HqfrGmdW7RVWWw==;5:yJdTcKxVONzB436x1If5l2hQ7Z+9AKUQHyv16QL7ulayvFKr7VOxKbduzJBtAVRmtWSpE6pbGCf35GCfL+/e9KT6PhI2Ja8uuV0Sa3bcRXYU8806QDn8pLkBpb86MoeZO7CSdMuwYMvFMCQn6PUgi7w3lhNY/7knKeT9p3D8T7k=;7:SPj/T83HaBXHdxHbjZhXjfrIFad2yuqhsBePk5KeJyxCv0PRLpg+oMZS0AwhAAQjO13OLGmp2XyNUDEr/OlQUi09vpzUa8clZ3lglOUO73u+G1qVA/MxzAiVSTc7txwSzcrT6mZNnaeTlL5vXLL5MtcN9OlQ2Pu4ojyZZcNBk9x/vN5RrfZ5li5cJi8YgPagcQ8gIEV0lw/eLzJVAhOJqWpqJgC8LLnxKazmlgokh/icMYSTorj5Ubih7ge4gtUZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df491755-30fb-454a-d0fa-08d5f96a13b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 337 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 423 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..64d976e
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different
+	  drivers to communicate with the firmware for
+	  various platform management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  If in doubt, say N.
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..edbb84e
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: Pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
+
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
+
+static int __init zynqmp_plat_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/*
+	 * We're running on a ZynqMP machine,
+	 * the zynqmp-firmware node is mandatory.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

