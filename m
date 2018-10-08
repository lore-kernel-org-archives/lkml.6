Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBC7C677E7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BDF2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xN268vfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BDF2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJIBfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:35:19 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:41216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbeJIBfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwcydO5I1gRFhzQ1uMnwIxBO80J1l0FNmJez56vy7r8=;
 b=xN268vfYH1WLt5bSE5iYi5IN6DB4qfMHFBaiJPikEEUmBknLSnocZW0DFRdhasFLqu15Wgv95K5R+b/OxdCEF9+kFMMSepcn9hg0p/a3MEJ0ISw0t0RyEiEq+ndx7l3D45XQtH4Wj/mvh7nPiBNaK9hG0gVRcR9KgFYmqFnd2v8=
Received: from SN4PR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:803:20::15) by BN1PR02MB086.namprd02.prod.outlook.com
 (2a01:111:e400:40e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.23; Mon, 8
 Oct 2018 18:22:14 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0053.outlook.office365.com
 (2603:10b6:803:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Mon, 8 Oct 2018 18:22:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 18:22:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34217 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAW-0005iI-7X; Mon, 08 Oct 2018 11:22:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAR-0004Gp-4h; Mon, 08 Oct 2018 11:22:07 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w98ILtCs014474;
        Mon, 8 Oct 2018 11:21:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g9aAF-0004D8-CL; Mon, 08 Oct 2018 11:21:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 4/4] drivers: clk: Add ZynqMP clock driver
Date:   Mon, 8 Oct 2018 11:21:46 -0700
Message-ID: <1539022906-18073-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
References: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(438002)(189003)(199004)(316002)(50466002)(14444005)(106002)(44832011)(48376002)(76176011)(54906003)(2616005)(7696005)(53946003)(9786002)(107886003)(426003)(11346002)(47776003)(36386004)(5660300001)(446003)(478600001)(476003)(356003)(575784001)(106466001)(2201001)(126002)(51416003)(4744004)(4326008)(63266004)(336012)(26005)(305945005)(77096007)(72206003)(50226002)(81156014)(486006)(36756003)(6666003)(110136005)(8936002)(2906002)(81166006)(186003)(16586007)(8676002)(107986001)(5001870100001)(579004)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR02MB086;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:YBijz3KKNls8FATd3jtmoOyVhhH2XrwNmwLmod8t82F0FDPPHvUOW/57xqYlAIGncPruG8fjZkTKN7IkRgWaNFlEZ66+2TBScjt7Tc16KgEfYudyLHajdctkm0jqAH25
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985ef473-5a04-4d1c-b651-08d62d4af81c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN1PR02MB086;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB086;3:zCyKW6WLmCkvxxJdBxitP869oAr6ekhaHVXojNnhw1ECPAorJUlzrkn/YHODvyEoGnC5Eh99iDCdm9v/RNlYEVm3aPodhDgksbSa7VKl2gtoKxetQd3RXxqIN47bh0HJdsvHNxj0zUpAsgqKBgwBgl8e48L1ertaS/rnTAEvSYmbOnmDyKdabnCts0GIyUCVwp9cNiFF7z8EwqJNLY6dkpG+L6lLVbSQXirUYyhPrw6dBevBDmwvHbhzcZyGOahk3ezDthlXxctnHQOik7LTScVTRvm9wmKiH0hwPeS9jDP8u6Jonjj+0FO0g3MjVnlxNgXMjzhYMCWK01begkWnWdq0uD27pd3I19csw8DMe1g=;25:RL8RXxHwobYLaxN61AF0x32yojIVkaivy9X1/yU9GtEASrUM3NgWnNn2OVzg1PArTXyqV7777ut/uY91PZ8P/QopMT8Q9Zgf7e+XGg8Pl7sjUYgPmEc86kAB4GN+7VuaFsfNCURWE8+6Pz65z09Qh9tnS9Z5jmEYqhSbnYHgEYJC/JxdREB5WZn7cBTVHTdvyxMc0uykm7EtpL/iUZT1jwmGSqmIvuMYVVt3P2oaHukwScKDZ/5jjxRk14UZaBfwvUfmyga/6k56UGUeROf8CVj+CNvL6C4yb3CjONRBD/6clMQuhM6Z62/NZy1LwGuv/O4KvPklBTsYNGH5Gq141w==
X-MS-TrafficTypeDiagnostic: BN1PR02MB086:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB086;31:Jjr1xHGvUSNN7q3GCTTZO2HevM2kJSmBBqfPxt3uh92g9in0neUd3fZm2qqa+0qbxCyY6xjpPe6rEfpnS1Rt1zPK1QQ9tOJn/KRgdI296PboOR9ymxPBTsxhtqgDURYyLJWb8vOE1k1gqhMuHZr64Ax57ZhVUavll744VivxxEbsJEG9rhlBcEtdWtkdYYpGg8iWVJo4K4NGeFs4z2XWzxgFD6WoUeI74dXL4UPcFiE=;20:Q5bUpJhq2g2kX11+OOjiBRR3YO4wUq6nnUmodjLC1DXKunUFhbCTNrq+e7+Wdn6GVsHeIbPo7WZnBbs7kkqDOcLmJ1ShLnrzsLY+CAddwoIcK5ZYRTE3O2yictKrIm6taxl4jxdN9DwjeFgznOx3K/PujdCB42W2JHKZE2kpjkgMdUVe80cpgFh5QTJKYCMW0j8/7Ord8XmoQHWVRR0IR6RkizUKTxrTDTHWddqXp8NDb0nf2CW8tgm6HMui+9p1uduzH/u3O8ymP6wW1AHEljhN2x2rD3qSp0g2Q8lKGPfss7ARoC7KrUo+oAq4c7eXRYQ3pHAdTodTO21NDQtYkYs8rysTCasWYXYXA9RAOPU5eVpe7NPbhIroewlnJTmaEFt8x726uxPJv5/Q98wb3yYC1vTvfROmfepBLphtUzSwWIpZQpYkARED0P7xvYVZgzqW7rE/UCGT59lBYsNnD+FNXqmD0xZGBJwFWLG6ZkjxOZBvQAA/kEZ1/pPJE3qt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR02MB086FFAD29A72C5E10515E3BB8E60@BN1PR02MB086.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN1PR02MB086;BCL:0;PCL:0;RULEID:;SRVR:BN1PR02MB086;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB086;4:8W4oAOqRCMNix63riOCEbpLBc2npZ3l1pJRtSyeZ+T5bJJ7ZJ6Saj4QfZ8GD9hLDqu3/9e9uBvf6hA84gdud768453Nd/6LTomHaASLrqbvNQ49+8WARq5znb1AY6RjDWDozaEoLYw3dEoFQq4VzDS1hc2+X3oLOIrhU4cxWdIC82agQquyWr2IFZjoMuTbCQwZAj+GXK45kB0uVVjIPR+2zxUMlUWTtboE29T4T8r3uglsAX/MzTKC1y7VaR5sJXRCw/e1qllUmPRs4d9lECMcb8wt4fKeoBhQqR8G8b1EHKa/TDt88lhuZVyUKy1xH
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR02MB086;23:nkaIJIC5nHG1MFfXiI6GYPq8C8kqPY/4dGNdqpIL5W?=
 =?us-ascii?Q?NpWOyt3rUwQKLmJtPEY8WLKbyeiSp3orvsVigXUlQ0fc7iU8lE3h+KdQ5Khf?=
 =?us-ascii?Q?NKSXZH80x/upVAJNcWH+2JKIhUHGUedRMeerEVjTvtrjxmd7YJd/4ezEF7Cn?=
 =?us-ascii?Q?VMUJgZRcB+DsXxQ9Jhy2MVQyNvgQ4uUvbPp89wxBCJtHZ65e7yw18fHjDZyp?=
 =?us-ascii?Q?1D/AThOrWQy7cdN/aHyIH0VWFyNUbJTwZ0fwvRgRuIjz6hJ3nWBn19Qf5A0b?=
 =?us-ascii?Q?PobX4A1W6wAN+OhZ7bGEC5Y11D3JtDxFk+vgB6xNqi+26PQmlA+0dEhuW5pG?=
 =?us-ascii?Q?1BKG02lLTPjnM2lXR5i/w9zZGJ0a0PsBqnFVgC8493rDJqZsyvSczrOdeH+q?=
 =?us-ascii?Q?Edk29j+sgOjmgyAys8jFsNEQSgGk/GHcGvwhlOe47TP7KralFhXRagb1IdTm?=
 =?us-ascii?Q?LRn4SWZOhjbW2CN3mzAQ5wfeC5FYQYfSj7zVRK5mb/Cfgm/+R4oAjHz2rx1g?=
 =?us-ascii?Q?gE7K421jsjnQ0AlFKMVZSvPdAD4zmtM/pUVnecrAAoJe6r2c8v+knmHVM6qx?=
 =?us-ascii?Q?k56P8QBsYLur7EtvrR800mTTEfxqqcMNfsWRGZY/GYV/FdlzNa/w4PnFM0NS?=
 =?us-ascii?Q?AhlOr9zJeRFEY1nGKmEe9P/F5p9Kv1t8ZcNl1M+zGbLAyW5nVny2BF8pxZJS?=
 =?us-ascii?Q?exEXEIAbn20NY3b5VTy1n3esee7NM2bZmFSsqI/kVXsGGiU0TlI7/FYMwgci?=
 =?us-ascii?Q?ZVH+tcQD6AgZ3QIZhiPS7DspknYNvMrBLvDBYyo8R88uvpkcp3GFU5Z6jIro?=
 =?us-ascii?Q?GxECf+hXti3Chk6sNHAckgb0aVpFzdyeVPtl4qd3UIwpzKqorPj7yEwKDsZ3?=
 =?us-ascii?Q?m4PPNeB3gFVAKHYPld+cPZl8quibxvYpwHGVDZp/1lIu1YXT7BfnqjjRCK6T?=
 =?us-ascii?Q?EA0DRA9bbJsFvHaD5iLnDBYc1fyBuYPDa0tjJjboZI5kR6lFzTXOzcO5FyV8?=
 =?us-ascii?Q?A3Lcdj45UwmrEiItQZLd2ZXVwYUYH7IGhzVwm/G/TUQ0o2zpsKaN5qAdt/s1?=
 =?us-ascii?Q?P9A6rW+MjGPgWs4Wr1r7zbibFmqC+ewnYSP6QPnIho0eiJgZELBknS0rh7fR?=
 =?us-ascii?Q?gODoRk7AF2aeD4uHZaSIK2CkMwZE8hUPFU2A4PAyDpXRLiZrWrJIYHQ3vH4/?=
 =?us-ascii?Q?7zWYt3rXGS+8gqDgi868MHmbEVVZWq561dZXLyjiyDzMF7cABMe/tSgZFEFZ?=
 =?us-ascii?Q?EsjQKUiNV4P/J7g/Lg4xb4EU6ZwWc3sjMYPszNLz0h9YTuMJW1YmuCMmoMps?=
 =?us-ascii?Q?3xNZGN6QiBhwaqytJ+afE=3D?=
X-Microsoft-Antispam-Message-Info: OSmQEEYUmps+4edb4o4bi1oBHcVEMwXmzG0Sm3sX8ULzfUn2ArPdiROrBj0sGYZW6zyR+wTwzmpf2Rb+uKGXf3uMmjFP9ikxGuttQANanHT4ULpBudIGyVGHPjtTxVNwxj8/I6OZCmECvrSKi5fREet1j5C27HxF00Uj+nG1Ir6R0IU9ez1qdFYprhIKTl58Ue7xiJRpSoA7TDkCdED1RSAPhtUKjB2Y+J7u7662Ln8qGbcLUNCMlWIG0RnLCK3o3YhieJi2ldmukjMuKXHrkROKSrf3u2f+O2h5f0bIcxmL4AkS/FocR8v4U1BZuFY+XsKf2s+zwXv8cGUvJcxBM7I2jqs8TR/c/rw99D/2dsM=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB086;6:lP5m99deIShdzLTmdi5913PxsufT16JgEuTgpfjygs5pbdq7dUoxhzD5kHUrNAD9L6P3d8NFQZyRvXGd67j9JPhpqSHXVwEpRcY6QU7WeHTiIro3KzGsjRQfg3hJZgk9QP/vRUisvq8BH0rKI+r5tGcZuR17ABuOcG6rkKj1bmtB9hlr4FVtoWO95C5S/NoHx4hgk4YKJeOf53MRO/pBiS1jf7mRxAXJXQ2T9/ozKhOcQ5FIfDJ5+YVt6o8+3I+UGhTuCzUcIOvPWQNwEjRFCoc0oRykSh9y90WFtwiqlNN0YHUFd4ECTbUW7U/yU1I/kPiEN3dMD/F2IsoCkMQEsCYZw6cXY4ELLhiB+MBN4Lr5AM6af1UMCy6flToFpx2oWtY4ijr8H27JtqkXMhBij8djmhJsjQ9hxCf5hX8AfUGPqST9eASphvil3S3TtodZNxXWkSy5dUvaXejGQLOd3g==;5:98pR3c1aSPSyweFrZDwpGfO+5RKCKOrLT30P9/6RjvWWtPMkL2DB5S+1u2HP/wR9FUwpfQwQZ45iW4FnvMhAAJh800rvnd3pBQ2D2LvonQi3nTmb4SOS3WjQvA/l2s8OPA4UEFEUGAQGsprMdMpYQsfEcyYc6cnKmKvpkj2+5To=;7:R6BxkKNMW+QOERTomXM3jFyjbsWL2HVBl7UMr9v1T9v8QY66UVapve2Fs+Ggt1epf4622a8kA+IBNi2ftIsEM98kmbCnq8QdLAtk1/+oHYXGgioTUoZQeycQLxP3h4B/8NRPgNthe9KIblc9G++in7cSvVCDugqX9CoJ+77VyakUhxmIsJWcehSpfUJgyaY8OIWL9DMFIz7Vp5QJdOrCLUB362ixNls7pQoNfNHxaKJ/G67ah3By7T0kiiph8ifI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 18:22:12.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985ef473-5a04-4d1c-b651-08d62d4af81c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR02MB086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jolly Shah <jolly.shah@xilinx.com>

This patch adds CCF compliant clock driver for ZynqMP.
Clock driver queries supported clock information from
firmware and regiters pll and output clocks with CCF.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejasp@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Acked-by: Olof Johansson <olof@lixom.net>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Kconfig                  |   1 +
 drivers/clk/Makefile                 |   1 +
 drivers/clk/zynqmp/Kconfig           |  10 +
 drivers/clk/zynqmp/Makefile          |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c | 144 +++++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 141 +++++++
 drivers/clk/zynqmp/clk-zynqmp.h      |  68 ++++
 drivers/clk/zynqmp/clkc.c            | 716 +++++++++++++++++++++++++++++++++++
 drivers/clk/zynqmp/divider.c         | 217 +++++++++++
 drivers/clk/zynqmp/pll.c             | 335 ++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |   1 +
 11 files changed, 1638 insertions(+)
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 98ce9fc..ab2ea76 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -253,5 +253,6 @@ source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
+source "drivers/clk/zynqmp/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 71ec41e..b6ac0d2 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -100,3 +100,4 @@ obj-$(CONFIG_X86)			+= x86/
 endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_COMMON_CLK_ZYNQMP)         += zynqmp/
diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
new file mode 100644
index 0000000..1708605
--- /dev/null
+++ b/drivers/clk/zynqmp/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config COMMON_CLK_ZYNQMP
+	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Support for the Zynqmp Ultrascale clock controller.
+	  It has a dependency on the PMU firmware.
+	  Say Y if you want to include clock support.
diff --git a/drivers/clk/zynqmp/Makefile b/drivers/clk/zynqmp/Makefile
new file mode 100644
index 0000000..0ec24bf
--- /dev/null
+++ b/drivers/clk/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Zynq Ultrascale+ MPSoC clock specific Makefile
+
+obj-$(CONFIG_ARCH_ZYNQMP)	+= pll.o clk-gate-zynqmp.o divider.o clk-mux-zynqmp.o clkc.o
diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
new file mode 100644
index 0000000..83b236f
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC clock controller
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ *
+ * Gated clock implementation
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/**
+ * struct clk_gate - gating clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @flags:	hardware-specific flags
+ * @clk_id:	Id of clock
+ */
+struct zynqmp_clk_gate {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+};
+
+#define to_zynqmp_clk_gate(_hw) container_of(_hw, struct zynqmp_clk_gate, hw)
+
+/**
+ * zynqmp_clk_gate_enable() - Enable clock
+ * @hw:		handle between common and hardware-specific interfaces
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_clk_gate_enable(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_enable(clk_id);
+
+	if (ret)
+		pr_warn_once("%s() clock enabled failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+/*
+ * zynqmp_clk_gate_disable() - Disable clock
+ * @hw:		handle between common and hardware-specific interfaces
+ */
+static void zynqmp_clk_gate_disable(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_disable(clk_id);
+
+	if (ret)
+		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+/**
+ * zynqmp_clk_gate_is_enable() - Check clock state
+ * @hw:		handle between common and hardware-specific interfaces
+ *
+ * Return: 1 if enabled, 0 if disabled else error code
+ */
+static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int state, ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getstate(clk_id, &state);
+	if (ret) {
+		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+		return -EIO;
+	}
+
+	return state ? 1 : 0;
+}
+
+static const struct clk_ops zynqmp_clk_gate_ops = {
+	.enable = zynqmp_clk_gate_enable,
+	.disable = zynqmp_clk_gate_disable,
+	.is_enabled = zynqmp_clk_gate_is_enabled,
+};
+
+/**
+ * zynqmp_clk_register_gate() - Register a gate clock with the clock framework
+ * @name:		Name of this clock
+ * @clk_id:		Id of this clock
+ * @parents:		Name of this clock's parents
+ * @num_parents:	Number of parents
+ * @nodes:		Clock topology node
+ *
+ * Return: clock hardware of the registered clock gate
+ */
+struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
+					const char * const *parents,
+					u8 num_parents,
+					const struct clock_topology *nodes)
+{
+	struct zynqmp_clk_gate *gate;
+	struct clk_hw *hw;
+	int ret;
+	struct clk_init_data init;
+
+	/* allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &zynqmp_clk_gate_ops;
+	init.flags = nodes->flag;
+	init.parent_names = parents;
+	init.num_parents = 1;
+
+	/* struct clk_gate assignments */
+	gate->flags = nodes->type_flag;
+	gate->hw.init = &init;
+	gate->clk_id = clk_id;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
new file mode 100644
index 0000000..4143f56
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC mux
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/*
+ * DOC: basic adjustable multiplexer clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is only affected by parent switching.  No clk_set_rate support
+ * parent - parent is adjustable through clk_set_parent
+ */
+
+/**
+ * struct zynqmp_clk_mux - multiplexer clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @flags:	hardware-specific flags
+ * @clk_id:	Id of clock
+ */
+struct zynqmp_clk_mux {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+};
+
+#define to_zynqmp_clk_mux(_hw) container_of(_hw, struct zynqmp_clk_mux, hw)
+
+/**
+ * zynqmp_clk_mux_get_parent() - Get parent of clock
+ * @hw:		handle between common and hardware-specific interfaces
+ *
+ * Return: Parent index
+ */
+static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = mux->clk_id;
+	u32 val;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getparent(clk_id, &val);
+
+	if (ret)
+		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return val;
+}
+
+/**
+ * zynqmp_clk_mux_set_parent() - Set parent of clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @index:	Parent index
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = mux->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_setparent(clk_id, index);
+
+	if (ret)
+		pr_warn_once("%s() set parent failed for clock: %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+static const struct clk_ops zynqmp_clk_mux_ops = {
+	.get_parent = zynqmp_clk_mux_get_parent,
+	.set_parent = zynqmp_clk_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static const struct clk_ops zynqmp_clk_mux_ro_ops = {
+	.get_parent = zynqmp_clk_mux_get_parent,
+};
+
+/**
+ * zynqmp_clk_register_mux() - Register a mux table with the clock
+ *			       framework
+ * @name:		Name of this clock
+ * @clk_id:		Id of this clock
+ * @parents:		Name of this clock's parents
+ * @num_parents:	Number of parents
+ * @nodes:		Clock topology node
+ *
+ * Return: clock hardware of the registered clock mux
+ */
+struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
+				       const char * const *parents,
+				       u8 num_parents,
+				       const struct clock_topology *nodes)
+{
+	struct zynqmp_clk_mux *mux;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	if (nodes->type_flag & CLK_MUX_READ_ONLY)
+		init.ops = &zynqmp_clk_mux_ro_ops;
+	else
+		init.ops = &zynqmp_clk_mux_ops;
+	init.flags = nodes->flag;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+	mux->flags = nodes->type_flag;
+	mux->hw.init = &init;
+	mux->clk_id = clk_id;
+
+	hw = &mux->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(hw);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_mux);
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
new file mode 100644
index 0000000..7ab163b
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2016-2018 Xilinx
+ */
+
+#ifndef __LINUX_CLK_ZYNQMP_H_
+#define __LINUX_CLK_ZYNQMP_H_
+
+#include <linux/spinlock.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Clock APIs payload parameters */
+#define CLK_GET_NAME_RESP_LEN				16
+#define CLK_GET_TOPOLOGY_RESP_WORDS			3
+#define CLK_GET_PARENTS_RESP_WORDS			3
+#define CLK_GET_ATTR_RESP_WORDS				1
+
+enum topology_type {
+	TYPE_INVALID,
+	TYPE_MUX,
+	TYPE_PLL,
+	TYPE_FIXEDFACTOR,
+	TYPE_DIV1,
+	TYPE_DIV2,
+	TYPE_GATE,
+};
+
+/**
+ * struct clock_topology - Clock topology
+ * @type:	Type of topology
+ * @flag:	Topology flags
+ * @type_flag:	Topology type specific flag
+ */
+struct clock_topology {
+	u32 type;
+	u32 flag;
+	u32 type_flag;
+};
+
+struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
+				       const char * const *parents,
+				       u8 num_parents,
+				       const struct clock_topology *nodes);
+
+struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
+					const char * const *parents,
+					u8 num_parents,
+					const struct clock_topology *nodes);
+
+struct clk_hw *zynqmp_clk_register_divider(const char *name,
+					   u32 clk_id,
+					   const char * const *parents,
+					   u8 num_parents,
+					   const struct clock_topology *nodes);
+
+struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
+				       const char * const *parents,
+				       u8 num_parents,
+				       const struct clock_topology *nodes);
+
+struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name,
+					u32 clk_id,
+					const char * const *parents,
+					u8 num_parents,
+					const struct clock_topology *nodes);
+
+#endif
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
new file mode 100644
index 0000000..9d7d297
--- /dev/null
+++ b/drivers/clk/zynqmp/clkc.c
@@ -0,0 +1,716 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC clock controller
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ *
+ * Based on drivers/clk/zynq/clkc.c
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "clk-zynqmp.h"
+
+#define MAX_PARENT			100
+#define MAX_NODES			6
+#define MAX_NAME_LEN			50
+
+#define CLK_TYPE_SHIFT			2
+
+#define PM_API_PAYLOAD_LEN		3
+
+#define NA_PARENT			0xFFFFFFFF
+#define DUMMY_PARENT			0xFFFFFFFE
+
+#define CLK_TYPE_FIELD_LEN		4
+#define CLK_TOPOLOGY_NODE_OFFSET	16
+#define NODES_PER_RESP			3
+
+#define CLK_TYPE_FIELD_MASK		0xF
+#define CLK_FLAG_FIELD_MASK		GENMASK(21, 8)
+#define CLK_TYPE_FLAG_FIELD_MASK	GENMASK(31, 24)
+
+#define CLK_PARENTS_ID_LEN		16
+#define CLK_PARENTS_ID_MASK		0xFFFF
+
+/* Flags for parents */
+#define PARENT_CLK_SELF			0
+#define PARENT_CLK_NODE1		1
+#define PARENT_CLK_NODE2		2
+#define PARENT_CLK_NODE3		3
+#define PARENT_CLK_NODE4		4
+#define PARENT_CLK_EXTERNAL		5
+
+#define END_OF_CLK_NAME			"END_OF_CLK"
+#define END_OF_TOPOLOGY_NODE		1
+#define END_OF_PARENTS			1
+#define RESERVED_CLK_NAME		""
+
+#define CLK_VALID_MASK			0x1
+
+enum clk_type {
+	CLK_TYPE_OUTPUT,
+	CLK_TYPE_EXTERNAL,
+};
+
+/**
+ * struct clock_parent - Clock parent
+ * @name:	Parent name
+ * @id:		Parent clock ID
+ * @flag:	Parent flags
+ */
+struct clock_parent {
+	char name[MAX_NAME_LEN];
+	int id;
+	u32 flag;
+};
+
+/**
+ * struct zynqmp_clock - Clock
+ * @clk_name:		Clock name
+ * @valid:		Validity flag of clock
+ * @type:		Clock type (Output/External)
+ * @node:		Clock topology nodes
+ * @num_nodes:		Number of nodes present in topology
+ * @parent:		Parent of clock
+ * @num_parents:	Number of parents of clock
+ */
+struct zynqmp_clock {
+	char clk_name[MAX_NAME_LEN];
+	u32 valid;
+	enum clk_type type;
+	struct clock_topology node[MAX_NODES];
+	u32 num_nodes;
+	struct clock_parent parent[MAX_PARENT];
+	u32 num_parents;
+};
+
+static const char clk_type_postfix[][10] = {
+	[TYPE_INVALID] = "",
+	[TYPE_MUX] = "_mux",
+	[TYPE_GATE] = "",
+	[TYPE_DIV1] = "_div1",
+	[TYPE_DIV2] = "_div2",
+	[TYPE_FIXEDFACTOR] = "_ff",
+	[TYPE_PLL] = ""
+};
+
+static struct clk_hw *(* const clk_topology[]) (const char *name, u32 clk_id,
+					const char * const *parents,
+					u8 num_parents,
+					const struct clock_topology *nodes)
+					= {
+	[TYPE_INVALID] = NULL,
+	[TYPE_MUX] = zynqmp_clk_register_mux,
+	[TYPE_PLL] = zynqmp_clk_register_pll,
+	[TYPE_FIXEDFACTOR] = zynqmp_clk_register_fixed_factor,
+	[TYPE_DIV1] = zynqmp_clk_register_divider,
+	[TYPE_DIV2] = zynqmp_clk_register_divider,
+	[TYPE_GATE] = zynqmp_clk_register_gate
+};
+
+static struct zynqmp_clock *clock;
+static struct clk_hw_onecell_data *zynqmp_data;
+static unsigned int clock_max_idx;
+static const struct zynqmp_eemi_ops *eemi_ops;
+
+/**
+ * zynqmp_is_valid_clock() - Check whether clock is valid or not
+ * @clk_id:	Clock index
+ *
+ * Return: 1 if clock is valid, 0 if clock is invalid else error code
+ */
+static inline int zynqmp_is_valid_clock(u32 clk_id)
+{
+	if (clk_id > clock_max_idx)
+		return -ENODEV;
+
+	return clock[clk_id].valid;
+}
+
+/**
+ * zynqmp_get_clock_name() - Get name of clock from Clock index
+ * @clk_id:	Clock index
+ * @clk_name:	Name of clock
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_get_clock_name(u32 clk_id, char *clk_name)
+{
+	int ret;
+
+	ret = zynqmp_is_valid_clock(clk_id);
+	if (ret == 1) {
+		strncpy(clk_name, clock[clk_id].clk_name, MAX_NAME_LEN);
+		return 0;
+	}
+
+	return ret == 0 ? -EINVAL : ret;
+}
+
+/**
+ * zynqmp_get_clock_type() - Get type of clock
+ * @clk_id:	Clock index
+ * @type:	Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_get_clock_type(u32 clk_id, u32 *type)
+{
+	int ret;
+
+	ret = zynqmp_is_valid_clock(clk_id);
+	if (ret == 1) {
+		*type = clock[clk_id].type;
+		return 0;
+	}
+
+	return ret == 0 ? -EINVAL : ret;
+}
+
+/**
+ * zynqmp_pm_clock_get_num_clocks() - Get number of clocks in system
+ * @nclocks:	Number of clocks in system/board.
+ *
+ * Call firmware API to get number of clocks.
+ *
+ * Return: 0 on success else error code.
+ */
+static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_NUM_CLOCKS;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	*nclocks = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_get_name() - Get the name of clock for given id
+ * @clock_id:	ID of the clock to be queried
+ * @name:	Name of given clock
+ *
+ * This function is used to get name of clock specified by given
+ * clock ID.
+ *
+ * Return: Returns 0, in case of error name would be 0
+ */
+static int zynqmp_pm_clock_get_name(u32 clock_id, char *name)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_NAME;
+	qdata.arg1 = clock_id;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	memcpy(name, ret_payload, CLK_GET_NAME_RESP_LEN);
+
+	return 0;
+}
+
+/**
+ * zynqmp_pm_clock_get_topology() - Get the topology of clock for given id
+ * @clock_id:	ID of the clock to be queried
+ * @index:	Node index of clock topology
+ * @topology:	Buffer to store nodes in topology and flags
+ *
+ * This function is used to get topology information for the clock
+ * specified by given clock ID.
+ *
+ * This API will return 3 node of topology with a single response. To get
+ * other nodes, master should call same API in loop with new
+ * index till error is returned. E.g First call should have
+ * index 0 which will return nodes 0,1 and 2. Next call, index
+ * should be 3 which will return nodes 3,4 and 5 and so on.
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index, u32 *topology)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_TOPOLOGY;
+	qdata.arg1 = clock_id;
+	qdata.arg2 = index;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	memcpy(topology, &ret_payload[1], CLK_GET_TOPOLOGY_RESP_WORDS * 4);
+
+	return ret;
+}
+
+/**
+ * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
+ *					clock framework
+ * @name:		Name of this clock
+ * @clk_id:		Clock ID
+ * @parents:		Name of this clock's parents
+ * @num_parents:	Number of parents
+ * @nodes:		Clock topology node
+ *
+ * Return: clock hardware to the registered clock
+ */
+struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
+					const char * const *parents,
+					u8 num_parents,
+					const struct clock_topology *nodes)
+{
+	u32 mult, div;
+	struct clk_hw *hw;
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
+	qdata.arg1 = clk_id;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	mult = ret_payload[1];
+	div = ret_payload[2];
+
+	hw = clk_hw_register_fixed_factor(NULL, name,
+					  parents[0],
+					  nodes->flag, mult,
+					  div);
+
+	return hw;
+}
+
+/**
+ * zynqmp_pm_clock_get_parents() - Get the first 3 parents of clock for given id
+ * @clock_id:	Clock ID
+ * @index:	Parent index
+ * @parents:	3 parents of the given clock
+ *
+ * This function is used to get 3 parents for the clock specified by
+ * given clock ID.
+ *
+ * This API will return 3 parents with a single response. To get
+ * other parents, master should call same API in loop with new
+ * parent index till error is returned. E.g First call should have
+ * index 0 which will return parents 0,1 and 2. Next call, index
+ * should be 3 which will return parent 3,4 and 5 and so on.
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32 *parents)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_PARENTS;
+	qdata.arg1 = clock_id;
+	qdata.arg2 = index;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS * 4);
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_get_attributes() - Get the attributes of clock for given id
+ * @clock_id:	Clock ID
+ * @attr:	Clock attributes
+ *
+ * This function is used to get clock's attributes(e.g. valid, clock type, etc).
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_pm_clock_get_attributes(u32 clock_id, u32 *attr)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_ATTRIBUTES;
+	qdata.arg1 = clock_id;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	memcpy(attr, &ret_payload[1], CLK_GET_ATTR_RESP_WORDS * 4);
+
+	return ret;
+}
+
+/**
+ * __zynqmp_clock_get_topology() - Get topology data of clock from firmware
+ *				   response data
+ * @topology:		Clock topology
+ * @data:		Clock topology data received from firmware
+ * @nnodes:		Number of nodes
+ *
+ * Return: 0 on success else error+reason
+ */
+static int __zynqmp_clock_get_topology(struct clock_topology *topology,
+				       u32 *data, u32 *nnodes)
+{
+	int i;
+
+	for (i = 0; i < PM_API_PAYLOAD_LEN; i++) {
+		if (!(data[i] & CLK_TYPE_FIELD_MASK))
+			return END_OF_TOPOLOGY_NODE;
+		topology[*nnodes].type = data[i] & CLK_TYPE_FIELD_MASK;
+		topology[*nnodes].flag = FIELD_GET(CLK_FLAG_FIELD_MASK,
+						   data[i]);
+		topology[*nnodes].type_flag =
+				FIELD_GET(CLK_TYPE_FLAG_FIELD_MASK, data[i]);
+		(*nnodes)++;
+	}
+
+	return 0;
+}
+
+/**
+ * zynqmp_clock_get_topology() - Get topology of clock from firmware using
+ *				 PM_API
+ * @clk_id:		Clock index
+ * @topology:		Clock topology
+ * @num_nodes:		Number of nodes
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_clock_get_topology(u32 clk_id,
+				     struct clock_topology *topology,
+				     u32 *num_nodes)
+{
+	int j, ret;
+	u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
+
+	*num_nodes = 0;
+	for (j = 0; j <= MAX_NODES; j += 3) {
+		ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
+		if (ret)
+			return ret;
+		ret = __zynqmp_clock_get_topology(topology, pm_resp, num_nodes);
+		if (ret == END_OF_TOPOLOGY_NODE)
+			return 0;
+	}
+
+	return 0;
+}
+
+/**
+ * __zynqmp_clock_get_topology() - Get parents info of clock from firmware
+ *				   response data
+ * @parents:		Clock parents
+ * @data:		Clock parents data received from firmware
+ * @nparent:		Number of parent
+ *
+ * Return: 0 on success else error+reason
+ */
+static int __zynqmp_clock_get_parents(struct clock_parent *parents, u32 *data,
+				      u32 *nparent)
+{
+	int i;
+	struct clock_parent *parent;
+
+	for (i = 0; i < PM_API_PAYLOAD_LEN; i++) {
+		if (data[i] == NA_PARENT)
+			return END_OF_PARENTS;
+
+		parent = &parents[i];
+		parent->id = data[i] & CLK_PARENTS_ID_MASK;
+		if (data[i] == DUMMY_PARENT) {
+			strcpy(parent->name, "dummy_name");
+			parent->flag = 0;
+		} else {
+			parent->flag = data[i] >> CLK_PARENTS_ID_LEN;
+			if (zynqmp_get_clock_name(parent->id, parent->name))
+				continue;
+		}
+		*nparent += 1;
+	}
+
+	return 0;
+}
+
+/**
+ * zynqmp_clock_get_parents() - Get parents info from firmware using PM_API
+ * @clk_id:		Clock index
+ * @parents:		Clock parents
+ * @num_parents:	Total number of parents
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_clock_get_parents(u32 clk_id, struct clock_parent *parents,
+				    u32 *num_parents)
+{
+	int j = 0, ret;
+	u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
+
+	*num_parents = 0;
+	do {
+		/* Get parents from firmware */
+		ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
+		if (ret)
+			return ret;
+
+		ret = __zynqmp_clock_get_parents(&parents[j], pm_resp,
+						 num_parents);
+		if (ret == END_OF_PARENTS)
+			return 0;
+		j += PM_API_PAYLOAD_LEN;
+	} while (*num_parents <= MAX_PARENT);
+
+	return 0;
+}
+
+/**
+ * zynqmp_get_parent_list() - Create list of parents name
+ * @np:			Device node
+ * @clk_id:		Clock index
+ * @parent_list:	List of parent's name
+ * @num_parents:	Total number of parents
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
+				  const char **parent_list, u32 *num_parents)
+{
+	int i = 0, ret;
+	u32 total_parents = clock[clk_id].num_parents;
+	struct clock_topology *clk_nodes;
+	struct clock_parent *parents;
+
+	clk_nodes = clock[clk_id].node;
+	parents = clock[clk_id].parent;
+
+	for (i = 0; i < total_parents; i++) {
+		if (!parents[i].flag) {
+			parent_list[i] = parents[i].name;
+		} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
+			ret = of_property_match_string(np, "clock-names",
+						       parents[i].name);
+			if (ret < 0)
+				strcpy(parents[i].name, "dummy_name");
+			parent_list[i] = parents[i].name;
+		} else {
+			strcat(parents[i].name,
+			       clk_type_postfix[clk_nodes[parents[i].flag - 1].
+			       type]);
+			parent_list[i] = parents[i].name;
+		}
+	}
+
+	*num_parents = total_parents;
+	return 0;
+}
+
+/**
+ * zynqmp_register_clk_topology() - Register clock topology
+ * @clk_id:		Clock index
+ * @clk_name:		Clock Name
+ * @num_parents:	Total number of parents
+ * @parent_names:	List of parents name
+ *
+ * Return: Returns either clock hardware or error+reason
+ */
+static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
+						   int num_parents,
+						   const char **parent_names)
+{
+	int j;
+	u32 num_nodes;
+	char *clk_out = NULL;
+	struct clock_topology *nodes;
+	struct clk_hw *hw = NULL;
+
+	nodes = clock[clk_id].node;
+	num_nodes = clock[clk_id].num_nodes;
+
+	for (j = 0; j < num_nodes; j++) {
+		/*
+		 * Clock name received from firmware is output clock name.
+		 * Intermediate clock names are postfixed with type of clock.
+		 */
+		if (j != (num_nodes - 1)) {
+			clk_out = kasprintf(GFP_KERNEL, "%s%s", clk_name,
+					    clk_type_postfix[nodes[j].type]);
+		} else {
+			clk_out = kasprintf(GFP_KERNEL, "%s", clk_name);
+		}
+
+		if (!clk_topology[nodes[j].type])
+			continue;
+
+		hw = (*clk_topology[nodes[j].type])(clk_out, clk_id,
+						    parent_names,
+						    num_parents,
+						    &nodes[j]);
+		if (IS_ERR(hw))
+			pr_warn_once("%s() %s register fail with %ld\n",
+				     __func__, clk_name, PTR_ERR(hw));
+
+		parent_names[0] = clk_out;
+	}
+	kfree(clk_out);
+	return hw;
+}
+
+/**
+ * zynqmp_register_clocks() - Register clocks
+ * @np:		Device node
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_register_clocks(struct device_node *np)
+{
+	int ret;
+	u32 i, total_parents = 0, type = 0;
+	const char *parent_names[MAX_PARENT];
+
+	for (i = 0; i < clock_max_idx; i++) {
+		char clk_name[MAX_NAME_LEN];
+
+		/* get clock name, continue to next clock if name not found */
+		if (zynqmp_get_clock_name(i, clk_name))
+			continue;
+
+		/* Check if clock is valid and output clock.
+		 * Do not register invalid or external clock.
+		 */
+		ret = zynqmp_get_clock_type(i, &type);
+		if (ret || type != CLK_TYPE_OUTPUT)
+			continue;
+
+		/* Get parents of clock*/
+		if (zynqmp_get_parent_list(np, i, parent_names,
+					   &total_parents)) {
+			WARN_ONCE(1, "No parents found for %s\n",
+				  clock[i].clk_name);
+			continue;
+		}
+
+		zynqmp_data->hws[i] =
+			zynqmp_register_clk_topology(i, clk_name,
+						     total_parents,
+						     parent_names);
+	}
+
+	for (i = 0; i < clock_max_idx; i++) {
+		if (IS_ERR(zynqmp_data->hws[i])) {
+			pr_err("Zynq Ultrascale+ MPSoC clk %s: register failed with %ld\n",
+			       clock[i].clk_name, PTR_ERR(zynqmp_data->hws[i]));
+			WARN_ON(1);
+		}
+	}
+	return 0;
+}
+
+/**
+ * zynqmp_get_clock_info() - Get clock information from firmware using PM_API
+ */
+static void zynqmp_get_clock_info(void)
+{
+	int i, ret;
+	u32 attr, type = 0;
+
+	for (i = 0; i < clock_max_idx; i++) {
+		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
+		if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME))
+			continue;
+
+		ret = zynqmp_pm_clock_get_attributes(i, &attr);
+		if (ret)
+			continue;
+
+		clock[i].valid = attr & CLK_VALID_MASK;
+		clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
+							CLK_TYPE_OUTPUT;
+	}
+
+	/* Get topology of all clock */
+	for (i = 0; i < clock_max_idx; i++) {
+		ret = zynqmp_get_clock_type(i, &type);
+		if (ret || type != CLK_TYPE_OUTPUT)
+			continue;
+
+		ret = zynqmp_clock_get_topology(i, clock[i].node,
+						&clock[i].num_nodes);
+		if (ret)
+			continue;
+
+		ret = zynqmp_clock_get_parents(i, clock[i].parent,
+					       &clock[i].num_parents);
+		if (ret)
+			continue;
+	}
+}
+
+/**
+ * zynqmp_clk_setup() - Setup the clock framework and register clocks
+ * @np:		Device node
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_clk_setup(struct device_node *np)
+{
+	int ret;
+
+	ret = zynqmp_pm_clock_get_num_clocks(&clock_max_idx);
+	if (ret)
+		return ret;
+
+	zynqmp_data = kzalloc(sizeof(*zynqmp_data) + sizeof(*zynqmp_data) *
+						clock_max_idx, GFP_KERNEL);
+	if (!zynqmp_data)
+		return -ENOMEM;
+
+	clock = kcalloc(clock_max_idx, sizeof(*clock), GFP_KERNEL);
+	if (!clock) {
+		kfree(zynqmp_data);
+		return -ENOMEM;
+	}
+
+	zynqmp_get_clock_info();
+	zynqmp_register_clocks(np);
+
+	zynqmp_data->num = clock_max_idx;
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, zynqmp_data);
+
+	return 0;
+}
+
+static int zynqmp_clock_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	ret = zynqmp_clk_setup(dev->of_node);
+
+	return ret;
+}
+
+static const struct of_device_id zynqmp_clock_of_match[] = {
+	{.compatible = "xlnx,zynqmp-clk"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_clock_of_match);
+
+static struct platform_driver zynqmp_clock_driver = {
+	.driver = {
+		.name = "zynqmp_clock",
+		.of_match_table = zynqmp_clock_of_match,
+	},
+	.probe = zynqmp_clock_probe,
+};
+module_platform_driver(zynqmp_clock_driver);
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
new file mode 100644
index 0000000..a371c66
--- /dev/null
+++ b/drivers/clk/zynqmp/divider.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC Divider support
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ *
+ * Adjustable divider clock implementation
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/*
+ * DOC: basic adjustable divider clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is adjustable.  clk->rate = ceiling(parent->rate / divisor)
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_zynqmp_clk_divider(_hw)		\
+	container_of(_hw, struct zynqmp_clk_divider, hw)
+
+#define CLK_FRAC	BIT(13) /* has a fractional parent */
+
+/**
+ * struct zynqmp_clk_divider - adjustable divider clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @flags:	Hardware specific flags
+ * @clk_id:	Id of clock
+ * @div_type:	divisor type (TYPE_DIV1 or TYPE_DIV2)
+ */
+struct zynqmp_clk_divider {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+	u32 div_type;
+};
+
+static inline int zynqmp_divider_get_val(unsigned long parent_rate,
+					 unsigned long rate)
+{
+	return DIV_ROUND_CLOSEST(parent_rate, rate);
+}
+
+/**
+ * zynqmp_clk_divider_recalc_rate() - Recalc rate of divider clock
+ * @hw:			handle between common and hardware-specific interfaces
+ * @parent_rate:	rate of parent clock
+ *
+ * Return: 0 on success else error+reason
+ */
+static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 div, value;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getdivider(clk_id, &div);
+
+	if (ret)
+		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	if (div_type == TYPE_DIV1)
+		value = div & 0xFFFF;
+	else
+		value = div >> 16;
+
+	return DIV_ROUND_UP_ULL(parent_rate, value);
+}
+
+/**
+ * zynqmp_clk_divider_round_rate() - Round rate of divider clock
+ * @hw:			handle between common and hardware-specific interfaces
+ * @rate:		rate of clock to be set
+ * @prate:		rate of parent clock
+ *
+ * Return: 0 on success else error+reason
+ */
+static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
+					  unsigned long rate,
+					  unsigned long *prate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 bestdiv;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		ret = eemi_ops->clock_getdivider(clk_id, &bestdiv);
+
+		if (ret)
+			pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+				     __func__, clk_name, ret);
+		if (div_type == TYPE_DIV1)
+			bestdiv = bestdiv & 0xFFFF;
+		else
+			bestdiv  = bestdiv >> 16;
+
+		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+	}
+
+	bestdiv = zynqmp_divider_get_val(*prate, rate);
+
+	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
+	    (divider->flags & CLK_FRAC))
+		bestdiv = rate % *prate ? 1 : bestdiv;
+	*prate = rate * bestdiv;
+
+	return rate;
+}
+
+/**
+ * zynqmp_clk_divider_set_rate() - Set rate of divider clock
+ * @hw:			handle between common and hardware-specific interfaces
+ * @rate:		rate of clock to be set
+ * @parent_rate:	rate of parent clock
+ *
+ * Return: 0 on success else error+reason
+ */
+static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 value, div;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	value = zynqmp_divider_get_val(parent_rate, rate);
+	if (div_type == TYPE_DIV1) {
+		div = value & 0xFFFF;
+		div |= 0xffff << 16;
+	} else {
+		div = 0xffff;
+		div |= value << 16;
+	}
+
+	ret = eemi_ops->clock_setdivider(clk_id, div);
+
+	if (ret)
+		pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+static const struct clk_ops zynqmp_clk_divider_ops = {
+	.recalc_rate = zynqmp_clk_divider_recalc_rate,
+	.round_rate = zynqmp_clk_divider_round_rate,
+	.set_rate = zynqmp_clk_divider_set_rate,
+};
+
+/**
+ * zynqmp_clk_register_divider() - Register a divider clock
+ * @name:		Name of this clock
+ * @clk_id:		Id of clock
+ * @parents:		Name of this clock's parents
+ * @num_parents:	Number of parents
+ * @nodes:		Clock topology node
+ *
+ * Return: clock hardware to registered clock divider
+ */
+struct clk_hw *zynqmp_clk_register_divider(const char *name,
+					   u32 clk_id,
+					   const char * const *parents,
+					   u8 num_parents,
+					   const struct clock_topology *nodes)
+{
+	struct zynqmp_clk_divider *div;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &zynqmp_clk_divider_ops;
+	init.flags = nodes->flag;
+	init.parent_names = parents;
+	init.num_parents = 1;
+
+	/* struct clk_divider assignments */
+	div->flags = nodes->type_flag;
+	div->hw.init = &init;
+	div->clk_id = clk_id;
+	div->div_type = nodes->type;
+
+	hw = &div->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_divider);
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
new file mode 100644
index 0000000..a541397
--- /dev/null
+++ b/drivers/clk/zynqmp/pll.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq UltraScale+ MPSoC PLL driver
+ *
+ *  Copyright (C) 2016-2018 Xilinx
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "clk-zynqmp.h"
+
+/**
+ * struct zynqmp_pll - PLL clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @clk_id:	PLL clock ID
+ */
+struct zynqmp_pll {
+	struct clk_hw hw;
+	u32 clk_id;
+};
+
+#define to_zynqmp_pll(_hw)	container_of(_hw, struct zynqmp_pll, hw)
+
+#define PLL_FBDIV_MIN	25
+#define PLL_FBDIV_MAX	125
+
+#define PS_PLL_VCO_MIN 1500000000
+#define PS_PLL_VCO_MAX 3000000000UL
+
+enum pll_mode {
+	PLL_MODE_INT,
+	PLL_MODE_FRAC,
+};
+
+#define FRAC_OFFSET 0x8
+#define PLLFCFG_FRAC_EN	BIT(31)
+#define FRAC_DIV  BIT(16)  /* 2^16 */
+
+/**
+ * zynqmp_pll_get_mode() - Get mode of PLL
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return: Mode of PLL
+ */
+static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
+			      ret_payload);
+	if (ret)
+		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret_payload[1];
+}
+
+/**
+ * zynqmp_pll_set_mode() - Set the PLL mode
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @on:		Flag to determine the mode
+ */
+static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	int ret;
+	u32 mode;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (on)
+		mode = PLL_MODE_FRAC;
+	else
+		mode = PLL_MODE_INT;
+
+	ret = eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NULL);
+	if (ret)
+		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+/**
+ * zynqmp_pll_round_rate() - Round a clock frequency
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @rate:	Desired clock frequency
+ * @prate:	Clock frequency of parent clock
+ *
+ * Return: Frequency closest to @rate the hardware can generate
+ */
+static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	u32 fbdiv;
+	long rate_div, f;
+
+	/* Enable the fractional mode if needed */
+	rate_div = (rate * FRAC_DIV) / *prate;
+	f = rate_div % FRAC_DIV;
+	zynqmp_pll_set_mode(hw, !!f);
+
+	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+		if (rate > PS_PLL_VCO_MAX) {
+			fbdiv = rate / PS_PLL_VCO_MAX;
+			rate = rate / (fbdiv + 1);
+		}
+		if (rate < PS_PLL_VCO_MIN) {
+			fbdiv = DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
+			rate = rate * fbdiv;
+		}
+		return rate;
+	}
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
+	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+	return *prate * fbdiv;
+}
+
+/**
+ * zynqmp_pll_recalc_rate() - Recalculate clock frequency
+ * @hw:			Handle between common and hardware-specific interfaces
+ * @parent_rate:	Clock frequency of parent clock
+ *
+ * Return: Current clock frequency
+ */
+static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 fbdiv, data;
+	unsigned long rate, frac;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getdivider(clk_id, &fbdiv);
+	if (ret)
+		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	rate =  parent_rate * fbdiv;
+	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+		eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
+				ret_payload);
+		data = ret_payload[1];
+		frac = (parent_rate * data) / FRAC_DIV;
+		rate = rate + frac;
+	}
+
+	return rate;
+}
+
+/**
+ * zynqmp_pll_set_rate() - Set rate of PLL
+ * @hw:			Handle between common and hardware-specific interfaces
+ * @rate:		Frequency of clock to be set
+ * @parent_rate:	Clock frequency of parent clock
+ *
+ * Set PLL divider to set desired rate.
+ *
+ * Returns:            rate which is set on success else error code
+ */
+static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 fbdiv;
+	long rate_div, frac, m, f;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+		rate_div = (rate * FRAC_DIV) / parent_rate;
+		m = rate_div / FRAC_DIV;
+		f = rate_div % FRAC_DIV;
+		m = clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
+		rate = parent_rate * m;
+		frac = (parent_rate * f) / FRAC_DIV;
+
+		ret = eemi_ops->clock_setdivider(clk_id, m);
+		if (ret)
+			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+				     __func__, clk_name, ret);
+
+		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, f, NULL);
+
+		return rate + frac;
+	}
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, parent_rate);
+	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+	ret = eemi_ops->clock_setdivider(clk_id, fbdiv);
+	if (ret)
+		pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return parent_rate * fbdiv;
+}
+
+/**
+ * zynqmp_pll_is_enabled() - Check if a clock is enabled
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return: 1 if the clock is enabled, 0 otherwise
+ */
+static int zynqmp_pll_is_enabled(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	unsigned int state;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	ret = eemi_ops->clock_getstate(clk_id, &state);
+	if (ret) {
+		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+		return -EIO;
+	}
+
+	return state ? 1 : 0;
+}
+
+/**
+ * zynqmp_pll_enable() - Enable clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return: 0 on success else error code
+ */
+static int zynqmp_pll_enable(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (zynqmp_pll_is_enabled(hw))
+		return 0;
+
+	ret = eemi_ops->clock_enable(clk_id);
+	if (ret)
+		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret;
+}
+
+/**
+ * zynqmp_pll_disable() - Disable clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ */
+static void zynqmp_pll_disable(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!zynqmp_pll_is_enabled(hw))
+		return;
+
+	ret = eemi_ops->clock_disable(clk_id);
+	if (ret)
+		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+static const struct clk_ops zynqmp_pll_ops = {
+	.enable = zynqmp_pll_enable,
+	.disable = zynqmp_pll_disable,
+	.is_enabled = zynqmp_pll_is_enabled,
+	.round_rate = zynqmp_pll_round_rate,
+	.recalc_rate = zynqmp_pll_recalc_rate,
+	.set_rate = zynqmp_pll_set_rate,
+};
+
+/**
+ * zynqmp_clk_register_pll() - Register PLL with the clock framework
+ * @name:		PLL name
+ * @clk_id:		Clock ID
+ * @parents:		Name of this clock's parents
+ * @num_parents:	Number of parents
+ * @nodes:		Clock topology node
+ *
+ * Return: clock hardware to the registered clock
+ */
+struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
+				       const char * const *parents,
+				       u8 num_parents,
+				       const struct clock_topology *nodes)
+{
+	struct zynqmp_pll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	init.name = name;
+	init.ops = &zynqmp_pll_ops;
+	init.flags = nodes->flag;
+	init.parent_names = parents;
+	init.num_parents = 1;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->hw.init = &init;
+	pll->clk_id = clk_id;
+
+	hw = &pll->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
+	if (ret < 0)
+		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
+
+	return hw;
+}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 7a9db08..3c3c28e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -72,6 +72,7 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
 	PM_QID_CLOCK_GET_PARENTS,
 	PM_QID_CLOCK_GET_ATTRIBUTES,
+	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
 /**
-- 
2.7.4

