Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548432146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qUGBmD/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548432146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLDMw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:52:29 -0500
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:42656
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbeLDMw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndEDK9Z0NXbEeYcN0/QvsqcjCcmk7JFLJKOyBoh3l5o=;
 b=qUGBmD/c5Q8UWa2qITd90Jx+3LYhKZ8rX16sb2k0q2/DX2bnI1EfVVYq6u+ktQcgJgwDxAjNlENo90mRE5yFklxl8+ibB/egnsUc3JFV8lGeAz/KWi0S2Ug3iVTVocBJhcBAOO4fDXr2Ecv1GQsntWzcPFZtRvJDGHSZdG3nNPY=
Received: from CY4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:903:18::11)
 by DM6PR02MB4459.namprd02.prod.outlook.com (2603:10b6:5:29::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Tue, 4 Dec
 2018 12:51:33 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR02CA0001.outlook.office365.com
 (2603:10b6:903:18::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Tue, 4 Dec 2018 12:51:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Tue, 4 Dec 2018 12:51:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42464 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1gUAAm-0002st-NQ; Tue, 04 Dec 2018 04:51:32 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1gUAAh-0001iy-Ji; Tue, 04 Dec 2018 04:51:27 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB4CpOjs015833;
        Tue, 4 Dec 2018 04:51:24 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1gUAAe-0001ik-Fv; Tue, 04 Dec 2018 04:51:24 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <jollys@xilinx.com>,
        <anirudh@xilinx.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] tty: xilinx_uartps: Correct return value in probe
Date:   Tue, 4 Dec 2018 04:51:22 -0800
Message-ID: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(189003)(199004)(5660300001)(305945005)(14444005)(2906002)(110136005)(2201001)(48376002)(63266004)(50466002)(478600001)(476003)(36386004)(36756003)(8936002)(126002)(44832011)(50226002)(54906003)(486006)(356004)(8676002)(81166006)(81156014)(106002)(316002)(336012)(106466001)(426003)(2616005)(4326008)(186003)(9786002)(107886003)(77096007)(6636002)(26005)(47776003)(51416003)(7696005)(72206003)(16586007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4459;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT023;1:ob3USuK8v3Ly0XoXshWw2v68mJc0p/LJS7IZHFCz7BToZEMQ1kWT+ti6WOjvwMfH5+ckj3UbJnjAGFg7p/7BMf/bhy8NNOgrdAcUtS/E478CSK/9uzpivuy9vwKQrTaH
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b71e177-250b-44fd-945f-08d659e73834
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;3:DAQ4LffS68aca9pgHMacsUXEXqCerRj6faVGtWuAogGVcHw/1XakZ4mzrpjSNon+c/7d6TjXDNKHWidI8HNPRAj0VYS8NUm1Q4I3/pHRDnzCjMIqKLdlI3Ykz+zMD26SoiJrrilIe7wU6NOvciDLTelqs12XlVmkBbPqw0+49m8FAQIOL3z029cKd51PLigBz/rlLKX3FYuWCx2ITiebPV8bFD2Gp49YBlrjCu082ymaK5rikJuMYwbW+mUDdF2oQDl373JsdwFVzNQkKxARzYpEcUPXALrTb4QCwsxwEEBKSRLdUGLrulF+esOy0c7R8QafgoVR32mW6zliyqJwmiKvIhNzrkm2inJ/gNEZfn4=;25:U7kC3+kMeRC2TIg0vOKaQgtiScJmTho1Xk2SHIZWRGYC81x+p2qxB9w9r0F3s1h2hhdWOaV79JU1PIMUvMzvEgCfZ9aLuZJvINwyG1ZrwElAjWk3wcqh3PYJoUne3Gr9c0qzjfxvLbxi+Knfzkj23WHOtcnBtfY4UbztE3PUUTDROPfCLf8SI7jxyrUxk88YR8GaYabnm6bzHJ0TS8ec1XNAYwmRL+2SCpWrzPdJbDhx4CTnXFQ8dQZoPOsqOMT59Qa1CFR+gv9BoZ3e2HdYIjhSlRk0wdaR0p8ieJ7S5zIVHkHmgBdYu7BxTUrXc1PmmmtrzY9hwgAEsu+tMnj3eg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;31:dqfYw2NeRhLcR4nYxdllUd//J2s3FSJ7S+gIVJ2AHkY8+sIM6BydKO01stnX3F6pz9pkzfEGKud6nksX3sewmCEYT5KyGQleU+PYphlXALsaLIgAAm2sfgNgOirqsqp5NAcXUHoqwantxd5m/IjfBnzlaN2iuGadrve9hw8RLpeRAeHoRoEBAeGC4icZqTYdOf9C8shUKvMV1gyyl8YbjeR7ZR/qrnMFVQMyURHg6WY=;20:JgEBuAexF80jpUNbxVfHFUVN8W3t06ZXSgwOedrAuTVlJLVmK0nAblMDxfyBMfu/mrU67ax7NTHeN6moIH+eHLEpkzs4VMxsizqMj3Ff8KiJMAAkkGPc5f8drW5TUpdoAuOYzLj0cIdGXgrB4ncQgQSYO/3/ZWpjSmjNn7ECCEzRmNWAdcHNbotC2+fhNifn0Pz1yOkSY5IYj9PSsekId8jKvAdPrhCssbqq78kpkGR+DszIpSA8rha7IjkYb1f9XsDS1NTEYKuCZmmPTEqq9Nze81IDfHTN1/bEj+sn5TxWqlLXkJsAL3qTWIdhIUx8mdw5EeQfr9onuouaoSo1EqLyJ9mmgbCtSxfO5s1GNULPe6YE+ZPR6GG2+7tOj5k+cSTXGjPQQFtR41uoO7a963U8IcZ57S/0rfZNov5RLtAowXrkKYdk0oJbdxXUmAB3xopxQELfUjJKtOMBJ/I/HJZANkmvSNxLMMUb5tgQ8uSs4OesYLpKcJuAUiYKOLxL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4459CB7BD381E3D26DBE824EB7AF0@DM6PR02MB4459.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4459;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;4:xwy1PohbiAJqpkHUVE3ir8WEPbNvSJYjbFLDUYYnhdAB1X0bi1zgIB8ntoxMkgy/5ZKrVEH/xxQjgAmMAIVFlD92YawL7M7ne7xU2BWx/Qge+/L2qClkFxLkqC/BKDX+J5GF9iTnXuTFsFw3RB95gYxWNHgKw9iAYC9+7Ru1+pTQUiHTogD6zgonCGerxuicDTG/Dp2lfPY00BY9ZO1IXAs2A6nQLYpRwSNdubuHTQpCmkZFGPNhP+IOz0o073R9C/9yrRVfh0euIjsn5ZLUsg==
X-Forefront-PRVS: 0876988AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4459;23:PeutWWR7tKetY/SqCfaCTRUcpqNbUcD3cM6/VOuDI?=
 =?us-ascii?Q?1ew1z9SbIch7I8BLutwu1UN2LibtxzManVrGZBkOS45dsm7CanHfNcHhlbuL?=
 =?us-ascii?Q?LSxaMbMDgSgtsiRzqS3uwA1fJlhHMfkqWdY4pw/+0jK8nq+EXUgrmPezHvN1?=
 =?us-ascii?Q?aUdIekZcjhDpvV5A2VxT4zaqXeCKjv2JVK5GyCyvg+8tziL9m9u3dtbnGHI7?=
 =?us-ascii?Q?0QP65xvFtkykAVbwtzhbr2XPL+ArFhwsWNIeBNI6aSnGgXslbzYTjPCwrNQp?=
 =?us-ascii?Q?kuYuWrMRAf7CYBFZZQkIZQ22Z4LgTT1IYzuXBPvd+7m4WzKK+nXz4I8I7S4a?=
 =?us-ascii?Q?dqtvzfSCekmUCOAd6m/J5fECyu3r3myrQ3vCfitqMffrB9uHMvxgu0Mb83Wt?=
 =?us-ascii?Q?YSdcOIdzdnMVPbf7LBs7RDbDngp99SzizIYT2ebAZlO/rqilX1kU9tWuYWfl?=
 =?us-ascii?Q?sisfPiPRmWxsJzX1yGdtgAqiOTqSmh9xR2N1++hLqhhvmHOmT4Lf4iTrIiXJ?=
 =?us-ascii?Q?2gaHZcWT55MYgBzL9sjR0+ePBuGFM88JLukMb1Rnf/xXvk+noenvpV4Qg+LO?=
 =?us-ascii?Q?PA8T3UKqRskDMi4JOBKLE7WcJ1FfVFFp9Q5KUuTxPWSEN6kEg7XIspDPOp2N?=
 =?us-ascii?Q?hL3EFzc/I1Eghx1cfkNdyy6iB/F+GrRY9CwPM9u8++2UH/6mq9GTC1LwsNA9?=
 =?us-ascii?Q?fbqGouedmwkLidd2RtT+Mk2qVFdoTLbB1h3Y3Ye2e6ECQ9p9lzgRFEm+4xHm?=
 =?us-ascii?Q?DMWzIPsJ8pbNbR0Kim1g9/TqzWlkTbArcHF0Qt0vuHMLM/58cLtIXMGUrB9v?=
 =?us-ascii?Q?GttCUufYbbfS2JAU7034nphd2sSU8KA5WJyLR7Xe7/7Yx305EPY/KplzRYay?=
 =?us-ascii?Q?gXfpv2IsfgGl5MCxLDvcpDEW0IdUuAR2ILV+n5X76w8Az2Rzv+6Q1bg9chTh?=
 =?us-ascii?Q?5eW/hCqRtfwUunCDb4ZF8P6oCXKu9h+rlc54tVYo47sSP21+cMp25vTXMshR?=
 =?us-ascii?Q?E+zpmxgGzTt7yU1dAWF7WTomo+mNmdsidOlVzt9nFTjDcNgqvSXmov/18iLB?=
 =?us-ascii?Q?AXqqMqOswLZtwi54+CnRrLNVmnha6Kao+kA/57DKFis6yi/Y+po5jT7YQ2p2?=
 =?us-ascii?Q?a8VV/fV0/nJxss8eBPryrBrfrpxff3o?=
X-Microsoft-Antispam-Message-Info: KTu4Ss6Tvi+xKu97knoQ7TeELjUwbYyFPNyD/OZOadjizpdEjQDacaXBmt0MTIu9DEif3ULgRPayvnBx9jPscec1pS3ffXbFkXClStrVHVG0fp0CPhW+ceixrvL15yCyu7ude2L0adQ3t+ZpyaZV1TZ2XzlJu/GSHWtZI4bo4dDBynAkavPRu4lpR7VQ5O4xmmKeLoBjw4owiDTHODtNljjnbSz3nutSlwVsc4D72uGfwgV2iDAPyjdVr4IA5LkqMKOcWQMr0tzcS2Vf5y5f2/QOJeF+nFYvzidGU+HTu7h3kunBjWo8OWJLPcRviK72t/JpXryGKZ8bPSoB6Y1/levy9uelyZXA9KA5N3h6eAM=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;6:5AXDLsu2jFdR8XehlrvOnX9nSRSgjJSm19UEwR3WV8sYbbC2XVnRa5QkJQvJDYTevMsWGmndkaneiX8tmS6yxZUklnoedN5u5+/QC0PtAlnpCE9uq3OSMKUDJcY9dR7MW3OHVKJ8gQYoE6hLf01SDruh/S32gPwAA5wimPOehRZ3gtxZPqFFH7xI/6mog586C/xKZXMC0Szsn8bGCNNnkwOsGloQDNYhsM564HyG7PYS2r2WQHcn9mOTR22Y6qduS4cgfYOKMOVWNkLIUgM2HDoX/NSXKex9qpI5nZwm5IlgwOKOAPtKvawv9IWOdxENbmkACQUiwafokYRHhzDKDkQ8bWDqvsdfn58EDboZs1WgkpC/PfG6z5bhbqrnr0Rlt2hLD4nA2UybjK9O6OhxWGMbDyKvKplqe2NsS051W5f/4jwLBbEOYOYpxEv4kMQksYQuEBRDEGQRIwBaAHlHhw==;5:nzH+eeNEBZP/qowbWH5GeFwbaMNK8CAlW2n4RPY8/0b5dziKWTdNgQY9xZllAVKsjKfdAyFHs0mj0kmoTHHnOMjf8+rqF0DNKDIr/pIATGztmii9tOazNdg52W33cWddVIow00N60LlCInynIkq9LZI7XYsioRf4mxVh6QVP1Vs=;7:VW8y+ASPKV+ZjchgaBBvVownZe6eN4vX8xu6frgTrw+7E3H6y7JmzE2Qyy1kb+1Rc5UOmXfp0CD6XH90gSr7J99hzAfE3lU307ho/2cuerEScsBkK2OaGU9NYvqJURS5BptxPRWu4iA+cq6dcclvXw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2018 12:51:33.1197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b71e177-250b-44fd-945f-08d659e73834
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing driver checks for alternate clock if devm_clk_get() fails
and returns error code for last clock failure. If xilinx_uartps is
called before clock driver, devm_clk_get() returns -EPROBE_DEFER.
In this case, probe should not check for alternate clock as main
clock is already present in DTS and return -EPROBE_DEFER only.

This patch fixes it by not checking for alternate clock when main
clock get returns -EPROBE_DEFER.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 57c66d2..a23baa4 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1545,27 +1545,25 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER)
+		return PTR_ERR(cdns_uart_data->pclk);
+
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
-		if (!IS_ERR(cdns_uart_data->pclk))
-			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
-	}
-	if (IS_ERR(cdns_uart_data->pclk)) {
-		dev_err(&pdev->dev, "pclk clock not found.\n");
-		rc = PTR_ERR(cdns_uart_data->pclk);
-		goto err_out_unregister_driver;
+		if (IS_ERR(cdns_uart_data->pclk))
+			return PTR_ERR(cdns_uart_data->pclk);
+		dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
 	}
 
 	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
+	if (PTR_ERR(cdns_uart_data->uartclk) == -EPROBE_DEFER)
+		return PTR_ERR(cdns_uart_data->uartclk);
+
 	if (IS_ERR(cdns_uart_data->uartclk)) {
 		cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "ref_clk");
-		if (!IS_ERR(cdns_uart_data->uartclk))
-			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
-	}
-	if (IS_ERR(cdns_uart_data->uartclk)) {
-		dev_err(&pdev->dev, "uart_clk clock not found.\n");
-		rc = PTR_ERR(cdns_uart_data->uartclk);
-		goto err_out_unregister_driver;
+		if (IS_ERR(cdns_uart_data->uartclk))
+			return PTR_ERR(cdns_uart_data->uartclk);
+		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
 	}
 
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
-- 
2.7.4

