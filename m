Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7237DC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4F820883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sFEGEGcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4F820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeKQKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:11:51 -0500
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:34368
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729550AbeKQKLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84AIBxIeYNFdPkga5OybmGCMZuJrM26RsELEsH0iAnc=;
 b=sFEGEGccTLbP2g+zPtofKZgENuTorGAdffFes4anXElqg3tHcB92jSKEDhyaUiseqi4fX1teljrTbQPSOXo7mNiAJe+o12/xkvSkKpd4dAXTG50BpDqK8YplKQmo8I7EuIFKGttwjn09uIq/X2hpLBkfgzb/v+2U/khSbV80SJU=
Received: from BL0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:207:3d::20)
 by DM5PR0201MB3512.namprd02.prod.outlook.com (2603:10b6:4:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Fri, 16 Nov
 2018 23:57:15 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0043.outlook.office365.com
 (2603:10b6:207:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.23 via Frontend
 Transport; Fri, 16 Nov 2018 23:57:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Fri, 16 Nov 2018 23:57:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gNnz8-0007TU-0o; Fri, 16 Nov 2018 15:57:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gNnz2-0006qO-Te; Fri, 16 Nov 2018 15:57:08 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAGNv4EH015442;
        Fri, 16 Nov 2018 15:57:05 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gNnyy-0006pL-PB; Fri, 16 Nov 2018 15:57:04 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 4/9] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Fri, 16 Nov 2018 15:56:54 -0800
Message-ID: <1542412619-387-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542412619-387-1-git-send-email-jollys@xilinx.com>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(126002)(11346002)(476003)(44832011)(486006)(106466001)(36756003)(107886003)(305945005)(336012)(186003)(48376002)(426003)(2616005)(446003)(63266004)(50466002)(5660300001)(16586007)(8936002)(14444005)(47776003)(76176011)(81166006)(81156014)(8676002)(50226002)(6666004)(26005)(7696005)(77096007)(9786002)(110136005)(54906003)(51416003)(356004)(106002)(316002)(36386004)(2906002)(72206003)(478600001)(4326008)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3512;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT037;1:BqmOdnTsc0TyUHwpAGPCsU6zMFCCE2Ixg0hxwqLHAoI+KFz2b6HdUpNCJTa9HFZBpazZ18WEWCq4KCY0HiYLhODdrxPLu22yMaaf6x681JXOeOUALJAE3XAHIrwPkXTX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdda57a0-28cf-4c7f-b75e-08d64c1f3b9a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;3:WHrRXYGGsiT5p3K5p/a7VgMWTPO9CS8Gl16srQZk5iChy75mHyF5XkSOTbEgI2IC8sZUGaxQunfKhmUrk+EyhGzbayqI47kTkr9AvIpBNa1onKAa4C8iGmltKU3KSVF1TFq0CZfBR4fnWPUbltNr5WvCAji7ygEeyyJr+wQqZGZ1zveRQ79o/ZuB4h3GrHAsAO/r9TnDdIDY0BrRXcbwvRZwTn5wmSm7hEcYQA+O5ykociTGnhQ6L3qEMM2b12IsjST5CxhePRLziPReVr9UBKZqcXlZf7ldu4XuQWfgsJUFT3AS81vosQlRIR/6XEwcxjyceK7gUdcxv5KYM6RYmVfBRMvzUoq3Mw70WsTIO6w=;25:G3Nzg1U3/5xdIVKQpaN93pCJdzq74LPAO0nNQOgJCJot1Hp5BLfVTSXnSKMNA7+V9eU2dwha6XvbdAJM3RNacOZfysV/dk0fFgts+VaDQjDn6RrYzgsofIEJzYGFLKW+0YItmt6bKjZls8f8w8SdrGfyyzVwHQvTXBRcE+G4aDta5MDJvsLMzgiBj7ZYeYA4X/U2piPAs0nfLH5BjEZbE4bp6S/dzI5dRtm+dECGC4nUrOzQzmS0Q8dt4OIM5GqNWta9P38+HeKbDr6xVBUqyZHVCsmXDhCw9eLIJdNzKTmhR+K24Bipl4N0vAaNvrpvkUgG06HmF3w0zpCt5T4yZbK0/5uWIcu4Uu/u9N+Hn4Q=
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;31:kxpFJf6FR8ElZ2CKsVavJMoIx+9naHHY8R4JW2I4asMrr2AZQvzs/r5ziQQSCVvT72o26L28SjD6B2A7ObyBziFOb7yHsuL7zwXyBoHKNWJtEL7Lb+eSA7NKL9Y3naOkXztDf02ug5xw2JGKJFBmiBLRUBGua6IP9AFuUsmnd+nJ49NSfR+9QrQ/ipoiAYX64u3Hw/BSGzz+wGzKme+UJ7m4jFFs6VfbOaFUOtyGmaM=;20:Eju6sdskRuY9sIWQDvv1Fbt1qpdwbfFeX2BE0jdGwJNnXrsYYgyfUxN0xP4HCtFcm4zccHiK+XULpgShtMP4qCjdL+KUtchVa3CFLTNVPN7sLzYDPn3L+SmXdpZkvOwgpe1KC9PmrA4r0YdEqTkYIDXv+rKCcU+Roo56+PrN34h7Edbrgor2H2vrYixyTDTaTbOqqgyOxPhXZljXNH3xDQrhlYinwqVq9FuVqQGnj31KcAlpeRLZLwzys0XJEXaAfBCt8dPURCiQeLUOFFrSucoNsgfcpLmUX15kld2sKai1fDQXZYtyGTJaR/klfc7Bn6zpbVGfY0KC6Z76JUoP60eDG+BNP9rihFrQAumz7B46Rd1bkhVEZQDyjMuDQ/xwU6XWcebuy+2pw+75xg9J0kCs1E0AC4dTcWuYXK5MSbJl4viPr579ASQBnG0NGtYfQ4zsVjJtjUoOM0NRIboFtXoRbv2Q+D2+sbRy1lNKZgHNOJjLOOe1ljthdsZ0+mti
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB351279107A48EDDAF516604FB8DD0@DM5PR0201MB3512.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3512;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;4:17qHo+u1G5FifmoOJ3WJaGbIVe6i7IT743ljfQ+sNlww+kcvo8L7WVlswFH73N9e/36MYvoZlradK5Jds0rsJHuvKMDHyCMbwn+N0emXJbTjYkv1ZQexRBNapnhDpDHDC4+eeLtdcCSzW153J048XGDrMoZ5y0prBJh0mKuxkGgGUs6u+Y2uPYetPBxy3FRoWwYUP0B8OqLeuWXDJhlzlrSDlEgpoGJOS4OLGY6l8DIHrzNu2kFie7Vy9lKYLXdrkZGCDNL9O4GO2VtHxBDli2KPjlgG56xQy2DhcvYiMo20i44VhPBJpkTyukUOL37I
X-Forefront-PRVS: 0858FF8026
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3512;23:ZB3hLSTt+yQrDYb83gpHTFveJB+M1AhwCaWJrA1?=
 =?us-ascii?Q?uyrBvDuiWUNmKF5kmwnZQlw+2vAr8UBtVGSlF0vH85Jqv/T+BIHUiCiBFv4n?=
 =?us-ascii?Q?dE7UDcFW/DO+6Qf3hxuIxyphXtS2ktf3OkJ+EDE40+omwDoL4cXnrLHIdj1L?=
 =?us-ascii?Q?zaTznNE37+j2uXKIz3uLNKTioKsG49XlKNm0H1aFB3yxcpA+Xe8A5yODguGo?=
 =?us-ascii?Q?9ZeNFlmD+l2BdbdwK6ImVJDP5O4GHecb+PX4HmY6RMrH7V16PxK5B6SQhwS8?=
 =?us-ascii?Q?hiCUJbC4RW8rGCWcBuqDy62crm48SVipTHgUDsk9bkU4FpXgWJGSrQerB0JG?=
 =?us-ascii?Q?jkhLViilU91g39vpNJ2kl2PowTP68NxZkYiTaDXbmzwdb/Id9n4HUT25KqKR?=
 =?us-ascii?Q?qZyKp3IBp4v34C9JG3RCHlcWetiH/u7F8xGMnUcyOMScjamtBTuRbvK5y5Gu?=
 =?us-ascii?Q?JCHF9OkzxIp29aVOp8SzCdgXsO1Yb4raGrTdWOGMz9/Lh+i62QCgSeMQ7AYI?=
 =?us-ascii?Q?3ucc8S4o4HK72OT3jTarQ3rgUS1P8aB6hdYATyW7HQV/g9Xvng5wXsnkPz78?=
 =?us-ascii?Q?B8u+R0sDdbj5jwnZA1o2ejDOFbf3WZq4gBfDkbyHbt65F3VO1LHSPAE0sSrI?=
 =?us-ascii?Q?wwZ/dGTJ89jbfiXXxPlAtTrmsGfXBX8F6jTQiJzXyU1h7KxeXYsoWPBvj8VI?=
 =?us-ascii?Q?q8ozYTRfe76G3zhDTCcHBN7l5eWTVZLe9NlQQerjQ+xaWU3he9UhYO6GTUdb?=
 =?us-ascii?Q?lv/igxx3xWyB5WNXH/CL/efXSYUF9tBjjg6hIWVHGKGREADLyd2o7veOVWKh?=
 =?us-ascii?Q?/dDUOSXZwywMIpGpUGOYFMnDO5T6SrtsncAGMdL8242WdE4M7lL7vXB78LxW?=
 =?us-ascii?Q?6Pr6s7AE9ftKHFhQTGTA7QeY4rZH0oBjdSbYFgA5n18k+Nt38Vn5mBJ56IDZ?=
 =?us-ascii?Q?XkHVMEn2XCzJLhLenr4kKnJp9UWpwJ3akmuflDJHeamVSjvBVG7uSlKfgZ2h?=
 =?us-ascii?Q?6cITNi7UZXx98Qyq+MjUj+NRXqy3Ti0INuZ3nUQlqXhpeKxJDuHXiNfTov3Z?=
 =?us-ascii?Q?fxiotP/TMWfsVCTVcu9DRLVBkpMWYo8ceknHztdwHhvmPtDD777G6JM6xwGu?=
 =?us-ascii?Q?z+dDWrtDKXpFUJ2YScabpbmDkunj1IQddldBGu35Uq9t00w55KKr4gw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: FFhZVyIsVzUKojbFURKDGqWiolXLvPiob6tNYEbLXKFSJMIrefCLJMRxbSw8BBvkZcSB0GR/OmnXuHaW23ah72RmGggN9qx94rnoch3NUcdgmm5ea1zwJ3Eg17ug87a8uxCkiYm+4nxw3P8n6EluXMz610jrd++2p11ewnfiZCyiQ8ubcoqHoig1Dvdnqh4PpJ34w4uKvAq10aOL3hs9Xb329Auc+/NsVymJrX6LGRUpOeCDksiIale9sWX900H33mz2gjUUM0a7xO4HtDWRr6pWN4/ayiGOiAqkSHM8s67GZQyX6LdaLTc1iF3V+JwsBsHjISAfb+j/I/D8Ks1pMukwsQ4BOeG1J0sI9aNlVTA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;6:zyk9jerCYO1Z+TE8FfbwXzyp2nkM7BsWy2cl8qgzGtU5vWdhyavZ04+90cqk4yEKbxZom4eLpRwOhw1RPOM91hlj52jPYiRw30w/fSvGvU/vb20WOHSPYJRt9DRktMIHO94LLoP9WgVI6AOkEuMmmuti/zlmIrR1DtayAzHyB5HgC9BJhQvOTQGDoMHouBGmnCQbsMwDv5VNFQPPCtt1D/0r3XWvlmWt6L8gFOHLdUnjIqg5zyi3y0phOqD/lm0zkq2brNQgJYwIU6cAor4zplX2q5/07OpMU9KPShezR/80FF4PT3PH3vOj8vk+tvHUQAPGyJCDl3oPnzBOUsmhqs+PJc7qAAxhp/nGemha2qh1RhI/XENcv1dJ/pLCD7p2rekX1NHiuTP3fBnUuIb+OCZtFuO9x5xe+kVVdMegnui1OKN8miKcHss+lQg5CWu9plFkuLiQlHKXsDMxtMHPMQ==;5:WD9P7mXJHwVK5b3d66IuL/yd+/bqNQ2j5huGwhyq9ogE6PDqlhaJoBHiINkgJ1hxK6T/ySirIG/5Z5SZS83mEL8N7gt+JiJJ0ty1cVpiYxD7nzllcOMEJKOU4AA60fI3LVjCadjLuxsxoPGSBSyRfdOSs9aF1AlAmmG03LxvhiE=;7:iAG+cagkApYaIIvfl4WxoQW1p7fY53TrujxRJ3ipUKrgAlAeWq8yMAfzhBzs+IUFK1DuumUvDSjAljStD8aWCpUCwhXoJZHdqKLupXPSz4xFeF7MePRseZpCjGe3LM2It1gWJrrE8fOIrDraa9hPGQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2018 23:57:14.4227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdda57a0-28cf-4c7f-b75e-08d64c1f3b9a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 0000000..090ba08
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,44 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
+	};
+};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
+
-- 
2.7.4

