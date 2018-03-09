Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbeCISNT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:13:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932131AbeCISNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:13:17 -0500
Date: Fri, 9 Mar 2018 19:12:33 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Cc: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
 SVM
Message-ID: <20180309181233.GO12290@flask>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
 <1520007456-85293-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520007456-85293-4-git-send-email-babu.moger@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 11:17-0500, Babu Moger:
> Bring the PLE(pause loop exit) logic to AMD svm driver.
> We have noticed it help in situations where numerous pauses are generated
> due to spinlock or other scenarios. Tested it with idle=poll and noticed
> pause interceptions go down considerably.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kvm/svm.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.h |   1 +
>  2 files changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 50a4e95..30bc851 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -263,6 +263,55 @@ struct amd_svm_iommu_ir {
>  static bool npt_enabled;
>  #endif
>  
> +/*
> + * These 2 parameters are used to config the controls for Pause-Loop Exiting:
> + * pause_filter_thresh: On processors that support Pause filtering(indicated
> + *	by CPUID Fn8000_000A_EDX), the VMCB provides a 16 bit pause filter
> + *	count value. On VMRUN this value is loaded into an internal counter.
> + *	Each time a pause instruction is executed, this counter is decremented
> + *	until it reaches zero at which time a #VMEXIT is generated if pause
> + *	intercept is enabled. Refer to  AMD APM Vol 2 Section 15.14.4 Pause
> + *	Intercept Filtering for more details.
> + *	This also indicate if ple logic enabled.
> + *
> + * pause_filter_count: In addition, some processor families support advanced

The comment has thresh/count flipped.

> + *	pause filtering (indicated by CPUID Fn8000_000A_EDX) upper bound on
> + *	the amount of time a guest is allowed to execute in a pause loop.
> + *	In this mode, a 16-bit pause filter threshold field is added in the
> + *	VMCB. The threshold value is a cycle count that is used to reset the
> + *	pause counter. As with simple pause filtering, VMRUN loads the pause
> + *	count value from VMCB into an internal counter. Then, on each pause
> + *	instruction the hardware checks the elapsed number of cycles since
> + *	the most recent pause instruction against the pause filter threshold.
> + *	If the elapsed cycle count is greater than the pause filter threshold,
> + *	then the internal pause count is reloaded from the VMCB and execution
> + *	continues. If the elapsed cycle count is less than the pause filter
> + *	threshold, then the internal pause count is decremented. If the count
> + *	value is less than zero and PAUSE intercept is enabled, a #VMEXIT is
> + *	triggered. If advanced pause filtering is supported and pause filter
> + *	threshold field is set to zero, the filter will operate in the simpler,
> + *	count only mode.
> + */
> +
> +static int pause_filter_thresh = KVM_DEFAULT_PLE_GAP;
> +module_param(pause_filter_thresh, int, S_IRUGO);

I think it was a mistake to put signed values in VMX ...
Please use unsigned variants and also properly sized.
(The module param type would be "ushort" instead of "int".)

> +static int pause_filter_count = KVM_DEFAULT_PLE_WINDOW;
> +module_param(pause_filter_count, int, S_IRUGO);

We are going to want a different default for pause_filter_count, because
they have a different meaning.  On Intel, it's the number of cycles, on
AMD, it's the number of PAUSE instructions.

The AMD's 3k is a bit high in comparison to Intel's 4k, but I'd keep 3k
unless we have other benchmark results.

> +static int ple_window_grow = KVM_DEFAULT_PLE_WINDOW_GROW;

The naming would be nicer with a consistent prefix.  We're growing
pause_filter_count, so pause_filter_count_grow is easier to understand.
(Albeit unwieldy.)

> +module_param(ple_window_grow, int, S_IRUGO);

(This is better as unsigned too ... VMX should have had that.)

> @@ -1046,6 +1095,58 @@ static int avic_ga_log_notifier(u32 ga_tag)
>  	return 0;
>  }
>  
> +static void grow_ple_window(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct vmcb_control_area *control = &svm->vmcb->control;
> +	int old = control->pause_filter_count;
> +
> +	control->pause_filter_count = __grow_ple_window(old,
> +							pause_filter_count,
> +							ple_window_grow,
> +							ple_window_actual_max);
> +
> +	if (control->pause_filter_count != old)
> +		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> +
> +	trace_kvm_ple_window_grow(vcpu->vcpu_id,
> +				  control->pause_filter_count, old);

Please move the tracing into __shrink_ple_window to share the code.
This probably belongs to patch [2/3].

> +/*
> + * ple_window_actual_max is computed to be one grow_ple_window() below
> + * ple_window_max. (See __grow_ple_window for the reason.)
> + * This prevents overflows, because ple_window_max is int.
> + * ple_window_max effectively rounded down to a multiple of ple_window_grow in
> + * this process.
> + * ple_window_max is also prevented from setting control->pause_filter_count <
> + * pause_filter_count.
> + */
> +static void update_ple_window_actual_max(void)
> +{
> +	ple_window_actual_max =
> +		__shrink_ple_window(max(ple_window_max, pause_filter_count),

(I have no idea what I was thinking when I wrote that for VMX. :[
 I'll write a patch to get rid of ple_window_actual_max, because its
 benefits are really minuscule and the logic is complicated.)

> +				    pause_filter_count,
> +				    ple_window_grow, SHRT_MIN);
> +}
>  static __init int svm_hardware_setup(void)
>  {
>  	int cpu;
> @@ -1309,7 +1412,11 @@ static void init_vmcb(struct vcpu_svm *svm)
>  	svm->vcpu.arch.hflags = 0;
>  
>  	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
> -		control->pause_filter_count = 3000;
> +		control->pause_filter_count = pause_filter_count;
> +		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
> +			control->pause_filter_thresh = pause_filter_thresh;
> +		else
> +			pause_filter_thresh = 0;

Please move this to hardware_setup and also clear pause_filter_count if
X86_FEATURE_PAUSEFILTER is not present.

>  		set_intercept(svm, INTERCEPT_PAUSE);

The intercept should then be disabled iff pause_filter_count == 0.

The functionality looks correct,

thanks!
