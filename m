Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F8C2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IzBCmqaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F8C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHPWIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:08:50 -0400
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:24836
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbeHPWIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcvonpnfBYRryDIIWjXG286Otoa9CxGUnScPqsG207k=;
 b=IzBCmqaaDkFBJWDPD8EXkM1pvoBPXZpWQPrJYZWIhhJPFZcUM0hNQ9TMegn01r/y4j25pl5lAlnhBUbu9Rp+m6VxIhzSu632HspRv8TuY7sLZp7RB0JyblTwmmSnYanYkTusqlvlX7Smvhvv02dSm2kyP7NzkYEBCyZwZ1OMnQ8=
Received: from SN6PR02CA0032.namprd02.prod.outlook.com (2603:10b6:805:a2::45)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Thu, 16 Aug
 2018 19:08:28 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by SN6PR02CA0032.outlook.office365.com
 (2603:10b6:805:a2::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 19:08:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:08:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNdC-0005Z9-6S; Thu, 16 Aug 2018 12:08:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNd7-0004An-1q; Thu, 16 Aug 2018 12:08:21 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJ8C3S016980;
        Thu, 16 Aug 2018 12:08:12 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNcy-00049q-Kr; Thu, 16 Aug 2018 12:08:12 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Thu, 16 Aug 2018 12:08:01 -0700
Message-ID: <1534446483-12156-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(7696005)(478600001)(16586007)(316002)(7416002)(54906003)(47776003)(110136005)(44832011)(63266004)(72206003)(51416003)(81156014)(8676002)(8936002)(50226002)(76176011)(106002)(106466001)(305945005)(81166006)(356003)(6666003)(9786002)(107886003)(48376002)(50466002)(336012)(426003)(5660300001)(186003)(2616005)(476003)(14444005)(77096007)(39060400002)(26005)(2906002)(446003)(36386004)(11346002)(2201001)(486006)(4326008)(126002)(36756003)(921003)(107986001)(83996005)(2101003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT050;1:ykUi+beFV7GLApVofeToMSTGLv8SlTRboDTQIupyA2YIDlh5eyHVj5as1h4IKxBkmaM3D3ikuxYjlGJ6pdRlPxbmUNabWWsy7kD27AyAQu7XmV7r2qPJVoanjxFeHcL0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e0f41b-6c9c-4840-598e-08d603aba5b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:pzUqtucl223YwvRQWzyEjLzkDrkdzMCUr8AY48umrE8mCg9fRnqsfCOJr1x+soQuQjm5kTzDVolAhYWg4qKngHlI5DPbOUz/C+93e9/3PrTCZeZn+LVlteNvQIaBkgEEsfMqrGt7zZHflkPqNu8H3RrdJ68nDDl6UeTuMt3jdCkW8lsXFKKIv4+3Jy1+lgVk1dVpuIyP1IayPwRrItxyTAL1+TbVNHAbNHCVjOpkrJUOwDEigeDVRcF9/CmEX1HKKeI6nA7KrkNKV7sY5e0j2oGqWUruTE87Lou/2YIXR0XuCsA/I2fx+dCUQ2caK95+8ITfsHAkzSHvVc6cJGQ6dKbi6A+sMjjKQascr5I/lWI=;25:C7BNJv8849it2/gLlZHrw109HC1ZehrOFW7Ear0Mnrc7LRDCMagI8XiPuE49cUQNUnE3pM0bPnXuQx4Ou9mqX2CLXQ8dq0xujubty6/RoAvbTtQaDiZeHhlGO6A5/B6/l9K4oKNO5VbXGPW6m9UF1g7BGFpXM7BgAILdpmLzKVSYSobkFCfHE43+VkU5TBJbZ4T/EGv0jDX5FZO0QIgudHEh0SdopkxbKKCFlMdfeffJ3LE4SdMftd9M43PDgVsNEtG8cEB4plb+cTVqATjABfF6im3sMDTuwg1mU7NErRPlxrZQFRWyQ2nUFqJyFg7VG4AX3KBvhb/u7en9Sd2zbA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:IVVvhvtQVApraQ72M4ejDpR5JY0LAeB3NF6r+LU7FdCcoEc4OolR3VBXc1J4AFnVvdKvwUqvqNZrPbmXRhgEGBxaSC9fdt69I++vPu4DmFBef/h3gRtYS+P4g5ce5XTOduPJXZxQYgrujC+Qt2+J1qkOQ8fiG4xt01mXwfhUn4O12ID9WYdMSIUOx730fYg67nMX73vESrrJVOIp8LM2kx5L2Lw+zwzE30hCpzDI8BU=;20:Xx7FtABKcbF+/nY2uWKvtF/xvfA1LiZth8L9+Jy4+oaCj5dvOcEyU6Q/vNQKXofCeP1sQx4hdNJfWSfAuyK6i8ZJmMFOm+pozWcOyyLqPvOVbds2/TKaCVVFXsghjUbjyW/nwIxwkDz/zLKlknQULFv+E/Cau5MOx7V2DmbV0CvkSPW/cZXyKEkhHkgxKW8jURSdlbQvnF/dfRowLw79R+ORIpDggERL7XYz8G/6d+NHFi9TyfpD4RdgWItY5gO1w4/wmpv90WoZ3y4RLVq8/gXkixCCgC7aPM5V8jGtbeAvT1ToHW8FMBAtZtt/hyZK/s8mEVrfXgdxAWSkmZC2Y1IBwqZXlybelIkq9OjT0MhLhGAaPCpDZWewrD6CbSkiRUAQxg1epPgpjPtHqeqqK8ADvAwbonKk4gxCxIpFH4obxVwKTOYuiseIVDtH9HDvV60esZh+YqRXWdAES+eX38UbeOa4qZEpOSlTBy9fyh7pN7cSk4QOJTa9TfzrHPQt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44498B6221D9CC003C633961B83E0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:8Rm7CPggkTU60en/FoO2HHKHaNAh4UcI2njEZ0ojndJGw080mEZ6cLRkW4qNgenS+ehbgeD7XfGOs/9ZRUYn8TPFhWaNUQyhejhHJHXNTZHboIX02W+Lg4A0SnKlSzHby+3IMdx3Ba/9FwObqkoHhUTF8VDWm4sq/7YXEV9bhBa62tN3BocYKnWmtH+5aabad2tC2xGjckfVnLCMWW28tQ2Win787BpyuzuccaxzTXNgVzGLjlHmnnchV9T4AByAnUQpUFMJk11NYwa9DLuNwRNWs0xAxJMKf+JO9/u9uvtDc/nGx52vSoCee3O0g9kG
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:Vkj7IZSIlLlu1ODr4G6QMZJfnjl2Jg13rEj5/qrX8?=
 =?us-ascii?Q?TvwJadlhTs1RlWu/VlWDFbMAxbkw6BkwWH5Ou2SlbS9zYIi+mpwsqdMJILnq?=
 =?us-ascii?Q?JDZLzJxO4nL1K9nWyKVECKfqSE0K1MuP2iqeVBxZVc7pmg1bew3yErQn2PfG?=
 =?us-ascii?Q?CTHKx4cweIZ06BDULnELx+bexjBhQOuXUvbs955KDxciSUuN7QLpYCPmqL4o?=
 =?us-ascii?Q?rdziVE2eqkTa8AqKcXk040OSSE81mYtoaGwojMRmXUfYdYtlxICKwe8JA5a1?=
 =?us-ascii?Q?L34CkVzgjzIaJ28yDYB0RT+EUTY3vzyreCRI+xtbN+pEC5w/BBizCCD+6zXW?=
 =?us-ascii?Q?FB7OFIhKDlMDlNMxI4yri96v1BJ09e7Bq4kXZKWC3p4H/1MM4a4/GdNd92qW?=
 =?us-ascii?Q?qPTKFEy+KB4SMgyyhih63NUv2F6Gm+dNniQOiBvrY8uySGfEiQLB7uD9fkem?=
 =?us-ascii?Q?H0cqGRUUTd0cq4ZnHxqYNBtGCdIMDjBoOzyS9Y0u6PWNJ4OVFbgrjZylfKDr?=
 =?us-ascii?Q?20lX2WFFvqyAnilgHNHjeN9zOrEfqTnz3b8W3bubTonWVZ0PTz9NMaQMehWx?=
 =?us-ascii?Q?cYso0hmbZrhDYU9UTl2e54HPBSi5n0/TKFl8+aNdITWqmS8cj33XzK0oRNaR?=
 =?us-ascii?Q?03P9GhClrhuM+qKra3brXDmQheyhUIwr1YFEsWBsbFNeZc4rAy5/f4u/2Uh8?=
 =?us-ascii?Q?JIezgRfbZOVCFaYwgPK9s05F8pGBKtafWRBGvVoab0PM3q17+2eTY3rbqGAp?=
 =?us-ascii?Q?C+1XgUGotjNs5ONrhaFObqOBPxxQ5JtMWtvoyxFiRqTS/cGCb81DWRW479mq?=
 =?us-ascii?Q?f2iFY6qMX/9i4E5/2lT3pcG9jOG5m/rfGOuy5liaaoyzLHq9rwanA6fzCHHO?=
 =?us-ascii?Q?uznv821cqgGZ3rjqeZFLrcLt10PFzuCotUpB9pVfwNjqecZXcmb8rv0LCF4F?=
 =?us-ascii?Q?IFC67ftv0SdGKYHliWHjNaenNRkB3Gcl5hWO4pd6TV/QceSh9RW+cOWrzfyG?=
 =?us-ascii?Q?OraWw4h3fsOXmHdlAYtgeF4m+3q/UffoGSNSqkCb34bM04FtzpOLBBBf78/X?=
 =?us-ascii?Q?ieZIn38lGTiU3tjtq6yFqn/6qb27Ola+xeyNsO6F6OpZ0GK3BtmzcZaPxWkB?=
 =?us-ascii?Q?uxeD37FpuQEOi7B6aYsK8RlBK1KjUbEu52DDlLaS4nghaBgPCr6UQPKb722q?=
 =?us-ascii?Q?9AMIYujcGbZNmDM6KnDipICzSIJPpp9YGDzuvmk3p0g0PO45qtXRTlE1p5MA?=
 =?us-ascii?Q?0kimNysQ8+KAkr3RRJmaEwU10eltxcIHz8Zqe6EeIxN6+g80vwoHrhjakZWB?=
 =?us-ascii?Q?WvjP/Ut3QDMtS9xLpm0oda5IVveAbO76Dyfu55xh7Wy8UwEPS6lEci1OMpn7?=
 =?us-ascii?Q?himcYNyBjJSvG49Kze012WsI2XnvMsBn1MVtOehoWdyn5tg?=
X-Microsoft-Antispam-Message-Info: yOKW7oVeeXV1UFBhvEknQoM6Sv3LFZ1sP8xanBWFqFaETceACohsozdihVGh6m4aUkkpzxJGFcKhf+6joVOEdmjzW1S7Y5XVoPi6Ka1dafgYzs/gKUXCU5nPD9hPedI8zMdiMxw48H+nfXe9dOKoQv0BC2xWWykclBysNJDHoftma7tqCzhTgbg+yeOsZR7jWnZU6VJP6WRD+v8NPbzdyzaPzq9G09YXjo970mFGLUm1/JH79WNmQvMt8nv9tD1ljFKuWja5BEDfFlcCJUlKzNLjuOw7BD3jjqCtMmRZiLgK2C6FQ+bOpcbM9IfTApmJmRaYg6MVBg/cHv0VDnaMX9k3q6gTb/rSFElXo3F1tl0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:vm97/6MhiNpaP65ApVTk+03r7CdM4SJwhVSd4/aWIxf2seLMtJ+eRB56Bdo83HGhEbvsrvF1mxP1Yf5u1E4nwHk5lccUsmQiBVK4C59myRG9tLkDnKkiwnszFyQkMip2PfdToCrbL/+SuzVBGFTVrKMUSTqAiMKNhd7cfngAdPhIlGwrl62B6USdfG0noRR2vQ9zRUPBW2Ltze0HYFsrh27tNuHAa/xNQggdmblSvnRzuAdmYp1M0rYA4q++SK+WB7PvpswK3yAZ+NOgVzRCQ0F+JuNGFEBcCeVPK5jAjJwLFWxFVOnA/HvQP65Nn9fLF+OfLkgs7itCaJMOewN/IqQMHcZr9F7phqHnlbK4BzV/WtYTsDJ7PaXXw9VJe9f1ARYRxMRnATRt3jpzFT0D8QsX2D24cAbZNnqkq++Z4wThUw84g+0pkgvjIaLV8qUziyr+5THvN6yMu2N+hVPieQ==;5:7vcmFjr4vd8PCruF3K6DPZKMO5lAtJlfTRkgHv3xymi43I/a2vPdN5wCwor5hxPHzbhfd2fN4hm7gxslP1U2HoSv1SEg06UTHPpr/rSh8KcLoNpJlBbLVb+rxwAV3EmRfxheAaSL6KBFiHiZov6Xok9WVGAt9z3YIWGRX8SYuKE=;7:LRN+uMtywMkbOSG1BZjpGikLfp0nOj1xAUztqHPWDVbejk+p/8rv5kegEltNjeRAd5TUOs19oegUVGHnWW+nwg3L1MU+RMu62n/h241uOQnjAqOXM5ZNzlVh5nfdwBrdhwKXJgJQW+IcxbFS/Wz+gRWk9PDxL/yXPf9DCVXa5yYB7neNZrWj6d8nX4OFrKlUIbStY2Zn4hDECFFdmiilE3AQdUaEAtxJiPl9APiydxV2AuH1FPX4NaUOEcJIo48n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:08:26.7357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e0f41b-6c9c-4840-598e-08d603aba5b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index d215d15..cb9a6b7 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -64,6 +64,17 @@ Output clocks are registered based on clock information received
 from firmware. Output clocks indexes are mentioned in
 include/dt-bindings/clock/xlnx,zynqmp-clk.h.
 
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupt-parent:	Interrupt controller the interrupt is routed through
+ - interrupts:		Interrupt specifier
+
 -------
 Example
 -------
@@ -78,5 +89,10 @@ firmware {
 			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
 			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
 		};
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupt-parent = <&gic>;
+			interrupts = <0 35 4>;
+		};
 	};
 };
-- 
2.7.4

