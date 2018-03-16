Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeCPUiJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:38:09 -0400
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:57888
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753411AbeCPUiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:38:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com
Subject: [PATCH v2 5/5] KVM: SVM: Implement pause loop exit logic in SVM
Date: Fri, 16 Mar 2018 16:37:26 -0400
Message-Id: <1521232646-79580-6-git-send-email-babu.moger@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 298e7894-3720-484d-7e9a-08d58b7dcf32
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1776;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;3:XATZkEZmBRFqv4p4JiiWb12t6BlIbxLQH4bchoRg5GRcG0nPWXzZHRZr+ZVGYM5hemz+EXwFKX5+Y1LX19+E+N8o/ZXnJ8AaHMjfMQY7dkHR8GxKEgP6h4gs6EGpQDGc4AjXD6/2uAN//bF9lmf+PVDx4I+sIbFpUSxqzsKDg0cFNe9yoU/s6X1Hk3uJtGWNSLDTJe7sb5PBtAUHl+rsKWbONM4kwPFAGt0pZVUVlxnqE4ZstOgFQpQsHKfjEGHQ;25:yTHl6smGKw6Nr4/fHZyXk0kiwy7yD70690AjeSpfAeUeG6kB5dT3DyW/EkVVn7dhpDXW7AxD4CHPEsCzwdnLgPHLCmckiMpFBmpiF3NNs5P1FUSIZ+QLrzXFHRbxcu1cZun9T3S2ZjxuXcpxYSCwd/UEiqw1bBHUB4bFR3HNDzbQ0YkQpGpVhx6L/YpswVhtIRfHNdj8nqvdppuF7mQZyJPdys5GOktpNxbe5eExrdxOiFb0LBwnJKB1o7Rj1/kmRLI0Sr4PRowWuSW5Zr02KkbFIq2yDf9EZnZi2+JEGmTq78Y1z5B3Df28rvyn7GZc+aN/U66BwQQtyp/y7zANtg==;31:VtnYSV3y3b0q/LiJWI7U2C3PPyjagu7/fIJg2x8xR9/z7uko0WK77ZarPEL6CfeLtB7YbYZ/QhIOKhVo05rdWr6udG8Jck6RLgaG14a3UJVGHXz9n/v8g63MZ/iZxIgAqtHdI4rSDjzoQ+g8GyQ9auJAB0Jm4dGRLNPP5oHYtBNVuQsIAPnBDYLFelZH/XGpnULXlEfOH82uN1o9jzJghW6Xw3cLhAVIbdRFZ84wjbA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:7ga1Dq+98rt6prinqndhM20OXWJh2S3c3MzJyoN+hk9P7jJM5JMmqMYzhNIyT93ta4JdK66h8O1jujIGmTLs/sj/i++HH+kFSbtEsdYxCVgnMW/DNLfUoLgGLgpDiduu3jfDZJu1Lx0h+ieShDSdaejv19/FClpaD1HXQrGjD+2YWUz0lq8M0GXra/ql6KYQsZykrsQUgcQILW1EnbrzJL4ti8VWk8j3O0PwiiTf+z6/amCf6Ux8FwzGPCMhbbMX6iWa0VNGIQSlNo+Sps1dyhSWiEY6eOXNF16wUU/GUbuQdJ/GZaSi2Jv0/GekxaNNpr++7U8+IIUeO7CWvnIUoliaMSIzlLpFXR0AqePV/0aM1yhVVpkw+9rMMQBCTf7uCrjod9rSgVsf03LXpBsEQaLM/MaO1J0LBEYq5MuGqb1+s5HlG9jeHNiuQPACKNoN/nb9vxQbJx//d7GVZtRLb8CbBTeR+rSlWzgzfq+u+qUfptgnWkftOBAiF1wZ3yVb;4:GJWu/1uOPCKT2lRPPb56GSyDAfDpvxvVbqT03f99SXivq90ZMxqud8NY7gVQQdXgpHnJbGrsd0qYrm/V4Z/n+N+cF9yYENSztSyEuUIw6ttxPIDHpRcX1y8E0CI6fk0DlHBRFAV+w27acBtOTd2d7MjkQFtjFejD6woIgHtMN0HcTcmV49AxPFYwndLaiBw0lU1MYnnClau4Sk6IOEjWaHKUJzX+Js7KVwShE830TElxgKwaLgYWzvbZJgOvNfJi5ML1uo9ribTRw9Ni260qnRBFMz4Q5cJ9ZFK4+l6vQlUgxKl6XBDLUTRozgFzS9BR29h+NNMGY+tIP6fPS5ByYA==
X-Microsoft-Antispam-PRVS: <MWHPR12MB177616EF060D37A29E32702E95D70@MWHPR12MB1776.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1776;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(81166006)(8676002)(81156014)(50226002)(6116002)(7736002)(186003)(16526019)(3846002)(26005)(305945005)(106356001)(2950100002)(16586007)(478600001)(4720700003)(386003)(6666003)(25786009)(316002)(59450400001)(66066001)(97736004)(8936002)(4326008)(50466002)(48376002)(52116002)(51416003)(7696005)(68736007)(53936002)(76176011)(72206003)(36756003)(105586002)(53416004)(2906002)(6486002)(47776003)(5660300001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1776;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1776;23:ZXV2K/MAWxjqdBQkmzO7rg3PrKYZLRHiqJ9JMhmbL?=
 =?us-ascii?Q?VLfHC99KlXmm+CHWrgcL83/+pK7yzIk9ijxyTGx8V9AmhcR57AQrCpR1yLqz?=
 =?us-ascii?Q?8k/m2hniYGacHSRqXLb+dfHplNy8GY13Ag6w1dqOC1JyEHdobS0IS7AyaxrE?=
 =?us-ascii?Q?thF0UTZH0xBXrT9fIK4hagQiA5qGF8JM1Rz1KF3FKs5Q6z8qdI5zW1KJ0st3?=
 =?us-ascii?Q?0tCeQUHMSaJuVBO9jh9gPLsYypv5juwN8po9erQgr3rTqpaOTEmMEVNdDel9?=
 =?us-ascii?Q?t1An4kZYWU9UAdmYGmQU7nX7HsPjRuItSBiF/p6L1Qkf5GKaxVK3HYd4uKpB?=
 =?us-ascii?Q?7iJrLzLLklpLrsuiX7Q9kTZg5Lk0SQdg0Pu3vVCGZt73MbJmXjrhC9R3Uccx?=
 =?us-ascii?Q?NJZhPVBKHlKIsp12A3JNracOTH7EdITYJc3971KzkS6eNauIzlwlkQJi613z?=
 =?us-ascii?Q?0WSVxhdYIedWTXLAqVPXj6X9Dbv61Wv/eX0gQI5wH0Yy6wmaTxwME1TEJTzT?=
 =?us-ascii?Q?k6KWGkvtEofMgChTktzQ4GDHGySK5HwfmcF7NjruFQdwkGveIquKoV01gba0?=
 =?us-ascii?Q?Q5voymglEJdY47ahLeoEU2SO9HNqupOGkWpFzqHO3O4nyZg+Znw+wudb7A9Q?=
 =?us-ascii?Q?mT9wuGc5dmdsRx7QOL2fB9BP9b7n2eiN+UGJvf4uRuvi2QUy9/vPsqTX4q1r?=
 =?us-ascii?Q?1RyDuq3n+QWHbhg0jCHBHaWqzT3hY498Lmf/R6XZlORYS2s88qbMb6RXjuZD?=
 =?us-ascii?Q?W6CzDKoJtbDKM6lEqG+SYACX3fehxzieQo/zdcb6kPx/6wwtBubJlXE5izgX?=
 =?us-ascii?Q?ZTu3bwae0DnpPirI2Y5I3t0xvz6TN01Bn8kk1hhtqc6dWJJpuwfqoJaSIjvF?=
 =?us-ascii?Q?aPjIIVZhNzrrkqWQrN4giHDAuDKBtiw0lMJQlY8ZKMPmurgJMeLpxsLCvPO9?=
 =?us-ascii?Q?ZLVRL7g94eTGGSrQERlr/TCOJ8VFHIjRr/6sslL55nu0/YcDw+E/PRympjb3?=
 =?us-ascii?Q?zku7NTEkx3Pgn8Jae9/hWlBwJUN5mn9dQa1o2yyAqS3C2ONIz5LWVGDij8qO?=
 =?us-ascii?Q?Vij9UTB6I7XGqBs3zutJqI6ekRboCjLsKh6lhhq6QYoO8GdgmW5XZ2L5ZdC2?=
 =?us-ascii?Q?Sx8HdHws0P2CwS9BaArm4I9haDx/UwoI3FYPxYzhSSc+3x7WxYrWQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: kguDF6eSXwvnTicCPJETVIZj+unHF6R3O41b8ZmtQWAtp/JivnSsBwvodimYt5pQXaLQGyoODDygF4bNjo3McxIJx+SRfuVQKnScM+NjWGRDqygKbXe6w/ZYeVNO/zzeqcA09UF8IGYVmmuDCbVJF2uR5ZJXsI0j36AyYbx0f9m7ABJnjnBPHLTd7zeRF5CF
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;6:QR/Z9C73tDJLJzuJitZznr6BtIuBbD9o9R5hi1ROoLRdEnKtkJr7vEM/cBN6K4VqG52je85NR7TGxklTJ6zdCD6M5YcKPH1j4sojbKkMtdI2QOz9Ifh48AgrD2yynWv0H+vhAbucCmb730JnQQCGClrHTp25X0PEuyJUpeir55dd2O0mFwGO1l0TcQXAWOn4eJ3iAlmD79nniXZ7dJMEjEx3c0Mxer/5b6IasgvB9CRveyzSpDuhN5kI1LJGen66irQ0WY2fn8ERXwDi1g0oxOWc9jhZbVkTCe4hHLgZkR31TE1LXdiOGGO5Wm2YZtl+f7+Wkuvfb8wk/WJ3z+wXQOXkmpiffoUf0XUKDZKhSNY=;5:4UDjEiL25PHRD6ijEjl21J44I1mRCq3ZrY2kWq9kormk4AE1UtHr72qwK4iX21cl0/27hffv7nBSmhzowwqDzGOSshnRqTY1vWU4sJlKfby6/MAbG7uqgPokcqZq/GJ05bl4vjtHV1E3/7yjFm6cUrvXpD4JRDTTtxLH941VkWE=;24:GFfsgIM77zebfsjPOLSBCItXdP4/Xqhss7WyToI6s909UqbsAdKg/nV4/OVlgrqKzde1x1u7IvAn14HkiP2MD8SGnGaF76tK9p7hE4yy+zI=;7:O5GCW2AcLE4/k8bqwNU5lxVqzeCFAo/li7jYTw3Zd5tLGFKPkkflK/tfNAYCoPtdsu7aoZawX6NkQm+8+Z6A5YsD5ly/z6X/lrEIAVSQzWVswDAWNCdgdATJJnRIDC3u1wKNeWl8lrh1P1IPW1ff128jamyKghJXssl03YOFvcZQkWBoMtw4MsPlSVw+FPiqHO5Q+4naiP/+n00MKGc9vuGTMxoPMEb37U6iTwu5B5qkrZe2HRRj6xhq1STQHcX3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:0RCYVZ/GyRt3G7xCUnlOhTefvC+GnYaPWZXU+2GVhytq+yKXZyQymC6E6cINvtLF/MkYHSbLj7jox6+rAd/HdLYASyP8a95NInm6xFK73aJ3zISz20NcaF0ZGt8R5eh0nL0+9EDMBcI90LmPu5Bi9irAFRCcx0XzyTEUB7tdhJGm3MHYoNAWbVnVULwMhvwgWaMMyiCtzCKJt0rkTPJEj9K0LkpAHEJldSc0k6SukicMPX2x3i2j44VWowz9lUAL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:37:59.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298e7894-3720-484d-7e9a-08d58b7dcf32
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the PLE(pause loop exit) logic to AMD svm driver.

While testing, we found this helping in situations where numerous
pauses are generated. Without these patches we could see continuos
VMEXITS due to pause interceptions. Tested it on AMD EPYC server with
boot parameter idle=poll on a VM with 32 vcpus to simulate extensive
pause behaviour. Here are VMEXITS in 10 seconds interval.

#VMEXITS 	Before the change  After the change
Pauses                  810199                  504
Total                   882184                  325415

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kvm/svm.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.h |   2 +
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 50a4e95..4636504 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -263,6 +263,54 @@ struct amd_svm_iommu_ir {
 static bool npt_enabled;
 #endif
 
+/*
+ * These 2 parameters are used to config the controls for Pause-Loop Exiting:
+ * pause_filter_count: On processors that support Pause filtering(indicated
+ *	by CPUID Fn8000_000A_EDX), the VMCB provides a 16 bit pause filter
+ *	count value. On VMRUN this value is loaded into an internal counter.
+ *	Each time a pause instruction is executed, this counter is decremented
+ *	until it reaches zero at which time a #VMEXIT is generated if pause
+ *	intercept is enabled. Refer to  AMD APM Vol 2 Section 15.14.4 Pause
+ *	Intercept Filtering for more details.
+ *	This also indicate if ple logic enabled.
+ *
+ * pause_filter_thresh: In addition, some processor families support advanced
+ *	pause filtering (indicated by CPUID Fn8000_000A_EDX) upper bound on
+ *	the amount of time a guest is allowed to execute in a pause loop.
+ *	In this mode, a 16-bit pause filter threshold field is added in the
+ *	VMCB. The threshold value is a cycle count that is used to reset the
+ *	pause counter. As with simple pause filtering, VMRUN loads the pause
+ *	count value from VMCB into an internal counter. Then, on each pause
+ *	instruction the hardware checks the elapsed number of cycles since
+ *	the most recent pause instruction against the pause filter threshold.
+ *	If the elapsed cycle count is greater than the pause filter threshold,
+ *	then the internal pause count is reloaded from the VMCB and execution
+ *	continues. If the elapsed cycle count is less than the pause filter
+ *	threshold, then the internal pause count is decremented. If the count
+ *	value is less than zero and PAUSE intercept is enabled, a #VMEXIT is
+ *	triggered. If advanced pause filtering is supported and pause filter
+ *	threshold field is set to zero, the filter will operate in the simpler,
+ *	count only mode.
+ */
+
+static ushort pause_filter_thresh = KVM_DEFAULT_PLE_GAP;
+module_param(pause_filter_thresh, ushort, 0444);
+
+static ushort pause_filter_count = KVM_SVM_DEFAULT_PLE_WINDOW;
+module_param(pause_filter_count, ushort, 0444);
+
+/* Default doubles per-vcpu window every exit. */
+static ushort pause_filter_count_grow = KVM_DEFAULT_PLE_WINDOW_GROW;
+module_param(pause_filter_count_grow, ushort, 0444);
+
+/* Default resets per-vcpu window every exit to pause_filter_count. */
+static ushort pause_filter_count_shrink = KVM_DEFAULT_PLE_WINDOW_SHRINK;
+module_param(pause_filter_count_shrink, ushort, 0444);
+
+/* Default is to compute the maximum so we can never overflow. */
+static ushort pause_filter_count_max        = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
+module_param(pause_filter_count_max, ushort, 0444);
+
 /* allow nested paging (virtualized MMU) for all guests */
 static int npt = true;
 module_param(npt, int, S_IRUGO);
@@ -1046,6 +1094,42 @@ static int avic_ga_log_notifier(u32 ga_tag)
 	return 0;
 }
 
+static void grow_ple_window(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+	int old = control->pause_filter_count;
+
+	control->pause_filter_count = __grow_ple_window(old,
+							pause_filter_count,
+							pause_filter_count_grow,
+							pause_filter_count_max);
+
+	if (control->pause_filter_count != old)
+		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
+
+	trace_kvm_ple_window_grow(vcpu->vcpu_id,
+				  control->pause_filter_count, old);
+}
+
+static void shrink_ple_window(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+	int old = control->pause_filter_count;
+
+	control->pause_filter_count =
+				__shrink_ple_window(old,
+						    pause_filter_count,
+						    pause_filter_count_shrink,
+						    0);
+	if (control->pause_filter_count != old)
+		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
+
+	trace_kvm_ple_window_shrink(vcpu->vcpu_id,
+				    control->pause_filter_count, old);
+}
+
 static __init int svm_hardware_setup(void)
 {
 	int cpu;
@@ -1076,6 +1160,14 @@ static __init int svm_hardware_setup(void)
 		kvm_tsc_scaling_ratio_frac_bits = 32;
 	}
 
+	/* Check for pause filtering support */
+	if (!boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
+		pause_filter_count = 0;
+		pause_filter_thresh = 0;
+	} else if (!boot_cpu_has(X86_FEATURE_PFTHRESHOLD)) {
+		pause_filter_thresh = 0;
+	}
+
 	if (nested) {
 		printk(KERN_INFO "kvm: Nested Virtualization enabled\n");
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
@@ -1308,9 +1400,14 @@ static void init_vmcb(struct vcpu_svm *svm)
 	svm->nested.vmcb = 0;
 	svm->vcpu.arch.hflags = 0;
 
-	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
-		control->pause_filter_count = 3000;
+	/* Check for pause filtering support */
+	if (pause_filter_count) {
+		control->pause_filter_count = pause_filter_count;
+		if (pause_filter_thresh)
+			control->pause_filter_thresh = pause_filter_thresh;
 		set_intercept(svm, INTERCEPT_PAUSE);
+	} else {
+		clr_intercept(svm, INTERCEPT_PAUSE);
 	}
 
 	if (kvm_vcpu_apicv_active(&svm->vcpu))
@@ -3802,6 +3899,9 @@ static int pause_interception(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	bool in_kernel = (svm_get_cpl(vcpu) == 0);
 
+	if (pause_filter_thresh)
+		grow_ple_window(vcpu);
+
 	kvm_vcpu_on_spin(vcpu, in_kernel);
 	return 1;
 }
@@ -5424,6 +5524,8 @@ static void svm_handle_external_intr(struct kvm_vcpu *vcpu)
 
 static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
+	if (pause_filter_thresh)
+		shrink_ple_window(vcpu);
 }
 
 static inline void avic_post_state_restore(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index ca051a2..e6d0259 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -14,6 +14,8 @@
 #define KVM_DEFAULT_PLE_WINDOW_SHRINK	0
 #define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
 		(INT_MAX / KVM_DEFAULT_PLE_WINDOW_GROW)
+#define KVM_SVM_DEFAULT_PLE_WINDOW_MAX	USHRT_MAX
+#define KVM_SVM_DEFAULT_PLE_WINDOW	3000
 
 static inline uint __grow_ple_window(uint val, uint base,
 				     uint modifier, uint max)
-- 
1.8.3.1
