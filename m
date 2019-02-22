Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4210C2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NCsgcxLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfBVAhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:37:15 -0500
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:64528
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfBVAhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jbn21ZxW/q3mMQeu+YkhmUdbNz9M8L49v4c3Xx6HT8=;
 b=NCsgcxLcUku4tX8+TglX6yhpRmvoobkS4wIxw6BCy2yADlAvRofgzg/yi6jovHTVQSqLNSqqjlQN3RebIQjyil4zL6O6iJ++L/seLKENnhXcKhdbsDAy5tnCyF2a9AlPHrsUQSPX/DrCr2dKCtSu3dxw8GUuRWDqYOlB7Q4W51w=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by DM6PR02MB4378.namprd02.prod.outlook.com (2603:10b6:5:28::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14; Fri, 22 Feb
 2019 00:37:12 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.14 via Frontend
 Transport; Fri, 22 Feb 2019 00:37:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 22 Feb 2019 00:37:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56992 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gwypy-0003dF-D8; Thu, 21 Feb 2019 16:37:10 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gwypt-0007dx-8z; Thu, 21 Feb 2019 16:37:05 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1M0atN9007335;
        Thu, 21 Feb 2019 16:36:55 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1gwypi-0007cY-Vj; Thu, 21 Feb 2019 16:36:55 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v8 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Date:   Thu, 21 Feb 2019 16:36:34 -0800
Message-ID: <1550795794-27594-3-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550795794-27594-1-git-send-email-wendy.liang@xilinx.com>
References: <1550795794-27594-1-git-send-email-wendy.liang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(476003)(44832011)(11346002)(126002)(446003)(486006)(107886003)(4326008)(2616005)(106466001)(14444005)(63266004)(50466002)(478600001)(36756003)(305945005)(48376002)(2906002)(47776003)(15650500001)(51416003)(8936002)(76176011)(50226002)(7696005)(5660300002)(9786002)(110136005)(54906003)(81166006)(16586007)(106002)(316002)(8676002)(26005)(77096007)(356004)(6666004)(186003)(426003)(81156014)(36386004)(336012)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4378;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67e564e8-636c-4846-a7c5-08d6985de21d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4378;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4378:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4378;20:kBx5QTihra539v1/J7i6G/mHPsl+RS/1hcmfojPNxxLG12r/xAiXnE3c31Dr6pZkVcj4ldtn5T1w2G7+lLlSsdpGBnjibi5G5rsRbYNScIlNagv5sbdd8s5PycDEayCeHuAWTOKU3EIskvIvcYMCgJq+GIjiRvUo74HcYlr3VGnISVhdGKNBdUY16H3zPhohWWBLCtUSDCvK3vrYIUCEtRsZD3W6+4l+GaWpPlZuBiHw5QX4FH6uKiYuynavFnean4VTcVwm7GhnRYzZI2owssGBuOyzrDBwa5pKcUw/hSSf9U1vPLO6oZAlo2WsDKbjroxrOdYG2y6NC3Khf1MogDsGydywoGkhdWFu9QHC9N6JhGdJhsJwzrzU/oWCzC4Twpfw15nONmThavbI0wkfASTeYLkxN1swlxXqmvIubI5LujmHDyTCumKdN1zCPzPJRl86JOseeXti4fhUiBdngm9y8qhjzbSp1DD+Cyb891omcAC2SSjCMivrCXar2FEX
X-Microsoft-Antispam-PRVS: <DM6PR02MB4378D49673BB79A1349581C0B07F0@DM6PR02MB4378.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4378;23:SEPtrCQZP4XQoNRiOdc/+PGDr7kvY7OhdI9SGfwNd?=
 =?us-ascii?Q?krHDCZ3XsykznL6EpJCIboo/a90uP7l04lUYlxhBj7P9LEDdU9EJmB6qfFkm?=
 =?us-ascii?Q?1/1Fd9vpfQ9ERUF+ZUu3ulpDYqsP4Uqb+NzAo3FIoa+Z6sfNsgE8/yfIeFfV?=
 =?us-ascii?Q?u8pPqHvEne7JqU+Yhmqak276/tlOI14/x+q4LRSk9jg1LCRB59FkwIUNAFMj?=
 =?us-ascii?Q?UjEwlUE65cvZn4nQ3M6oSBuAF4HgwVohlu0Nwocb/KIMDAV4Pio3mdeDGEjK?=
 =?us-ascii?Q?b5WkAz5WLqgTBzlYT2j/qcgPMFxl+STUUiqIEoe7y0sQ1YA0KzdhI9akH3cE?=
 =?us-ascii?Q?mnveVoVVcMScSr/gwvGFmD0cXrPX6gI/yD17DzHlbiqTJPH7nJKBLv71FVvf?=
 =?us-ascii?Q?Qyd/bL6FD8wW9P5wXMC7x7Cyu5qBk0MnUiyJHsU9Rpxdu41nHMrYIF973FN6?=
 =?us-ascii?Q?6S+LQz5Ao7P1BxEtQnACGXfDTwExf5YK9xE7VD6mLdzsqK0BZXCp15ZFDnHB?=
 =?us-ascii?Q?HWsjXwVekFMz4pNx0eXF4/5PJtoNF58zfRRLn4NJfgL7Uy7VSQJOxJizy7JR?=
 =?us-ascii?Q?oSX/EluLlk7ZSO9lh+TcHgGf5kdwFdlYSlEf/NMIzPw8BlcnrdUn/QcThSRX?=
 =?us-ascii?Q?rL99TaJFbkpZMMtcRJ8oS85ysXGuIEZFzi57Q68+ZgcyvUJ5K9leEmRjd2iw?=
 =?us-ascii?Q?HhuWtdzZz099NR9ClXV+tGoaoVLMxWlxrxmpxqvPsEtnRgwkuA0a1muKlyoG?=
 =?us-ascii?Q?Cac9xI0zVZY5vjL5PG8GqgCTeD0IF3fVfyuN91bhLNmea0vABv3ajfVonDM5?=
 =?us-ascii?Q?Vw0Scs4RMVqMCiYC6ZZpIzhq0P1A0aZ0gZjL95Q9GMFiitJ9sqHI6u05T6rH?=
 =?us-ascii?Q?hFICiDYG5BwVY85nhwTFkG7RNEYIgrG2/37iP84fie2BWGGtDz6YDYQH2Nwi?=
 =?us-ascii?Q?1QsJ6+SVclD71r/bIGq7SZ9novsEeLLb8n9Kx005MZVuFI0D01OUqls2rjTO?=
 =?us-ascii?Q?eHT76c/DuHJRr5V5r0xvGmGKHVKtCx7JArHlq/TzbMsV1aPB4pPOpaLl1azx?=
 =?us-ascii?Q?DbnzOAbSn8wg6arDjWeatVSU//d8SCJWjXsrQoV8MNbr7Rq7n9Dk/xvLh5e6?=
 =?us-ascii?Q?Pd4GpSUk71DULzGrnOPlkWcxo/owzu+NVgj4TI7V74K+DOImkg5wLHD/oK26?=
 =?us-ascii?Q?DBbaVvbulpxCQ4=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: glIKYpymVRUiZcoE1px6zRpqkd4RHQ72uGOlVzATT6dYPkpPvL4kDYyN6jsD6FOsVbOM52BY7NF34uA2EbjEfD6K+GHjGSv+Z3ijI8mVphvW6LsATOsn8cwLsqW9yWmsqt/JpLG5GpDPh/61xqPKyK4UhyuMD5nyomXPlhDmM025ovpXaMS8BxvGJtSYjDPEeULiBU/R9AzyO/93s6wuFwZcG1AxPyt/nX30SuWsntVh3PWi72a8Z3T8Ahyy3qWd/NaK/SLNIwGdLFAX8o/e7f1Re+1xxXEgleDOssu8jqNpWxSquxn1CeE9UsCVVGxxU3hCiGLOt2XuW0nMCDbOE8A1txEBxxlABJjAXb2Viek3hfD84zeTboyRUwrtp6TDMb4U5KIVumvnleFyGlN8/V6Hd2h3TZNLlnO7MS2uvNs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 00:37:10.8685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e564e8-636c-4846-a7c5-08d6985de21d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
in ZynqMP SoC used for the communication between various processor
systems.

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
new file mode 100644
index 0000000..4438432
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -0,0 +1,127 @@
+Xilinx IPI Mailbox Controller
+========================================
+
+The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
+agent owns registers used for notification and buffers for message.
+
+               +-------------------------------------+
+               | Xilinx ZynqMP IPI Controller        |
+               +-------------------------------------+
+    +--------------------------------------------------+
+ATF                    |                     |
+                       |                     |
+                       |                     |
+    +--------------------------+             |
+                       |                     |
+                       |                     |
+    +--------------------------------------------------+
+            +------------------------------------------+
+            |  +----------------+   +----------------+ |
+Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
+            |  |  Registers     |   |                | |
+            |  |                |   |                | |
+            |  +----------------+   +----------------+ |
+            |                                          |
+            | Xilinx IPI Agent Block                   |
+            +------------------------------------------+
+
+
+Controller Device Node:
+===========================
+Required properties:
+--------------------
+IPI agent node:
+- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
+- interrupt-parent:	Phandle for the interrupt controller
+- interrupts:		Interrupt information corresponding to the
+			interrupt-names property.
+- xlnx,ipi-id:		local Xilinx IPI agent ID
+- #address-cells:	number of address cells of internal IPI mailbox nodes
+- #size-cells:		number of size cells of internal IPI mailbox nodes
+
+Internal IPI mailbox node:
+- reg:			IPI buffers address ranges
+- reg-names:		Names of the reg resources. It should have:
+			* local_request_region
+			  - IPI request msg buffer written by local and read
+			    by remote
+			* local_response_region
+			  - IPI response msg buffer written by local and read
+			    by remote
+			* remote_request_region
+			  - IPI request msg buffer written by remote and read
+			    by local
+			* remote_response_region
+			  - IPI response msg buffer written by remote and read
+			    by local
+- #mbox-cells:		Shall be 1. It contains:
+			* tx(0) or rx(1) channel
+- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
+			connected to.
+
+Optional properties:
+--------------------
+- method:              The method of accessing the IPI agent registers.
+                       Permitted values are: "smc" and "hvc". Default is
+                       "smc".
+
+Client Device Node:
+===========================
+Required properties:
+--------------------
+- mboxes:		Standard property to specify a mailbox
+			(See ./mailbox.txt)
+- mbox-names:		List of identifier  strings for each mailbox
+			channel.
+
+Example:
+===========================
+	zynqmp_ipi {
+		compatible = "xlnx,zynqmp-ipi-mailbox";
+		interrupt-parent = <&gic>;
+		interrupts = <0 29 4>;
+		xlnx,ipi-id = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* APU<->RPU0 IPI mailbox controller */
+		ipi_mailbox_rpu0: mailbox@ff90400 {
+			reg = <0xff990400 0x20>,
+			      <0xff990420 0x20>,
+			      <0xff990080 0x20>,
+			      <0xff9900a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <1>;
+		};
+		/* APU<->RPU1 IPI mailbox controller */
+		ipi_mailbox_rpu1: mailbox@ff990440 {
+			reg = <0xff990440 0x20>,
+			      <0xff990460 0x20>,
+			      <0xff990280 0x20>,
+			      <0xff9902a0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <2>;
+		};
+	};
+	rpu0 {
+		...
+		mboxes = <&ipi_mailbox_rpu0 0>,
+			 <&ipi_mailbox_rpu0 1>;
+		mbox-names = "tx", "rx";
+	};
+	rpu1 {
+		...
+		mboxes = <&ipi_mailbox_rpu1 0>,
+			 <&ipi_mailbox_rpu1 1>;
+		mbox-names = "tx", "rx";
+	};
-- 
2.7.4

