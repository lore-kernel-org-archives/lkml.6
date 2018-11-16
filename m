Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17110C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB42206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CanvlUXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB42206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeKQKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:12:23 -0500
Received: from mail-eopbgr790077.outbound.protection.outlook.com ([40.107.79.77]:55972
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729542AbeKQKLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWIe28t4UqxAqmCBN+3Hywqc8/gYiUFgmpPlM1DahGk=;
 b=CanvlUXJ3Tdona9XxCl+cse2aRKOJmqJnwVuEj0ff++mH1q+vcPOkvyzXHg58Ij7O4ObhlyNKvXU+wnclgLuvccnjq2hoq8sX5MI9gWeM08lr4y53zeNKreKe/h+qfSVy6vGxcvMkCpHgFZHUSJLmA4/OqHx/W+EP0VZ3MKYwR0=
Received: from BL0PR02CA0107.namprd02.prod.outlook.com (2603:10b6:208:51::48)
 by DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Fri, 16 Nov
 2018 23:57:15 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0107.outlook.office365.com
 (2603:10b6:208:51::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Fri, 16 Nov 2018 23:57:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Fri, 16 Nov 2018 23:57:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gNnz7-0007TS-KL; Fri, 16 Nov 2018 15:57:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gNnz2-0006qO-H1; Fri, 16 Nov 2018 15:57:08 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAGNv5eW015450;
        Fri, 16 Nov 2018 15:57:05 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gNnyz-0006pL-1G; Fri, 16 Nov 2018 15:57:05 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wendy Liang <wendy.liang@xilinx.com>,
        Wendy Liang <jliang@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 8/9] dt-bindings: remoteproc: Add Xilinx R5 rproc binding
Date:   Fri, 16 Nov 2018 15:56:58 -0800
Message-ID: <1542412619-387-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542412619-387-1-git-send-email-jollys@xilinx.com>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(36756003)(76176011)(7696005)(4326008)(50466002)(51416003)(106466001)(8936002)(305945005)(50226002)(48376002)(81166006)(8676002)(5660300001)(81156014)(2906002)(9786002)(446003)(478600001)(26005)(63266004)(14444005)(36386004)(107886003)(11346002)(2616005)(126002)(6666004)(336012)(486006)(72206003)(77096007)(476003)(356004)(186003)(426003)(110136005)(54906003)(106002)(316002)(47776003)(44832011)(16586007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT025;1:n2TJXgsyHvNwGDyBmj7FvgawgDfi9tpBA2AwCmEGaSnPU25Kq5RF+bUxjMbQBRd1EAcXvVq30DWVHjGPE+ee1qoQnjobFbmUpYhT3nZtBi4wFXYIM9lGfAnqDaFAJnhi
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dac611d-da4e-46c4-97a8-08d64c1f3b65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:1conKjmla+owO5OCYunXrpnXO4hRAHSgUGCc+Xlt13zA/d2ew9cFnohgwQqtY/s5oiw7KLnNseR2Ao7Gnqm1SHVCWKvNwx1LMQn5xV+6SW7l7lAiSetOM1BBlw/Xf0IAxJ7J16h6fxonB1wrvY9z421Ay+qPna+IKVmBOZJFLD9D8oPlMXFNOzzqXxhZoyZZe4oge7CImKCoqpQhGXmF3UXFL4wK8KKZaeEpo2/ZvD43NYMKjCRyGmthzCL2s1IpnRlWFU4Z/+kcgTi70L0IIkrbX8hNEM9wUNRcIq12sRzmVBzIoDjYj4MthJbABUkSVkBh+u7EZxWcjNg7tRzvkns1XoF1zK9BkK2d+qstPZw=;25:cnCjhjwax5O6275rqng3xEWk+fTaTOP5VR1wjU8ynL9pLAre4PWlMQA2bt80DMr5Lc54iWlKdzHHzbP3tbNjJp+vEhIa0zMiZdptMOe5tfYP/QkN3TcFwpjiQRTPIkY4Y9jwFTAcoweTxDUE5eCoUtBHnblNBjMVrBzG2pDzT4YHNDbS38vQ4o/c8Cua6LOz335fH61ZWnCeTIXQUKyD8CWMQ2W6pkqySytvkVfdIed3lYs9iEA52faUrmBBa9kH7oQ6KvqN4l+cEQb16FBmnfWAsvmB5AJgIsjB+zvn5s4K4VHDfp7KwrCmcAaH5/2cfTayp953mcvQ6ezASvDED/1yzq94rvUbyP7jeQwMtRQ=
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:DB4Jf+/g9ZRH9oiFDIVIjgO0qOYq/4WzBKNUSXZ0rSX3BBWZETcN4jffYem5XTaqd4XDL1C5c4qDkqsjUxJ/oCbusmqBOgQ2LcpONcCNe4ORJ3WL15boOapfh5/Suaq8xddRWM/dN//u0/ZUThuil5hbtdrA8GVNTBSMNPDqszgvVc8BdPv9qXY7IZoB37O3XZBhLDafGJHhUpImf41ASC7rHgCIZ7smtZ08c3vg+Y4=;20:brauqR26v1hwJpePuRWxLbLhVdFMOBSGIFWYM3+3CjbWACT4EXfOU+hn4U/dR1SmXbbl8NAl6q2QCD93FZG3VN0KZ1edrNyzgECZHK74KEnpPjavL+KtF1vDNEXWoypKTbVparzfQRp691iVU5bAOad1XzWc3fGMN/mrjo9f7H9H9e9bHmSlkW/4XyGWF+cqg419WqWwCHtN4liOBF09E+XnIxOZBrADgS2drDiXr2eZm5SHa8dyBrPvgW9IBNdtp3G0AaADKWadkegxKpdDDJB8YGwAuStqHXFGad5Vce749Nhci8C123F4M4/UdyMIdHRj3eSA9+zZPSdGksMyiwINgeE8XzKX5ES4hLtEAFdQufz9OFhr5mApt1Ls9XpBQ9V/dwh3HDklaQYHr19P1FV0O0oCrPF4+nk5hhxBIvC95fZ0O2/cyqHBR5xNsuAUtmTWY0g8q8q2Y7CXqkOP6ujjYedfDburxAp2tnzHHhQEsW5beHwpdmePOwwDy2jR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330B7E1A9CB075E8849735EB8DD0@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4330;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:N89yCE3OLZ/PQCcHDIoLem5F1n5YeKG7sSsPWC2xo7I1LVxiwFcVQ8TS1sVCZyCQxbDhkhAGVOQoZFuRDv9nB+hVVw8I8i9u8vSvnn55LPbIWMxHPorQTKp8bmFwTsmHe/G3rKJzIQE1hT0XN7jWQnCnxDTw0D3Px6MV9RtJahH5ubdm4bZKXjGp3gZZlyhTsV8lT1ZXCHdiU3qBcLnFizgf88kaxOlTQf3kC6OLwpaaLr7pv5s9apHZPI9XLP0Yfv1NhFwU4H3IloJW+XAEvudtUs4FUkYv+EOwX3mMHUMCSYXUoU76Z5E5me7ecHbe
X-Forefront-PRVS: 0858FF8026
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:+BxWkj8ZdApTwRhE2z6km2FQbGJB06re4YzgsK8Fs?=
 =?us-ascii?Q?M+H49vGeaHOjedQXyx+zt/NxIbDGJnHuNVAR3+YdN5RiSmFcvbEbHYqIOIYH?=
 =?us-ascii?Q?H6kDX2YO3gFjkOLni8Qv2W1sBoVETmWAyQrNcOpt3P4iQDRNGCWpVGy2njix?=
 =?us-ascii?Q?ntlOolQaKoD/uXV8XyokB9gjzZW95VrdYYxrz5HVY37iV701OVzYjmidI8a8?=
 =?us-ascii?Q?Rl0Fgay+La25peDImp4aig8L9JL3qEJVuoXSV1ttPNNr1uFTJWjONmijepDy?=
 =?us-ascii?Q?9zxJAktz+HPcEq2ssk9NIqnsDU5/VqTikQrQHNzguBdw2p04/9QvlSvMyq+r?=
 =?us-ascii?Q?6XrdiH4Lt9JtRh0gCwmAJgU2KdJJiEgkQpUpZU1ROzuunDwiaI7wPkXRFNxU?=
 =?us-ascii?Q?Z7J+sxvEyovjhKKqRrN97xbyxeaD3BQpXO1fC2Oeum06NFjHMrtivZrNB1zD?=
 =?us-ascii?Q?UPz4ZTKGvwKqnX/nG9oWcBp9ibZ1KUvXs2OkNaiyagF/ih4yB32wybeg0h9r?=
 =?us-ascii?Q?JUfFC5Fjzi2RF1KnTI8DCo8MLb9jUf1xL4m3Bp/0P1twu6Nd2bAIW7TgMh75?=
 =?us-ascii?Q?TWEBHTnn+1HAQcldQDbaO0HG+uBWxc2HK89im87Tdcuzh6B8frwt0YKTRcWC?=
 =?us-ascii?Q?8Fto6DRJuSIuUJKO5wKv4eOAIpBJKrrDDQgYi8hETI0yry/buhg1+5LKYzWi?=
 =?us-ascii?Q?Tu1Lhjj1b/QMAq4VvIBnAcHmuDG3geiCk6ExwUaIN0BViJslQJq6Tok60fBZ?=
 =?us-ascii?Q?gnE7qdVCplbKLH3bvh5jLnu+WKWbBx40lDly08iHEwCxZ3uXkgTfF5GCrQOz?=
 =?us-ascii?Q?NctYpVBTNWhoyD2ycvfBVHjX3lSrCSv3gwcO7mgI/Q2ORwR+Dl7X654W6wU2?=
 =?us-ascii?Q?+Wc1NaU4g39tAZYtNYb7kzLCsXfjC6qTQvlXFh+3vv9r9FYfozFQyoQo+BRM?=
 =?us-ascii?Q?wEYeoJy3btfmFztMeyKN97nIUa0kcnwoqtaN/Dv2XLmSLOm6nZRFZAKBBpHL?=
 =?us-ascii?Q?LYEA71snHcBx2ViUTEglnKT0Z+P/HVLksbSD1+l3NBNBvoQ0NDvE7vRsmvVo?=
 =?us-ascii?Q?2gG6jJ8MUYBgH5DgQbKKy5hLwzNMSf8CRuokvtBXfFD+1DEAlxsYva8S/6Mf?=
 =?us-ascii?Q?RCZTi+Iz6eGoRDSrtNsmEnbyje9KHoGXrqZAeELogYk6bUfwxoF9w=3D=3D?=
X-Microsoft-Antispam-Message-Info: k9Yx2rScH6mlGNl10M7krUF87jES6H3EKA2VeU3DpRN8QmsUrFtZqY0kDaMVi4TshhpOp4dNEOQWyHlNWpN21DVOBqOebmO113pS3hnx5izf2XjpMjFvi1ZV7Ce1/fNd6YnZFYUaMv+NNkdDuy0nBv68hDFNXcGa30s3cccxEYW9cluKCaMNsA2B/afkCPrfE54Ecps2bKNTS/LA6XespZuYU06oertjjVNEOzFAyJ9V88J63t+Qn4VW0GzcjETTdkUIcnxKWazWYYQExXKou5q39f4sCVMJv9vSVVH4CgcnReF8gAoQ8lrLxXzl0E2k9is0rmd/6bSZH4byNqGbGkAbYk5aZyDO0vbo6lMiqXc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:SWu2SNspTokFXdhoNymSLO6YZ6eVepQ8a8g+P995Vmn9AQeCMVzbjXmv4vRiajX5+g5jMSH5hl5maJrIxFRPY4zIpXfehD1bM4NV42DXcupgMWEkA1nSWfHwsbsAH8hzYAAJ99os3fphJOOv09A2ZARU7sXLrPGKEipfivHiPkl0sRE1Sh76cgiw3m6Hx6Ry6jbC75GR3m/HjFS8X3HafuC4hMRu25Eub/fqpVMqac9ILd3nl/68IazzeOAMwtXP6go/yWR+choqBTN5EiXxDivymOhffXYbsb4fFZuHIIPFt8fBc9Tv57lDRvE7yuLqT231CVkjfSgODbgl/FRqeqz3n9ZjsppoS/sT4QK/hjsO//mEIs2LFpbYYbsdliRwc0x5Eoj+JxTh2oXwIeVg9gBHc7b+fW1VVDRPkq3uojqcxfaeIjy/NYZvpVmAQWQ7ZTcGl99DHW0ST5w5As5naA==;5:WIVVE+clMs0wMlJ7rNeqbTXKv6J9Nf5sqtgAyfZNGSozfd2iFjTVWGPrUz4WQdvzs03FyFw+v4QwubvNc5PySDW5RWP9fvI1OZ+Yq2fDbXfnM450czV1ZM8ZaW8DLHdfZ1nlbXbWBN/U12lwbeZK4dxzare5zXA9kYJNFELNSn8=;7:Jcg76IXX7ba/E2jV0jg2gfkaQUGQA6Lg0t+8Uc1Eonvl+bizXoyEDTStQVQO121aQ45pbKOeyjiNZrro9QEOkQYsPfiYvJnqBETTR7Uk3deTKgncd8IlC2SVo1sibBf+Tm5WTbWLnXHfRk11w/ONjw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2018 23:57:14.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dac611d-da4e-46c4-97a8-08d64c1f3b65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wendy Liang <wendy.liang@xilinx.com>

Add device tree binding for Xilinx Cortex-r5 remoteproc.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
new file mode 100644
index 0000000..4831350
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
@@ -0,0 +1,81 @@
+Xilinx ARM Cortex A53-R5 remoteproc driver
+==========================================
+
+ZynqMP family of devices use two Cortex R5 processors to help with various
+low power / real time tasks.
+
+This driver requires specific ZynqMP hardware design.
+
+ZynqMP R5 RemoteProc Device Node:
+=================================
+A zynqmp_r5_remoteproc device node is used to represent a R5 IP instance
+within ZynqMP SoC.
+
+Required properties:
+--------------------
+ - compatible : Should be "xlnx,zynqmp-r5-remoteproc-1.0"
+ - reg : Address and length of the register set for the device. It
+        contains in the same order as described reg-names
+ - reg-names: Contain the register set names.
+              "tcm_a" and "tcm_b" for TCM memories.
+              If the user uses the remoteproc driver with the RPMsg kernel
+              driver,"ipi" for the IPI register used to communicate with RPU
+              is also required.
+              Otherwise, if user only uses the remoteproc driver to boot RPU
+              firmware, "ipi" is not required.
+ - tcm-pnode-id: TCM resources power nodes IDs which are used to request TCM
+                 resources for the remoteproc driver to access.
+ - rpu-pnode-id : RPU power node id which is used by the remoteproc driver
+                  to start RPU or shut it down.
+
+Optional properties:
+--------------------
+ - core_conf : R5 core configuration (valid string - split0 or split1 or
+               lock-step), default is lock-step.
+ - memory-region: memories regions for RPU executable and DMA memory.
+ - interrupts : Interrupt mapping for remoteproc IPI. It is required if the
+                user uses the remoteproc driver with the RPMsg kernel driver.
+ - interrupt-parent : Phandle for the interrupt controller. It is required if
+                      the user uses the remoteproc driver with the RPMsg kernel
+                      kernel driver.
+
+Example:
+--------
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		rproc_0_fw_reserved: rproc@3ed000000 {
+			compatible = "rproc-prog-memory";
+			no-map;
+			reg = <0x0 0x3ed00000 0x0 0x40000>;
+		};
+		rproc_0_dma_reserved: rproc@3ed400000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0x0 0x3ed40000 0x0 0x80000>;
+		};
+	};
+
+	firmware {
+		zynqmp_firmware: zynqmp-firmware {
+			compatible = "xlnx,zynqmp-firmware";
+			method = "smc";
+
+			zynqmp-r5-remoteproc@0 {
+				compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
+				reg = <0x0 0xFFE00000 0x0 0x10000>,
+					<0x0 0xFFE20000 0x0 0x10000>,
+					<0x0 0xff340000 0x0 0x100>;
+				reg-names = "tcm_a", "tcm_b", "ipi";
+				dma-ranges;
+				core_conf = "split0";
+				memory-region = <&rproc_0_fw_reserved>,
+						<&rproc_0_dma_reserved>;
+				tcm-pnode-id = <0xf>, <0x10>;
+				rpu-pnode-id = <0x7>;
+				interrupt-parent = <&gic>;
+				interrupts = <0 29 4>;
+			} ;
+		};
+	};
-- 
2.7.4

