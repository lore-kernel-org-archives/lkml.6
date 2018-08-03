Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E695C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4798D2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dQ/clLq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4798D2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbeHCTxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:53:22 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:38832
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbeHCTxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsVeROvmixsQSA5c5LXPifn0lKBPPp+H/S6vIGu0UBw=;
 b=dQ/clLq75hBs2JAslYPDKUiE3//uWix4TSbTceVLxkhRAS/1aPVekZAJDBIRBN0/9yuMnOl0/+j3z+VzCRS9XEAx+EJH1xtvu9dasXgqv6/p1bcA5gBLzm7f8Sp86m9caIoFW670SHJXQdb/5o64X7OQ6p+fSarakeb1F4McWcM=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by BL0PR02MB4451.namprd02.prod.outlook.com (2603:10b6:208:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 17:53:53 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fg-6C; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-29; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-3V; Fri, 03 Aug 2018 10:53:43 -0700
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
Subject: [PATCH v11 00/11] drivers: Introduce firmware dnd clock river for ZynqMP core
Date:   Fri, 3 Aug 2018 10:53:17 -0700
Message-ID: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(438002)(199004)(189003)(6306002)(72206003)(7416002)(2906002)(186003)(8936002)(26005)(478600001)(316002)(2201001)(44832011)(966005)(5660300001)(6666003)(47776003)(476003)(54906003)(36386004)(2616005)(486006)(126002)(4326008)(106002)(16586007)(50226002)(36756003)(63266004)(110136005)(7696005)(51416003)(106466001)(356003)(107886003)(8676002)(336012)(81156014)(426003)(81166006)(39060400002)(77096007)(305945005)(48376002)(50466002)(9786002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4451;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT052;1:0yWe8mgZYmg12YBP0aLmRBUe3zfejMVdsnyABxiRKrA2S7l8NYpAxLN4qyfAx8v4gy4puUK+Oto/Zd3T9KkGeZ6CEsnsCbTUcuKwXRGw21AdcgKoIcZz6dF1oI3FV0IC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee4588a-02ba-4ecf-0e6c-08d5f96a1380
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4451;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;3:ABcPW3LQt7zlYqbhjhxhBNaN6XHN4ScEh9lHtXvgAFrDi86S45xPFQ9i8mRD3MksA+2F6g+cSrFmq5y85GLunBiiwXGuKDaKQfLfbeXGkB8WqetA6jYRO3eOaf2QjOFJeM/moz+wT6OfoTWWAC8XP7kD+kVx0ToUT1ZVFZvTMfDThugPkOAXQGWvyUM0WxgYhlWmylHXo79Vy3hgIsMDk0A7ezm2QL7nAQitTZqxx3A1roNybv43NrxfogjGsGeNlOFM1fCHK+l8Ivj+Q9jeW77kKdDy6mEgHy8ndqHn1afkPhy+P5p62E79+cd0rGwwwcwMvlTWGfNIp1lgeK1n5RRdVoBWtd5Wyp+xpEbboWg=;25:O7lHY9nYO9Gy2FWrzi03GlPJeAx1XwxB7Ycf/xaltVgZEDnY4mSBg/TjHnbSQ6B3XtA6SnPQyoQezQgYyFOb2Kgi72mQ44MXEoUuJ17YAIO29OhbBiJPAGmbjWqjnxHNMmVgkcxMmXosiY+YIm7nZCQQsUYhu0CsEKbzKSIfyaLchjref2cvi+/FuYQV3ouXCpkte5jSnO5ejYyublWOmwT9GPmz5AHq4n1rx3kqIr9OIc9fu58ZzIKGzM3mWnBBASRaqw0WrTe/JbD+uUKHA1qPa6luuAKFwuP9H6cKnWW6h26atQ3im62dd74fQbChonnzcEZd08D3zXhU+cUMuA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4451:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;31:ih9gvd6/lP0QN7JJ2ImvP7d1+hNjPTzRosd8SxevqCdoBXFu15ycmxPLCt/hCHqM5rgpsiw+SDkn0INwkZkYef0ma2kjYcTKVEb3SFTUlliaJCiDJskL7S+HU1pc497T4siIiKpiguOIzJaqZNTbNczemxvkOZY2hP/AAIqjLIf1H3eiipjwHFleduSiMm5/3qGABnTueYIw5TnueKqtEJkoYFRGE/i9zir3sENN+WY=;20:77Ku3ZZD/kXXBwhd63m3uf1pgBxSbHeOvuUza2zMR2LCTOvsNFcMvIlryeEa5JohVegQ7sa2fUnJUnQ3oULX1oRw3gy3t+Yf8Hhv0lkJqyKmbKujUai1Cvokcg8xVZWJv9WrE6PzLc47/dcDsiBXDiobPNqBVHzPTda9nqCQzz44g8+GUTjEQp2piYnzWFv9az6Z/N7cpEostzPv7jd5i4ECBi2o3xGYvA4RTFmiO/nKSptHLvhM/bmrKZEAlPF4Oax0MkaH7ryyHvISD+SmB21F9jrrIYeu2S74+kb+LR8d5BhBhUv22FSFhaRKXB/7T2PqtpOb2iIycKP5fX2QpKNpIsoSGWfYm2XcCfzdspSSvjpFAjv4PJvagH8O7xkCsNnSmpD/cQ0rrRY0fkcGhmS/1dwhTifC1ENDwyLKC3fqsiV2LSF0AEkOMzyT/bNLd7M1p4lbYcTYRBZRoFxAdJ94vGCB9p3RiCkfWzhCTmtXBeDXid30XfBiDVQttGGW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB445120A7805DF4FBD499AC99B8230@BL0PR02MB4451.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4451;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4451;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;4:FMhP0zJ5emNOxrl4Ejq7MDBCBUgPuTrHT8HMEa8aUHnqer4Use796FAHSnh/0T+ol531k3x5hZPZvA7ckMyw8iFuRChyWCwXPMxIq1iZRyXyZ6VGdUy9YahDbXPQRH2GBd89Uq0NAk/b/K8SPfq/Wkv98IApDV54DuT4AafKSFGWf5lW13LVG77l3RbtIQBymC0+/3QZnY11LUTVi6hdWmp1lHl2LNqQcEfPkF/UWJMnyQHugBCq12i+cFwO57cD994WgG+0l4jlqT0gQVO2bSshFl2eRXS3PKsKPo3fbfI4iQxLFNgKIV+I+delNGc9
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4451;23:IrKxW5eVWD0r7MMMQMKjBHg1FAqjaqXt//FJK3Nww?=
 =?us-ascii?Q?3SQV86l0iLher5hzAWiSuWeb+rclZ+aBxoeCfdI512VYqIX3b6gk919rO7o4?=
 =?us-ascii?Q?ORSavP6fNhKsj5c4B92zEV11g3OUJXdQq1tNgS4CGNHC5Wdfmv6WcRCv7HWO?=
 =?us-ascii?Q?Ht1zKP00mCV1xlbW+avOznksKCIiGaFkm8neiSsLVwJ0sHtT0zblEox/6t/Q?=
 =?us-ascii?Q?rsiPucLQ1CxGgyZ2DxtBasrDKZbg4VRYwur6u3CtRfyPsCgjmbq6/W/5n7LB?=
 =?us-ascii?Q?G9dZrbPbLr3hE0gWMHhG+Ht8oxaffl5zsn0qVuxcUwifg3o5fI8OjHCo6PG9?=
 =?us-ascii?Q?P3dbsyCOMWw6hixjOdelcA7kx/kOXu4bUxXYbpPKn3eis1oUHHgse3JSQcYR?=
 =?us-ascii?Q?npJOIL898qhEabCCChI07Z8ixR9yZD3lrt3mOkEY0WM0AjnRvj07HHl5P0rk?=
 =?us-ascii?Q?9ETO0MXEhz+lPepcRqAXsTkx0GfmRixrr1a6mEGuoftcbMrsPDnV1dbywjMl?=
 =?us-ascii?Q?dk+mzJ3sVWxhZWITg9dqfZRDdFD0Fa4Kqs0lkHAYITg2FsTWoVi/5P5kFdbq?=
 =?us-ascii?Q?usX8DMqcyNfcwY3qEHw6ea9fRxso6hjqNGPYpFD5WrTbzAMyKd4cFBvBuP6N?=
 =?us-ascii?Q?wwuCHQCUXjN2XWLQbsyLsVbGYzB7iIsgaa+C7B+Fr3ac1w8I4HBck1uRPYER?=
 =?us-ascii?Q?bEp8W2kp4DMeIn9DKjrtHoDOkVxnL/cimcPcrnlm3zPYqjQiLLAvpTWFGw+n?=
 =?us-ascii?Q?ycTZDtXq8dp7wu/nxtd3E54s1KUgNi9B1CWFOWPSWNZl3uIMbiXVNqdu9WcC?=
 =?us-ascii?Q?1+HWDPpkixu1ImgJLdXdZgC9uxvIFgWPK/78pne9J1VGqmnZvWHHz0sG1vk+?=
 =?us-ascii?Q?PXQ2BH0tkPBdajqSN7619kseW5GraLn2gs7YE/ukGFwoqMmVfFeW3NbGlrQE?=
 =?us-ascii?Q?5LKq+caEDV1UIWkr54mpRSDFN7NS+GCsLZ5H2XleeHxhrnXjq5agjT6wu7+W?=
 =?us-ascii?Q?j7hYMa4JeAIWS+q0hTBtczAxHXCAiDyjBhn2FM0IQMyGoFG7lblVgJnzKXI6?=
 =?us-ascii?Q?Bb1goJH23KoZ/uOrDsE1TayC6c0Dn7UzZOWhbBg0Hgarg6MHtlPSIprj54BB?=
 =?us-ascii?Q?bD9f/JSOymr6q2l87o/Xq1qQU11Fh2TbvzIQAhS3u4M/0/3E1pLNUuDQhZ3k?=
 =?us-ascii?Q?/2Ps47YgvkKuinXV9X0Qvy3tWTGtLJq3c1Eb19X164ssU5yJi+S7q0hfA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: FlwuDowxxVx4efNgrnW5C0jJdGonO7ARbJbTY6Vog6jj76vvxb2ymp1tTuxDc7wg5tz+DTSA8lBEsQYRe5KBjVtcnmIGutaDcEOaNgwLjMvIhreY917lq3MLBtAJlUPr5j25Fns8j6oV7jE/HFhSc0HJf2ZjedTmRHfoI9drE4zqwMKNzE7V0qQdzKV8XaX2pTnXzdLWYdUmer/YZ9PpT4coXO6JAIioYzWkmqMFXHm43oGcfJ7u75lZd/l/LqIm/hmrHAK6z3vQ6dOnT2HNgzaEwthDQ3BKIAJZmMgIId20po4YmSaqsF02C4M5UMA5mN8RgsAQ3tZ5b/arLe3nxCXklpo9bqjVboHZZdq2LHo=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4451;6:aSqKodDdwVxDHSd3NlKb/gG39jkGWxo1wQCRDfLjLgh1kVykyfu+K4M+sqJuqN7WSgSA6xBZUf9NbGY6sV4ScDEGpDI+dylrgYBk5Bz+axKpbk7i73KDp/w54Ke2a8qf04NDLrbVDWEJKu6g/nRRbucCMN2ML9/kYrZTAQJOl+NP7QVeX8Hr2JA9nI+tOtluI2H/kYfyNrQw8AOlWTA2E1OeMzCPM70PgxeSoU6PgnNMnT0XHzG3T059+h75sRKbSbrW+4yiTMSDobMXwhLlfUcittot/tmDZJ4NuAPw1qemD0abUj6lp2ttr0zp8/32ppascNTpnK8TTf0LoxcfEvUHD6JhtpP6XbQAC0gchGVcfI3fvrtmxr2dNhp7eJDsdXXfjv2IiHKEBSVVvgm4EsRDz7ESyZxqfhH3bi8mWe95tdTmZJAM3Yb34ZIR00bOhrqMX9UfpMbRQmaL4TyUAQ==;5:EQ8FRcnLLA7dzNREP+tmORyq95noMUuu2ntz50fPl+E9Rtrxw2BBx3Qo2oBWUDEb58I8TcD9AgGPHfmdVQdWbhCl4F+EyOGXJ9NtWas9gKL2MSda+6RbVBHmx/EkwYAQrAdFiB3C/zap9f5gIBv7krxqfw4if8M49kiJ629uwRQ=;7:iYJ2wclK932fFKBlgcFN4vI4GMRl0v2vH8ZDgV907KHszPO3asGEgsbn+K/ZR1mz+3Gfr5psAqnbUKOmljCo2wuHMiXWa+i3gU/eEYgHAbFahJPa4jBxqOsZWGJ/7SKc54cXZoDKNzUceUJlj5ESDvSIXkp+eIqN+5DNg2xgoqWAluQ6cGPCnSR6oinRC/ISFTOIpHEwuheva1CojWT0sqW2f2y4Mq+nbV64K36VdnJohyh1U0f/NKWACdWFgYsU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.5864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee4588a-02ba-4ecf-0e6c-08d5f96a1380
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is adding communication layer with firmware and clock driver who uses 
those APIs to communicate with PMU.
Firmware driver provides an interface to firmware APIs.Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.
This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries supported clock information from 
firmware and regiters pll and output clocks with CCF.

v11:
 - Removed "Reveiwed-by:Stephen Boyd" tag from firmware binding
 - Updated clock and firmware driver to use probe method instead of init
 - Marked PMU payload arguments with __le32 for proper endienness code
 
v10:
 - Incorporated code review comments from v9 patch series. Discussed below:
	https://patchwork.kernel.org/patch/10478575/
	https://patchwork.kernel.org/patch/10478457/
	https://patchwork.kernel.org/patch/10478461/
	https://patchwork.kernel.org/patch/10478463/
	
v9:
 - Fixed minor typo comments

v8:
 - Corrected typo in clk Kconfig
 
v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (10):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add zynqmp IOCTL API for device control
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for IOCTL API
  firmware: xilinx: Add debugfs for query data API
  dt-bindings: clock: Add bindings for ZynqMP clock driver
  firmware: xilinx: Replace init call with probe method

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
 drivers/firmware/xilinx/zynqmp.c                   | 535 +++++++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
 21 files changed, 2788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4

