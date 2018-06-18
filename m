Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92EBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267720693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vwUHRf+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9267720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755880AbeFSGF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:05:59 -0400
Received: from mail-cys01nam02on0076.outbound.protection.outlook.com ([104.47.37.76]:17916
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751777AbeFSGF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgMI5AEffghCo7GW+04zjnGO+Dt0FPSlVOsgwM5wIwE=;
 b=vwUHRf+E2kddBBtU6c7C1PQPBjqFhooqnuoJLoL1Wc2636uxeZwcYUkYoW406X4AXW1QSQNCuBzatcV4XAxgGEkl5ClTkSeDufbos+4fUUZx3aRBVDRLUDy9tXRwWusp1qDbf2GHK6TVOrPrbBf/F8juFEL4QF5BKsGfXq35MuQ=
Received: from BN6PR02CA0087.namprd02.prod.outlook.com (2603:10b6:405:60::28)
 by DM6PR02MB4635.namprd02.prod.outlook.com (2603:10b6:5:21::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Tue, 19 Jun
 2018 06:05:54 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR02CA0087.outlook.office365.com
 (2603:10b6:405:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.15 via Frontend
 Transport; Tue, 19 Jun 2018 06:05:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Tue, 19 Jun 2018 06:05:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46762 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9m4-0000OL-RU; Mon, 18 Jun 2018 23:05:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9lz-0005TB-OB; Mon, 18 Jun 2018 23:05:47 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5J65kcg028517;
        Mon, 18 Jun 2018 23:05:47 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1fV9ly-0005Sn-NV; Mon, 18 Jun 2018 23:05:46 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 834203C724F; Mon, 18 Jun 2018 05:08:30 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5]  Fixes coding style in xilinx_emaclite.c
Date:   Mon, 18 Jun 2018 05:08:18 -0600
Message-ID: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.559-7.0-31-1
X-imss-scan-details: No--3.559-7.0-31-1;No--3.559-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(5660300001)(103686004)(50226002)(186003)(2201001)(305945005)(90966002)(52956003)(26005)(106466001)(356003)(63266004)(2906002)(8936002)(486006)(336012)(16586007)(478600001)(6666003)(6266002)(59450400001)(48376002)(50466002)(51416003)(47776003)(476003)(81166006)(106002)(316002)(126002)(4326008)(42186006)(36756003)(7049001)(8676002)(81156014)(2616005)(426003)(54906003)(110136005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4635;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT064;1:k/5NIChYk1WDlGiwPgAj8r8kx9xWg6zhWSeFoqHuJZICeW9+eenfiOsGtwdI3y3hieEsvU/Jk+oIjzU/5yuudGiqII5vTiW3r+q1TtYI6HcywfU3whxCYCD7a2YK4JRX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c97e70-4551-460e-39ac-08d5d5aab729
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4635;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4635;3:/He3ni2PSjrKkNvR3toRMyLLa+K3hetGxIur9npILqUjAvOsFmg6DJFgUEjPg17025JdelMUL8ksYgocnMESqtiQH1W9AipkZiypqZGyO+KkAbIc/Mb/7krhq6JJGRE4o5BPU36Q7SXAMOUrbNHERZ59q+lnRdkIZ0sS6H6Z5j+4FfTB1kkWAaFlJS2zIabEHVqQwBFDMrOm4KBIlW2kwyBIgXrOc8CMVoLWY3QuNv4ZSj95qKH2BLL7jBWVv3I6kUoy2bjTJb3JQFNo9G55IwroLcRg9l+dIuF0jrXGYdAuPwGeVy3mxvxC2GitNI0cV7yAPAqE4Zs9OLdNk1tAPt3zuGaiJR1arZJArRDoteg=;25:90Qw46uS255CSwVcRhn1FJT/VQjOtGNqVisjITMCUiK6yPiR5Y9TMDZnwFQKAemxtSC1oiw/riArIvWWjMCwr+PP3mr4tmUVehjJDa/yIhhENBPwj+PO0U3V9OpqRtKEVc/kzghGVl8NKFGt41hqupPYeNESulqj4OYWPkgPGSU6XTdVSJm+DyDB5eTXSZ37Llg8nAWjCH1MQvpynuc7gquLBYl+aErJzHAejaRONF0Xu9+iwsAI3y7fb/5tt39IVccl85WBqTtdpn2YXyMIqIlGlK06iLSUAXgP56O+r+Z2kdyEj30yktZC/VBLS5Oe/w7F27XVbidiOmFyw8qiZA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4635:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4635;31:dsQWoMZ4grFK8YO+oWRP+rzmrxLtdme6NdXbIbCi4KVKtlo01/Y2IaqxZqBWnYvA3A9osJt/XCin5du8GM0w0tu/F+W0d63J4zP6K34QVzRJ288lmDuI2SZ75ncsk+8Sspsl++3Gltx9mnj/i0WNTlCkdxADAmtEpnK68g/lJSaXxn8JWNZfzXDjxMxKwL1YJ+PGpdwGlpAsiHocfMThiozW356NZAim/AVh5eUqFEU=;20:Ma3F9GBqEjZlz3yIZpApi3C7TFCpQGifumJnkPvnnt2vDJ0dppKpMVuQDhLvPUZGqW5xoqAemnlq6Jyvh97sqOAR5lzdTZSJ2fOAX7hNZB/lgcE2dKFM1Ohjomb0dsq1wEEkasPZXPDejX9M71ZFvSoYMPLkWSnx+Vzf2tymVMqB3NtINtbCCHmTBX+wXYLgAesk0lw3rvC4HnSijXKjzBUIjG1rDQxsZ03cTlFaEftD5Fr+WkBpIXCMC1kqZv7kYIDog7uPrTGhq/+s2mR9Tm1dzIakVEFSjMiE90LpH5coVor/j6wgyG1VXTYyKfpQS894gLY7NqwJyRIlcPXYwyiBnG6llH3WYnCfpvOrjZ9wJrEZq/6TYeS2gDNK5g1GaGhlBrgzmJ/WTb5ySwQDfu3Ag0b1nQH+edCKWUBsaBDuyAj3XDEZgLBVhyURhBEAwVV9/whDWpCfjN9+VTYvkkmTaBeVOSVTWF4TTnd+F9gZr0IFnYRTcq9pCRbnh/YD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4635CD4B04A860F59E03D9A6C7700@DM6PR02MB4635.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4635;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4635;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4635;4:KbdjAQcCGjMTqRtA/hGgY6eYTB4ibBSmVp7eczqoGuA3YPauL6edvERZ+HHZhsFqUqBSBEbNawSAvsdPHV/CF4VRON8ixd9kh5FwOpP/y02tWsGidK69SCBL/oUb46Lf1W/by77DkTNIweOPAzywXyX7MRGb5pNnGLQMR1G5VRAxnxwWvCaEfpb2QQW2GkrvWD+GBIcc7IAUxpD93LgJF2CFvRmGQmkAvD0PJByIa+A0zeVOiNvNwEveQ8jvLVZicKLlLWR9l63+f1eDizbDrw==
X-Forefront-PRVS: 07083FF734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4635;23:YZfSCkJ5SH6q3Vw1OGQG6NSs1k1aYhWJvvOjUubVN?=
 =?us-ascii?Q?yg5PChr/u0d2sK747do2xZwAdLJK0ebwxgFJeDM2FlhKl6qM6OcxfJosHH0q?=
 =?us-ascii?Q?Qn2dklm4/Ko1i1u3BDQybqZEczUlZ0TCFsel83V7A1csZ8CUrq6Jgj5bkss3?=
 =?us-ascii?Q?hTUsogR6WpgxTJm/eT1ORuWQNilcOa/F92383iS3c7lDWed1dknW91iAcBI+?=
 =?us-ascii?Q?UKSeZ7HA6/Nbak99cXkNjgoDp1CQYU/BmTeQWAGUcBb3nYgP5oBquLq9GkSG?=
 =?us-ascii?Q?LARw84kTUnrszBmwh+Xs3DOy3espzmS+uOW5F6p/1OfNnHZBJRR/GExdDLSU?=
 =?us-ascii?Q?IYfqinEuaQ3N67/pDbF1hCkJYmz1kZ5sQKaXhupNlJMruQt6vvOl+i2bwOen?=
 =?us-ascii?Q?+padQWZCoe8tQ14dQbjJE2suUNKqu5IAJnfEvgGeqfa9hy/RIOtA9yWcc8iD?=
 =?us-ascii?Q?nL3JCYY0rFaSTDMhYmW69AyZDGqpNTg+gsp70bCQ2+m1TmH8SePSfOvnB73a?=
 =?us-ascii?Q?U+g6KCYvLMKyxd56UpTcmZx8weSLjhqn7YnAWPpQFEbNP2bh6aJtg7DnkWGi?=
 =?us-ascii?Q?T+4ZvNYfJoceDzXZqeuy+S6pjasoKpldDoP17f4v2Y1OiC+XPcYbaE5UrrC/?=
 =?us-ascii?Q?zDF+ugnOttFea7MW/txjvxHE/F6ulHo9/vaqtrGi3nb2NigdIp0ttmL0OVE9?=
 =?us-ascii?Q?DGwM1ZaoPfVZ/SdCROpN1wFwekD111bg5+Fr28mju35xin3unvgrq3UzLKdF?=
 =?us-ascii?Q?nKznBFnN1dMsMH4agAQ/BYr+7jg4MbghhQANOp/mzYanwMdLw2NZ1Nsmw7nB?=
 =?us-ascii?Q?TqiNkAiGVluCQD1T6MVL1BDt7d7O92O8QmoG1w3166kK0qQO8wp2jVqUEXe4?=
 =?us-ascii?Q?QBsuZ+mzntSFUyYh4GlvCntjVjImYmI6+6Fic4Rcd+g1CpBewcGIE5On419R?=
 =?us-ascii?Q?ZnC3+dr0QX9jsEUQuZTOs/vn6VqoVrUZoQW71yzCVLwJGWfMsx5Q6ChxtCCJ?=
 =?us-ascii?Q?yZXVBdpen9o2Ht1TnzZ7kCz+ZO5Ht7A1FQmiWXtFme4ztDRdCipNhvesZdII?=
 =?us-ascii?Q?cytSv5xg4msKaCduhbrwOjZedJuTKxucJ2HpO7s3+Sq5uamuc2B+kWeMU//r?=
 =?us-ascii?Q?hAA04BM9r4Dxq6mLcxdWedDUoBzGm5lqA0mYt5qw4jKBu7j11v6pw=3D=3D?=
X-Microsoft-Antispam-Message-Info: a/2aotiTKiA51sC4VPP+6PRFtZZGNV/r32S4Bk45GQzlyCFarDrpPX4e32bgFWXpqGBzKIs1f67Zp1hujf4c9OlkxuNL/U9tP63T3o37h5zRqiPJZcRl/pR7Dtj1UAmw+8aC8XaR4YDZ7AA3bAcBW37RXYHublEoVmlLChgOoYZJpXKhWg+DVy9qs+YSYZQN/XsDFHHmSz32SqxHX4ts90MCUfPM3TaSwDU7qtuEbULhFDTYGNfyl/BdYvOsUCTOVZoIcDWBBms9TpJ9J8L1sXwdgDs6S4CEcwlaJ+e06fswKy4nVz2PyS8LfstP7aTn
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4635;6:oEGdWL0PG6GtQCF4vxNcTC9uGFJNiM/N8+zSgfpXh8vgIwos+k4se1N0YRwKOXp4c1ej0jEt0gc3abGAZeviy3RrV2UhQGPLeu7L6onh1JNJhqdVeK//jvW8y4ZAHX1gffK3GLBaNITLWYteIgs5XzT4qmC+zJmGLiWTnFiFMOmKeqjixJ/qK0k0nODNHcAgu9AXUGtBusmEWD3Nskw60TDg4+V52MPzN6LSiN0rYhEUaKcfFoqvdHJ3mDe4IghjOpiVngM6XC8yu+4PaN4Lup9+3CYERG/mBhyEsdcZbfHD28AHUDgZb8hq7COgfvnyhLXa1Vpvhxm/EoJ5TIerdZuBmbsFj8H6+rv9KXvEtNtTy5Q5U2RkDhghS2mb5kPqaXE8nLRFHL9aPGzMeD7hvkBeVzSwdMhdu28fOx/N2Ec8ibgN9h8nYNeM3uP2SSxPJHtxdSLp66fnYeg8P0ICkw==;5:fl+j5cU8SgTqHWXIKJxuetpXrB60NRKWcHHEtah5r1ZcCAhSkwhzNoHl0PfN44tBJlrpaAN0x6xMX1HwPODvZcs7t1iVYXVXDee5dE/0Fgln2TBm9+7nc2zURtFI1HjmavgUrQr/8sCF5e4R1ECAxOlMWYd7XM5w4RzexRZEIlY=;24:IGSJe4mW9qp1MJLSbC9eFJxklbrgjNwgjF0p8vilCMlvHPtg9K7J7aSMoJmlGN0OmhtU5y7ad9NiwV77GuFhw5z4/7fexkm0fwWfjFyQj8E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4635;7:Q9H4aoQsekJW+2b7F6E/umv6qkQGVGn/sleJ6YIL6zpo43RP4vVZ9lULb5AeRplN0x4BX3AWGjK8i6qM9mtUV6lLDrR9eq8fsFO4sP9y+1kQJFRI32awLEU/z3mLY/q2Y+QjTaOORPnR4lOlhiClZeUtMnAIisnxWwpYOGxZtdcmHH414eBPYcwZwwo+MkVz5Q9cvCatDGIHb7sTRhrGmdGqYX/yTilwl1P4YK9Gq06C4gTLLAdP7GSMRSz1eh8R
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 06:05:53.3600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c97e70-4551-460e-39ac-08d5d5aab729
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes checkpatch and kernel-doc warnings in
xilinx emaclite driver. No functional change.

Radhey Shyam Pandey (5):
  net: emaclite: Use __func__ instead of hardcoded name
  net: emaclite: Balance braces in else statement
  net: emaclite: update kernel-doc comments
  net: emaclite: Fix block comments style
  net: emaclite: Remove unnecessary spaces

 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 101 +++++++++++++++-----------
 1 file changed, 58 insertions(+), 43 deletions(-)

-- 
2.7.4

