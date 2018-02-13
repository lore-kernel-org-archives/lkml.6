Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934247AbeBMQMs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:12:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934056AbeBMQMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:12:46 -0500
Subject: Re: [PATCH v4 3/3] KVM: X86: Don't use PV TLB flush with dedicated
 vCPUs and steal time disabled
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
References: <1518483942-14741-1-git-send-email-wanpengli@tencent.com>
 <1518483942-14741-4-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d890ee61-19b6-bb38-607b-f9e547b7a35b@redhat.com>
Date: Tue, 13 Feb 2018 17:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518483942-14741-4-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2018 02:05, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> vCPUs are very unlikely to get preempted when they are the only task
> running on a CPU.  PV TLB flush is slower that the native flush in that
> case. In addition, avoid traversing all the cpus for pv tlb flush when
> steal time is disabled since pv tlb flush depends on the field in steal
> time for shared data.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kernel/kvm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index c5566d9..285822f 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -545,7 +545,9 @@ static void __init kvm_guest_init(void)
>  		pv_time_ops.steal_clock = kvm_steal_clock;
>  	}
>  
> -	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH))
> +	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
> +		!kvm_para_has_feature(KVM_HINTS_DEDICATED) &&
> +		!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
>  		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> @@ -638,7 +640,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
>  {
>  	int cpu;
>  
> -	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH)) {
> +	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
> +		!kvm_para_has_feature(KVM_HINTS_DEDICATED) &&

This should have checked the hints word.

In general, I'm going to change in the whole series
kvm_hint_has_feature with kvm_para_has_hint, and kvm_arch_hint_features
with kvm_arch_para_hints.  But apart from this small naming issue, the
series looks good, and I'm applying it to kvm/queue.

Paolo

> +		!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>  		for_each_possible_cpu(cpu) {
>  			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
>  				GFP_KERNEL, cpu_to_node(cpu));
> 
