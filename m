Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeC1Uam (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:30:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeC1Uak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:30:40 -0400
Date: Wed, 28 Mar 2018 22:30:37 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Cc: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] KVM: SVM: Implement pause loop exit logic in SVM
Message-ID: <20180328203036.GK26753@flask>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
 <1521232646-79580-6-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521232646-79580-6-git-send-email-babu.moger@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 16:37-0400, Babu Moger:
> Bring the PLE(pause loop exit) logic to AMD svm driver.
> 
> While testing, we found this helping in situations where numerous
> pauses are generated. Without these patches we could see continuos
> VMEXITS due to pause interceptions. Tested it on AMD EPYC server with
> boot parameter idle=poll on a VM with 32 vcpus to simulate extensive
> pause behaviour. Here are VMEXITS in 10 seconds interval.
> 
> #VMEXITS 	Before the change  After the change
> Pauses                  810199                  504
> Total                   882184                  325415
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> @@ -1046,6 +1094,42 @@ static int avic_ga_log_notifier(u32 ga_tag)
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
> +							pause_filter_count_grow,
> +							pause_filter_count_max);
> +
> +	if (control->pause_filter_count != old)
> +		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> +
> +	trace_kvm_ple_window_grow(vcpu->vcpu_id,
> +				  control->pause_filter_count, old);
> +}
> +
> +static void shrink_ple_window(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct vmcb_control_area *control = &svm->vmcb->control;
> +	int old = control->pause_filter_count;
> +
> +	control->pause_filter_count =
> +				__shrink_ple_window(old,
> +						    pause_filter_count,
> +						    pause_filter_count_shrink,
> +						    0);

I've used pause_filter_count as minumum here as well and in all patches
used 'unsigned int' instead of 'uint' in the code too match the rest of
the kernel.

The series is in kvm/queue, please look at the changes and tell me if
you'd like something done differently, thanks.
