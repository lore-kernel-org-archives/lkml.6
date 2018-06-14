Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C5D8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B004E208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yYbNDgtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B004E208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755404AbeFNS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:28:18 -0400
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:39310
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754833AbeFNS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJzB+KnyFKhLEmWrAsNYQ8EP3hzk/DxRcJ5zh/8+xcg=;
 b=yYbNDgtbvc3AEdNjiZFSNbAVn3OLsT+21PgB4mpb8UHleoKSbxIkhfnpPyw7KLCY0mhNDCAKwpN6A8iIP72K+3ATZ+pJpyb9Qg4KGnB1sP6+/zIFe/AuGxBp0vH9zWJLgab30A0EZUZC+xipwC5w73y77YxhVWCTmGsBGQs6sRU=
Received: from MWHPR0201CA0071.namprd02.prod.outlook.com
 (2603:10b6:301:73::48) by SN6PR02MB4349.namprd02.prod.outlook.com
 (2603:10b6:805:a4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR0201CA0071.outlook.office365.com
 (2603:10b6:301:73::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-000211-3z; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-0m; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRtEB017077;
        Thu, 14 Jun 2018 11:27:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-IC; Thu, 14 Jun 2018 11:27:55 -0700
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
Subject: [PATCH v8 01/10] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date:   Thu, 14 Jun 2018 11:27:33 -0700
Message-ID: <1529000862-11510-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(54906003)(7696005)(110136005)(2201001)(106002)(336012)(107886003)(186003)(51416003)(2906002)(47776003)(16586007)(4326008)(39060400002)(316002)(26005)(77096007)(36756003)(76176011)(50466002)(81156014)(446003)(305945005)(36386004)(2616005)(476003)(5660300001)(126002)(356003)(11346002)(8936002)(7416002)(486006)(6666003)(426003)(63266004)(44832011)(106466001)(478600001)(48376002)(50226002)(9786002)(81166006)(72206003)(8676002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4349;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT004;1:GxunQtD2uOF/2AQ8MnZcQmcyN0NxRVASPvv8GyewPa81dtf1H3B+ygyOTKf5RmahFM9rckaFElBqKNKGYjNYIlMDJsSLh4IluWLUj+1kP6u2ac71imHvErv/yNA2Incj
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d154597a-e285-40b7-e14d-08d5d2249561
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4349;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4349;3:xqzEHs2ponD0o+eh4X8zUdGj2uVif7eQFtZ84UyY3R9W6VjdvWHFSLJ9FSYDDvhI8LVL4n8V5QdiB80hcHVQHLKxGc33xb7KLMHsND9dwtWtVLq7fO5ltaDzraFfK2aumfKPf+PtMVdY+nHqqTO3EFJ+KsPyxswL4asxtT9uPPhEo1mpdMCbRxBNy/Og/YoDnGs1xyS+JvsGpBm3QyuRvcz0bqeqRYFdiX//hOESh0DXxyb5uE9F2MiJhMvs+M3cTY8dCsJzXxy2SpeucwpEzDqChgES2/EkVaZLqwbRhC1Be5NUOHD6n30pCTuWRvTIB6vslVBg5tIrykqRfUaChJ/4oeDQEvDY8coTawV9Rrg=;25:8pMnTw9/41YwlQmP0Xcw5YP9EijurhC7zjBqG0o/1tRoPAfz86WTBXLwA/4ZCnbik/6RGJjr5GjQp4/0eVO355MnQbFWvMWktl63CCYHYOhvkye1R/4ROUPH5e+VckT0/VE8vqx/uMEaXW1uwMs0A8do6l9ZL1GxSsCHT8jh9NEEbCCBvWi9+Pm6pgYLiODe9IoMtROtrGipCCUX0n3m1k9MXajLp0SIcw7o32WSVo3naDSky/mDhA7DfMupLf1Rwo7+K7EslJczFCc0HV1wmM8U55CS0sgze8YmRq+OdUCbF9P3zuUN4R8ke+orCP/i6Lbww3d5kJg1kGcEs94GMQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4349:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4349;31:jwwcsgzr+OMTQnlfh8cS8U3hdKlo+jXBQX24xxwaVkRoJ/kvixyODJkxW9tY12I49RdEMFs1FtB4Jkruzon4MF6sJxSH8QtW8bwRtJgfVGrPacHon9jDvmqME/HMCWZg25R8V5dAVyQC3nshRJwJobD531V12dGcZR4jhwFH6jJvO/+E4cSQXGS5BlfJTXUSk/zOsaO7036gKlzUD/o5llLHswkSdgd9Y1YG+fIUdQA=;20:17hxyi191pJIukc4BW/iGUcorr0cSFUD/Ex7JYju/AWkmtOLT24qYe/j/Q5QtQOhOxwwUK36U3fJjt8c+ibaxzoKQ+k6HNd2SUfyBGiCa8QIK6R0UvawRqrxDnRszvffI0FnZahWsI2tWuPvOCeJAOqg33F8OOJb34YGvhVsKu1PVSARoRDFmD/k1fK0JAWaHY+z2HXysfScjj+vXLLOly7geqkKTSMJbu6nqBeIN1Gqyl4T/unlEih0hFHyvYo3YSBWMKCaVxxxz1765eK67n/wpu5KK79zOYvygWAFApkbIXt1sr+mt/icXq+9nUceePPqJTTNb6r7iNUqFHMkYwq/gYb/kBjbYBIWUqi5i1fWKauitZFjT9ydXaAju/rrovvqpK6GDdwRgOjeVjtvMsAT1gdS3G9cbHk31n+tjlRljrlV307+8PJVe11AYCAOMHsBnzkC8SmZW9foCrTEDvsWBZfk9IZv2k3ppO7d2bus3aSwxHTUZKgRB5nwSt3V
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4349471A05F4DE83376ED195B87D0@SN6PR02MB4349.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4349;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4349;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4349;4:57wdRh+0bgiVU/tVxZKqXU9wre6Stigav3cgelL7n+uF0d0qy9/nJ4JSjOCjQaw0NBBnHQtdOwhEG51mRnHYnsaIj6GV6kFhs5DaKJ6yYqPzVqPAXsN7zwhsyIqqzDG5vY/z+4OV+LjUv7CanGQ8zogFHs0UTBlKS26V8SfPjwQNiMqN4xhMckuSme43hQf+dV0PwPSPl4QPHbXLnbmC9prrH4k72l6XP8cDcZC98NICMsoTmMJ7Xet18vOEySaSNW24eChN3K5sRZT1T4ccvqyj6DOptv6xY2Ftmc6sZmZgIUY0wndp29L5A8WqfnTN
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4349;23:9WR6tEGLY5oQPxuxx2kIK45TvilxPbBBscjpsW8aP?=
 =?us-ascii?Q?peWlfua82GwqEWVYStMTAVAH8azbIkJ4V3MGiXhCB4ph4EsvmfSWkpRJg6R6?=
 =?us-ascii?Q?/l68eprsehA0j5OSMEzlk/qCjK55b3NZjg8fms9dHFvJUS/jMNNPyUWZJYjD?=
 =?us-ascii?Q?E9upsfqARDPR00d4oobjQSzEKDPO1/l+YVFF99n3CcPTsWXArHOPc4FSd6Q+?=
 =?us-ascii?Q?Ke3VVhmw3SoPZkDC/XHekv+E1X98WUlQ4mFqh9OADNqFu7x8jrgLKjm6WSpy?=
 =?us-ascii?Q?jiKNJ+ekiGutucxIDDvdLOfzawRCIYxNM+hN2IRM7k5D7B5jupBDN88KGCcE?=
 =?us-ascii?Q?6KgkGmb6KuAP76ndE0l78syP9fqQp/1pdzekuy6lmK2DTuP3VPRvHuc6r5vM?=
 =?us-ascii?Q?lKrcO1gQq5fH9o6exNSlrmYoGxYvY1y/Rhe8j7FXMHZ2rJMhxrC0NSrGYwRv?=
 =?us-ascii?Q?i8fKXgTTJ3qcMy/jIm5kpVrtzxyLuvC5WtrFOtP2jqP9FG2+eXYCxwcaWylT?=
 =?us-ascii?Q?omvRjK4Jf1IYCY1odlA6hFxClENTyoA4yk8rTVfzEqxpt2KNFIkS7sxpYl1g?=
 =?us-ascii?Q?u6DI4T1V3z2apN4pKk0ikdsI5yZy50+eCo0MhWRXzusRb5mPD8y8c2KHYBHg?=
 =?us-ascii?Q?11gkxzVaH2MAVjjl2sV/HRRmv5q33D0qRbeZfVMM3cwdcqkncjWOEOd//u+Y?=
 =?us-ascii?Q?jGd5OWLG5/YC2LcvWpYA5jq45aePWg2EYbD2QWxSl2TC4aiY7TWm9G+spBH8?=
 =?us-ascii?Q?k5zx08kXLgfLi/D2Mvv4Jmwd4jK+Ec17qekPPqtiLDMPrWN0iHE69al/c9ea?=
 =?us-ascii?Q?VtrDSGCkPH+DOfuje4fXuic9FcKqekSDGHyy6ATBut919xjtdLRnR0w5S7hY?=
 =?us-ascii?Q?MvRTZdbuU5IPBrSi57k78ZXEgg8Wr/I038tOV0jpTA9bAAgaE20KLZL1ucCw?=
 =?us-ascii?Q?q9MFvTnmFglY5O8AIKrzcgd6++MfJfsevPRdE2Vh96EiGpNQyZOxcYORv50S?=
 =?us-ascii?Q?72zKKB7Gnkl/+9YUxoWcYTUE1rxb6dkB0rk1LFBIVdafkO2eDEMEfSfbd1lb?=
 =?us-ascii?Q?0U0IFQG/aeS8PVDtk9glX80wjZy1eZFzbwshhaVk0ynoGwXeiwF+/AfAK8Bm?=
 =?us-ascii?Q?+UM4hil1TWakGgbL6vWphp6aPghuk18J5o3IS8nuBy4lJDUw6xFOCZgoO8mb?=
 =?us-ascii?Q?/2aVJIO56U4vFBXBtW+U/hWuafs5K6HW2D5vyVqrFYmxrlqzLxrsrrI4X6xD?=
 =?us-ascii?Q?aC36nX53XE2WWFC/EE=3D?=
X-Microsoft-Antispam-Message-Info: +6njQ5awwh9HKZlxmWV7osYdYy9WJhYLNuuUSObtKcSd1aQSYxsaaDZqzCGiUg1N8zDF8QEaQDAocameCXXB1UjtCQbgtRWXEEtdr3z/EEzENT1p9iNTJi1CBpoujL3uzu/1XFAA87IUaEaRaH5OoD6RrrvA2zbLGoaP+2Ye9eYM7qTQ9dtvk8zPCIx9vfJE
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4349;6:edPDm58QAhhety/UGFK2E9YtJwHBeGLId95CoDGkamU5U0XMx2MLHoE3uhqzkKM+/KjN2s+EcwoU0ilQ2geOBtH39SP+jxnnbGG7Wu4R64qxHyUQ7ku2AaFmrz7a6ofORI+372PcMiTYZaZ2TdVDffeeXmaJ30L/2YVyaIzr//7dictJYVXDymB8vuF1kS6ulNO6MQcPp8S3z06NEXrOl/NcF0aUHLdLaZmf9eLBBUpvZkLdNpbDxniFugSYLUi+5K9KdIusLGF8ktbEdPw3mCHNMybNXfwcKQ5dIEoLSvaAJLEr4lgO5lG+e2uP/Im7gA+wLRTGc7BtqQAlyz1lkeAWhzVXK6kfGyFinveRnfcemreQujrqxw3UclagfdJJLx/uLPPS/+tzRjKFQXeto/rqFhxppxLhZZ5TKS/wqLZoKisNYP6R9P8FOQGUd2l2wgmXB33ZyYiqgVxDv2tK+Q==;5:/k9dykN724/FYvd0FlEhWOB3kpao9//28JA5T2vw604MTh/3B+Xjx6QX59Ir+06oM3aW6nRKeusi+Xbq9ltHhSq0rAJUX4/VOuRmkLuf5++kzZM5SrHwV25CxU/Y5bcbWO1e1Q771xD54wN7Mv+OlQIva3sesTGGYjkn1zpacQ4=;24:BGC5BascZe6KwFqMS4Sh/Jjw0z7YLsKtS4w/yBPX/BicZx8sp1rB3EZ61CL2y/zy8S8GdUlFi64nHUTRXnsFCw7gZDXmnyfB/WsckQ2aO+Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4349;7:MqjdfwKgpIryxpq9gqh24bs4zNkGnfYKx2dCmpOm7H8yiFLK9RbZJ0AyyFb28y0qy7JqO1tvTfRseR39gSuFmxkEaVWfsx3i9QxZYTlytp6DUv6N3N92RR5WDKO4aPf/GzSrBGtC2aGG52fX5BCd56r5WbF23k8LOqHrumKPyHX+QvytCLXwobpBgbnWhVb4615f0b8er8NlaivEmx7qI+pUJY7rBX61Ge/3hocE+rqZEWfHGFPI4apgIuABWnZZ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:10.7793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d154597a-e285-40b7-e14d-08d5d2249561
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4

