Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876D02087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tqu5iUkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfA2Uki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:40:38 -0500
Received: from mail-eopbgr760052.outbound.protection.outlook.com ([40.107.76.52]:24800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbfA2Ukh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOprgopWaThs2RZVQAxl3VL9bMTAW5QLsOWAa5YF6qc=;
 b=tqu5iUkLXYAI1IcAE2J6FUsgP/dXaTlWxWCFrVTX6uql3wRfu3MUsoldD+Vf5OrCmCJCIby8lEMNf0foxhW+X1lC+YUi7b80tQuwgheEfX3Y9jU0/MntE2jpJ417Qf2Ai6N695hT7/g071OsL3O9ZxSQf7Q8m8Q9Dkps7hhQA0Q=
Received: from MWHPR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:301:74::49) by BYAPR02MB5015.namprd02.prod.outlook.com
 (2603:10b6:a03:71::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Tue, 29 Jan
 2019 20:38:54 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0036.outlook.office365.com
 (2603:10b6:301:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.18 via Frontend
 Transport; Tue, 29 Jan 2019 20:38:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 20:38:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9l-0007ir-5w; Tue, 29 Jan 2019 12:38:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9g-0007aV-24; Tue, 29 Jan 2019 12:38:48 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TKcaDj023880;
        Tue, 29 Jan 2019 12:38:36 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1goa9U-0007YY-G6; Tue, 29 Jan 2019 12:38:36 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Tue, 29 Jan 2019 12:38:19 -0800
Message-ID: <1548794301-30483-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(110136005)(54906003)(50466002)(9786002)(14444005)(356004)(6666004)(36386004)(26005)(336012)(77096007)(186003)(51416003)(47776003)(48376002)(76176011)(7696005)(2201001)(426003)(106002)(72206003)(2906002)(81166006)(81156014)(39060400002)(8936002)(4326008)(478600001)(63266004)(36756003)(126002)(486006)(50226002)(16586007)(11346002)(476003)(305945005)(7416002)(44832011)(446003)(8676002)(106466001)(316002)(2616005)(107886003)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5015;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT053;1:POCAFKSG6rtF1FWIp+NTOASiJja8UpN4s9wSs+Sy7D0ApXaweFHQYd59oAXk0Rk8P2U1W4Hl7iWYbE5hVcpfE9g2rlKJM1Gdob9B2zTVylS9NGlBG1VVqZ24aootFmC4a/R8RMLMAfnJjykwdgCvLfws76AKPNYfE6Di1Oq5nOI=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1bb559-a50a-495c-43e1-08d68629c8bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB5015;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;3:xqulMMTqnNMFMki4o5EtrJPUX9ljzrrxX6eqzXMdjP23rDFlOkTFv9S4yicSImkS+LVr11CoOYSh4npNSydvOMH8c58Idnbw9oeguBQKorFWK1FROhKKHekI1fFnP0m77ngEPOV4QgmwCx24MCeaXtIeTEcsAosoUxxiftcwfJez0jCH4c16g09Qwb3wpR2TL/6ggGoBnGr08DuT88vpQ4Hoo7U8JXfZuC7s1jL+xWGPONP4I6dExRi7c5A+Cv3O37kpK6hTpFQ3m7AId2sKytisNY2zbktJ10XXCxJZH7DVDsWknrp2RFMRD1UcwnDxSqhxu0JOWAIoGYK69bnPt1cHmXi1pyHmUqO4kmlz5hPMedn7cgUMe5trfeCJbSRq;25:UWclD4c8eFVGiZWTTo78n+dcrNGbJkBXX0Q4syJL3KMI+j4DvUXeTSNfGr16XdeIQ2WfjWHjE721pcsUvslZ/WT9bt+d85PFFjGVPmyZpwtFqAu2eADPXxPVSY64LTc9FafI9S8dJwxYKtN8xJXjC4NmqGSvMQVTIrTs3Jy+yoICxiG+oWMdTze9TCS7ju7KZYWTf7rqP0/Uyt9GNsapcd4yrVG6Oaa5Xnz4/+LB+MQgVZ/IO3wZ3Nkp0sikYUt8hwiAyvoPOAtjolEzDRL7KjOMTvQJ6+SkwcEYpHw7EkJqkc/r47Dj1QSCTfF/px9RGb/qucpH1ruzsaONyBh2OQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5015:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;31:FIyUNL5eHqKqjLDVaavhk/QWxbCs8pvVhFv/Z0lhDimwOO406ra6FyVo4WdFxVY1760+ym0tMEsWk2bulKYDlpg/JNulK+LOWSP9zVSRil1Ax+7loThT2+Dhd1LbahgydIjBOW5Le+CFKk5aEA3HUvM7OAg94PZGvjQKfEIVJ+T78+uKeovCVDD0IFuFnoEv+SVLNoabPP6fKMtj0AabOA1R8RpMCv2aX24vTXRzEsM=;20:2rbvtEwNXvU3U+auaTm/a1RaMS73Vn4Nim8NayGrbiW8iXzqlpGxz51VCWBc96BMV/TRbGUv68tMAs/NKokO5hLityZvg3PjlGVqaEmywE7OXjVfbnrrB3Ls+lQkSeWTHgAuqOTTCjBFaVbEumz9gtZnY+cqtjp9Wrq6rO69iLbLLgNtL7WLQKe/whjGMyNXpmuGtoNsHVvXlF5vd66XR5LwZ1eWezMJ+O3dZCWiTqxGYuErNRbjBnz4KYqVKqK9gKEyP//0L1RptF9QHlykfnSjE8RUn3T+p9UjdU6nfUPtNGmr4xujZ+cvcM9FPQNFzOjXKnSyXPKSz1XrqefL5aYTSaYbcidYATXFEtEG2aGBIbIK4JFctW66KaRieGAgXuul/clrhb9tKTHSysGpLoT+BCj62jJ2QhJt0umh+BXJ8JnQ1CIKn89KsIszK1ISJa1Q2Hop2QeJHTAir6DOfOIApNNlix+qhBjGgEDGt7MmhBi2x93H4uPoXgG5c7u+
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5015A4896B4789ADDC52B629B8970@BYAPR02MB5015.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;4:71QEsivvk1w11vxpk2XKeQBl0xh0MXWHnh5FBP4mmt/+VFENH1ZDe4YqbEngOPrlYZrpybq+I6bKsXANWwdXJAaFTpDY+9Oh+D4WNQOS97Iu5C7Qbi0udaZnecKMLAUwdbEC1msy3oxJeA6pQ/iqvH5NmT5M5vxRTDL+S5a3yJv0lLGX5Yg4qDi4rv9yQDFk5I3SatJkhxBat72kFjVhNhJmU/zWk/0eWiPCglj65b2OAY9YlqGaswKWNf5/0D3JvcHQpnhZHD3FMIWtmMqdyUXoek/Ro+ChFqmQrXzm9EZf3ytlJdC58zzgTPah7AJr
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5015;23:sCjkHXAjrszm/JgxEAfSFNGaUKQbz1sDG0vaTp9p5?=
 =?us-ascii?Q?TL+JGV48KZI0dMQv8e+j9c7LS2g2oGFEh4gqKbnmzBu+zJpuK5yzkUXReT5v?=
 =?us-ascii?Q?QtNqtmKYbQbVPA7Jy5VxOVY/Q75mEKk0jxyRQFvVpQ/0BnRyyT8Qi8ygrzBC?=
 =?us-ascii?Q?2GcYryrPZaRHcm8DoQ1/MlBkDjrltJBaBLR2ri8c0t78MtQrMfZDTG6V9XWG?=
 =?us-ascii?Q?LWkJdEi5qorPZ5Uonteb+kiMwNW3GzdG4Zj3/km6xC9ZA++V986UnSzduN91?=
 =?us-ascii?Q?Pt176qGQ8N7AYJvB8qAogo5/BhPKY71OV2COvPo0yA0XJtFoc5puOHHNBAs4?=
 =?us-ascii?Q?/3qnljDhsVOyKtxbLUMcydfolHvs4/vNaWkvb8PApdHcBg1Mh85FeWFty5es?=
 =?us-ascii?Q?jOnKWc0v4fSyo+31gnC1iLG8mU7ePNaHwWeLwCdPDvpSb8PIUuCqsq9xJShR?=
 =?us-ascii?Q?qkoXLUoN8p0BzWWtUtEVBxxXGLhSfcDTnxH05TV2q9nwHtfj9CQStujVSmGZ?=
 =?us-ascii?Q?AJ4wtQ+Y7X7nriJlhhd/nErDX2G5WxgwpZUzDs+GdhTgo++vDEIBuhzLlUif?=
 =?us-ascii?Q?RKN11J10eb+/FKydiwrGsvOQv/GCmQwlTsyFZwuZGxsrTGzcW9lvHMd5H3El?=
 =?us-ascii?Q?9/aDaQSxZ2zX3zBd/ADIY36ITdaxyYIeXYrPvGGUKkRY+4028mlnwgUncb7M?=
 =?us-ascii?Q?xhP2gMA2zxKBI+Nzp859nO7An/Hv5tqpXqEDGbvE+kxIuIIIJy+mMCVPAIz+?=
 =?us-ascii?Q?eA8lkwVgBHh206NRDIUi9JmyXdh3QfDNB3amMGXLoVxYbUbhMXofUtibqJZV?=
 =?us-ascii?Q?E9qelfpR4y1b42jRDOV0pnYpJnLchfI+wOKXYZWbYDoe1RgYBmMo1vnxVyih?=
 =?us-ascii?Q?hDo3bXpVgZqJoH7utmCbyr7tZlcQH+pjm9Rr8mMr0JBqFnJD1ws8j9J/3EtV?=
 =?us-ascii?Q?hGbPsB7FVhJelWRXhXBteZauxxxeHZ3/cyB40eK3pfwH9DhbEz8uF01DmRmT?=
 =?us-ascii?Q?//YBPtFl2gfXPS9u1zVuXM8+zZ5N+ZQBhTktQNAqrVy5m7YVbKUr2HK86kUo?=
 =?us-ascii?Q?DgD5oLohigeeCVGLxCR8lPdUbn9ZZiaF6W91z1BQcq+NdJg7htVULZQjGGF5?=
 =?us-ascii?Q?vstJvvq5lKdt9y9U2yRIvZSDe7P6fCRzjNhPxWOqkxv8ekWVP0wLOxIghKzu?=
 =?us-ascii?Q?0uiY2dkCVua1gVN43vcsXVEinC27Q4VDt8DaXsAQqlo/h5NY8Xd+BIRNgDcS?=
 =?us-ascii?Q?KubUoVFHnxDBFElD0ScRwQOU87WjR/Ruivy8Sqp?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Lz9uBC17GnLo2+WJIwuyBSpCbFN+776JYKzos1ZZA//vAWnv+OvJalq+sAUb0VGBYLsTk36V9VffRdpBlzpc+zVY5B5ZiEsscyBqWMIsJh5yMDwaVApRzxJHyip1wr7roylBOQcizisqXzey1vAf6YbD9j4CSMnGH7ygZYLBJtkgX0oQs7YkzwRfRjSCDlY+NI5yxp+blNmJBJjf40IpD/69PWkLrGGAmPaJBOP2h6KUSKoHAUkiT8XdPq37bPrc5sXbpKMGfHIjQNjNgwL4k44sI2ov1bJ9ZBu5+P4MT+vfVpjJRSuJCHK4QlkhCR6Ils2P3IdzRWW3GiVYpO0l624CgwjMV8/yzeFlBsDiNAVrN0yY18aheqAivjAmuidbOXI334kEFhBmuv5jQdSqi9pkRgGoddzrPF2xqdWBGn0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;6:rgMjsvJB6osaP2MhHiLCGLrBtWl5m7oK7KPbDW+Q701/L/EJpMTr96TdKjmpaQLFPjhpjlFOP95Ya5duSX69to3iHJ+fH3Yj6y9fZ56UgV+axinof0jsTlqJC37iz+4ec2IoezZQrg5WEprdCVjfk9BCOGZntCP5HBhArq+RbCv7PfzikteaVxHNaEtFO2PzwalBkQkNuiDs5NxO23WMR+qAg21fknV24VPwjzmwUJ1msaMVAWxfqaPJcoAdoUPOfb294toIDYVOhcfLpoBjm0puAP6shJowAXXCu3knKLtdb6GDQCRJCarfTThALFmcbQQuWBjDPTgNqMt88NeMLU0VEhdo5PogdaE9Siefa+f4qz+emMMpMZ1eClDk6rA7PLD26Wu4mNFJWgSuvV+dSuAaQYMyx1HVfrz6Uemy7hNFwlUt6NgWVWQfVGZ2Wlq0eNrMTb+siNrun+j6BKrThw==;5:bLLx/goqcrM4QW7bM971L0psO2vgFGRlE24Cc5DufbuxTUdxeQzgyRRSEzuXtNEsuiZMvKRMPHTW2GDaXYR2crh+7zxTrvh+P0C75lnAik3iG6WXrAFs5XbeZgN8VKhKNPrWH2D1HTHZyc1b98c/Qtx8sI1RZnbKY5CaLANyP1EfOp4JMLAWdH0BrFg5GOm3Fz+uzz9rUIGbifCs1381sQ==;7:H0vZEW1aX/AQZTZR5r7ao02SlVEIoHVKL0S22FFHN00FyTWT4CGTS8WIMTX0oeyz1sWzvS9uDohomXImU683ga63MrfknVKNIB9JtzadDo04gLrVR/XcpBgkyYAGQbQwpNQkaPoQZgs+kMvWwBhrfg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 20:38:53.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1bb559-a50a-495c-43e1-08d68629c8bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..d366f1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,25 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.7.4

