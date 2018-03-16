Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeCPUig (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:38:36 -0400
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:57888
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932094AbeCPUiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:38:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com
Subject: [PATCH v2 4/5] KVM: SVM: Add pause filter threshold
Date: Fri, 16 Mar 2018 16:37:25 -0400
Message-Id: <1521232646-79580-5-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:404:65::28) To MWHPR12MB1776.namprd12.prod.outlook.com
 (2603:10b6:300:113::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6e03592-8b69-495f-096c-08d58b7dcdb5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1776;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;3:564DSTZmutffFhlTAL4/qjLu50doi4MpGT2T0XMPsIuIW3e8CL2d1oR9m0dU0Gw/qkUs8ejLXNuSEpm1SeuoILo6kki57H0PT2LRDjA8pkRy2hqukENclWh0SYxrpa/ojhHPBNVicWCn7PnqQlE/Fwkv++iMnYSnUTVEf/+g7Xq36ef8LjKfpFn0DIwSnTNcsqO2QcYclK6VcTUPBjIkE5z75K5k4dZoOF8DE2nDXjoDZidSgHaF282SWGP6usNR;25:a22lhXvBeuGNX1Mwb+KhjtgB13vp8Rx9j2+wCaFcvX6IgemeIp2TM8p/yLROHXmuzHSVlyUw3ktCquvsUeG7ltmYxKqwR6C5xI1SAY8CKh1MxksTQkTQ025JMzN915082P91gBsPYbGMFXk9UsIpvQPDC+UbxchvvUgo03QrZwS7FRDfDSceEsusZ1uABGW46pE+QtqCsjaWpFcYJjDvEfIIM8878EZv3fQiWVaVIfYH8hfUyiaPGngszPxSyjY/dTUjlmHAoP7Q/G46VWovFC5yx89TACwZ/UouI2bfN8kFuyJlpUaoO1ahccvOxJpn1vmwMQ9grozKtyqEN/ZbMA==;31:eCOLTrsTyi3uW9rTG+nvNPPI9fUDK3lBXwx12xIi20y8Bg6I+F8hPo1pqqUw8HS4rLyXgEAuT/7RL2gmvmgr/ywxmU0/QOVRU5GMyusgVv7REnJ2RxP4BX8Wp/cryeELPcMB9F+trVmFQOuvMSDdA3SWQLAL4bBCDaY1LUyO78j+ydjFn4nwg3+b9gLZHqb6GqzvsruO/gBXAbz8vPl7nDOwm/IqzKMqXBxh3fAnVZg=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:vrVdoapEnQa9qf9AbP8nk6uTm0VRDOHeqPSoljxldqYG9EenCa3Vzc0WQZ8o2FTCAisE26KMd+ON3vxxSiMxsNG9bRWDK0DYSJw1XVIAYS19uC1Si0kY2nr4YH3zWYF7ZSGF/ZSrasolNur2tZbzQXZPNRDQUmUfuhqDfPMFElDQKqCcSJWA582bmd3xqKV0PeR8mytjqcOqnx3ibIjibP+GTD8IBzxvFWI1IwnfUH2sSi0DLBfYUDmGM+Ms5sZO3J4skP1TF65eZxR5EZjvm917x8AbASJTD73UrPYbWwfXuBIO7RRNNld8hnOKdHSN1MSu/Vj3i0h9ca17mccYjrxMw826InjT3ugF5WblQJKnjMNBhnRFbOSEF9uPLIrwVQ+PEuJNYNle7YzoJpccL44jU3U0LG0VYXpLeuEblBeNRcjr+P/Db20SYl/7WiAtk40fN7No21Qp0ZT1izQSkmwOf6ypD6OrQ9QnuYJc9MRs9QF3tRUmq3BkdZIyeKkT;4:tV5sLoBg/Z2id7tNylO7gaMvUQiwHll0P5YpeUo7tjPuuKnQBG6WHaItqPsUQ3T5GxVUULP83A+t5t8lVQn+vnlr0ZclipO9DbklXINfs2SbgXcd8g82Vh9WGBcO6aCIp/AQDzaTA7FkZeAzNJfTcewzsHPjktrKez4gXB8+RxA/GQdRPOEGrlQMhDVybuq0vmHI/XYq893yXPWAS7r/6F2eSeOdVQXJemLu7Ypbk93EjR1G6gOoyky+OuOJzE1zV3cUfyhc5mJ8p15CSYKmDXiNT5Rrta2fFij/1o2u54/w0nXksSPmp9WJFd7oBYmd
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776C6E250E80BAE2136862C95D70@MWHPR12MB1776.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1776;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(81166006)(8676002)(81156014)(50226002)(6116002)(7736002)(186003)(16526019)(3846002)(26005)(305945005)(106356001)(2950100002)(16586007)(478600001)(4720700003)(386003)(6666003)(25786009)(316002)(59450400001)(66066001)(97736004)(8936002)(4326008)(50466002)(48376002)(52116002)(51416003)(7696005)(68736007)(53936002)(76176011)(72206003)(36756003)(105586002)(53416004)(2906002)(6486002)(47776003)(575784001)(5660300001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1776;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1776;23:m4AA+8Dy5rjEbEZnpMVIeiLfjwPTP19LOXJYR6Cyd?=
 =?us-ascii?Q?qRiuOvarVFoyNB81FRYcgTEOTbCUSwPttpjqyM0krzUlufENeOHydTh2Jg/g?=
 =?us-ascii?Q?NOFaVTWSHTITOrOLIY9NVQgWfQ+a1SIKCp5vhZgtT5J+UvSJNcOkU0XSlih3?=
 =?us-ascii?Q?MvHiO9zpVvBMGIBSshDvyhWrxbDBkcYfce1KPv119Nc9mkR9GJu8e/FHGr6P?=
 =?us-ascii?Q?Yjqntae1FK3WtcA4QtzwDWfEzThJ/AgMCuhwEqMKI4Afrh+RCHBu2UzR/nh9?=
 =?us-ascii?Q?h6rypaKOcaKE8Wa+EGH9UubpzFzSvNsVWVGFiXLKBqWcOvb/E3Mn6/+eON9H?=
 =?us-ascii?Q?T7SIOvCCfvB7jfVLddO3gFDSjj2QvyWk0l97MJOwekwxIDhcxJJQfdn+7CCa?=
 =?us-ascii?Q?aStsB7QuASFUUxZ0M4RjlCCSth2xhTUEYsI0lHE8h3zptssFBJuh8mNeDeia?=
 =?us-ascii?Q?v73jltJBeZe9ELH4fwGD8wVS7Iaty+it3LQPjArFyBjg5VBw8oJLMvi+Kouj?=
 =?us-ascii?Q?1ypJf6rEZL9+II4KAJ1ktdZZA61MPkWH7skqwel0sBRWed2L/k5kUF91W+kE?=
 =?us-ascii?Q?5Y3kJ8BhPsMLqLFe7OUrZApUm7hvXdhFhh53iO+ScvssXCwqoAr+Nbyysbyi?=
 =?us-ascii?Q?5cWoNWt75sVr5kTH+6PyeG9VNV3GRPvR1TqmwF4cG3sffqE0vFQI4Lsrcn7l?=
 =?us-ascii?Q?CaXeu2BUAJCkGNoFjpqWsmsjcJvsDXvIAAm37/ROxxlviD5fKy05t/XolzQT?=
 =?us-ascii?Q?i+d5fdme926mevxJejcFVq9YdQS4cVCZy6qkETizX2d1/pKjgcDO1bGsETIu?=
 =?us-ascii?Q?Cg0/Mi7W7xIhQwwPu+Qdv41NxLwKO7NQnqa+B7uRVO7KrQnHerF5HWABLN+z?=
 =?us-ascii?Q?0zUgJGOPUEwsoY273i+D2OgzMx4zWpYrghpSDsiUIOmuY+Zm+BwrqT+rlS/P?=
 =?us-ascii?Q?ZwObFyJqXrZ1ujnhf0smfkoxui1MMaze+aguLkkjHtRUxo/XF8yi155YH7W5?=
 =?us-ascii?Q?izjT7Jb7sgqVkNvcHmIWThPV1xR3yCBUU6LFnatw7Kh1nS59cgcuEQqrbu/0?=
 =?us-ascii?Q?17gw/qN5thTGzpfb9fyLyE6ghiFk91Byrvav2rrDnpOxubjXv5qU00BrHRiz?=
 =?us-ascii?Q?iHxNHTBhyPBD7nawH981irtZBnT+MCfU4lLPkJab17gX5wKVLqFb0hX82mWJ?=
 =?us-ascii?Q?2R/+45SQFheUAg=3D?=
X-Microsoft-Antispam-Message-Info: V2s+EXmN5fR+WbYrTaZXrUGgAy2xZJn9B7EHCKHi9B0MN43FyXey4mLrydMPUYMcbAXbItDwgnFWm9t3uOlhvLTmp7NxZyUQVvalgeYlU57U2coPkjtYeMDN4u4mUrGXN8vB59Dmi85eTpA5NwAMytuJMmCeeWndpHWo5cY895mviQv4YfnRH7ighnbRSUnN
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;6:YEovB4UO02D3DMmC3ZwALxvYtGH5KKMUjxjOAoG4aX7QGoMcyy9VCqkWqfdsNLJbAO8ZOHeSVtELaXswH2jabVx3rI1qxULb7kds3tTR2fcHeAhVGIeWgUovXgmmz+llWHyiv1DfOxl49imCo/hRrKoEUdIkjpach4R8nA/QN5DUorCn/ygLct4NyEfzCOsVO+woZL32LR7s3Wp6byUDJA7rGI+P+n9RSd4/gmsFuGReQ4/woIvGsxXfw3PkP9CrtG6t+WV17NO57Rb6rBfTGg337DwEtxv/kuIYi4joG1/Lhnvf+VK9jb1qgFXcNcfzuotViDpncRefQoCG/UzkWLhrcf/T4DoHesS+9sgQIlw=;5:2ml8gHks7BEu/T9iLHwG33xZIG/jZfgSeLGuSCsNDCOc4glY6wVSBdOi8BU07CE2un4NcFaQq0XbTtgGwTwGMXAcIkotSKVCu98bQoJiDDAHdjiQ1pilTB1wnmjc9xlo42TChW1zxL19EmG/zWdxvMQ3jVGPccE+mm9hXH8MhkQ=;24:AePYMT3HLqDK3hOCI4p2gygLsppYinyCcO4GfDDnz+lE7noOYjrJn889Mero94KW7T9PfyhgUtAJ5EUts8W5hEti9NsIHI0ZeK20aUBDHto=;7:Td6ImO4xal7pc8oTE+cVMn69A8XPJySxHhD8Eh4mHCVwYUFricl8BIF8SaP96fL3GAdRu19vIwxBoXF1So2Ziq2htjWFNWe5MXUUaVT6WkkiRESsbIJbb/oTpSWc3UssVsuof+euiVTORwUcY48Y/J4HAM7pBWXFQSmwWcfIkPiT+f0YHQ1heXOHNEqCfylRPohd647VJh7V3e2kB3D9pIi4Z/oW+T9p/srnF0jHhQEyatTAyk/DCp6VVL7DM3pL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:VaGjWknf/El0vEJ0/xIU1FCW6CYXhmYX2QN+6oKe3fxWrIcHibuEVOmFZbv9lsXT1fwC07rArhIPv8582BfDuvSRMVfPx4CUC3VI9o8P6+b6JqlfCEk6SoSH+/aUUuDQG6WoVM7Zo8PYOcFbt7qxsMJ8aIMZn0kbQRBnFoB4QXmbcOWbP7NiK0K/7AmxyjQShvKlKVVdC0FY8cbZLOwCHf9NeLaig108C/gWvkS0qieVUHG9lgEkXW+LX2bKxt8O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:37:56.6472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e03592-8b69-495f-096c-08d58b7dcdb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for pause filtering threshold. This feature
support is indicated by CPUID Fn8000_000A_EDX. See AMD APM Vol 2 Section
15.14.4 Pause Intercept Filtering for more details.

In this mode, a 16-bit pause filter threshold field is added in VMCB.
The threshold value is a cycle count that is used to reset the pause
counter.  As with simple pause filtering, VMRUN loads the pause count
value from VMCB into an internal counter. Then, on each pause instruction
the hardware checks the elapsed number of cycles since the most recent
pause instruction against the pause Filter Threshold. If the elapsed cycle
count is greater than the pause filter threshold, then the internal pause
count is reloaded from VMCB and execution continues. If the elapsed cycle
count is less than the pause filter threshold, then the internal pause
count is decremented. If the count value is less than zero and pause
intercept is enabled, a #VMEXIT is triggered. If advanced pause filtering
is supported and pause filter threshold field is set to zero, the filter
will operate in the simpler, count only mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/svm.h | 3 ++-
 arch/x86/kvm/svm.c         | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 78dd9df..7a3d9c7 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -60,7 +60,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u32 intercept_dr;
 	u32 intercept_exceptions;
 	u64 intercept;
-	u8 reserved_1[42];
+	u8 reserved_1[40];
+	u16 pause_filter_thresh;
 	u16 pause_filter_count;
 	u64 iopm_base_pa;
 	u64 msrpm_base_pa;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f40d0da..50a4e95 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4175,6 +4175,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%08x\n", "exceptions:", control->intercept_exceptions);
 	pr_err("%-20s%016llx\n", "intercepts:", control->intercept);
 	pr_err("%-20s%d\n", "pause filter count:", control->pause_filter_count);
+	pr_err("%-20s%d\n", "pause filter threshold:",
+	       control->pause_filter_thresh);
 	pr_err("%-20s%016llx\n", "iopm_base_pa:", control->iopm_base_pa);
 	pr_err("%-20s%016llx\n", "msrpm_base_pa:", control->msrpm_base_pa);
 	pr_err("%-20s%016llx\n", "tsc_offset:", control->tsc_offset);
-- 
1.8.3.1
