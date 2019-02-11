Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F83C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CBC214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zj19dB4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBJQRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:17:19 -0500
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:57472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBJQRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 11:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW3nt2JoQaKPtC+jjbWrq+UN7wJIT57RzjBTI76RnW4=;
 b=zj19dB4aQqs1OE2eLeMQbCNsg2DzD8TmKT9tMZf4ajVZoKSctWfTyh52kGqRO0WjPaG6g4dqpin+AV5CP3thBE4XSw85mDRWYNRQcmGdTZHNBs3qnnORM6CDFEKiKpIUfBt6WE7andMWNPuJSPnBrWNLLlMOuwXv8cJoFt5htvo=
Received: from SN4PR0201CA0067.namprd02.prod.outlook.com
 (2603:10b6:803:20::29) by BY2PR02MB2149.namprd02.prod.outlook.com
 (2a01:111:e400:c506::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Sun, 10 Feb
 2019 16:17:08 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN4PR0201CA0067.outlook.office365.com
 (2603:10b6:803:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Sun, 10 Feb 2019 16:17:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 10 Feb 2019 16:17:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrn0-0003e7-KT; Sun, 10 Feb 2019 08:17:06 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrmv-0002YB-Ez; Sun, 10 Feb 2019 08:17:01 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1AGGuuw020385;
        Sun, 10 Feb 2019 08:16:56 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrmq-0002Xc-48; Sun, 10 Feb 2019 08:16:56 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 1/3] firmware: xilinx: Add fpga API's
Date:   Mon, 11 Feb 2019 21:47:18 +0530
Message-ID: <20190211161718.23785-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(2980300002)(199004)(189003)(426003)(48376002)(50466002)(1076003)(336012)(2906002)(486006)(9786002)(106466001)(36756003)(51416003)(7696005)(47776003)(63266004)(478600001)(126002)(476003)(2616005)(6666004)(356004)(26005)(36386004)(2201001)(305945005)(6346003)(77096007)(106002)(14444005)(16586007)(50226002)(110136005)(186003)(8936002)(316002)(81166006)(8676002)(81156014)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2149;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT022;1:caInfAQn9dQVEhGULOkR1KPv3+QS4c56/ueZn/X1ENkNHdKSR7Sd2lEuDbkPec5/yAzD2RBkK6ep72y6NavKwepRJmwEWpY6nCro940pe30gwk8Votnlc7DFtfcNxc6JVfF8nBUt8Qa9aFsEWQmD6ZTz7oWON1HeAsw/oDZimro=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 439b993f-4824-4c1f-06e5-08d68f7333f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;3:p1koeNF8+FDP+7cxF9mhE0U0Xib3OrbmPxC/A6f8ge6J9a1yJBD5Fhj4cA0pR0aBrG3JObXNKx2ZnEdqUnPXRrcNmbhR/Ne/9DMgXuAozg0V7DUN4yyENxJlImEigHo+0wtzHGCo5cOuiQDk0Xbg5fND4H/fR6VAWrt7/OPpCebLZeYOlznzJjP6N59azZULxD4zRI9Laa45n3mC94KDHEPExLg6f3gfS2DoTzU5WN8QKrmq2xYSFgvzfz+NEisBJ2AW15LiHQR+DIj94UqI+3LS72nYn1GjLQOll2/qMFgPJWGbUN4//KJEkWTkqC3MhIyPT0jJq99R6b47/PXr+SSZK/PjgS1vi9LdF/6ollymZlN94jhddJbi+LqB/dog;25:TYx37A3+Z+oFEMSzRix1MUysUEZF+xB++9J/oOA6vL5lIo17cGgRJ/85E26GVvOb+QwtXI217/IbFP1F5sAciqRl/Dtr4dRogLANyjQxzXMO1waQ5O5ZFi5MLfyci/Qhnuq5LEkxXdD9OL3Typ+CvQfmOV82Clzog9UOS8zu5z6lt+xFj35pCtWtIwTNowVV4y2MPyc5BHslxR/YswlJen+fL/XBC12CgduBC5Bd2RUjbnaa9X3rkhiavg1xCyIVoG3MGKKtiYtDWwM7GI0JEtp9sl839CCn7hV47FmnaAzygnNGJgYm5VcrMgQ4YHCziDnPlvaU/x8YJO5u9izLIw==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2149:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;31:58H3p8fRM39op1IIDqEkTj5y4YDSmQpib8Aip3ZM9EigENE/GPDDNb59VdIi2nTASrSMG0D47awaZAXYIVjR04LZwbOto9WVMGhhjRjG8zfIZdXjlk5LIiRCets7CmBAvPA8S0LllVebv25MYx0BE5cQkuGxPX7qrWV6+1lenlvWe6sMSOioBdTELuq7yVmkV42O3pLODvAPXT5JRx5+l6zLbTvBEHNFeG3TUMEJgi4=;20:6eqTR6hNnnB4UpZ2vjLdwitLD0OTcKBULTxsfiviFXIKW9LgU1DB0Wi5kmdbYq8L8XYDbJN4a40UqtQGf7mTc8L9ZrjJrM8iRXXOrmN54nf38d+iJKMLac4O+MLF6d+aKLeG+5yO2lAgjLD+FtN2HACqdbkvs/4VNuW59Dp1iz7aWiZUIogYJ+dBnCaGRTm1r1VnXv7mv8VJ4gbUMJuxrVBYPDpijtyzZwX/HnbzqF8eDzwjVwlEcsyzABCE8lOCDysJFvMLSexLnfmYAyPVX5SsCadMNXcp09orPkomZ041SbyBacHyZsmssgQipMIZ8hqiEsNVIConOVMj3xdTp46rBiXSwdeZDn26/7RDehORVmpTaQ410rIa4f43y31c1teeJlyOtsBUTRsQnskcGJM9lDj/YvhUQE0F2ddYe/Gy1jtnerAvYz1dFSmqqC1J/sQWkdhzUsXtcHPneRsWXaCbCF7oLZ+JbLNiP47GMg1I68+sqfCmYBxFyhbmKzfW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB2149BDD7264BDA2170597414C26B0@BY2PR02MB2149.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;4:wRXTf2//Wgjeu/fa2hXqidnPjW9bK5nnfXGY3flzzCH6DP04xj4atqAUyUBVWog1uVJSU91Zno8xLII1JeRcbcy+GRluB5UjN0KenW7TqdxscYzFItTPYXnj3XWWsy7fxrYoU6pyQGbfWX000Yg6GvTruX2XEdR2d1I3CEnM2HCPV1mkOKUum4aLnU74LJbE0QnVFKxWWZ/FAU6TAQXOFjjQVcnucgGunqW7PcPL0gyTE/9ufiE0Ma6aZ6DeT2dhKoiZl9R7EEZ8hJVHZPpyaNTr8H0m8xpnFJITFY6bWqQ=
X-Forefront-PRVS: 09443CAA7E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2149;23:DnnHF8f6SUrrHNYa3YvUbpm/SrgFRY/2YebT5WKtG?=
 =?us-ascii?Q?j05024nVQPWMbv7n/rTom8nKMCr4X0wyfrRUaRRgQF1mtY6/FLjQrByVvliH?=
 =?us-ascii?Q?CvfLaXeVx0eOSMJEBCW5m81dGBllPh563wY0tnIDzm1u81yHOmoZpFLfMDsc?=
 =?us-ascii?Q?L1EZXM0xPxaCmwPdALJdbdeIslnpMlxbKnT3VTOvqx8fWOFZQbc7zuM/fbCB?=
 =?us-ascii?Q?PSoua7d0/FDOf6NeGr00OK1PBaudquH8Ulop38SQ47fccvB7KRYXlrN8s7MU?=
 =?us-ascii?Q?88sF4GIHLE8BPhaUEyN5V6yCGLMyugPQsDOLPbJRRKCPqyM1FOp0YEWxTHFr?=
 =?us-ascii?Q?Hsw2eLay2uon5O0XdTk+3D1rRmg9aVFjVxv5bZaDOarCYHpigvdvka99Zx8m?=
 =?us-ascii?Q?XfBEDjC9H2A5OUiOp9XsSbmMCDnBRuVjPTnvACO2GM8OhD0NYwLt6o79ChFi?=
 =?us-ascii?Q?EZ9NVzkOQg8c88blmkEkvUNRSq4EuQjPNpg7CaIbaUOq12czZSOI4ZjZMjf/?=
 =?us-ascii?Q?Xwomoydkjk4IvlO9yfL+gLwFHKy5XqoTck0mKVndQgdmXckJxvNuMlTBH1ut?=
 =?us-ascii?Q?vSxzC4mHF0FP8rN7+o2CXfcA6N4J/784aifTzbNpF6woRX7aOZyPlwSgEqXq?=
 =?us-ascii?Q?CE/7gS3G8ymd7Yj5JjbQJbZ+ivlz5FeVCVKpZ3iUSDejxuceyfNC1n7fG7iV?=
 =?us-ascii?Q?eIzhT1C8bSztXdsxNZ7hYEosn//i/ObVhwonwjyh3egY4lBRaY6gi1IN+d+c?=
 =?us-ascii?Q?N1b2MC3EtWxuo1fAbzqH8HlXTYd8xEQcsLZAhbayrIyNHngI3QptP4T4H4F4?=
 =?us-ascii?Q?5Kr7+wQ/UnzmDtsZ9h7aX5deHqqjXAuNCSRwP3FDAAhXYnhh00lw8/bkew0E?=
 =?us-ascii?Q?TKSP8hIFMnJf9trR5eInw+XlZh9CpUV8byghbiIBhLzBjaSA+sgcuC5OTieK?=
 =?us-ascii?Q?TnkGSgM+bFNoKateaocaNVzhA8dyfVEZa8h2/IWiQtJMwxlS5ipMOLx5fjEl?=
 =?us-ascii?Q?eqEkiJvxd1pmIVXjQGCLI04/V1afMdkAbrPcIbnxpgvX+Qcqyao+O8fWd4Uu?=
 =?us-ascii?Q?MYViuVaPVgSDXtCUKl/jiZNkMdi0IH+aKf5zMjMay1S9pxEyw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ubP1F8XXnKinTuWrhUNuQS/UcIwc0l4urkpBgFJF4v0C0ytioBBKq1ilGSPM1hxNbDEP3TMl9oGgg4DVAX8KXJJdQdkpby1tLgLlfudM4u5Y7FDLDUeDfbu8zo+7x0txDbVm8RfWXoARzmUixBLjhsrOrrUMd+PfTH2AoTsgRP5wsZzhlbD95jeagFA0x1R4oC7ML5mN24RB0zg3MzespOWqy4YT37LVl4XJjL7WXqcDrZdQ9G+9xFQ3twysmlUz2BqF5Ang0W1Jc1K3Lsw0k9Pq3gN2SDfk6QhLtVaWreYW+ySqwjEYSTapSAmgmWrkBctOcbqDDlsXRvRvhGVxc1y2XfN4GQQJEVRCA7GvZobYTOw6R0fdGJ+szAse9/XWRzx5LjDhnycDywB2gnw2RP2IOYEbwF0It6MSfFbx/9c=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;6:VE/5pCcP+T8i0e9xTQ6D7iEadcDf3zMkjLQ9AJ0UM79Yq5Qwzet1PK51hXtGZ5L+3TNCFLTslZwR+t79HH/XAHXQndaLy2sgbBqqXtZQHXTxTiM/6U40YU0YdIrUuK6LxZmB2Ll3csv5LWrt+mpR3rwg1uhsbcZ3OZ7/m+we/cXmIZ+h4Soh3trZLJglSIOuVCGIVw3uZSVCirJcgwvyidhb6UE3n6zz/oB6Kebs+YCwJon+rOON43OD2TGbzgL+lCcSySAMKXsBv3Kwspgv7SV9E1wxQj6bjbYy6zeaH9WTqeLRD6ozMmeKQcr+40qbMj0gNWwRyrKJJ22yTsNfnhJobuTMjTeOqYmTSEFAdqnw/rWYEkfCV8S/Xx0LGolj02eTbVFxoStGGBY0VWpA6OylNYkK+LUgwgoBLsoRviOYfp/y7gf2sQ+qOvC3XMstFRx5llbD5g/OKt6T0sIoKA==;5:dcsEJY4lbCQVnFJtnBTPlPREPScKdVwU4Q7JFb87CzMC+OeJ9/QGRPgvBr6DqWpPUdBZzxxfIEMqmQEIesJxn+ijjQwhvhMBPDFpvcX6zBqQZAWoHixDwLtYHgs/mnhF9u70XeeUnoojH/2yZZ4fiC0cLsPkmEaQdA/INbRo59ZYTtnNh8tw43QmV8snK1wlet4Ldr7PaaNup3eqLB2iCA==;7:/Kp9GQ8REqsoM7kZLuVBjAInrYTt7QFboWheYjZuVf/ihGTLV5iXIwTnEKDIelHqV/T29DzIvO1L/JGx//vGHoyQZMBFBba9aj4iyxY/TJAoIAkTxe7HyotOqtaBByFik+Mu1bnqCg7/GCXqflET1A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2019 16:17:07.1062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b993f-4824-4c1f-06e5-08d68f7333f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Chnages for v3:
		-Created patches on top of 5.0-rc5.
		 No functional changes.
Changes for v2:
                -Added Firmware FPGA Manager flags As suggested by
                 Moritz.
Changes for v1:
                -None.

Changes for RFC-V2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a..366441a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,50 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/*
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bitstream.
+ *		 1 - Partial Bitstream.
+ *
+ * This function provides access to pmufw. To transfer
+ * the required bitstream into PL.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value: Value to read
+ *
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -482,6 +526,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.ioctl = zynqmp_pm_ioctl,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28e..16d4042 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,8 +32,18 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/*
+ * Firmware FPGA Manager flags
+ * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ */
+#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+
+
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -91,6 +101,8 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.7.4

