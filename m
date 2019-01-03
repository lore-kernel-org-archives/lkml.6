Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ADA21871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TFwUt1e7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfACSKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:10:16 -0500
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:58640
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfACSKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoY3Ncp8u4l2brAfL2xkXZcRDVkC/zM4YGdU6F8zOEk=;
 b=TFwUt1e7oh9bCI8yzFTA8dfIfs3hLLgQyTsPack49ehWD5BCHOBmP7/IrkF50GiRhIKLfL4zVmvW1FoqBAdacCbVMvh+RDzBBGRGcVYTJT0SAyS6T+hrly4Q5TG1wiq0sPXfmorTxCrQGlzUwZmdJdxaSQWP/79xw3Y5g7I6sR4=
Received: from MWHPR0201CA0094.namprd02.prod.outlook.com
 (2603:10b6:301:75::35) by DM2PR0201MB0734.namprd02.prod.outlook.com
 (2a01:111:e400:3c06::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Thu, 3 Jan
 2019 18:10:07 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0094.outlook.office365.com
 (2603:10b6:301:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Thu, 3 Jan 2019 18:10:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 18:10:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RS-0001eN-D1; Thu, 03 Jan 2019 10:10:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RN-0007he-A7; Thu, 03 Jan 2019 10:09:57 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x03I9lTf002780;
        Thu, 3 Jan 2019 10:09:47 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RC-0007fE-Uo; Thu, 03 Jan 2019 10:09:47 -0800
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
Subject: [PATCH 2/3] ASoC: xlnx: add SPDIF audio driver
Date:   Thu, 3 Jan 2019 23:39:52 +0530
Message-ID: <1546538993-55473-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(396003)(2980300002)(199004)(189003)(63266004)(106466001)(39060400002)(186003)(9786002)(11346002)(446003)(426003)(106002)(2201001)(36756003)(8676002)(81156014)(8936002)(50226002)(81166006)(305945005)(356004)(6666004)(5660300001)(36386004)(2616005)(51416003)(316002)(336012)(16586007)(26005)(77096007)(110136005)(7696005)(76176011)(2906002)(47776003)(478600001)(7416002)(14444005)(126002)(476003)(48376002)(50466002)(486006)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0734;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT009;1:RBFF8Fo86u9gR46NWRZSHYMc4z5PG7KoB+2iwzkVI5FTtXGeP34XrzCg/aUm9DGtCbLbFry331uaYKWJv3mLuXK/5XtoRjn19dcVEpB8MENOTlk+f2M/GuXKDz5LyOT+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca5ff5f-538e-41b7-a9be-08d671a6b0d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM2PR0201MB0734;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0734;3:9MUXkMMgwYOJMeEZgOjwW6LapvTe1SIfMvsROSoxQ8HY5oKrVMkYdxCPDGoWFPihFbgCkfbiRVql3X3NLQKwk0sCdTIC7MXtLxmdoEUGsRRhkFy5BbD0kI7k+egJecHmGtsy/LzWM8dQKyakmxIOQKTzHIuaBQVojlo3Cw2YWT7tX7Jhxlg1bhQUlCXRi9FAglSb8NT6XCPe8/NX6F5rWC2UoAh7IR0h4UzRiqq2f2uMx8wSOXdQmnfQhGAffNxaQ838SItkbYo1WcXOP47AZv+dRVOSnlfuYCbLy84DrzAHm0zkVlubLJSEocNNmhdJHP7cgd9OD7GRa8ZW3308vLUKSS+xoiNGpUO5/7Yaxs279Dfs4AR5z6p5YBBeiFJY;25:msKNKk5jCuO8tg7dV+24DXKX9KI7ATx/zJ3IJBEmJRrteeYOxOa4KSZciir0ZzpLTskzT3JEpjGJrxk2KmN0NUopgKqwkftHluniIwBjGHTs/n886Edro8XXKTviq4vGGYLPhXQ/dkYDKXqk53FKX6NsZK0lSzkrsTFRiLVOcP4mUa+P7CkWbmVa1R1NqzNOMV+N9tKma0HmY9UzwAwucmY2Zz4Ho8Ska3tgAfiwV/RcmQCsY3q44wV9yqIl5GfLOjtuIBaYaOGUkaeLrhai00KUpwWoWZzQAw7bdDdB469O3Sobq55V17Cv6eJEEGdfr+y2EE5I6k65h4gsVCynuA==
X-MS-TrafficTypeDiagnostic: DM2PR0201MB0734:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0734;31:AGBjJmHgsvv+nooVP47xmhsWDoWHCJ8RSsLolZXpOTXRGP5HMMTXMlpJxVAcCFJPY+OSKxJA/FiR4QM2WKxnF7YkfvySfj5N4cMknQMDdvr65T7GvB48aJmPDTFVWxRkKKvpSC/R1+YLT0DFFmymiMjf3HZFE7eBDMXGqts17uJC3yZxzLAm0dSWEMQY/Z/bwJDF99jrD6XT6ViCUThB/xcreO7XN+82RBEVSqvsOx0=;20:jEocLmfbR0EyfVc4QT69dE4mjKv+7XroNeHxt5e9ESJbvNXhxCejGrTfQgruzec8BEChpvIIy/8mrW/9Qnar6xm2ZQz0R3l+y8ASIILJ9y3kO60J1Qtv4cAXInwAf1d3lLiGFOec1Qad9F8bt1n+7PqWVqHzG6rT0rNXwfQYS032vlcvpgJlnMVrscKXNtKd38f6YuQzt2XKqg52EPUl0a2NPiFkVlAHtdcfeZGM8bn0opB9nXZC/IvL+nDoZBqdqg5ox++EVvjqJzoclunWqeD+xJJ4O5ckS9LgcZUm1uhk7tnDRx+CO3hoXXJn5kTMdZLhYZS6y04VJiT0NFR+ufxOYarwW9PLwl6X0ZvIEfarRFjulzPLJEvQVnF/uvT7KFk5/0dOjWWyULgqIRZfHIPw029oiQ92CAQ7/d5rLsqxFBTxhx+5Ju2Zx0wVKeLX1PzyYUxFp2yhfu1A68L4k+ltmV+Y1n/pChTSbMBtfBNKKKeYixk20LsRNi1v7zJU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR0201MB0734798534B341B3BF5D15FABA8D0@DM2PR0201MB0734.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM2PR0201MB0734;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0734;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0734;4:pgQoL2IZCacHqalTe6KMUEuNR3zCqMQPlibRV4qJcFc/LHkPx5nosshqtY3MpZq3S23zDkWTN2S08swkY0noGAv8IVJOjXkxhA5L2+gBJfCz6Ewhtp2wVJBCMJtwSqUyclyuPjVXcLcgGE39X0h57ahAI+KuQKDUJVVEZHPalKxW0+ZjHNRa2narWeVhHt+9l9hgiiCrmnrr6yAn1brnROehjtdkDUQc9TTZQf3txIbtzfAmsG//jQVuHimotyo3if4kxp0kzdR+02cL8Xe7PPCxy6ilqn0FZIo48cQUdAUW6h/xhkCzV1w71usyYmMq
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0201MB0734;23:w2vqXXoy9mWApn1SxeLj+xL0Eg3HaPi/5T/UCBB?=
 =?us-ascii?Q?sKuIrbu6UlE6J6lU2tJu/r+K/UFk0CMSOyIlAu5Hct0rkk98jVW3DQ3WsKYB?=
 =?us-ascii?Q?9yt4RA8Pogq7S6LJHX37vGIUYJpObgODUvmU7WV32UonYCgptlEsZplmGhxQ?=
 =?us-ascii?Q?b99Fvxa4Goz3+t1cBwoPOhHHCv1oFvAx1k14KdUhyDtQcm4DZrc+519WCXZQ?=
 =?us-ascii?Q?1y2HwCcnzie5Q6uxSvI8RYG65z7F8Js1KPxkD9XtiaLdAcmiR74eQigp4Fhn?=
 =?us-ascii?Q?wnCz5xRXLl83sovMUyogVMduCL+zc2Umd7HQS/N6tS/biobzxIEVIumCNFaj?=
 =?us-ascii?Q?jkhzjWan5UOW2SamtzPUQWMEaPQ6341TxabSKcZVYyAXirbOOi+TOcRGnBCa?=
 =?us-ascii?Q?JF1kC1Fs4nWQ1xUm5p6ZDXolMe9euZ5iPn4lMe1+WrRsak9yj5tTD9ZGCLhI?=
 =?us-ascii?Q?P1vE0Fg6JYjQMyi0ucJvgXZLPp2vNIZzjLIIjc3F5ibwFh30EzXZHgFbdjAS?=
 =?us-ascii?Q?oDjqrrQLiWZvYOfoJyNSNsdzbAt3xJz2OJIbWla+eshuCF/1Xw9ftyLZg7XT?=
 =?us-ascii?Q?kcv/UJc9C9iwPurXt733eX4Qq/C9zKeN/daMpwR7j2St/gywmQRNkaVu1pVR?=
 =?us-ascii?Q?Mj+hRLyCxSDPq0xpS9W3shg8cq13OUoUKQH9K2TA0nOfSca5VPpXDLoP6mFu?=
 =?us-ascii?Q?P0eTRltduVh2e1Iu77zLPG6ObtidEqQY6+ZPNOdQ5GAIo+QQhSVmSuJBfkJ0?=
 =?us-ascii?Q?yu9SIiA1YvmBKThjWhgfaGxKsWubRkP5eGR+cgN5yu/jC42qP2kElpywAfy/?=
 =?us-ascii?Q?bWthsyaApGC1ERsb/TpKmd2rQQAIPDo41rE7LXfiuOJlv+DAo9qavKoVG5HV?=
 =?us-ascii?Q?KSI3BywcnxRa6egnMkqpsJjxQYFYJrlyP2Xjhq5BSGoN7pW4UNGzMvCsqiZB?=
 =?us-ascii?Q?1XntBlV14wwa9saIs2SZRY9oG3WPvT/MeIKDFz4TisGVdVI9fB+vtXPPjIMu?=
 =?us-ascii?Q?vIFDTdkZFMJ1o5m+SJoFWfB/zDWjLmkQE84TTA1bhqGL8sEvaK8EyPmxOG+O?=
 =?us-ascii?Q?XoeRxYtXang+KfTBY1LSpBcsPUWINfC5G67BXw22wJSCqV/CY9tTJfCBsRLp?=
 =?us-ascii?Q?cJck7A7cTlMdk1SyVMEUVXgjXipWWIaed?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JuI8VOC7xM6arrmwDJRdHiU7BTLU2RgnlxQahFVKArGWQM27cQkdRvU7zjZFjYltmXia4LJfxPPwT51iA8StlP0VJuS35sGu2IEAo/kTSUPayoinjxuUezjgSZbtBYdN3uh16YlAONI9jiJLcl/Wbzjnoo57KHEqxrB1rWY1h+j46/ZsycxhCQDdMiqWASt36P6x/Rcqjl/I/9jpO7Ofau9hZNkzZqz1j5w6VqtGLnqpbiFGdiiuDXfF8Zp7eZwI4Yg7WhzCD4vil2E3ZyApGwsJ85E6+WB1pE8IREAbJ49hsGZwmHPOeksOyoCwTR2J
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0201MB0734;6:M57AgTQKDG3VrVxFT7BGS1DgYGdvwXoxZagR6vARg79qVbhQBDYY5xD6fc4Ycp2zbddlhWThqj9xd39p5z9TVvAmb6+ySuzP+CVdkop4tivVK8JUMrV2aiab4fqUAiWBVxIfTqXFMZcFLVqKdPOKBJjT2UyXGZfKQS4razpZfaIkbZvqNdIMMf3nqe6cB1Qk4UFHYktbG7hGAwbnUzIE6DIuS30Ld/Ga7c9KOYUIHGE4GAUXggqygXGXY33kLnK9LmBO1CKgvFVVsbaP/mTbrePMsjeJUbnvd8c1IzoSqTJw9ITzoz+ZiGeCFLYuez2wV2MjdGLBzn/j32HKyVij4zcCESVTzdTEjaKwl8b1Zlm/G6IqfDLdwN06JPBrrCO6tL2ZQG8LmGQpa05e7l/NAMh+IGe1L0jML7YzM9LPInijreZe++RSRWOsjUxHg/Vs0oY1Lrvd1+gLx7aOeSyAfg==;5:s9BnQYVS0BaGfawYjeN2gc+wJSNEnN1tV5RLhYsYcEzFH1LH6ojRwiOkC5laxEPFW2ZDQsN/OxB8EXVKgQ70mJhlOYoVeJivg5mvU1MuaNnjf7SUwjJFA+qFe2GBoSU6CCkGsFo4/wC83m4Q55jTuHbc6lxMR/MVXrSYmBdp+B/+KiUw7+noHScxVTh4k2KXxzbJzk69gSYtCJTT+hgtfg==;7:kMva6cHHkYQ+x1IkPETnXBFF1o5FRnGITzath9LgZgm42jxcutHse8+RoK8r+Xr0rHcFCsph4Epgi6zgNVb44HsuZelmrjI8zxnThQYEA4OWpiqnQaAXX7scZLiWcInsNqLPPiUklxC4Pwp4Du/McQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 18:10:03.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca5ff5f-538e-41b7-a9be-08d671a6b0d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added SPDIF audio driver. This provides playback and capture of
AES audio over SPDIF interface.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/xlnx_spdif.c | 339 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 sound/soc/xilinx/xlnx_spdif.c

diff --git a/sound/soc/xilinx/xlnx_spdif.c b/sound/soc/xilinx/xlnx_spdif.c
new file mode 100644
index 0000000..3b9000f
--- /dev/null
+++ b/sound/soc/xilinx/xlnx_spdif.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Xilinx ASoC SPDIF audio support
+//
+// Copyright (C) 2018 Xilinx, Inc.
+//
+// Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
+//
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define XLNX_SPDIF_RATES \
+	(SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+	SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
+	SNDRV_PCM_RATE_192000)
+
+#define XLNX_SPDIF_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+#define XSPDIF_IRQ_STS_REG		0x20
+#define XSPDIF_IRQ_ENABLE_REG		0x28
+#define XSPDIF_SOFT_RESET_REG		0x40
+#define XSPDIF_CONTROL_REG		0x44
+#define XSPDIF_CHAN_0_STS_REG		0x4C
+#define XSPDIF_GLOBAL_IRQ_ENABLE_REG	0x1C
+#define XSPDIF_CH_A_USER_DATA_REG_0	0x64
+
+#define XSPDIF_CORE_ENABLE_MASK		BIT(0)
+#define XSPDIF_FIFO_FLUSH_MASK		BIT(1)
+#define XSPDIF_CH_STS_MASK		BIT(5)
+#define XSPDIF_GLOBAL_IRQ_ENABLE	BIT(31)
+#define XSPDIF_CLOCK_CONFIG_BITS_MASK	GENMASK(5, 2)
+#define XSPDIF_CLOCK_CONFIG_BITS_SHIFT	2
+#define XSPDIF_SOFT_RESET_VALUE		0xA
+
+#define MAX_CHANNELS			2
+#define AES_SAMPLE_WIDTH		32
+#define CH_STATUS_UPDATE_TIMEOUT	40
+
+struct spdif_dev_data {
+	u32 mode;
+	u32 aclk;
+	bool rx_chsts_updated;
+	void __iomem *base;
+	struct clk *axi_clk;
+	wait_queue_head_t chsts_q;
+};
+
+static irqreturn_t xlnx_spdifrx_irq_handler(int irq, void *arg)
+{
+	u32 val;
+	struct spdif_dev_data *ctx = arg;
+
+	val = readl(ctx->base + XSPDIF_IRQ_STS_REG);
+	if (val & XSPDIF_CH_STS_MASK) {
+		writel(val & XSPDIF_CH_STS_MASK,
+		       ctx->base + XSPDIF_IRQ_STS_REG);
+		val = readl(ctx->base +
+			    XSPDIF_IRQ_ENABLE_REG);
+		writel(val & ~XSPDIF_CH_STS_MASK,
+		       ctx->base + XSPDIF_IRQ_ENABLE_REG);
+
+		ctx->rx_chsts_updated = true;
+		wake_up_interruptible(&ctx->chsts_q);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int xlnx_spdif_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	u32 val;
+	struct spdif_dev_data *ctx = dev_get_drvdata(dai->dev);
+
+	val = readl(ctx->base + XSPDIF_CONTROL_REG);
+	val |= XSPDIF_FIFO_FLUSH_MASK;
+	writel(val, ctx->base + XSPDIF_CONTROL_REG);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		writel(XSPDIF_CH_STS_MASK,
+		       ctx->base + XSPDIF_IRQ_ENABLE_REG);
+		writel(XSPDIF_GLOBAL_IRQ_ENABLE,
+		       ctx->base + XSPDIF_GLOBAL_IRQ_ENABLE_REG);
+	}
+
+	return 0;
+}
+
+static void xlnx_spdif_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct spdif_dev_data *ctx = dev_get_drvdata(dai->dev);
+
+	writel(XSPDIF_SOFT_RESET_VALUE, ctx->base + XSPDIF_SOFT_RESET_REG);
+}
+
+static int xlnx_spdif_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	u32 val, clk_div, clk_cfg;
+	struct spdif_dev_data *ctx = dev_get_drvdata(dai->dev);
+
+	clk_div = DIV_ROUND_CLOSEST(ctx->aclk, MAX_CHANNELS * AES_SAMPLE_WIDTH *
+				    params_rate(params));
+
+	switch (clk_div) {
+	case 4:
+		clk_cfg = 0;
+		break;
+	case 8:
+		clk_cfg = 1;
+		break;
+	case 16:
+		clk_cfg = 2;
+		break;
+	case 24:
+		clk_cfg = 3;
+		break;
+	case 32:
+		clk_cfg = 4;
+		break;
+	case 48:
+		clk_cfg = 5;
+		break;
+	case 64:
+		clk_cfg = 6;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = readl(ctx->base + XSPDIF_CONTROL_REG);
+	val &= ~XSPDIF_CLOCK_CONFIG_BITS_MASK;
+	val |= clk_cfg << XSPDIF_CLOCK_CONFIG_BITS_SHIFT;
+	writel(val, ctx->base + XSPDIF_CONTROL_REG);
+
+	return 0;
+}
+
+static int rx_stream_detect(struct snd_soc_dai *dai)
+{
+	int err;
+	struct spdif_dev_data *ctx = dev_get_drvdata(dai->dev);
+	unsigned long jiffies = msecs_to_jiffies(CH_STATUS_UPDATE_TIMEOUT);
+
+	/* start capture only if stream is detected within 40ms timeout */
+	err = wait_event_interruptible_timeout(ctx->chsts_q,
+					       ctx->rx_chsts_updated,
+					       jiffies);
+	if (!err) {
+		dev_err(dai->dev, "No streaming audio detected!\n");
+		return -EINVAL;
+	}
+	ctx->rx_chsts_updated = false;
+
+	return 0;
+}
+
+static int xlnx_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
+			      struct snd_soc_dai *dai)
+{
+	u32 val;
+	int ret = 0;
+	struct spdif_dev_data *ctx = dev_get_drvdata(dai->dev);
+
+	val = readl(ctx->base + XSPDIF_CONTROL_REG);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		val |= XSPDIF_CORE_ENABLE_MASK;
+		writel(val, ctx->base + XSPDIF_CONTROL_REG);
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			ret = rx_stream_detect(dai);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		val &= ~XSPDIF_CORE_ENABLE_MASK;
+		writel(val, ctx->base + XSPDIF_CONTROL_REG);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops xlnx_spdif_dai_ops = {
+	.startup = xlnx_spdif_startup,
+	.shutdown = xlnx_spdif_shutdown,
+	.trigger = xlnx_spdif_trigger,
+	.hw_params = xlnx_spdif_hw_params,
+};
+
+static struct snd_soc_dai_driver xlnx_spdif_tx_dai = {
+	.name = "xlnx_spdif_tx",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = XLNX_SPDIF_RATES,
+		.formats = XLNX_SPDIF_FORMATS,
+	},
+	.ops = &xlnx_spdif_dai_ops,
+};
+
+static struct snd_soc_dai_driver xlnx_spdif_rx_dai = {
+	.name = "xlnx_spdif_rx",
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = XLNX_SPDIF_RATES,
+		.formats = XLNX_SPDIF_FORMATS,
+	},
+	.ops = &xlnx_spdif_dai_ops,
+};
+
+static const struct snd_soc_component_driver xlnx_spdif_component = {
+	.name = "xlnx-spdif",
+};
+
+static const struct of_device_id xlnx_spdif_of_match[] = {
+	{ .compatible = "xlnx,spdif-2.0", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_spdif_of_match);
+
+static int xlnx_spdif_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *res;
+	struct snd_soc_dai_driver *dai_drv;
+	struct spdif_dev_data *ctx;
+
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->axi_clk = devm_clk_get(dev, "s_axi_aclk");
+	if (IS_ERR(ctx->axi_clk)) {
+		ret = PTR_ERR(ctx->axi_clk);
+		dev_err(dev, "failed to get s_axi_aclk(%d)\n", ret);
+		return ret;
+	}
+	ret = clk_prepare_enable(ctx->axi_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable s_axi_aclk(%d)\n", ret);
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ctx->base)) {
+		ret = PTR_ERR(ctx->base);
+		goto clk_err;
+	}
+	ret = of_property_read_u32(node, "xlnx,spdif-mode", &ctx->mode);
+	if (ret < 0) {
+		dev_err(dev, "cannot get SPDIF mode\n");
+		goto clk_err;
+	}
+	if (ctx->mode) {
+		dai_drv = &xlnx_spdif_tx_dai;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (!res) {
+			dev_err(dev, "No IRQ resource found\n");
+			ret = -ENODEV;
+			goto clk_err;
+		}
+		ret = devm_request_irq(dev, res->start,
+				       xlnx_spdifrx_irq_handler,
+				       0, "XLNX_SPDIF_RX", ctx);
+		if (ret) {
+			dev_err(dev, "spdif rx irq request failed\n");
+			ret = -ENODEV;
+			goto clk_err;
+		}
+
+		init_waitqueue_head(&ctx->chsts_q);
+		dai_drv = &xlnx_spdif_rx_dai;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,aud_clk_i", &ctx->aclk);
+	if (ret < 0) {
+		dev_err(dev, "cannot get aud_clk_i value\n");
+		goto clk_err;
+	}
+
+	dev_set_drvdata(dev, ctx);
+
+	ret = devm_snd_soc_register_component(dev, &xlnx_spdif_component,
+					      dai_drv, 1);
+	if (ret) {
+		dev_err(dev, "SPDIF component registration failed\n");
+		goto clk_err;
+	}
+
+	writel(XSPDIF_SOFT_RESET_VALUE, ctx->base + XSPDIF_SOFT_RESET_REG);
+	dev_info(dev, "%s DAI registered\n", dai_drv->name);
+
+clk_err:
+	clk_disable_unprepare(ctx->axi_clk);
+	return ret;
+}
+
+static int xlnx_spdif_remove(struct platform_device *pdev)
+{
+	struct spdif_dev_data *ctx = dev_get_drvdata(&pdev->dev);
+
+	clk_disable_unprepare(ctx->axi_clk);
+	return 0;
+}
+
+static struct platform_driver xlnx_spdif_driver = {
+	.driver = {
+		.name = "xlnx-spdif",
+		.of_match_table = xlnx_spdif_of_match,
+	},
+	.probe = xlnx_spdif_probe,
+	.remove = xlnx_spdif_remove,
+};
+module_platform_driver(xlnx_spdif_driver);
+
+MODULE_AUTHOR("Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>");
+MODULE_DESCRIPTION("XILINX SPDIF driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

