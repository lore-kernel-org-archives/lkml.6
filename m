Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A9EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2236B218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Prt29lof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbeLSRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:19:34 -0500
Received: from mail-eopbgr810077.outbound.protection.outlook.com ([40.107.81.77]:15968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLSRTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68SnUHkFM2B86UYtguDH7Y+D5J6aJVsq2DiCu3yltG0=;
 b=Prt29lofOEkbcQFXZGtcgCgYE5oFaUP5VZBkpy/keqGyitp6IHXxYrJ/DOb+UoHWN/XbhPT/RKmIl+6VxZBbnX1mSxNB90RQWuojz/RgwzfxpwGocUhqHbZJD38P1mI0AsDlV84jmp7Jjsu/7YdK1k/WDqtjf1uogYDV5YQbeew=
Received: from CY4PR02CA0046.namprd02.prod.outlook.com (2603:10b6:903:117::32)
 by BY2PR0201MB1896.namprd02.prod.outlook.com (2a01:111:e400:58b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Wed, 19 Dec
 2018 17:19:27 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CY4PR02CA0046.outlook.office365.com
 (2603:10b6:903:117::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Wed, 19 Dec 2018 17:19:27 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=temperror action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Wed, 19 Dec 2018 17:19:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfVF-0004vX-6H; Wed, 19 Dec 2018 09:19:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfVA-0002m0-35; Wed, 19 Dec 2018 09:19:20 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBJHJATi027017;
        Wed, 19 Dec 2018 09:19:10 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfUz-0002k9-Ii; Wed, 19 Dec 2018 09:19:10 -0800
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
Subject: [PATCH 1/3] dt-bindings: ASoC: xlnx,audio-formatter: Document audio formatter bindings
Date:   Wed, 19 Dec 2018 22:49:07 +0530
Message-ID: <1545239949-112845-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(199004)(189003)(110136005)(316002)(305945005)(47776003)(16586007)(106466001)(39060400002)(97736004)(7416002)(8936002)(8676002)(5660300001)(50226002)(9786002)(81156014)(81166006)(36756003)(14444005)(48376002)(356004)(6666004)(486006)(336012)(186003)(53936002)(2906002)(2616005)(2201001)(476003)(478600001)(126002)(11346002)(446003)(50466002)(426003)(63350400001)(63370400001)(36386004)(63266004)(77096007)(26005)(76176011)(7696005)(51416003)(107986001)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1896;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT056;1:+a5B/0lO4qQl5ThFqF2DDpafAOrz9yk9rg7vWmTVyhWeLWXbh2UzEDkVS7iBv7F/eH/UP9GTHHVfgTm02vnRy0ftrSjzVdOtOsoob6fu/5VseUxCW5uVxZbt4YwEkc1Q
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72c907c8-a5eb-40a7-05da-08d665d62059
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BY2PR0201MB1896;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;3:aITW7ctxXcaVD1RS7XPy2JvxGBJ+NBa4GGFvUwZyuN8hsjXrv2Mg8RRPzxGRnQ8v4N46l7JPrLulybYm3Gl1CyZoqE9o3EBI5fiVrIWPT6rtIc3AEm8oU2dIStMvBpMwCQet5pIzc7rnPOrlFuPkFvCSaEq0+L20wEC6ClE+y5LrlON+6ozG8fA4F2UtJuxoecjWel3cEkzG8bG9GJB+AYtyFxq+aiXBeCMu8XYjD7scKA8oNql0BCV7HeDydYMVD4fUqB2eNH3ZwBTm0XgAdI/JnZrad1miqpNOnorWgEgUCPFHKMkmjSwL07uQ17IHEAvAf3DygzBmLD8bB9VOkaELpmcJVE1mkYaEldXzaUM=;25:/UCK2qqLiJSedGO1puQAPpff3H9DP0/BKdYOjnFkIi+EUM3vwq0w0L31apzZ3sogc1SowHqp/14OeD1FpWG81B7V87lc9EkarFrGDhfuKAZhsXcRGVSflNwj/m+6My2nQK1YS9Oh8ZkvlzWs+w1LLpyjJu3JpnfjeTfF4pcL7bwg0x1M/Ri5jI7lWRNPdVnr0ueUW9OisrZ1O8hUyx7reehYKnBQLdQmAuHqnxpepQb/qI+DQAXwMuaqMt8vyhZ0W9m8cEb7d18caqCa7Q5PFikdAL3qoVuemBn2s72xiIZQKs/uG71POTKxwUJbgQunjNz0B/BvmEo07tR8xRZZJpWq+9dNBk4kbOvDBL9U3Vg=
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1896:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;31:JWibwLfEsv5mynYvrjDySiqw31cxtJPcUVcj1pwYX2VK5Tvx+yjM7Zs2Au4WIA9m8myI7tS5qxgagUxUFhyy2K00F51+NMcZ1kbo4QpHJTtc56uz8cRgXbFpDL/Dj3K6cyyH+tqAzhtZtSZN27809ow7il+UAOTIyYN9Xadh6/lzcZe9WHw0aBW12tOftjHjC02Agm3uybyumX0xGEQjn4YxG2v6EhKUAokoddKo3gQ=;20:jhNpIPKo5ETl3qA6Z46NTqF25n1MbmNXTLd7txWgZtO1x0RtzoSmhjkaOxwFSAPLKpe0OzGtXSexDtV4Mc+vsB1wTCU9ZwHVeabDYHUk80TMgplCsdcd7WT0zXcxFvGjJflVDd7jw3e1IJXFAptWnLsuFbmx/9VsXJNcqok9L7JE1rskmz0fl2aqSMQMBuwaTq0jj8r4UnczGcLp45ua4L3hEKKv5lfgc/iz+s6aDJeR2Sa9xeNMwGLjegbrXYRaU6Ct4kI/nBwbk1GDtX6/+MArdosGaqpVVFgOH+AHD2l0UbvF0dYo2YLX6NFFQykw1Y+KGR1NR6SFf+BCrQJzwJYZqbDoE9wpXSMLdXz6ypDnyPWbu0KBAbV/zrccz/I/U32x5TCMjDGuEAGvMhw9YWC3q3sn+kvgoTFkLIPgwSEWiJrNmqz3AhDhpWzJC1+9MZde9bB8FezQZrjj0xORwm+xMt95mho+CAAaER3gjJ0XOGfP954r0Q1u3CgYQt7+
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB18966412147F38DD80BFADA4BABE0@BY2PR0201MB1896.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB1896;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1896;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;4:uOMRBklhFrx3YraYTa2x7/muKnkSbMF/Lb5WO3HUcy+P2p63BDqxwd2kFbMtqVOylnOwkkj//qNnS5aka+yzLL4IR6797KU4NfESoLpdS1lprLAwKG2dxsYm6AMXkr/VKCQe11iRO5tnSe7XfXLTsyoJ08NPkBENfmKXosO//TTP1DflMc3XpT4Z2YOkl++q4zQvuslRWRvY6LmirODIO0pg5VesqoZEOchO9FHr9Pb5QReJlWBKx9Ro4ZcJIBoKfs4NstDaKQW7Prr36N3bTw==
X-Forefront-PRVS: 0891BC3F3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1896;23:9buaQvRtsr2YF4pMki8K8/WsLF1tFQ4xMMVGscN?=
 =?us-ascii?Q?JxLfb6jB79cHo6LMGrd2mmbgGerkBFyMECd2Dst9yF2yiZLYZBVwmFHqQD3K?=
 =?us-ascii?Q?pKDFbMvwS0w7rAhVKO+ljOiL+5teYDx21Ufk/8cSF1Ib6X0FEbwauoBg6vPv?=
 =?us-ascii?Q?mJ4HDH9vxj8l9m542RprwBle1TYM3+EMqJKEvnEL9ttVV1ANBxa6y/zeCrYA?=
 =?us-ascii?Q?NjMMQ7oMDneiWTmNC3HWD68TG/7Faj26mirV+N0EMLPeb/wZx5Lsaa7e2O6l?=
 =?us-ascii?Q?Nk5cpFOQb+UrGbMkwNrsIAqOWRM0QciBkAif6oF7LHHUDE/2GAUNsa8opPqx?=
 =?us-ascii?Q?e4zJaeqE1Z5kaTqYEcTIvV7AOzvY3UwyzvNFRedw8Ui7zzKF7LPKLJSuMEII?=
 =?us-ascii?Q?umLvrP1OooPxEqeBsOTL8akXIMMoyrY8Yncrx04cPU8qzvYNZq4FGl/zs6E4?=
 =?us-ascii?Q?zA+av37q5hWnCQHoWa9LfYemM2UqonV0zYAHz/WhbaOJgs9rAxdqug5aCniV?=
 =?us-ascii?Q?6Ud+Kyg8Fb8UE63kJ1nzvY+zcAI1+H03Im09znwR31VBoyy+foLqfOFWbVfM?=
 =?us-ascii?Q?IQrDD8WPrBn3A6U3+Wc6Gqky8QOKyymTU6gMBU27w2OSm8i68obmFjbiSktL?=
 =?us-ascii?Q?HiA1cDhdrIdq6vy969nt+QT82S0krsXlYGmoo3keY9BxN1Xry74XBabWkHTs?=
 =?us-ascii?Q?SOVcufkqg56XdfzJO0vXqQuZ2XFQHAvB7AUK+Gb3OGeVDVwpJbgtzdhJ6D7v?=
 =?us-ascii?Q?W1fnda4sQiXHrIMZBpTz3KUuMpNXXr/rW3mT9ue736kikI4KLivubURKSXph?=
 =?us-ascii?Q?9b3vt2jvwCw6Hqz+wDWC7S8TZO11YecQW74vUfj0+8dioKRuSVcosiLdLiP+?=
 =?us-ascii?Q?+irwaBCQ5tITiWj1z3FoiPCxoXHVHgsJf8Uf0K0yYdMy1FWZaaVq5IPjVVhs?=
 =?us-ascii?Q?O2CuMw8LibQuVj7e3vkeEy/fj7lV8S5AercMAAya02GOcCrOQWjH7S1lU+N1?=
 =?us-ascii?Q?NpdaXzEKSk9NiYtMOZgOC4Laf1mQ+pWJ/ye+hjgPvm5h1YYDIiHP6xwZyqp2?=
 =?us-ascii?Q?gvioUeP7PT0u0QFrA3BToEWx1x1lb/NWDxGMdC3K5GBQsynxaIkFti3I8gJP?=
 =?us-ascii?Q?Nrjur9zkXDqmJ/SD72WgOB9IJLtgSYwAHx/SIA1gVcdHCrWq2xDgHJDmszN0?=
 =?us-ascii?Q?pRrxgsbRwTdreHzkTohdlr8gzSLPFOBlEyxsWwvAwZTvcslAdmtEdPjSps2E?=
 =?us-ascii?Q?UKPUNTwwZJJy4/yV0gd8=3D?=
X-Microsoft-Antispam-Message-Info: y2Ga0yklavXYpwNrD6jteGuk4vVLnt1jrNJeM4K8t7vN3Gc/yzOcIPtOn63xArBfI0DsWJtYcwC5XvVCMCqCuSO3xftNG6j8ZE1YcjSIEp/KkN6dwlQtIrYOjzIQSk6waHjkINDUQbKAy9cdyvc9Uv+6YzsfHFzcjVOpLwOHUAeTakTAK8XQ+EI0VxUrE+TqPpYXct7m9U/L6vo/c7fUPMshGgaTvJkooe/ze1RmVnzl3GmUidQtZG81f+YrCyNOdp+WyEFVbOZkoOuAkBy/SXZqFDy23U9Txg959snSk8wfvTCFlh12mMNhzggrDlVH
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;6:H5allvTC1J3ZNKXwmg2m7iuPSlKL8tOv49tDHuH+KpQ83IwtYYJ6/inykJpQGwfOqyEfk5xsbr67ciNPE+DIQUVUtdMJxvHB1spg4lMAsqYMXje3OHVsgWzwqjxlMJhjW+PvvvcFvmz5kXflqg1sKCEWHDWflsODjoRKa9BJ2XkgryqCwT0PhSNkO+f/O661XDHsrQQQ1FY+TCKANAWzqaVp+7JA5P/AKJXKeJkQ4f8GKWaYw/uw/RPBCGMG28y3OyniciaXrdL4Y5xDnGXNemnjN0rgGjU5wHRyjmwym95q4+X34RLyU8M/wNFWEzdpHzycELT4yy0JiG5a8U5n4nG6P35mHGmsA68V3tvhQi69A0xeaQ/yBvzEW9wWeZ0gCV9cIBNjyg6GHp3UvNRxO0lplJmZlsFGatYbr62yakfmqM/XOOXRHeZgN9mY5SK+ORWyIY/Eh1O5YlICJOmK3g==;5:uzVSxTGb5nlYKPGx/wBJrG2f4DBbfdfPjc5kjk6l4Xl3IirkCFMgF2kz7cqd9D5p4JSZ1VkB+5q2HPaVOcVQegvLqtY87o6Fh4E8/8mRvzKbOkAixlrdSiA5PU3Eq31pC/3NvRx30pMFCQElj8SNb2P6yCRAyM9PB07H5bpuA1M=;7:lCm6yYwYAhpBeZ6fXtK7aVxovtiECYtrnZjDT6sheBIhHryE0y2rz3oBoKeru0Y4siYwQwVip+ULcJJuYQxdQbei0CdBZOAakEUtOv4kqDsfLJsssBHVwcZQsPRSN5NrszB4TXEJH8rNL7aIaBpKIA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2018 17:19:25.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c907c8-a5eb-40a7-05da-08d665d62059
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation for audio formatter IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 .../bindings/sound/xlnx,audio-formatter.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
new file mode 100644
index 0000000..cbc93c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for Xilinx PL audio formatter
+
+The IP core supports DMA, data formatting(AES<->PCM conversion)
+of audio samples.
+
+Required properties:
+ - compatible: "xlnx,audio-formatter-1.0"
+ - interrupt-names: Names specified to list of interrupts in same
+		    order mentioned under "interrupts".
+		    List of supported interrupt names are:
+		    "irq_mm2s" : interrupt from MM2S block
+		    "irq_s2mm" : interrupt from S2MM block
+ - interrupts-parent: Phandle for interrupt controller.
+ - interrupts: List of Interrupt numbers.
+ - reg: Base address and size of the IP core instance.
+ - clock-names: List of input clocks.
+   Required elements: "s_axi_lite_aclk", "aud_mclk"
+ - clocks: Input clock specifier. Refer to common clock bindings.
+
+Example:
+	audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
+		compatible = "xlnx,audio-formatter-1.0";
+		interrupt-names = "irq_mm2s", "irq_s2mm";
+		interrupt-parent = <&gic>;
+		interrupts = <0 104 4>, <0 105 4>;
+		reg = <0x0 0x80010000 0x0 0x1000>;
+		clock-names = "s_axi_lite_aclk", "aud_mclk";
+		clocks = <&clk 71>, <&clk_wiz_1 0>;
+	};
-- 
2.7.4

