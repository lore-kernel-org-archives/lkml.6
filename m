Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A9C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5932087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2g/Yso+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5932087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJEETY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:19:24 -0400
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:24992
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbeJEETX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu9jKEjQMvfpglDe1otU3GliSLYmUZ2vgVVdA8SiBFA=;
 b=2g/Yso+ZcbaV0SAiag6OXUhNa7s4c4RyTc+A5WGJ2SRI6WdRP6JzUBsSHT8VjsJI9wo+qHt5ftNfXlTZKqhpxlVlg6pI9qp6ppE3Rh1CkXrY0fY3/gckuvmrV6TcotiR9Q+KpsaAmfnFyA4Hf/g3b0zHv8IKASCwwirJpeoKof0=
Received: from MWHPR02CA0028.namprd02.prod.outlook.com (2603:10b6:301:60::17)
 by BL0PR02MB4755.namprd02.prod.outlook.com (2603:10b6:208:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.18; Thu, 4 Oct
 2018 21:24:06 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR02CA0028.outlook.office365.com
 (2603:10b6:301:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 21:24:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 21:24:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6J-0003dW-RQ; Thu, 04 Oct 2018 14:24:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6E-0001wm-Nm; Thu, 04 Oct 2018 14:23:58 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94LNubk006250;
        Thu, 4 Oct 2018 14:23:57 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g8B6C-0001w6-Oa; Thu, 04 Oct 2018 14:23:56 -0700
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
Subject: [PATCH v3 1/4] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Thu, 4 Oct 2018 14:23:38 -0700
Message-ID: <1538688221-9823-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(476003)(126002)(110136005)(106466001)(72206003)(63266004)(106002)(54906003)(305945005)(44832011)(478600001)(107886003)(7416002)(2616005)(36756003)(356003)(16586007)(486006)(316002)(4326008)(2906002)(39060400002)(2201001)(50226002)(36386004)(426003)(47776003)(8936002)(9786002)(48376002)(5660300001)(7696005)(76176011)(50466002)(81156014)(81166006)(51416003)(8676002)(336012)(26005)(77096007)(446003)(6666003)(186003)(11346002)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4755;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT054;1:WaRDq9iIRlNCyVCdE1f9LJzC4COePCkbUNXiX+b9dQlp6ahJv5VT6JK+vE3CB+f3vKDz/HsbV8Jx+JFUnuLzgsIhiVkBLWwXLKmaKcYKGCEWgXgimz3Rb8k2GZ4AflIu
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b08b4b9-da7c-4b27-fbfd-08d62a3fb63b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4755;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;3:GBadNZT9EPMeUDURO66onnxmMgGm6wwKDe+xSYynKuwceGTIgYZ6j6rrHDrjjG6RbLBcm9xCAVk2uee2YzXTo6snBstN+r+ZRndda7mmMCLnWKu7P8JJI28CKoF1xJIerXag+PEZbFQVc9Mf/K/02UcgnThshOpN3hoIlTIHCoDUmqXc8zf7GCvOj79mzI1DchbwkLgFD0iUBHU3Wflx6bJXwT5gklPdFnwjAO5TD928jNBrtU+ATqjelY+ynza0z/W1eMdfep0EsJv9leFWD8+xiZMdfG874CGamDcm/7mckWoHwM/61BUd1oHwVG7RAo7vkauGR3POFXeyJZgYvgOEYnVvp1abxqqrVt1MoCk=;25:+4/fJ29DkeN5srz76AaBSumwN9D1BoNIrvZ5+r3Vs1OI8bdWLR4UPhkQZuc6jIsR5tsBY0WzgYT3ANftAGAUuGh8u/YnGpltZOCeukIaZDS97X1Fe6+iJOs96iPs0jYRaxwysj9OB31IvBxXz221EABIZajQuYNzNvM8a67rA+968AO7oDjWIwrYvf4Y3btzz1rIb/34BGV3s/KezsF3sRIdMWz4s/vM/pP5W5jov1t02yOYeEGtzlsZEHOL8cwcxfQR0aZB36jZgMpZs0tkbeTMm6e28aD1hgLVYZuj0AzRMm4zvE7RDuYsFDyGB4mYhaCzp/Scbc955Y9WLVkjoQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4755:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;31:Euu+bNNLCHTM2DVzb8NTLZ3ETJik2n6JOUNp+q3ZmER/u5+JS9gyNwtHu+m38i2VeicjV1MfLwK5z8Wu+OQ908VJXFlrkEun4NJl1WtqbvsO5mQfFYzV7QTETM4PlYFBuaqDHbNA642+/wNLYoPFKjNojMIgtSD0toEP5Dc8lO9Z/xkdivfT/QkFvMfzVtmFg0uh5l0Im5Jm5bcDi2sa8zc+8c6ZgorK6tfc2b6I0WA=;20:1OBVmwcabii553J7ooNXBzL/Y97T639iI8kvcEJmcVKmhTlT19v9e4anrknnOUmb/7px4tda+rep8RlXGQGjDkrA1KERAC2yPDubiJIVwZFUNiVvRka5+kjgrnuQdybcXf862kUizkcqv0mEdm6VSskRdY/gFEIP77LAXkKydi8CNbHfzw/0R4MSizSHmayOJRaYfIkheEFw6vwwXETvqiZTyJMvZ6hOhN2n2HpSyVyskhG3qkMe6Nzk/SjTAhg+t0yCUX7s9y5K08nKw1BQ67GhqlfOk+Efz0ebCMrLtDDs8sqFiP+6qPEKBEC+ra6mGtbDVUqISmTqbapPG027NpceD7tkWL5AyglCqtWV0gFHOTB337fTCr6GHO0wDPLqtTCfu6/du2nF26mlgHcY35pDr6a43nhBNlRqyTWmERQ6sZEi+sd5aJo3jeNlZ2pK+nqwESHqYZTKE0ZIJ2h4k6KV3KDycOEuPg/hMmbMwcnedndvbnCWcNYgLr+kEpeV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4755C69E751A4A66A92E4C16B8EA0@BL0PR02MB4755.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:BL0PR02MB4755;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4755;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;4:fMsovgBbMTmNjjWUhu3RECfBZEWCOPbE6NwRyo+XhlLd/B+lsVJ3iFjU0U8AE9IIcwJwDt8PD/p8QYE1vwAJSKDdv21SiIEdxSljsa7zdgPeq7j3iBv3A01Qr4hVFPPDKy3dxWo38qW3jQtyVLURURAib18PxEMMBhbZNb5VnEFtUeT8qQqIDQvh+qnTGrc6wNRAurvRzx3fOvwBcp7hwf7+5GOxhEGVNRGM6F8mdMZ0k/TxYzdT+VS/scB7wVs2/k8HZp/eqNqMC+cfKzx/IGRfXOWAr5lyE5SbyuaoO9/lxeZiUEPpinvXhmCwkGSuP3SM7Y8bB+T4tcu5agMBAumF46ysmHe+w5m8wXk6ylQ=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4755;23:ZY/mK3F86ljpi+vk3CbP809TbfkOTqqRAjDbL+Vxb?=
 =?us-ascii?Q?vjSZI6JWVH5KEWRLIch21wCBBYcd8nJ3WoiAH5V1AnW3KSudM3mLaIZlk7r5?=
 =?us-ascii?Q?BTo8Z6rhT4q1Uk4qKFU9kve2jbiZrUJ6e67FUAChxCCuMeFNwfxhowU4jHio?=
 =?us-ascii?Q?TOFuwBy8UHmnaGYfEezZZSomUhC2XBtpy4z8goqITOgSMFfGCMeuqnwmB4bn?=
 =?us-ascii?Q?iwDK1lj68FIp8bZF/2dM97fHEXd8vg1ZlQ/15fT1+kZ1SrLfM2nCS7IZrbTa?=
 =?us-ascii?Q?lAREyXkoHvzZqXZBdm/Cp/WO95Sz149ZLMNCV0GVFD4jXSIHu5Jdwo37rAnG?=
 =?us-ascii?Q?Gye/SPNc/ra/9+aq/HOXXHTzz2QjV69jfYtXPTou2nELm++wKf+x5O1Gg27f?=
 =?us-ascii?Q?VfK6iOJVC1/+MWMK4yo1vpRxzZ7rqyrieUcosE6pwEJ+9gfUQEOc8WbKFVaE?=
 =?us-ascii?Q?gKHSqJNzJTZ06mWUxzwkrDHhwunu+W20+5SCJKa9X2jTe8Zg0S9oM7rjZhtl?=
 =?us-ascii?Q?EPWEqQUPJc4OXmSOVb42rcJS803Lm9KpluAVLqIf2Tb9RooDOcISyufek1JN?=
 =?us-ascii?Q?Q4XAL3e1EWBbnSJhQ6QsrxR2V0DzH9z6srMfoOutY23lgDmy30aIMIy6kUYp?=
 =?us-ascii?Q?pD6afI5+5QnB9SSZrEJheO7rdOHyelyKcaKRHv/RI1Lks1zGkq/AOiBAchw0?=
 =?us-ascii?Q?PnuvitKI4/FRnC0vC+vie2pHiiMdU84xaLP9HbyDa10noJLmNgEBuyzGy4cF?=
 =?us-ascii?Q?K393J84iOD4IpUrq4od+nfoY/jxpsxbiyP0uiK5lmgvIEYqxg2Pa2YVzMSZ4?=
 =?us-ascii?Q?myNUB/gw9ZaP3PsY16VtfrFACWweAxNf7IdBKeXuCnUI7QflD+kUG4MqAEab?=
 =?us-ascii?Q?C0ZiSuel0T2atFdRLj2RmAmYSsU5KpqqV8HQY910aZI7euHyhMi/J/kmWQQS?=
 =?us-ascii?Q?uhC8Fm9QeWxYmatCRR6Cyen77qMPDDYQr0B6EJOMfnoOwknYhzugAGuHDg/v?=
 =?us-ascii?Q?W51ZZUWwzawI8r+o4sE2wIKfm0HDkH7Ze3mbBOj/h0dDlpk6s1pnSkQxwMXd?=
 =?us-ascii?Q?N7JLC0QwD3n4qOCv9Ki0nP5R39hIN9a+GpGD29nXxHChlOQ9QBL3sU+r+mYC?=
 =?us-ascii?Q?75soXWuJr+aBpquSD09MtLNXEbHUHlQQl31GaOaqcd9lbxERTjXkdWcrS0nM?=
 =?us-ascii?Q?Tc7aqHxy9HNe4/5y8VLWe1ZDs8PvOA43wAHv2KI3wSjBJSYvqpI578jFSGTK?=
 =?us-ascii?Q?Uam2quwYAIxIxC4Zi7/XUwl1T2ASe+yA+tHxWEKjSGDiGrZG1u6uP2xkdIlh?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: VrsuiFoDh2zSgdprwPVTfIbwoCSjdCKqHnutuoS1zvYNgcNggskU6fno1zAQDbK7KVcOvduCCesrO57juB9lvb1mMJtZXHj0bqM4cq2BhLDVcHRuZOjL8yBVnVpkbOxeXpsVc2Nz38V9Cv0/EpkfaNHtVjN0XVyZPgvW4Y0ucxx64nGAi4KkjctrB9cS5jocNsLEe2rGZi5ty0nBxYpvLBgog1g0ZU3pvRYcuk+E/c24+ZSR+joolndxai8NGxw82pXwKgcP9f8O1tyLd7lZF5lIR3B5bVo7LK8b4wbCmlJocCVyjdEJbsxerRuyU0dB23dZpsWIo7SYcmlfaYQaHvYxBwrYApMwBxtG/31+jhU=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4755;6:/Nax7iA2kIvIXYBzGzq02gGIacPL5Nha43Ixh1pe2s83j/naSxmruH5t2x4Ki+d92wohaFd2dSFPp9WQ8J9h0GHgOKxxDo3OfQvMqUZaMe/sN9sNh3F9GoyzmUx0ufGBC9TfB/ciRfE61vAEVmx1JsPiYXGOGOxvfNXBTIl2S2zKF5porQpdRA9gT0it9KYcPH+UJjUVMHNmo1mzoPjYi0+M7aR/z4e296ohORiwgGSf8qtAFnFcECOLp7nzONfWJQwcCPC4K05No06WW4hiJOKX8/pCFz4vVdwZ7jRt40ANHHlVuAhTZKPVP19LNi2DNCBkExso8hhVQKjPi7CKUJTx3MRaeI4gRpT9soc8I97WRYUAbwDfyh3MeAHIb47/hlWWFNWqppI4mCCJjU9dLT+F/EQUvaIQ/kAIkzLLEmNzj8nGF8OSS9l4PYzBS1D333hSsKsWOoCNcH/6WSvDwg==;5:lFv6q0q79wGH9ckynpFGF6LKVe97E11mt+NW1Cwdcg80kbv54kd/Q5bUKUEolsc7IhptIIzoCZ4YwjC7J9RhJPNaoMGnKbPxEMBrh4oHs8151Cdf3J/jMIfRsLaLgQWQ3KhjymoC0Pg8B4rmB5GGpe41ZLSB/0dqdOMpbLPG8K0=;7:+Fhca//GlSFGI6KZg/EwNka9jyiqwcZpi6uT7jxZ1nHG17nFrnyGCRyDHjvIHpI9v/sXLPnItfKfyUGNPiDa+SAWPWI64M8jde+wpASVLRdFRMrVghwJc57KdzwrvwtlIxrlJLRDysYBrHDV1AW1I8x/J1XJSrAM7MN6n6KDicupAnND5jpG+DKjZuN+Nw/Vt/ts5ceaII7/Wp43n/lyz/UoUA+ogGtlUG82UfgkhdvR51Il8UCU7XMe88zVck70
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 21:24:04.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b08b4b9-da7c-4b27-fbfd-08d62a3fb63b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/power/xlnx,zynqmp-genpd.txt           | 34 +++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      | 39 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
new file mode 100644
index 0000000..3c7f237
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -0,0 +1,34 @@
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required property:
+ - Below property should be in zynqmp-firmware node.
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
+
+Power domain ID indexes are mentioned in
+include/dt-bindings/power/xlnx-zynqmp-power.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#power-domain-cells = <1>;
+		...
+	};
+};
+
+sata {
+	...
+	power-domains = <&zynqmp_firmware 2>;
+	...
+};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
new file mode 100644
index 0000000..1bc9636
--- /dev/null
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_POWER_H
+#define _DT_BINDINGS_ZYNQMP_POWER_H
+
+#define		PD_USB_0	0
+#define		PD_USB_1	1
+#define		PD_SATA		2
+#define		PD_SPI_0	3
+#define		PD_SPI_1	4
+#define		PD_UART_0	5
+#define		PD_UART_1	6
+#define		PD_ETH_0	7
+#define		PD_ETH_1	8
+#define		PD_ETH_2	9
+#define		PD_ETH_3	10
+#define		PD_I2C_0	11
+#define		PD_I2C_1	12
+#define		PD_DP		13
+#define		PD_GDMA		14
+#define		PD_ADMA		15
+#define		PD_TTC_0	16
+#define		PD_TTC_1	17
+#define		PD_TTC_2	18
+#define		PD_TTC_3	19
+#define		PD_SD_0		20
+#define		PD_SD_1		21
+#define		PD_NAND		22
+#define		PD_QSPI		23
+#define		PD_GPIO		24
+#define		PD_CAN_0	25
+#define		PD_CAN_1	26
+#define		PD_PCIE		27
+#define		PD_GPU		28
+
+#endif
-- 
2.7.4

