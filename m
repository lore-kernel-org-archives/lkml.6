Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2529C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A48420861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sIqedUtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfATR0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:17 -0500
Received: from mail-eopbgr710075.outbound.protection.outlook.com ([40.107.71.75]:63810
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbfATR0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GEZFY9FBwFtJvdNCp7bJwkJNb3GByq64+HpZTjvTmo=;
 b=sIqedUtm+fzWeCn9tOl0skf4qtrblwa60xlIpXZa69HMDF+6qPpGl9XqTgdd94teR0RGDqGkw/YJpyWbbwYXbTNBCvy4ZYnnFmcwj6MKAbTRhBRNaw+/2sZRotpS8w2PTYN+4KWELUcrupNba6a/sl21rNxFL0vbTIPT0AO68+M=
Received: from MWHPR0201CA0069.namprd02.prod.outlook.com
 (2603:10b6:301:73::46) by DM6PR02MB4457.namprd02.prod.outlook.com
 (2603:10b6:5:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27; Sun, 20 Jan
 2019 17:26:12 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0069.outlook.office365.com
 (2603:10b6:301:73::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:26:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:26:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGrK-0005Vg-SV; Sun, 20 Jan 2019 09:26:10 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGrF-0000wL-OU; Sun, 20 Jan 2019 09:26:05 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPuwO019870;
        Sun, 20 Jan 2019 09:25:56 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGr5-0000sm-MA; Sun, 20 Jan 2019 09:25:56 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Mon, 21 Jan 2019 22:54:27 +0530
Message-ID: <20190121172427.20446-7-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121172427.20446-1-nava.manne@xilinx.com>
References: <20190121172427.20446-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39830400003)(376002)(2980300002)(199004)(189003)(2906002)(486006)(508600001)(7696005)(106466001)(1076003)(47776003)(51416003)(426003)(336012)(2616005)(11346002)(446003)(476003)(356004)(126002)(6666004)(76176011)(186003)(77096007)(26005)(50466002)(2201001)(48376002)(9786002)(106002)(36386004)(4326008)(107886003)(8936002)(16586007)(39060400002)(8676002)(63266004)(36756003)(305945005)(81166006)(110136005)(81156014)(50226002)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT033;1:jyY67xD67Um7LgGecezt0P8cU7r3Qhv40/jQOdBqMjZ/uRUbBGLZiHUtINMquT92dGbteP8zboiEIqzfHMrNHMe0FA1pZn5tQSH1MjiLCG7ZMCD9e4MA+dN+v7Bh1AjwSlTFc98d83DFDB74SRQOLYD1UCg+YVGb4EYhm866ZLk=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 930639a6-7816-428c-adf8-08d67efc5f46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:YBeyACXm50SN/nMhNu73Tigxjnhh03W5q1SycAgc/BSivL8WOUnBCKsdXRDnxLJN/lqAVUfgttzymCCVYbXaUKE/XEfQ8HpCzVtg56sZvtabjgldQaRW4mtQ86F5tG0HCskhYxWJ9rcSvMedovRtfg7p5p0b7Oud0VpbDHZmObFRjXsne9NfiS++PG4xyKAEXZKFNHfYvRD+SqS6uS32HiV27ZKe6BAHumMtgH3gN3EUqBWEsWPm5QV9uGARjU0ELurlmrFTUcVTDwXmGPvYCBzVtgeOe7R2PRCjlpUkC6u9hfVy0VdAQD2qZomamYWHVCK5wJUGkatMexJlU+JiBFc3pZ1nyef3IuO88aMV4gQB0P81JTsF+3B6PkaP04V1;25:fIzTZeahEoypzM3+2wYpN/Ulh5/LZ35C6h17JyJW5Xp8duiMUjOZiKGR8SYbHahd4FHSjOXn8m/Cs8rnJTItZrmivMtQWMS9CP3AVbAaUSbo0K2ywqOMejhcscH/JXgiJTP0sT4boLOH39s2NPOPfP7As+TBuM6Prd+IGigQrWqgGBrqslKXArRuAfI7t4SolmDlNW4Hdxn69uWKpDGqu7lBSOrCUX5oL3CxzJ/zYwi5TxRrVwgM/y5/pE3bjp5mnkcFDHSXf0Xw/EzEp9aDrjUQQ4Q3gDuQZ/F82f/wsYtJVSBedgHrz0sYrEgT7FUE5PKRiMqo9yxZA3uzf7JiFQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:QYSCx1awYoFynJcoD3ZcxCtFbk8S0JubeF8qLeU4YLsWRwVYFB32U1CsPeIpef/jf5H3igCaSW/mr0ti0tn2tg8GYHLQuQZAiI5ruyVtajXn2T/v4qeanyJcMh/lBYP4C136tMjcevEblRdAlp6QlB3iEjcAqiM1HL4W1sLfsVO1nuihc/xEVIj+BUoSUsKA96j6dSp8gCs838zeiQ1CLVbWeWtRk1aLniiOrxyvaWQ=;20:x/JYi8yjHSo9CAhTZ6wzUP175djSZ1NwEOPUvD9v3JT5OiAQNBwviOrwYJadN1VpNEv5yParhV+YHGSyixMxSqr6t9Y53N7e0NBCXxkNKwoZub/UnzZ+IvXcOlgWL3A5+QojTx4tf6+vwLUOHa0me/K/esanzctw7A5N+nDCTvYvC+FelbiIjQ/ETZsAukEmXHB4MrHUIaEgYXaGAEjXBtSo1L3swAdpLPHcJrS/DQsKJMEf4PftWd2JFbhMfRb0SXpY02gpVezJM+cR1zD4jQOVgGDyHIwlFbUMrEp0lwJYOUzBsoq/TX4rX4BjmBT3zmmWp4E7x8usNfYIMTUCOI/R4VahLY/WJHFqWaUZK5vtPfyYbdfiJEDN08+elsMQ0Aotq5dWmrnnE2g3JEgJgpB+iF+PmYzZSzi1Zzj6F2Q2ujD+EhANPoec6MuWk9je4bxf1fnfUxcnMPRdvgZCeUGpVapUeure/8afffQsEWg0jChcQlRBjd+ivFkfTqpb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457F0F565E351B3D6A39104C29E0@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:GRqVIqWklis3y+os1QWq7AW/Zhad+18Xill8+Pvxn+Rcyc05FFcz6x+ijDqDU1vNw0tJYScfu7tY3dYDgrD9xFZWQjPU4X0qyXgPxpOwN1Chv65DCqVE0T6GRy98X0YvYIFV4D+M5WcIGQtjnQbOtkffP6nFI8v4/f8I+6xBHQnV7F/1IuDfNGqVBhxWy5NfkQrPgcIOzMZuiXmHrQOlTwT06hPTrWoXmaNw9hz5+kokrZjlS8SbgPDiwgVvDY6vcfg8Gr0NIDpKk4qsvzNSCB7Mk431kZMv2FfNXPmPy6zV4puf+cCrcGxLDKP+hDG4
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:9z3VzqrP2mAr2j/6SsLPiW0F125vtDMDgJcdxdgTg?=
 =?us-ascii?Q?a309r51Lcmgkg1swb2cXQKyaLkYH8J5GI7mPLBiO0Bad3OExmfhkar1KIFHu?=
 =?us-ascii?Q?pt5Wp3dsSxfaSEbCd374H3fAtsyrzeZFJ1RZdxWEbOvArT5LjSrKxUFeedpi?=
 =?us-ascii?Q?/XYOlDyC5EFMFEO9JOjxCOkoKtM94nbpRY0RMgWRW2kz4REsMJnlSmX9+0Wl?=
 =?us-ascii?Q?MRruZ+YpeqNhQvfawwzgPwN/UvInG1U1dGLrqbxXuGXi2T+s2YkmfT4nVQdY?=
 =?us-ascii?Q?3/s22l3iQLfa9xhGKMfonsz2JB3grMlFtzNwVwZxi2Yxp001vPkxfAuCzFtG?=
 =?us-ascii?Q?j7ziX4lIDIhppDFSlCyl2UofYxzzKhmyPXiKOCE5eDezjhPOz7ngdQx4Eo/M?=
 =?us-ascii?Q?k7M/vR9TP9+xCifRTasxpRzg/RLFCGCBGdJhaYBSLW8VMHMCEno9myfJrsXv?=
 =?us-ascii?Q?1INJFAxpUt4XnKSLujMjVeb80QHTfWHKqQud85yyd2vFtmUfo6PCPcxASc9a?=
 =?us-ascii?Q?yYfYakrZ4DEM/Kpv7a8aKQJ02Ev9dH58FyhvrmvHw1Hwz/m34/kudFXbVohD?=
 =?us-ascii?Q?MrXsAOekExcoKKLck7fE2GGb0uaIckQxQQ/qqPgIqi5TME3VDpvzhYLGCC36?=
 =?us-ascii?Q?M39GLZdSBLvhjwiGkJ8LK/aiXMTFqyopuEyOllyrXr+9RGIABO0OlCdZd+Tv?=
 =?us-ascii?Q?N4jNGhsXfRKCuPZl3XWnZSboae7ANK8IbRbfH88lvfbEzMVslwH62+a4ck8N?=
 =?us-ascii?Q?4Wmw7az07a7m8Ezjj0yHtkdgF+lHT0W3qGe6cczp1oFRP+aqqa/BUam3W4MP?=
 =?us-ascii?Q?SuzDdlVhyj8pBnR56nCDUIJ8jRAD+jUnqyqEVe4bq7lKa68YjAbHEVxAEqdL?=
 =?us-ascii?Q?PsIAIw/yhqIzohDAYwXo/9KznBKM5OWy0FpQlONugXdiO24k1yj4OT/2Q7VB?=
 =?us-ascii?Q?ZT3dHQXQ/6ASGnPeYtQRc8nRVmzBH6TH0qnYjbvG0+5mJoB51O8Q1usUT2L7?=
 =?us-ascii?Q?ohmQnMoLbTU6eIeGsb7YYAGaWDMrWn5L0T444cy0383QI281Ejxxznlzh6up?=
 =?us-ascii?Q?6xlVfAnXBzx+0vwuVN8aRirCeAo0vCN6nzynwLwvnC72KuXMg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qlM4ZfDFnKoF2RKpAC5obBVDM5dk4oJveeDdF5TiwKMfgEVoUdoPVlFONKK0S8owTQMsditJ1VVCt4h2OX0twTq+Yi6RVvhyItEA/l6N4CLATiOU5QkzviTGN42+2t0uS21zBS6yL+ddQzm4Ijqqur/GSk6/Muxvgtwayn+ElMTkdKit45WGS5Yc30Ml63xdT/0aJX/01qex/+gawFzzyt85oo4KD7hrcfMYFvdL/z4cDNHUcC9Dr5Kq3PDypN1f5TmU0X2CDTovep042qEc3ukmBqW0vSKvSr4Xhu/RDCxkAcr7ONdsxx/0PHjoDYo6wIX7mOKg8ywBj3rJSavy2n0lvksW7iWDmmcoyvqOfWREfi6oKr7AWUmIbHqs8HwX3YhcofPpiKSnOdDaBZYKEgJrtJsWgS5EOEgn46uVtoo=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:m9K79MHEVb9jPESmhOcwb4xIsYSC5MXq0FlirCikeQQMe5bsviym3B08hKODKcA5oJ5TS4Zl7OWKfj1dMTB0mCx8XtuEF81TYVO3tShlONN69BC9vmWfFIbus1nZZgVKZgtW4SHjqO9F7MdFd3YJ8s1ERD95Fxy3miSbl67yOdwMysjdz5D7/uGE6syWXCSpVU4yttC4JievTl1Mwyp1EoWh7ekc+2WvkQ5YdqWtUh15NzDfTi5ZoUxXQmw8yP189uiftZ7IvtCWiUHMZZ5CLxTfdr8/w/mMR+MyWjsBiedvxtVJidXMoIzv9QKYE7TFiZGBBRgxGbCV8BMMfXs3G3sne8Ap4PwWJdXROqqfm+SJ7nrXHjau4gmE82YYaGZ/EBoXMtqzHgnexKnGGpVIWIoDSxPAm0lz4kv9+xqjI7nw9yM+4ZfOmUpv74B7VE7qgAMgipA+okCl5yypG546nw==;5:B8DuSX3UYE85+G2uivmfQw6dTVBqQ0nRSrhL72L6aZOllvLAzAzHd0fB2cwWHu17xJV0kVF5J/1cTqani2704yFTgkaklgooE8X2cxK+qraAYsNkzcPIaaQsxlF90mMkOaqY/a5b19GiGUPSbyQMVRNJpByjeVwT0bKRTgTYJBChlyWH/aAvHsFpqSTydFazbrv/pp5ox/G4FxO/gMcorA==;7:vsHFhXVsXZSuiduSTt1HcBGBVQuMQTX40K2+pSQ0LVRTGoThtkPkkCgNZhbGCCGAFQc1QBPPC83wSK/UJZF1AVIPOJP0Lage5aeZIf1HHwkqrIB3HqzuKWelKYhCqoX93aU/kj5/UDpsqwKj0LLueg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:26:11.2485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930639a6-7816-428c-adf8-08d67efc5f46
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Removed PCAP as a child node to the FW and Created
		an independent node since PCAP driver is a consumer
		not a provider. 

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..1f6f58872311
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,13 @@
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	zynqmp_pcap: pcap {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0

