Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE3FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F105923F73
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hqKbWwn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F105923F73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeGFGt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:49:28 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:24058
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753814AbeGFGtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTFYRDJzL4FbkReX5Ah9/X0XDadDa8fqPSP/0cK+tYs=;
 b=hqKbWwn+nARzpotMOMEYa+yEdHznDAHHHUKmFH3z6bFPZ0+ruC+roJYurfsYkUhdrDVULfXppoxxFwwZ6p90PXj4D2FMFYgB1WQ0Z2jq1IXn8mS/hEVHBoPF7Kcr/rff7jMveRmyhdAUSvEFhxCxueMpVDlxemcXdJy2e70QTwI=
Received: from MWHPR0201CA0007.namprd02.prod.outlook.com
 (2603:10b6:301:74::20) by MWHPR0201MB3514.namprd02.prod.outlook.com
 (2603:10b6:301:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Fri, 6 Jul
 2018 06:49:22 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MWHPR0201CA0007.outlook.office365.com
 (2603:10b6:301:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Fri, 6 Jul 2018 06:49:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Fri, 6 Jul 2018 06:49:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fbKYT-0004Yy-GU; Thu, 05 Jul 2018 23:49:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fbKYO-0002ZS-Dc; Thu, 05 Jul 2018 23:49:16 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w666n7H9004746;
        Thu, 5 Jul 2018 23:49:07 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fbKYF-0002WH-2q; Thu, 05 Jul 2018 23:49:07 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v2 2/2] net: macb: Allocate valid memory for TX and RX BD prefetch
Date:   Fri, 6 Jul 2018 12:18:58 +0530
Message-ID: <1530859738-11802-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530859738-11802-1-git-send-email-harini.katakam@xilinx.com>
References: <1530859738-11802-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(486006)(2906002)(6666003)(81156014)(106002)(81166006)(36756003)(8676002)(50466002)(8936002)(9786002)(36386004)(5660300001)(54906003)(110136005)(356003)(305945005)(316002)(50226002)(63266004)(2201001)(16586007)(478600001)(106466001)(4326008)(76176011)(51416003)(7696005)(48376002)(47776003)(336012)(26005)(14444005)(77096007)(186003)(11346002)(126002)(476003)(426003)(446003)(2616005)(44832011)(39060400002)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:dCODEgfAzQV6VBi8XfR85sfXOo/dJ34F2vT8nmLz8sgqFXLiZQVUakHjkdCkOpwEL5n32+dsAKe0lrM1q0ZCy2yTuLcOugf6DRJlzhCZIq1AHkqlrJM8B7kX3R/Th90m
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cee2df7-3dd7-44ed-b12a-08d5e30c9af4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:MaSN8JgX5DTZptu8bN0+emcLBlA7polSJ4qbfR+RUXNTNfilBiMoIjeBsPn4x01zdr6S+HlLmvz4TrmN2rDuiOGZIlElYOi/CA1adSbo7dLPLRGurqYlKrUiB/XL2dIudXTuBtQFqT6mQ2/1u9tbJVe1cFmE9VIUTDEohju3SqeWyUf6rPenA6sHd+bfjKCOxFUXR87G81AxB4WtvJmq8gttbgXJgscIfYa/ijvyJC0f1Y1Kl9BumB68BI8c6y4q4KnHrvLYyxBlIj6vWyewa0p2twJm5/pCG7ONKrj9gcLguESEjy0g2tr+D6X/Ay0/yi2h+yo28GgeAovh8Uj9R+Vh7MpGJiip1Nzumn+Udnc=;25:oqMY4182xN62gnXJlLnhJ//ji913FCT/yBWphHrIzHgNXheW2zaCdTCeuFw0dAwXz7Co47oDk3YfsE+TXVp6lB1/IumtQ1+NuxIfhisFWqbZSab0rO/2MgcdGiLH4PxciM3gSEX0QCLNyRI+9spH1bmw+xhXN0MYpuYo1augsZalq7gDK5fhHosY7ydeUVzxMMhoJFdbBzErBy1NwGlrfeWuovCtBJXIOOxXz/1d8LaHzq/DBRYFFcsJU0mAIiRO7Ks3zzRUaG1P0s/SmZgAou0LRXlZg1kTKPlGfN+vICU7mMg/O8h22dOXg1imq8/eio3+BOwfz/3g3vc4it+khg==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:cZdJ24vngkeHSygwBWTWBGs5D7LVpfgkCt0QfL3EUZcLnw0Wqkns7YpSX5bjDb+VNnjTFAzX10X58fXOkprDCR0ghWpbJShH95Ouy8M+o3Yq0Hheb2Mnp47+Gb4GjqGovE/ITOheU3jNQdLAv1SRSYTuhKluZBtfgPBGr1b4hx4f+V2UemO/6XLTXxSKMoqA9Kv+rTRzD5EzVxZ/T54JOiXokTzX4IzBiPR6vuyj2oo=;20:0E+LXKQ1kjynkBf5LU1pUM+R7HTHUmMGyXgL/m0Tdmb+gcpf90r/Rld2KVdd3pKkJz1CUt2fT+u16WLdKXojbAX4UkSdAxSHUYUNfuIosN2wf6jGpX/Xz3CaSsFkY/pSjqnFMsX4opCPuf+4PWkgOPhIntEUK5snuV0ejUYZj0N86FnmtOpPZ4jzkg2tXAck8pPK5K9p/mXP/Upy4+FMxWuoj01kcte2gM09JfClv8GbIN/Ahrvr3+Mwr22FdunPBsWU7Vt7aYvUrjQXu1gx8jAb/sQbpl/p5dK9KPc5Oev7UuIVQYw5KIODPJYqEt3AIqFOcJgrkFgXgAbX8nmm6cyO8vYJ1Kl1vd+OR14cPfKq0jwjoAoZQAzJ3lDvqWkIpF7hdcJbNpuKy/DTZqIWkL0zA0XkZZKvdWFiYXGJgNieoRcxGeBk8diFbj8OdIdUqKsIm+OvImgdf2U/3ztnsxlFJfTm2VMtIpIwFSC0f1DxogpRZw4PWoK1ToRdNKjz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3514BCADC0E8E19D5A6833D4C9470@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:1htOGu9HBMEYufTW+9t9gJuc7EvHsL7Tv+/ik5utLPLoAvyqAunQ6VJaB8GJ/63jqX2mtlj1H3bcaIeyRxNb22hj83F9Y3ZfZi1GHwTEFVy1VXKmR8y/U1pSObYEVAYWx6zKzID0rGJu1ruONpmA7843sZAp2PVTZZ8d4ICGpl/DF+zsJkV/yTNnbLLplQbenVcofJLtta8qkyhrNUiAio0znUgUGAWt+dYdcxldMlAqNPHclLIvp18hUf1OEbbjPpQDAl/1mZ6gxY6ePOvRVuYOGYv7+u+L+tRPYqo438Np/ZoSpyre9qgzJ7RyNh0j
X-Forefront-PRVS: 0725D9E8D0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:3HdtnGOcDhYoYfF1NwugC+uuh1tOHA+sqAZZVa5?=
 =?us-ascii?Q?q+o1HhyKbQq4KW2NRkwNkjHH46xOZMPpH8yfAPkixZjiMZkP2dupUKF97jgS?=
 =?us-ascii?Q?gS0iPNI4lOY1us5QNAxcgaS3wK/ckfdTE934wNpYQGf+juwlliU6em7p0v2j?=
 =?us-ascii?Q?TWeCzMEDrhXPAupbzo9pDvP9ItceVdrMgSuBg0jkKxFnibR5r82jSZ/SefJP?=
 =?us-ascii?Q?JUaZYomNQjRBi3j0nl2LIg8mn80d1zXollGVdP93oHoWtmkjPG7sBkMN4szR?=
 =?us-ascii?Q?YhkTREPtRb1UYPjMlO6O02GpcJSBic85dgpRGtLJaqvveACJTUA2ofqnRFm8?=
 =?us-ascii?Q?FY9V6xrxnvcwdiTNGctu9YTK9DPfPVhZrMbQ2kdbWK0g4O5xR5FayUf6cE/6?=
 =?us-ascii?Q?Y+uSSOsyUv/mAjHB/wwPelzEY7yOYaMMj0vdLdsdRkU7X0f6Fc/U9wo+oeKb?=
 =?us-ascii?Q?B2G86pNyY08sbYwuLGyHiiMZ4Pnle/Lj/upNZmq3xK0DFvN4Wwm2gE13yAD8?=
 =?us-ascii?Q?lKCUnhCsQEGkhOZPTyOJaXaBkj6HtsJQ+GwFPVosA60fQ/vJMo08N0wSygK+?=
 =?us-ascii?Q?6ZZ6utcqQ115oZR3AEmPuxEUjAZNd63mt2F6A+pFaC3n/XCyn3t/KhMPJzLF?=
 =?us-ascii?Q?H1O14XLy1WZjEK2KxyrMJgUs6ZHijFSbEG4cCuW6IS5nKvYocZn5+8PUnxU5?=
 =?us-ascii?Q?E460UehoX8Bk3R894cUfk6AwjrUQ9J2DRrIBMxw9MCivvzR5Q7p7n9R8RPUV?=
 =?us-ascii?Q?6HcGruC9u8XrGEasCILwMrh723noRvQXK/GekFsYp2VupRVZsGk/v/mkAl3S?=
 =?us-ascii?Q?5Myg0y8o9aLVGK8d9zenWUK2H50pLofW5KzTfpmUj9tibZcEzPxa5C+a7dGJ?=
 =?us-ascii?Q?b+5/qzNxE6U3+2z0pa15Wb+sNyjLZ9afqnUUAguhI17vhdQeOjaCD0hw4cQw?=
 =?us-ascii?Q?9vr47zvhdw38IeMHVgl2IPETw2AihxlQrzCWZu/W8BTEfuwy7S3E37U4LFAD?=
 =?us-ascii?Q?tRZkMpFYPlE6/ZnTVkn6eQJvm29HFgF6f9Po3iSF27WRpnk+ge7CWK+xUTmR?=
 =?us-ascii?Q?cXRu1IwrNAmHJywVThg+HlqXmQKpPdkkzHWFSieNyOGF9E4KTL77lfOcYmrV?=
 =?us-ascii?Q?7tijYj52Y+8fSMx+Q2TKL+wzE4c55jdw1xoGAJkUpsUrfUKngnWa7z2X31H3?=
 =?us-ascii?Q?jZIL3b1anxM5hkbU=3D?=
X-Microsoft-Antispam-Message-Info: dmvaWFA/WbxbR0qNy68vkITe5pSqNOUlvC5mb5m/mchuFex8WIXh7v3Yp8MDE0zCW2RONCQgER+84TKnqm6YotysLqhKuQPpi8LCsKh15wLkOFBSqve8MhRzawY0gpj+k9bezgYJJX9BoJglXcUDINhvhDj7VSTLaR6W1YBwsdT4s4vZ7fJRNgWIkvY9VsqJH+ekNjFOz71Kbhyz2wN0CIeNjuHaB69q32mKa/9+ezNVeKEda8zikTTOcmjiuKIE3DT1lzhzysrknWy8V3oojh3Nx8V3IFe06ZJAnhbchY8WOw0Z5DkYBtX2Ivx636bfCA2Iw2mQMF7W0NSyZh0EnE+kDSVDiMJQTYCGq5q0OR4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:P8ah2iDw9CzShRVP78FMfJEU1tmU2haOryEGj3mAVQZG/PpeZ383hUXQ1/qybunZqH1xOfpkKTOf6HthZKhPRRcfffCsK7Q+POoXRztlkRtoagddpaURWrmVacYABotdb9SdilkyZMF9gQo5J0S64i3Sk9RDHOSQW1zhPaCddn8EV1pv3L6Prknv10/jtXBu223o0GPBjQ5LcN01pXXd7vuVa6VfPaa9U+KHtMSky4lQfzOayAGR6gzjB62AR3M6mfAGJODPAnyKWhAGqyGZFfnmjYfxlVQk/jXzvAwVO2ywu6t0STPZJ957gw1BuRLUG699r7VsDO+KIs36R9Ek6k6UDoPLD5QnAuw1MCMVkUMcOfnoKiOPMAVQ6ycLw+0mFXEjktb335DRuAOR6VGO8mDmxgs9/zifyJbmX6b3E3vXLmN4tMvJFgzD6Nvu3m1PmSANMTPjvQBDCP6gKHHBuA==;5:r5rG4OrGKUkVU/1Yxa1JN9amVfgMaxbujIEfD6vEcb9ih/MvE6xPWkJv18MH1OkFTZ070a36UGFMz7GwhLCy/z4mt/XRR+FDecK9EplDOEaisDWDpDR2Uv5pQt/fcjx/Ci8ieJijJ+P9Jl5rqFgBmsPgrc6yFpH7kJBkX6oUuIs=;24:LcvpVO0yP3M5EVgc3Glctd5KQUu2xoKxsz7QmWqVasOSYyzVBDOuRWJC5H8DAthEwpy9IoKYwRYuKg6MJcx8CbEUwFhIvOa5cUhEsQWWobc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;7:bXTSDHzRGfIIHTQK8dK1Jr+iODI/pEVUY1Z9HZaCscEk+q+szMb9qNxWZvAt6/yKUer/CT9iyYBPlBO+rTlMoylfZz7htyUbtH0xT6aa9XHcddF6x8Q56YnHttM7+gms67jOZVFisr7Sjw8hOG61RYD1p26SBjzY4gNxCyIjRT0WCyHojZBqDcPbsaavDtNjOAoh3r9O0yGcBwhTTHRzUaF0s5tWyc9C2o1dcj/89C1J+AJ1fRnxzoHfVeE6KWpk
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 06:49:21.8820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cee2df7-3dd7-44ed-b12a-08d5e30c9af4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GEM version in ZynqMP and most versions greater than r1p07 supports
TX and RX BD prefetch. The number of BDs that can be prefetched is a
HW configurable parameter. For ZynqMP, this parameter is 4.

When GEM DMA is accessing the last BD in the ring, even before the
BD is processed and the WRAP bit is noticed, it will have prefetched
BDs outside the BD ring. These will not be processed but it is
necessary to have accessible memory after the last BD. Especially
in cases where SMMU is used, memory locations immediately after the
last BD may not have translation tables triggering HRESP errors. Hence
always allocate extra BDs to accommodate for prefetch.
The value of tx/rx bd prefetch for any given SoC version is:
2 ^ (corresponding field in design config 10 register).
(value of this field >= 1)

Added a capability flag so that older IP versions that do not have
DCFG10 or this prefetch capability are not affected.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
v2:
Suggested by Claudiu:
- Renamed CAPS macro and variabled to indicate RD prefetch; renamed buff
- Removed unecessary prefetch variable initialization
Additional change:
- Moved computation of BD prefetch bytes to one place in probe


 drivers/net/ethernet/cadence/macb.h      | 11 +++++++++++
 drivers/net/ethernet/cadence/macb_main.c | 27 +++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8665982..3d45f4c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -166,6 +166,7 @@
 #define GEM_DCFG6		0x0294 /* Design Config 6 */
 #define GEM_DCFG7		0x0298 /* Design Config 7 */
 #define GEM_DCFG8		0x029C /* Design Config 8 */
+#define GEM_DCFG10		0x02A4 /* Design Config 10 */
 
 #define GEM_TXBDCTRL	0x04cc /* TX Buffer Descriptor control register */
 #define GEM_RXBDCTRL	0x04d0 /* RX Buffer Descriptor control register */
@@ -490,6 +491,12 @@
 #define GEM_SCR2CMP_OFFSET			0
 #define GEM_SCR2CMP_SIZE			8
 
+/* Bitfields in DCFG10 */
+#define GEM_TXBD_RDBUFF_OFFSET			12
+#define GEM_TXBD_RDBUFF_SIZE			4
+#define GEM_RXBD_RDBUFF_OFFSET			8
+#define GEM_RXBD_RDBUFF_SIZE			4
+
 /* Bitfields in TISUBN */
 #define GEM_SUBNSINCR_OFFSET			0
 #define GEM_SUBNSINCR_SIZE			16
@@ -635,6 +642,7 @@
 #define MACB_CAPS_USRIO_DISABLED		0x00000010
 #define MACB_CAPS_JUMBO				0x00000020
 #define MACB_CAPS_GEM_HAS_PTP			0x00000040
+#define MACB_CAPS_BD_RD_PREFETCH		0x00000080
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
@@ -1203,6 +1211,9 @@ struct macb {
 	unsigned int max_tuples;
 
 	struct tasklet_struct	hresp_err_tasklet;
+
+	int	rx_bd_rd_prefetch;
+	int	tx_bd_rd_prefetch;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e56ffa9..c4d08a4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1811,6 +1811,7 @@ static void macb_free_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
+	int size;
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
@@ -1818,12 +1819,14 @@ static void macb_free_consistent(struct macb *bp)
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
 		if (queue->tx_ring) {
-			dma_free_coherent(&bp->pdev->dev, TX_RING_BYTES(bp),
+			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
+			dma_free_coherent(&bp->pdev->dev, size,
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
 		if (queue->rx_ring) {
-			dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
+			size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
+			dma_free_coherent(&bp->pdev->dev, size,
 					  queue->rx_ring, queue->rx_ring_dma);
 			queue->rx_ring = NULL;
 		}
@@ -1873,7 +1876,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = TX_RING_BYTES(bp);
+		size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
@@ -1889,7 +1892,7 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 
-		size = RX_RING_BYTES(bp);
+		size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						 &queue->rx_ring_dma, GFP_KERNEL);
 		if (!queue->rx_ring)
@@ -3794,7 +3797,7 @@ static const struct macb_config np4_config = {
 static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 			MACB_CAPS_JUMBO |
-			MACB_CAPS_GEM_HAS_PTP,
+			MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -3855,7 +3858,7 @@ static int macb_probe(struct platform_device *pdev)
 	void __iomem *mem;
 	const char *mac;
 	struct macb *bp;
-	int err;
+	int err, val;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mem = devm_ioremap_resource(&pdev->dev, regs);
@@ -3944,6 +3947,18 @@ static int macb_probe(struct platform_device *pdev)
 	else
 		dev->max_mtu = ETH_DATA_LEN;
 
+	if (bp->caps & MACB_CAPS_BD_RD_PREFETCH) {
+		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
+		if (val)
+			bp->rx_bd_rd_prefetch = (2 << (val - 1)) *
+						macb_dma_desc_get_size(bp);
+
+		val = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
+		if (val)
+			bp->tx_bd_rd_prefetch = (2 << (val - 1)) *
+						macb_dma_desc_get_size(bp);
+	}
+
 	mac = of_get_mac_address(np);
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
-- 
2.7.4

