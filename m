Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A9F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q1X2hlVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A9F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeGYNDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:10 -0400
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:37132
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728681AbeGYNDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBZcGEePYEegP+ehKsC5vM41JYPEmNjrPlIUsVLWxww=;
 b=q1X2hlVc6fEs6ztE2awP0jHYxgdWTCrucOuMCZ6nwkDXaGAvXOqgSRS1yiEpevCAskegsnRnR8MD5Ap4A3DX1AtLG++C1RbB2Z8TGnV3gfwdcboCQAuUmWJkT0SNoBMRLGxcvtgUeRda35EBuX16fuFfu5UNKtFJVSY8PJxaxQI=
Received: from SN4PR0201CA0037.namprd02.prod.outlook.com
 (2603:10b6:803:2e::23) by BLUPR02MB083.namprd02.prod.outlook.com
 (2a01:111:e400:811::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.22; Wed, 25
 Jul 2018 11:51:46 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN4PR0201CA0037.outlook.office365.com
 (2603:10b6:803:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKX-0007iB-0n; Wed, 25 Jul 2018 04:51:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKR-0006Z7-RP; Wed, 25 Jul 2018 04:51:39 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpYu1027038;
        Wed, 25 Jul 2018 04:51:34 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKM-0006YM-7S; Wed, 25 Jul 2018 04:51:34 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 58D6C60504; Wed, 25 Jul 2018 17:21:33 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 0/8] fix broken BULK stream support to dwc3 gadget driver
Date:   Wed, 25 Jul 2018 17:21:23 +0530
Message-ID: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(36756003)(6666003)(90966002)(106002)(8936002)(54906003)(336012)(16586007)(42186006)(478600001)(2616005)(51416003)(81156014)(316002)(110136005)(106466001)(81166006)(26005)(50226002)(8676002)(50466002)(356003)(305945005)(48376002)(476003)(126002)(486006)(63266004)(426003)(103686004)(52956003)(14444005)(107886003)(4326008)(2906002)(5660300001)(39060400002)(36386004)(186003)(6266002)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB083;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:10M7WvaMecSnTOKoTntHpEaUmwRWr/P8GzM732qBxCjdrxKjQ9W7BKwCAr2V4NN6Cdr6ABf3EG57h44L33pznAELwsGjigZ3s53Y+VY7q29pOXDsGLiWc4+ZWgskwoGQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eca3537-7fd9-41cc-0294-08d5f224ff8d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB083;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;3:RhfHe+mAjxEBZuErez4R2lGjBk+TiFOabvAq+C59ocpMtJQMjhWHkMZiK6vb1NXjkKLu/c+ybsItfoKTZR3Il2cT2al/wC3vUedmQ6WFmtqlk9vh2pMp1Fg/aGvFWkX2SM34VNGKu3F4kKwKn9i1P5UmbeESDb5IWcy/MzpYcW2o8KV+AxD1R0fFSxj7jAbPj5MISS3HK01qheywg1jL0DGBa+lZcB8SU33XwYXwPYq6wEmWl4g7vGk5vn56AaG0csgrhmnwc6IwzV2de5bebCx3aBhGN+uqAn4F0PHhuKTHEz6ZOheeMm1X3SHFs+Ax8/j+omyDVs31m1Btndozix7N4c6jMuL4kliTgmdzlnA=;25:Ts1BWhmrNhVJuaWCu5BrN1t5KRBRxZxB4rgi/N+MT8vYWd7/ZGTFUKFV+62lIRf5LPFEJU7Tyo0WG+DUj7M+93IoT9hj0P3twCuEeqoNQTECG8pBItMl/QgPmD+f6h8cx5q3poxNlZJQuv+tusmfdnz9RS7R8Cq04KNPGo6b8up6/+Xp4MDlSocu7HIRzuasSlmZYyOMAEk7xNSVBg4lWNBi9m3Uk2G7GUY0/tjyizWIVq1u9a7P9CRHRCCIV8/spDmKRrL4EzrbZXDil9UtFvngA765A0Tzkm/ezytCznPGTsE6LCqsJzey4lEEK0uEZwZibb9PiV7XqXc/w9HBZA==
X-MS-TrafficTypeDiagnostic: BLUPR02MB083:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;31:ZbXHAWmTLbWbuscHSXjzLhAiMNj8k/Kyoa4+CA9oAt5QndhBCo2Osi5F73fPjmoa8cRG4xMmlxsfCPCho+yY3IikL+wTVdXVAHF6SX+e+a4BCDI6UbHymsb60o7ffOgjbwIHb4ZXWtL/vfuLL3XvYh5g9oAf6JILHP2t8e7WC3x/YyM5s/O4SgWFIoDRHPrhJGlOz1NbNWZp1dByn2KPd5SCTX0qbZbG7zQZmTlDsD8=;20:TVU9O5dt3XOGUXznLE6RoDJFuMX9ssk8RRet3vRiov0cJvbkCU1cMQNYe+v6+hO3ITv8GG4bwc7BIvc+NrcMOZ+JUWs4jqzFmcbz6doKh0Thd0GHinKjAbzCemOxB62ar7Fc2jDgVSULodcnkAX32IOqMA5xVZP9AR2OtUEAH0gZog1aoIu8O43aVX8zBDtdrg8n0M1nVngteSTBbAU/3ucO+Kw7CMZTVLKF5ynO1KH2iKH7dyd/VHzIxqW9OFl6ecvGLp95r3OWuxa2YpWUecmFYrUFBB4qpEjK4s1rqzQRHEaCA0s1HjBqZho4B02w/TXzhe+F5VcqsnHocHI1PVRBtlFLdM2JhJl0zyD2+qzaQDS5bsod8Cuyx+wnVbI61wMiDU6cq7vqwBqd/4PFqrj/Y2uQMfQbmjhjaKUOKoBvv0Na5x4nqrOD8B/rWA0XCIXZBXCi1WE38Xg6PrtD4ZT8cvwil3OL+vqsmIQlDnv6qLA+utmtS1WjW18VDxhs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB0830C9EF78C194F6ECDAA6BA7540@BLUPR02MB083.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB083;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB083;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;4:F1bJ6pW8LgaRo4wVFE9KSOsr//6iFm01vuEOg2+iyJlKGXBG9vnA+wDJh13MUnbWdPwRGPmLV+unNCd1XgxxvFuABsbQYd2g5VPcuXWIpOGKPLewn8aBBMA/1uHV5UNbKWrdEKpG72grOudH4WGQamguO1XNoDe5Sr6OsSzN/6G6VWdsOFinLV0X1g007FD/N45HZYGHzD3A8zbPQNcXlCs62ZdXQAZKIEvovcQSoVUuYup4pdi2xGA6tW+u0zR18FBKc3mnH7vkYdjqiNnQhA==
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB083;23:Zrpr225c8zsF8/NnM09NLgsxhLAk2IrJ5VnKZyj/7q?=
 =?us-ascii?Q?4Tm7753/0+e46Q3vgCQwMZRn40hsr+xVcua15l27ZVGW9iqtEmA9JN1StiNL?=
 =?us-ascii?Q?Oka/HP0L+QhkZfZkB20IBOet8AlHoq3EIlb7/Vhx4McZaeMAnMwR2OUOzF/6?=
 =?us-ascii?Q?v0D7RxwWmNos7lfiUU6rh5yMec1Brf4JGD5zIJVKyGovrXaxffCdm3NQHQML?=
 =?us-ascii?Q?+iqL6/z/gjF8sdYAc3DDgrnuQjThhmFxz9K3Q2QxXIfRrY1KCuj/puw8e9W+?=
 =?us-ascii?Q?36aKqn6rJymtHsmUGS6ExV6+PDW10iHGhH3kF6gq3l/7feJYuaCTu5AEncQx?=
 =?us-ascii?Q?O6AWcPQiV3g3sOf8AQhEA01qmeXccw0dQaFmiBT61+cztoCwjBSrkVPJPa9c?=
 =?us-ascii?Q?Uxsne+N5y61UUb7/U8ufgEzynxmjPNw+BcifqhqL5c2pb+mD1jM8rnpebGRV?=
 =?us-ascii?Q?xpoiBeZFhSo+04LFAw6u/LfZIBT0273Bg0wqwkgZYDX/ngeNzZxf91RobuLp?=
 =?us-ascii?Q?SCWWyfYxwJVs6wejJZZtpOhN+aon9oNrZ0iK8HJMeaPb+q0Qov4vcCrAcXEl?=
 =?us-ascii?Q?//0cS18AyIG/teTdu8DX4ODYdAgVr15U7LE4BpultP93V7iJoZMTEn0ndF2K?=
 =?us-ascii?Q?DnLwT+BcEjg8iMzXyegmD5flOne6qZ7g1fLeCxAuoeaEMGHS71CWxXasV8cp?=
 =?us-ascii?Q?sV+yFhQqP1MytYfDC9ZQRyqJ3dvVRCqCjnMdm3NLPoqbSzqpyLV9mwIRtwWK?=
 =?us-ascii?Q?Tuilp6+/5u3SW/gP/0ml49ZiNkNFhNaVJPujQVk7YlS9+l/Czhtnzkxh3qNC?=
 =?us-ascii?Q?G+PigJ8TsBdS5GRNuqO4QztfZGnhbWRQxmY0TN9+Ql5ANE4TWNPKaQeeEPn6?=
 =?us-ascii?Q?fFeo2zq1JqI4xHIdH4iQoN18Z0B5QbPlDU3MYOhRDNMeRYutCX7Q7kQPRKQq?=
 =?us-ascii?Q?Tqu6hKq+W9OBKqnpF5IlrksCs7ppIpQAUbVEwEf6+uMiaLiRpd7b6hvztm/o?=
 =?us-ascii?Q?OPiXP/XpCo24JhIaanK7dXa7g5HPX5+pxVAw3N8d07MVbV8H1QkN/FrqlF7l?=
 =?us-ascii?Q?MzOiRZiuboj2MPI+jqV8MW3/zpaZ1kf8rAAtQFOgj9JO1WdbrWuOlS4jcqPB?=
 =?us-ascii?Q?LV7vdYfWlb1RZp0s0V1wQdD5fs56mJ?=
X-Microsoft-Antispam-Message-Info: NpMPUopwSQETsRyemfHxBYtKnaFqaP4jx566EMcXHGovUViDt7KZDa9STmoO2Z/MvOVfZC86q0fgsaJYn3LGjPrD9hRbb5+7cvukCSh4TuuXeakCtxQZtEaGBvwMuyg8Zbz50wfhoocQ0SCLMNeSV0SXnc3wWRxN0WFn/kQFz3UOWUxIzTEIwPH0GE7hjvJIcSEuAFXXEpFT2vj8BgFbZ2mXFaQHHk57NZIy3Ol4zOBUm51MMTkS/X7i9WzGU2+FvPvyFrt1DcmWpZ/vdzWsILH+5Pp7jHEyMVt9Z2ATxKKmOdxlPWJfjEvvbojlr5mqCKqWa2Df5fzWG2DpMxzd60baAj+zcQ7+PpyAVkREVC4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB083;6:G4OrK1LgUShwAuc3exJbDpgtTua67iOm/3XeQ94ANR74LXMyiCi1mH4gWcEyT+lMKieBdwBY+HZ+wdar7m69guFCfG3xFxpQ1wAqHI3GaWNagW5wfKuU0q+6X2jNO4AGVuPJPMdMnx6nYrwPvNLtb9p0Wva8s7lfQAgDzpOnWsaAQvJWmaars+2yrEc6B7w1nXq/8c5mHktiPyOC/LZTCl28U60qDsg9UnMogg34vqbZ4f7FhLRjs5lLZeb5jDNj4Vv+MnLdML0peISreD0DtUMxV5ibirjKcMFYmbNs3RslnTeogH63qb/Q3aPb9rFZU8bD//I273gR0ABfvYZS97GDeqzjaNwFTKCohPju2cyZ8Wz35ApjRAd4M713cON4paJEX01wnl3xgklAk6qvSJyBvXza9gXjgBLLiTBaNKd9anh1MeK9ln1l6cZ4n/n5FyV369r1NjN1WTW+FnAvqg==;5:85SKdSpBUT/Yl80hUq82Vr4Y9Fn2PWCnYNyPu66YmUnhqNpc46ygTEzGrKUUsgckFyALS6D3b7DNHNVCaTsRRee0Ie3iXq0u3lAl0iZ/TBWTenR+1pi3MdfWPp5abQR1dZj1tBwvvgBrsC9znKWsbaXp1mx//2hhI1bUSgU1ehs=;7:mKh4IIBpoz/Jgsuz7CExvjrjJG1jV8lgzwLoyzh2zKb7WNWk2/sXULk4C6G6ynXxKvh+meu4AIQy+sro7WagBiCOvBs3ho89CknPYoo/QWMv7B6JoEzvLpVKH43+aSmXuaOu3UbWFfX7v8hvVN4Ga3dUwhD5491YdDHJ93fNSuTsdNeSR/3aLBuWtqj95wMc8uKWl3GA7BsQ6bEeMpnVOfSVu0BK0s9XAdvrYKCsP9kFb6O/7MT8dIueT7jX9qn7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:45.7500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca3537-7fd9-41cc-0294-08d5f224ff8d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series fixes the broken BULK streaming support in
dwc3 gadget driver.

Anurag Kumar Vulisha (8):
  usb: dwc3: Correct the logic for checking TRB full in
    __dwc3_prepare_one_trb()
  usb: dwc3: update stream id in depcmd
  usb: dwc3: make controller clear transfer resources after complete
  usb: dwc3: implement stream transfer timeout
  usb: dwc3: don't issue no-op trb for stream capable endpoints
  usb: dwc3: check for requests in started list for stream capable
    endpoints
  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
    fields
  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints

 drivers/usb/dwc3/core.h   |  7 +++++
 drivers/usb/dwc3/gadget.c | 78 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 7 deletions(-)

-- 
2.1.1

