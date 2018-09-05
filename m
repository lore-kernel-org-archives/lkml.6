Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31773C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0E12075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qup+9Qm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0E12075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeIELik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:38:40 -0400
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:1974
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbeIELij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smd1JcIkfnUUHXtdRSsYWyN7F2l2wkJs7gfc30tulmo=;
 b=qup+9Qm0HLjADj3Yj6sEu5VQ2zDo9drki6C0oX53Pgcp2vGnIiKxsELMQDkEy4R9vdoGt6HqQI79/6hPvgWC9Dj8zLhvRgwZ0TKyy3D+PDc1P8r1SjxGhq5G+3wbhfOU0PF1uT9TbZ1ZhFFUyb9av088A+8IhAh6AWHU4Fl5JAo=
Received: from SN4PR0201CA0006.namprd02.prod.outlook.com
 (2603:10b6:803:2b::16) by BL2PR02MB498.namprd02.prod.outlook.com
 (2a01:111:e400:c2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 07:09:26 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0006.outlook.office365.com
 (2603:10b6:803:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.16 via Frontend
 Transport; Wed, 5 Sep 2018 07:09:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 07:09:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwL-0000Ad-Bt; Wed, 05 Sep 2018 00:09:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwG-0000cA-8Z; Wed, 05 Sep 2018 00:09:20 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8579HAk024307;
        Wed, 5 Sep 2018 00:09:17 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwD-0000Zf-3y; Wed, 05 Sep 2018 00:09:17 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Wed, 5 Sep 2018 12:39:01 +0530
Message-ID: <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(36756003)(106002)(63266004)(76176011)(356003)(47776003)(5660300001)(50466002)(48376002)(110136005)(8936002)(305945005)(16586007)(77096007)(186003)(9786002)(50226002)(6666003)(336012)(106466001)(81156014)(81166006)(26005)(8676002)(478600001)(36386004)(426003)(11346002)(217873002)(2906002)(316002)(446003)(476003)(2616005)(126002)(486006)(2201001)(51416003)(7696005)(107986001)(921003)(1121003)(2101003)(83996005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB498;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT017;1:HfhBgmftcXwALZek/1Krz9HeXDiS3h+Eko/tTxJAj3h6iOlOyE3Q0pWMFaJHkQcY7x6mmLFpSx2QbqAomuzPKV7DM1Z3FEwLPpcnzdnbCku+lh/jOwhCtmLiwQzQpOl6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565a4d6e-d49e-4ab5-ecef-08d612fe83d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB498;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;3:RjgZFOrbId/Fsw5YfYzId/1fFyuIUNbotjlUdTb1oixB2eD+S0VjcpZLqa/L9at+vWUyv8NtC77yAw2BTyIlS34rpmbO9PBYOLhexM/QaTIVnmFIA7omj8gwXjqG4dwrNyvEcknc11um1zYY5ElVcOt4l+PNut88Hjt9P5jZiNcL97697EqlkJIgtRPA8K1271TaKGN2dyxR8MMFtLY1W9STTEKFs2G+UObWSaTkfjnzrzERD2kfQp5djMJVjLFfdqdwV8yD9UpxLCr1sXwmJXhAHao1QR8YkTUh282TVQ7EF0Ua+0y0eS4ZxzysbVHsbbV4ptNJiKGy4yvMcFkaNhbK1gy/a3pMziutN5jCD2Y=;25:7cAZPsywb7lIj+IPxM0t2+2d1qP2goKeuiT/GZlhDsVgV20T+dcmNnLiOe2Je3R5WsSU3BkJj+wUAzB83Xg1RS1JUfqtyJOQ9KHpaPjBq4d2nHhNmhtnCfJB1ASUjZzWFuU01S51teaTcPCw5oCjzI+/B/rc+CPvkz+fOlpcdS0R35tNI3BfucKv41Swmz4j13bVS9LxNHTOziB1rhoCAU1F2ncMJs9yr8soqZHuTHGVekFeIb3osIllgUvUe4Pd+yBstTmC/bfQo+mYFyBdAKe/f6zg3uNqwHQwFpZq98jLNRVR6dT+6O/eKemv6oLCs29tJQG516p4OnsTJxQldw==
X-MS-TrafficTypeDiagnostic: BL2PR02MB498:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;31:e06mAHhSXQz3tZY2BrD5AUxtVyvvKWLYSNjcgfMa8VMrBKxPRKBz1znuTqcmjyFFlz6UuRrNP2D6oEZHnbkQ1FB/XV45jwxxjpEDcLyNkg/HnCy5JxtE1E7Ytywf13LRJGcVbjZeXRMBK7BdXjxYe2AeWLxaGj4hPJZ3rwbIH0R2JxtgWCkEslAWtZ/yfd60S07JvZMh4/AYjqbRVrY/Q3z8YMwfR+psiWuKaEJVswI=;20:klYVORTWs8rhig6wsu7OrfEpjM4Ao0a+dmz0jzjl3b3CKFacj3brB0iH+Ab5oBs57Qu3oGdzUPjl3eBAaSOUy+B5e6adRaB1watfXn9fV4kjhJfRqfQIOEs9Dh65wEJIRFAF2gKJNn93KwC/wGllcOUoYzWcoQ25GX/yLsqTbHp2abTunHZPDYWuDjWVyf43xcZo2iwqE5Sf2w0eCGZjBwCjQNtL3NCC7K2YnpsPNAnRdT4U02ejaACYWREuzAtMqJJRd98jlab1tEGxJq3WBgg2Ij06CTY80IpgWGbcYEu+3XfgfQ9xwvyC9c/gn9jKKuVvbWm4ANC/1DucD78XEOg+/68dW7aEQNmwbnftf/ww1wavdTl8QpV2HNgIed+85B8H11CLoZyx+14pYu8SfLfO4dsrbkR1wdStGU/jDdvdI0HOWf4wBRuxE7hKW7dFVHKoAYGJXu3SvZ7cbuTbfn975NHYG4Jp8+2aNIBtQQD0lEowjFSwZt57dQU1j0W9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB4986A9F150F99D7EDC05977C2020@BL2PR02MB498.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BL2PR02MB498;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB498;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;4:L9/NAXOB8rKK5TGfJs6JHhWsIBFEzGGKMQsm0GXiMQQv2bW6v8PO+QRJ9M8KMvQ7PsK4Eg1betUwHDNbLP3uF/3upT4t5OYkWxKaYkNQbqSoqJmTIG0D3lf4Q17/beceJw86llM8LICNySISFjuzs0r+pEICoiR5NGtSt5Otv1+z5ceZlBtTo0KDIjt9miIeGt3RUW965ncxZ2C3Lrjk2hN42NhSYPIPvrcNZ1FaZLAs1pz93YrWbfsW2MVqCcnHRAlSgmbmtgvyNYzPSIZqYSJtL1oHb50qSHIe7VW5Xoc1fxaqGQJLL5zhQdmk6tszD9/s9yUyGKVXaCB5nmtAes79g+0p1C3jlmG56BkhMVE=
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB498;23:fm/KnbYNxsdrcPI+0dri0pY9lDTlej6WE5zQmv83V4?=
 =?us-ascii?Q?0D+zdpt369Z/jA/dvz6Hov1LX4UPP03qq8RndVoNzijDa22VmZZ1hnQwZzVD?=
 =?us-ascii?Q?cid28cddCLYosNg9eUy20MrfTT+N+lLEZzSHIW118mxOJ3jJeatEA/w8Ls9r?=
 =?us-ascii?Q?IbachXTcDdQbMtTgFi3OfiEyU5psgUv+oiaH4kAop6xjDNwqsd/9CAKU8M0p?=
 =?us-ascii?Q?cayJ+GMo+VoPaLnnccN8YSpbEaVAJqQSBs1qfljpi692w/jc1lzLsbhuHhEL?=
 =?us-ascii?Q?AUy8rLYRDFcdOrR0faNc8kFy2aEagoqDt4LPfGoq/d9aEO0nN17mMu6wiovf?=
 =?us-ascii?Q?cVCouU5axr8Ta7p0zPgYGH1Hv5foPuUTVYgQgUaS6lEmAKQ/2J3WuHNivGt4?=
 =?us-ascii?Q?p5M2tYTRKl//d01irYOW6/uIFeOFbjmtX63TOhLwmM7zEqD/9XkJxEVT+0gl?=
 =?us-ascii?Q?KRiTYNsGqT2eb1jS4fwmg8j1d4yo3gkndMOhyS88WuQFF/ahbH9kDz/BqY2R?=
 =?us-ascii?Q?uJhouon1I+yHjGYxSIP5Plbrz0nN7jZTjfO59gpLeUbHOCPSmiqb6WYwNCo+?=
 =?us-ascii?Q?PQBtyj7+mnQlRVwt6j1R4RwWt0OIB13szjDtIkLT797SjZIJ6y3gwBNIjC/U?=
 =?us-ascii?Q?NDss/i0DC5FdvHjniWeWB2lcV6DWcao2miVW0AJbqn7cFGYDTqNZGIfxpMIz?=
 =?us-ascii?Q?w+i/VQCZmxm446KzI15xdPWC0sPi1bXKxU1EGZbgydMV2lXXtmmx9tdAnWYE?=
 =?us-ascii?Q?4fbGnuHdRMiQaVcvXBGNmf15/hA53Js56hOuLrg/f1M8Co3tX8Btnn29Lq50?=
 =?us-ascii?Q?V5sREhzBX8rKcmfJl+Re59xpryEqyN5Qu58FFJ0CllfphP5nDemn+rgBVVGr?=
 =?us-ascii?Q?QKmPOUMus/XJ7CAedJ5MfePihDlCw3hgGH0+AN2FVm75W12LMrJfeJR3dO5U?=
 =?us-ascii?Q?AIsY3N0tZ5GPc+r/S8Ha4C5Gr0xV3RAaJAgVxYh+zrkh+B5RJstJrYMZEfma?=
 =?us-ascii?Q?hTKEUpvW6nQOmp1sCpdr5zFu+jWbopSnLcWW9ox7FFyv5Shwzs/0IlFg14p8?=
 =?us-ascii?Q?mzXQQOplrRbQyaa6LsYGTLj79mK5GUT4+R6hoczE7aaJuQi+VxM1bP6BNUIM?=
 =?us-ascii?Q?yOvELL24OX4BS+MQavcU5/pMLz/I7u1v60x9+1PnqZpfCdXCAxjlTsq2W8Gr?=
 =?us-ascii?Q?96MoSlFBLy1iYdyERpe3D4KFKnQFzDZNDEWUp4O2X0Gd9rNRk/k6YD4gcglI?=
 =?us-ascii?Q?3edCf8Uxb8mpGjNIQ=3D?=
X-Microsoft-Antispam-Message-Info: EwrnKK3A2fAqlYvUL0I+6DDQPf88HguSNA/u4SpAealhY+t844LfZfKFvLBpOOxjT0tCEzfmclg2xWj7BEllxAdiP482bBrnulrT4gFNHD6Hjtak5JmDeuPY0zlD96SOjNSSEfY235WZminRpbc9vN8eo0uBGl7TE+gHxkgXOP2aoUc8nd79Q6S9kSfXumQqYucQqvyuGu1pXR2Yk6/v4TPheJJWUueFmoIZyVlo2LskN8uJfk1bTFpxR2o7cPfBZoih2gl3sf2XIdjm6HQonpnpkgt4SwWu4Va3qqs2C3iQJsIRVsyuBVtfWdviBxa/qacViVzksdND9I8kH6nqVqxhuyNzhsBZZrhnbOE9HZY=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;6:rpu27xk8aYLFGG0j+NvvnJvBq2YyoXZCcf7b7h2nkgCZhQehxTs1XEWeQmnJxlaGPgdDTbfwP4ZDAlIKO3oSidOlp96fhoIyn8SLAL5xDtRYrGUMyD7WNuje5d1i363GYyJXd9Rx6F7FA/fcVGG6Pjs/7fXEvIHUsqGVX/os1huVOljPICsXUSMGQ5WCrAHzwIoDOl6sKkz3a5abK7/xDlCX7aFgqf+dlysNL1MumH70+uTiAT7JoKsTOfC3ajCo+IoBNYgz2GbWRW59vjMhw9oZmaWnVYg79ZmSJ26onL6solerfDxQRZ/rfNqu5X4M1fcE9bMy0xAMA8ccYZTjxDvuNExhtgIEhkz9lwXEzqekVgUFIxhE0SXDej8Mi5pUnKGSKGOGSkLg686Mqiz1Kn3Dp7f10aBLqYvdiEBu9jV2qL3U+/4IIIKQvu5iXstsS55OSj5zYoNBo3rbDN3cGw==;5:YsT74ykvf+WD3WTRgtT0iEWKiXCzGX4FaM2hHA+1K1YBwGA50Pt2ht+s4jdvhTKDNgujc7TgHXD5wSM2tABArWZv6teLA0IgCVs7ByyFJDLcvkOa0f58UEZMOtbLs4YZtNsV9BK96hLWbYFxRdGZ+08uTeML3MjkgOZx9NYSSvs=;7:BFDvxB/6g5hFp3qbHsU7JBwkZtyk+xsueQV/l5beVKfLx8hsrOoixKuObKOq1URKM7f21poBh/XSFrAeH4RunPYimNJEgA862hM/2XFOp62MiD23Erl0m32Kcmk/z8r2daAWMowJfXw7dDGnFQpTpT5UaFNJPMMx4vj/1cYB7TCj0DaqWMN5xMLSw/uAb0T3EX4KjXccdsi+vVuHLCCZikW8hYIWlMYEbRscG7iEbJ8qVtSCW3AX0FIFjimRWAz9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 07:09:25.9897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565a4d6e-d49e-4ab5-ecef-08d612fe83d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Corrected Commit Msg. 
Changes for v2:
		-Moved reset node as a child to firwmare
		 node.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..351b1bb 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,144 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+Reset outputs:
+	0   :PCIE config reset.
+	1   :PCIE bridge block level reset (AXI interface).
+	2   :PCIE control block level,reset.
+	3   :Display Port block level reset (includes DPDMA).
+	4   :FPD WDT reset.
+	5   :AF_FM5 block level reset.
+	6   :AF_FM4 block level reset.
+	7   :AF_FM3 block level reset.
+	8   :AF_FM2 block level reset.
+	9   :AF_FM1 block level reset.
+	10  :AF_FM0 block level reset.
+	11  :GDMA block level reset.
+	12  :Pixel Processor (GPU_PP1) block level reset.
+	13  :Pixel Processor (GPU_PP0) block level reset.
+	14  :GPU block level reset.
+	15  :GT block level reset.
+	16  :Sata block level reset.
+	17  :ACPU3 power on reset.
+	18  :ACPU2 power on reset.
+	19  :ACPU1 power on reset.
+	20  :ACPU0 power on reset.
+	21  :APU L2 reset.
+	22  :ACPU3 reset.
+	23  :ACPU2 reset.
+	24  :ACPU1 reset.
+	25  :ACPU0 reset.
+	26  :DDR block level reset inside of the DDR Sub System.
+	27  :APM block level reset inside of the DDR Sub System.
+	28  :soft reset.
+	29  :GEM 0 reset.
+	30  :GEM 1 reset.
+	31  :GEM 2 reset.
+	32  :GEM 3 reset.
+	33  :qspi reset.
+	34  :uart0 reset.
+	35  :uart1 reset.
+	36  :spi0 reset.
+	37  :spi1 reset.
+	38  :sdio0 reset.
+	39  :sdio1 reset.
+	40  :can0 reset.
+	41  :can1 reset.
+	42  :i2c0 reset.
+	43  :i2c1 reset.
+	44  :ttc0 reset.
+	45  :ttc1 reset.
+	46  :ttc2 reset.
+	47  :ttc3 reset.
+	48  :swdt reset.
+	49  :nand reset.
+	50  :adma reset.
+	51  :gpio reset.
+	52  :iou_cc reset.
+	53  :timestamp reset.
+	54  :rpu_r50 reset.
+	55  :rpu r51 reset.
+	56  :rpu_amba reset.
+	57  :ocm reset.
+	58  :rpu_pge reset.
+	59  :usb0_core reset.
+	60  :usb1_core reset.
+	61  :usb0_hiber reset.
+	62  :usb1_hiber reset.
+	63  :usb0_apb reset.
+	64  :usb1_apb reset.
+	65  :ipi reset.
+	66  :apm reset.
+	67  :rtc reset.
+	68  :sysmon reset.
+	69  :afi_fm6 reset.
+	70  :lpd_swdt reset.
+	71  :fpd_reset.
+	72  :rpu_dbg1 reset.
+	73  :rpu_dbg0 reset.
+	74  :dbg_lpd reset.
+	75  :dbg_fpd reset.
+	76  :apll reset.
+	77  :dpll reset.
+	78  :vpll reset.
+	79  :iopll reset.
+	80  :rpll reset.
+	81  :gpio_pl_0 reset.
+	82  :gpio_pl_1 reset.
+	83  :gpio_pl_2 reset.
+	84  :gpio_pl_3 reset.
+	85  :gpio_pl_4 reset.
+	86  :gpio_pl_5 reset.
+	87  :gpio_pl_6 reset.
+	88  :gpio_pl_7 reset.
+	89  :gpio_pl_8 reset.
+	90  :gpio_pl_9 reset.
+	91  :gpio_pl_10 reset.
+	92  :gpio_pl_11 reset.
+	93  :gpio_pl_12 reset.
+	94  :gpio_pl_13 reset.
+	95  :gpio_pl_14 reset.
+	96  :gpio_pl_15 reset.
+	97  :gpio_pl_16 reset.
+	98  :gpio_pl_17 reset.
+	99  :gpio_pl_18 reset.
+	100 :gpio_pl_19 reset.
+	101 :gpio_pl_20 reset.
+	102 :gpio_pl_21 reset.
+	103 :gpio_pl_22 reset.
+	104 :gpio_pl_23 reset.
+	105 :gpio_pl_24 reset.
+	106 :gpio_pl_25 reset.
+	107 :gpio_pl_26 reset.
+	108 :gpio_pl_27 reset.
+	109 :gpio_pl_28 reset.
+	110 :gpio_pl_29 reset.
+	111 :gpio_pl_30 reset.
+	112 :gpio_pl_31 reset.
+	113 :rpu_ls reset.
+	114 :ps_only reset.
+	115 :pl reset.
+	116 :ps_pl0 reset
+	117 :ps_pl1 reset
+	118 :ps_pl2 reset
+	119 :ps_pl3 reset
+
 -------
 Example
 -------
@@ -25,5 +163,9 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		reset-controller:reset-controller@0 {
+			compatible = "xlnx,zynqmp-reset";
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.7.4

