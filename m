Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F169C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E60A20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="orOV7ADZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E60A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJMUxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:53:24 -0400
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:5499
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeJMUwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUia5U3ROtz4lzd//jjoLkJi7nK2C1vC2RyizlVreSQ=;
 b=orOV7ADZgRyCArwhHQK/hmPTvxh0D7YAqb64PshpaXFj4MlS94w8qCuvXQdkjMn6ZzgoFDG//m+QNq2cvirkJ4IsJBDkgb2bN1ltaxENDILKDs3lo+2piYLG102USjoQB6nkrzNpx0/t+M6rZLgH2zbsIv1XXHsXlvYEdW0mcDM=
Received: from SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) by SN4PR0201MB3520.namprd02.prod.outlook.com
 (2603:10b6:803:44::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Sat, 13 Oct
 2018 13:15:20 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN4PR0201CA0044.outlook.office365.com
 (2603:10b6:803:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-00068i-Ic; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-D9; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF6WH019364;
        Sat, 13 Oct 2018 06:15:06 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl3-0007pN-RJ; Sat, 13 Oct 2018 06:15:06 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C5F3660504; Sat, 13 Oct 2018 18:45:04 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 04/10] usb: dwc3: update stream id in depcmd
Date:   Sat, 13 Oct 2018 18:44:51 +0530
Message-ID: <1539436498-24892-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(106466001)(47776003)(52956003)(90966002)(2171002)(6266002)(54906003)(486006)(126002)(110136005)(186003)(356004)(26005)(476003)(14444005)(2616005)(6666004)(15650500001)(76176011)(446003)(51416003)(107886003)(11346002)(103686004)(8676002)(39060400002)(81166006)(2906002)(81156014)(42186006)(63266004)(478600001)(336012)(36756003)(36386004)(316002)(106002)(305945005)(4326008)(7416002)(50226002)(50466002)(16586007)(5660300001)(48376002)(8936002)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3520;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT025;1:GDASXcRUZFjPYbdTd8E6D4tM6CETGDwcdU6i6G/h+gwIC/c/RUBm/7IY0C6gXNPr8Rtdss7KS5pMU33p/k0MMEzOZdpZjAvfRRAcpUIci9oZoeDbz1H9cR4cZsTig3Ac
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1af2d9-3baa-401c-7684-08d6310ded2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;3:rM5SQ46k1LqgNxeo61qKkr6lje3tOxwjYkrFhu5muOQSdYWdwgonlLyxOq6pnwb/ihxCFj/xsYpsbT6AbYd0r/PQanBkv9J5/YiKdmYZe38plTnpr2IEPcCja0S7gmd5FtVH/W8DyeL4pcHk1hqx3b4bZvTP2qJka1bRmeqQo+CS5i3L1lVGzLPoO/QXtbghCUIlXMBEfJJkGnnnx/fErjcXlBbFXofaUaBkc6YDFx3WIQurW4mDmPWFB9hNyNOkT8jhqgwRnychknqxENypXXDy4QD0Pmg1ATJVvWeKUUcyUOkphr922jJwg7tVagtH3HfZNE5uYJibNAR7DyUC3uTqFu932YcERwWsNFBmkBA=;25:thH6bWFX+vSjgXv+BJjPn7kcl4It+qcX9vgSmNuQyItKGdcsf/S4Yh/tql6wTqz6UrNIGEZfcrBK5HbTOHG076lXO5ckj8kjgPogf8Hj9LHdApWqqDchdT5EYKbMGw1sEu+BTARxf072dvq4Rb26VWXS343ujubXUrcRfOCotZzXAdyajpyLZ+a3hgIRAKZGB16I42nBszF9thXLb+9Vfi+RS42fBrGX8nWbmyDK7OMp90dRZG83BT0ff2U0ephh84HNnWv+9jdt9okV7c2J1h1L+GhRIIjiRgVT/+8ABUFO+mptd92COa1BKovZ1Rc744h2suQ2kh8y0NIu5AsqOg==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3520:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;31:Mhg5LmrP2m6AV+vsmXBDQvZA4Cm/6TMkg0ItwV3hkwOGlNYjmO4dKHTMqH4cCsJ1dqGO41mox7Jx2LNUuVYLKFZL6NIemAixVU2EZWbewvkB+HkIDaUrV+kd7Tor3Yy96Uhn1M07AX+iNpORAn9TGIcVg0yyG1NB//oukhxY8HdD00STQRItaVqRANjacWJZ9RGsmZNuxnFHQKWC8xC0GBUh9g1NyYHACjzwSdEupQA=;20:Z9hl45UWG9XEi3BE53mBqhy+wkR0kY5B1Sim4qVJurOK51ElQFt3Lgm4dMFYl47z3vW7A0zOrxpaWNpxtfWx7wkOU/Zj+xG+VufszcqWh7UmC0snjZ1I2y00wzPk6j8HhokZcQQD/62Te0AHmA7921SdgDlTCqAt7rXrqma1mnA04TeJSe68Q8yYhLffDe7jxcaQfqfEUkAlFmOl88d881eXffl/7Mq+UlN+w+4dI4TyoxZcrpFPGoaKp5HJSf/l7cBs02xjI55J4T/htRBpHFR8Jepeij0EdZaEKVFCv1tSMCmBTNY2hHQPSYlbI5yY36DT2L6qIsP9bmoxpqq3zm859SqZ8y40WpLuXefjIkBSLYLp/Rm1/LRTrOy6/psrDQyRTwnDBh6SDsnmt10nlKJNSFYnbOTe9OMIiymZdvjQeH2BP2R2+PrvPPaqju0/LZ4g/scbPSCdjlboicVgoOOpmurKlsII/ppUJrVjFeWS3PiTsuZL34EM2xsgxSRz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB352009265E861B3B79FDDC05A7E30@SN4PR0201MB3520.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:SN4PR0201MB3520;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;4:2PyySzZssR2RpfbDvp5HP/6vIOOMQYtBIbxBC1RGiNURK8RteWFVeD7MsjNAJaNK6YabMbRyQFK5nDOspr//dNdOjOa1aDWUOcPzEpUh/Ksbr/ppGx2yA1bNjkdPv4UrYukHX6myXCN4iOycLbRQ1RHWK832V2cttAsXfkPCYaPMfhPkc1hK9FDcGELhWaLD9AM5ztjlsQAZaBCMmhnfPkel4ld4Gh5ZH9hi0G3if2WZlWcC8xsiYO21qfI3/scR44olmTAIs4TMF5G95He3qhXuHDSBVkR4fZIIqaClEZLitPJJhT2jL1g+wRt1Oc19
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3520;23:275yJ7B3v+8qPfaOAJ5FncyNwC8lwfwy2Hrau3r?=
 =?us-ascii?Q?JGRAnoPFq/mO992O5x9OTGO5IF+NTZMC4CxybD9vqbSCF5yo14XhAeI5Xh8a?=
 =?us-ascii?Q?YX8YDZjEMalZCypgmOay4if+DGYrDafeoDSGiMQWtjtlVrJHWlPi94zhMC/1?=
 =?us-ascii?Q?Va4pPUao3dh1kb0UwJWsYQ/PETeF+ZssUbY4HzzfNSKGIhMKSiRJGLSSOLml?=
 =?us-ascii?Q?ZdJltFoSvqtsfTghlYMOh0WHxeoj6PKH7rg1k3vBkJUV4m+EiqYCU9o+t0Vs?=
 =?us-ascii?Q?4xNLWg6rIh9szW41LeueANMiUq/WHjZrwhaBriTwy/rCE+vzmhrqEkNJgBRg?=
 =?us-ascii?Q?RcQN5VM2P66hzSknqwP5zul7k9ph4mE1I/W+eM6/9HC+DJZeSWa/Zz85K+cX?=
 =?us-ascii?Q?UYXBkZLMJFJqdXYgP1Fs/wUm/erOcnQW/bYAaIb9tv5wVrwvU4ZGOsiGIocr?=
 =?us-ascii?Q?1prkN9UHwRt28bUvimA1BcZ0Qa+wDYupoNH9knPyXqZ2JnQrq1qgambHBOYN?=
 =?us-ascii?Q?a0gVcGSproad5wHTisBWZ3BWpjlFHKhg4xqAvIWmuZwoWkCX28cZxFxD2+dU?=
 =?us-ascii?Q?b+iaHFRaIxMPjimEy3glRpyr0fa1PDpiyMrDrV6DDsCeKW9pu8GbfwD2n5O2?=
 =?us-ascii?Q?MkU5jtY8tc9rCHhvImuSgyGg0zldLQ0dtM/t2E4QxX6SXldc8nzYKfu/a8Zx?=
 =?us-ascii?Q?/psqdt52Zv7Xa75E9QVovo055Rn3frKB3ojZYZFdmPcqnqQ+6asaK/VTd/k2?=
 =?us-ascii?Q?T6umHoG29pu64yhCBetUBsAOijL76/adikw2owDLRzjW8n102twazcGHzlb2?=
 =?us-ascii?Q?mY9Xzm5x4ckAkN3TJnxb41TgNj9XZTE/DdTvOPIazrBZ0P4GH889y3mvmj2f?=
 =?us-ascii?Q?Fc/bMokW3mSBJe5Y2klX6HE3IaWa9TBhcQw5v8O4HYouuURqOuyvaQSyfPoV?=
 =?us-ascii?Q?XYKqF68IeQ6rZUm0DeI6i7vBbwvlMtDWe9pK9euECAgNyN5lBCf+kCJfcWhw?=
 =?us-ascii?Q?XwkFGSqcoqN7BFIYBlDQ9Vn5Hhupx98Vc/pDQK7/N1snSp952I1uBRs9PRH2?=
 =?us-ascii?Q?m1SesdD4juyLOn61D/9DNZ+2VJB6CZUGbmff5UV8yw2KQAXrEFdUx9/mGM4R?=
 =?us-ascii?Q?RVPkCD32FeFxaJi1KiJPxZfldvhTMph8FHgDwIgNr6Oybi0EnSxIxZEM6Ig9?=
 =?us-ascii?Q?mVIJH8hnw2RUXaKNOgpFNPKK8P0Idq+kalxXWBMn679PgrW7qKlj5v7OBmSQ?=
 =?us-ascii?Q?Ci0tNx7MIf0bt/MFQej4ddm43FVNufE6l1MGLhqq6?=
X-Microsoft-Antispam-Message-Info: sSvBesMh5NDzLJG3y7VRJNEyvsps7WnSwFGcj02xQX59M1hKJzsEZRjLJnx1gcddi0WwBwaS1J1kfh1/aEl2xLn7LfTYC1uWlbWhFQTUY3HuEXAQ+IPzC+p7xQbdt0Mtn7jtAgYTB0PO3ROBl0g3nEOqCbSbSQA7BzmblbnwwWK46wz/fmDy0atYElUxmz7teGUjhkM7U4NKSjPPS3P4WRb4MuwOIFeZjBqsM7OaMNQcGZnpKZdZ+RXs1Neby+CYnTB6tR55soLgMD6b3g1Wes6scXjEH81iZHcRvCF/ZrIuddS9WZIERQt7L/98/uKzIkh3tRi3P3EUV6qHGF7DuTE7P5rxG1QXFSIsAKwnRuw=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;6:8pPZl3PjZMbA829WqnqsoIoZLmPCtfLK2D6GKOz9SpZE4UXtyFQPRGsEEWX9hOCPHFiSbliGCsZ+ubmlButuEKAtu9dI2IgK7Mz1q+NFL7P33uB7q1/CKUecFhd4LyCVEGmc5PO3GySg65gIq8wujz3XxueR9MxqqKeqn53qTypzZhsx88h1mzHeB6i5jDsFYl13jkWaLgY7zlIH3Au2URY4t0X8TABMfzqcf0hIA4MWOWV3V/ekaajZFeQcVIsCkqFB+JLbmfpjxX2bpSXqv/Wl+Jsg+Cz7qkHmFOVUscq5AbBi5rB8r8YpCdCbdQvC1FA3MavP9ZN3HB8RpZ2hTv5rdqOm+A3PrVmqyShvamslgpFtJd4H4Zt/ZDS1dLkQOkyWnLtAtoCEI0z0e4++29S6jA5F2S5kuBcSLpKZ85hYZVmBN/JZPyWWGKy6k1JY8fU+MuiOx/4l0cF2O6qBWw==;5:VCTQfwz379mpZkoN3OTr6TlM5gMtgM8URFFRnEHG0fKxEcuVYFqy/xFWlZmgXCIrqOvexWU6cqvsg6sq/UrgGcNoXAtICpHO4N4UD5GJ5dkS68qYhtXAVYvPE5uqy4ukhOI2EoiyH6YiOdfJbl0shW+bH8IkswJCTDw6k0xIm1k=;7:kUHX3g30vUeq+9jMV6o3I1L8wjkaAkHfDTno7eWkPSbhIJWCSmxfMs0cwUkRtLcbocUJVkAxiWQA+mmyhP6p0kouYlTcvSwPGOXxBX3EFGS1q3MsGieHkktGfTFTgK++l2TkP8UGsO+fLi8srUHrNGd5HpHElSKZqv+LWru7BSwDmfT3Mp6qUq6nSrvmqT2IjighUs0HW5EFy0E/bS+NeYvRXoV9A+UHkNvtgGsE5da4IllA00RrU2xATxEvRdHA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.1078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1af2d9-3baa-401c-7684-08d6310ded2c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, stream id related information
needs to be updated into DEPCMD while issuing START TRANSFER.
This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v6:
	1. Used dep->endpoint.stream_capable instead of dep->stream_capable
	   flag

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ac752d4..862ec5a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1225,6 +1225,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
 
+		if (dep->endpoint.stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
-- 
2.1.1

