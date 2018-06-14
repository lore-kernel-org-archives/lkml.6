Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0A77AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB92208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WBfl2tbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB92208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755439AbeFNS2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:28:23 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:39616
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754799AbeFNS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnUuKT3KOVxk9qJDl1SweGkZ/cx6bMHa0cexhaMd9sI=;
 b=WBfl2tbrdIWhI/2a/3GhuNDKP8MLHwqGFjTLZeN3nnf4zeQAMjK6X3JjfJFkOOuFhiN9dfDQHohTH58jasDu55a7YqJlqaMFJyfyScdKhoSTUANeH4sjbqecXWq84CE9Fry9u313eX/MUAGKGvRkQXc7dwZtcaoJ/MiAD2NyvsU=
Received: from BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32)
 by BYAPR02MB4950.namprd02.prod.outlook.com (2603:10b6:a03:47::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Thu, 14 Jun
 2018 18:28:11 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BYAPR02CA0019.outlook.office365.com
 (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-000212-Kx; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-Hq; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRuej017083;
        Thu, 14 Jun 2018 11:27:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyS-0006F7-0O; Thu, 14 Jun 2018 11:27:56 -0700
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
Subject: [PATCH v8 08/10] firmware: xilinx: Add debugfs for query data API
Date:   Thu, 14 Jun 2018 11:27:40 -0700
Message-ID: <1529000862-11510-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(8936002)(47776003)(4326008)(356003)(2201001)(107886003)(51416003)(76176011)(7696005)(36386004)(50226002)(2906002)(486006)(110136005)(106002)(54906003)(16586007)(44832011)(81166006)(81156014)(36756003)(316002)(305945005)(8676002)(2616005)(476003)(9786002)(6666003)(77096007)(26005)(186003)(106466001)(59450400001)(7416002)(126002)(48376002)(426003)(5660300001)(446003)(50466002)(11346002)(63266004)(478600001)(336012)(72206003)(39060400002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4950;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT025;1:8Ofn/ZHa31TvID5DlF51NkNf0eypq46/dkpBw51w5K+MGIPMzLDFx7y8UPjgjAnqD2FDyzqAHsu0jE0oM+Di7tareJrey1jMTZPZ9L9GTsZMYeJ1t+5NFrsazfUzNF5c
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6bc0337-7da9-4a63-df9e-08d5d22495d0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4950;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4950;3:sgZ3YD3c4sjtG2GFY+TBTxyecAHIkLYIJgCPX5wBIvu0e92jHKH8i5cbxBjuESdYutu76sVRIpYwKOWiNZ8b9Qs6tpuxe1rvDAD+jFKlJ3DjuI67PfLCjaSjtQzaTrvfmm4XSa8zXi4KYdNDmgIteqYJui/qrrs0AYuwXenZRstdN4nRqsbIB2XX2wgwluHl8jaj2Ynla6o4lYMkwTN94WWI4b81Bkwz+xc/Uq+m7mPLIiAg+pap+2iahwOvDiEw0XrawR3raBLcF76lqD2kJUo4VJX2TPA985wmzKYvKPm50YBMOvEtDRybFbhcSbq3yJ/CSuzFhBmUbVVjIGvwKlziWcymQU7SfReQ4xKIIIw=;25:zbbphI6Y2oG7HEAAazbUmUFs8aga52X3NBkM8rc37MQplRt4IisTYOQ3g7uc5LvOYHyq8pPOaqt6P/39ixMdPQ8jYTKSdYFtOP1w+xFfMr+5Z0IRCxg0C23wCT6sV1N2X5NRRs3kBfKq2goL0BC7nQrq2YYQoeHZ463qCaYkotkrK3U/rEBqbCWOJf80ZqmIHZoflCgZE/y+Sd3b9Tc9sgG7vITGo3ZYPSyj44pDz1aiaIH98TN3ygwS51hdYNejk6/h0gZUP3HlP2nWQJCl8+xc++F0fmfVZML7IO2G0M2P4gYes54/xn8quS15kMPs9mKShts0Lnn3Ln5p7fuARg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4950:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4950;31:wJYTroRs6e7UMwX0ULz//G3j+tt7NM02cpVl6GRQf/9JVdwcjpK3Wgfd8cTNM8ybk/4YlwfnRkvR6mKT9mapCe1qxf7/M+j1WXNwQKVRpOhCGjX++wgLgjTMFbbWrHReQ9C9nSuM0moXhAUqMbEUA0/uqnuxwn0tWepo2sUekLuxc3up4sz13JO3rkcITHqOPneaVMREXLdXd/EdORh4Z1zI6ZJSOLCJvWS2V4ZpR6o=;20:ruFnoT4SWd70aTC4twBS6VojQxSdjUJyxx213t9udNYYkDs+gX1N2P83rJm9aWn49BWLW5CmORFvUKh1TOrGUG7oc3tZ54xsN54w5D7veUMcdfBRkO09QMTUl0SyBf20rCQzfZOP6jp/+B23RfYep4H0V+JahGAP7f59Srkf4L2Mr57laFmTEcMEhaKJ3ZNQNU1p5L8FZcT6LxYVagnrIiAesIMXI/cERqUflKV5ELlGS4NaMvx95S8rqMIbzffZNdw04sFVsXnDjAj6B/eU36hqGCPYK3D4s8rFIx5rlPPN7A4FUc8eMLi/Ke043HxaG6L3cCWEP/nL0MlxDqFLzte2IVFSHtwHRLsrTxg2faxBvgeNGk1ejmlFHPKTTGXmnjW3IZ4NPeFp9AbklmSMBpFCHUEUOR2/WZ1t8F/QBtfMzr3bKQdU14iZVBcnFXxLzftqGpl+SyifqsE65h0kwW0BdNhTZA9m1D24n7IjO0o3HSbbh9hd61VmRUkNDout
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB49503028576A3D40AD973CB9B87D0@BYAPR02MB4950.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4950;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4950;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4950;4:coeVGdF17nCrChczJLjJNqtUpV7o7rr2fcNh8WY7nmwDHWGn2weoIYSYKbAFuGUN/wBHMlp/deA5G9AvshPfYGdj3PwEm/GvExKamC8HwMEalP+Fn3Utyr+Ev/peRDcv29RNC0LbBmIxXmkIfkOgxGtnhVNZzCidpzbWZvvG/bcl+ExIim3SLUEZhD03/iRB7bHqRFnL8D+ofcfADtE4aZr8XdRmlWe4PEPOFC0cjJgopukGsZiiPvPjwX3Qh1UY8aajJAkfy2qjQGhBkSL6QdgRzMu2Avl7qFj0Dwu34H0IwuE/Ld/B8Zg9GwJdNunC
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4950;23:zt8WqjqMGB55zFEIXeGLYxMaHbYTgE6MCpJqpO+Qy?=
 =?us-ascii?Q?aHF5aZksjEIhkHgmoNWf9UHfgCehv/Jx05lSXhHlOXgy+/teqxEpExrgX9U6?=
 =?us-ascii?Q?nvETWFh1mIeu2DBfmn8LzGzNInIItjVMFi5DHvs3TDL7SE7iiJKYI88G5WvH?=
 =?us-ascii?Q?fxKUqCKvvN3mtYNtW18HK+6mqSG5FFUQtrtgTaMEJ2kW+wcQ4TdWUBizY8T0?=
 =?us-ascii?Q?eiOjoyRyNBzPjvj2QOQOwy2VMsksjt1fBVblkCHzsx80QCk4PMfu907BaR5G?=
 =?us-ascii?Q?zM+dOum2naee9fwPTfgq4FdgCGaBi1xHXj4HFMk9+TQ1qA00/B7qIAsa1Arv?=
 =?us-ascii?Q?dZ7WdIdqje/7YhvJ9sg7xqp0HeySSpJgceIaqtalG0Fpu+et2Gv+6gGTfStC?=
 =?us-ascii?Q?O9b11+7onsvF4kpbp4jSJqaBbB8+YzWCwM9UkEdQ+Ushm9YUfcJOnUP5e5Ij?=
 =?us-ascii?Q?DgLZQV5ylVtBbejbw1zyvwUxBAtYZ0AUVCNccOk3RsZjGDAWnBvKiE+4B6UD?=
 =?us-ascii?Q?Vh+5Hod9ulcG6uJxNXFI7Hqi8DPno6rsK5ZA4nzo69nMSOdAy2/gU2ME1Z/s?=
 =?us-ascii?Q?wR/LU80HfOg8ehegiyz+L9Y4zjmJyx5hCAoIgLgqmtBNWQ0wSX00OnwfugW0?=
 =?us-ascii?Q?gDKenvSEm+LcwK/7yiiTC4XSAnalzHNqVhmModBg1SiL/xqLJs4p+A8j+qB9?=
 =?us-ascii?Q?x6zxMgRI1zOV+madtFFLEhGjPFEIGB4IkhLsyZEdlzWVcLB/N2ieeABWpDiB?=
 =?us-ascii?Q?ufBWbHPiBx91urBOdbEZyZkVVdW/owhpna4q+E8vU3TETqyXV73rVjsmRn5a?=
 =?us-ascii?Q?9gxc98OdCaifWasjM47peMjHHurtz/p7P3bYnic8QJFjdtvw56yCvrV61WHp?=
 =?us-ascii?Q?+jb1MO8UDP13Vv0xlhtTjw9cHOuUybigPcJe3DJTwrExGUIbSHp/YqYABjds?=
 =?us-ascii?Q?7UohXzzY1pLa+bxPvXd5VzQiS+HTxjUwaPtQZo58CSa6QX324hhZH7C1bARf?=
 =?us-ascii?Q?4sJAsCxsZ+iX+TDO5n8d6GyKjIOcy+P95eT74ldQHjU+xVZ28yZYrQrnYskN?=
 =?us-ascii?Q?9bDJpVsW++ADWR9WANKtn0Y1OrJmauIfFUIlKbNB6Oy7N7VmHz1wCxjZuHbz?=
 =?us-ascii?Q?/PPZeTrLcRrYuOX2dmwLVw/W/MZwBPvbqKi6/siT2MV6hNVoONiy5iWM27e5?=
 =?us-ascii?Q?EMGxy17rk3Nwjb29XyI9hRIndKN8KYL4/bHwoDJ9uMVG1FDPY739ShS07hcP?=
 =?us-ascii?Q?3ookyCQ6Cf98575yrqyVwc2rmkTL0Ycc5WLLIONxHcg+y6WtguPmdb+Y87oi?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: c432If377xv+hrhp1sWBlbcv9/ye8vUEV2Bj/6mycg+S1gap0bsh3//77gAq2HmTdAthBFgo7pRfnxWFBr9vNKFAY68kHDKlWMzk9QSnVLbzD+8ajFFTc5Cl7QEmrK/ZIkipCu7ee659AMOi8Jksh1k7ihRoyrEDN8dd0MCWuC+S719drDfNRhZVnuRkt/qW
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4950;6:VN6aSjtMO3MNLrGts9f0qHaQg1kEs3vi8h6DG8LTelyRKm73T6wvL0iP1bWBY5JspfhvJa4/PMWEfdPMe+dADEn5dv4h1+Y3IvNV9ChLuIj4j6Qe0aib45LzrsI4UYhrSje7zV/sGZxGVS4sDFlg/J1fTXurive2Qs/eIt+O12dnidocAxQWZxF10Aa5Nf9l96/kZBLgGQZmgg6QbFnisvR+iTF8rOV9pOMnqhTrnwWtgfFEFE3h8XAZJTg3zoOe5SHdORNJVl4s83bm22tsA6P9YXCV0KfBOjJm9ynEHtDWslPJELNzdN9v1huGbEfRu70djUeJg/cTAN37GUUmV+9rB4mjV/a1kiDdHuX7tY4Mh5L4yIlxfn4XB67P4ZQ1FbslPe1X86cWy8ChbeuyFdjaPupurjkOongZ5M3nTtj2HK5yxh7TKIzvnE+9thjjHfSzwOHJJhOnQ0ynh1GKaQ==;5:AJNscN7EFkjwn9R+6jAUKJclOfvaLnMQYhOGV4hCDNqHOquguCL/LSkcpwjLR1J6u5KLZRE95hQficaC7/JeLdhUQ/weCeRLMnIjA+EzbH65p61RT9NTGNeW+R2gy9wOTCh7BuNKbJz9oEaUnWjXWLOKSrf0rEUP8fc5dCzMD0k=;24:HFLfEf8gkoLTabXieIfZLgChURrmnOtxL3eXdWxYxqWnRfqllf+ZP1HIvbaYSO9cwxtHcHseSVbGzRTitWa/bQ7QNxpEqHqwddZey6d22ME=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4950;7:n6YSL8Yp715Zrh4+cTFi2wCaPnSZTtnJVO0AVgFJw1Ur2wf+kOdCO6gChE3MkZv/bbk8f80hbdodJoFbWxyXwgA5bA5enZShEwtMRsWQyW77Dd1K3wYTiUWBHPK94GFFg3oYXrbMT135TxVfdGh3zsHEHCdJ6xsqRIUNi+GQu/OjeLa6dhXXrgTuCmLMvDLlbXLO4jnBB2s1Y4vX7i0FmHEbZT1tl43feMXti6uWYCIM5qQTktC9JMBK4OdA/0rO
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.1317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bc0337-7da9-4a63-df9e-08d5d22495d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to query platform specific data from firmware
using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 148dbff..1cb69f7 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -33,6 +33,7 @@ static char debugfs_buf[PAGE_SIZE];
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
 	PM_API(PM_IOCTL),
+	PM_API(PM_QUERY_DATA),
 };
 
 /**
@@ -105,6 +106,32 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 			sprintf(debugfs_buf, "IOCTL return value: %u\n",
 				pm_api_ret[1]);
 		break;
+	case PM_QUERY_DATA:
+	{
+		struct zynqmp_pm_query_data qdata = {0};
+
+		qdata.qid = pm_api_arg[0];
+		qdata.arg1 = pm_api_arg[1];
+		qdata.arg2 = pm_api_arg[2];
+		qdata.arg3 = pm_api_arg[3];
+
+		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		if (ret)
+			break;
+
+		if (qdata.qid == PM_QID_CLOCK_GET_NAME)
+			sprintf(debugfs_buf, "Clock name = %s\n",
+				(char *)pm_api_ret);
+		else if (qdata.qid == PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS)
+			sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
+				pm_api_ret[1], pm_api_ret[2]);
+		else
+			sprintf(debugfs_buf,
+				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
+				pm_api_ret[0], pm_api_ret[1],
+				pm_api_ret[2], pm_api_ret[3]);
+		break;
+	}
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

