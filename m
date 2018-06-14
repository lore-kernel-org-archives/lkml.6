Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 704BBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CD5208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FIEi5s65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CD5208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936116AbeFNS26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:28:58 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:42432
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755427AbeFNS2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIkHm85z1WUVHuKMn8jcaQdPVsvWK1J86FnoIRstJGQ=;
 b=FIEi5s65TYryobnjooB5+8UPrRxga95qVN1ITmks+jKtDoR+pDZlzI/pm6OZlzXhNdUHI21hsBWkMHGJgHWtPw9+Auk81MPLxF1eOTLpowMPq615Rfy+gsWH4c64rlOUzjKBpwzXpSgX9oc8c34yLtMFoAe5ZUguvh+miZ+p8xg=
Received: from BN6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:405:60::45)
 by BL0PR02MB4946.namprd02.prod.outlook.com (2603:10b6:208:53::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR02CA0104.outlook.office365.com
 (2603:10b6:405:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41052 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-0000Aj-Eb; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-BX; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRteo022829;
        Thu, 14 Jun 2018 11:27:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-NE; Thu, 14 Jun 2018 11:27:55 -0700
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
Subject: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Thu, 14 Jun 2018 11:27:35 -0700
Message-ID: <1529000862-11510-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(346002)(396003)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(36386004)(26005)(478600001)(81166006)(81156014)(316002)(6666003)(356003)(50466002)(8936002)(9786002)(77096007)(8676002)(336012)(11346002)(486006)(426003)(47776003)(72206003)(2201001)(476003)(446003)(186003)(126002)(2616005)(44832011)(50226002)(106466001)(63266004)(36756003)(7696005)(106002)(2906002)(7416002)(51416003)(4326008)(110136005)(54906003)(16586007)(5660300001)(305945005)(107886003)(39060400002)(48376002)(76176011)(107986001)(921003)(217873001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4946;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:Hi2uMgG2zioTP9994lCRFfHm0fQ62V6HEnT7X3GaFpHbIkxqHvfSPRlOziwS4nh31W8qG4odmDhiZggxjsZvyTbgoIwF0GopdC0NkMV2lxJCzCV4NW7gVY4im7IG5lpN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf33eb82-4acc-4758-09d3-08d5d2249616
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4946;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;3:ZAqJYIKhs/kNN49ODV9BxSNdLx9jNVEi1a3+FyCRDtCGd/E6r7T3nY0bOXXEHnUF5SEt9OWAu19CMpYpt7QrFEju57toZJcFRDoJlcnRRqRg2vIDgGY8UBUCT0hC2zV6li+lOt1nJJRWmILxoDia2HOPL+cb7m/mbEtt3bkHgyxrZMry1LdWK93VnSc9SBL3m4170KRM958mVBR5QEbtoBsAPmaBx8BS8tMErCS3FEepmUZM/+XKs2jGAWWpfwCkidfejyYRO52l5rbNqF2wO8mqu8bCD2CIkgyy8fIXhykqL0HLvUUBgm+HGUyhpUbYO20pL+e+PUH6oDhuVd3UEsoxIvB11nXIQCaAy0QN6WY=;25:8nO5Mpgr2smS+erlIvomMpvhoioGYRe9qw+PejoQvI8L9rsupTWTTtrjmYIpkL00eTZwO6NU+qlgfm0cFAKYkSU3SFlCCetfpgJ4yF0kIzk/0WHeODnv+gnLZ8ihAKdUNTMxGkWA+fGmhQnajq0k6Kly83bsBdKkeIa8LXkUyXLvJrrXcKBiDeZ9a0f3xrQAvQIsbTHxpjtsGQGmb3oflemcnFlsWkMIKAnhqzoPKVV+mtfxYk9eCHwolh1AKJOHgLF64YCBr7EhAUuU/DZh1g759+UfJQZnR5zF3QfwD3uYtZMJ1Dglo1Im8cU+YQKQS95anaIs3tPkRiVZz/VWgw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4946:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;31:PpKBDEvteomqTG0ws3g/7al/86A+rtEMtA32a1Nxad14v3N23kIhKip9YyquudVIGYDOwBI/DVbi4XmM9kGMZ8NMnqKsPW0MuBmVvDzJVdvIWmHb170KMRHxGRwi9efqs2u76s1ctoMnG8HA8xwtaf439QKmS4pVRf++ZeSucQ/21FVtWG6UVHVtfZXXA57gCvyk19IroRvDdSteyqdsYkwuXGSjeSkKNWbDgGpcrH4=;20:PjIlDj27IOyWT4wlcypWfmRTwmlKe2CZdS+7mKcghilx2z7CMjdQGbdW2Mva39t6ITVI/CQZ5nwgI1qAXvMvpqNIoW5EnDpCW6WX6CDPa1lwH4VBi7L9QfcVnFx1HV5M1lT/82h1dE/AYgCu4l588NDtHOL02U//FmxA4aLgR40dtMlf1X1k0yy36QKjeJmQjMU5gNcTbAz6qBTWj49GfrL06KaSvoBZWfSGMa0PqktGHENXqnfiO5edZAQR6yW4Sw6QCXzhaircRIKQ7Sv2YppQA7eESlPxr736bootKFE5fU4rjpL2hVIOr+ra/Jexwn4S+vRgvdxZmBVrJfF3rYoxyjDIEmWK+R/3ihuQs0uiJEOg/KBqQiypexiJsb9DS1WfREnQFCHASTnrl3XOlGPwhTr7JIvdJkM8bsFG17GnftKbyGVLMq4/ejKyG52YkGbTW3hb54xpcb0Wz000KpuXRrJV2fdKOi+Z+7KnOZewuaF6ZWPdGgH83hQBXD+F
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4946F92BB680E06574EDBBA0B87D0@BL0PR02MB4946.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4946;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4946;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;4:NZGI8QLZiIZ5RLu18J0aAgBxzqjKBGaguYOLFnnJXlesGK7ev03o6TQzFuTuv8EPlxiSvcPcqcgCsADxjKk/MePaD57SXfbl7Ye9wwpojesQbYYI4U5Vgnmpl8+74d+kA7d77oOL7i1ovoDx5Cf5pDsKBQqwMFyCdUHZKGAzrmHMp6gw9fSBlcgdarsUEmYFVGk5SnrgCCrz4Jxt37D99V2T4FTB7xeQ0WRofouVA6MWVm+NP/ED9eg5mxEqSo3o11mYhpBkyWj5i5/NcMTR2lGBSef/UmK8TSOg+3jFjBQA8qwV1amhdjtzhlCh+008
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4946;23:0c5DFzRZhxnJC5fD12zFAAxZKJB21tdrx1+TE9SJ9?=
 =?us-ascii?Q?IMZo30X5euMsU+F7tyQ8rDI+IhF1bxp7S3tQA7tObSLn58lbeNiyo029Cy5y?=
 =?us-ascii?Q?oXxyEdMewH77DRaX5mPYM058D6hVzgvlqJkQxxGR3oA0TzsldunejkiziW3v?=
 =?us-ascii?Q?ZpZp2HJ9IDqS6H8sNGNmkABQT7nbieTRymU8rnmQ48uFtVFPlrnlErthiRt7?=
 =?us-ascii?Q?q1H0P5fp2llOeuJDiVOzSl89N6RInLG+cr3pWU9eY5d6X5KMlqViWxWACbmp?=
 =?us-ascii?Q?LUkrGoEmDHK5eTey9hDWZkRFSfPhoBjGmoGYLJTLcirJ7kjvLKE8lZ8XK98X?=
 =?us-ascii?Q?NVHdeT7Q+oeBeAvVQeKmx43uoP814KOhGrVHKbpR0NJrMIOerjoOA5avqqAI?=
 =?us-ascii?Q?a9jMajiu/mzYvB1/BY9pVtWUqnudrqvQAq5E7fOwq/zKEKB59otW8lQk+n23?=
 =?us-ascii?Q?cHnFRQG1elisasJw46LnG/fMeDupj6kBPA7+vjeEiD5AuP2aTWTSf0M4yjnv?=
 =?us-ascii?Q?dz8AzWkvCDbrw3gk4twY9EiqH+acWire/zCqeUFLtRgkiakm5dWU0bOtjI+l?=
 =?us-ascii?Q?uWORcGmFig0JLjDjvaj9yU0T6Zvx1SsVI0BXhQKDyOTciPbNVNmOOLDXsyeQ?=
 =?us-ascii?Q?nMXkNwXQjswwXGgHuKDdiLVCjqRu6x6hudMBqp9qNhKbtOhCpqiQ2lUWCuQX?=
 =?us-ascii?Q?ShWxwBeIf0EaNqXPqVK+4QYs4xe7CmD5ul0Fl5LpZdc9xOqGfaZN1NSnXh1F?=
 =?us-ascii?Q?k16mQJdAD2Fz9ConJkvkyG6U3KwWEi9UOrtRKo0wlzOKmg25B47q0IMSgkLR?=
 =?us-ascii?Q?gQzej8TkFU56bxJVytRPgk07XrSRQUShBr+BXQDNH4YJdgN8YHjnA/TPN7mw?=
 =?us-ascii?Q?FVIgAI/lkCRxqk75Y4X36M467/Qf0uVRg7LNzvuL0IfJFj/ENGmKHNSKGS1u?=
 =?us-ascii?Q?TcPq9KFVsvJo2p09M6HC4SjwPgBe+cBbnAJETuz7v3MF0GQ8t2rb7j/oMNvG?=
 =?us-ascii?Q?5sIqT8twMjKi4oG7rCuaY0FupQV2ColUIugeoYWvPjVv5ObFA3nE01f6iEXR?=
 =?us-ascii?Q?AHk/Wl8YwOwhbdSw2AyUiwt9ZJhAhqLQ5Oc+GuD3JBDf81zQ1HAKqA5YVEgK?=
 =?us-ascii?Q?hGo5k49QgHq0HJ3TKSZmMqltk4AsIux8i8qvjuzjdkKHShqtQxrmfmMsDSQy?=
 =?us-ascii?Q?bPei/Kwrj9KZ4rDA7GRl8MAcVLwXQeigeH5rxZsEWRycPbPGdKMx5VI+MHc0?=
 =?us-ascii?Q?3vMzwPUkISEPKEGEffdMMbOX6xw21Hm34e9fKqBr/519NKboHDh7RAFvO2/k?=
 =?us-ascii?Q?TUT62/uI4USxLqa7tI6l/9zwy5dEq6m+tYtfeWmUZYC?=
X-Microsoft-Antispam-Message-Info: uoTJ94Jp6PxE0YHt5s8NMtteokoGFB8LpSXvjAjDL1Y3pqoZV2uTB64KqMFQucnm6exAGdU4URoCMFew2xXqVxc+rr4ErgzNpxokcg3jWSKioXM7nHtTLuJF3I1vEcsClSvIM3AszsGacopYFUBJYNEw3NcDoZbU8PaxU/xE6md0ewrzafIjS1D6lbF5fTxK
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;6:aCxCq2G5gCG4sscjntz/t5g9gWk3PrGvuBaSEl8E8w4Lht5PCuA+sw4ykJA1dAd0uHFLIkmDPijwIi66/Vk8i7VHXL6Rmif8deN83uTlG9ZXap7fbf9wvDI9E51afG2/ptl0pb1aRV8OUkFry3hdiwCnK5Xxhs+/gblCE+k7dysPmZVgtT/zsebcm4P+43grDXBcclc2/qDIDIy+o014TajDeeMaCSCyhOSiOZSXE9e853TgKxhL9Rv1AZj8fAj+4/KLhflduvnUmh/GWkaIcvCAbFO0PxI06BMoVd9feC7bXSTRwZtrPO9k7GOGlQfUoxdd2PvaFcTWip6q4MtCdm6IX5Eh7/52kQb3W+7DHxu52lXBsACtpJroudlx9XxZa0wPiCq9YTJDotnBzpTZQLfH6x6KLMgMQc0CoJ49MmmJHzLA/u0khRSv8efQJdYyteYlJ7b7hH8TNAoPCqCDYA==;5:NwrxQeQ/hkW21KauQxEplHDZNwKBb35J3fPm14LPxg+FOe5L/gWKAWvZEvqjr/evEJ+QhvkZl848gEFbw439A9tcfVkq0f0yPMlCYCwCpimrW5RMi30ukvfTgxwhWUaPuF959C6UWgrjVqEwL5JAQhabfcDH2a3SyBlW2N9dR2w=;24:0fdGAoKWJJaShJ7JWWGpifBEaxz12R4n2INYFHrnyt0QGJ9mBvxOeBVAtaVLZgaBd1FO2XG/vJp3+sZZ9KKaKJztQgMd+Kwo+KRXYQGiip0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;7:B1aP2UgnLICu/tz09Xw1rmsfYhWHRTddLbOKBvWABLfyd8EFR9HIug5nEMwL0rD7T/zd9DGQ9oHNswdoLK/ZDr2s12qc8IxR3YfLzzKUGKYsIP9cMEGpjW08CKzzp/aWII2oc/1uzFjfsg1HKpTw2kSjX9SH+qLOW+37HWDjsxUtLeAQv2oZMA99npbtxtkY/kizC7XzSms8h82g3sPDlbtyN2nBVF5VrA/ZbU9hp8QEMs/kZ9uKUnCQyAdjFQur
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.1631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf33eb82-4acc-4758-09d3-08d5d2249616
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 70e335a..34c5ad5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -241,8 +241,28 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..2eec6e7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_IOCTL = 34,
 };
 
 /* PMU-FW return status codes */
@@ -49,6 +50,7 @@ enum pm_ret_status {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

