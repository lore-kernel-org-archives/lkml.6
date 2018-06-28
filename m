Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B5C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832327303
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MmbhAFuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C832327303
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966021AbeF1NMI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:12:08 -0400
Received: from mail-eopbgr720066.outbound.protection.outlook.com ([40.107.72.66]:46544
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964921AbeF1NMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCDvwAOqrb7TGOifQTqqRWg4bpWH9AP3SzMg8Tlljzc=;
 b=MmbhAFuBhJkW+c8YaHMB2pL3pHvEOuDcD7BuyhTV8YLtZBneo9yef3BYmQmt316dYkJuiIvdYtmHE5F7LPouXPxHCl1rWCpr9Htgj7PuTB3o9m3JN0pmNRULLdechRwjCdUCg9AVlaYpFUUsk3qwzyUK4Dc+aNrXvqabnZf9wHQ=
Received: from SN4PR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:803:2b::13) by MWHPR02MB2653.namprd02.prod.outlook.com
 (2603:10b6:300:44::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Thu, 28 Jun
 2018 13:12:04 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0003.outlook.office365.com
 (2603:10b6:803:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.21 via Frontend
 Transport; Thu, 28 Jun 2018 13:12:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 13:12:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiQ-0006cO-Kv; Thu, 28 Jun 2018 06:12:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiL-0001yd-I1; Thu, 28 Jun 2018 06:11:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5SDBtKu027111;
        Thu, 28 Jun 2018 06:11:55 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYWiJ-0001yC-1o; Thu, 28 Jun 2018 06:11:55 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 3C275B20956; Thu, 28 Jun 2018 18:41:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net-next 5/5] net: emaclite: Remove unnecessary spaces
Date:   Thu, 28 Jun 2018 18:41:50 +0530
Message-ID: <1530191510-10310-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(438002)(199004)(189003)(486006)(48376002)(76176011)(2201001)(50466002)(51416003)(52956003)(90966002)(36756003)(16586007)(14444005)(316002)(42186006)(426003)(81156014)(336012)(476003)(126002)(2616005)(54906003)(106002)(47776003)(11346002)(106466001)(26005)(186003)(81166006)(8936002)(8676002)(5660300001)(6266002)(446003)(356003)(110136005)(305945005)(478600001)(50226002)(63266004)(4326008)(36386004)(2906002)(103686004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2653;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT060;1:VCZ8tj2oCsMTMa7KNfRXzuNDW1TyqBZOzkdQ0O3n8s3PeiGlt6OXXiNMXdrOniYfLPBAezgXTHzSLTvUj1M7byPq5OZgHcbt7HntJOQjwZXi2p8IQSuhsxQSvQr183O+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db40c707-5c87-4fae-4178-08d5dcf8bdbe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2653;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;3:16IZJyadUUcVj3r6vyas6zbLOIxQ3jxuxCznRer1GYHD0Ay+RWFSb3WzOorq6TCCuBwsZSFdws5JPlhXHraZ97FgyhtIzdborZlt70ZXOEKLWQnaS0WC6qmAWFs0SastcsF4BfSWp0M7M7CPnAr+2CoFbDyCrKRLTPV/SnAHWzdx7Qv7NazKJojNx/fYsEZNTZYqSCtYNOTjMZMmMS8lek9gxlisygRySgMMJtXWCok1iGLa/MCDX9X1AjQevTzfbTw/ubkZf7sfp3SVyQUqjf7q3kWThzQg7RwFqeZ7SYkeyhZd6ffmcUYpf7YZ9DwlE8XHqX8Y2P+ZY6W0AcSfrURn0WZ1TjRaluFkHg5HkF8=;25:mhoAwgJLGTjPpG2kRT7B7XmQDT85caISrCR+Ly0naTle+AkY/5FloChHLynq4eZneFmjEEgk7cYsDS0w2KQS+Ovc1gNmkJdzU5W0aY6Z9p08KeVwA9JtLBUTb22IxP3eyFfxDffn4JRyFBaz+gnxdA2gUkn2WGFUOxD9L+Q6pFMiRoMKJ9UIfQ/LewVRP469RU3EUyc4DoQOZtqRjr+n488bHCREE4V534EpYN98b84NrcLs2M0L2eq7nM9IrqZDj6b1XcTYY7AeEhtmlGeDOhlTt34WMA5IzplSggBBhUB9zSksoAwGQaARGGP5bM3SBv44jBR2TJLOwJ7b+LHIuQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2653:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;31:oIrMAKzgJHu1YbuKtgbdm+iX73gSDNH6e6JCmW+5wSa8wcHfSEDvnbgnJk7lhKtLNfiS9O7m4LW/dnhLNsturPqNPXJ+SMkTIIKP04gxtrOu2Jp7966BggpsjY7Nft8U1Km0i3kCx0B0rlo0DyA4GIpobtTfeGyg6gHyIGWh+QfkO/BUxr/Kmu/E4rzm3eTxhMVK+s5PBmZ1603J616sxcjsqqy4yFO5kqowJTbGdPI=;20:o9juoHFu0AxcMz/K3kvT70JmdQHCOYkKaPR8i9ITJ3uZxKC/0vIU+qoTA3yJc73nxN1DDYW+eMYRwiNnimTNU9zJ/n3jiEExwxqqkjhTmEDnyQV2sNH+PG3dBO+7X0O0j86HwohnvCO9ddSUppc+jJoduMPBUUrs/RjcdGVbS3zKg1EJ6dlYvG2Xx79TKuRqM+nVti4V+WXg7ktJoBwm/TJn8l5/nGJD29hZyCtxm6v62Ixsh3iLKdNBW89WDL5q2E+XmQ05ix8NvEXjWNeLImfhSAFO5RE1iA7jpBVhUj1nm2+YJi5N2sTCq3N5Ge+gm/HobYcSDPiDPZD3Qz2SuI8ZJYQ+UbockD/sOtNRnbMkVrbxImXjRU94GjiZ0puZ6JlVPnkrXuoEgldUOXml3DezfxTjAYGWAmNDpJgg/uE+J76ygjbl2qZUAjjIgi3gKx8vK8cdYwkFCZpWqJ5dMe2asinWVZNOGfo0wgn8tqFSVrW5iT/d+jqRD28ng0OV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2653EF31749DD89E8286862FC74F0@MWHPR02MB2653.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2653;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2653;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;4:Dl60OICu3pOud9I70Vgj9Gru6fbDXVowntlRygFBrbrE5MQh3DnM8O0u83VshFYEfKxNZK42BafUUZ+eunQaIFd5A2U+XgphgZC6/n1PtMsGp8J+rP7pH27cDfce/+6PQ5byloFOa4wJpukmEbjCPaFXe/KUiyTYls9FesofTKlfPdO52v9k7q4yZOq83n72Fo2fNkxIwpdBwMDzS8g3bAxPt+GOMCO6jUNl20kd5LHLdBfPJUR3xVBp4Ni3uAHIwEvexXeQeOpx33NgBp5HsnrOXYB/T+jm+kMYh2k1fiAhNYfbjqCMkfQqTpX5Zcmm
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2653;23:qxp0NB3Q/NOYb9vMDs0/y8lfIT3N384OIa5fFUcPI?=
 =?us-ascii?Q?BuezXxeUoV30nLjNBsVuPHh3xIS9BMr4xN0jMbcO4kQel6mhxRbfbk5oBD4u?=
 =?us-ascii?Q?CarA6+ibShrBld3XH3YRRf7mluX/kD/qUX42yeJgS0uw9qbkbh9nyjxsu8vj?=
 =?us-ascii?Q?Sqx4sFJxZJeNltaOVzfiDzJncNFpUAbyuilSp7dMhoc3B0U48rHI2v/T8YZi?=
 =?us-ascii?Q?NXyR78c9qgKKi1B8WLvJoMmgN0j83RMt4Y9uhLX0XQBm6segOzx7hfgILcer?=
 =?us-ascii?Q?EXECp2BMlcANdcgznXCE/QaRDSRY1qnN/JrAI5nXiewuUUOYxF+CCcR9EXfD?=
 =?us-ascii?Q?magDo+kLjX5AsWso+hsOd3WaNFiUZobqfjZUvYat4MnLloMzZhzn/jepcXuC?=
 =?us-ascii?Q?DYFVY/ExaxLlz2M++L+VHe8LYOPzB/ccKT57hyd3IKLf5zCkcl86gKbuRFcQ?=
 =?us-ascii?Q?4TlwgISPZ2vM7b8lBab5KIy7nVfejOfUqOEVKH9C80L+WsaKLPaZRNsxedQx?=
 =?us-ascii?Q?CSZBA8d4gdnRlIr0wB6tdcv0rfNVXuER8qw6LpVFHB0+REbTRikoCYPxLLPV?=
 =?us-ascii?Q?f0AX0/08Uk6FrUahbtsFUU4SdO8tMcg6QvytLUDPp610ppHfPtKEO8WiKBAm?=
 =?us-ascii?Q?7eHr39MyRXXu88Af6t1ORbTu3grf4swxmTDgG1wGlayUPnvpwrFv0Ek0NBBU?=
 =?us-ascii?Q?w1PNgyllu1wR0WRPVNbgou16ftsPgsYnM4Ii2puMCv8gIXT65ApD7wYqLsdb?=
 =?us-ascii?Q?1b9bBQhw165zyNq3DNWgm5lW7Y+yFTh7PzCuJaCeLkYhG+JVa+xk9LnEvrN3?=
 =?us-ascii?Q?thXdqX93+ibmOWggPq3OYOOrVjTjxCuPqiZY+WNK544Q2QVOYAHPCLNHJCZ9?=
 =?us-ascii?Q?CAoRZtqzKzVVMQa3Njh7wzmGbhk3vWDiMTXFZ+FLI/N/d2yoA74eGSIM372W?=
 =?us-ascii?Q?SW26C2WFSrGVqGDSLMG/cEcQZbdK+ralD3Hox7SjwVtVXPuq2NaWU5MOxlfr?=
 =?us-ascii?Q?TlYsbsOrslZPMxjTAUhPj/V1DGTidNh0tOpTAKSR6selQVX4dL0+F+41U8fj?=
 =?us-ascii?Q?3Pt4XaU9VSbtdjodCAgtuDlmRPy3whz9HvbRrXygKqxXQCIr7BHdAgGcK4t/?=
 =?us-ascii?Q?RDO2+S2lQA0f9YmD/wbzLjAg7y12w8a?=
X-Microsoft-Antispam-Message-Info: 5s9ur2gWKvufsLB/9KBo34go+DQE5R0lfFnibWoiTgQ3dhv8GuJO6tgYIwxSg5K2AEs5+NHay/Xi2v0AMdAs5D3/Frd4s7eVGgz/IDYZvsR77ifxQLOGTjIsfj6DAXbGGI5Afr+aw95z6apnkl9i7BGDJfQNY8S4NWm+VCtPL8P7LqmNYpOoM903ItiL4t4HH7Whph723d3oioPwxAjpO/Avatyl9yAiZ19UbsAcLDjBv18CgDof7G1QJt9Fzt39hZLsBnyuok1NVt05SU/wcCa4kGJ0UsaPO4Bv6atzXMNatEg3tbd/B0M6N2Q/T/1xC3UOZEZzZKHuDUgSCEl2KNvUarYt9EI3a+IAapAcz04=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;6:sNzwxuKJ/GGml7BjZvIKNhbvdGJwmu7EBr++dRXOCaq8FdS06h61ECxsACyry7Wshh8wYbiO4ZxkzkaCSYZYOkDvLro+qDKlRK80KnCTY+nnOt8XsyOX3NIHHt4H/yoQE9HL1ODR20pUibY5cNP3m9FrXthzRdX68cvzIgK0rs64g3kGXCLN0phYM+RSbfSQanzooCzvEpFGutMJMr6cpK+h9U97DWtGsYno5wN9vZoN2R/vXhhjpM6Sy3kTaA5mEi7QPhNXUPGZgsgNZkezsJ/PrU1nuhs75Ldz8QpvMPUXHHGCYucOwpvk3GKgjRX0JZzreeophwVPEnNqZzV+jhUrzYcalrsVajPH6RAbvy9VrG6D8MtENezp/NI0M0HIEVfdz1eounY78rsQM8EqySGxExnJHetx0Ty6CcRC80S+lMbB8OgZ8mnma7JRG4ei4v0iEtDZeUpfgK2mNdoAXw==;5:ARIR5SxY8gMwxnvuG7WFpuUcJA6WlYyKQyAZLYVFiaOFCzcJar3ibTEa249WWQgkbUeJlwqodtdQIFKLN7XIx/ZiJWzx+lluorM/ROiESJ7wfXFJSMp+iBMmuhIq77baMG7PyEpAl+zaW+r5619sOxY6vS9eXq6WyOpUiht1WRg=;24:z3YjsbPTUckVta0DuNYSGBsFsOdSdrvPe2EPoMEv4SAZoQlNGRNtjQNX7AKllU6GMG+eQmG6HCjz36SJYH1UmMSrGPwblDgTQMYBwl+Ogmc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;7:rv0lUlPT9LtRmcPGhwfacqoAp3c5QA2I53PbFhSmIdBjKj3tmM2e0Ev7w6LjShoHRtzUeiSDKiR31L7ZHMGR5HAE3z0nF+cev3gV+UaX9ZD0WE+IRZrHpIcCATxjqwKtoEGeaXK9x6LL0nEfcQgoohP4L3S1H3Jd/N/6/TkDGiv1Nsm/g/PN2HO8NDuFriax/c2UippZ7mQGsBBfAOhq53yuKD6WYZnr3i8vD79skjxnT0LKjBALNQVge0ljgzdH
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:12:03.3655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db40c707-5c87-4fae-4178-08d5dcf8bdbe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch checks-

CHECK: spaces preferred around that '*' (ctx:VxV)
CHECK: No space is necessary after a cast

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes from v2:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   27 +++++++++++++------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index f96c920..42f1f51 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -95,11 +95,11 @@
 
 
 
-#define TX_TIMEOUT		(60*HZ)		/* Tx timeout is 60 seconds. */
+#define TX_TIMEOUT		(60 * HZ)	/* Tx timeout is 60 seconds. */
 #define ALIGNMENT		4
 
 /* BUFFER_ALIGN(adr) calculates the number of bytes to the next alignment. */
-#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32) adr)) % ALIGNMENT)
+#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32)adr)) % ALIGNMENT)
 
 #ifdef __BIG_ENDIAN
 #define xemaclite_readl		ioread32be
@@ -239,8 +239,8 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 
 		/* Set up to output the remaining data */
 		align_buffer = 0;
-		to_u8_ptr = (u8 *) &align_buffer;
-		from_u8_ptr = (u8 *) from_u16_ptr;
+		to_u8_ptr = (u8 *)&align_buffer;
+		from_u8_ptr = (u8 *)from_u16_ptr;
 
 		/* Output the remaining data */
 		for (; length > 0; length--)
@@ -273,7 +273,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 	u32 align_buffer;
 
 	from_u32_ptr = src_ptr;
-	to_u16_ptr = (u16 *) dest_ptr;
+	to_u16_ptr = (u16 *)dest_ptr;
 
 	for (; length > 3; length -= 4) {
 		/* Copy each word into the temporary buffer */
@@ -289,9 +289,9 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 		u8 *to_u8_ptr, *from_u8_ptr;
 
 		/* Set up to read the remaining data */
-		to_u8_ptr = (u8 *) to_u16_ptr;
+		to_u8_ptr = (u8 *)to_u16_ptr;
 		align_buffer = *from_u32_ptr++;
-		from_u8_ptr = (u8 *) &align_buffer;
+		from_u8_ptr = (u8 *)&align_buffer;
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
@@ -351,7 +351,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 		return -1; /* Buffer was full, return failure */
 
 	/* Write the frame to the buffer */
-	xemaclite_aligned_write(data, (u32 __force *) addr, byte_count);
+	xemaclite_aligned_write(data, (u32 __force *)addr, byte_count);
 
 	xemaclite_writel((byte_count & XEL_TPLR_LENGTH_MASK),
 			 addr + XEL_TPLR_OFFSET);
@@ -448,7 +448,7 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		length = maxlen;
 
 	/* Read from the EmacLite device */
-	xemaclite_aligned_read((u32 __force *) (addr + XEL_RXBUFF_OFFSET),
+	xemaclite_aligned_read((u32 __force *)(addr + XEL_RXBUFF_OFFSET),
 				data, length);
 
 	/* Acknowledge the frame */
@@ -479,7 +479,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 	/* Determine the expected Tx buffer address */
 	addr = drvdata->base_addr + drvdata->next_tx_buf_to_use;
 
-	xemaclite_aligned_write(address_ptr, (u32 __force *) addr, ETH_ALEN);
+	xemaclite_aligned_write(address_ptr, (u32 __force *)addr, ETH_ALEN);
 
 	xemaclite_writel(ETH_ALEN, addr + XEL_TPLR_OFFSET);
 
@@ -572,10 +572,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	struct net_local *lp = netdev_priv(dev);
 
 	dev->stats.tx_packets++;
+
 	if (!lp->deferred_skb)
 		return;
 
-	if (xemaclite_send_data(lp, (u8 *) lp->deferred_skb->data,
+	if (xemaclite_send_data(lp, (u8 *)lp->deferred_skb->data,
 				lp->deferred_skb->len))
 		return;
 
@@ -620,7 +621,7 @@ static void xemaclite_rx_handler(struct net_device *dev)
 
 	skb_reserve(skb, 2);
 
-	len = xemaclite_recv_data(lp, (u8 *) skb->data, len);
+	len = xemaclite_recv_data(lp, (u8 *)skb->data, len);
 
 	if (!len) {
 		dev->stats.rx_errors++;
@@ -1033,7 +1034,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	new_skb = orig_skb;
 
 	spin_lock_irqsave(&lp->reset_lock, flags);
-	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
+	if (xemaclite_send_data(lp, (u8 *)new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
 		 * current transmission is complete
-- 
1.7.1

