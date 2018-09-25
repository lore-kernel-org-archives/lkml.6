Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FF42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QXEGjcmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FF42086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeIYS2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:28:52 -0400
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:55536
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729066AbeIYS2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umXHSgZvtWKZ7uqucOstE8I/oMz1KGarpSfxn2s0eZo=;
 b=QXEGjcmiLR25BDgb1p+HakeuEOYo4Cnyiw0hM5q+ffeUbKw8j4V3k5BhiEpdOULiM53FrpUqfjPxNOngz32lJzQ3382m+3C+q5oVfw8qb/KfE9jTCb9qN+dlPp014BacCxlLFLrtinck1YtuY4P3COkB30gOadRK+TfVAWAn8H8=
Received: from BN6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:405:60::48)
 by DM6PR02MB4763.namprd02.prod.outlook.com (2603:10b6:5:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Tue, 25 Sep
 2018 12:21:09 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN6PR02CA0107.outlook.office365.com
 (2603:10b6:405:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 12:21:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 25 Sep 2018 12:21:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKy-0008PE-76; Tue, 25 Sep 2018 05:21:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKt-0004sS-46; Tue, 25 Sep 2018 05:21:03 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8PCKwOx023037;
        Tue, 25 Sep 2018 05:20:58 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKn-0004mH-Aw; Tue, 25 Sep 2018 05:20:58 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 3/3] mtd: rawnand: arasan: Add support for Arasan NAND Flash Controller
Date:   Tue, 25 Sep 2018 17:50:31 +0530
Message-ID: <1537878031-22253-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(81156014)(81166006)(305945005)(8676002)(107886003)(8936002)(9786002)(4326008)(39060400002)(50226002)(5024004)(36756003)(14444005)(217873002)(478600001)(2906002)(50466002)(34290500001)(48376002)(63266004)(5660300001)(356003)(106466001)(316002)(6666003)(36386004)(76176011)(7696005)(486006)(106002)(54906003)(47776003)(110136005)(16586007)(2201001)(186003)(77096007)(51416003)(53946003)(26005)(2616005)(126002)(476003)(575784001)(446003)(11346002)(336012)(426003)(107986001)(579004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4763;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT016;1:RxjcrhZhPdHEyLK960tKrGinh2yCip9KsLTSSucJ5/lKatB2t/2u6gqx8Ou0vxhkoI5Pv7gILa3uTpPfPbU6XWES2d3S6R311M29BdIsi+sPjGbqYfKdtxj24ID2eYe5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b643c0f8-5223-40cc-4471-08d622e16020
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4763;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;3:R4gvfa90CELLBcrEzATmYBbc9leoStrWg3BrWs53sS9HvujEzHlMz+dIHCYuc+RD5SfV17xKzjn1u/UWEHscZLvp48SE22DhrKtiyjCAIVVbA3cJT21iBBjgp8f1k11OvqK7RlXx099MebHNiCZrRQzeYwRnpcYElkI9SkF9TORwIIlIL49ZQEQPYnElJWfzzoJPFFw1cF9KklaasSS6QGFK982pWPZmYlTzEz6lwF7iy/sGNYT5qSyvE+e5WmWH+OPvYXtwUs5ePOYaxTki+VLcB7zAgZeJ2fq5vC2od5tuT3dXC0Z2ZAr5on8lQFi5e7gkWkrlgD+riT3VvAnuzfDvD0u3cCskJOa6JMyAfDQ=;25:JWuzS2PuYCKAPtxWdH8Tc28hC0TbmrvJMyzhEygZoOcFDoh9T9USYZLnORWW6L/Mgt9yT8gjsax4KV3QRuPc0NOPqhU39DfW2i7EIhqbzRMbhKbuwg7rymB0eCfa0PCB5sWO+tc+dGHDetvN5ksqMuV1WKmqCzX2vAQEnumgZbNr5DZB7hIaandnFE1Py4Tl3L1Rar3pbZGoqywqsj5eG+7UQMb/zNU2a2q9gyA3TOecsSix0bornNDYpHuMmVud+MGaGWPGkIUq6Nkne/rC656f7wuk1VnXxGFgxcwaYwQ+Rbnf8BkCYI5nn0kduF6bngthemlAsjpYscSHJfoROg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4763:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;31:a5TVi6mSEqbTVZY+mb33AI2yNmRxdZQzNVM0tUJleqQ9CBDmFVw9CK42u8bm3vQz8shqUs6NwmC9me4Pu/V8o1me4e+eM95TeNDEqq6qvHy8pS81jy+wyaqwe5/20avgrlxBVxBeamjSHLyEiVNIxN8UKYnAdLNalQ+wrP89xvq7pNfdY1GyZxgHPOwWCsaPoW+jp4tW4+QwpGOdUV4fSnRzAA5S2ngPCttR2bRcQzE=;20:YKYQA99zegwvA8Q/Ykhi1e2STM6f5Om7WiAIG1XoqV+TiC8n9iS5fwVsU42RoBLFGlIpmU55mZWsQ51JqJzV35f3tonjwFNfwBgM+Ksy4gTb9Frq+Xc9cg9fvM3CL2vkBCklaebn4SID9c8PwX55oMYLrSkR4SuYyt7bDLcmMFbeF7z79/cX7x2nWBNs3FyhmbAiS9h0SxDnWvgV8CNX/NQ1kXETeMtJsO4IICbPDdAA32qehRmjmH11B/KEFVQ55kk9/5yBlXqDoZfY5T1mIvPlBYkEa828r4KT5l05/W0wo9JjcanP5V9mKWgbWZWe4wX3s78KGSog0LrZgBMrE/MW3ws0Fe0inH2nZtimlIhCVy5v9uTNX9X6UUm0AdVhiF4jskJESyEAt7CNHdH52fRjxMFBtAyshBgihdrFV+2u7Ouhx+DlXZv+VAERH/LoYgEEgEU1gO//eCeLUlew6qXChVs6XE9Hy25j1k+PHIqsMlYj1fKTh/ue1+LHn8gz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4763E78E5EEC2D65B04ACB08AF160@DM6PR02MB4763.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(788757137089)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4763;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4763;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;4:FV4qIIghV9nTgulQDTWPcUT8B9DODIypxZ/zhauCov6Ew9ojCOle76R64VKrI6DzMh1wk400MdbHZ5oLcv5sa+GV825mWM2u/X2cY8pyR4Jf9uGneWfbRHiM+PMTXukDcaUPDKlfOjBpnJWCbVON/opUDwBUQCab5hVZmC1JbY9eWEjS7x2rUD/zXoiit0rsmICrHcABw2F1d60gWyuv7Z3WVsv75DS1mwzvk7uYq/rv6zmX3EhQT0LQ++9Jomzz+pxkc6OPCrDJTc6VZmRru71QJFN3lZGK4G/De9mQ1bE1zSEeUhvCSqOE/lAF+V3NzewTjRRWpOFk9CusgiPLVBhIxFsdQe0+xGwlB1DkEjr2QQRw4A3LFG6R0A7qBhwG
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4763;23:9ubkTltPhFn/zvwWfale3MKe23lE0k2fXG+Ay5IGE?=
 =?us-ascii?Q?Pac6CxFH0vvv1abw0qtJfSx9kMS9l//1uHvsHTDQVgag606RfJjgTLMUcF09?=
 =?us-ascii?Q?p3B8HqL3xNnheQKMoXPmUqGMJ0k4bO8ud+yFNIDFfWg0o7mztnhtwlYUeHva?=
 =?us-ascii?Q?+nopy7rp+pHvRphaf4Q11gSgPxZQrLi3iGESvZDF52rFBNWej8GlVqndXJmo?=
 =?us-ascii?Q?T7BXDXipcUDx6AN/dwWG9GeKzxfvpoh7OladfhGhIv+H3e516YU0aEb2Zjvz?=
 =?us-ascii?Q?4mc4kkn42oTEPH/1Qab4BxJz4cNqj8ehlKAw32vyet+wwH9qJw39UmUzWEsM?=
 =?us-ascii?Q?MSRgIHnRnfmSYWTpdXDD4p48SNaTr9DRdtbSeZnGbcSCuKhDLkA+A+1reUrB?=
 =?us-ascii?Q?Obre7wzG3gLZJNhh6nAvgHvuariLJy3RUfsCInWvy+kCRkutnIRhN41ij6c9?=
 =?us-ascii?Q?jEgHkO/KJd3dUKqKoQFR7fUuADUTIAyrAZ21mGWVGokneMQvAUDLFnHdsZW5?=
 =?us-ascii?Q?cUKsoEgEXDtVE2/S6CNghbo9lWHXTJQ11i5AkiwoD8ZbYUbJquRJ43q5v+js?=
 =?us-ascii?Q?J/5WdOcPtI/n1JE+naoo6jIE44RcQ/qmJ/4UABYjfINrf0qwA51VML144UQv?=
 =?us-ascii?Q?3gv0puVnHNuf5MpWKDbrNJbxkYN3p1z+An8E479m/KdpT+6nIHwxJwqx8204?=
 =?us-ascii?Q?+41yddbSX79AY0X1ZFPRQlwRouLzTfetUrvhDgeRmetz0EPRpbfKPTvurrNJ?=
 =?us-ascii?Q?Bxf8S/CLHfOSFcNd9gRphjnVpBY/X8XiWfQp67FAO6zliHuBkvF2sw6V4MSx?=
 =?us-ascii?Q?QyqqJk4ycNCQl7pqZU6XmxSHRg/k0rvi13m8ablG7e910CWqPnb/i7AiJ8oF?=
 =?us-ascii?Q?rzlToxScMfbKzlwJdRydlJzjM6GFpqoZtpxrrU2t8n9F6JJ4Z/eyeNpjdD3C?=
 =?us-ascii?Q?7ya7VYI7Zr3nhtXzqT7Og+pE0HfMKjimG1NCbsrJ1P3a0vXsTMH0dFNGH4CW?=
 =?us-ascii?Q?S18VXhWtewHW7OT9qFoJk9qLOKIQ9/m1WgtWygbKMAKgZU0DPTYvCAZJ7YT/?=
 =?us-ascii?Q?+Muprlba/XUfPBnAsikWGTmOdzfoLFEvcMHnAWAYW+xtw0ZZD6PSNJdaU2wE?=
 =?us-ascii?Q?Z5A8lf76Ksdtxq25repdh10rH5SkGK9Wp44FIMt4eMvOoB9eMFwY+J5xUg9y?=
 =?us-ascii?Q?MypkmOWQHBUrVcRQSoyC02tx+66v3DybvfsvQAlrgRb1DxrATZuFH+y7daxu?=
 =?us-ascii?Q?Mj1UbpC9O1LaPDqYO/SFg8tv/7sDG1+0ayfSIIDdSZaKPHCdVzo7EqPQ9nnY?=
 =?us-ascii?Q?s704C5SI/1wG92aOjfxEaO1kagYg+JYHZdLiZ8kmor+ur8TA+qT0x/Dih80q?=
 =?us-ascii?Q?tAE+nWppPYm5fWLpl6ENqy7Rbww+OCU3WFSUMHEWQtqTIkG?=
X-Microsoft-Antispam-Message-Info: bRPxeG03F8q57y4bkzlm9KAdPzthJp1ClWJExMH7nOWHK2/bBhp4XP2Wiyfjye1GyCKEspU4zZ7YkhGdhqDC963AMRTJjNicKWUY55hjLlyse2JWPQ+UJ4rys6yxIkUwUWohKX3Du0msFqHfyuetRaUAil2gk3JGxMPCQ7ht6WU8cFJ2yXt7rdeE9VVsjnILt45Mg7d0zY/cJeMlHcfkk4F5DrY+TjX2ywwb69TNjX/QD9LYK9EfKDjPvoVs0+Wbx/crcO4KlHmCbtyGJSZjoQF7AAHwkZSyWOdt4e3EprLrW6z63z2hJZIU7BGcWkmomVMRGoVpcJpslNzgEh6DwiK9SDTyGKjAdjv3G9tB0YY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;6:YOOL88nqCd6RFjxGXLHQXA6TTYcFIJaBPDjtodMnz1WPaYvriV/nYWbYvukVVXkmONAH58A4ZKaXZAaZm3aUDxTwBzmlUY3Shy4YvqOA5n3AY6Jp0s2+Rqj2PlO5YKmrlP/U+31z8Te5blBupTZHPu1+qGhaztlHz7ToBIT1hsWf7YcSfo3mSHvVBKgAFk1Qh3rsAWCmKU7VvoIutvFYtx6nXqlDJlZjPOCmXtxcb4cHLYzl5JH6JtakAN5HiM10+ISV7pHShSdUHSPP0vi/30JxLvoT1P2+zAEd7iwAW20Z5nKQ2cqYiKcVPpLkxi4tvWaamW5Tru5zqEQGz1OBgkQK463k08JXBZ9PfsiVlf1QRf3R4gT28uxTULBK3uhdA/9MmQCJ1Tn98qGuy0ZlRW3rauFWQBEd5YgpXjxEvmOdeKFX1/QXShTjLbSiQghLul8DlasQsduigUAGlyRfdw==;5:xSIJlhffbrOcMPw8ajbBDPnTndtm7ev9L/+huBxelMw2656Ftbu3B4nLtX8vdoi/ov2u5/VBY/014eOoB782/pJ93w/1yafIse5iV4TbcGWrE8NWCoSu/3SYuaLeZajLda4RhjXQu89r2JQxg/0I/zamvj12cQpYrZK4nOpyat4=;7:Df5cWg3kjDxVqLjEo0EoBb3erzRbseAlloX3sXQj73wK4zhRCSyfuAvNUhBEGilpjackIjsU+3T7dwq7g7IYO/OLjTs29fgXGMN32E3kMkwBRHbZ0vYAWhQE5WcINfHYwfiYPoBvh4yRQ+36kMGLteo0zWflgILCe/bsaGByJldjnTHE5yFJ2yDsI00tl4xLwQ2iCxjqDgnQG8akA0ujKiMy8v7xZ3zOa76hR48dOGq6JTMdYe5OAew308p8ajn1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 12:21:09.1310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b643c0f8-5223-40cc-4471-08d622e16020
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the basic driver for Arasan NAND Flash Controller used in
Zynq UltraScale+ MPSoC. It supports HW ECC and upto 24bit correction

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v11:
Fixed the below commits given by Boris
 - implemented separate hooks for each pattern
 - Changed EVNT_TIMEOUT_MSEC to EVENT_TIMEOUT_MSEC
 - Grouped register offsets with theri fields, previously
   there are defines at randome positions
 - changes cmnds to cmds and s32 to u32
 - Removed unnecessary fields from struct anfc_op
 - Renamed bch and bchmode to strength and ecc_strength respectively
 - Passed nand_chip object direclty to all functions
 - Replace is_vmalloc_addr() with virt_addr_valid()
 - Use default routines for read/write_oob()
 - Added core support to get sdr timing mode value
Changes in v10:
 - Implemented ->exec_op() interface.
 - Converted the driver to nand_scan().
Changes in v9:
 - Added the SPDX tags
Changes in v8:
 - Implemented setup_data_interface hook
 - fixed checkpatch --strict warnings
 - Added anfc_config_ecc in read_page_hwecc
 - Fixed returning status value by reading flash status in read_byte()
   instead of reading previous value.
Changes in v7:
- Implemented Marek suggestions and comments
- Corrected the acronyms those should be in caps
- Modified kconfig/Make file to keep arasan entry in sorted order
- Added is_vmlloc_addr check
- Used ioread/write32_rep variants to avoid compilation error for intel
  platforms
- separated PIO and DMA mode read/write functions
- Minor cleanup
Chnages in v6:
- Addressed most of the Brian and Boris comments
- Separated the nandchip from the nand controller
- Removed the ecc lookup table from driver
- Now use framework nand waitfunction and readoob
- Fixed the compiler warning
- Adapted the new frameowrk changes related to ecc and ooblayout
- Disabled the clocks after the nand_reelase
- Now using only one completion object
- Boris suggessions like adapting cmd_ctrl and rework on read/write byte
  are not implemented and i will patch them later
- Also check_erased_ecc_chunk for erase and check for is_vmalloc_addr will
  implement later once the basic driver is mainlined.
Changes in v5:
- Renamed the driver filei as arasan_nand.c
- Fixed all comments relaqted coding style
- Fixed comments related to propagating the errors
- Modified the anfc_write_page_hwecc as per the write_page
  prototype
Changes in v4:
- Added support for onfi timing mode configuration
- Added clock supppport
- Added support for multiple chipselects
Changes in v3:
- Removed unused variables
- Avoided busy loop and used jifies based implementation
- Fixed compiler warnings "right shift count >= width of type"
- Removed unneeded codei and improved error reporting
- Added onfi version check to ensure reading the valid address cycles
Changes in v2:
- Added missing of.h to avoid kbuild system report erro
---
 drivers/mtd/nand/raw/Kconfig       |    7 +
 drivers/mtd/nand/raw/Makefile      |    1 +
 drivers/mtd/nand/raw/arasan_nand.c | 1324 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1332 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/arasan_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b6738ec..0fadecb 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -560,4 +560,11 @@ config MTD_NAND_TEGRA
 	  is supported. Extra OOB bytes when using HW ECC are currently
 	  not supported.
 
+config MTD_NAND_ARASAN
+	tristate "Support for Arasan Nand Flash controller"
+	depends on HAS_IOMEM &&  HAS_DMA
+	help
+	  Enables the driver for the Arasan Nand Flash controller on
+	  Zynq Ultrascale+ MPSoC.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index d5a5f98..ccb8d56 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
+obj-$(CONFIG_MTD_NAND_ARASAN)		+= arasan_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_amd.o
diff --git a/drivers/mtd/nand/raw/arasan_nand.c b/drivers/mtd/nand/raw/arasan_nand.c
new file mode 100644
index 0000000..8c24fac
--- /dev/null
+++ b/drivers/mtd/nand/raw/arasan_nand.c
@@ -0,0 +1,1324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arasan NAND Flash Controller Driver
+ *
+ * Copyright (C) 2014 - 2017 Xilinx, Inc.
+ * Author: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define EVENT_TIMEOUT_MSEC	1000
+
+#define PKT_OFST		0x00
+#define PKT_CNT_SHIFT		12
+
+#define MEM_ADDR1_OFST		0x04
+#define MEM_ADDR2_OFST		0x08
+#define PG_ADDR_SHIFT		16
+#define BCH_MODE_SHIFT		25
+#define MEM_ADDR_MASK		GENMASK(7, 0)
+#define BCH_MODE_MASK		GENMASK(27, 25)
+#define CS_MASK			GENMASK(31, 30)
+#define CS_SHIFT		30
+
+#define CMD_OFST		0x0C
+#define ECC_ENABLE		BIT(31)
+#define DMA_EN_MASK		GENMASK(27, 26)
+#define DMA_ENABLE		0x2
+#define DMA_EN_SHIFT		26
+#define REG_PAGE_SIZE_SHIFT	23
+
+#define PROG_OFST		0x10
+#define PROG_PGRD		BIT(0)
+#define PROG_ERASE		BIT(2)
+#define PROG_STATUS		BIT(3)
+#define PROG_PGPROG		BIT(4)
+#define PROG_RDID		BIT(6)
+#define PROG_RDPARAM		BIT(7)
+#define PROG_RST		BIT(8)
+#define PROG_GET_FEATURE	BIT(9)
+#define PROG_SET_FEATURE	BIT(10)
+
+#define INTR_STS_EN_OFST	0x14
+#define INTR_SIG_EN_OFST	0x18
+#define XFER_COMPLETE		BIT(2)
+#define READ_READY		BIT(1)
+#define WRITE_READY		BIT(0)
+#define MBIT_ERROR		BIT(3)
+#define EVENT_MASK	(XFER_COMPLETE | READ_READY | WRITE_READY | MBIT_ERROR)
+
+#define INTR_STS_OFST		0x1C
+#define READY_STS_OFST		0x20
+#define DMA_ADDR1_OFST		0x24
+#define FLASH_STS_OFST		0x28
+#define DATA_PORT_OFST		0x30
+#define ECC_OFST		0x34
+#define BCH_EN_SHIFT		27
+#define ECC_SIZE_SHIFT		16
+
+#define ECC_ERR_CNT_OFST	0x38
+#define PAGE_ERR_CNT_MASK	GENMASK(16, 8)
+#define PKT_ERR_CNT_MASK	GENMASK(7, 0)
+
+#define ECC_SPR_CMD_OFST	0x3C
+#define CMD2_SHIFT		8
+#define ADDR_CYCLES_SHIFT	28
+
+#define ECC_ERR_CNT_1BIT_OFST	0x40
+#define ECC_ERR_CNT_2BIT_OFST	0x44
+#define DMA_ADDR0_OFST		0x50
+#define DATA_INTERFACE_OFST	0x6C
+#define ANFC_MAX_CHUNK_SIZE	0x4000
+#define ANFC_MAX_ADDR_CYCLES	7
+
+#define REG_PAGE_SIZE_512	0
+#define REG_PAGE_SIZE_1K	5
+#define REG_PAGE_SIZE_2K	1
+#define REG_PAGE_SIZE_4K	2
+#define REG_PAGE_SIZE_8K	3
+#define REG_PAGE_SIZE_16K	4
+
+#define TEMP_BUF_SIZE		1024
+#define SDR_MODE_PACKET_SIZE	4
+
+#define SDR_MODE_DEFLT_FREQ	80000000
+#define COL_ROW_ADDR(pos, val)	(((val) & 0xFF) << (8 * (pos)))
+
+struct anfc_op {
+	u32 cmds[4];
+	u32 len;
+	u32 col;
+	u32 row;
+	unsigned int data_instr_idx;
+	const struct nand_op_instr *data_instr;
+};
+
+/**
+ * struct anfc_nand_chip - Defines the nand chip related information
+ * @node:		Used to store NAND chips into a list.
+ * @chip:		NAND chip information structure.
+ * @strength:		Bch or Hamming mode enable/disable.
+ * @ecc_strength:	Ecc strength 4.8/12/16.
+ * @eccval:		Ecc config value.
+ * @raddr_cycles:	Row address cycle information.
+ * @caddr_cycles:	Column address cycle information.
+ * @pktsize:		Packet size for read / write operation.
+ * @csnum:		chipselect number to be used.
+ * @spktsize:		Packet size in ddr mode for status operation.
+ * @inftimeval:		Data interface and timing mode information
+ */
+struct anfc_nand_chip {
+	struct list_head node;
+	struct nand_chip chip;
+	bool strength;
+	u32 ecc_strength;
+	u32 eccval;
+	u16 raddr_cycles;
+	u16 caddr_cycles;
+	u32 pktsize;
+	int csnum;
+	u32 spktsize;
+	u32 inftimeval;
+};
+
+/**
+ * struct anfc_nand_controller - Defines the Arasan NAND flash controller
+ *				 driver instance
+ * @controller:		base controller structure.
+ * @chips:		list of all nand chips attached to the ctrler.
+ * @dev:		Pointer to the device structure.
+ * @base:		Virtual address of the NAND flash device.
+ * @curr_cmd:		Current command issued.
+ * @clk_sys:		Pointer to the system clock.
+ * @clk_flash:		Pointer to the flash clock.
+ * @dma:		Dma enable/disable.
+ * @buf:		Buffer used for read/write byte operations.
+ * @irq:		irq number
+ * @bufshift:		Variable used for indexing buffer operation
+ * @csnum:		Chip select number currently inuse.
+ * @event:		Completion event for nand status events.
+ * @status:		Status of the flash device.
+ * @prog:		Used to initiate controller operations.
+ */
+struct anfc_nand_controller {
+	struct nand_controller controller;
+	struct list_head chips;
+	struct device *dev;
+	void __iomem *base;
+	int curr_cmd;
+	struct clk *clk_sys;
+	struct clk *clk_flash;
+	int irq;
+	int csnum;
+	struct completion event;
+	int status;
+	u32 prog;
+	u8 buf[TEMP_BUF_SIZE];
+};
+
+static int anfc_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+
+	if (section >= nand->ecc.steps)
+		return -ERANGE;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = nand->ecc.total;
+	oobregion->offset = mtd->oobsize - oobregion->length;
+
+	return 0;
+}
+
+static int anfc_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+
+	if (section >= nand->ecc.steps)
+		return -ERANGE;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 2;
+	oobregion->length = mtd->oobsize - nand->ecc.total - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops anfc_ooblayout_ops = {
+	.ecc = anfc_ooblayout_ecc,
+	.free = anfc_ooblayout_free,
+};
+
+static inline struct anfc_nand_chip *to_anfc_nand(struct nand_chip *nand)
+{
+	return container_of(nand, struct anfc_nand_chip, chip);
+}
+
+static inline struct anfc_nand_controller *to_anfc(struct nand_controller *ctrl)
+{
+	return container_of(ctrl, struct anfc_nand_controller, controller);
+}
+
+static u8 anfc_page(u32 pagesize)
+{
+	switch (pagesize) {
+	case 512:
+		return REG_PAGE_SIZE_512;
+	case 1024:
+		return REG_PAGE_SIZE_1K;
+	case 2048:
+		return REG_PAGE_SIZE_2K;
+	case 4096:
+		return REG_PAGE_SIZE_4K;
+	case 8192:
+		return REG_PAGE_SIZE_8K;
+	case 16384:
+		return REG_PAGE_SIZE_16K;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static inline void anfc_enable_intrs(struct anfc_nand_controller *nfc, u32 val)
+{
+	writel(val, nfc->base + INTR_STS_EN_OFST);
+	writel(val, nfc->base + INTR_SIG_EN_OFST);
+}
+
+static inline void anfc_config_ecc(struct anfc_nand_controller *nfc, bool on)
+{
+	u32 val;
+
+	val = readl(nfc->base + CMD_OFST);
+	if (on)
+		val |= ECC_ENABLE;
+	else
+		val &= ~ECC_ENABLE;
+	writel(val, nfc->base + CMD_OFST);
+}
+
+static inline void anfc_config_dma(struct anfc_nand_controller *nfc, int on)
+{
+	u32 val;
+
+	val = readl(nfc->base + CMD_OFST);
+	val &= ~DMA_EN_MASK;
+	if (on)
+		val |= DMA_ENABLE << DMA_EN_SHIFT;
+	writel(val, nfc->base + CMD_OFST);
+}
+
+static inline int anfc_wait_for_event(struct anfc_nand_controller *nfc)
+{
+	return wait_for_completion_timeout(&nfc->event,
+					msecs_to_jiffies(EVENT_TIMEOUT_MSEC));
+}
+
+static inline void anfc_setpktszcnt(struct anfc_nand_controller *nfc,
+				    u32 pktsize, u32 pktcount)
+{
+	writel(pktsize | (pktcount << PKT_CNT_SHIFT), nfc->base + PKT_OFST);
+}
+
+static inline void anfc_set_eccsparecmd(struct anfc_nand_controller *nfc,
+					struct anfc_nand_chip *achip, u8 cmd1,
+					u8 cmd2)
+{
+	writel(cmd1 | (cmd2 << CMD2_SHIFT) |
+	       (achip->caddr_cycles << ADDR_CYCLES_SHIFT),
+	       nfc->base + ECC_SPR_CMD_OFST);
+}
+
+static void anfc_setpagecoladdr(struct anfc_nand_controller *nfc, u32 page,
+				u16 col)
+{
+	u32 val;
+
+	writel(col | (page << PG_ADDR_SHIFT), nfc->base + MEM_ADDR1_OFST);
+
+	val = readl(nfc->base + MEM_ADDR2_OFST);
+	val = (val & ~MEM_ADDR_MASK) |
+	      ((page >> PG_ADDR_SHIFT) & MEM_ADDR_MASK);
+	writel(val, nfc->base + MEM_ADDR2_OFST);
+}
+
+static void anfc_prepare_cmd(struct anfc_nand_controller *nfc, u8 cmd1,
+			     u8 cmd2, u8 dmamode,
+			     u32 pagesize, u8 addrcycles)
+{
+	u32 regval;
+
+	regval = cmd1 | (cmd2 << CMD2_SHIFT);
+	if (dmamode)
+		regval |= DMA_ENABLE << DMA_EN_SHIFT;
+	regval |= addrcycles << ADDR_CYCLES_SHIFT;
+	regval |= anfc_page(pagesize) << REG_PAGE_SIZE_SHIFT;
+	writel(regval, nfc->base + CMD_OFST);
+}
+
+static void anfc_rw_dma_op(struct mtd_info *mtd, u8 *buf, int len,
+			   bool do_read, u32 prog, int pktcount, int pktsize)
+{
+	dma_addr_t paddr;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 eccintr = 0, dir;
+
+	if (pktsize == 0)
+		pktsize = len;
+
+	anfc_setpktszcnt(nfc, pktsize, pktcount);
+
+	if (!achip->strength)
+		eccintr = MBIT_ERROR;
+
+	if (do_read)
+		dir = DMA_FROM_DEVICE;
+	else
+		dir = DMA_TO_DEVICE;
+
+	paddr = dma_map_single(nfc->dev, buf, len, dir);
+	if (dma_mapping_error(nfc->dev, paddr)) {
+		dev_err(nfc->dev, "Read buffer mapping error");
+		return;
+	}
+	writel(paddr, nfc->base + DMA_ADDR0_OFST);
+	writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
+	anfc_enable_intrs(nfc, (XFER_COMPLETE | eccintr));
+	writel(prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+	dma_unmap_single(nfc->dev, paddr, len, dir);
+}
+
+static void anfc_rw_pio_op(struct mtd_info *mtd, u8 *buf, int len,
+			   bool do_read, int prog, int pktcount, int pktsize)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 *bufptr = (u32 *)buf;
+	u32 cnt = 0, intr = 0;
+
+	anfc_config_dma(nfc, 0);
+
+	if (pktsize == 0)
+		pktsize = len;
+
+	anfc_setpktszcnt(nfc, pktsize, pktcount);
+
+	if (!achip->strength)
+		intr = MBIT_ERROR;
+
+	if (do_read)
+		intr |= READ_READY;
+	else
+		intr |= WRITE_READY;
+
+	anfc_enable_intrs(nfc, intr);
+	writel(prog, nfc->base + PROG_OFST);
+	while (cnt < pktcount) {
+		anfc_wait_for_event(nfc);
+		cnt++;
+		if (cnt == pktcount)
+			anfc_enable_intrs(nfc, XFER_COMPLETE);
+		if (do_read)
+			ioread32_rep(nfc->base + DATA_PORT_OFST, bufptr,
+				     pktsize / 4);
+		else
+			iowrite32_rep(nfc->base + DATA_PORT_OFST, bufptr,
+				      pktsize / 4);
+		bufptr += (pktsize / 4);
+		if (cnt < pktcount)
+			anfc_enable_intrs(nfc, intr);
+	}
+	anfc_wait_for_event(nfc);
+}
+
+static void anfc_read_data_op(struct nand_chip *chip, u8 *buf, int len,
+			      int pktcount, int pktsize)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (virt_addr_valid(buf))
+		anfc_rw_dma_op(mtd, buf, len, 1, PROG_PGRD, pktcount, pktsize);
+	else
+		anfc_rw_pio_op(mtd, buf, len, 1, PROG_PGRD, pktcount, pktsize);
+}
+
+static void anfc_write_data_op(struct nand_chip *chip, const u8 *buf,
+			       int len, int pktcount, int pktsize)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (virt_addr_valid(buf))
+		anfc_rw_dma_op(mtd, (char *)buf, len, 0, PROG_PGPROG, pktcount,
+			       pktsize);
+	else
+		anfc_rw_pio_op(mtd, (char *)buf, len, 0, PROG_PGPROG, pktcount,
+			       pktsize);
+}
+
+static int anfc_read_page_hwecc(struct mtd_info *mtd,
+				struct nand_chip *chip, u8 *buf,
+				int oob_required, int page)
+{
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u8 *ecc_code = chip->ecc.code_buf;
+	u8 *p;
+	int eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int stat = 0, i;
+	u32 ret;
+	unsigned int max_bitflips = 0;
+	u32 eccsteps;
+	u32 one_bit_err = 0, multi_bit_err = 0;
+
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDOUT, NAND_CMD_RNDOUTSTART);
+	anfc_config_ecc(nfc, true);
+	anfc_read_data_op(chip, buf, mtd->writesize,
+			  DIV_ROUND_UP(mtd->writesize, achip->pktsize),
+			  achip->pktsize);
+
+	if (achip->strength) {
+		/*
+		 * In BCH mode Arasan NAND controller can correct ECC upto
+		 * 24-bit Beyond that, it can't even detect errors.
+		 */
+		multi_bit_err = readl(nfc->base + ECC_ERR_CNT_OFST);
+		multi_bit_err = ((multi_bit_err & PAGE_ERR_CNT_MASK) >> 8);
+	} else {
+		/*
+		 * In Hamming mode Arasan NAND controller can correct ECC upto
+		 * 1-bit and can detect upto 4-bit errors.
+		 */
+		one_bit_err = readl(nfc->base + ECC_ERR_CNT_1BIT_OFST);
+		multi_bit_err = readl(nfc->base + ECC_ERR_CNT_2BIT_OFST);
+
+		/* Clear ecc error count register 1Bit, 2Bit */
+		writel(0x0, nfc->base + ECC_ERR_CNT_1BIT_OFST);
+		writel(0x0, nfc->base + ECC_ERR_CNT_2BIT_OFST);
+	}
+
+	anfc_config_ecc(nfc, false);
+
+	if (oob_required)
+		chip->ecc.read_oob(mtd, chip, page);
+
+	if (multi_bit_err || one_bit_err) {
+		if (!oob_required)
+			chip->ecc.read_oob(mtd, chip, page);
+
+		mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
+					   chip->ecc.total);
+		eccsteps = chip->ecc.steps;
+		p = buf;
+		for (i = 0 ; eccsteps; eccsteps--, i += eccbytes,
+		     p += eccsize) {
+			stat = nand_check_erased_ecc_chunk(p,
+							   chip->ecc.size,
+							   &ecc_code[i],
+							   eccbytes,
+							   NULL, 0,
+							   chip->ecc.strength);
+			if (stat < 0) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += stat;
+				max_bitflips = max_t(unsigned int, max_bitflips,
+						     stat);
+			}
+		}
+	}
+
+	return max_bitflips;
+}
+
+static int anfc_write_page_hwecc(struct mtd_info *mtd,
+				 struct nand_chip *chip, const u8 *buf,
+				 int oob_required, int page)
+{
+	int ret;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+
+	ret = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDIN, 0);
+	anfc_config_ecc(nfc, true);
+	anfc_write_data_op(chip, buf, mtd->writesize,
+			   DIV_ROUND_UP(mtd->writesize, achip->pktsize),
+			   achip->pktsize);
+
+	if (oob_required)
+		chip->ecc.write_oob(mtd, chip, page);
+
+	anfc_config_ecc(nfc, false);
+
+	return 0;
+}
+
+static int anfc_ecc_init(struct mtd_info *mtd,
+			 struct nand_ecc_ctrl *ecc, int ecc_mode)
+{
+	u32 ecc_addr;
+	unsigned int ecc_strength, steps;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+
+	ecc->mode = NAND_ECC_HW;
+	ecc->read_page = anfc_read_page_hwecc;
+	ecc->write_page = anfc_write_page_hwecc;
+
+	mtd_set_ooblayout(mtd, &anfc_ooblayout_ops);
+
+	steps = mtd->writesize / chip->ecc_step_ds;
+
+	switch (chip->ecc_strength_ds) {
+	case 12:
+		ecc_strength = 0x1;
+		break;
+	case 8:
+		ecc_strength = 0x2;
+		break;
+	case 4:
+		ecc_strength = 0x3;
+		break;
+	case 24:
+		ecc_strength = 0x4;
+		break;
+	default:
+		ecc_strength = 0x0;
+	}
+	if (!ecc_strength)
+		ecc->total = 3 * steps;
+	else
+		ecc->total =
+		     DIV_ROUND_UP(fls(8 * chip->ecc_step_ds) *
+			 chip->ecc_strength_ds * steps, 8);
+
+	ecc->strength = chip->ecc_strength_ds;
+	ecc->size = chip->ecc_step_ds;
+	ecc->bytes = ecc->total / steps;
+	ecc->steps = steps;
+	achip->ecc_strength = ecc_strength;
+	achip->strength = achip->ecc_strength;
+	ecc_addr = mtd->writesize + (mtd->oobsize - ecc->total);
+	achip->eccval = ecc_addr | (ecc->total << ECC_SIZE_SHIFT) |
+			(achip->strength << BCH_EN_SHIFT);
+
+	if (chip->ecc_step_ds >= 1024)
+		achip->pktsize = 1024;
+	else
+		achip->pktsize = 512;
+
+	return 0;
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void anfc_parse_instructions(struct nand_chip *chip,
+				    const struct nand_subop *subop,
+				    struct anfc_op *nfc_op)
+{
+	const struct nand_op_instr *instr = NULL;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id;
+	int i = 0;
+	const u8 *addrs;
+
+	memset(nfc_op, 0, sizeof(struct anfc_op));
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		unsigned int naddrs;
+
+		instr = &subop->instrs[op_id];
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			if (op_id)
+				nfc_op->cmds[1] = instr->ctx.cmd.opcode;
+			else
+				nfc_op->cmds[0] = instr->ctx.cmd.opcode;
+			nfc->curr_cmd = nfc_op->cmds[0];
+
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			i = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop,
+							     op_id);
+			addrs = &instr->ctx.addr.addrs[i];
+
+			for (; i < naddrs; i++) {
+				u8 val = instr->ctx.addr.addrs[i];
+
+				if (nfc_op->cmds[0] == NAND_CMD_ERASE1) {
+					nfc_op->row |= COL_ROW_ADDR(i, val);
+				} else {
+					if (i < 2)
+						nfc_op->col |= COL_ROW_ADDR(i,
+									val);
+					else
+						nfc_op->row |= COL_ROW_ADDR(i -
+									2, val);
+				}
+			}
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->data_instr_idx = op_id;
+			break;
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->data_instr_idx = op_id;
+			break;
+		case NAND_OP_WAITRDY_INSTR:
+			break;
+		}
+	}
+}
+
+static int anfc_reset_cmd_type_exec(struct nand_chip *chip,
+				    const struct nand_subop *subop)
+{
+	struct anfc_op nfc_op = {};
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], 0, 0, 0, 0);
+	nfc->prog = PROG_RST;
+	anfc_enable_intrs(nfc, XFER_COMPLETE);
+	writel(nfc->prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+
+	return 0;
+}
+
+static int anfc_read_id_type_exec(struct nand_chip *chip,
+				  const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_op nfc_op = {};
+	unsigned int op_id, len;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], 0, 0, 0, 1);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+	nfc->prog = PROG_RDID;
+	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 1, PROG_RDID, 1, 0);
+	memcpy(instr->ctx.data.buf.in, nfc->buf, len);
+
+	return 0;
+}
+
+static int anfc_read_status_exec(struct nand_chip *chip,
+				 const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_op nfc_op = {};
+	unsigned int op_id, len;
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], 0, 0, 0, 0);
+	anfc_setpktszcnt(nfc, achip->spktsize / 4, 1);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+	nfc->prog = PROG_STATUS;
+
+	anfc_enable_intrs(nfc, XFER_COMPLETE);
+	writel(nfc->prog, nfc->base + PROG_OFST);
+	anfc_wait_for_event(nfc);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+
+	/*
+	 * The Arasan NAND controller will update the status value
+	 * returned by the flash device in FLASH_STS register.
+	 */
+	nfc->status = readl(nfc->base + FLASH_STS_OFST);
+	memcpy(instr->ctx.data.buf.in, &nfc->status, len);
+
+	return 0;
+}
+
+static int anfc_erase_and_zero_len_page_read_type_exec(struct nand_chip *chip,
+						       const struct nand_subop
+						       *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 dma_mode = 0, write_size = 0, addrcycles = 0, len, op_id;
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	if (nfc_op.cmds[0] == NAND_CMD_ERASE1) {
+		nfc->prog = PROG_ERASE;
+		addrcycles = achip->raddr_cycles;
+		write_size = 0;
+		dma_mode = 0;
+		nfc_op.col = nfc_op.row & 0xffff;
+		nfc_op.row = (nfc_op.row >> PG_ADDR_SHIFT) & 0xffff;
+	}
+	if (nfc_op.cmds[0] == NAND_CMD_READ0) {
+		nfc->prog = PROG_PGRD;
+		addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+		write_size = mtd->writesize;
+		dma_mode = 1;
+	}
+
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], nfc_op.cmds[1], dma_mode,
+			 write_size, addrcycles);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	if (nfc_op.cmds[0] == NAND_CMD_ERASE1) {
+		anfc_enable_intrs(nfc, XFER_COMPLETE);
+		writel(nfc->prog, nfc->base + PROG_OFST);
+		anfc_wait_for_event(nfc);
+	}
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+	anfc_read_data_op(chip, instr->ctx.data.buf.in, len, 1, 0);
+
+	return 0;
+}
+
+static int anfc_read_param_get_feature_sp_read_type_exec(struct nand_chip *chip,
+							 const struct nand_subop
+							 *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id, len;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 dma_mode, addrcycles, write_size;
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	if (nfc_op.cmds[0] == NAND_CMD_PARAM) {
+		nfc->prog = PROG_RDPARAM;
+		dma_mode = 0;
+		addrcycles = 1;
+		write_size = 0;
+	}
+	if (nfc_op.cmds[0] == NAND_CMD_GET_FEATURES) {
+		nfc->prog = PROG_GET_FEATURE;
+		dma_mode = 0;
+		addrcycles = 1;
+		write_size = 0;
+	}
+	if (nfc_op.cmds[0] == NAND_CMD_READ0) {
+		nfc->prog = PROG_PGRD;
+		addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+		write_size = mtd->writesize;
+		dma_mode = 1;
+	}
+
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], 0, dma_mode, write_size,
+			 addrcycles);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 1, nfc->prog, 1, 0);
+	memcpy(instr->ctx.data.buf.in,  nfc->buf, len);
+
+	return 0;
+}
+
+static int anfc_random_datain_type_exec(struct nand_chip *chip,
+					const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id, len;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	len = nand_subop_get_data_len(subop, op_id);
+	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 1, PROG_PGRD, 1, 0);
+	memcpy(instr->ctx.data.buf.in,  nfc->buf, len);
+
+	return 0;
+}
+
+static int anfc_setfeature_type_exec(struct nand_chip *chip,
+				     const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id, len;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	nfc->prog = PROG_SET_FEATURE;
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], 0, 0, 0, 1);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+	memcpy(nfc->buf, (char *)instr->ctx.data.buf.out, len);
+	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 0, nfc->prog, 1, 0);
+
+	return 0;
+}
+
+static int anfc_change_read_column_type_exec(struct nand_chip *chip,
+					     const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id, len;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	nfc->prog = PROG_PGRD;
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], nfc_op.cmds[1], 1,
+			 mtd->writesize, 2);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 1, nfc->prog, 1, 0);
+	memcpy(instr->ctx.data.buf.in, nfc->buf, len);
+
+	return 0;
+}
+
+static int anfc_page_read_type_exec(struct nand_chip *chip,
+				    const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id, len;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 addrcycles;
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	nfc->prog = PROG_PGRD;
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], nfc_op.cmds[1], 1,
+			 mtd->writesize, addrcycles);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+
+	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 1, nfc->prog, 1, 0);
+	memcpy(instr->ctx.data.buf.in, nfc->buf, len);
+
+	return 0;
+}
+
+static int anfc_zero_len_page_write_type_exec(struct nand_chip *chip,
+					      const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 addrcycles;
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	nfc->prog = PROG_PGRD;
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+
+	addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], NAND_CMD_PAGEPROG, 1,
+			 mtd->writesize, addrcycles);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	return 0;
+}
+
+static int anfc_page_write_type_exec(struct nand_chip *chip,
+				     const struct nand_subop *subop)
+{
+	const struct nand_op_instr *instr;
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	unsigned int op_id, len;
+	struct anfc_op nfc_op = {};
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 addrcycles;
+
+	anfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	nfc->prog = PROG_PGPROG;
+
+	addrcycles = achip->raddr_cycles + achip->caddr_cycles;
+	anfc_prepare_cmd(nfc, nfc_op.cmds[0], nfc_op.cmds[1], 1,
+			 mtd->writesize, addrcycles);
+	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
+
+	if (!nfc_op.data_instr)
+		return 0;
+
+	len = nand_subop_get_data_len(subop, op_id);
+	anfc_write_data_op(chip, (char *)instr->ctx.data.buf.out, len, 1, 0);
+
+	return 0;
+}
+
+static const struct nand_op_parser anfc_op_parser = NAND_OP_PARSER(
+	/* Use a separate function for each pattern */
+	NAND_OP_PARSER_PATTERN(
+		anfc_random_datain_type_exec,
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, ANFC_MAX_CHUNK_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_change_read_column_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, ANFC_MAX_CHUNK_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_page_read_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, ANFC_MAX_CHUNK_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_page_write_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, ANFC_MAX_CHUNK_SIZE),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_read_id_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, ANFC_MAX_CHUNK_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_erase_and_zero_len_page_read_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_read_status_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_reset_cmd_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_setfeature_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, ANFC_MAX_CHUNK_SIZE),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_read_param_get_feature_sp_read_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, ANFC_MAX_CHUNK_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		anfc_zero_len_page_write_type_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, ANFC_MAX_ADDR_CYCLES)),
+	);
+
+static int anfc_exec_op(struct nand_chip *chip,
+			const struct nand_operation *op,
+			bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &anfc_op_parser,
+				      op, check_only);
+}
+
+static void anfc_select_chip(struct mtd_info *mtd, int num)
+{
+	u32 val;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+
+	if (num < 0)
+		return;
+
+	val = readl(nfc->base + MEM_ADDR2_OFST);
+	val &= (val & ~(CS_MASK | BCH_MODE_MASK));
+	val |= (achip->csnum << CS_SHIFT) |
+	       (achip->ecc_strength << BCH_MODE_SHIFT);
+	writel(val, nfc->base + MEM_ADDR2_OFST);
+	nfc->csnum = achip->csnum;
+	writel(achip->eccval, nfc->base + ECC_OFST);
+	writel(achip->inftimeval, nfc->base + DATA_INTERFACE_OFST);
+}
+
+static irqreturn_t anfc_irq_handler(int irq, void *ptr)
+{
+	struct anfc_nand_controller *nfc = ptr;
+	u32 status;
+
+	status = readl(nfc->base + INTR_STS_OFST);
+	if (status & EVENT_MASK) {
+		complete(&nfc->event);
+		writel(status & EVENT_MASK, nfc->base + INTR_STS_OFST);
+		writel(0, nfc->base + INTR_STS_EN_OFST);
+		writel(0, nfc->base + INTR_SIG_EN_OFST);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int anfc_setup_data_interface(struct mtd_info *mtd, int csline,
+				     const struct nand_data_interface *conf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	int err;
+	const struct nand_sdr_timings *sdr;
+	u32 inftimeval;
+	bool change_sdr_clk = false;
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	/*
+	 * If the controller is already in the same mode as flash device
+	 * then no need to change the timing mode again.
+	 */
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	if (sdr->mode < 0)
+		return -ENOTSUPP;
+
+	inftimeval = sdr->mode & 7;
+	if (sdr->mode >= 2 && sdr->mode <= 5)
+		change_sdr_clk = true;
+	/*
+	 * SDR timing modes 2-5 will not work for the arasan nand when
+	 * freq > 90 MHz, so reduce the freq in SDR modes 2-5 to < 90Mhz
+	 */
+	if (change_sdr_clk) {
+		clk_disable_unprepare(nfc->clk_sys);
+		err = clk_set_rate(nfc->clk_sys, SDR_MODE_DEFLT_FREQ);
+		if (err) {
+			dev_err(nfc->dev, "Can't set the clock rate\n");
+			return err;
+		}
+		err = clk_prepare_enable(nfc->clk_sys);
+		if (err) {
+			dev_err(nfc->dev, "Unable to enable sys clock.\n");
+			clk_disable_unprepare(nfc->clk_sys);
+			return err;
+		}
+	}
+	achip->inftimeval = inftimeval;
+
+	return 0;
+}
+
+static int anfc_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct anfc_nand_chip *achip = to_anfc_nand(chip);
+	u32 ret;
+
+	if (mtd->writesize <= SZ_512)
+		achip->caddr_cycles = 1;
+	else
+		achip->caddr_cycles = 2;
+
+	if (chip->options & NAND_ROW_ADDR_3)
+		achip->raddr_cycles = 3;
+	else
+		achip->raddr_cycles = 2;
+
+	chip->ecc.calc_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
+	chip->ecc.code_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
+	ret = anfc_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct nand_controller_ops anfc_nand_controller_ops = {
+	.attach_chip = anfc_nand_attach_chip,
+};
+
+static int anfc_nand_chip_init(struct anfc_nand_controller *nfc,
+			       struct anfc_nand_chip *anand_chip,
+			       struct device_node *np)
+{
+	struct nand_chip *chip = &anand_chip->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &anand_chip->csnum);
+	if (ret) {
+		dev_err(nfc->dev, "can't get chip-select\n");
+		return -ENXIO;
+	}
+	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL, "arasan_nand.%d",
+				   anand_chip->csnum);
+	mtd->dev.parent = nfc->dev;
+
+	chip->chip_delay = 30;
+	chip->controller = &nfc->controller;
+	chip->options = NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
+	chip->select_chip = anfc_select_chip;
+	chip->setup_data_interface = anfc_setup_data_interface;
+	chip->exec_op = anfc_exec_op;
+	nand_set_flash_node(chip, np);
+
+	anand_chip->spktsize = SDR_MODE_PACKET_SIZE;
+
+	ret = nand_scan(mtd, 1);
+	if (ret) {
+		dev_err(nfc->dev, "nand_scan_tail for NAND failed\n");
+		return ret;
+	}
+
+	return mtd_device_register(mtd, NULL, 0);
+}
+
+static int anfc_probe(struct platform_device *pdev)
+{
+	struct anfc_nand_controller *nfc;
+	struct anfc_nand_chip *anand_chip;
+	struct device_node *np = pdev->dev.of_node, *child;
+	struct resource *res;
+	int err;
+
+	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
+	if (!nfc)
+		return -ENOMEM;
+
+	nand_controller_init(&nfc->controller);
+	INIT_LIST_HEAD(&nfc->chips);
+	init_completion(&nfc->event);
+	nfc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, nfc);
+	nfc->csnum = -1;
+	nfc->controller.ops = &anfc_nand_controller_ops;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	nfc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(nfc->base))
+		return PTR_ERR(nfc->base);
+	nfc->irq = platform_get_irq(pdev, 0);
+	if (nfc->irq < 0) {
+		dev_err(&pdev->dev, "platform_get_irq failed\n");
+		return -ENXIO;
+	}
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	err = devm_request_irq(&pdev->dev, nfc->irq, anfc_irq_handler,
+			       0, "arasannfc", nfc);
+	if (err)
+		return err;
+	nfc->clk_sys = devm_clk_get(&pdev->dev, "clk_sys");
+	if (IS_ERR(nfc->clk_sys)) {
+		dev_err(&pdev->dev, "sys clock not found.\n");
+		return PTR_ERR(nfc->clk_sys);
+	}
+
+	nfc->clk_flash = devm_clk_get(&pdev->dev, "clk_flash");
+	if (IS_ERR(nfc->clk_flash)) {
+		dev_err(&pdev->dev, "flash clock not found.\n");
+		return PTR_ERR(nfc->clk_flash);
+	}
+
+	err = clk_prepare_enable(nfc->clk_sys);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable sys clock.\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(nfc->clk_flash);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable flash clock.\n");
+		goto clk_dis_sys;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		anand_chip = devm_kzalloc(&pdev->dev, sizeof(*anand_chip),
+					  GFP_KERNEL);
+		if (!anand_chip) {
+			of_node_put(child);
+			err = -ENOMEM;
+			goto nandchip_clean_up;
+		}
+		err = anfc_nand_chip_init(nfc, anand_chip, child);
+		if (err) {
+			devm_kfree(&pdev->dev, anand_chip);
+			continue;
+		}
+
+		list_add_tail(&anand_chip->node, &nfc->chips);
+	}
+	return 0;
+
+nandchip_clean_up:
+	list_for_each_entry(anand_chip, &nfc->chips, node)
+		nand_release(nand_to_mtd(&anand_chip->chip));
+	clk_disable_unprepare(nfc->clk_flash);
+clk_dis_sys:
+	clk_disable_unprepare(nfc->clk_sys);
+
+	return err;
+}
+
+static int anfc_remove(struct platform_device *pdev)
+{
+	struct anfc_nand_controller *nfc = platform_get_drvdata(pdev);
+	struct anfc_nand_chip *anand_chip;
+
+	list_for_each_entry(anand_chip, &nfc->chips, node)
+		nand_release(nand_to_mtd(&anand_chip->chip));
+
+	clk_disable_unprepare(nfc->clk_sys);
+	clk_disable_unprepare(nfc->clk_flash);
+
+	return 0;
+}
+
+static const struct of_device_id anfc_ids[] = {
+	{ .compatible = "arasan,nfc-v3p10" },
+	{ .compatible = "xlnx,zynqmp-nand" },
+	{  }
+};
+MODULE_DEVICE_TABLE(of, anfc_ids);
+
+static struct platform_driver anfc_driver = {
+	.driver = {
+		.name = "arasan-nand-controller",
+		.of_match_table = anfc_ids,
+	},
+	.probe = anfc_probe,
+	.remove = anfc_remove,
+};
+module_platform_driver(anfc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Arasan NAND Flash Controller Driver");
-- 
2.7.4

