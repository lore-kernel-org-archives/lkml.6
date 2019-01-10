Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A4214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5LRLPhNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfAJNO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:14:56 -0500
Received: from mail-eopbgr700067.outbound.protection.outlook.com ([40.107.70.67]:58848
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbfAJNO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaDtdi6BCaxdrb/WLAZaxFc51YMGNe455Vm7AgRLg0k=;
 b=5LRLPhNG078ZYn/LzPSIxMHM1U5Z8TRhNvTQyVmrYLbsXIDiL//lLh1QMCAYCVFXXCRgVC2Mdlu6we2BiN+FGu9Z7x2U4kqhOAJCBNqON4c9gpqCwAq5m37epL7z/e+WsYbfz3xEfAaF5YjJ5FuR/xoxdmwpWtsvKtmlEcirYTc=
Received: from DM6PR02CA0031.namprd02.prod.outlook.com (2603:10b6:5:1c::44) by
 SN4PR0201MB3519.namprd02.prod.outlook.com (2603:10b6:803:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Thu, 10 Jan
 2019 13:14:42 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR02CA0031.outlook.office365.com
 (2603:10b6:5:1c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Thu, 10 Jan 2019 13:14:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 10 Jan 2019 13:14:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55780 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1ghaAO-0004Go-JM; Thu, 10 Jan 2019 05:14:36 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1ghaAJ-0001lH-GB; Thu, 10 Jan 2019 05:14:31 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0ADEQS5017183;
        Thu, 10 Jan 2019 05:14:26 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1ghaAD-0001jh-NQ; Thu, 10 Jan 2019 05:14:26 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ASoC: xlnx: parse AES audio parameters
Date:   Thu, 10 Jan 2019 18:44:43 +0530
Message-ID: <1547126083-44466-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(189003)(199004)(186003)(36756003)(106466001)(36386004)(9786002)(126002)(16586007)(8676002)(316002)(106002)(81166006)(81156014)(39060400002)(14444005)(110136005)(2906002)(50226002)(2616005)(305945005)(77096007)(26005)(51416003)(476003)(8936002)(48376002)(7696005)(63266004)(5660300001)(426003)(47776003)(336012)(2201001)(356004)(486006)(6666004)(50466002)(478600001)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3519;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT043;1:/gIYBgxLb1wq5kA4GbZv15to0S89iGo7CtF3DHDcrjmRqoDGV1dF7hjZJ80HQSgz8KltdgnlqkcB29YfahbfZHvMN7NcyFnO6akm60alwB+ZTxyQOhJifEo3WBWxxy03
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f90179b-31fb-4ead-9a53-08d676fd9416
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN4PR0201MB3519;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;3:TsLqIz6p8G+uzAPd1caHyoLVz4fzf/yKTycFPQi0B/oH5d6+rsIAc03PXeQY2bLWa7qqcy72ErDJf4QEyjUD8KYKXwHQvKh5iJS17YNuXz+ss6WN9VRvv8P6of1pklLrJ6U7haeI9f8GUngXVjloyXxVBNkupUSTZ8Ct5D0RY6C/BmkkGutmmcQqgyf5hHpgv+kiSR2CCLpvFIep2AHGOl/FklVyaodN7WR8BE9soU3RYYHWTraDHpnsjXKV01gpM3lEpyrlRLo3r1ngIYO5Dqg1VvKUk6k/xdhg+Zfc/bDUpPiJrR5erFkkL3C2Q4MMww3c0ootfBJ9L13tA//e8vfV0lRFSCtndsBtpjIOoEV1yAmq5EP8edY/IuPrBdLv;25:3hbXunJNjsc4K/RH1+iTBqrhezOqcezLALg8p4qJR0hdS56WdJ20cIcE/6eT7wa4G20sC5sJbq79kmwEcSkT86wP/bwg13VusjSXnzhLKHQ9RE3AMLKd7LDSop+/LtMxaUzA2tv4YRif2cdQtMyq8Wf79oS/QJ/IgAh/O0i35C/RydST8/RaYTphUdyZJ8zx3GwU7iwa36kn8gJ695dzmJv6z3tn9YMnssxtBsFSsLoHfCdJCqp171ELM8ONRVQxGzilhegYgi5ZbgkCiDxdNv9DiTCkltXnor8+V83sBxv9/6H6pU7rpmgeXyQq3w4U2dJ/UGjHGLgyshzyCq0BbQ==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3519:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;31:dj/iTSnzZVmqnYDZ1y+kq+eyN5WPxk0tDLAdna+2w7YMWBr3RhLLphSnu5dPoJJP48IihXDeHiVu+nBT/T60K+paUpMDYAdN68DtFr79JGLCBrJhl3bXoFUaWC+ty/oaOvHJBShGTq4PjTDstNMpgAWNLMI4/O4Mnsd+If33VaM+hhTcW4WFcfSd8zmU8PM29T79F+P2tw1d8Z3SnXvoxObdWEFFbB6LjFu/5vqbd0Y=;20:DHFP37DM+fex8VH5uMafPJCAkvR7PlCmTpNEl4lZ1XjVCj36HVvKgxJaqIFXM4cY3ihT0/ND+lLbM6y2Y4mZARFdKMMYvP+2y7w/w7QYGJUr5mVo2OWah44YMVYRI+ElahaRLiUKpFzo40zW6R2qiatoHkTgQymTKZtw5GW4woxrR/Xk+9X0cr3tY5xztxccI8KWI15U8eczHPYK9cot3TsWenjx0FlL39X6FZ1AVfh3SA7wqGIjj7dKu7Mo2X5cSt95Sl4GLp9J7P2bEmqN7Kqsu671JKEM4x8cFaPsfziy6MNCB85M7PrgYl6+Oig4uOBBp6pB0IQ5kkXjV4y8x95PwohNak/DxEVB1+2V5sPlArJnGfJ7NkJp/T+befijJP8r+45QR5TzkRhE0ebo69VudRI9Hq8vm4DbxDna9Myp2CqRkmC/Hqcb9L7QArO3sW1minmtf91x78n9BuxugWoZ5RA+SA0W3XCdLoRag4MedvtegjZEzcdX8YQr3GZL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3519F3E49D151A47295AA9D9BA840@SN4PR0201MB3519.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;4:hR93LNdTEVcPwiGG8bJ5wPjKB3kl3BB1hf9ZModCTeUITjmamcWcP/w1fN38qwCZfG/0A+3KswFQDqovkNRUwiIVZCZ7Eh11jTy3de1A+Bc8w7DNSvgft2z/vQhqAA1ZFF2X0C2Nth0iTyf5bjMzoMcUg0bLMiHqi7MQS/JlUX6Xfx5n6ltYcZ2xdmNbi73eoWukoKP1tTh1BSnII8SNScfUe2c/T6oZuejkU2TCn2SyjPNjKREPMLfJS0lZMHjhm/27YapA13lnuyyBkA1YYrorG82O7LCMnLaJVxTGOlA=
X-Forefront-PRVS: 0913EA1D60
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3519;23:FnJAh5vxh2LXeGgwMfcqI3XzJP4iLGLUuDejnk1?=
 =?us-ascii?Q?tJqEezsyKrOYhRgEsNDdApH6ImkUfdKeSbDXa8vy1crQR0dNkYCpQA5kHsPs?=
 =?us-ascii?Q?xiCeqil9lrhxqXoConeMushLbkI4uUASIG5ruFvr+UDbqn55KG/lkc6OGAQ2?=
 =?us-ascii?Q?iuvMBNe9g3ZVW1zFNX1D6SnO5m/w1f856C0L5sLJGSTp3EQkZgFMC0oXrsGL?=
 =?us-ascii?Q?zFLuBEDwhfr9yaUTxhazs3LmZqV+yoQv+NULnv51E48gJdlBdLmGoXbhouvk?=
 =?us-ascii?Q?gSGuCREdiKsJwY+T3ask3CoyS65/yNsWVRQxiPNMKvn/frFG1e0tLCF1cPVC?=
 =?us-ascii?Q?BW7K4NSb9KXsAYvmucKdR/hdDRBIyM1vubfuMO22gQRvW0rCJ6pmc+TuB+hx?=
 =?us-ascii?Q?O99OtDx7soHa5G20PVEEd+4BqgMc+ZcnuI0CPA7ut/SZy1/LIdOgXZZ8cm6M?=
 =?us-ascii?Q?wVHq+hy1MMxyLaXUhvwzCFmC9XNwMG6kpQaD4xIE1+ViIDTWuoPXS8+j/T7i?=
 =?us-ascii?Q?UCxrNhvZqdFXD+Ewi6H2SZQn+aOqHc2wEGNOvkVPfxpb455ggJc3AnRB/xCO?=
 =?us-ascii?Q?W5aWiPPPCtbpOkV97nugg6BLTPduuLOV8ux7pJXBeEIIuabU7HH0PsdFt6nP?=
 =?us-ascii?Q?mw8Pj1eCiNginAzQJ6JKPRRTiU5jcufN9+TNhbBFCbShO+gKHNdz116r8Y2d?=
 =?us-ascii?Q?bbeH8fV60pLQDdC3M2w2myxNyeShAmY8jo6pwrEMHp0G/ImNFrK9oixq6s++?=
 =?us-ascii?Q?+wg1uIKpNI+TDys+u5OA1aSeaGFvQAAPhuBdnYuVxMsGW1qWztDWPYrUEhTr?=
 =?us-ascii?Q?U9LmF2MBcGCTbj5Ppthrq4Z1NmoQ2XP/HGq5VeYv3QauDYf2GS9bCfdfVBbB?=
 =?us-ascii?Q?bfiJQhJNEIJM8NbZ569zaWcrNQ+FgxyctVfeOmaTPC2o/LcFHEmod0yqem1Q?=
 =?us-ascii?Q?WqOt1GXjRy02py3b7z5D+v5vZ6lFVW/Cn2m8bDVRzlHTkvl8shBo0c08J5gf?=
 =?us-ascii?Q?gaz28h8Irr25miEyV7qC0XOt+smyYINL8Sqtee8umCqmYFn5Jkx/FpQb6Wzm?=
 =?us-ascii?Q?PGGN5p1PGm/p42oTMJuXw9MReOEPPK2veoPBWVFiBLYfX57v1LA=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YNDLpa46upV65j+192BhogmlCI/DMyOSfgj6WpAQJkYg1Uj5EilnlvTIfWRc1oMZZg0/Np/RhEwuyUsVjUTdmB+Uvfrxnlrd5Dz85viHgVrH/vgTgH4RigWC2lwELRtvq/dqOZjw1zBwnTKKAQkK/9yt02NEAy2/sp4zUzasJRZT8ztuSSiNS8P5Xv1dyMaDkBWWuKqfebR9SIoX86/ttln9kD/xl5aSq2WNBrHEHFYZaycOfnNaTvZMMAluKk55ZtEUjyOjvKFIIE9P9lghbleW066BnLP7fW/x3QpNeDpzYQW8j6X+8gy/7ffs/ntgUGsd7rfUf161OVf3++3Vig49vv6L7XLDOCpCSi1R8WN0f2ylb3gSXzocxlrRFEt+BQINGO4BXwfpUpdOLzjhnV87ERsYlPEtZoGXYNbNC6wwdpY6F9OtX1cm7HOoP3o8k8OXDycQ4HQAdHZfSXB+3g==
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;6:B0mgwm4ufP9SFkp80o85gUwWIBvGn1PzGIc8m7dAp3Rj7Rz2BL9PUy6oFrV4wZEtKHSie6e2/W57gVwwEC9NpDRNtjFHXCtB5fdESSszL22Fkkgmn96vrjhTcCembMwyidcaiS9CzTYEYr+54Bxb9N42rtdg1muzDZJ0Eqxh+BFTjpkmAfB7ELMTjmNYPhrVNA+P8t50A/xD5vxhe/3qOVwniWE6I4QwCLfy2l/pWBUGTBV2c4QiaqH+oxAk4hNXZNZo12CTLfRFX/uJ3oz3G0rcIINMKAME5JXhE2XsIPsf8RgZRCh4+BPnU2P4j/Dpxds05lQhQQvWfw9d8QFkGYwx+cPy+BEueruukZr9E7jTnq68If0vCaX4BtS6EobehqW+buvDzUBHeqUC8u5VsKaOY+L78l/VYZvNk9DpN3sgQ3psR3oluUXrtOCnqyDvDfwlwMchwBi6no9Xzcm5bQ==;5:HubuMziFzzvhXgkAah4ODcxwH7hClH2iRkKCJa0YiKQb3TSmjxnXQjc6no2lsO6pJpohpbKWBqEhb0Nn1WCZRS9ZBjhd1iAyqwlWNB+78ksnMy9poqY2fDcHMrU1oU5kc4fXhH2TLaXCu7dI2lToNQPa0BlRzn5u95mlqFDYBPTsav1PS60MNKSCM8GnxrizKLo8WRo4aBA6SZHDPJHScA==;7:6sat+rtTpvF7j8gCRyC+RPJ0RMksLMThVi+AkFwFsbDtkYUxL7znaEp7NNfSqX783HJ9OW2Ws2360Zc+zaNpVFhG5RkvsdZDzbtRURnXk53UPZVPSTVM940FwXsvA+KxwAqqklmni+6VVrOAG/7Mwg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2019 13:14:37.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f90179b-31fb-4ead-9a53-08d676fd9416
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AES channel status carries various audio parameters. If channel status is
detected, current patch extracts sample rate and bit depth parameters of
the incoming stream during capture.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 143 ++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index d2194da..97177d3 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 #include <linux/sizes.h>
 
+#include <sound/asoundef.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
@@ -63,6 +64,7 @@
 #define PERIODS_MAX		6
 #define PERIOD_BYTES_MIN	192
 #define PERIOD_BYTES_MAX	(50 * 1024)
+#define XLNX_PARAM_UNKNOWN	0
 
 enum bit_depth {
 	BIT_DEPTH_8,
@@ -117,6 +119,129 @@ static const struct snd_pcm_hardware xlnx_pcm_hardware = {
 	.periods_max = PERIODS_MAX,
 };
 
+enum {
+	AES_TO_AES,
+	AES_TO_PCM,
+	PCM_TO_PCM,
+	PCM_TO_AES
+};
+
+static void xlnx_parse_aes_params(u32 chsts_reg1_val, u32 chsts_reg2_val,
+				  struct device *dev)
+{
+	u32 padded, srate, bit_depth, status[2];
+
+	if (chsts_reg1_val & IEC958_AES0_PROFESSIONAL) {
+		status[0] = chsts_reg1_val & 0xff;
+		status[1] = (chsts_reg1_val >> 16) & 0xff;
+
+		switch (status[0] & IEC958_AES0_PRO_FS) {
+		case IEC958_AES0_PRO_FS_44100:
+			srate = 44100;
+			break;
+		case IEC958_AES0_PRO_FS_48000:
+			srate = 48000;
+			break;
+		case IEC958_AES0_PRO_FS_32000:
+			srate = 32000;
+			break;
+		case IEC958_AES0_PRO_FS_NOTID:
+		default:
+			srate = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+		switch (status[1] & IEC958_AES2_PRO_SBITS) {
+		case IEC958_AES2_PRO_WORDLEN_NOTID:
+		case IEC958_AES2_PRO_SBITS_20:
+			padded = 0;
+			break;
+		case IEC958_AES2_PRO_SBITS_24:
+			padded = 4;
+			break;
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			goto log_params;
+		}
+
+		switch (status[1] & IEC958_AES2_PRO_WORDLEN) {
+		case IEC958_AES2_PRO_WORDLEN_20_16:
+			bit_depth = 16 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_22_18:
+			bit_depth = 18 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_23_19:
+			bit_depth = 19 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_24_20:
+			bit_depth = 20 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_NOTID:
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+	} else {
+		status[0] = (chsts_reg1_val >> 24) & 0xff;
+		status[1] = chsts_reg2_val & 0xff;
+
+		switch (status[0] & IEC958_AES3_CON_FS) {
+		case IEC958_AES3_CON_FS_44100:
+			srate = 44100;
+			break;
+		case IEC958_AES3_CON_FS_48000:
+			srate = 48000;
+			break;
+		case IEC958_AES3_CON_FS_32000:
+			srate = 32000;
+			break;
+		default:
+			srate = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+		if (status[1] & IEC958_AES4_CON_MAX_WORDLEN_24)
+			padded = 4;
+		else
+			padded = 0;
+
+		switch (status[1] & IEC958_AES4_CON_WORDLEN) {
+		case IEC958_AES4_CON_WORDLEN_20_16:
+			bit_depth = 16 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_22_18:
+			bit_depth = 18 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_23_19:
+			bit_depth = 19 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_24_20:
+			bit_depth = 20 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_21_17:
+			bit_depth = 17 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_NOTID:
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+	}
+
+log_params:
+	if (srate != XLNX_PARAM_UNKNOWN)
+		dev_info(dev, "sample rate = %d\n", srate);
+	else
+		dev_info(dev, "sample rate = unknown\n");
+
+	if (bit_depth != XLNX_PARAM_UNKNOWN)
+		dev_info(dev, "bit_depth = %d\n", bit_depth);
+	else
+		dev_info(dev, "bit_depth = unknown\n");
+}
+
 static int xlnx_formatter_pcm_reset(void __iomem *mmio_base)
 {
 	u32 val, retries = 0;
@@ -302,8 +427,12 @@ static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
+	u32 aes_reg1_val, aes_reg2_val;
 	int status;
 	u64 size;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
 
@@ -311,6 +440,20 @@ static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (active_ch > stream_data->ch_limit)
 		return -EINVAL;
 
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	    stream_data->xfer_mode == AES_TO_PCM) {
+		val = readl(stream_data->mmio + XLNX_AUD_STS);
+		if (val & AUD_STS_CH_STS_MASK) {
+			aes_reg1_val = readl(stream_data->mmio +
+					     XLNX_AUD_CH_STS_START);
+			aes_reg2_val = readl(stream_data->mmio +
+					     XLNX_AUD_CH_STS_START + 0x4);
+
+			xlnx_parse_aes_params(aes_reg1_val, aes_reg2_val,
+					      component->dev);
+		}
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
-- 
2.7.4

