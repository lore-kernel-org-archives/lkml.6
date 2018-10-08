Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B15820C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wM1gtWYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B15820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeJIBuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:50:17 -0400
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com ([104.47.41.81]:55917
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbeJIBuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJPK/Fv/6Y2Wo/HsHIWIKsWPfhsni+7rYOSnWVD+Ihw=;
 b=wM1gtWYdSbjFyEyz5ZbMGxPx70Hw1NGw2kkwi36IAhylKdDRiJRtEb0+W3YaXUrDjVRZb+V0DFkPvtF+5KcHhHcGRmSVzeksHWmel4jt0IsB/VEWpOq5ytbIbKvGcX8VWm+qA508yr/WQs0Knm4Cjj+FbisKhVJddy6zo8ZglRY=
Received: from MWHPR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:301:73::21) by BLUPR02MB082.namprd02.prod.outlook.com
 (2a01:111:e400:811::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.25; Mon, 8
 Oct 2018 18:22:07 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0044.outlook.office365.com
 (2603:10b6:301:73::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Mon, 8 Oct 2018 18:22:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 18:22:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAL-0006BA-Vi; Mon, 08 Oct 2018 11:22:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAG-0004DT-SD; Mon, 08 Oct 2018 11:21:56 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w98ILtjL024115;
        Mon, 8 Oct 2018 11:21:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g9aAF-0004D8-9F; Mon, 08 Oct 2018 11:21:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 2/4] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Mon, 8 Oct 2018 11:21:44 -0700
Message-ID: <1539022906-18073-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
References: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(438002)(199004)(189003)(446003)(14444005)(77096007)(126002)(11346002)(36386004)(106466001)(36756003)(486006)(2616005)(356003)(476003)(2906002)(7696005)(478600001)(217873002)(186003)(44832011)(72206003)(26005)(51416003)(426003)(54906003)(305945005)(336012)(106002)(76176011)(5660300001)(2201001)(316002)(9786002)(81156014)(8936002)(47776003)(4326008)(63266004)(110136005)(107886003)(48376002)(50466002)(16586007)(50226002)(6666003)(81166006)(8676002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB082;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT048;1:+qgce/otNyuaDyP+PQ6aUZIz8NsiUuDSeTku022BeElS14fK8b/BA4huCKnyiILXshm8m0Apb8pPL5aeOmvt65fSjUexlEOqE9HkJe7Umm4NrvDDoHJv1MI0jqmDAA7k
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11d2a5ac-df41-407d-ed0d-08d62d4af377
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB082;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;3:TrKzz8zLNZs05vP5Z3yXHQMcL89NDXFpdpZ6YDQ/67HdZCKbPlVl8w3XducUZ4f7Q3Ok2Wo7bTHpX1OdHfdCq4JyaupBjSsVohWZJGturhLMH10IGyp2IRgzeCwqQZjFGeYlzU/d0ZHW/8dSIVjPjuRIhHWw2GKPqCcgmYJpiakG5/wP1DgCfsEZSqHjzkA/hXqzSpnaCs1Ti1w4hPVNjMId8yp40leOU5ZPpekVk2Fs5pMsSsyAwVeLL8AaU5G6/Oo3fOnWHhWg18wfoqA/ocinHs/5vN2lSnrO94Q8XNVjQV1WwPdQMsbDXlakEejBwUoziJIS6hjjtjWUxxWgFypGFuHVbEVuOayWoyWynB8=;25:UD1rekE5t+b7k5T1DApSRT7Xi4Dl2Uwnrq+UsIaM74G8AgeJRJ3khnzWaahYONFiKHFdnCVKYli+3n1dTsYdZPokeCgOpj7H+Za9p/BCi70lk9vdQhVtYBdnpNB2XWqvkcxa0kcPwrhfzbTPlMRUauleQQVBm2P6C+epHUlN84Q6x5R8vAVQMgP+qkSjRRAfvtIP5NElHMMDhOQ7ziYRv1DzlTurdtwtqsYl5/I68DJl1ZNto92zr6cioOXfDZLz6f44UD3knxFZdvUCEiOJKNrCLe4TffjsyUP27DCwt80CzEQTPjcO8CFXp8GoeRhaZP1P/vwwgjRoVS5XjSuqmQ==
X-MS-TrafficTypeDiagnostic: BLUPR02MB082:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;31:RmZFTEnV7Izh5vArU2dharnySM/7eGRekA21bkmaGwZx7LKtbXOQ5TXFGGulRpbjr4tWEN3Q0MP1+3KAC4+9qP7+51YAfBkSEk7L10i5DNpnckEUuz29U44+Du7eMe4cTKL5kmKzAF/zA3EbTUDAA6W9ovMWFj72JFVQfDm6pkDJ3IpWktPOCrU6clW7uP3swF8UWvNhF0OcX0eo/5E7ttcHz99hHiWuS+xo5IRFKuQ=;20:0o15uhfbkvbJBSuyLswJIDOEhTAWW97EJGkIgcmX0LyaA6rrM4HlxgxT5WNKwCklHQJNVIUhyLp3BbjKrzBtFxzhatXxV5SgKG1yDBgY+OltbQewCTfoiwA4P+DZFnm9BYDAHh5bqysq4HuPv6kvZGU4xeO3D7F+VzsSLzCGlCsJSdZVwib16X/G3vruWty/CxaScFmPJ+qjkuMNy9t9Z1Cdr+Q7OjeAGBPIEp6QB312kFpYH5W8euDsdBHIIqSKEKuDONNGSaY2tVk5Bk3XEcgLqgpRaXeFFmTdvanuD3K113SuIGpSdmCjtB8EnIAEhc+IVm4IKZmKhKYeQYud0oGPD4DZfsOMZuvuyqmWiaNAapB/tLZmbsnBcZrfKA9bR59J7SW0uG5LXXc9d3ayN56KwwYr4+rU151xvvuL6yrl1foHvfuA31+NKH3ObmANIHDRHOIARZ2v7siX6OniFoRt6TmosA3kYEbKgXN2w0R2i0lRQW0oyvJeKDh5Tg8v
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB08244E1CDD602B9F5A93DD9B8E60@BLUPR02MB082.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BLUPR02MB082;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB082;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;4:QmagnLu+jJsFd0ZEd+/BwskICMxAOdE5bGwCxkRSwKfwuG5UDohq6FE29NtOWn0VZCBwnefuoOe3QnOJPizV4eMLJ38NAdlVdtuJWAvPZePdh3/lP0kZXAp2Mw42+pAb2zEJLuSblqxh5rf1+kptWja1bZNeP7oRx99bTziCWus2MBYgsrfwj3BzTYCn98rz0z4dOnIFjvX2xIA/j9ihOQ8z0emxDCUS9CUKoGhyoYG+en+LZkXCK0plFiLn8LlF/TIhXSC2aDJ7712FhCvp4HNBlIc7zSIc+nnFdcjgG4i58SYQxgpLMM0A9WZc49Ef
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB082;23:ufgHYEmLlcOWV5DodEajVW6/VUZDgSUdkoFAD+4Wvp?=
 =?us-ascii?Q?NqsE+jcHWz2+OoTGuIxhLmsneoaCMVOpS7QxuidUaHhgoH+Xnm77Mp/FeF8V?=
 =?us-ascii?Q?zcnXUm+wbl41hK0qAnfTUc/sdxn5/bEp0fFNFxH2PrSmzQk8btxdo4kBPhs5?=
 =?us-ascii?Q?B5VXHbtWxxF3vf6GIytwkCpAIGZDuUn6OGqubItu1aWPQMmvyku4nsIArN8O?=
 =?us-ascii?Q?o5fNFJMEwDtgyfDDHPitY10KLVzmGoJpDQzqLLb7ScRmTWyqyqq6w7mAzq7E?=
 =?us-ascii?Q?XV0Bsa00Ys9CENL+YpxYvwJLUl8fL19Q3Nb5bR7H7qsM4sAI6tI6y8TpOUSm?=
 =?us-ascii?Q?6YQ67h4AE+9wmhcVWHAtDNeb/RpBz/GdFQM16dIsqmw2VyrhIhKGG2wrFFGZ?=
 =?us-ascii?Q?KCMAzQRuJeunGi335jBUIsFtOgpTbSxf86RcgNlSzSwxv3Xw11uh0aq6Tiwv?=
 =?us-ascii?Q?ox+kltAM7Za5LRiuVlRPWCHSq6o4jNQO2ADX6c4QLrQR+hm+vvBm6dJXK2Pr?=
 =?us-ascii?Q?QtXE85tXk+sjDvFoWx56YZbBlb788d2qbkLC1dGb5EB+98WL64aT1C3eGqim?=
 =?us-ascii?Q?LLgS5JKBLXtbSa7blPzJU1cwOIU2tcP3/DkBku54znujr9WOpxWw0TpVYSdz?=
 =?us-ascii?Q?vwDT0YGGxczUF2PqyFlubqYiZv9R9/fjrgCfEAC6puXKRpX4AEeGATzC13Qz?=
 =?us-ascii?Q?P6WGYroMdVJn3M8LusERVhmyGsVtCMwPdLKZJka/iOmbkbaXvWzbvsGHs0Sn?=
 =?us-ascii?Q?WY/lTh9bdIyk30pKuL9bgrEI5bN112ygRPs0/lCbuLouMxPUnRo3EeFcyL5l?=
 =?us-ascii?Q?BuEJALVM8bvM80yzcXhO0PGqSdY730WqCX0ZcUSVDuE6TQ1Ldo3LGkA4X1wd?=
 =?us-ascii?Q?OfWOU7/A3hpWo/gDkc4BqoORq2wNzQhkB6gxDdD2Od5PhcyVPM3Zqoh2n5nD?=
 =?us-ascii?Q?AICMpQ9ii4vuNSZZgNIBTADvsWlMnpcNgO0/1oN43mrl5mmZEv1sKrU2XnCu?=
 =?us-ascii?Q?2zES+IPSt7T3WWIMUWWUVGReMJiF+tzC30+X7JK2eAkr3jHyvl5J3TEIpF2H?=
 =?us-ascii?Q?90vvRTErg5EaborjPbRkEzdz10RmZVchqVKSFdJ0kNYTtmpVLB7HKKWv6Uo4?=
 =?us-ascii?Q?qCkEyANalpaoPYf2MaSyssvKXuhWSBPARMl3WP3i2l7kxIuJzAJZFZPboFZr?=
 =?us-ascii?Q?Z6uStL3UD83B0WJXrqbNq5hp0vR2uQMuT7?=
X-Microsoft-Antispam-Message-Info: lTThUPhFOHeFs3iyq3RBtHfx+/TZZ2CPwCKj+J09D8wbnXVurVaKsJWfOMpPXEn47vlbS5N52994Y9nCKGaVgfJKMK/dBAj/FBKIzBbD/kGbd67SfZxTLpGFi9P61zJ2/ZQ5eZJBHnwonShl+4u6ebjpNfbob0sl4DAwvE8WDMlTbj16vfaLh+YzmrkNs+yTvDsZWXqyIZ7JlAWQrV2xQuCWIu8QsBpaAEuHg4dVzt7mD+sawyOIeCFkT1tIXPABUrPowO7pvQ+WdG8zsIyPm8lnpYa29BRAhqayxw3xW6+9XO4PQ4E+Gy3to58LifIAFp3fju1vR2qSCJIs7rYTlj/9Of76GvMDR8n9bIOX1Qk=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB082;6:VktqMMB8GFMzildfUCplrOEuKvRiW6s02oTMa0sFLIB9FdLoPZdjmUtu+9g47HIxGpvParwDDN6rbAm7FNfyx+uBraCnKt5JiAjpsv+5FqiFz0goejVT8asQJFX4XkRoJMPPiIcv+Hz8A0ju1sIWUyIxY4CBehETgKVeMhZbJSz5oyxAT5kJY+eH83LYyON3JKTLGk+LI/6z6nKDQCdSZ4hz8Bpa1sSbny4tcOMrPpY3IY6fNW5hdG7XsGbYnMu4EkpVRSLy9WWlF6tM/BX5X+5aIa+NCVi/ZDGzytwfCtKvg8LdYalDpiHqijGsFhFnLNnbkXRn7B/EbWBk5IgaApKmP+iPslqvf5Ja6XEbCfkQFPX2Jx2Kum1CL04hswPTBd3lpEaurTQknBE5oBvnhthGfD9InC2C5vLEMBxfw9Xk4jjfior7QLq89I1OeyJvjfBwiB36twYiChVb5H5GcQ==;5:MIqQbKuYkfItf/WCDD0tK4ndPg+ZjBLPZhwZf4iPCyUSXjUYneKOmkJIJByXqVT0MXshmhJr0njrwrqkbF46QMhxl+q+xsqNBVG+lv2GE6iVb9HK9MqwvSKkqClXUtK73hnIEJIOvJiddPfTdPVkiAoaM90UiByGb8kBRu/O30A=;7:i7zVviy5/V15HpHEJ5Ey7SDbcl+IAXyjTBEEEn4biveTFS+BtBAia1DyF2Eu3W6kMyjh5u1SdT457qtVtqSwRiZR1iSgitR7pI/bP5IUac8YRQ8zUTKAsEdWUn9RcMzBck8KpDEZMYK10oRkGjGgMTJz1dSZcxMawG0i4ihkUGYDAC91hXwlEuykv0Cr9egppejdP60qlYk6J+SmffZl8wXyT2TcqMqE3IVBOC7mlLXZsClEAoz/tp5KkYaCZ4x0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 18:22:02.7868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d2a5ac-df41-407d-ed0d-08d62d4af377
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/firmware/xilinx/zynqmp.c     | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..9a1c72a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,47 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
+ * @ioctl_id:	IOCTL ID
+ *
+ * Return: 1 if IOCTL is valid else 0
+ */
+static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
+{
+	switch (ioctl_id) {
+	case IOCTL_SET_PLL_FRAC_MODE:
+	case IOCTL_GET_PLL_FRAC_MODE:
+	case IOCTL_SET_PLL_FRAC_DATA:
+	case IOCTL_GET_PLL_FRAC_DATA:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
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
+	if (!zynqmp_is_valid_ioctl(ioctl_id))
+		return -EINVAL;
+
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +481,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..7a9db08 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,7 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-	PM_QUERY_DATA = 35,
+	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
 	PM_CLOCK_GETSTATE,
@@ -99,6 +100,7 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

