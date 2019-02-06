Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81131C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F2F2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DZ7uhoou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfBELHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:07:09 -0500
Received: from mail-eopbgr760071.outbound.protection.outlook.com ([40.107.76.71]:10720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbfBELHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a92ZS1lr5ZQxMsaLPQc+uukOOVmZXgH32yzbv1Ek0I=;
 b=DZ7uhoou4Ijbd4WcZm3CelvLVORc88+BopVcey5w64BEb0/JqVLF8bAfGJMKjEzf8LRY6gXLd6qS+BjLkBo0S6cbjFR1gdrp3Frww1zuNEZcAGvdEQP7mNNbneTPhoXi2P/QSsRhp5uHpdRG6eVsrQK2qDi1HbC1/U3HF01k5oY=
Received: from SN4PR0201CA0007.namprd02.prod.outlook.com
 (2603:10b6:803:2b::17) by BN7PR02MB5009.namprd02.prod.outlook.com
 (2603:10b6:408:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Tue, 5 Feb
 2019 11:07:03 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by SN4PR0201CA0007.outlook.office365.com
 (2603:10b6:803:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Tue, 5 Feb 2019 11:07:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 11:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZC-0001Rn-6X; Tue, 05 Feb 2019 03:07:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZ7-0001FW-2H; Tue, 05 Feb 2019 03:06:57 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15B6pw1020310;
        Tue, 5 Feb 2019 03:06:51 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZ0-0001EM-6A; Tue, 05 Feb 2019 03:06:50 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 0/3] Add nvmem driver support for ZynqMP  
Date:   Wed, 6 Feb 2019 16:37:18 +0530
Message-ID: <20190206110721.27765-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(189003)(199004)(8676002)(81156014)(106466001)(81166006)(478600001)(26005)(1076003)(7696005)(51416003)(36386004)(486006)(8936002)(4744005)(50226002)(305945005)(48376002)(77096007)(186003)(63266004)(50466002)(106002)(16586007)(2906002)(426003)(9786002)(47776003)(36756003)(316002)(110136005)(126002)(356004)(6666004)(336012)(2201001)(2616005)(476003)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5009;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:itio5U+39lrbic1AGStzZA1mirf16NGbA8hEnRjlgkx/MU1VhSfelkh44FLg8OO7hoYxk3JV69dfpReslAc29g4thc8wIW/hNtOjMBmtkdshHGv9xZ9axVpLt0Igk9qL7MaiuUmUhnhx6T2VwkVyZ3tG2qY3YxrKchf9w2HxjOQ=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d647a6f9-da17-4b2f-2147-08d68b5a0eb0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR02MB5009;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;3:6fmPyd09bJ0jI+SgfFKiueYE6MqMGGQ07OyFmb+P5fF188Qpl/5B3/bi4sO2kRlyH7u0wUrGEh4WALmGETWw6NNBLNVgqvOjZ7WWwKhCEGCZs3fwmIlaDw8R8S1A01pGb9g+WnVOmdDQjvhHFlRBNIpyb7XZSJqgqNs1ucy9gi8SF++SFIMZs1QRTlL8kJM4SYxrt5Wk7G8uunSh2+LsBvc3k+75oTrXh6lrvPO4xn07hXr7bQnLYA2XrICeAJC1AqnKa1t7fnU9zun5b22wbspn7WD3GiVAHd9+aoFwG08qKlILQZiTJSMbnBje3nCIvloQBQlKZjAlLu0fi+SD4sgVelQ1v+RvtRbXo0IEHi3memkTGRTNdwSgRjJiHUtt;25:EX+gazWCyHaMsfd2gkih58qPLDpg4eLm/uZnyZpK/SrI2P9I2jNVQ7Cdp5IQRaRh/AHAZlNVEshxt5wuWP6S/ggpYV5LparKDctJyaKaU3kAjdpTIfCL30PtAfYvPOAcyTzpztI2BGpYsmS+SAIBRIUaj1cxR12oa5J27RP1cNcw03MEgoo/mHasad5SkuEzYawMhpYGjUAuDqlQbLdnAVip0pxI1yrgu5Tecgk6avv5KsHRtWxR7i28Pq/dlfZz71sjmFW5Npb9NFRKqwXuf/tClI89Pdw7i5XkecDGdzelwJglNDiyaSnFvljEmme4rgpruZg3LxGCy8YUzi3VBw==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5009:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;31:jWdPvnjLHlrGogYcOkO/r3iwTNLPg0K2aqw8SQi3t0vS26aE+cJON20tVsu2wL/sckKhsovGOXu1nUfXQ5RIgzmXQSmq2DRiPRuG40p/1c8ZmVxEbaG6B8QvghkWeTV/ioDXlpIrQR2mLrn0YYNhIYGvkIzuxraeMN+YWpyYC078mC0KVlnXDCjKxGFER7YgnDDyRLGsg7MVKY36NCBmJhLqH+wOC7u4Riv/vHw28Gc=;20:evmwEKUORNt6AhgF86khWscyF7pAXkwZwDqj2Lgj9MLtRj/CXt1dWE+Yosg3/iysxZjGbaYp+mgIhXQkyCq3tIKC8/goCPGi3IzVunLysyhA+8Cewsam5L1I8BdyNWyOxFW7w3uz66/YlhqV678rcpnyyqNKerX2qYMz7guLbYlrzQv5kbRPT9sR2fkNVQZ2FuHJiU78x4PWVOxRlOzofXgunFBkcZWinQ01pDsPN4N4G+HUZ8Qz+p6ENcbZS1UtVY3kX+bxCgw3068x38OBHOsGOGLCWOBzE72HSIhfzy54mFBrYiPpTcnlzk/FQv7YdII4BLXxpBVQht3MPNS8L3l8tGYK2xI4PIUsDry+AbUPuw1jcLAteGaPyjxGGdx2MKzVV9e3KxBgO1YjWsVGMVHdLU2Pf9mMI5RcaYsbuimre9c0PeAL+BhtRF4aERt+WEEirto1VHWF4Bh3LrUxcDLtCbe4xY9vuitYZ3ggRIA1qE1DPFoEYZyanRibsQdW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB50097FFD7171604B4491A717C26E0@BN7PR02MB5009.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;4:t7xQp8cMnZ8DHEcDU6CJEPhVk9df9zrHPbTiWOJChAEXI9bt1pc2GDXTRcM4n27ScLPsdzIvOQby0rfu59zs0Ie5vMRRst4MTKqO2jIVL3KdVGq1XmEZOTcGz/3ucYGrJrrMJlkdiLcNGkIOOJeJxs6EmC3CM3KGyRP5z1/RzkkViXUt6Go0UyPUXEydKGhj/AIMSR5ZK9KIP7EUcQfCYv5AHBOcQNggiCyKOT2X0EUMnr2MqNaBHbCe6Rx2zR1t7AuoY2wyEwWa3SVyffV9LtgEoRaAXl9GzNSqdXiK07nxdPErreJhCRvzNJySjb2C
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5009;23:P+bM2tFaAHxjGZHzvPFNKPe3PTlpHqllcyI0gd7ZT?=
 =?us-ascii?Q?IqP+tXRgVhYT10Wj1hVCwUG+ZgzoYOXCzthrDtIZ44eiTSrQ7qBD91OcZ5q6?=
 =?us-ascii?Q?FF/H2g10V7SjxQ5k8txQ0zsuad3pJheLvuQD9uArfs6gyCmKOPl4pB0mbdKs?=
 =?us-ascii?Q?YBXLG4+RK/nblWZ3FZnnm8UfN+xl5qbSYXr7O6L5BS6sY1zEvzFV6zkm3R9n?=
 =?us-ascii?Q?1IjeKz8psoXhP6fyP5C7PygHIjKrt1vb57yfGla0O1JWzav82ANjGfkq5vf2?=
 =?us-ascii?Q?nasfbwjB7QfuWskHVtmhSlvvT9hnHZWzLMV7ll7689ZH5atSkQKe/fhI8T1v?=
 =?us-ascii?Q?DaGdHSVL/mrvrexLmy3EsgVMm25EJPEO4IDpGzwoc0bejQc+Sf8u4UovVsG6?=
 =?us-ascii?Q?XNmfS9PRw5AZPY6ScP+++cYAdD1Ya81z214rB2owF81SbM0kUmnehofGmF3U?=
 =?us-ascii?Q?19cNIu2PzF780rlF5iufpp4cvob4De/ZpLs/HvF2OTp/CP6q00XX0XBOHo3G?=
 =?us-ascii?Q?f4/MZn9IItAHNxgGrGI9Y4HNBC4/sUvHXKmwcytqeRc4txV8junKSC0MyYdu?=
 =?us-ascii?Q?6vmjyWOlQDMFGY20WxXbNM6LUUUzDvsOQYvDNl8yPtgE+1e8zwNfM16lT+MN?=
 =?us-ascii?Q?E57r9GWS7MpfnRoOBnTBKECSIgpKkL9Udcwkd0x+6qs2VlVL+RjwSWFvhFPn?=
 =?us-ascii?Q?ogEr2BW/dGsKHAqkIbDxM8nL/AA3LZ7iY8TW6DPZHNdxn5MnaYnfrigfW2xq?=
 =?us-ascii?Q?e6blutJu2m9jErb9l2z2vJkWw+s0dZa/rPNC/qPKYg8fE5EwzDoqMdZ4M9WL?=
 =?us-ascii?Q?ae9nQO8l1gT7bWAcLYJe4Bc0v+03aRp8vXpVlvE6dABe078bUqZuLfY3JGN4?=
 =?us-ascii?Q?hCabzD1EdNUfAYHtgnhCmaE9x4T/lKN6xaMwYWeh4M9T8tNO+BqVRtDvDuRk?=
 =?us-ascii?Q?gsQKMQlVtvOFkM5byFbm7XxT+gj4PjIUMfdYz9d3eVIqehO4gwgmhLgSGFHC?=
 =?us-ascii?Q?dFm84xrWizIYFfq3PVGcRoHSKTtWN2TdV42aQmaCCo+u/1TxL3GK0h6CIb9q?=
 =?us-ascii?Q?Tmw4AF3/ri7eVVUY9vSMz3vBCbK?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: S3LAzc/J5L7UmTfEI9l7/V0S57yq/R/3oS1vX8v19EEMOougz4PUWiYqtOi1PEzexkQEJY61BHVg/RSACwiAwVsZgp1g5ypkTxnP7AILl5OXEYSNHqqgkaxw1wy4OH98U9w9Da6JbEcdUcuDTrkk/r8elaLru7dlF1KdcAMi/aNEBf5celSEKKORvYr0omf94KFQEecy0sLLImWV962eFYWkTlSxFP5Un3V2inS6cnHaCZleUAYGyCZpOatpppqqiHGuyFxjBjA6gxXrBIoQzhTJrJwJ8kHvpO0iehr6JPFp02H4gBV0ghktIh515uyFhAHQMhgWZVpumaPqqAV1UmybW/77U21Yt5829QV8b980jkJzQp0AE1wwRVK4qlQjyU5uLKfjTh7iHygt071y8lTqTxEL2BIB539RYHPE/j4=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;6:cN49BFaHqU3TnUwgna/GQE6nWc3tI8ILaWkv2OE2jReQsrvnYNtWKh+crxtz5vyrpSHCUMnASOOlvSxYF9z2mp6CvuOvYWNxQFB6MnqP6ewTqxxfBRxU9PgaQJRRQUDFXaXrK+7YsY+Fpf3nY+E4O5SgPI4WZVoHSIsQ47ErsAv6k/2+C/MIr/dmCUXcNC5RhT2p8o4Ta3KMkl4vHBolgtlUhhFIswz6VUjbEFvbeaRK9IZnayznxc8AJuRNsjzHNBn6AesHObqSpYDyW7almc/aoYpUwkoexRPgRibpssib4DFnDwyl2pKv4TnmFXuXfC7DcYbDvg4q9BCfLYVIvqDv91NpwqK7CP7Hbkz4iJs3aSwZWahT41VCO8KOgB8QTzGQo2NWNuXTcoE15fw9/2dSpJRDuQm0JXAF80hSE32emg2tW2L7PZU/QR9APhVl86OsvDzXUh5FpITfyQ0Wcw==;5:w22pijq0Ls6wSQ5ucsWANsV2xA1BgLAUPOS+mBhTH/wzgBSdeurAvQhTHQOFsSLBGBMC/bckM+RyLIGYWf8nn3m/VfnNJmTV1f8Cgpkte03Ac3D9wCJcn2zA1mzWA8EUGsJ3Iy23bEECHu//hon2miIDE2uAJWhWbNmgL+zJE/RVoqP2N483EoQP40snk+KXhbO3tOm2nR3ziuwa8uGrjg==;7:owLpx2fxJhqXABTL7RP4t6pBjNTSc2k0s/8ryguFhibyLiOfXCJ3kE7Zjrwc8fmKNeEVUPdTXeraiexlsHQEQ3Qiz79zgQGVaK8qBC8CLHl55tEfHNgwFElUHWrhMAIxhAxSMSHSwhjRcb/l99wFcw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 11:07:02.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d647a6f9-da17-4b2f-2147-08d68b5a0eb0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nava kishore Manne (3):
  firmware: xilinx: Add zynqmp_pm_get_chipid() API
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  nvmem: zynqmp: Added zynqmp nvmem firmware driver

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 ++++++++++
 drivers/firmware/xilinx/zynqmp.c              | 24 ++++++
 drivers/nvmem/Kconfig                         | 10 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/zynqmp_nvmem.c                  | 86 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  2 +
 6 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

-- 
2.18.0

