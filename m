Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B400C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2FE218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fC0st1r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbeLUI5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:57:55 -0500
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:64672
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388874AbeLUI5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/upsBXiWFcBkiXwIzP/sqKhEHtHgdDI1j+CfXKccRw0=;
 b=fC0st1r5v0BudOC1a3up3oFQjnAtFh/pcT7XYMw9fV1nuJyhjGLjze1fttcA1hy9Kql8HU5LXJIWN7+qXujynTVJCx++GQdmj2am+u0fCPB0Mpjmrb46UEP9SYf/fyPIafCNefkjHelZWA0k3l+YJELS1KpjaI7Zx6/aHK4yec0=
Received: from MWHPR02CA0006.namprd02.prod.outlook.com (2603:10b6:300:4b::16)
 by CY1PR0201MB0730.namprd02.prod.outlook.com (2a01:111:e400:4c28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Fri, 21 Dec
 2018 08:57:49 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR02CA0006.outlook.office365.com
 (2603:10b6:300:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.17 via Frontend
 Transport; Fri, 21 Dec 2018 08:57:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Fri, 21 Dec 2018 08:57:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33478 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gaGct-0002E3-GE; Fri, 21 Dec 2018 00:57:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gaGco-0008U5-Dn; Fri, 21 Dec 2018 00:57:42 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBL8vdZA031579;
        Fri, 21 Dec 2018 00:57:39 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gaGck-0008Rq-Bw; Fri, 21 Dec 2018 00:57:38 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/3] ASoC: xlnx: enable audio formatter driver build
Date:   Fri, 21 Dec 2018 14:27:29 +0530
Message-ID: <1545382649-181411-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545382649-181411-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1545382649-181411-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(189003)(199004)(106466001)(8676002)(2616005)(2906002)(186003)(356004)(446003)(11346002)(63266004)(76176011)(51416003)(26005)(39060400002)(305945005)(77096007)(36756003)(426003)(7696005)(336012)(9786002)(16586007)(110136005)(47776003)(316002)(81156014)(81166006)(36386004)(50226002)(8936002)(106002)(478600001)(7416002)(476003)(126002)(50466002)(5660300001)(2201001)(48376002)(486006)(6666004)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB0730;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT025;1:LIXMFVJxvktfvUu1GoViZKzxwr6qy6+Yb963Sr0hb1CBLMI9HktuG7k/6bmLwxBWe0BW/ALYfNt6W9lhhQKq51KTeTqiC81GheO7v7rerz69n8me1ggIcAYD+ursKUGW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a5408f-7a86-4082-027b-08d667226189
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY1PR0201MB0730;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0730;3:1B9SYA6C1zXrvLkPBV64wBuIcx9uVPvPkL3AcUqyf+IuD6JVQO4j+Fc6aYOyaCs6oFkm+0JZzZq2x1Ps7ywTCLEwwnumQkXFOastZzj2UYBT19aJ+iddI9MDkgq4Z5cgATWjOkRD6+GuLXrZF+nUVG/CblYvI320PtaCZy0ajKwDl/XFjQYjzDa3EJpmeFwn4jqeMxEDvTl677/cdD0gJAAyTGqDNLT445EocWUjzPHiePC03YZlVFEWHq1atQPLprLnTpyQC58/iTCXY5zQutYOsylANs4cAsphuWJZDxKh4TAMlDHwraAwqsM4MIleXAj/XvxlDeUtU9Qo0UevKacWU7n8GxvqSiTBSsXNckE=;25:zcbt1nFOYDE5ldBlKnnnrVbD2hZgLcnDZX+9GfscxYvF9Ff4rMOEDCvcNAJESIDzzRLfArkiW1GiYcd2uWeVUve5HuLmYNA46svBU4t9EiWmAwPvrQGn0I26YBQ0BmSZKS34JidMU8Y2oG9e7a7iVF9BqBvefZsJw9f8J16YYcG65jEw0gnjNseWPG5Q/zTGejJoEA+2WOQ/hE1aV5TWsMnXRQoFpNMTpOZa4zDAl9JuF80YJBdII8fIgx5LOofkbJYw9+un9/PyCGTK9lYjDjRbvcs5uQIkrE4g8DwvNWQh0AcjDuV4Ws50F7hTIGHhge0Yn/9qFnmm5ugfd8ctURK5yNyFDcZhKS9ofgOUoH8=
X-MS-TrafficTypeDiagnostic: CY1PR0201MB0730:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0730;31:AsYQ92/4Kxcu10HlzFtKXjSRfqpSReSdNOyMQGQ0X22hTGkFU9Uj9J3GqoCvtkFeTMvtLRyi+8P+RS9MANkg4xjzG2I/nS6n1GZnWtxBoszutHsf4lZpcQEbajW8som+k5t7AGsK3e871p0Mx2I9CAehWM0AwiA/yTkuVhGRXY78g0qHckrYyMOmrnJjA1CX1d4b0CmPtrksBu9PWvYOmrPgaGYp8ftYCg6mF0WrRWA=;20:DEEPRi0u6gj4IGCEp6WnAimxKCw/j9/SvlR/QUhpxcdY6sbX5QG5ZOpI/nvab+tYPneCTAuQn2hhJOl5+75D6nqfG6dbf3ahsVuwmvVR7Lpm69FOqi/KhWgZZ+Do37P2id7aZRfUSbZnsi3bdzuJnuzFlPQQwKnmVV3EkwGCcwELzr+xMoi3qYtXL/GzOdX/8jHXOt2ZYPNK/Dx5jDnzu8NXQ2YE61tqhi4IiHaBtjyU73SGVYE9GD3Szrze6FiIa0C95BTOv+eaIbA6/xV7Al7oN2MjFkslVksbQ+SvRx6wPCR9mIjUKRdyuJhRZkUuLqesQfZUesHdogP8BwbjW2ztEpbABuqHbree0kP8hJBHNhzIIj+qQ882a4dCFPN8UZSEPPw5FTsQLdUx+Gzmu8W/v+VPkkPYn2Lzrhnil9Mw54LqlEGxEtK1ox6x828CWFDCaFBx3k6v81/yIITcyVMASx7HpTzOB8rYz3mawDv8StQSDPaT1p5nSrHYsic+
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB0730E7ABD4D40F6924BDC6BABAB80@CY1PR0201MB0730.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY1PR0201MB0730;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB0730;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0730;4:MKGTEJdFGuSq9DWYZOQd4/M1IKqm0WzVnoHfFIpznPLSI108S4k5/68KR0HGhprX2gU284DEdQh+EFt0VBLCxartHXufsiJ3OSQjueHenIOpCc5peJzORQsoZojGlWU1oKnZtvF5uq9+R1ogk8WnNirYW4CCFTb/gXoVuSmAH9v9n4rZ5gKYCedHf+U1X5LlqsmtrIrd1TJzlPPDRxe9dXPlf89sQJrh9AxbU46s5wWKMLK3jGJB1p0K4pGE5Slcw45e6ObI7ggIh4NFbkNDJQ==
X-Forefront-PRVS: 0893636978
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB0730;23:jEqJq74LyHsoq4YAojjQ2PH2hiUKM1QhXrcT5q0?=
 =?us-ascii?Q?r6IKUmLUxoWr6VCobS6i4mMkPyANj0R891aRVi/O2VvpvKqlFa2834kM1Nki?=
 =?us-ascii?Q?PMK9kupR4m7CqMv9gR8lMlhK1V3WL4ZgPgSj63XuDTMZX6j9/Ea12YAHEzop?=
 =?us-ascii?Q?YpPozoIXqh+n4xRxH37baMF3J45gO9fqBmjiL3jMyX8M8LZysa4Lx/2zhyby?=
 =?us-ascii?Q?1HrF7N33u7HEtXILRaUQR9X5bNO70cAFT9gfGQ5e77z7JwPly5eADpRz8ENm?=
 =?us-ascii?Q?J5c7xgby+iNXLMxvnlPiAnrdy2jPEwrHmIDxFArBcoa1BQRBAxpAqbRg8b05?=
 =?us-ascii?Q?9y2pcxOenohzy36M95CEr7CrdYerrnDLGRHJfG1CjIs6d1HpFA3jrPQadOKj?=
 =?us-ascii?Q?x+jyBvPTHQDGO7xKYPkVoxKcSD71WhPJF0EetLOWnjw+UMtg4hmMbzry8LVz?=
 =?us-ascii?Q?yuAaV48RYS3gloTv0UK9erbP9h+Z/phwDeCM4HdEqCMD01Vlt1oQ1arIZthF?=
 =?us-ascii?Q?mU40bxiLOM6cbQg2coY/9+DMk3BqBlsCX1pvgb7gprLKCt2GTB+Snhvf/F4b?=
 =?us-ascii?Q?AqbNKws6rOxRULLTtnL0xzk5ohK1ZghfWcU1h9ELSo5NQ2/rYjEDmUgnP+De?=
 =?us-ascii?Q?nwb34CHmYrqUaVI9XyN/WKiNeqGU9xOgORUGBuor5zhQ7sxiUmp/L63Gh2dH?=
 =?us-ascii?Q?8mI+Qvv4UdnWudP5EQwXbFeGEvYSB6RdeqYko/NJ8lEYFKLdH8cv06K2I4s9?=
 =?us-ascii?Q?DIM7t9vLJMilLFwqbFhrwYrTz1jZ6W0mdiPdGECOilgs2Sl7KsMyU4tr+Uje?=
 =?us-ascii?Q?keqmXjQT7AeXGS967yoPbNNBAoioNSd5sBogk8WaO3RieZ/DxnY47PIDdW1F?=
 =?us-ascii?Q?ARuAsWB0Mrx/4PuUVOx/qzBFegAHUAIIitFyMw5vKPPVhY6WjzRWljp1kmcX?=
 =?us-ascii?Q?pwI7qnuHGmrIsJmluEcXKy1DjpHg7NYjaxjIbahPsQm9n2HWfkRQcQ8y/lVu?=
 =?us-ascii?Q?a+Otm65BZ6VNO8OVDWlJStJSwF0rd77ZnqMvNfRcwra+XPMSNSF1x1WL/17D?=
 =?us-ascii?Q?J28hWxNiDI3vDukFOIJn5mvbhEiSemOm89jEo5CZ30T7K6Ter/K7KqxsLSz6?=
 =?us-ascii?Q?HrwT44slM9554/811M+7X1U64PNKEjULdflvEHOS4wAMfWhHRiZ5r0w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 42FZE+UehodH4Pj++VoUwFlWQoERCqevxWliNXpWZKsyODrVzHPVeYKZgqrN5nubo4tc6e5/KA1qIcmaVJVyJPNEk7C2A40yM9vKR9xKrBGK708SWo2Qj6aVkl8vniNuqSiGdWw2c2NpQsHthwM9N5BIWQBNS3gvrbZ7jo+OfkHvEp+lOYBeYMfpWSr/H1sVgiofpqlzPXPeIKOlseePvPNKoVwTi76PlbeBzb07QU+HQipezvOCT7Sc29lrWkFp1r8YfAoreGWqpQU+DYG/CNFmVLWzhy0BqJnNhA/dO7XKk5nWFyZ4CjLWx4B7TM/8
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0730;6:GVHXAAUHJyOmHkF/B9JXxQqZBNym9u1sm0pwPlCxnxrvwz9/NicFcSF/pgq+Jl+L1yFI6RjR/jJz+60wZEcsougdgblJ0ufrjQPj0pjTdoRFVMVqA4qvmL5q89Y8rJzuj0sIFXtExY2aub5K/Kf+reTOkW/p7b34NyPl+PMoTc6BcU8uiBbnpV0Pq98ei7EmAMCFh3sUscGDzZTwnlmhizVuOPZUcPnMKtBk8c0bvCoUmsvroYxQqPgQu7KnuU0hKbIa/nGI8XER0veCRsss4/qMq8b2UEF2HZs/FERd4NEGewE9FOk15+OwJ4HXEjK54U1TJWTa3mKi9GdSUQsy1efY32nk+b3rzqt8H47aaF99sfEjCkZXAeOLB1XG+CDdGOqWPWYVa89JZ8X8MJHbHNmYMX/eeLH6BByJfLzAlxxXSJNlQVh7cUzqZnl6u+9OShkt8VLJtFo5ofbE1Xf/OA==;5:Af3ypxbbxVoD/QYfEPVdZsnd4jj3EhIRe/cZThDQKFicMv522n5s8mFjzISawMQnvenPZWfSzoQbjcvtyNoQOlBdJ5lC+TRs/fIchREk+IlgQpV7pUjDvYF64fylDv4sWrAQkYOe6Gji3nN8AC9DAKevWbUiFr0p2YqQWLbEmuo=;7:SGzICvJAIFdbtjSrqlzjw3GdN/6C40zjNb5OTYqTfrerGHwVwyNBEOxiLeh4Rh8GTN4rj7xtbU86rScnR1a6fdg19UGn9OhRcsACl6zb7TvDNX3+iTjBxZ2S1o9tc8bDtUaSjVh0o3UZm//cEcE6bw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2018 08:57:48.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a5408f-7a86-4082-027b-08d667226189
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB0730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable audio formatter driver build.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 723a583..ac48d6a 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -6,3 +6,10 @@ config SND_SOC_XILINX_I2S
 	  mode, IP receives audio in AES format, extracts PCM and sends
 	  PCM data. In receiver mode, IP receives PCM audio and
 	  encapsulates PCM in AES format and sends AES data.
+
+config SND_SOC_XILINX_AUDIO_FORMATTER
+        tristate "Audio support for the the Xilinx audio formatter"
+        help
+          Select this option to enable Xilinx audio formatter
+          support. This provides DMA platform device support for
+          audio functionality.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
index 6c1209b..432693b 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
+snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
+obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
-- 
2.7.4

