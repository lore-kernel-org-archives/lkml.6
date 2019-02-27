Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E06E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PtNgERtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfB0Uvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:51:45 -0500
Received: from mail-eopbgr790071.outbound.protection.outlook.com ([40.107.79.71]:60032
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfB0Uvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6B4XBmAvzGNtVg1EtOboI7I+MWDbNRvMEphG1E90jI=;
 b=PtNgERtb2DUq6ZGs9d0lf+FHT+acBbtYq22U5j6kJtFBiZY15qmKDog0AXvj6G82hxQmNt9rErVyEk+VeEcgjMxRnMT8HwrKXWOwtV3kfWVXELWOkP0txAXMQQOp0AYH1pip0WK7bfM23i85R5XoFO+g4qnXvx2sYZLvojk07ds=
Received: from DM6PR02CA0008.namprd02.prod.outlook.com (2603:10b6:5:1c::21) by
 CY4PR02MB2261.namprd02.prod.outlook.com (2603:10b6:903:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 20:51:29 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM6PR02CA0008.outlook.office365.com
 (2603:10b6:5:1c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Wed, 27 Feb 2019 20:51:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 20:51:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gz6Aq-0007dR-O1; Wed, 27 Feb 2019 12:51:28 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gz6Al-0002WZ-K7; Wed, 27 Feb 2019 12:51:23 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1RKpKZS021083;
        Wed, 27 Feb 2019 12:51:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gz6Ai-0002Vn-3G; Wed, 27 Feb 2019 12:51:20 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 2/2] dt-bindings: xilinx: Separate clock binding from firmware doc
Date:   Wed, 27 Feb 2019 12:51:10 -0800
Message-ID: <1551300670-6949-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
References: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(426003)(36756003)(26005)(186003)(77096007)(50226002)(126002)(446003)(11346002)(2616005)(336012)(476003)(2351001)(5660300002)(63266004)(106466001)(9786002)(36386004)(305945005)(316002)(2906002)(8936002)(81156014)(72206003)(107886003)(14444005)(81166006)(4326008)(54906003)(106002)(6666004)(356004)(7696005)(51416003)(486006)(47776003)(16586007)(50466002)(48376002)(76176011)(8676002)(478600001)(44832011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2261;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e033fdc4-8a7f-4185-e086-08d69cf55904
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2261;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2261:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;20:H2n9sS9qkX6/sYXLgPzK18qlZeVSDzlp+1VIRdc0wS4Jop4ixQKNZyN00MpTPtfM0enfMS0W5RvwHhw3spXWHVibvs6o5+H3sOgww3I2thqFtBD5OObZCJembhCypb5CAHU4wEsUWpCkUA85tBACpt9yZsOOBD34siysaQjM6dMLVbohzoElG67tojNcecDzyyBLNw5Z4wglJFAvqteHTu4dJg92OciDgLQESBgZp7Nmy2SFi3X0AoagF8hosjkQCeYr0vEJ1wLwWq3NBDMVfLBxK4/6hYjz+SU6glhx8jg1c1FcvEsnp6lOLMyMLVT04qVxsJdmeOhuKi8ttcYjMb8XCsw4Q3x4NPxAxWAAZAY0moGDt7xhDCdK7daOT5+l7PM3PJ/uxI7UydjwRlUvvGaZbT5I6mhIUhc3NVVcZcUAbrORkk5mPi1UWXq2ajTpog+KjYS0l1z3HCngNQtZDKM3IvlqqEzZbXUEbt5xihp1ZJt8J8/vnpcHtbbHDEmf
X-Microsoft-Antispam-PRVS: <CY4PR02MB2261AE0C00EC0B884B76FA90B8740@CY4PR02MB2261.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2261;23:8hMEWafw7TyrJQyF43VCH7fNKlmkxApRn7SJRtShT?=
 =?us-ascii?Q?IiP8PJAVW1vEvyQ2JtqicsrR5N1JgDJU8PcFYBx1I56EyVPJOANLEa0T39Bf?=
 =?us-ascii?Q?m4Umaua9+FaOZ+scNsiAC96LxxmQfgj5CEApDxtTbRm6BskFxO8CPpPTpBIe?=
 =?us-ascii?Q?67SvPJ39OFnr6nn8z3cbvMbznV8OaTomlm6JI2nrFvt6tgQefeeJ3MrdBPe4?=
 =?us-ascii?Q?QidDFnvtGTi5ekkdvdoatSxx0yciZOBn2k4ggz7pqAQkLF67nAg5KsNntgNS?=
 =?us-ascii?Q?dtZdvo0YknqvTqfLTl3VnqvDlQEEIEA0S/4qKbFzIvMNctgx3t0LxPU9AbyZ?=
 =?us-ascii?Q?q1hXKpY0N5KoSP+0Rm0LhEhdoz4NeQZHhBEpy6/3IuxGQDWhBsd3QVEfBNi6?=
 =?us-ascii?Q?elio6d9N1N92qQh+yhK1sCjVOisfmAdupEWwIiQqbz7guMGpop4gE1NktoEK?=
 =?us-ascii?Q?5pO4E92bSeE3VL4AaiTemHJyAwa0YjTg5LuHX3rTcQ8aqO0EYhnKzK2lPbDq?=
 =?us-ascii?Q?nieBHpX1TmiEQxtAcIDyav0CRqFhAfI6gVsyvLKy/+8VtYB36FE3ftomZ6Yv?=
 =?us-ascii?Q?GcYVFkNlYLS42+5QjSmzJUGQ4PKAHv4+3UKHLdpBvQB9QeDnYO4hWlEwdgR3?=
 =?us-ascii?Q?ie7LLz+6RBUJg638dnYk7+ION4u169PzXrirTcgJ4mFUvhZG52OTYIVzh0Z4?=
 =?us-ascii?Q?xCXbd6n6hd6LoTGolGvEK/n+BXBK5sxSUlEtlf7u2aywdrw3Dgc/rUdoNlBi?=
 =?us-ascii?Q?5ZJIVdbzGqIXVRGl5cXO4Kg/s8tjdPgd+LfFBC0AEXLArFDdX8ZSQR1GR+Ic?=
 =?us-ascii?Q?ZxMHTeE8dvhi9xMrRUl3opP8jzT4ns5QZcs0/iOmu4RnVhoGk4ivHX81MTrS?=
 =?us-ascii?Q?JDWwNfZORs2mBwEvIDZrHLWtlh3QNHQwE7qMpvhNqbUXOyUaXUu2JdJqxbmu?=
 =?us-ascii?Q?7DpVTHvqDaE+jh8eWS/6UWiK0efOgC9rfbu/mbwezR0al6j16SD9D7atffq4?=
 =?us-ascii?Q?xadk0wGbAnNnHUdEGX6TnC/KsrgRq3i0FVuaAv/1PXcAWUI6cNsSHztacLRR?=
 =?us-ascii?Q?c7buQQ4zhp6mh13270ZrmGQl5uB9+aX3EWRnUMKPgnzAEiPRspIaZatybZG6?=
 =?us-ascii?Q?1OyxpjEbOFvjnMSuU/jWnWA497pDvig?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eFuQ+0ncctY+1TNJ+w6c3oXZjn8Xbh1Ec4XDAZXML2q6Y1fqHdR1J3lyMttw0T+eUIh+T/1hohOY9UH6geS1HR6kHxaOm6C5G8a+HNULDAF6+ieKLvKE67sKxWW4yf6GiDTDFzdJvBi/9622MfgdeJxOSaKpt0sU3yTJ3scCytFoaxibJmrWHCmNBD8CpYB7Vx++jJK7tpqqBXl6tnmIXePjxZwe9fOAo3IyQS2gSlFJkSQ1ff/lsvE4IDiksUO22W7bKcIX0dG8fFAeuzyE7o6Fum5ZXOP4+H67uBIukYninlCjKCC3+jMT2eByJrC8fak5XzmNC793HmqOp3kenQUQgXwoEWb7qHvXqOdQIXt8a/BDlzJvgQAzXs61Hs6cbcWPB0SHcglSrB/EALezAXzIH8n3/z6E3hAB5HrF4Kk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 20:51:29.1494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e033fdc4-8a7f-4185-e086-08d69cf55904
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Clock description is part of firmware doc. Move clock description
in separate doc.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  | 63 ++++++++++++++++++++++
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 54 +------------------
 2 files changed, 64 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
new file mode 100644
index 0000000..391ee1a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
@@ -0,0 +1,63 @@
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx-zynqmp-clk.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+		zynqmp_clk: clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 45d259c..a4fe136 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,53 +17,6 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
---------------------------------------------------------------------------
-Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
-Zynq MPSoC firmware interface
---------------------------------------------------------------------------
-The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
-tree. It reads required input clock frequencies from the devicetree and acts
-as clock provider for all clock consumers of PS clocks.
-
-See clock_bindings.txt for more information on the generic clock bindings.
-
-Required properties:
- - #clock-cells:	Must be 1
- - compatible:		Must contain:	"xlnx,zynqmp-clk"
- - clocks:		List of clock specifiers which are external input
-			clocks to the given clock controller. Please refer
-			the next section to find the input clocks for a
-			given controller.
- - clock-names:		List of clock names which are exteral input clocks
-			to the given clock controller. Please refer to the
-			clock bindings for more details.
-
-Input clocks for zynqmp Ultrascale+ clock controller:
-
-The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
-inputs. These required clock inputs are:
- - pss_ref_clk (PS reference clock)
- - video_clk (reference clock for video system )
- - pss_alt_ref_clk (alternative PS reference clock)
- - aux_ref_clk
- - gt_crx_ref_clk (transceiver reference clock)
-
-The following strings are optional parameters to the 'clock-names' property in
-order to provide an optional (E)MIO clock source:
- - swdt0_ext_clk
- - swdt1_ext_clk
- - gem0_emio_clk
- - gem1_emio_clk
- - gem2_emio_clk
- - gem3_emio_clk
- - mio_clk_XX		# with XX = 00..77
- - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
-
-
-Output clocks are registered based on clock information received
-from firmware. Output clocks indexes are mentioned in
-include/dt-bindings/clock/xlnx-zynqmp-clk.h.
-
 -------
 Example
 -------
@@ -72,11 +25,6 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
-		zynqmp_clk: clock-controller {
-			#clock-cells = <1>;
-			compatible = "xlnx,zynqmp-clk";
-			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
-			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
-		};
+		...
 	};
 };
-- 
2.7.4

