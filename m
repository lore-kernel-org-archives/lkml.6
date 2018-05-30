Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeE3U4d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:56:33 -0400
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:50263
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932290AbeE3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:08 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 03/10] firmware: xilinx: Add zynqmp IOCTL API for device control
Date: Wed, 30 May 2018 13:55:18 -0700
Message-ID: <1527713725-1086-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39830400003)(39380400002)(2980300002)(438002)(189003)(199004)(81156014)(47776003)(9786002)(5660300001)(39060400002)(26005)(77096007)(186003)(36386004)(51416003)(6666003)(2201001)(2906002)(76176011)(478600001)(316002)(110136005)(54906003)(16586007)(106466001)(63266004)(7696005)(44832011)(36756003)(4326008)(72206003)(356003)(8936002)(50226002)(7416002)(305945005)(426003)(8676002)(107886003)(50466002)(476003)(11346002)(106002)(486006)(2616005)(48376002)(446003)(81166006)(336012)(126002)(107986001)(921003)(217873001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2205;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT034;1:BUFKNeOb5/I1Uo6ljLJM62CFfPBukW8BjyIKuB1/kjZIYdWbH8DrL95swJYSVrNew4jek8jIPPHGbn6DQGKwSlPSofffpTW7YdDFEfoz24afbGnZT0aiwuf7h7/J9MpI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR02MB2205;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2205;3:XqktU9CfchBd1KjaNxAguSo83AzNO8Kt+O03K8amacTbAKEhSc7IAv0fhsXAtMRikbaQZtzQCJqaFY/eudfhW49l2k8TKDZrOJTf2aP6AB6jBnDkkv7WoDlO+RqSkRNOerMCziEYML3F0lCDUpoPWe9t0Di+T9FZpCwfjXddljN06P+kYjB1IBKVsLWs5NMK5v1AFbXZjMs71fHVDBeeU9fPvWPG6sHMX4KWUlLoz6mvdnEDahAhhsAIctkzkuXs/XoILdwZ95EjCv2o8p5eWdFPucBat78l+osYlFEbwdj+oOSd4uDjcaWypIbAbpK+caJN1KzrF+VaJRx756Zis7IDo5DqFWX4p4+Xq8Ci+vA=;25:6d+PKAMe+5R13UfdMlBeV9DC+EqhSkT7+FTEiL8PozJwKEYmkv6I6hbsy2mHa7hWmjQGtBvHh0Z5WQOStORh4b0IKdlgh6QZFyOastHFd+PlBPVdAaDxC3zgH3pHsWzpCG17tMD/XB6czmlPOGp8luFeyqIbeLntaY6ctQkNdyD9aIQAgPJgWgYZJB73DLA/AEf+kQ+ybS+DeDQEGcUdx63disOGBOa5FXzBDbZIw4WDbtSDgZqFnY3ZTnFMKFDCy4sEzfj4T01Ig4xj4kgru06harDhMWSi8sJmmwDMSHiuykPeQS4p8Kw/COYdBPKeS1/tnbhkG3KjlS7mDj299g==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2205:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2205;31:YBhsIviPQAPK79ey6+/NeyOqG8qHVdAzYDkWwi9uw4Dnu0mRZspt3adPjb6C8OBXoBIbJ/QEafCd1kbnviC170y4MMztFumZye/INg0l0pQPao2PV8ArCWXB21w9Q7ArFVPfVTHNH8aV0H9twv+qcH0eyZgTK0g2neX0mVg1ff7/9UD1MoVIRr+j5HTk6C6Txz8OOsHMlFOT88yCSj+6bntmOWW6P0dEPnQ8vo5ycMA=;20:HOru5Q98roXrr0kRlumaVTFPSCbCw4gi0QTkMwXuGygHbfyFMngckmv36ELkt/DygMtND7CHTev/CJ5/z/NtCSCIz+wa2Pe1cKC+ebSF+BWO44Z0Rew5h5ojH2EKXQkea343vOauN7MBGH7MksRViSEJztQ0e9GOeU5dI/Gr8RShd/yB1woM8GaFcdjPKngqWHCzIkYl4vBE5RCh/YJvVSeKqbd/Aym0iwvZl543JyuBQOLwm/wCDkfZfaUuoVq3IqFyZ09KSpz+3sio1FYBaudpqz2RN79QnEAftNeXXU7pAHozPl8p44BodVCQpxplXT12fmTB9v8/DErQ+GEb7VsNXa1EEJrHumu7+ihGMu211oO2DR7MLXtW2RXrO0YJQEku6Vk1wx2xlIGt1DUyUmE8STbiotmFIdQmZIDx3o7onAX1XHMZQiKzOLq+H8eKq3/LO+3pOOeeX1Ekb8UEGBrANg9YYcfJLq35WGU99XV90FbWyU9RUjukJahiGpuY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2205E8FB1DE3F69C011E2D1FB86C0@MWHPR02MB2205.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2205;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2205;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2205;4:bBKLs0Dbwr06WBXlExjUQzkSwRV6vP+JzThIfJapCDx7Dw2CMdm9hN4S84CpQ6CpjQCzYjHf23LGGp4ZERzvPouaTUhYgLLitVojMfh9aUPqTsh7lXMv2jkgIfdanIsEWhmEqKVTA3LsJd/KidHKUGTUK3+5tkRG+UBtpA+ezYwRCRa/sugCQhqpw0xOhYfQQZ3UnCbeveC4qN7AQjeOG1Cnb57F1Xq1h3Sv7vB8HvnD2unw5ES3bWy3Wf4M0tsTQSyx9DFHF0uySnup9vxES6QTPyVh+gHkTBj/FgIDLXTXvgNDDOGBgU2Dah5oS60x
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2205;23:OH7aQRlbfuJvYwwsiAmhxoapPguspnI05Ki03sBLA?=
 =?us-ascii?Q?gmZxk1xkokl41mjFEsHZcpkJgr+yI15AhyF6M2J4hU2hV9UXQcwUcPqnaxnu?=
 =?us-ascii?Q?UWF5+FmEXwI21+6n2rrX/vxZ7FTYaVxs5OQwi0357hUg7tnB4p9n1ipLrZld?=
 =?us-ascii?Q?IWHkMZvoW9WlToRORI/yzZG6UkVfYNygCBhhrSmqqN2zzibh/M0jJdfaGF9B?=
 =?us-ascii?Q?9nqhHyCwJ6m5L/M8tHdA3MDVFCblWlr5I96KzbYEuSQ6W8VlxG41xJW3Vyh8?=
 =?us-ascii?Q?1PFyR3qztpjI+Y3odQefeRElMIVfLoB0bwyBBf/HHicdKbwbauYnppwIBeDg?=
 =?us-ascii?Q?DOfN2g66O8zvyF14d5l7Kuubb705E58E1YegM3bg184xLCtRWeZSasvSZ806?=
 =?us-ascii?Q?cafkc6L20gmci2bhkoWw5iSGL5u34mCYvUECQhSe3rSqLwiNrU2zi40qhs8s?=
 =?us-ascii?Q?sho47epMqiroNXrTGA2wm0oqpT7ofQGtguOxubvMIMwOkyBNLjwFizzswkSu?=
 =?us-ascii?Q?gprQoPFVgivb/yxiWWQ509NpD4Z5/2HpZCH8VIpWeuwu9Tioa1WIvuMykmtD?=
 =?us-ascii?Q?D9c4dMQSNKIA3tg8peTHj0rGBOtuP78e4LgDFbm6txOZrpYwhH0w6YuqPatD?=
 =?us-ascii?Q?ZcysqhmBOTNlMaltfGqRTYIOFJFyHJbMR4Y4vVv/9i/DvZpDZFk5UPUb1Tq0?=
 =?us-ascii?Q?5a+zrM11AUTM4h6HLKpUXdnwlv8hLDonCBmFMRGRDKxiT+I2TtY0LyKRzVZy?=
 =?us-ascii?Q?j3eKDePTssxm++ZkPUGvtr5AeIbis/M2wxQETphgYW5FTFMm0HbOsu0eCjZP?=
 =?us-ascii?Q?yAB56rUFuMQw4cf1Qb28O7E9HLEWyOvQ4ae4+LlQNyYpOIXwbXzh67pFcdOs?=
 =?us-ascii?Q?9gTWNanXqg6hmMS4E17CK8fijyKVT9ex4bdVY4SniID3z5IcB5s1dWLdjR8L?=
 =?us-ascii?Q?Opv7CcvlW0ds34l+sJg8MA9KdhRWMGOgPwFyQ2MZSUas6qXOuPBApQhUoe1y?=
 =?us-ascii?Q?TWOVbhU+qsY5skQAPnSDYb6lPX56b8J1QZH4sxEDzmHnv9UwkaZctMT6fTuC?=
 =?us-ascii?Q?MFKzGpNZT9n4xO4esPAHiYjJgedA2nvexkatw8PlrsIiPgf3Elsz6XVmRDOr?=
 =?us-ascii?Q?0z0Ndw8x5xvlJdp+c7YaHQqtZ6fSdtmBpMPw7MOiZfUU1Vokxz+N36UuGqjW?=
 =?us-ascii?Q?c+5X8+498yxdyfXX8xKWNmEHH1Lmfe+q9L2wVShcjQ4I0ZRi8/eIdTA9qA0w?=
 =?us-ascii?Q?j+0D5rf5B7UNMS639YCP8PRmzILeHF01qeldausFsZAtgsGolqnf96okvSJc?=
 =?us-ascii?Q?SG4+Q5TIMW9b4t8gCr20Qg=3D?=
X-Microsoft-Antispam-Message-Info: s+XSJ0bNH/harx9BKGt9F0rpVjgnAKIxpq9vPkbLoGSSRTqJeSaZGHaSV4AIiyxbQaVj0jdTiRa0BoLtdzdWbbP/KHtQYUD+F1PgmyPoVxC213jJWUdW38ubRrzMDkLHOiCpvyAZCKPgZbpdXAaKA2BLp3aSWq+S6SUq89BuFaQj9/10MBVlXAvxwlSm08GB
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2205;6:qfQFMGpISFFSh1ldJNnO7spkL3x2tb+kBB6Jj0s6bWl4ai+6hmG49D80W8/ruQijHZ/BbZAPgeBLzmZY+hWoVhaRMrnRiWn/seE60AS8EwHVGbVQRCuA83KiC2MSvpcZfXPlai+4ILb9BSGoCUxQp3l+IxJ40eCpa0ntvEA7q8ppYx6IdACcp1Ekw3bvMErisBQwyzx5D0UW4YEeU00kwyAuq4836or1ElsFfApPN/bGAhfZFsGzCQM13GBjxqfQ2ubRZlsuGgSGaBSUMXexjHzk+KHjsEyk55qybztXHPdj4Y3WYff6PutkVyII/b6/LpUAph4xqcmMmoekEyv1jugGpRWmRjzpcd+gKYqe8ItWHEkm5GJPV3xSirOCHomnLUvbkdrNFBaL3tKR78/gbebq0Yrt0EgCQylrQn23aOVXfwAg6GNeQMto9DQYe7C5Zthjm5QwrWueD5a6/VPs2Q==;5:Ye+xOFe0jF3jR7dGNKQgfJ1k2WjdDiE/4KTDhvxLNWOkz0vdGlJZ6lHVXasKb5qhxX09sOKeEmZqodo1bfC1/hFq92AN0w2kA00uJKUQcmtNOL2gjODfd6KA8dFhhXSmgEezWEtgsGO3Lt96+TyZ0YewD2YFLQipVQGUoEAKfww=;24:1O1xBuz7U1w5pGe8FzhTF310KcKbrqQc2zVf35bGsBnBWVLq1TBizdWMwFrfgQJpUgN7TbViytAcVtRlhlsXhS8RnWaO2DgZoRfRP48J14A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2205;7:eUy32FsXRjz18B3N5FFXImfK2bp0Cl4tJkRDmIeR8/TmTzFm06NY3CCdlgjcRAP12WjD3YNNCCBtmBwfmu1bHm4mM7A7V1HX2qYP63W92gZTHSFJmigBZ2M7zTn22rlPt44anP2cGDSBEW24+c1+BuJ3pUZka75mtgHLP8LyDBhB8C6uOIqWks2Lwe73wU6oQCImNoj47ZduoSrilY/gxyQn8/CLRs8dOFGxDEtRKJafFlBxPUAipP0zeQOkdxkr
X-MS-Office365-Filtering-Correlation-Id: f2fd49bf-2cde-420d-6d33-08d5c66fc2bc
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:04.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fd49bf-2cde-420d-6d33-08d5c66fc2bc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 70e335a..34c5ad5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -241,8 +241,28 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..2eec6e7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_IOCTL = 34,
 };
 
 /* PMU-FW return status codes */
@@ -49,6 +50,7 @@ enum pm_ret_status {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
