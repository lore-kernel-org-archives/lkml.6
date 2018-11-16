Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20AFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22AD20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="y2cB/+Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22AD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeKQKLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:11:46 -0500
Received: from mail-eopbgr780084.outbound.protection.outlook.com ([40.107.78.84]:58784
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729498AbeKQKLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D10SpXuCrd244PQu2GtbM67D5aeW6FPEPPd9M4qWmls=;
 b=y2cB/+LusS3Hxy1nkYV0AXtYEqqzu3lgXdpEsqimUJSEejO4Zy0Guc18Ivvn6bj28SoOfDw7VSUIdoSPcWO0iI2PwEiMz+s5OSdbqZ+DZo12ycfXwSTLVpxI2BtyPVORrbvkjo8AZcVhn0mEn7/qhjIq7b5GKpUrz/LA+tp6JEM=
Received: from BN7PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:20::24)
 by CY4PR0201MB3506.namprd02.prod.outlook.com (2603:10b6:910:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Fri, 16 Nov
 2018 23:57:15 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN7PR02CA0011.outlook.office365.com
 (2603:10b6:408:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.20 via Frontend
 Transport; Fri, 16 Nov 2018 23:57:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Fri, 16 Nov 2018 23:57:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:38907 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gNnz7-0000Tv-U1; Fri, 16 Nov 2018 15:57:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gNnz2-0006qO-QZ; Fri, 16 Nov 2018 15:57:08 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAGNv4SP015438;
        Fri, 16 Nov 2018 15:57:04 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gNnyy-0006pL-I7; Fri, 16 Nov 2018 15:57:04 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 0/9] dt-bindings: Firmware node binding for ZynqMP core
Date:   Fri, 16 Nov 2018 15:56:50 -0800
Message-ID: <1542412619-387-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(26005)(356004)(77096007)(186003)(48376002)(5660300001)(6666004)(426003)(305945005)(2906002)(4326008)(16586007)(51416003)(316002)(110136005)(9786002)(50226002)(8936002)(7696005)(106002)(81156014)(126002)(47776003)(81166006)(8676002)(107886003)(36386004)(476003)(2616005)(106466001)(50466002)(36756003)(575784001)(72206003)(44832011)(336012)(63266004)(486006)(54906003)(478600001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3506;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT059;1:whTVDeyR4cpv4S2k3eSKO+GL+a1XzqOR9FW1rsdHC1vuR1T6wLh7AiK3XkZQVje6L0YqCJckdiV2OLajqvUt5zY8UoZ5c8lhsg5G6N44yoxc6PsY/RhClpC+PWz/Hezn
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e338cfd9-87dd-491b-cf85-08d64c1f3b85
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;3:8SL+cr/6vO+1Chp2xlz895XXqaDr1g/dOYiFegoKnBeOxM2j+qBYey6yW3Azor5uQMGCYOBuBDR+LXCjiZiDm+iQIUb1ods49tyRJE4MUgDZQa9YObYnaPbi5axyQ4w10glKutxlp3YuIsDK303brBIs6+0/WvOTYtqZ3Pw/VMPfHy2w/wrnUighAeEnsHg1Dcawop88vHuan5Zg+F827D429viyUcDRf0J8o/X91pO/A4PC8XJ+7i36+X3b29ulF2GrgSYwW02uVZrMkClDs3K9EuS+nc9txXROl6SGud90yShYXiPUoEavHTg2+X5/jaQBjL8dJ9w2J3vR3tDAK4w0X95EaW16e9yUGoo0Kuo=;25:t4Y1IB3uUWw2sPqQMEBAyAW74EoXRS/5ZCl/qaq2mJdQjgdnLamscg0W9bY64sAjgpt8d43f5NwGEoOapzlwFuUEqcahPuNdrNyFheT0WPKAaW/W3Ud4MPqIlI8JqY4oHS7hr7HOVQfEo+m/FeoRop7yAL/H+RgJIcS9EViTqTyoueVISunsBpfP9QnFQpOR8MHKqwCFNISNj86jdPAzdNEbuVfl10RyEXz9tAQArNgPP6mWvQZS3OkwFYuav1QqqNAhgV0XUCDbJpNStJqmxiHVlxCEOltz6w5tGVN7fArYVfget6PFH/bXhnI4FQB3wSyZo7UBqfMmdgq0hcNyZg==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3506:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;31:jj6DoNBuWjLNzkDFp2Lwiov/mkrP+gHiTiHrn+IvbCXMeZ9pIemIxFuIsisKWBjF4Kt+HBfpTFe7Ef7/Eq1WXHdHu00/7k88E11lTKlesPplmBD7mcqM554baPDaohJOpFvjQr3F7SkczA0yb2rhdeTXQSWZv9VldA8xv4RxPnOMGMz3RfXuqi0VgufapiGgcy8LA06BR/FBsF4kTuKezRExOvx+6DUQV5Vgh+iculY=;20:UdVpNz49WwZziZBThxe+6f8eoO5QzU7NDSN80v6hPvj7qOCYZ8xmGdvltIzG2cp33mVgoRfBxrk6uR7SMw4CvWBsL7/pC34IYLitlPrzDzQC8qvqSLvWpA68IouD5+MrEdWsYPwr5QveGG8v1uEzxVuPX4A+lQ3qAI5gXfZXn7cQNYlvwdDwMvn+OMuZJ//r1anK+y4LtX+RGzF/A+VSL/F/H1bM6nrRwsfZB9/0DW4bSE9aG/5V5uVGb03G9dN2UAAaOkm0CgVvYbQUm2pZYBYSS4FkRZdr+N3maWDi9UpK6DkchsCYWbrZGsaIoOD+kjcpIfSuWBsyL4uAQMBY4sW9t4Mmjqs4yAipmOzH5o38Oh46Zf9RMasvIgjrFftXVZ9sqXr/fWD7Mhyu9SZJ8UfLmfI7be5faMqPgQZyDDjrrVNeWk2I1NC+TDIx7j132twl1u+5pDnpcneR9qcz9D03IfeOgsb6hRTvoUpAed1ghx49itX9E7LbnIPrvpxq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB350692B43791AE4E4E22A066B8DD0@CY4PR0201MB3506.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231415)(944501410)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3506;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;4:9jdPpT9sb0f8MLQBd/qajsL4NmkoFUk6rG7HB+ET001tJIXpEgWh02fXkypDHjEWrcXOUz6OFHrvSY+nkPfVIOyRx29LSmLk5xm+dPCC3IVZ7iT4lX+P8YI0GlfTEHYGqQ9g33765V5MNyZ5b+mRkIvbNP1ZiSEQ/339WZG1Pjiuo/Fch3gam9YcnOEEFzoahKKyXh3CmjrwSNbzy734kGKBQCini5U6upbIci18aOC21tK2hGU2MkxiVJ9sRFiEyEHdT5zO4ItNF9R/8QbLs3T7gMzngNCpG1Sq3QQilPHUQAdzuXeV86F3iR1Z9cXI
X-Forefront-PRVS: 0858FF8026
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3506;23:gPm4sJJOJo0LU088Qc846A2jkC/RuDwsxrhBBSk?=
 =?us-ascii?Q?6RrjSkblFfl/2COHc5ZbjWT69kHb9HVIk1VGCDlHpjk4Ov4rP72T0e385cCP?=
 =?us-ascii?Q?jVIYsUKOPJQH8D8D1kGD5Oau0Y6+e6XPDYeBjE0pSABDnCTkSiFYjEnPv8Bp?=
 =?us-ascii?Q?VMsik89GmLqB0VKcT7A07WXaZGi9gMGNrIcI+RQs74RiwOBDvLX7OHrOfx6F?=
 =?us-ascii?Q?7E8vQa33ULdwqohkxDxPD17DG1XLz231Oyqh2LTfdsXK1dTNX8ktcAQ1kIkX?=
 =?us-ascii?Q?XzX+nCmQDWvKR/Jrn3QIHcePtc83CIAmxS/LV6UKU4qspsBggU1qnmmUJk6N?=
 =?us-ascii?Q?DkHb88SihKlO3Agc0p6wOF8MT6Ze8YzibnRsG2ShidLKQJpTgN3p+OsE+vFG?=
 =?us-ascii?Q?rkoGot9bBnyliGUKj1qMUzbtDEP7jOtRJamothkEoxlm/uvTjFr79aIBvtEJ?=
 =?us-ascii?Q?lKwiGtoG+LObmeu5a0TRlFWvcEXxME2ABTGRivIn4M73bzagyHRx7sDHMZ92?=
 =?us-ascii?Q?nhbhIFIrjmmmqBBs0cpDFhFOq9qxy/q5+BzNoVzgm7zX66Eh0e2ln379D9/u?=
 =?us-ascii?Q?zzXi0+GcsTU9BzAy9RGv8uXk0kTygeTOE2ixyixNqzi7Kb727kEnqGMnjU/4?=
 =?us-ascii?Q?huO94Qq9Zba3qAR5PZmhGGZYIIDQ1wqv0jX21F6kPFOteAojBkf1lUEhHDLJ?=
 =?us-ascii?Q?yc/0w+p5TyBud0xwfikK5zwrvBHWLmONBGOR4ylxtIVSYvXPJkipNg5GxQXO?=
 =?us-ascii?Q?8u4e4ngqZKA6lZXrNy997CqxGJjm4nrogAMJuWnIz/SW0x+W6hKx5mUlfq5A?=
 =?us-ascii?Q?gPfSVAWMQNXQiJdleYBDCzBF9vii6zq2XvAMcevJE6mZTHlQWb+95zqxcYAT?=
 =?us-ascii?Q?eQ8UGbZSjajykslDgy4V+MEYKGLpk39AxqOR+kiUD217cpNeofQZGarmcHCf?=
 =?us-ascii?Q?Ef/DUz7X4g8vPVoYeUZZz0rD85rNeVX1JXy4FdeGKBL+StscY2k6ZsUJ2bJK?=
 =?us-ascii?Q?3OtHR3JH1A7xCysLHEQmatanJepLH5jtmEOH1owIb5NrIjqKqXcn5AnYwZDt?=
 =?us-ascii?Q?EQX1WMY8MO24ifwqq76GSMHSjvgrIhZA4fvYz/GUQjB7k5Xvj5UQwIS9t3vv?=
 =?us-ascii?Q?zM8GOOuWBlhCLxMIdwGgTA9+yjWh3Ol62?=
X-Microsoft-Antispam-Message-Info: YONv4KL9W+K8ppAxcxwCPgAs63RumFM/t33QTgogBsTjjppEwmuJtdxf6TiFIaKH9ZV5/LBAOeHrbFYQ+vjvec2dB54L1aYroI2FItE6q/4OKGpHSaICDaCUawne1S8fMtnwBk1UZfLXZSpiKTDdVUjZ0aRiY6j13moHuSreMy2JrzTXMrQFgPP0z+mwt705Iw3c4mDHFSuF91znHV/H9bF8X+Piz5QeYLHuHgr+lZ5S3Y7TjPgI285QOdEkZ8ScoLOoSkTWrqI5/V/n6rFdIO8A0Wrr62mf7ySrx67+U2OKI87X3y+j80PdUrbhzEUWNgG1d2SW85W81aZ8zs36i8pZ2TJ3pmhtvwq+sexbhqM=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;6:fPrhtpqfdWdjcYQIG+Pj+jYzlgp0jpwyM67g/zJWP6M/2rlcX7jMR2wYmxpvggWJssUN5j0TJdJBbAdsZskpklqA8fZ/lNXyfjAvOiS/3TfPiQ+KiI+a0o50vOoKu/qJGTP8pYJyIRA+Qtuge8pUDFcFd2QXHvOfLNWSWqQ+jrA0SMstsd4J4YlF8HSy0BbLD4+2qJeFlIwKjBi85WhEixopQdFqCMLAMBoSryx1BGCQzZRaMYgmP8pG0XJmhlrjQdNm2GJ6HdCdMb67401aoPm/Lzb2BMh4hk+eNo/YYAsnZNvkEadBgK9D2YAbtBEiai5iSQDRuEUApUUSvSzPzaLRgFOgAxNl+2z2afMpnrO21gRKasqEppPakHiUQvaf0YxgXxfl15BpT8Lf4HPDLF9mCl89LMK6h7zgBs1ovO1JN5oSlojBXRHgR8xh9JZPh2hZzIqDZ+fJ8bMfsOMO2w==;5:p6WraxJnTubAxB+mfW+J3gy+SDfgB615xqhGDaq2DZ3hlRf6e1BZ8Nvh+OsyzPPRSeUSnq+AvcjC5m6Sq7qnD675F8NxB6W8XCq0MlqTb74V0cXzcYd9e+12LAtRieX5oSaxe78zqoHFcMenYeT0xA91OH6Egg/W2ciKhfMtCHA=;7:rIL5/I9djWYaBw1IY+kgXnF/t8ReEIcRj4deyYxp85gozrJQpe8b5CsgRBIFtQp6GsYSHeSkSP8izldE/KYwAhV6Ddtois0vzNkvxX7xnIO/4feIy2pYyc/LLG/S6izt2qsLWsXkbyo1UcTXbkf1Ww==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2018 23:57:14.2857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e338cfd9-87dd-491b-cf85-08d64c1f3b85
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base firmware node and clock child node binding are part of mainline kernel. This patchset adds documentation to describe rest of the firmware child node bindings. 
Complete firmware DT node example is shown below for ease of understanding:

firmware {
	zynqmp_firmware: zynqmp-firmware {
		compatible = "xlnx,zynqmp-firmware";
		method = "smc";
		#power-domain-cells = <1>;
		#reset-cells = <1>;

		zynqmp_clk: clock-controller {
			#clock-cells = <1>;
			compatible = "xlnx,zynqmp-clk";
			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
		};

		zynqmp_power: zynqmp-power {
			compatible = "xlnx,zynqmp-power";
			interrupts = <0 35 4>;
		};

		nvmem_firmware {
			compatible = "xlnx,zynqmp-nvmem-fw";
			#address-cells = <1>;
			#size-cells = <1>;

			/* Data cells */
			soc_revision: soc_revision {
				reg = <0x0 0x4>;
			};
		};

		afi0: afi0 {
			compatible = "xlnx,afi-fpga";
			config-afi = <0 2>, <1 1>, <2 1>;
		};

		qspi: spi@ff0f0000 {
			compatible = "xlnx,zynqmp-qspi-1.0";
			clock-names = "ref_clk", "pclk";
			clocks = <&misc_clk &misc_clk>;
			interrupts = <0 15 4>;
			interrupt-parent = <&gic>;
			num-cs = <1>;
			reg = <0x0 0xff0f0000 0x1000>,<0x0 0xc0000000 0x8000000>;
		};

		serdes: zynqmp_phy@fd400000 {
			compatible = "xlnx,zynqmp-psgtr";
			status = "okay";
			reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>,
				<0x0 0xff5e0000 0x0 0x1000>;
			reg-names = "serdes", "siou", "lpd";

			lane0: lane@0 {
				#phy-cells = <4>;
			};
			lane1: lane@1 {
				#phy-cells = <4>;
			};
			lane2: lane@2 {
				#phy-cells = <4>;
			};
			lane3: lane@3 {
				#phy-cells = <4>;
			};
		};

		pinctrl_uart1_default: uart1-default {
			mux {
				groups = "uart0_4_grp";
				function = "uart0";
			};

			conf {
				groups = "uart0_4_grp";
				slew-rate = <SLEW_RATE_SLOW>;
				io-standard = <IO_STANDARD_LVCMOS18>;
			};

			conf-rx {
				pins = "MIO18";
				bias-high-impedance;
			};

			conf-tx {
				pins = "MIO19";
				bias-disable;
				schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
			};
		};
		zynqmp-r5-remoteproc@0 {
			compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
			reg = <0x0 0xFFE00000 0x0 0x10000>,
				<0x0 0xFFE20000 0x0 0x10000>,
				<0x0 0xff340000 0x0 0x100>;
			reg-names = "tcm_a", "tcm_b", "ipi";
			dma-ranges;
			core_conf = "split0";
			memory-region = <&rproc_0_fw_reserved>,
					<&rproc_0_dma_reserved>;
			tcm-pnode-id = <0xf>, <0x10>;
			rpu-pnode-id = <0x7>;
			interrupt-parent = <&gic>;
			interrupts = <0 29 4>;
		};
	};
};

Jolly Shah (2):
  dt-bindings: phy: Add dt bindings for ZynqMP PHY
  dt-bindings: fpga: Add binding doc for the afi config driver

Nava kishore Manne (2):
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver

Rajan Vaja (4):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings
  dt-bindings: spi: zynqmp: Move SPI node under zynqmp firmware

Wendy Liang (1):
  dt-bindings: remoteproc: Add Xilinx R5 rproc binding

 .../devicetree/bindings/fpga/xlnx,afi-fpga.txt     |  67 +++++
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           |  44 ++++
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 126 ++++++++++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt       | 272 +++++++++++++++++++++
 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 +++
 .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       |  81 ++++++
 .../bindings/reset/xlnx,zynqmp-reset.txt           | 148 +++++++++++
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    |  22 +-
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 +++
 10 files changed, 850 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

-- 
2.7.4

