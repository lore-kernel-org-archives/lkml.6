Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF17C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138520673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4zHyAIa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8138520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeG0JCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:02:20 -0400
Received: from mail-eopbgr710050.outbound.protection.outlook.com ([40.107.71.50]:22211
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeG0JCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY9UrT2Fp3dv7w+fBxc5fmulwn4Ir+ZNGcAOX+yafK0=;
 b=4zHyAIa3+lTHJWeK5igc3V//1K5Kze/PyEB1/4CDN1+noQC+YlTFuxVyvz4maaXkkKq4KlXJL4w8xnnvTN74bp10Tq+6KyQC3mRoVv+A+ZPmOUh2Xx7ug/ORvOCYCW4QltsXkEPtOJp+QT/Nyjbqw4lzdVjTzXSlBSHc7C3iHCU=
Received: from MWHPR02CA0056.namprd02.prod.outlook.com (2603:10b6:301:60::45)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 27 Jul
 2018 07:41:41 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR02CA0056.outlook.office365.com
 (2603:10b6:301:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.17 via Frontend
 Transport; Fri, 27 Jul 2018 07:41:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 07:41:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56948 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fixNZ-0002MV-EL; Fri, 27 Jul 2018 00:41:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fixNU-0004qn-BA; Fri, 27 Jul 2018 00:41:32 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6R7fMuU029905;
        Fri, 27 Jul 2018 00:41:23 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fixNK-0004pb-IT; Fri, 27 Jul 2018 00:41:22 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id B58CF60504; Fri, 27 Jul 2018 13:11:21 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4] usb: dwc3: core: Enable AutoRetry feature in the controller
Date:   Fri, 27 Jul 2018 13:11:20 +0530
Message-ID: <1532677280-30945-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(189003)(199004)(186003)(90966002)(6266002)(26005)(478600001)(107886003)(426003)(110136005)(336012)(16586007)(42186006)(106002)(51416003)(551934003)(54906003)(316002)(50466002)(47776003)(103686004)(48376002)(36386004)(5660300001)(39060400002)(4326008)(50226002)(575784001)(52956003)(36756003)(8936002)(81166006)(81156014)(305945005)(2906002)(2616005)(126002)(476003)(106466001)(486006)(63266004)(8676002)(356003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT009;1:9voUS+Pb38xu8OaGCutl8QGM+uEEnwtCfa+bSoSxjcjI2/2BsaJ4gfK6xhIVBL6fsOfRTbpBVAF9WUdpIpX47z4NTJ0OGdu9zlacO7zmE1Ro4NMPO0snCnmGHYsqG1v+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f12c97c-02a2-46ee-89dd-08d5f39463e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:ObTxHNk02Lp2lpo1LT1ydZ/RNzLOHabVgRwuKT+pq22bwS2IkPnrR1FpV/oKjMNxmVy1DMkpsmjfmkjvKc2tbU1+siacMRHmo0YLtVR+2WYhsxrzcI3raj+RiEmbQ0ALF/lfsqL60+0NIAXACY8GA8UvCvOEOE7h9fuIkNdHyRkiZGymUWf1jDOA88C/dXlJVlxbmv1qlZjO5DR2eWgIm+zjBNWtc2WlsQgEdWW3VGulAF2kT1BIj4WVY8JzamO4eXXF8BZ+XInT8elgf/VGeEsR2KhoCaGs7XkWYruYP1ydhjkXUd4bcvJnmOj/KPH06oc9Uku0IStK+BjGZ1OMAXwZ1nYfhC8MRrssAxoCM60=;25:4Asa/bAPVW4mvAtj5Ky/1Yl50AM1wUdM3LQCwfCndFz/nXPiMDzWp2NAFIoN3WRUJ6JsJ6MC+Uei4GvP+COhKQT6Pm375SKAF7FkCk1+Nl6UCKm30ATm8J3bNZpfLlzda0wE6ZW3b+4XTiqNkX/8PSS7TKkJ5G04WXHE1Rl3pw79fGgHuhQYPER29oJSLRQRCac/ka5UmHFF8cUGhISo43kflEZiNl6Sgk9z2Ch5c+6p66KjnMdzgVIYcA+kxAVTvwyvWjUHAbS5mnwdypl6f/GygUm60959RPDQS0l1G8FkyWlyQBIlh/mQC/T+W/Fh1hVJa9pNQMVS3XSh6XOqNw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:F2zIV4Mn9Cse8bnR8EnRNJIyBfxKKvqz92Hze4PLOzAnGF6shJHbAAI+gcM9RQDBYVkXbachhtGXEyujs2zhElyDr/eIjOdxmqGaKzwZt+FtE7j8lCmMWXlyIkJMDUp++B4zKNyufiRxfmMRRtChFzD61KyYWPYkDFSkfhC2TBl+YGuX2pV023iljy/ysYC5AwbLRGAJRfb8V3WgfjmmyQFf82uEi8tLlJVdfgfnpII=;20:WK+3R2+DF4/aXF4NkN1KdBxLYODz3Uspy5agbg7UZTK4AS4CanXCNUMIpjtcJTFroEQ3uXh253WAEPNEyuccEEbkU7JTzEViX1zn9n+y35McbIMr/YVmM9lf96/ayQh8NdA6QgvFeu78Lpj0k5nY5tq29/m/W4qyzfY2opd/GXMwT1Jjt0DmtsMS+YP1EPyozXJf1vNeF3VDnV7zXYKKvaSk1iSkAwaUGmGlREYEH9sv4Rz4ur2CFZqm0kvGzQGc2AEHve2/qXp4wN+uwW7gBIWrpbjQFjZG22nZLV5hg2rd58T1CA/14+W4pAiI9a6Tu1m9IYl69Imy51uWcAu8oRt/iNsHpTpE9Rc2jR8HhcYQhZ2P9Jwqz2Wh2aFvKfnh1iMfzaXeDT1hVDWIdLenuzPlAhiZ5aiHI22emWMwy9W9weAQH62rNIIUBOknVVTpQ79b6tgcLy7CjT4rl/+OX/ENPRzK4vpQAb+uvC9mnsVxZjDcqRPH8YNq5wObYxqa
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB444937BDB581F4F511D33AD9A72A0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:5H5fb0IwhpP32wTFVyEcIjvKT8Lc4oYkF40j8wzzi8gAMeMTB1Snwm0lRzDZsBDLi7F8BJiN8vTYruSzBNyrtMrodDoxLtFP3KUhZukzHynze8zem5F0znc5Fj5nNWgfvd2qeYYvan7umQvIzZt/ocG2/hWA6Vr12fmuoCmAO4WVSfBSS1E19ZVCv0ZNEGFkUfg9eiiNNUR7IrTH0dmgbq4BwRsLmZOpuyExeRFgbFETlFN6IDoJoeqGyrjk0TtKTKmmZ36FsAtdstXxHYTnfV1Ev23peFqv1T1g/eeQMpZo7AXTS780PWtohfNzePpV
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:WdLMl3yBWWPy7fjkcr9O2OoISPxqDR9qaxGoGhF5b?=
 =?us-ascii?Q?Er3uyo5J5wtFfDHxmOoFPLeDTv2wkKC9f6hQPH7DmOebzsD+D3yKPZ5wK+tT?=
 =?us-ascii?Q?BQQUP0IKk61jehpEAeXdrxFrqjUalnQdDH6AiL4bMhftoP9EEJoRDur7tg5T?=
 =?us-ascii?Q?+GatMmO2bTroUZDgo5damruzKwXp3k2tJ4TJAkNACEeW0nt3Fe4WVo/JJC/h?=
 =?us-ascii?Q?Zj8nXzjM1mf4xzaWig1JlJ4b5ZaGEOr6ToOYEhzFU4WTiH0WUGOHT8pV2EVS?=
 =?us-ascii?Q?VI9EPOdeajM+dJNO78byq93hZmqDZrOq/U1feJvpL2lrvYPBhlfsCo/fhUR0?=
 =?us-ascii?Q?+he2fOaH0zrgAvYHZ5IHRkVvBslGeTqgniers0lEe4iDKwBlNfAOUUIveqLi?=
 =?us-ascii?Q?om3hWiRtLvsN3WpoUnD4kFUUvVXEEIKv3uswpgIJkuWVWfE8lWsB7CZKQkW/?=
 =?us-ascii?Q?MhCYV23nfehlVo0qtoyyVnW4mE+oPmppXaxg81oS5i65Kfe0nHFGwGiWwzpR?=
 =?us-ascii?Q?dQYc/DXjoHE7FVPT+pvyAFx+MB1xGBBjRz09J+ACt4ILjRJQF/GKsbLOE/Th?=
 =?us-ascii?Q?Zf5odJyitC+HxG9cvDlP5LwkNaeArlbJ2Ar/2GUTTiV+0Ze7zODGeYj+wDoS?=
 =?us-ascii?Q?esnTbYFHoQUs77/e0cjhtYqQq4am29QO5ZVgP9wM85jlkw/AxnpCBmTFf/Cn?=
 =?us-ascii?Q?B/fFIEO2EcilfT9cmosxuO+no9Fy0+PZlizWUQj/Bh2fjM1cw3r3Qk/Aqdny?=
 =?us-ascii?Q?EH8d2DGMvcnwJtnyQZwZWib7/mx1ZVroj0t2sGeudKF4z73cYokNjGikcdM1?=
 =?us-ascii?Q?fwH/BNCBrTuk+OzBLyg5SFszlk0YY275TR5fXA7qV+8AdLT5PjRZWBg+JtG+?=
 =?us-ascii?Q?aOIoDLDheiFwb4PuoECmcRo8vUNsZeTU0MbNrL+sy+B9TiNsoWhgkkjQrkXK?=
 =?us-ascii?Q?WmdXgTy+30BVxt05bRf95HIZhq3ZpnvRpKKy7hYw9eUFHCwM1pg/E6pUiWQt?=
 =?us-ascii?Q?dzw7z2qBtyBVzQNgD8LbxhzrrBhzG3ncCLwEUHsMW8WKGJfTEUlM2e/+hAgm?=
 =?us-ascii?Q?2dwE3GHTqZLgtqADV8f8PCKfdk1E2ZAg0CZG0hBUPiCa8F2I5lmRvQSZ1qqu?=
 =?us-ascii?Q?+1yU2gMMe4NBBdgYuUWR8oIWOgG4s+PQ3YGyjlYlfx2IQLrna+DmCDAAY2i3?=
 =?us-ascii?Q?UpljgZ3gTQDnkc=3D?=
X-Microsoft-Antispam-Message-Info: GAM3qLnw3eLYzwZ2hQnCa+iKLxrMvsCaeUqVyqvhplqEaZag2juRJvBkOK6As1sXGCqqZTAKfmEQTHQirEvfJmQm8J7Lc+Xr6fQNiRkZXWnbAiQJrdLsF6Fift0Nez27F6wMqzGmodyj4uTYhjamqbLSUsLj5erQCYLK96+U9MmjCdBquUTWF6P1GXOg5i0W6kOXYTTeP6LN1kN1lIYgCYsAIxexfDXqD4/Ve9vM/oxH1f6JYoYGgQFHZa2kXmnbOBAa0W4liPfXZ+x8PkEbvW7oTplZ98+4e5IK+2gYo1olmaP4McW7xn/Cc8dumVjauO+nZaWz+XWuiqO3JxxW/h7MvPO9AXfMa8UXv1tmyDw=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:yWKwVqmUvUwFaF1U1ie4r29frTZ0+06XbxR3iQigqFUkSW2sIDNLmaj/OJvbtyxVoeJRJyVvZnvr4qkfD5dO+cMBwG8XW7XyGrMaN7eMRUI9LOXL0oZBz4HfKo9Cl09PX+WvXdZ8EwF1f2HpLsuz4jSKV32vka575/ljkEtKBjndRTBbMLRMfQatS0afV+DRTNIIb5Y9a5ogkzEctHR/7xMo4XUONDk02jMbv6ZZZKM57RaXPzco6VOUcDLFlr6WA/fn3kVD9Z2ZGGyuFDujWmbQWCDxN4oQ9JplUwkksEnGeA6UioqqkuJ2aHbi76pt5T9gDhxOP+niztIBor0kGNs9kaf/Qhaiqlv18XzvdGg4we1lPr2vKXGmgwrhFhx1oRRbtCOetVncyuZ/NL8yPO/dJs7Un6ULgjnDD4yZxb4VJiu1ECYkMYnB3omXtcOHkeu+wjh1eHzsUsLTjYvNag==;5:7vDIo1QQIvGqM0lxrU/+dwQSEZPE+E7mTXrPXUdo4mHQbTOJKpqWsotrbc4R1KfXuLSiYwwiN/LZJ3y/E0/8Yq2aAOUS4lfaoUmpnzHfI8MfwS36DdMPn28OIgLH3+DSkLx11mT6KjnD+b3XUw3ML0CNwUFUU+oz48Nal5jPIUo=;7:EEinJ80HkNAtujLvJ1eyVfgGu3F+2Ea/cw408MAAFxW4z6aXWf5yirFY7jumIAHmio8vMRwYfmrc3FCDBGhvXiLzilPPASSWPELfC2fAvzHjfSDvADwb24MdLzD9mouVO43N/LozmJS4UHHKZMKckbj8P59SHUxAsrYoKgcAEPyjKYNqyk1GLasMyM+jaeRKqYYbhx9/EmhLLvlNCwTkb/HoEJ3UxBiZcN4IEf6kxwhKM0CRBDvojVcVy7dupHye
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 07:41:38.0997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f12c97c-02a2-46ee-89dd-08d5f39463e9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default when core sees any transaction error(CRC or overflow)
it replies with terminating retry ACK (Retry=1 and Nump == 0).
Enabling this Auto Retry feature in controller, on seeing any
transaction errors makes the core to send a non-terminating ACK
transaction packet (that is, ACK TP with Retry=1 and Nump != 0).
Doing so will give controller a chance to recover from the error
condition.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v4:
	1. Changed the patch subject

 Changes in v3:
	1. As suggested by Felipe, added OTG related check
	2. Corrected the multi-line commenting format

 Changes in v2:
	1. As suggested by Rob Herring & Felipe Balbi removed the
	   quirk logic and setting the AutoRetry bits unconditionally
	   for hostmode
---
 drivers/usb/dwc3/core.c | 16 ++++++++++++++++
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1038075..bc9e33c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -883,6 +883,22 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		/*
+		 * Enable Auto retry Feature to make the controller operating in
+		 * Host mode on seeing transaction errors(CRC errors or internal
+		 * overrun scenerios) on IN transfers to reply to the device
+		 * with a non-terminating retry ACK (i.e, an ACK transcation
+		 * packet with Retry=1 & Nump != 0)
+		 */
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0e..92a1077 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -227,6 +227,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
+/* Global User Control Register */
+#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
-- 
2.1.1

