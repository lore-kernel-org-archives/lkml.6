Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EDB2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Lcz01Omz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfADV5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:57:22 -0500
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:64885
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfADV4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeApFyN8bmpGujy0JtonWSxPrlX1vge83ih1LNB0NGg=;
 b=Lcz01OmzbTgfvMoxdWgxK2aF3xdSCoebXL26YKj37izvlMeMEXk793YfMjY/ZPNBI2rk2Qq57uLk24ITnv+AWJ+E/PHark5eEMqETjuaH3US6QU5GwkELoulCSUJ4KtvNHpjUqxlP76oegyKPtUCSdmWU3puI2b0DOFAo2dCkJI=
Received: from CY4PR02CA0039.namprd02.prod.outlook.com (2603:10b6:903:117::25)
 by CY1PR0201MB0731.namprd02.prod.outlook.com (2a01:111:e400:4c28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1471.20; Fri, 4 Jan
 2019 21:56:49 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by CY4PR02CA0039.outlook.office365.com
 (2603:10b6:903:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Fri, 4 Jan 2019 21:56:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Fri, 4 Jan 2019 21:56:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSS-0005Y1-8H; Fri, 04 Jan 2019 13:56:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSN-0005nC-4M; Fri, 04 Jan 2019 13:56:43 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x04LuWq5021622;
        Fri, 4 Jan 2019 13:56:32 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gfXSC-0005iq-77; Fri, 04 Jan 2019 13:56:32 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 4/4] dt-bindings: pinctrl: Add ZynqMP pin controller bindings
Date:   Fri, 4 Jan 2019 13:56:22 -0800
Message-ID: <1546638982-12954-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(189003)(199004)(51416003)(5660300001)(8936002)(186003)(106466001)(72206003)(7696005)(77096007)(11346002)(426003)(76176011)(9786002)(336012)(26005)(2616005)(446003)(478600001)(316002)(36756003)(63266004)(50226002)(47776003)(110136005)(2906002)(305945005)(126002)(16586007)(14444005)(81166006)(36386004)(44832011)(6666004)(106002)(81156014)(50466002)(54906003)(356004)(4326008)(107886003)(4744004)(486006)(476003)(8676002)(48376002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB0731;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT016;1:yxhdQZ6hPei9dNyUTF87Liyz5rgsvVvJksqNmDwRY760fajQA0yE5/NoiqmrWR8Ij+TI0uk1ndrU1bxhzIzx6zsGMwN8EKUADmUp6zBNhzK6RV5k7zI+7Ga4Dj6bfxMf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe5dba6-2dd6-46eb-244b-08d6728f86f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY1PR0201MB0731;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0731;3:1VN3HFOpYBB8vnn/QfplpprhMG4jQM90OBLsKL7yVFiQ6RJnJRd3C1WqoKod5IH+EuUd9Jlz7R0dzzgzaD2b8s7tK3j+LL3CVARyWbNAe27QHgqB8tBVzyjXWtuakh+2LbjzIxACFmw6SA00CCPL+wK2Ale7qWu4aSAycfGEsY3r85oqjNcJcwW9GhCCrlAEQfg9TS046k62ZKTrPdxLCCA48wsuWxcIQgCP5dJXnFn/D5JoelRDDeeMqMyHUiGZPl8PU8wLTDajWdjxXrkjIGxm2EuIFKsGpKoXe949TIw8x9cpv0JczaEEu6yIQM8gj1ay4NvSuyfv+i74R5vpKyJHuLJKaiDhyZbGORqLegk=;25:a8EhJgPq5jASPX9D60F+6p0qMgbacMa5DLOynWQ9oEB5i4Hobye4zsNyaUPlaE4WDm2f3luAiCc1bSKoAfTs4nGno9iUFOEj4wKPDEMVifTlV7bG7WBFOLzamSo1C3M2Anr3IWAtq9XjMhnAgC6ggGjIm5QLc3p8soPOdtx5xYoi0NG0kktU41jkoTS6SUo73IGx/ju/v104/WbiWmqD8yry/OZc+UatWs8772qn1TPqhoRX1tnzoDR6pkHIU1BXrohU71MD4CN4bXV//J032MJDLMmxD+KecKbgsXMBgUfHtzyRhAcCzP0mjqiHW5OhT3I7kEwKLumfrVFq7NEE/w==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB0731:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0731;31:1tF8LYeMzDqfYSHwmWFkV7WhxieXDpgZ/nxx7lje+Pr8/olvpSp8jga6dL99V0GSqxsqm4W4PecbF/vpxifMWIlOo/l4HxCIy+hLJzqeJ+N3jZoNmZ6Xtl6qBAzEqaIj7O0XXYyi35e/rdXnbpFr4lkZA/PLjNqOTDLM0Kcs+oroLIKHrbwzCfFZj14P78XYcfQAKwpxklYKXLUGshP4DSMPmkBBippISv11++nyYLY=;20:CSwdCxmIgIlvKcuxrCXOBLb9UVvj9bUjeWPKjvthnJMgtdyp2snx49fI7WfU1r/3yUhNEiVg8icvrldOkICbmqBY9BbyHDkJd5HAVRGlWM5rU3TeYuGg/Fx1IwvuFA/fDpaEiVdCuW+Sob1wInTBD5APkUGDgcP4WDpjWz6ou6g2HWEYDcaXzR6y8twLmPRDBIDhYYEOvjstqfRRpY+Gy1H3eTrzGqNI8pV8rK4qO3L/sKbSfYu+mRHllNHFRczW9xDUulCk2GloZGKsE53Apgp9mAdm4RA4G94C959d/kdSjG0wQCU4MEZ8qivP1lQnWWKlHa+zIBhL8+mokSm8sQ+qBwR4LP9IAkUi3Ya5cfO09c0m8UwmIhGZ00iRCwcXvNmmgLadU7ZdjxD+KbMB5UBV/+DUva6Sy3CIT4CX6/s0jDtqEue++pmTxZGScnFcmrCBQ7TZzJ6pnvBwdE1lA94MfdrCqdRytV4WApBn9L3ZfC2wHLJ/Vz9e9wPifR9a
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB0731540333E82B848EDEB68AB88E0@CY1PR0201MB0731.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(93006095)(93004095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY1PR0201MB0731;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB0731;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0731;4:Vt6wJ1T/KezBnb473UJeCoRgIw5TS9jDKXNse8LMuBl5mRhJwf6NqYT1cFY+2blhSwTcbdfmvpgrWhfZ7r9VJuhy+GyH+BVyFDRPe1gabRPqblJUmXoNqbfn9DAkdnQ5WAtpqI/yUlEaAEL07ghcMy7SZZQhMBIW0xr+DDPjVc+lmmgwcsoYq6y7u8ajwtSwmWdn5+C7dqaegxLA60acH3Lyzcf9XDvIRgnpxs0EN3mrse7uensPPyzuhCpHZDI//r6CB2UsCIuJH+CabDpvkw==
X-Forefront-PRVS: 0907F58A24
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB0731;23:K+y6VxL0wboLk2O4pPnh2l0UmlTH08sc/vf+Cds?=
 =?us-ascii?Q?RYJqpp5fBX93LNFirpmQCltBL845g5vKbYnJL27+vwEhI0hnZ0PkmFAjQZxJ?=
 =?us-ascii?Q?qiLW/04Ng7uVX4RyBd3LW100rA9j7yUP3LyHcMXvMP7bewK9e156Mlmq+Fu6?=
 =?us-ascii?Q?E7Q+5BXN1kB64H52ALsm0/QJKslmabqxswDM1GRZFjTfId4jyajgCJFpTANr?=
 =?us-ascii?Q?hX2sde5HwEetFSB9Fr/e69tfjskYK8xlv90/QrqYtiqiRPjKu9jNPjL4LGl6?=
 =?us-ascii?Q?QDx6K5ic5+ZdQ5NpEoEgwP9QcEf+kwXSEK24Ze+wT1tuUxyssKPOMLAy/0qv?=
 =?us-ascii?Q?vv+dNvi64UpK95p77+1j6oThYRuOQ8akr4ryfsn8ZSSUyTbLUjIrETXHZbVS?=
 =?us-ascii?Q?PwF2VojyWECCEw9KVeTV56XUHz/g3/oAww9aA724opkNIi1OWFrcy+lbSZqR?=
 =?us-ascii?Q?eUIi0BQP4HfYnvG+lD6PJaXpHwKBH80VBuW9fYobCDr0T88cEKYmLXmWha3t?=
 =?us-ascii?Q?4U+gf7P4FMpvLUjJCvJDQbp6B7tQEjcj1/FixmxpuELud6ejRsGikVFLZhKG?=
 =?us-ascii?Q?8iEzzO7SkoqYDQ7SpjkLZnQM+wybl6w2OAiPQ57wGRju8vLRZtZVmQ3pbhzs?=
 =?us-ascii?Q?6YXTglGKLiMxXGwGqIe/SLiGg6jNNxctdIb4KhhplSdHsDSDv/n38A6kxUw5?=
 =?us-ascii?Q?iHQ0qyeaEr350qNaJLuZd9W4HZNF0S0OPGD23gKAScL8DsjHaOtQ+6w5Thyx?=
 =?us-ascii?Q?CC03U0EJeZIXWboVNaa0+i9E1mI7smH7+U7hoOvQMzwDfAkOn6HWW8czg9sG?=
 =?us-ascii?Q?nYeR5NO09ZTgAuFGzBvAcXgSJwiZGYJzArrl+P2cwHvQCB3PZyJtEwamwWpm?=
 =?us-ascii?Q?HsiKFg129JsJYN7lvqD2rJklMWA2MNwx7qI9bgsw6YBVd2mHB0WpfaF7ZobN?=
 =?us-ascii?Q?PUtLJTyAC7JV2NNgbAM2l8sF7URf+yiUcTflEog5mln7A0ZwW+U7txL0HGRB?=
 =?us-ascii?Q?A7Fvy38Fn88VkAlp7Gbw4RHKeOwJyfbZcxZ+hAHgwHj8NnzGp7xJowRpe4vV?=
 =?us-ascii?Q?6Vvz/jquqn7KBaktk/pFU8Ud+sKZI7vq0TXSqRzZWBw3z+Rwl/QxBAEeAJEH?=
 =?us-ascii?Q?Wd7cKd7J5adUPm8ZIbWZmzUw1R//Qzij9xHE13Ckvff6UqOk9pPdj8A=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d1ocrgah+YWNQ68CqWpEGLhHfoCqwqZD56aPAjQGvV9QhMSXWoRrBM8q4GFfpuqcHapm61mAEx3jFPuTbH0RuMFoOx3uH+wppGgcZnYvs7hG92N7z4Wd7WA4bHrJhpq66UOc4XIZFCZ5QU7fmYcn8AagcJWFSHuPmkGH0/+pD2uVwnuwr8JMb9CHUV9qMput0VNgdE1ey6p8ha9yBz+NECB2Hur8rHMYfzmPGfG/pMLBP/dVX2vEEc5CY7ZbRcQt7rnWN2wFZvN6r0k5ZySdSNBP/uKFwaCd1vfdQ0v9UvY4PUNL4G049JPSHjAYjZ+p
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0731;6:uOT4sRtAYMCZ+SEWF2ggngFShflm3xxB5RvYB+RSSlUoRAkFNmSA/OiYuenjdPps8DpUjNYCBppYmsFADAWCQrrYyfBFHnjIGn4PoWoHLrhgKtDpyuLROjh+HDMutmohosTSKS+jsYNu9npK2Z4YFuND6NggM2pVG42OhrExpBRP5e2OX1CFvFmYx6XMIV3bxQkfbrt3ikZ7+IBSa4zXWz5p0qwhhAFvvTxwxWxj7z6LUGvhZEAbaElpZly//AgehbO72n+qbrJ+2f8TK6xK/kpzYNCaOYlLuyvlMb+dOkHmf347SuNYSTY5GKN4beOQ02aTEz460gBe14eu2VypKkYgUVS6PX0pQJ/cHubSBIMd0kpp7qjryyOniqFq+P5IXT969QzQBe6owl+rueXSyH5zPuKOHdK9c7MGheAtsaI27ozxwd6M9X+JC+b3P+PAKXgExQ/583RtrIhuRk9y0w==;5:cdebpZnHTm6b5t+CXu4w7je5ri9+xbGP8kPtWOPieoDgHF49fTnHad4pAqBde7j60PE9ADQr317LTW0BFQpafa5iqrTWOjq6RwLcAv+oGPCF9G7JEVC+hKfiNIxA0+PSDPdlENsiCKP+CANGmkdv4l0IxrulMm59sGkfsSGaP7s=;7:VLmG0pS7CyerJexAYyofnGo5Z1VUQFrLrDSIhkS4fhvYpxvrEF4Tf1nvof9t0l02tNjGKFHgO9VZk8frzk7QqWxWQviRudz1fHmeh/1rDQ1vS2ad/QaEWrWDeG9sHzly97oW/ZkoQZM/OzN+Vz9pQQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2019 21:56:48.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe5dba6-2dd6-46eb-244b-08d6728f86f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB0731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP pin controller
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt       | 275 +++++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
new file mode 100644
index 0000000..acf44a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
@@ -0,0 +1,275 @@
+	Binding for Xilinx ZynqMP Pinctrl
+
+Required properties:
+- compatible: "xlnx,zynqmp-pinctrl"
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+ZynqMP's pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration can include the
+mux function to select on those pin(s)/group(s), and various pin configuration
+parameters, such as pull-up, slew rate, etc.
+
+Each configuration node can consist of multiple nodes describing the pinmux and
+pinconf options. Those nodes can be pinmux nodes or pinconf nodes.
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Required properties for pinmux nodes are:
+ - groups: A list of pinmux groups.
+ - function: The name of a pinmux function to activate for the specified set
+   of groups.
+
+Required properties for configuration nodes:
+One of:
+ - pins: A list of pin names
+ - groups: A list of pinmux groups.
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinmux subnode:
+ groups, function
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinconf subnode:
+ groups, pins, bias-disable, bias-pull-up, bias-pull-down, slew-rate
+
+ Valid arguments for 'slew-rate' are 'SLEW_RATE_SLOW' and 'SLEW_RATE_FAST' to
+ select between slow and fast respectively.
+
+ Valid values for groups are:
+ ethernet0_0_grp, ethernet1_0_grp, ethernet2_0_grp,
+ ethernet3_0_grp, gemtsu0_0_grp, gemtsu0_1_grp,
+ gemtsu0_2_grp, mdio0_0_grp, mdio1_0_grp,
+ mdio1_1_grp, mdio2_0_grp, mdio3_0_grp,
+ qspi0_0_grp, qspi_ss_0_grp, qspi_fbclk_0_grp,
+ spi0_0_grp, spi0_ss_0_grp, spi0_ss_1_grp,
+ spi0_ss_2_grp, spi0_1_grp, spi0_ss_3_grp,
+ spi0_ss_4_grp, spi0_ss_5_grp, spi0_2_grp,
+ spi0_ss_6_grp, spi0_ss_7_grp, spi0_ss_8_grp,
+ spi0_3_grp, spi0_ss_9_grp, spi0_ss_10_grp,
+ spi0_ss_11_grp, spi0_4_grp, spi0_ss_12_grp,
+ spi0_ss_13_grp, spi0_ss_14_grp, spi0_5_grp,
+ spi0_ss_15_grp, spi0_ss_16_grp, spi0_ss_17_grp,
+ spi1_0_grp, spi1_ss_0_grp, spi1_ss_1_grp,
+ spi1_ss_2_grp, spi1_1_grp, spi1_ss_3_grp,
+ spi1_ss_4_grp, spi1_ss_5_grp, spi1_2_grp,
+ spi1_ss_6_grp, spi1_ss_7_grp, spi1_ss_8_grp,
+ spi1_3_grp, spi1_ss_9_grp, spi1_ss_10_grp,
+ spi1_ss_11_grp, spi1_4_grp, spi1_ss_12_grp,
+ spi1_ss_13_grp, spi1_ss_14_grp, spi1_5_grp,
+ spi1_ss_15_grp, spi1_ss_16_grp, spi1_ss_17_grp,
+ sdio0_0_grp, sdio0_1_grp, sdio0_2_grp,
+ sdio0_3_grp, sdio0_4_grp, sdio0_5_grp,
+ sdio0_6_grp, sdio0_7_grp, sdio0_8_grp,
+ sdio0_9_grp, sdio0_10_grp, sdio0_11_grp,
+ sdio0_12_grp, sdio0_13_grp, sdio0_14_grp,
+ sdio0_15_grp, sdio0_16_grp, sdio0_17_grp,
+ sdio0_18_grp, sdio0_19_grp, sdio0_20_grp,
+ sdio0_21_grp, sdio0_22_grp, sdio0_23_grp,
+ sdio0_24_grp, sdio0_25_grp, sdio0_26_grp,
+ sdio0_27_grp, sdio0_28_grp, sdio0_29_grp,
+ sdio0_30_grp, sdio0_31_grp, sdio0_32_grp,
+ sdio0_pc_0_grp, sdio0_cd_0_grp, sdio0_wp_0_grp,
+ sdio0_pc_1_grp, sdio0_cd_1_grp, sdio0_wp_1_grp,
+ sdio0_pc_2_grp, sdio0_cd_2_grp, sdio0_wp_2_grp,
+ sdio1_0_grp, sdio1_1_grp, sdio1_2_grp,
+ sdio1_3_grp, sdio1_4_grp, sdio1_5_grp,
+ sdio1_6_grp, sdio1_7_grp, sdio1_8_grp,
+ sdio1_9_grp, sdio1_10_grp, sdio1_11_grp,
+ sdio1_12_grp, sdio1_13_grp, sdio1_14_grp,
+ sdio1_15_grp, sdio1_pc_0_grp, sdio1_cd_0_grp,
+ sdio1_wp_0_grp, sdio1_pc_1_grp, sdio1_cd_1_grp,
+ sdio1_wp_1_grp, nand0_0_grp, nand0_ce_0_grp,
+ nand0_rb_0_grp, nand0_dqs_0_grp, nand0_ce_1_grp,
+ nand0_rb_1_grp, nand0_dqs_1_grp, can0_0_grp,
+ can0_1_grp, can0_2_grp, can0_3_grp,
+ can0_4_grp, can0_5_grp, can0_6_grp,
+ can0_7_grp, can0_8_grp, can0_9_grp,
+ can0_10_grp, can0_11_grp, can0_12_grp,
+ can0_13_grp, can0_14_grp, can0_15_grp,
+ can0_16_grp, can0_17_grp, can0_18_grp,
+ can1_0_grp, can1_1_grp, can1_2_grp,
+ can1_3_grp, can1_4_grp, can1_5_grp,
+ can1_6_grp, can1_7_grp, can1_8_grp,
+ can1_9_grp, can1_10_grp, can1_11_grp,
+ can1_12_grp, can1_13_grp, can1_14_grp,
+ can1_15_grp, can1_16_grp, can1_17_grp,
+ can1_18_grp, can1_19_grp, uart0_0_grp,
+ uart0_1_grp, uart0_2_grp, uart0_3_grp,
+ uart0_4_grp, uart0_5_grp, uart0_6_grp,
+ uart0_7_grp, uart0_8_grp, uart0_9_grp,
+ uart0_10_grp, uart0_11_grp, uart0_12_grp,
+ uart0_13_grp, uart0_14_grp, uart0_15_grp,
+ uart0_16_grp, uart0_17_grp, uart0_18_grp,
+ uart1_0_grp, uart1_1_grp, uart1_2_grp,
+ uart1_3_grp, uart1_4_grp, uart1_5_grp,
+ uart1_6_grp, uart1_7_grp, uart1_8_grp,
+ uart1_9_grp, uart1_10_grp, uart1_11_grp,
+ uart1_12_grp, uart1_13_grp, uart1_14_grp,
+ uart1_15_grp, uart1_16_grp, uart1_17_grp,
+ uart1_18_grp, i2c0_0_grp, i2c0_1_grp,
+ i2c0_2_grp, i2c0_3_grp, i2c0_4_grp,
+ i2c0_5_grp, i2c0_6_grp, i2c0_7_grp,
+ i2c0_8_grp, i2c0_9_grp, i2c0_10_grp,
+ i2c0_11_grp, i2c0_12_grp, i2c0_13_grp,
+ i2c0_14_grp, i2c0_15_grp, i2c0_16_grp,
+ i2c0_17_grp, i2c0_18_grp, i2c1_0_grp,
+ i2c1_1_grp, i2c1_2_grp, i2c1_3_grp,
+ i2c1_4_grp, i2c1_5_grp, i2c1_6_grp,
+ i2c1_7_grp, i2c1_8_grp, i2c1_9_grp,
+ i2c1_10_grp, i2c1_11_grp, i2c1_12_grp,
+ i2c1_13_grp, i2c1_14_grp, i2c1_15_grp,
+ i2c1_16_grp, i2c1_17_grp, i2c1_18_grp,
+ i2c1_19_grp, ttc0_clk_0_grp, ttc0_wav_0_grp,
+ ttc0_clk_1_grp, ttc0_wav_1_grp, ttc0_clk_2_grp,
+ ttc0_wav_2_grp, ttc0_clk_3_grp, ttc0_wav_3_grp,
+ ttc0_clk_4_grp, ttc0_wav_4_grp, ttc0_clk_5_grp,
+ ttc0_wav_5_grp, ttc0_clk_6_grp, ttc0_wav_6_grp,
+ ttc0_clk_7_grp, ttc0_wav_7_grp, ttc0_clk_8_grp,
+ ttc0_wav_8_grp, ttc1_clk_0_grp, ttc1_wav_0_grp,
+ ttc1_clk_1_grp, ttc1_wav_1_grp, ttc1_clk_2_grp,
+ ttc1_wav_2_grp, ttc1_clk_3_grp, ttc1_wav_3_grp,
+ ttc1_clk_4_grp, ttc1_wav_4_grp, ttc1_clk_5_grp,
+ ttc1_wav_5_grp, ttc1_clk_6_grp, ttc1_wav_6_grp,
+ ttc1_clk_7_grp, ttc1_wav_7_grp, ttc1_clk_8_grp,
+ ttc1_wav_8_grp, ttc2_clk_0_grp, ttc2_wav_0_grp,
+ ttc2_clk_1_grp, ttc2_wav_1_grp, ttc2_clk_2_grp,
+ ttc2_wav_2_grp, ttc2_clk_3_grp, ttc2_wav_3_grp,
+ ttc2_clk_4_grp, ttc2_wav_4_grp, ttc2_clk_5_grp,
+ ttc2_wav_5_grp, ttc2_clk_6_grp, ttc2_wav_6_grp,
+ ttc2_clk_7_grp, ttc2_wav_7_grp, ttc2_clk_8_grp,
+ ttc2_wav_8_grp, ttc3_clk_0_grp, ttc3_wav_0_grp,
+ ttc3_clk_1_grp, ttc3_wav_1_grp, ttc3_clk_2_grp,
+ ttc3_wav_2_grp, ttc3_clk_3_grp, ttc3_wav_3_grp,
+ ttc3_clk_4_grp, ttc3_wav_4_grp, ttc3_clk_5_grp,
+ ttc3_wav_5_grp, ttc3_clk_6_grp, ttc3_wav_6_grp,
+ ttc3_clk_7_grp, ttc3_wav_7_grp, ttc3_clk_8_grp,
+ ttc3_wav_8_grp, swdt0_clk_0_grp, swdt0_rst_0_grp,
+ swdt0_clk_1_grp, swdt0_rst_1_grp, swdt0_clk_2_grp,
+ swdt0_rst_2_grp, swdt0_clk_3_grp, swdt0_rst_3_grp,
+ swdt0_clk_4_grp, swdt0_rst_4_grp, swdt0_clk_5_grp,
+ swdt0_rst_5_grp, swdt0_clk_6_grp, swdt0_rst_6_grp,
+ swdt0_clk_7_grp, swdt0_rst_7_grp, swdt0_clk_8_grp,
+ swdt0_rst_8_grp, swdt0_clk_9_grp, swdt0_rst_9_grp,
+ swdt0_clk_10_grp, swdt0_rst_10_grp, swdt0_clk_11_grp,
+ swdt0_rst_11_grp, swdt0_clk_12_grp, swdt0_rst_12_grp,
+ swdt1_clk_0_grp, swdt1_rst_0_grp, swdt1_clk_1_grp,
+ swdt1_rst_1_grp, swdt1_clk_2_grp, swdt1_rst_2_grp,
+ swdt1_clk_3_grp, swdt1_rst_3_grp, swdt1_clk_4_grp,
+ swdt1_rst_4_grp, swdt1_clk_5_grp, swdt1_rst_5_grp,
+ swdt1_clk_6_grp, swdt1_rst_6_grp, swdt1_clk_7_grp,
+ swdt1_rst_7_grp, swdt1_clk_8_grp, swdt1_rst_8_grp,
+ swdt1_clk_9_grp, swdt1_rst_9_grp, swdt1_clk_10_grp,
+ swdt1_rst_10_grp, swdt1_clk_11_grp, swdt1_rst_11_grp,
+ swdt1_clk_12_grp, swdt1_rst_12_grp, gpio0_0_grp,
+ gpio0_1_grp, gpio0_2_grp, gpio0_3_grp,
+ gpio0_4_grp, gpio0_5_grp, gpio0_6_grp,
+ gpio0_7_grp, gpio0_8_grp, gpio0_9_grp,
+ gpio0_10_grp, gpio0_11_grp, gpio0_12_grp,
+ gpio0_13_grp, gpio0_14_grp, gpio0_15_grp,
+ gpio0_16_grp, gpio0_17_grp, gpio0_18_grp,
+ gpio0_19_grp, gpio0_20_grp, gpio0_21_grp,
+ gpio0_22_grp, gpio0_23_grp, gpio0_24_grp,
+ gpio0_25_grp, gpio0_26_grp, gpio0_27_grp,
+ gpio0_28_grp, gpio0_29_grp, gpio0_30_grp,
+ gpio0_31_grp, gpio0_32_grp, gpio0_33_grp,
+ gpio0_34_grp, gpio0_35_grp, gpio0_36_grp,
+ gpio0_37_grp, gpio0_38_grp, gpio0_39_grp,
+ gpio0_40_grp, gpio0_41_grp, gpio0_42_grp,
+ gpio0_43_grp, gpio0_44_grp, gpio0_45_grp,
+ gpio0_46_grp, gpio0_47_grp, gpio0_48_grp,
+ gpio0_49_grp, gpio0_50_grp, gpio0_51_grp,
+ gpio0_52_grp, gpio0_53_grp, gpio0_54_grp,
+ gpio0_55_grp, gpio0_56_grp, gpio0_57_grp,
+ gpio0_58_grp, gpio0_59_grp, gpio0_60_grp,
+ gpio0_61_grp, gpio0_62_grp, gpio0_63_grp,
+ gpio0_64_grp, gpio0_65_grp, gpio0_66_grp,
+ gpio0_67_grp, gpio0_68_grp, gpio0_69_grp,
+ gpio0_70_grp, gpio0_71_grp, gpio0_72_grp,
+ gpio0_73_grp, gpio0_74_grp, gpio0_75_grp,
+ gpio0_76_grp, gpio0_77_grp, usb0_0_grp,
+ usb1_0_grp, pmu0_0_grp, pmu0_1_grp,
+ pmu0_2_grp, pmu0_3_grp, pmu0_4_grp,
+ pmu0_5_grp, pmu0_6_grp, pmu0_7_grp,
+ pmu0_8_grp, pmu0_9_grp, pmu0_10_grp,
+ pmu0_11_grp, pcie0_0_grp, pcie0_1_grp,
+ pcie0_2_grp, pcie0_3_grp, pcie0_4_grp,
+ pcie0_5_grp, pcie0_6_grp, pcie0_7_grp,
+ csu0_0_grp, csu0_1_grp, csu0_2_grp,
+ csu0_3_grp, csu0_4_grp, csu0_5_grp,
+ csu0_6_grp, csu0_7_grp, csu0_8_grp,
+ csu0_9_grp, csu0_10_grp, csu0_11_grp,
+ dpaux0_0_grp, dpaux0_1_grp, dpaux0_2_grp,
+ dpaux0_3_grp, pjtag0_0_grp, pjtag0_1_grp,
+ pjtag0_2_grp, pjtag0_3_grp, pjtag0_4_grp,
+ pjtag0_5_grp, trace0_0_grp, trace0_clk_0_grp,
+ trace0_1_grp, trace0_clk_1_grp, trace0_2_grp,
+ trace0_clk_2_grp, testscan0_0_grp
+
+ Valid values for pins are:
+   MIO0 - MIO77
+
+ Valid values for function are:
+   ethernet0, ethernet1, ethernet2, ethernet3, gemtsu0, usb0, usb1, mdio0,
+   mdio1, mdio2, mdio3, qspi0, qspi_fbclk, qspi_ss, spi0, spi1, spi0_ss,
+   spi1_ss, sdio0, sdio0_pc, sdio0_wp, sdio0_cd, sdio1, sdio1_pc, sdio1_wp,
+   sdio1_cd, nand0, nand0_ce, nand0_rb, nand0_dqs, can0, can1, uart0, uart1,
+   i2c0, i2c1, ttc0_clk, ttc0_wav, ttc1_clk, ttc1_wav, ttc2_clk, ttc2_wav,
+   ttc3_clk, ttc3_wav, swdt0_clk, swdt0_rst, swdt1_clk, swdt1_rst, gpio0, pmu0,
+   pcie0, csu0, dpaux0, pjtag0, trace0, trace0_clk, testscan0
+
+The following driver-specific properties as defined here are valid to specify in
+a pin configuration subnode:
+ - io-standard: Configure the pin to use the selected IO standard. Valid
+   arguments are 'IO_STANDARD_LVCMOS33' and 'IO_STANDARD_LVCMOS18'.
+ - schmitt-cmos: Selects either Schmitt or CMOS input for MIO pins. Valid
+   arguments are 'PIN_INPUT_TYPE_SCHMITT' and 'PIN_INPUT_TYPE_CMOS'.
+
+Example:
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		pinctrl0: pinctrl@ff180000 {
+			compatible = "xlnx,zynqmp-pinctrl";
+
+			pinctrl_uart1_default: uart1-default {
+				mux {
+					groups = "uart0_4_grp";
+					function = "uart0";
+				};
+
+				conf {
+					groups = "uart0_4_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					io-standard = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO18";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO19";
+					bias-disable;
+					schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
+				};
+			};
+		};
+	};
+};
+
+uart1 {
+	...
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart1_default>;
+	...
+
+};
-- 
2.7.4

