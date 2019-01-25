Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B840C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B713C218A4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rGSg5Foi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAXHqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:46:53 -0500
Received: from mail-eopbgr820051.outbound.protection.outlook.com ([40.107.82.51]:7424
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbfAXHqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzg1HvmTq2ID5nmBPg5WCDjocilLb1zgGT+7bn/Vzwk=;
 b=rGSg5FoiSCH9ilQugtjHa160ba9aDY6SZ2nmXCtRydn+HCTtrd9urpJswPjQom/FpaaJtpGoxuOsxS3p/77c3+66QplJXciU09XBuuTJetO1pK1AsmANz1ymmXoQ6wwDU4NLHJyp1OgeAiWjLac8yVXvfTfqhV3wS9qqGvlgTE4=
Received: from CY4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:903:18::13)
 by DM6PR02MB4329.namprd02.prod.outlook.com (2603:10b6:5:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.16; Thu, 24 Jan
 2019 07:46:42 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR02CA0003.outlook.office365.com
 (2603:10b6:903:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Thu, 24 Jan 2019 07:46:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Thu, 24 Jan 2019 07:46:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49100 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZif-0007f8-Mm; Wed, 23 Jan 2019 23:46:37 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZia-00072k-Ii; Wed, 23 Jan 2019 23:46:32 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0O7kOr4030052;
        Wed, 23 Jan 2019 23:46:24 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gmZiR-0006yr-Ey; Wed, 23 Jan 2019 23:46:24 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
Date:   Fri, 25 Jan 2019 13:16:54 +0530
Message-ID: <20190125074654.10950-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125074654.10950-1-nava.manne@xilinx.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(199004)(189003)(36386004)(106002)(336012)(186003)(76176011)(8676002)(446003)(305945005)(2616005)(51416003)(7696005)(486006)(126002)(11346002)(478600001)(476003)(426003)(8936002)(81166006)(63266004)(81156014)(9786002)(50226002)(2201001)(47776003)(106466001)(36756003)(6666004)(356004)(48376002)(26005)(39060400002)(316002)(2906002)(16586007)(50466002)(110136005)(1076003)(77096007)(921003)(107986001)(1121003)(83996005)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4329;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT029;1:HMG/nHUe+JoiygoCVsAcWYhgTP9NwBmTCRJuqcIhLSoXL/RpJoJehn1/mwOXonpXi/+gOmrIWlJIz6O3AnIxXe9I7l6isd7aOs/PWlaM4YpgNkgRpf0tu9Deox+mKmG9r0BCHU0v5noNQ0uhy9I6A2pzDvtUf3uxYd8kLJ/M2xk=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a8668f-36f0-4b84-696a-08d681d0144f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;3:KLUBC/R5vEofvlTq7t0wb462XAifl8jB1kqDXrq+gK5fk2Jd58YxqhuUEjZ7bg/Ase+rjG+SRN9a/088YXjGIsFSFj9skW6ytFLvgrql87XRpW+wBxsWwamZ6x8or+gxtGKO5L2EgJKZ+IZj1rJEvtP9EmaaUZMRtMHgcXBZ9GAoe0LN/UKsHGXn/PB2hLzz2lyslQ+x8Bmf5Yro+4KDoWAE9Tgof44XXIJjvAmzJ9fTHeQSnKuBrzioR3jJF2J2RxWR4Db16L7BGrSHDpiSB41agTi3TylWjuXb1qTGxRBqvmNW3qZbEev8jTnWuLBImyB6NZAiUZU8fCZFeddI//JDqEmWUJ7MgmgXnW6eFdxMmvFNzyeFQptPv5ZNRyQQ;25:VzJ/og9w+mAd8Or3K+rS+sSHFQUhszVPiFuCf3t7DOyC4LQYbx5l/uqKdf4pcvY9fXSvpgtWqHsCfnRzTSMelU583aAl+rOAR87hACOfvRgcZp6cWxuawhYGea72Q3uYgLP178M0kL+ucFyt9BxaxEjaj42kKGuh4aMlG0jfTlQhYIwKCju+/cFidIrHWBJFd7lZA3eTfTJkaSApbyYoAkaMtsNbBQu7gwdth2JoJST08SPTCNO3lj2AJd8CcGYxvNwrOKFuijlLpXkx455QjjqvFyguENb+xXPh/WcUFVOlCtZCtL3rDiiV5S0cuG0pqXT3q3xc9zjpThl02vvr7Q==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4329:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;31:sXe105UD9p7VAtrWTvd5siOS0j+fd/J8yOQ7N9IrgcGo4+We6eLMD0Qi/RYxlYT9DBKL4Lqydcwcbr/xwJvWtHJ38AajtJQ3b8oD/U7NNkBjeIcO0pocdh6xRDIFTHu5I7Mm6E2OldQZ9NDZIByalEAKfJ9boxp4yjSMMC8DJUiJ7saM4Xi2XopgR3eT8voS099c5qxhAdBeTWSU6xuPtEoMmAnQO+MWcrmj2KsDSFI=;20:OPw94GgVdi2anXZ6qAMxtDBV6m/ptInxfQuzYPk7zTORVtgF+L8H18v7DA5gyROno7iO3756duJpEVzMMAu6CpL3q/xrL/XSR2CZqOBxYDbIwVFUCfGX3vGKAOl2HkrpqN5KSpwTi1UB5ZbTak6z1KJ3ibtimG2pT1KNY6Yw3EADNEO1krtkj/yiK4iAOS8sDt8Y4doKfenGwUB5bMZxvCaAWyPaXeZrF6bSL6jXOFL5R+cGqRbE6O68JffoUus4gjWDdA9fkEHfgTGQDGB4I8earJsGIdTLbYkvc5tmtGlYrAOwQZG9fBcd/bR4Q56YmLmW8wdO9rEr9sp4WYuvTl5F71vMTOlIkYej+pI2PXyJxcVz1CCrabrF6W5dwfThEc+o//8nBv+XQyN0/Gxzbhrm5ig+FiejBtCrgHuo3evuX/E/K+hnTSfhr7jdbwN74r8u3OCEe+oLhqmsw88ffmOzyIZd60KvqAneRAoqTZcVjaNb2LJjpdH9vLowbQ/8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB432904AEEBE7017628511BBFC29A0@DM6PR02MB4329.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;4:aNzTcWwZOnmH0HBEHQLXqFAhHWZnYD2si4gxY24lrvyl7zhjp2FL+FEmXkMJe7cfQpI4qKmgQNeCO4F2tSp9KV4fKFhcx8ahAye+JDJ7Etf4G35PDUjiwpLMmHt925KdqF2ToXzGHTvzFAHBdRvryUogVrp0JRv8PMSncI9xOFRxmjkxQTVVSMGiHVTdH9Lk5+CTr75N9gNY9GAM+o5Qm6GOO2hqTlaaLjEr4ipQq6HJDxfndn417Dqm5XC5WHJ52d3q5Km2tru/2YVk5t9VNZAjkH45wDDCOM9Cjy2E3Kc=
X-Forefront-PRVS: 0927AA37C7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4329;23:Vs3w4Ubi1CeNhYo7zXr61YmiPXuM2Y3En3nnBrt5v?=
 =?us-ascii?Q?iJlfVlWndloNifEeS549XDiaz5TB/8yIKARxB5IbS9hMsNOvoJGxIn3kD4Av?=
 =?us-ascii?Q?Fjh4d9zmVzffp83I56Xw2tTScVH9ZknQcqO/u5IuyNjZQMHKctzK8XY/m1P6?=
 =?us-ascii?Q?OjObapear7y9dhO9ocOpvFgwc0iJcyE4EGDT1CaLp60ylHzi2F5y+R6ubLYj?=
 =?us-ascii?Q?PuIp2czYulvVrt89g97wvsBZeNHt+3/h5LqU3S5tZbDoSjTRpio1tV3xJ5w3?=
 =?us-ascii?Q?xANLKaVligATJzdymfsYakuIxziWNb5cbtgWRMPZtpzMUQF2WsYpXxh7bBxu?=
 =?us-ascii?Q?qfEPGW0xJyeS/4rEVXd3e1jhMLosuQc1l0Qn9mYTZVS93XRg/bGu7XKS+K44?=
 =?us-ascii?Q?pJ8yu04PybQV186griZpC4fc8TMYkpwGs64fsaz5kB45P+Kca+c9xrNgt+CV?=
 =?us-ascii?Q?XViEyw6A3go+JwZqeuvXdSM7akh5iwGS2+6gm88+9kNqLS0Gizi/It2VgN64?=
 =?us-ascii?Q?7G6Mz+/8+Xudf63QiiyUNOBmkb/40M9xHVJoHaG3f5IM9UWgUJLWeJ2oQiuT?=
 =?us-ascii?Q?uyxpxJtfMwhFpHigUJbbJi7W3AKHuemSWK7Kk8fAe763rugPDveZclg1mjqe?=
 =?us-ascii?Q?+LCFXZxpWOev0b3+JR4C6kc3Yoj0AO09DbAK8p4GyO/TeSIu7VrMDnXDyOMg?=
 =?us-ascii?Q?77y2FnUHuUx0lq45UUOZT4PGx5zFACD0wmfhrgeX3eudpKbyX4xvsawpERc4?=
 =?us-ascii?Q?Ab8B2ckx2yv77BkkSqCYzhpKTynU7t3AKzgyZ6gKnPbUfyXl9VETpBrURJGH?=
 =?us-ascii?Q?LYj4b9eEcZC2xsswaDwr55/1tRvv5rA5e1sXMpNIoWE8pGP5vwx3l7AEXgRN?=
 =?us-ascii?Q?diLFk5g7SkmaF1FEo8jQPAVyStsbk/9HdrKpP/HEx85+Ye+9pcLm1aGd7HFj?=
 =?us-ascii?Q?TvzlX4417UFf3h5wwj34X1YyTNoifK9r8/wWtana7u6rPSajSHnL2rhoFyhy?=
 =?us-ascii?Q?b7SQ9FZqd93KMbekZg1z3/hL1mNpBbB02QUpoPCQ2Tt9PTRCZ62Lc44SRHhE?=
 =?us-ascii?Q?5z/hBLUVUz7B32Mg5Q/IWB1pT3VTYFYqG3cKuGaooo2R3ELnDt38czeBjeOx?=
 =?us-ascii?Q?/k4f/yWUKBLZlxd0ygcNd7MboeY1o2JydMI4P+as1wJW3tp49/OFHOWNbqGo?=
 =?us-ascii?Q?pGFfHtEyDfbY+s=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DJT6DhO1jCfvKxKP3ED+1ou7cMbo4xWmI6a7CHhexD5b2e4I0tYC/+Lcld0JfHEz1zJT1eJ8hD7iw21Ui11YZcEv4H/DP4Inf3VQqVVZvlx1e3MzMK1i8TVMO68LM1eyNKJqQUt/ZSsJZKWpnpC+pYxu3ORaFj58V4nQjTishKPB6WHPTziZGRcM4yBgkeqI2cKONhoaFvycdPwddYcWudyB09wQs0BfGqIkW0ydSY/de3u7FbbdSDQxUHlemtUJ/3c9cnYQGOR+sbY3MPdaGCTYullcuHVJhbeqmwhc97JVk+7mjf6Usi3CMw6n/1g4AW9uleazINAQuI7MhKaeqhZEl6T1OvQTn9FHi2V1+Enfyo8kj7yb44xNQNhU1Jk8NQiynom2XockAuzKyKUSgBRl2xplsY3KVeJo/XL3Uzw=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;6:66M1/iWp9VNrTLoOqVY/WOEVsh9N8EcsIZ24Us98typQs4+MO49bw6X9yUOg0vcq5Yj0KjxwqkNUZ7eRa35CNv3R5l8qj2wf7QEmzMumkHNgguIx2TU44xD20MfMaJ/K2kygHd4Hu26gDfihCkQOholhJovt7c+LKrRk1JNMQer5ZGmjiccdltJQf6h4qFGvKotXvFWwd+Q4v1uIGPbocU5aZiRS4f6wbeDtx9OCXZH1cCdFee6Z8eJ/3tD3GXv2U2yGRJQmwmEd8DPLUkHWmwdSYwjYaK/vPz6A9BijJc+9+gmHxcRaT0zFv9p4fV9r09d4VY0+404CLJ0wOn0FRiCfdV0Z8Fg4LSgrqSJ2rVZCbBE7guSb3cTY2aQTB/7PxrAGm65HFAJy4FkR2OKHavHopyx8BreKIDpmhoI+8s7dbDa5uYdMlKVJBUovFt0xo2LfWMHpgYA+dr2KTgHX6Q==;5:66SOvwspW4ftFIy/kejzJjS8rDKvDGk22Cfyf0jz3tPEZAbOhX8vvI2XbFxgoZiCv7H1LQZ9JXMYjPrEEvqcaYEF/uGA6KfwvAwwkaH/f3RS3zZiXcVvV884x2HxyQUOOX1sZssHIXnc+9Km/lfAUO/rhDED7oSgluPldrcIpNXQnTxBCFmPF7er10ea2avhGBBWvLh5oGDJg6/91ABP4g==;7:Bk15S3jJRCerTOWPWRSkCocKQg7cc/hxKFOjGmuUaajEfq5c0Ty4y0koioi8PBKKIQnoxHZwtlu7JOodjBw04FcrWGSRA0gKrJLarZ1pPePhiVk0IpAlTVGDXvzoOguFo/bqulJ4F/jq1XzubXcFug==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2019 07:46:38.6244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8668f-36f0-4b84-696a-08d681d0144f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Fixed some minor coding issues as suggested
                 by philipp and vesa.

Changes for v2:
		-Fixed some minor coding issues as suggested
		 by philipp.

Changes for v1:
		-None.

Changes for RFC-V3:
		-None.

Changes for RFC-V2:
		-Moved eemi_ops into a priv struct as suggested
		 by philipp.

 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zynqmp.c | 114 +++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index dc7874df78d9..573b8386d901 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -26,4 +26,5 @@ obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
+obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
 
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
new file mode 100644
index 000000000000..2ef1f13aa47b
--- /dev/null
+++ b/drivers/reset/reset-zynqmp.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)
+#define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
+
+struct zynqmp_reset_data {
+	struct reset_controller_dev rcdev;
+	const struct zynqmp_eemi_ops *eemi_ops;
+};
+
+static inline struct zynqmp_reset_data *
+to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct zynqmp_reset_data, rcdev);
+}
+
+static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_ASSERT);
+}
+
+static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_RELEASE);
+}
+
+static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+	int val, err;
+
+	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	if (err)
+		return err;
+
+	return val;
+}
+
+static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_PULSE);
+}
+
+static struct reset_control_ops zynqmp_reset_ops = {
+	.reset = zynqmp_reset_reset,
+	.assert = zynqmp_reset_assert,
+	.deassert = zynqmp_reset_deassert,
+	.status = zynqmp_reset_status,
+};
+
+static int zynqmp_reset_probe(struct platform_device *pdev)
+{
+	struct zynqmp_reset_data *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!priv->eemi_ops)
+		return -ENXIO;
+
+	priv->rcdev.ops = &zynqmp_reset_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
+static const struct of_device_id zynqmp_reset_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-reset", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver zynqmp_reset_driver = {
+	.probe	= zynqmp_reset_probe,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= zynqmp_reset_dt_ids,
+	},
+};
+
+static int __init zynqmp_reset_init(void)
+{
+	return platform_driver_register(&zynqmp_reset_driver);
+}
+
+arch_initcall(zynqmp_reset_init);
-- 
2.18.0

