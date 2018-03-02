Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936428AbeCBQSf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:18:35 -0500
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:42045
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936395AbeCBQSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:18:08 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org
Cc: babu.moger@amd.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in SVM
Date: Fri,  2 Mar 2018 11:17:36 -0500
Message-Id: <1520007456-85293-4-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR14CA0041.namprd14.prod.outlook.com (10.171.172.155) To
 BN6PR12MB1761.namprd12.prod.outlook.com (10.175.101.22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c22a8aef-8911-46f9-5a29-08d5805929c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1761;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;3:OUVPj4PzpZJ8Vb6nF8IdTbyhoBgHqnTGlHrIKhenT98TtCBxS/JFNnhZxgAZFRrIACg+VQnup+vNPgCZLHLPpHOLCFIDrBrYvCgx/WMwG0n0jBxuIBYzWDA9hFioDfICYU5DcHWCz57z2k1sIbGcEOPVG4vjX2HcBEM4dFkkqWDG34+Bq5K2pyuXcoGqX5K//3KwO2ebmgZvJeMHa/KSkz9xGpnSYqJkiJtfXfCHzVjpR/ZYmlfYu773oHxUKEXU;25:VEjYs6msKIMHjnFL+HnGa7IkJcWS+LQhuwFc/ug/LB6juBo7PXZP0UZD3ig7VdIxgAbvLUcNPrJOPkCo49uSBo60pDMWTyNoa5Vtcq3SffcVhmPDYarbzsQVFchQrezAQqPZnQ6dTB9r/JsH3b2G0dZZ920sG/5QyvI8dEE2651hZLGUJuwlMyIwn/2WzfDyApkdzpMYU2eNRCagsbhN3gKrRmkK01Dch3RjSTz04DrzFw8nEzWD4l3R/j69KEi/7d5y+RzJ1ifmt2aalRY7qDkmswEyefpwTYdKwTbv8ioCGGu9b3ohGyOUEV4ReXYeuAOF6zxjn9PoWWD675P6AQ==;31:wxDamlQJL0p4+cXtMFF4HzQTfGs7V0izIG77j27B84MLowZOO75PrFcXtmpHBTSuM/T1evFD+6zrqOvLMeTMJwbzirYCViDmOeVEkUPIHyGTv+I32FBsg5RDJnzpxg9/wR5zcHXLpUrCjRbOr/KeAE+KYW8GKLNbrOBjtAzFFdoFfGIFsI0pkEnC3VOz9gy7Gl3MAbFF40ErcfUbxKooTqu9ZZWP4FgPjlqtexuogio=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1761:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:VKbOgCNnuk/9FadyKFgmAX2XJP0UsSgIyd5P+Wb/uaBJDf2m5evDSXr54+4vqxP1qYtonZyWrRmIgRpzYzLCZdu/nnXkTv5aSHKSpbZDF8lNJnp6566eG0yaihx0x+3yWXZOdwhy7OZAG9pprK+v7a/usALV/7TKjYMNhyNtSGK7VhSr3LiAjJWKhnxmaEMGr/wgd4RySv0TOq9JhNzLVhnk3icjm8AN2GE8sHxVo9OB6E45uESH6hFZHBHQUFUx63R6MEnRBfCXkElPMYmP8YA5Ut77uNKvEnYDUS4dpJ9+yJPXvfPI0uZvXwEdtkkqwYW8YDUh3O9zZqx3sT3EOo61YlWH4nq5dmRfcKWDLVlpNfJnNnysDvVl6VgEcWrJPRP/PrEjzhefHB8Zh2ccqesLo/ZRutJWf+rUODmgg5VGRVKopjk7gN6QTcttKWR7xyzaDI7D4xZ+NZYMg/eXdXWnwi086yc2kNlyh8ddKOgrc/jpbw65VAt7Z5IScLiQ;4:BLNWo+t1YgwBpBogDXbrdSQl9SKZ+LZ/nqzAM1gPDeNM9a1byeNt6XRsXrhohkIKjWHF79uW1yHck3vr0C/t6o0hkP1uy7leFdPvvGQbcz+qqB7tA097ijFK9+2qla4IFeA92It/E4ETo6CpEP2iWHT5k0c+ECWbx1ehIecd3p8QFGlu2oxBeKRUPXKa/ryYjBfaLVV9VCytMAlmhnrK2S0/pZuyAdTwi4gF1kyEu2wIxdez7bALeNysBRB31Jhqw2hVYkCuA2rvpX15ceBEwlMZKp8KsIN8iuS5jIRKUXhiaw/0hGWne793jhEXZlfo
X-Microsoft-Antispam-PRVS: <BN6PR12MB1761AEABB558F32A1690776895C50@BN6PR12MB1761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1761;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1761;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(51416003)(2950100002)(386003)(53936002)(186003)(26005)(7696005)(6486002)(52116002)(16526019)(68736007)(6666003)(4720700003)(76176011)(106356001)(16586007)(59450400001)(316002)(8936002)(50226002)(4326008)(5660300001)(36756003)(81166006)(86362001)(48376002)(50466002)(81156014)(2906002)(7736002)(3846002)(66066001)(105586002)(305945005)(8676002)(53416004)(47776003)(97736004)(6116002)(478600001)(72206003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1761;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1761;23:UZiXNv7EfG6+Ix/XGzsMDJigCbMVjrYEUz53izCiR?=
 =?us-ascii?Q?5QgKYL1iEhYCNVC5dc7SX7WLcNDqAYHX6zFFABeYEKN7tXuJaoLvlMb0ISjY?=
 =?us-ascii?Q?rwvcuwjPWClFrMXU0hpv7C5lYghb8ZP+ujVDJ4RzGySCiw3rXuYnoAj8mVyA?=
 =?us-ascii?Q?irlTXbThcd2i7u5LxW2w7XRuMW+pLR29v7a06hhAr+mFzF6LChSYAGGn1KgM?=
 =?us-ascii?Q?dgiD+PhYJ/ITzc48BiFjqcqeC5Xw6cJE3g0ErgNZSq/DQMypbvo9sKpyQPLV?=
 =?us-ascii?Q?HtfQVf/+WQdNjp9omjvFmlTRgjEFc6ZxprQ0xPR6hBBiLu2Dc6izNnRny+9a?=
 =?us-ascii?Q?OGKMZW7T03aJi5eJrmM/4SqQho3GocNVRjsbTKiDM8F08pYW+OkRUU/t5i+S?=
 =?us-ascii?Q?xfG+EcWdjoSag0oT9GEL0ZBk6vhCItiuPzHAAdnFCXiOncxomWypFNKSFNcV?=
 =?us-ascii?Q?HU9KYdKJjXUNVVGi7LH6HaYTKgxh2RhPKOurHNW0aMfQn3IawcilD/OLzriF?=
 =?us-ascii?Q?UUUx2Dbk0Gs0/u6xruFHKCu8S+XAid9pK6DLNJfnJVdsCq6Tca42n0MlrQYD?=
 =?us-ascii?Q?FPLpE4Jn9Q9suqdr902u1L8KgJCZ08xwMwHfwB0e0rifv9xgjTe1iKe82O/e?=
 =?us-ascii?Q?9ByylMdbXSjcgzicbJDANC3PsQvmrtj3AS5nFsgSdaBgO9tShypRD25VUytS?=
 =?us-ascii?Q?QSR3BLfPh+v2MvGX2fydlk+PmRmDe6T+7FN3Jgn3yVq2jR0hw3moXrPhQs5e?=
 =?us-ascii?Q?t7EDJlbPtfWsnvqvg3lLgZv1ekYJmC4aQP82qw8u5IhEGP3xaLY/7kDwJnrt?=
 =?us-ascii?Q?dA0KiwDCsBeoY4W+5Bhg4aLbvqctErpSBdCxuN4RBdIsy1wE91jzp23dA+eN?=
 =?us-ascii?Q?zP8WewZprIMbkVgh9xIBvvDBBZAkzMO+KslKgn3ReC/FMfTHseKKePc0JYvF?=
 =?us-ascii?Q?fb6lNf9kCo6KFPDO4Hgadciwnt0ur92OT3uBhVBA135ZSGtIEszx3z1zV99h?=
 =?us-ascii?Q?tkOCgP3MN6YFk27JFFIug6iL4nwa89Jv5o20iXpOgdjBZSR+3Fy6Cu8HSqd7?=
 =?us-ascii?Q?YuaMK6lSTUxeSOhWHdA1D+03MGSoUrclYKfC1XNWOYt5WciHjeToeavgqNU5?=
 =?us-ascii?Q?xPYrg+ohPxkVrv4GE04efs+dPJ46NEERX7ybXLrwMffMlfxJnrZqw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;6:3ZycUYAxV13OPAs1D1bnwzxwut3+zs7NIREo5mLJPPS89R6PSF8gfTiepeKvgc+727nJ+dH82+yQQc+624mIOmIXl3ZQxAiWZ+x/qAcpwyZ39ei8jwfpRGRCkjpdadGbwbTJeFhjZpX2yI2hiX+je3pJ0DXESJquqswvAI7iEnOI2vHJqOp5/VWaG8+BRPkfgVyn/AW4VvUm6yiakyjEi33e2l+pew4rXab0/4GwXocjkYqXFl15ZWg/mfvRCOrkea34gNwXhgjwx7cFN7BMROLOCPt6jT3l0xWntSjLug6VzDrQpUp1JI3NHG3vn0HExosAIQNTXT5vlqRBnuWT3xn5Xym8tiyShjIEJA0iCx0=;5:JGZWi91VHZCvm2l37w1RswPFZ8hSEbdEHfkKMEHDFY5FT3eVzg6FysldWu8FwNU4AWqMCS7GpQqpIOmatkDHRW8IMCPU9FubthSv3m5pfMI9OE5NZ71Z+1YZzFxLg1B6JryP9wzYU6hP4LpcDpnFfL2gXC74G38/f/ZwqNFzW/c=;24:uLkOwSlWInLJ03zXEj/H7i9ruje+LKzuzQsOvJbKmbc2grTbk4C2VFMVGdaC2LxfHf0fstvWhtMm/5iCSJWUOSZn0Ls3PFD9NGdonCYD0dU=;7:QXKgxq6t069mSCG79OH958GNQKDM5Aii2jM6l+GKtdB6oBJVkBiPfcuMYbPjYTPvsE9KsLEPGeksH0eCVH+GLeGCxiip0jBYbelKqj3VGWnLagEnIyAjr969vty9NQy3d0t5SI4OKHzmjAtoJyruQDTZoAf5JgtpZ2abCYFV4LqV+yk5rafERpgxsJyVs4E8pS/IAnV/D161vHz6HTRsDsAHPXrQnivuko/QITR/546vktksZEG5vKSOxsxK3Y7H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:O+n9bik3XWRPkSqn4yWg2/9+UYBRAuHSbmw5EBpH7hurGRELTjx/2KwTVNO3ZSIRayhmwHdcNUo2zOs4nTKB5to1tb2kOj2nbDSs+A/kbp+HHEGfyKLh/SdLe4zcA/ne86N6th4oBxy4lw9jRscCyqh6vsEUMLVq+Z3HNXsLRRFAxaIm3JQz7c0Cj8h4F6WjPIN/s6M54LjqYglPSGwkdgZHUR7aXXIeGx6ItxEDPuI1NYL5ti9cRiXWLRkoZ5Fx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 16:17:57.9155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22a8aef-8911-46f9-5a29-08d5805929c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the PLE(pause loop exit) logic to AMD svm driver.
We have noticed it help in situations where numerous pauses are generated
due to spinlock or other scenarios. Tested it with idle=poll and noticed
pause interceptions go down considerably.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kvm/svm.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.h |   1 +
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 50a4e95..30bc851 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -263,6 +263,55 @@ struct amd_svm_iommu_ir {
 static bool npt_enabled;
 #endif
 
+/*
+ * These 2 parameters are used to config the controls for Pause-Loop Exiting:
+ * pause_filter_thresh: On processors that support Pause filtering(indicated
+ *	by CPUID Fn8000_000A_EDX), the VMCB provides a 16 bit pause filter
+ *	count value. On VMRUN this value is loaded into an internal counter.
+ *	Each time a pause instruction is executed, this counter is decremented
+ *	until it reaches zero at which time a #VMEXIT is generated if pause
+ *	intercept is enabled. Refer to  AMD APM Vol 2 Section 15.14.4 Pause
+ *	Intercept Filtering for more details.
+ *	This also indicate if ple logic enabled.
+ *
+ * pause_filter_count: In addition, some processor families support advanced
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
+static int pause_filter_thresh = KVM_DEFAULT_PLE_GAP;
+module_param(pause_filter_thresh, int, S_IRUGO);
+
+static int pause_filter_count = KVM_DEFAULT_PLE_WINDOW;
+module_param(pause_filter_count, int, S_IRUGO);
+
+/* Default doubles per-vcpu window every exit. */
+static int ple_window_grow = KVM_DEFAULT_PLE_WINDOW_GROW;
+module_param(ple_window_grow, int, S_IRUGO);
+
+/* Default resets per-vcpu window every exit to ple_window. */
+static int ple_window_shrink = KVM_DEFAULT_PLE_WINDOW_SHRINK;
+module_param(ple_window_shrink, int, S_IRUGO);
+
+/* Default is to compute the maximum so we can never overflow. */
+static int ple_window_actual_max = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
+static int ple_window_max        = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
+module_param(ple_window_max, int, S_IRUGO);
+
 /* allow nested paging (virtualized MMU) for all guests */
 static int npt = true;
 module_param(npt, int, S_IRUGO);
@@ -1046,6 +1095,58 @@ static int avic_ga_log_notifier(u32 ga_tag)
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
+							ple_window_grow,
+							ple_window_actual_max);
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
+	control->pause_filter_count = __shrink_ple_window(old,
+							  pause_filter_count,
+							  ple_window_shrink,
+							  pause_filter_count);
+
+	if (control->pause_filter_count != old)
+		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
+
+	trace_kvm_ple_window_shrink(vcpu->vcpu_id,
+				    control->pause_filter_count, old);
+}
+
+/*
+ * ple_window_actual_max is computed to be one grow_ple_window() below
+ * ple_window_max. (See __grow_ple_window for the reason.)
+ * This prevents overflows, because ple_window_max is int.
+ * ple_window_max effectively rounded down to a multiple of ple_window_grow in
+ * this process.
+ * ple_window_max is also prevented from setting control->pause_filter_count <
+ * pause_filter_count.
+ */
+static void update_ple_window_actual_max(void)
+{
+	ple_window_actual_max =
+		__shrink_ple_window(max(ple_window_max, pause_filter_count),
+				    pause_filter_count,
+				    ple_window_grow, SHRT_MIN);
+}
 static __init int svm_hardware_setup(void)
 {
 	int cpu;
@@ -1101,6 +1202,8 @@ static __init int svm_hardware_setup(void)
 	} else
 		kvm_disable_tdp();
 
+	update_ple_window_actual_max();
+
 	if (avic) {
 		if (!npt_enabled ||
 		    !boot_cpu_has(X86_FEATURE_AVIC) ||
@@ -1309,7 +1412,11 @@ static void init_vmcb(struct vcpu_svm *svm)
 	svm->vcpu.arch.hflags = 0;
 
 	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
-		control->pause_filter_count = 3000;
+		control->pause_filter_count = pause_filter_count;
+		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
+			control->pause_filter_thresh = pause_filter_thresh;
+		else
+			pause_filter_thresh = 0;
 		set_intercept(svm, INTERCEPT_PAUSE);
 	}
 
@@ -3802,6 +3909,9 @@ static int pause_interception(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	bool in_kernel = (svm_get_cpl(vcpu) == 0);
 
+	if (pause_filter_thresh)
+		grow_ple_window(vcpu);
+
 	kvm_vcpu_on_spin(vcpu, in_kernel);
 	return 1;
 }
@@ -5424,6 +5534,8 @@ static void svm_handle_external_intr(struct kvm_vcpu *vcpu)
 
 static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
+	if (pause_filter_thresh)
+		shrink_ple_window(vcpu);
 }
 
 static inline void avic_post_state_restore(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d1fb7bb..4c4f6b8 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -15,6 +15,7 @@
 #define KVM_DEFAULT_PLE_WINDOW_SHRINK 0
 #define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
 		(INT_MAX / KVM_DEFAULT_PLE_WINDOW_GROW)
+#define KVM_SVM_DEFAULT_PLE_WINDOW_MAX    USHRT_MAX
 
 static inline int __grow_ple_window(int val, int base, int modifier, int max)
 {
-- 
1.8.3.1
