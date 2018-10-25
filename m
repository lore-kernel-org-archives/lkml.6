Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDD12082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zfZeV+p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDD12082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeJXQBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:01:44 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:44064
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729394AbeJXQBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQjIxvU5oavkHjKt6+zhbdpEdMfLfESSegmi1vwdgdk=;
 b=zfZeV+p/YHmSkDsenxFpQP/PvTaDve7U4qN1USVdlN2ae0rls6AK23GHr2+mytXa01JzN/Qq9u+U20aT4+675fhJFKxNKs5CU0qxZI+E2lbrtCLyAAlVVwWXR5fkFo4Gs8CTsg7NfttKKQtfOPD1ULNEIOctinXHtEQdk6/2RXc=
Received: from MWHPR0201CA0098.namprd02.prod.outlook.com
 (2603:10b6:301:75::39) by SN4PR0201MB3519.namprd02.prod.outlook.com
 (2603:10b6:803:44::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Wed, 24 Oct
 2018 07:34:45 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0098.outlook.office365.com
 (2603:10b6:301:75::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18 via Frontend
 Transport; Wed, 24 Oct 2018 07:34:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Wed, 24 Oct 2018 07:34:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57066 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDge-0004Op-CB; Wed, 24 Oct 2018 00:34:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgZ-0005zV-89; Wed, 24 Oct 2018 00:34:35 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9O7YPF3009493;
        Wed, 24 Oct 2018 00:34:25 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFDgP-0005vF-2c; Wed, 24 Oct 2018 00:34:25 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Thu, 25 Oct 2018 13:02:05 +0530
Message-ID: <20181025073206.9264-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181025073206.9264-1-nava.manne@xilinx.com>
References: <20181025073206.9264-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(438002)(189003)(199004)(39060400002)(47776003)(9786002)(478600001)(106002)(7696005)(356004)(36386004)(305945005)(106466001)(63266004)(50466002)(76176011)(476003)(51416003)(36756003)(126002)(11346002)(16586007)(316002)(77096007)(5660300001)(110136005)(446003)(2616005)(81156014)(186003)(426003)(336012)(8676002)(8936002)(81166006)(6666004)(486006)(1076002)(48376002)(2201001)(50226002)(2906002)(26005)(107986001)(921003)(5001870100001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3519;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:xVW6ZQTHOsxXvMBSXFb4sJbqJJeG8i09NwSZZYxf1tAkGkJVCfyfAv2WsVjCTAdf1Aaky1KA5PVcT3YN890a5/xt3dN5L8twqrTFr67jAGwADCi4bnnbM4ID4/Ivpf65
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3479e28-2580-4dd3-e6af-08d639832b17
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3519;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;3:HQXCvNRDquQdCFUJK1721SqNCbw01n/SkyJ2E1C1Ydb61/xJc7xzx8qJEYjFt3IHBX1plv9nAK0svAjiHIrLB0rexlAIOBQwuOK4UWVzJJXhy8Bt2f4e/jJR4MoI7YqYShL8d8OnQGtqutqZoHHxuuQWZgI6/IfAoCE3nhNHEmeLSQQYVGu4+OeJ1JdP941OgbICczX1YzmBZBcYKzGwnS/vHEN9zLurQSlRyGMVkA5yrEljYpSJV/i6f8Blr0k+mYBiGhE2euHz6SjehvhaHuYlOm0sNre0yw0tOdaqP2qiLt+VnXCY8DhDTSApyElG3ArgDUWRVd/MFH+ObOaTb9zMCg9IALJeJs+DgR6fDvQ=;25:MTZaK8PI5besg5VCl6GIDF+HSnzmGHqnGY9En2TlJXe8eby2DNwHO59aStdBgmVkkDJ+Erfl4XDaorSqoq3SO6uo8txhOoXqS28eDmSb56uDdoTI6NDHu3pvXL9f3HARkbvCY9ieJdi1T2vfnQdKB8zX45I474uX1/0bii74N6mMDxtMn/Zu+cWC1TgJz0bIPMGjGYuI9g4BQWoLVFOXHuHiWogIx0XQSiF61e6TLdf7FU5dWeFZtz2nkMW1uV/tMuCbEAZZ+ytQAGcFlZryQMkPcmCTbdGLIF+YDW2aFxlNNOYSdY9RGv0osp/7o8s6F7dHJaTyTkhmIx/uetpTLw==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3519:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;31:JofG9TTihy9JuGxLTvPf2H53gbW9VHnYu6wNZXFaKu6jSPM8RcyY2YbrVQZwT/EZ0C3bOZ/v8k1ynxzffC0ZBUdQSiThk9uNNH4uiEMjpoTDFu/qSZkpxWjiOg3msXYVb8V83reNYmoTqncw1ps+sDJeraHKalSRP4mSsHBdxWsqWCvO9eMfABMc41Y8FxCQBw4mpEHhPPb3BWQcv230A94f2PswKixLQcvdIZs6Q7M=;20:osKhcA7C6c+Ty6dbiRgkOERmc53oArLUk4qOC/sl3dbkOH4U2dmV9zJxSO1KH6ndQT6Y4g2sLu2ogh5P0Q2OTmfuLvzdimeunBZFcJHeiZHOw2YsAbHJxznwPJcfmqQx4Ufw1lHON0/Tfu3M0FsKFWhpWbxWdImgoFvZoSjIbF6pjuchFpvaxh0JkgqTUXE0I0cUQkMcvuUvWS59CowRlp0/K078NMUHP3TEszXc8iFi016R16mCtB/j8U2OGh1Nl7Y6JR98RMe3/9uRL4Nn1pQ1ygPhUrq1LrhWy7/dFM/wmCIS6XvKmacb40oOELxvmw2v/HQkyU+KLl6Uab/SC98ioAmDicFL7v2iSePp0EfkTXixcRC06oe/eAE6nt+JQqhHSRr9N8pGORE3wZ4mYHDaBFQoKvsrFHNqhWV2p2hOdoK4iYFKm8+ny/1IC/++ClgUAqUohjEH+ZAEISu2K39/CO4N7tcWxsfMhUEn06sH94o+L1lfOVFxKg+Awjkj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35196EE44FB6CB06231B69D4C2F60@SN4PR0201MB3519.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3519;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3519;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;4:C3GCc7IA5uAZfDHk9/GKlmz2xxyh1MFWn1KGuhFau3L3Yjdd5RpZXNW8q6q/n2IRCH1p+iWpTYW7KjnsrdBqzxOW1RUABN4YSY6GJKFwz7J+Ah02831q954Tsz1OsHeSFPtwzBbTlG0bmEskpjskMZqFmUsFXiJXQPP4C8bvF730UQ1aEnyRHmCR6wflevZFe2evfohxAcHsq9byHNSnToD7Lt+lIR+i3qZMpJGmD5QTKdbUnoTLy2spwnqLT4upK2xyy9cJYJt2mauzAlzpRvALDU4+CB2KrNDvHUXuaLR1ZJtCwrx578tt3W0WPHdT
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3519;23:DYnaNEwj7o3NTyT4/RPYc+wdk6CgjhUViqAgJ1W?=
 =?us-ascii?Q?wSg3v5fqW4MmDXTQU7BoDGi/TaOnQJIZZ1d9k1y+ju/EPxVQnq5mMS4fGrv1?=
 =?us-ascii?Q?Xppr06XPQsj87ZPxa42KM8eOdoJYoPQul90BgVAvQTf4nDGKPztYi0B5zsRz?=
 =?us-ascii?Q?P+3jOQYYRPhCTfn/GpGDTmrGrIS2M3tYJ+Ggl0eVbDpotdLrBirSKnZiea20?=
 =?us-ascii?Q?hq4qHSAPuPeZQFrQw7xPFmswbI7l8oCfMUH5r65/Pwu1s+WxKbQnMvepEDTM?=
 =?us-ascii?Q?sW7VWI3eYefC31bY2wuksENS9pY/WGLhVgV8on8GcdEad08+nobIe/aFBFTu?=
 =?us-ascii?Q?kWTu8Kr2RVP/Ry/Swcah1vdlR4qDHBkMDp617sY6k8RISfBOa+k3dJG2hK+i?=
 =?us-ascii?Q?ThC9zcfF/4CdBHY99pMcSU/sL3nSjO5XceOHqsR81q03pNHhKWOQRmfllFnC?=
 =?us-ascii?Q?JEJ12V0ycbVKbr66/HeCZNTjzTwP6KKfyONa6l/1+gUlMmOoMAnSeRK/2r98?=
 =?us-ascii?Q?SY5B5bEBv5E7Kxp6bpmXpzpY/1DJ3i8d55PDlGoJG4TFRvPnlgOSybrS1G7r?=
 =?us-ascii?Q?cGvDQqzZwFOnGr4/bdAaYa5mcAfbXRECl1lWFLOqi1H/0yHnm3eYAKnrDSfp?=
 =?us-ascii?Q?fPIUx/5qqOuTjO5I/fqM+VsrV0E4RJeeWU6QqtyBwwdfRoBxoT+smYcCmKh5?=
 =?us-ascii?Q?teYNdGRteSCkjysHZ3lh/Dxo+VAVWC4+tbdJiWNen9+R9OTpLIYDzV6m/PdT?=
 =?us-ascii?Q?ZSUdUEf21+7qy98sOGzc+dPNeS7hb5r+mA5RECUUzvZiCZk4wqSd9KNVVk9p?=
 =?us-ascii?Q?CpZnwEsysj7NqUyA1zNqYsCh50ySkb9a2I033prQI8RZZNqjIqtxDbJzr97u?=
 =?us-ascii?Q?zkbhyP5iz7F6hN6+bsVbSmRjsXlZnuRa6FTVkPcE7iCbxnoVw/KfMxjx0oBp?=
 =?us-ascii?Q?aChyMZ89oiorXJvA6aOgJ6U/MDvQhvQ899eUpnJdM8SoZF2NGNA+lbu3Xm/G?=
 =?us-ascii?Q?/vKCfqJmaVC0APb5AMke3a57ZXagISwPTStvCaVUSfimDBrcRRIIH4jkLevB?=
 =?us-ascii?Q?CWwKnyIU71WN53y7n0tcfzo3ml55ToRXbCthSztGo0e6U9Mky0QwZLzqbGVm?=
 =?us-ascii?Q?i44qNyZjwtg+IkUwfYZQ5E5QOMFkyS6p7PRpSK3R7jj1ffBonKeT1XRrlttR?=
 =?us-ascii?Q?y6/Kd6n/mAgdtYNB5wFvSI2bewvOF1xsMREDqQhwQ+MseKeMv7acJPnudaw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ki92o1f/CZ6YNK4+jU2o2bxMBYqaZM61z3bNzsebRGVHnQ0OtAu1usUZU5OFMd8T1+8hGRTYQlgJxmMGXnkxq1pIEgF0crJZr+e6wDcrKjEAN+rT0VEFOrHI+rqWU0IMrfbWoFW4TZ6zBzftjFszUlB4OhB1Mg9Inc3yxLUcTkbsO7GVukKiKiyycPPjSnh0O6U3gNw8jNgI80M3CFmrMCzOc9WgOX4gGFcLO0ss1qBTxZd48LbFIJzI1TVSKeXjRhhqVkpjGT+X9iUDwbcVQ675yUyg8EAaetYwOeJvurdJ7iniacefXI4wtNrOFNH8AnooUr0lsGn0kec+JYDwuovRMmbHkoPAaOh0yWSQ08k=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;6:pHLHeh8wnklf2Hd38Od1jfzxZ9Sw4ECEI5+aBdLIt8wE4w/SWSSt0wIcbMPPQMh9ZootXxRZfp0KI61C4kwCLn94mhdCSgWAt74fc67fQrP/k8JtaHl3MGNnFipDaGyUymnZhsobDApMWynbDtDrh7va42FBvJ4WBZUU8+md14LGflhOD3C60pD9SX5WK1uc5gnBPfCozaPG7UkjAmDeIks2nfw5EufR2zAbHooCq6/sPSsN09oR0C14U7wpGiz4MVAXTlNrPqzMZG9pHJPI/mcvRZzUqzllzqwKpCYRVroPS8W9cMv0ymKyYDPR5KlSdIOgOlPNCx7HYu8pONRDVU/SqgmxTcGJdhEGZE/PDPRP1WHTD3OxvIwr6fZmMzE/kE2bapZXugzXhiFRHYJiZ/jn0U6Mqr1vgh3EZE1oP7J9JMrRDk27dFW0g93zi+5h1OsUCVU07ydw4gIX8YVGJQ==;5:frGPsBLR6CL/9o6fjqHNmZZcwh8ir83Yt7I/RoAPsXnOOuDXZHgXcMqlB3rfrOnO9eaBard0FuXytViJKQrCcy5SoMnyH5CXGdmTUNQAcZUnXsX2nhjAfwZm1nQbw6arekzBOix+1eS66AJ8wVo7FVf21S/CY7HlidG6zNCU7EY=;7:lqkSYRBKiSPTGuGiDzJTYhdKGXrLg7kCn1EFJ5zglSm+AZad+WwFFFhDfF5DD668utsRU9bkCTAo72eaupOzao/8RQtuRzzm1deFGTKwhGntVp4GxhU3P1CyH7ht7riEZTHfeOgDyOcyGiJkVPuaMM47tnuIaZx4hSxJuDHbRdLE7l6j7hgwPkRdrHSRVqlVUCOf1WdloLPNxvsVoFi83fTn9D77CjWlTpVDx2eIV0Dq3+61oBCN6P40bU9Ixqsf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 07:34:41.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3479e28-2580-4dd3-e6af-08d639832b17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Removed "----" separators.
Changes for v1:
                -Created a Seperate(New) DT binding file as
                 suggested by Rob.

Changes for RFC-V2:
                -Moved pcap node as a child to firwmare
                 node as suggested by Rob.

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..1f6f58872311
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,13 @@
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	zynqmp_pcap: pcap {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0

