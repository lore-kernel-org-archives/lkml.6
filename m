Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E409DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FAE21477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="feyIDHjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FAE21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJSQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:48:16 -0400
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:50549
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727193AbeJSQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GT8R1DAsaB11VSmkPUA5wfw+k4fdGh2HTxasMKepMo=;
 b=feyIDHjokyQVyWp85gva3Ywmso2BIal4xVlUK+mbmJWaNvvQhBVNZk3sCj64B3D9v/kjoK/Bxp44or7luy/z4Nnz/zFdlzZNFDrhCHCr8y4j0gFxsTCclJ+ETZkAljZgDVCsbN33Rg7mHWUlfyGklWhr8d8+1UcrodXrcBFAaB0=
Received: from SN4PR0201CA0068.namprd02.prod.outlook.com
 (2603:10b6:803:20::30) by BYAPR02MB4325.namprd02.prod.outlook.com
 (2603:10b6:a03:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Fri, 19 Oct
 2018 08:43:04 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN4PR0201CA0068.outlook.office365.com
 (2603:10b6:803:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.29 via Frontend
 Transport; Fri, 19 Oct 2018 08:43:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:43:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQN5-0003tm-CB; Fri, 19 Oct 2018 01:43:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQN0-00025b-8b; Fri, 19 Oct 2018 01:42:58 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8gnCJ030777;
        Fri, 19 Oct 2018 01:42:49 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMq-00022V-Pb; Fri, 19 Oct 2018 01:42:49 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
Date:   Sat, 20 Oct 2018 14:11:07 +0530
Message-ID: <20181020084107.28251-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020084107.28251-1-nava.manne@xilinx.com>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(438002)(199004)(189003)(1076002)(446003)(26005)(8676002)(77096007)(63266004)(486006)(2201001)(316002)(106002)(305945005)(16586007)(356004)(110136005)(126002)(2616005)(39060400002)(5660300001)(186003)(476003)(11346002)(6666004)(336012)(9786002)(36756003)(478600001)(106466001)(426003)(36386004)(2906002)(50226002)(76176011)(81156014)(50466002)(48376002)(51416003)(8936002)(81166006)(7696005)(47776003)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4325;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT021;1:rAWGjRgoCBIeRinx5P1TgxHVB/eRqsEV3nn1I0p9NPY7a2IBODcVcHMvlVi2tEuDGd+vxeUCpSDvkiAgf7aFh597z27wdRmBJjWVKDzjKnDxCd2UQxy+QEIjfSqkv9Zn
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4c74f9-2122-49ae-0b36-08d6359ee24d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4325;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;3:cYceEQESLY/XVbj8bXnwrMDhY4mBacaqpm9wV/yb3WmCd83Gc/hNq+uLUN2yrZVQ1GMecVBCtGBJnPlzHPGqCIlohQpBcbVNz3Wr+vP+daucSf3baOT+S/kxfuvl75iHXYHdeUV0m9X8uklo4VcCVIA1mOlxPTnxRBd9vMk8rzO0GrxbTXl3GC8PIPzDBEhA1VoDtSweDuZP0uF5hlY5C2hnpYR0xitZvJg2xuS9J+9ZcIuUegNI3915OGuffsKF6aDXkuMdE2Ut5iTiq99qwikUAWicXVKdo0EG61vpvttLdEE9OYyUzh1BEBUSVFX2I3RbXWn+pGY4bpvcriIARtWCP5Mu7l8cjyJB/e6UU8U=;25:H9e9DA2gMJorXWkIDRtgufDE+4SK5LLNJAe7G7y5yAo+YijhkGygFZj0wg85s/1vKRSGaj/iih/SgoGxlM9gKxfR9KOjHAsvidpw7ALQ3rhieqxuOTk0Me8SeygiliETQ4B5MimztZ7Wg51SNpxgSgs2RIoRTscuhBL/D0uXrUmP5tG+Ry0PimsoKWi890r7eyH+IkSOanRpWjrko5mKKXWhEoq2GXBqNjaArGfbgi86uUhGCha54iKwE/iPm/baFwA62J9Zzb6BJ+WEOZUmvUtSDmgYEdBEdsTUjmRHWBmgKh3eJEEDN7M/oE6KKBJYwKLAe5Vz4Kx0l0yj/q14GQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4325:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;31:B//dcRaL3rqNEL9ptwHH6fxGQYdMn/WpVrLC7yKH1/hzEP2qmbDtFDgwAckYTMp2WDnJe1Lz1L2B3Rf7vsyVtx44XVFoChuXt24XibUF7FIw31LL4i4mHjneiOd1djZsXXpettNVscwU9mBosHQVqmQzcKYBojYon6AjI0dIJCuRiz8Ce4O1dUQHNrlNO111Gxn4Vz87DaF+Q8AXHsyFOZh6YpVdT5xB3y8DsGwDDvc=;20:l/kDP354qvv4OZv+KiAy/LjlysOABidsiqgE8Xn79LqpVLNVttlPTcvu4i19atsa4iOJ9aokssBOCJx1bCUDMqmYQ15StaY5XniwuAdCR250urK+SsVrOMieDBq12my5rpYzneMVmFHEvIzeN3uYdSGrxDlzLWGcJKC05fiS0NQjqud41fSLMJfOGeFLrJRMO8n6cTmPC0vayTOSoSmjpnNhRJNs/yoCSJ+7YHJdc4Soyjh9nZfBvRJQQgEjQ9kbI0Bh1NUoB5lug+feZm0iJZezFvyyhwNIneA8nocdMtAfbO4y+IMb9D1iw6blzbMw9mCmm8XF4U+QmXnpH6aMb6Wp/e6FV2L0M3i3qFHHFWFNGB76n/78YkkRxLL0g2qU8eoQevvvWA13q0quWFKBJWn5AOQ0AOYNdYuT43uX0Vec4fp/BnpmQtHVncSErRpvlUD5+hQSBl8kDBT37aTzknog1ab+XrzXqFmzCLi5l2uiyQLeR0Orge5OEbRPJkTb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4325447014EDF039308E8D1FC2F90@BYAPR02MB4325.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4325;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4325;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;4:BpQJKeFafurzRgbfcyH63kXLaeOxFObljDpLLlU80ih3E1vG5aC0A+fEgi3rVYkDj8S8rGBReJR0o8YEdI4QTBZR/AeNgH47w6o92Mnk61XjjvymxwmlNcgj+0ABNkcGdR/ZnWVfKN6W8UrNKJoJTakJw4iL2aOPCNhWkMgPeRrtp9gr5PMdwq5W8wV8jhTKrgDKbHEe7Y0wF5Q9HMReTQsG3jYtviwxZEXrBKHkNydQ4eMR8k7Q45OKFQeIKW0kooC8W70DMpcNNAAclg8R4SDePIktOQ9m6k2AGC9heas6MLXavKX8aoxxAKBACwbF
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4325;23:jfG0breKCboZfCNfNDA/w+koyWh7DW9fw+0EtHdq6?=
 =?us-ascii?Q?l6ihhUTGYO8zFeFNxEnP5FcKokWsQX0UCIl+GFdf0Gqvp4KUkQNCpXYQrXW/?=
 =?us-ascii?Q?ip0AbrH9G4UznlQY9aU7UHru9LhxPFxOQQbZxqWE96MUSm03Ye/Bd3cHoc9V?=
 =?us-ascii?Q?wpw4gZW2szB5vyZEGdlO5AJc3nGL0cLKHHCbuGF2jbEcycgGEzdp1rDb4c61?=
 =?us-ascii?Q?mv3UYkAmmNZdnAoKuJIsgCimXc+zkGtrayQupC1x64iVG0TpKbPpWPwYnBpC?=
 =?us-ascii?Q?MtdrCpEZ8aRVM+vxo8X0OIzDkeamkeKYOUuB51I9PZRkmhLDqzAENnqB2VfM?=
 =?us-ascii?Q?o36FWrKYh/iDiWfNM8mWYaEEZAuT6WrfQTnfVaBz4u9RXZqqIlklwU/ITVG2?=
 =?us-ascii?Q?TeVRjC4AFkhg+lS+AoIvzFHViLM6WzxOn0P96NBSWV+EmB9aU0MHRO5yxCEG?=
 =?us-ascii?Q?MNOvKDlf+OfKJRR1fKo0k5Yjli81JqqT6T8qQDWJrG3gshdxpgDWEQ9sqDnn?=
 =?us-ascii?Q?uD4d6lvu7PmO+wMXf+Hdf+prhxElNVXa1915+y+FBbol93wRkSS/76QMwMX0?=
 =?us-ascii?Q?Jtu4xZRR6oeXCM18QXo+FR2dtl3rB5gz3hWiTOqcGnUyr6vDgaQOROk7PPrz?=
 =?us-ascii?Q?xdRRr7+RiTEJK8xtM/XiKe9RothTke0nvq4IcHVJZwQiyRYcvrLBxsSiHPVQ?=
 =?us-ascii?Q?bgqaC7sTiKFs0JC//uDpvE+MlhaM/toxVYijnW7kYBPStst0Xbokslh6ZIK0?=
 =?us-ascii?Q?gY2yzezH223JfTSjdPNUWcw4fAqeqWIRhi6xvpdRtCygp9DQI3/aA9XZz4xe?=
 =?us-ascii?Q?ayur9fSWL6w4yvLJphZeEoFtHTq1j5UY3S1dfJlNOtzOeukzHq9l+CrenkH0?=
 =?us-ascii?Q?Qqyh5IgitgV8eSuFVXfvQE3KuM0B3ZLRviduBYrBd187IEIy4p00tDp+MtJb?=
 =?us-ascii?Q?dOtib9W1/a/ltCWbKmCUNmPQ3+DL4Rxoi7Llznc/ph/dcNvT4QOEfMq0o+Pv?=
 =?us-ascii?Q?Vwkz+4J/4t9sX4r58nQk380WdvHRR6FGRIIDFe08kMCr31uix0gHKlzTTbJw?=
 =?us-ascii?Q?LvXfj1V8L4YHrSLdgmtdTD4gYvug7mQJuTnTM4qgr0VAsvf679vyp30fLw0J?=
 =?us-ascii?Q?yxaz12oA1D7xCFJUxghNluqx/UOw1fX/cjaErrMPzoE2YQfbteUY7nxQy7Kw?=
 =?us-ascii?Q?pt4Pbcqg5pwDts=3D?=
X-Microsoft-Antispam-Message-Info: aho66bFK0rwoe9nbvuXJTZwtHQtD3OoBe6XGSN2OR8aq0OEby8QdFBUD0sdn38rvmOi6XHDSgjzeWhw/eWDQZzBdcjxGTzOO+FkgWJlfzpW1xYGRBRNCGevHSKFByViQr7dFM6yxkmsDlsu36i/LavC0SBMouq4FThkzYLJRu9G2na9eguowY6Ab7tHAX5TrKR7FHGLnTD0jq1sBcyp8WfmxmiL0xRLrM3FzSodCnlBjHrtptst1m+9qyAAms6mv0XE0obWYXVazKbYwJgj8rUIljhKgv9s+byQ8OMRPTYwIYBcA6DzIkuCjg/cVfPSyTJlU1MnIbvz+jfIE1AQRNMS/xKzURwYC0KPcBuCfZxs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;6:n/Y4vRg4RpzMxFMsUZysf1GL8y9EUmsXZYsVQu8dUFUbsBnmIg7jDuI9cEEh37cJQpKpS+cDM75mRMcTmSCHo3aiMXm2MulZWjz+CcYbF09TdpoaZvU4I/lkBOwdcRwzzrfa2e0PEhJf3bQRGNEJiPdYlm2r+zHsYSXtUdctXCphhQWEQJ0UD/mUNbXJ/rocLBezWHGHzqErDLOczeLo0loERa1wyJfFacmCKsMcu9GnX548imVYQpPJkoblCiB3dforMfZ1pyP/YbrSp8Eyk6tBeCz9E4mwIhjWEc+8CPcklMDvWVjioB86ObsZ54uZvc5OTvMJkTV6rcDsEbY4huBMnr+EBsUP0lUpDcMrrYQB5OlEMSEWPCDTsIkLUyLEpSwKZkzCInVoHhbTfyCnzuy+y0nePpGYzuNMRakDXpxqPMS2E4lemtWd0R6dhhUntq9iJCVKh7UuuQeXA2A8iQ==;5:F60oGFGyPEtkSpoZfmiOaKA9+l5VxVhjEZYSYHoBxbbqs0R35Zb081S+p5jLOuAeZWKfwLd/7fWuqs4U2kDOs9AYesLqMGFP2S05DCKzIk/Q7ZmvhFyPjNmYKmSjZfggxrliBUU/i0D9bqtdWsfpmMLv8/wXyRCL6DZJiQKWmSY=;7:hR+fib2PlYw1fujDZyrxS5axigL3T6eLPmOI/qFQxJ8/OOX3n52kGoEUuuaz6wie+35j3EC87kFM2IrQJgwgtjf/ElxgzRsKDw25SMyiQhRZ+lxoHx0h9nUgGztrtn5k39XM+pdGVV/FC5M0wVQmaejXG2hlSPjeK3cbn/j2w7N+iuqSKYhtvIZW9BxgAeo0JV8NlN2867EL5kHaa3kVcavyC4ZjcnAdW3oKHWaKury+RRFKWXHRrXR/eSgOJFKU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:43:03.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4c74f9-2122-49ae-0b36-08d6359ee24d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None.

Changes for RFC-V3:
                -None.

Changes for RFC-V2:
                -Moved eemi_ops into a priv struct as suggested
                 by philipp.

 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zynqmp.c | 117 +++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4243c38228e2..eb315d14a520 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -24,4 +24,5 @@ obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_USB3) += reset-uniphier-usb3.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
+obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
 
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
new file mode 100644
index 000000000000..9528fa3894fc
--- /dev/null
+++ b/drivers/reset/reset-zynqmp.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
+#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
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
+	if (!err)
+		return -EINVAL;
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
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof(*priv), GFP_KERNEL);
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

