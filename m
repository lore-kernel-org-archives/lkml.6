Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o/x8Iepf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6C420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbeHATAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:00:39 -0400
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:19728
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403758AbeHATAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtO4sKAgAkQ8Eu5H2YHErlhmxCHlDlbcRXwNC2+nTUU=;
 b=o/x8Iepfhao9NgieAsrve/e/dESj5HfqfSTPIKVxub7c86OUmLMUIy9c76sIN/JwfALAtIp07qsHq1PEWM/hLUJabnuVsRIxE8NcApOCZ5wz1B5NeQbGSkPdCrhm7nJX0v0w+xCtnm70cOH9NhbYEdVE2hh2Zxwce0QN2QiHf4Y=
Received: from BYAPR02CA0031.namprd02.prod.outlook.com (2603:10b6:a02:ee::44)
 by DM6PR02MB4458.namprd02.prod.outlook.com (2603:10b6:5:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Wed, 1 Aug
 2018 16:49:44 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BYAPR02CA0031.outlook.office365.com
 (2603:10b6:a02:ee::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Wed, 1 Aug 2018 16:49:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Wed, 1 Aug 2018 16:49:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJh-0002L1-HC; Wed, 01 Aug 2018 09:49:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJc-0004si-Ct; Wed, 01 Aug 2018 09:49:36 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w71GnWKi009047;
        Wed, 1 Aug 2018 09:49:32 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJX-0004rx-FX; Wed, 01 Aug 2018 09:49:31 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/3] Use xilinx controller irq for AER handler
Date:   Wed, 1 Aug 2018 22:14:46 +0530
Message-ID: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(438002)(189003)(199004)(50226002)(8676002)(54906003)(316002)(106002)(16586007)(110136005)(8936002)(9786002)(36386004)(356003)(305945005)(81156014)(6666003)(2906002)(81166006)(5660300001)(478600001)(107886003)(77096007)(26005)(426003)(4326008)(486006)(126002)(106466001)(2616005)(476003)(63266004)(7696005)(51416003)(36756003)(50466002)(186003)(47776003)(48376002)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:M80ZfRLA0wFxObLpAsoXYUFIlPSpyykAXhXmoA4WSH4qAaOo/v9ZExZF9VzypOOOAiXQR6WdEoUJqgsgt/1ww6D8NZWtg6cbCPMp/REhaDdthRGX+fSkmypTYaCmO5Ne
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8b3d6d4-73a3-4ca1-1fee-08d5f7cec7ee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:htC67WBPIoZhT/y0Ht2umPmStgzoKYIkLzG0gu5ZlZW1kpSD9cJE2EdkVWt95sqfU2wTUcDe9/mvqWpm9QYVDFlvD5z/wKoVfrvqq95nStoYUKkPPrO7hOuyqQFT85L6x8aioz+buB4TgJUFYw4FsqD3ep1ZBh1hgdcQjujOyO39LFEeAlWx0jIbcOq+eo8RGp1p6bdZyB72Xcch9vth4hEFxw4URl53X6bMJNCbc6iggNPuGK57D/yiayy5olp6xB8DSdWtd6FPDECr4ZeGPjWdj4o4fZYmuktawsnZXlPJ70YLMCfmYg3MHvwgwRXxqoqylxKxipN6+kRoJEGj2Gdoq+2iqqWpKfKGyIcfdyE=;25:5S5oRzhANfwgMgJL4Koha7p7uHDpLhJaAgL/cBsc9ED2Mh4KyCkNndtSwFTlMsgwG0GzfjPjl1bxWOuro56kptoEJ2tI8sszTLUkaz0hT8CAMxlStYOVmY+EoKeQz63lOkF6JqsRVV1nbKQ7opV4zePv1u+TWbAB9pwzjOgtnB72lccDPQe5z9TL2WBYOspZ99NteHvIFKQ6Qyvd6Pv/JcqqlVkgNEonHCswXA31HqQ5w9+K0tu16dFYd8ULKTLEaoDF62G8EOkjiN9qw4A0LuQz3END26ueFGwVr9Qc1DskrnUfdrFMsCijK69VCKd/GWlMnlSfJlKgyafv2gipMg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:Ooxh7Voced3/38GoMIsEW1mpucr8+9u3mmZcYv7WCzyv8FCre0hz2OMS9K+j2rrI+PRePwAHyJbuBa+v0wVez8lrxj0/+kqhqrlL6u4EMMv2KqB7vgnTgx5iSpfSu8UbiVtco2isSJV11oHifngRe3g9qoiG+Vil7A1jgLOvoADWtFQ2CoFWO7RmCeO9MQImkD5xTJuJxrUynQzxpMjXJ7txWg++vPcBmr71atSsyaA=;20:oW1HTcRp0oovmpq8Y1XPgNMOwcyBA0FMdiHW8gwPUdvapEkhzD1V/1j9F0eLd4SZ4hBMvb877X4No+1M9vqBfy7UQ3WOd8HbolqYtFB9ZBm9U4daIlPFGyGxkzHJb5lJnRZ3uhJmw+jAsbqrF6lIhnqh88svxZyU5NsQQtYfaIR0a0zGkqE9/rIWsxOn/55Vpf5rQoHn5lgXitPY5O32CMHVXUv5yVDu0PIPiT+aAxdg5tAbuQKwDmwIbLgehL7eW7eq3pJgcE5v+m2JCGm7/osQr7opK41O8jxKSzrgbCE7X/hcoDMTY3GwJuSYhnVZuTDJU6Bm/GgglY3/ov9uoWTwz7+gH9OvSpyPJ5Ym4nTqiPU5e4rx9vjywl+Jx81C0sZea4rAf73xHhL2D0TvSW9sr151SUDcCFext+LHMeR+hEFtcPp0iX0GIr9GCK0bW8mB8bDcWI7A8VwYUDjyAtn7sHvaepkWVwR3tmjDYvMYh56LMmOTGOLSXibGDXzO
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4458A6A540E9C83D5F189FF7A52D0@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4458;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:7oka2LfXQXE2Ap8iyHLmgdGdHkGN+CsNfbJNGsoxLcXRKtaYYqLODR/8gBoCzRtX0J2Ghe9s1tolDVcQvsmla8BfILE8NHZvnDtut+0g+9KmTGw3tz6ztUQlMSMjekNgdDCKBS3i/GXMou1adO7ym37qI99I9gwlUkmVQoeCImpFBZ71XdHAOiXeviNLNejd/mM41CFJjuAvEGyTkjkrXtMbL7nsNs/yEyU1gcno1cjQz/opF+OUJ0Fw38iQ1yfZmuQm43VPxVXFjIQpQz5nkrhicKpN6a6X+82pmIAuzXQjCYQ17EbBUOl2SIGNMbfY
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4458;23:F/QZdYP6VxYb2YH44K6xzJ+5WFm5zBwdFf3detOIx?=
 =?us-ascii?Q?10CYMJbFY5VpcaVjTsJxntmGw6CibACVNXmDM09bC28kC/hHLkLYY9tn91zF?=
 =?us-ascii?Q?wQceUykBBUXk+82nWFa3PlGY1lxrrzR02BHNNbdP8M0J6a6uvON9eey60Tpp?=
 =?us-ascii?Q?A4vs5zIlelt+V6JAAAemetUyBWwt2CE7ikzmmPQrlWMLQEg/F2/KYEOa3tfC?=
 =?us-ascii?Q?8gHIBUSvHkrKpis71apPjSokd0RdnXzTm4MhtnG0Ow4HRzAwIALR6RsVbboZ?=
 =?us-ascii?Q?+5m4f7b0PvtfL31hw1R1aizCitT1Q1n0tfOWg73Rb7NUKrSFnto12gO7ZRAY?=
 =?us-ascii?Q?DEGuJDT9GFr1BqFb9dGGSi/RbCakMz0Ae5047yonUf75yyJOvhQt7mHGurED?=
 =?us-ascii?Q?233VOBizB9yNEX8E56a8l4WrvFa6Mm7canEh9lST2TnjZltyhMmNMybjj804?=
 =?us-ascii?Q?cu6xk5beJsvWgY6QWa3hNmUywH6pZVLjKmQvqCejT3zME8pDxhYfd+k777yR?=
 =?us-ascii?Q?+k/AoEIz1ii61b7hK3N6yWJasHDvQIW+RLrxHJVsFcVbjqur5hevAj/koZdD?=
 =?us-ascii?Q?ep/nNXi3ES6R46byKvf/CtDtCLamCgRB16M2PDAPt07AN7VJTHxFLY0mdI2D?=
 =?us-ascii?Q?YvRYFEQxkTZmRO1iN8pVDWeSWlonmcAbzfZbfZswYxC9/VAWaM6333JW08Qn?=
 =?us-ascii?Q?H5rFxXjtv003hypodcIU1nC+4YdC6Bp6qYTYv6NTNrL5L6vsN6LWbb1XQLNB?=
 =?us-ascii?Q?RVAIrhaJ5H3ytaYNWRe/8kRxrfWGddDwjYCOkUJrd5O6OeScZbBC5OUIki/W?=
 =?us-ascii?Q?fJJaMeMbdV2dzeq5dzcRr1UPkfp7VuoHJ5DuCynzQFV60I3FGB4Dx2GEOS3Z?=
 =?us-ascii?Q?wsnx3okQej4FnWXakiDWbVkvAr6XqzJMe8CrN2rSYjhCeUlnCqqxQNlUAsH6?=
 =?us-ascii?Q?AnobvH53veFXoaYPiQtsv+YXlItiPHoy7SO9JEKJN/5kPHIh0AGruRF9j8Zq?=
 =?us-ascii?Q?mcABLB/JK0KT0tw1LDM9uPSO98SoNbSzBux5BHeY7n52nK3W4EbF9ylhVcVM?=
 =?us-ascii?Q?uxobeY=3D?=
X-Microsoft-Antispam-Message-Info: mlMzkT3RPpdIo/wEUrRCV38J3n8sB334zq8GhlqkBAoKZr4jFTeyi4Yz56gzUJP/BY5yxaVGXWR6RnSYvBDGmL0erQ+dP77fYLqj8EKRhn+tFul8LZfqbDfAjRBFLBCgewt1LrwfvTRYNVpV2yJt9Fl3+BR4N6KBulF4bT8Bzox2KamuWdeGWISf20aMPI5fywbS2FH4N1ZvQXt79Rdzu+hL7XwToO4/R3St9dc+1l93TEadJFZ0lVtRBOGBlho26QXwzA9VLN/hYJmxMZTvwFbX7MK/wplVlJCOIRu46yeb9WsL5QGNIE072ynZ0FsjobdFmKH0qSE4M1jR1CCpctp8/hACLqC+gTLo7N/E66g=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:ui47qeXc2QE7OgeooVxoic1LGqZ5UYj4V7YrK1mWkPicZQsT6kkoBIDY3DUyBStUP11za0ovGox714VYB61q5+fmukh5G4S9OWFjS6PajOQztUQeI0Zqh+9uhmRNvQbcUohlGIipYcNzvKGS31L6G7bT+8zDC5PIKyC9VKRumL8RWE71rlCj0cLl/F9gHybQD4WtKZnTgP5//AhyDzngfD4I4b5Qan3tNb/kCA1RQpzHB9A52w28C2SkMzfoZbUkAKL0ZhLihxkB/eW4RBOOettH9n34AoB+1jKoxmMze2JincyHKBQ9PypfjtAU2TMGqWyx6aLLpDgvS0OYHJMcBkuHj1zggdzLdtE0d+6ao5b/KIrXsDjfum+rZA75sewCN1d1j/y3iRsxjywlBX6YONaOl7Q6Y+J1q9/IILu7iB9c4kEnAAlrkLTnZL21v4xQPA6K19BiWufGX14KjPGZsQ==;5:BhZNKFa6tVgd69OaJEma5qxWJoQZlBj30zYAuIF4DMlaMyhCN2alsPZivFsVzs45zwSiM/qhBN/7zU9xmv59lrs4s045RTKAHDmqiv/6NZWAvnlQteqKDGZoCBoTmKxAgXNtQpwDEMfUEHPWlKtHGbz/KfNqIvCH133MUnJ2aK0=;7:kOBOip60TOf/H6H8FwyI/iG8JNLbUggLaOMhPbaSOEVYCJJUeZhSnzJUtk4YsL7doyn6PfXFV4Al8JyzsVRnOj5XDpQMrsVc7n2liAeXbW/DZWwcTMh8cQ4E3xEaOlzhXHJdWaSY9P5ZgUUG6KDHu0TnYZGQdPE5gdoAsKx1Eb4swX1zVUAp0Q3tHfrmoHskufrqBsd719MP83L2cr1XUkd5isoimLnIxGS7/qZoUU5wlZoeEHe4w431/9ScQdxw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:49:42.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b3d6d4-73a3-4ca1-1fee-08d5f7cec7ee
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
Error Interrupt Message Number. The controller has dedicated interrupt line
for reporting PCIe errors along with AER.

Since pcie-xilinx-nwl.c is platform driver and AER uses irq from
pci_dev, using struct device_node private data to save xilinx controller
error irq line. Using PCI quirks this data is passed to sysdata of
root port pci_dev which is retrieved and used for AER handler registration.


Bharat Kumar Gogada (3):
  PCI: xilinx-nwl: Save error IRQ number in device_node private data
  PCI: Use dedicated Xilinx controller irq number for AER
  PCI/portdrv: Add support for sharing xilinx controller irq with AER

 drivers/pci/controller/pcie-xilinx-nwl.c |    6 ++++++
 drivers/pci/pcie/portdrv_core.c          |    4 ++++
 drivers/pci/quirks.c                     |   29 +++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

