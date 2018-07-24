Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C805C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A2320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeGXFpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:45:00 -0400
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:24924
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388166AbeGXFo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:44:59 -0400
Received: from MWHPR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:301:74::16) by DM6PR02MB5001.namprd02.prod.outlook.com
 (2603:10b6:5:52::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Tue, 24 Jul
 2018 04:40:25 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR0201CA0003.outlook.office365.com
 (2603:10b6:301:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 04:40:25 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Tue, 24 Jul 2018 04:40:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fhp7Y-0005k1-JD; Mon, 23 Jul 2018 21:40:24 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fhp7T-0005Kb-C3; Mon, 23 Jul 2018 21:40:19 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fhp7S-0005Jh-BC; Mon, 23 Jul 2018 21:40:18 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <netdev@vger.kernel.org>
CC:     <shubhrajyoti.datta@gmail.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] net: axienet: Fix double deregister of mdio
Date:   Tue, 24 Jul 2018 10:09:53 +0530
Message-ID: <1532407193-21637-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.131-7.0-31-1
X-imss-scan-details: No--4.131-7.0-31-1;No--4.131-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131768808252898444;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(106466001)(76482006)(2906002)(105596002)(498600001)(5660300001)(16586007)(73392003)(50226002)(9786002)(450100002)(54906003)(316002)(6666003)(86362001)(81166006)(336012)(126002)(63266004)(61266001)(77096007)(2616005)(36756003)(575784001)(305945005)(476003)(26005)(8676002)(1857600001)(47776003)(2351001)(4326008)(82202002)(6916009)(87572001)(14444005)(86152003)(8936002)(50466002)(51416003)(73972006)(2876002)(107886003)(356003)(48376002)(55446002)(83322999)(45080400002)(81156014)(486006)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5001;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT022;1:9IeNJrTcljo0EmBBVV/RdHRcUcgkvtRm8TIYgiTkAEkEOmPJp/Gyxb6RrB4Gs6w5VY/Pps0dfhRTdWUs+kJz4TUhE+/6o9XS/4XAIfxs0G8RM/srmTE3XvLrhbZdmoDX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e42f9fb3-560c-41a8-37d1-08d5f11f92d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600073)(711020)(2017052603328);SRVR:DM6PR02MB5001;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5001;3:Aw4/j8KEMQ2WwnJlUDhWqRxBic9WI7eVNM1jlHjobHeiSk+s45/jctQ1vZuS0sTt0ppKkYfcN1oasjEQbDbN6Ql1SMxua21RnIyngtLhcYEOG9lcQGvXbYzgrXlJwcmcry/PoIBBYU08tRwGir+snYQAA0FuXEBkegm+exXLj2kX5BmDrE+Tu395fRC/gZHAqNzvELhr6jVia9X/wC9b0uoEShULFDrvMeTHP49BhLJgmCvT7Nv+wUQgVbL/jTXa4cc1o0vRLMr6uNQum/RfPs9ZNSBdeV3mZoRRtzBBI2nxVZgT+Swinxx3/UnZosQq+xWn5wBjCvCf1EwzLJIMnS9e/6pqEjVX8BNWedj66AI=;25:sloJT8quhbIHPz2chIqWSBDgxQY0bWCrZLuYn/fTGBGBi/wjPSP4CFhUs0pzhM9EnpYjUd0bDGDLAROTkbUQrDBpCnBBnue1l8pDzs7/obZrCygUA4ZGAttl7ugjlmK8nqk2uwkVH/QhPQLYCP3foTG9kIWwkGPwFfnVRl2lNb5YyBg0wqiZkB2xNuprAxpTKph7uYuV99tM4rAbpGLZlEmZHOnDt1VVq4T+HrDbFfqBsxXkYFBZT2Ot0z30QrxSgims9IraFfXp1BHeWlQ0rsyZehgrmLMn505GxyfTmNj2LD0xCa4JrWI1DR7/DKfBKpeA2wOJ7FNKLMHVPSY83Q==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5001:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5001;31:FeAguqNwPn/5b4phV6ZXfRBj0fu/5DSDGO+83gEAqMQvYjfjVk3jCv0LYZwsPA2G+3CSmQhu5gDSwK4XGselzKNycT/D9ItMiCJ/3Y5CDhacf1yDf1gJ2oLlWVM7/Vmb7hjG7cDZHPz3M4xZYV9ep48ZVjfy0nk+fy8BAcSYu1LNV/YYTXrlL1+eOQKK8AJGjFGU840I1tk37D8iRumua6+8gIUz1n5V56bwS70Cz5U=;4:HyFJH3hWQEuhwkLEWPWO429HXgt/sE23CxIGFGt45TctX4/zVlBQwpUFpmbDGaZiqQkCFriWMofLn01tEfFmWseKkCSppLztu8wSE0MLeKBpMWaB1Z8trnMuNl6bsd5OAFgtH31o4Cj088vUXbwJJ6xtk5FGv0NRvi6f9Kfo8A1xL7bQuRkDp4YcXZ+2M2qyzlTfMx72jz09jw6g8SUkxFXjmNsFCAQBlXmU95pPy7wZSyN/6R9RUMSrGFirhDqcbZ1JRAGK4s9OvcQBa5j3AxVvrDTbG8tlj4s62q8Pg+LpMa/gKJpkaKO8l9zAj+x/
X-Microsoft-Antispam-PRVS: <DM6PR02MB5001B1AD664CAB7669973D3387550@DM6PR02MB5001.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123559100)(20161123565025)(20161123561025)(201708071742011)(7699016);SRVR:DM6PR02MB5001;BCL:0;PCL:0;RULEID:(400006);SRVR:DM6PR02MB5001;
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB5001;23:xTsIFQg4xigWzFfBxg6xtupweShNJNqCCseVpAGwm?=
 =?us-ascii?Q?4ErCmCi41wC4RBV0REcC+nv7n1R/edHCWPzw8sdyKYLSqNsh6QJo9CHtZFfE?=
 =?us-ascii?Q?Q41Y585cBIa3MxjX3+09JLE+b7ne090OtjFkHxnc5OQZ7s+/aT8O48jR1m94?=
 =?us-ascii?Q?1fMIY0Gbzkq0VdjZRrC+LKyTffAFEXYhFKKHguxikhVHHjbR48cMIwWl0jIP?=
 =?us-ascii?Q?iMYE5MwhnQdftqMysmD46l1qT7xAgrUH68KRlHndL3k6PK15VaVwMJBPALtO?=
 =?us-ascii?Q?IQdTtyvV4SqB9qODrjqSXaSNqYrfp9ZH4Yg04w70bTvs2IRva4jCIud7hs+I?=
 =?us-ascii?Q?fmdDjKFiQryUnvLyGywXPsENlNGZdTGreCBvpNtAceW1Dn9i54SZjHvCDMcA?=
 =?us-ascii?Q?nIVGhJM4izZ7h5w6h1yfVmzhDTkJnNRyL5GHnHQXwDdDSrE2xbhjOUumwlpq?=
 =?us-ascii?Q?s/3lxU4TyaP8CQndzep8rcOE2px9+6MuoVW6lDFm3WorvqLEl6rjvkFYSNZ2?=
 =?us-ascii?Q?vKny5nw40vybKgIjJYGH0mnZjwQ1huGHAJlSDv1or5Rr6ZLRU3F8c78BMipB?=
 =?us-ascii?Q?wurEbUsNGcvawj2M7ibHhzfzGt8MW9I8vACjO/O5Nd9kFhxRrGxdWXPg4eYB?=
 =?us-ascii?Q?DE87uO4Kf5NdnkC9DJH3ySrWOslwuwAf1TxX9HHkAVz5jmsr25H5TifTF+Xy?=
 =?us-ascii?Q?sOGARQBJ6w+bq/45OXdqYCOnLpK/EktOvg464o8OFLa/Abs/mC2ydys6Qacn?=
 =?us-ascii?Q?/Ze9RfOxVYL7iPgDVmzh4vm73ULKeT3KIfV6h0I2HC9c+l8TSXZc7JFdEcyd?=
 =?us-ascii?Q?1EKubJVhnE5zTjw9prLj5zZudXQt8PE+GAPqaCKTfikFdDRzSokCsTOaNyCR?=
 =?us-ascii?Q?EiBwM5r33MQNi4jqTt3GLiRx4PafAt5mLtObLc9kgOSMZ/7ZqHkyhX9P8GNw?=
 =?us-ascii?Q?jNyC4lNBAiEsP0kuHzLmi/sy7nJxKCsJashNP8ygS42noV9KzPR7ix2SmXPr?=
 =?us-ascii?Q?N982E+YIuGCE43ErwHAxI04H7s1/eAic9KyuoBjFNDlvOJzv9ay1vzFpPij7?=
 =?us-ascii?Q?gw3PQsUed//+Woj4oPgpEw+dxNeB6FiM8WQweAX2km9KG4L6BybBYbxN1+16?=
 =?us-ascii?Q?g2HHnvKGjOHaZ3cSTIzRSuVNGW8l5CZI3kqYVM53zWn6JWxIdAsksN+mBiyZ?=
 =?us-ascii?Q?S6/p7lvBUJNJu1HvLb1ZwT8mpuxybu6qWvtBbZKiBY2w6L4b06jSSb/+5jiR?=
 =?us-ascii?Q?F57H7aetzF1tSWVp/VYE+ZNevGJywe8e83WKvafA4PgQUsYCWfekIHVtSdFk?=
 =?us-ascii?Q?bC7pKAVkZHIEmaBh+vW0FI9N36l+HrZ7a2W+piPFdtQEnA51oqOyjFOMwCSb?=
 =?us-ascii?Q?g6NZw=3D=3D?=
X-Microsoft-Antispam-Message-Info: tP+Ow1K5YPm+sRsh3bhyb/kTscdHfzgnHd4GAv3W8WCPQZCIJjgCJ6iNEtKJ1Ku9MPHv1IFMa5RF4qkYiZQTXFEa53Qtf09GZKhwei49hy5lclRBFab+sMogGCGftFsUQtpQzMJs9jWLm9x458RszbEbOtQTKr0mAExg4g6bDcDtEHErafQEA9RsSW2X0yBKjyo2kP4cZkPg0+8OmiYBVXm7sKg3B8cBwbFbQftFxZlPjdjfQlkXCO/xrICWl+xncfI/JrWKD254w1tZ/redHsiiG4sLymFZRKCENNgbLPMzQ8oTaYh7hgK8Fljw75hwVfyS7ygZrvt0nyd/rJ9neCICHOvttSe4ZPbkEdQbaU8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5001;6:IwldBxI7DSL8ZbURUAF4iLoXpDZk6ZUV9BXvOILmntNfK3dBxDXCxFdHJ9EbMMRmbch9CJb8jjnge+zGHqjgU/oGw2p0vzXKmPJi3TIjMsabH+ok1Y4UWmPu9roPxsYkv5s9/pjNbhR7CS6LHubLhbVw14uhJlufoqlH0//xYb+sQzRAxghGfZs+NY1iLjBRITVnpDOOHtVwVOR2rATIvDM9foOD/Tv9oJXuWJqUczUuzWapL8LOqCl5/zPU2xJZiQTs+u/XeVRb5M2VKZcSA3NghH0rcEsj4Eus04Z6S2M5iSlvkX86EnZ6r2+esp7vcXGmzq3HGbKiUajixxDid/7FxPuLmRTi07XEl4nDNOiS73kcF7srJCMYD1mb8DiJCnGvmwweSIV8TOcJ/8LSmELbkJdOuHg41KKSqbAzHMq4fTBEz73P5h5jN43LlqsXeoYvl7z3cPpri1pJpHejCQ==;5:uK8FgskZFYoXm/wlYBcKU7paaVo/M7q/xeXLqh9CiPRli+Rlmo1C8eKFINb4iHPcpKfPrI+p4PuqT3OoZqucm17EcbG0jkpLbznwoVHzs769MTrZIiPHZ3ofH80gCeksQtNomiGUeJDa10QqXHjPB9tt8aW1Efy+soAOlp5nJpY=;7:SZSVdidBiLMXs9zXE+MkK5IiR3LSoKtxfEz8/vPVIlOFqyE42mlXKab+b5GoKAA4PLhty4ITyiDEYgTsAvpOdXkbvfzZfva6INPO6IXGsa0680AMNrs5AUsmdC646GgBUtkzGAlJpehFhwD7gq8Y5YsGm1F4DkW2q91fsRmego6i0u/bFsPCyeR1IY9J3sKph5n4q1n9ayvNX+TZEN5xz+PF5Y/Co8j8d1ojRmSelFkhFY07efOfwx8JKF/dPy98
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 04:40:25.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e42f9fb3-560c-41a8-37d1-08d5f11f92d6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

If the registration fails then mdio_unregister is called.
However at unbind the unregister ia attempted again resulting
in the below crash

[   73.544038] kernel BUG at drivers/net/phy/mdio_bus.c:415!
[   73.549362] Internal error: Oops - BUG: 0 [#1] SMP
[   73.554127] Modules linked in:
[   73.557168] CPU: 0 PID: 2249 Comm: sh Not tainted 4.14.0 #183
[   73.562895] Hardware name: xlnx,zynqmp (DT)
[   73.567062] task: ffffffc879e41180 task.stack: ffffff800cbe0000
[   73.572973] PC is at mdiobus_unregister+0x84/0x88
[   73.577656] LR is at axienet_mdio_teardown+0x18/0x30
[   73.582601] pc : [<ffffff80085fa4cc>] lr : [<ffffff8008616858>]
pstate: 20000145
[   73.589981] sp : ffffff800cbe3c30
[   73.593277] x29: ffffff800cbe3c30 x28: ffffffc879e41180
[   73.598573] x27: ffffff8008a21000 x26: 0000000000000040
[   73.603868] x25: 0000000000000124 x24: ffffffc879efe920
[   73.609164] x23: 0000000000000060 x22: ffffffc879e02000
[   73.614459] x21: ffffffc879e02800 x20: ffffffc87b0b8870
[   73.619754] x19: ffffffc879e02800 x18: 000000000000025d
[   73.625050] x17: 0000007f9a719ad0 x16: ffffff8008195bd8
[   73.630345] x15: 0000007f9a6b3d00 x14: 0000000000000010
[   73.635640] x13: 74656e7265687465 x12: 0000000000000030
[   73.640935] x11: 0000000000000030 x10: 0101010101010101
[   73.646231] x9 : 241f394f42533300 x8 : ffffffc8799f6e98
[   73.651526] x7 : ffffffc8799f6f18 x6 : ffffffc87b0ba318
[   73.656822] x5 : ffffffc87b0ba498 x4 : 0000000000000000
[   73.662117] x3 : 0000000000000000 x2 : 0000000000000008
[   73.667412] x1 : 0000000000000004 x0 : ffffffc8799f4000
[   73.672708] Process sh (pid: 2249, stack limit = 0xffffff800cbe0000)

Fix the same by making the bus NULL on unregister.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 16c3bfb..757a3b3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -218,6 +218,7 @@ int axienet_mdio_setup(struct axienet_local *lp, struct device_node *np)
 	ret = of_mdiobus_register(bus, np1);
 	if (ret) {
 		mdiobus_free(bus);
+		lp->mii_bus = NULL;
 		return ret;
 	}
 	return 0;
-- 
2.7.4

