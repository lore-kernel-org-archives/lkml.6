Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936282AbeCBLwc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:52:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934748AbeCBLw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:52:27 -0500
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix guest time accounting with
 VIRT_CPU_ACCOUNTING_GEN
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>,
        David Gibson <david@gibson.dropbear.id.au>
References: <20180302105156.19506-1-lvivier@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba4aa266-ce9e-cafc-d9bb-8a6686d9e97c@redhat.com>
Date: Fri, 2 Mar 2018 12:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302105156.19506-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 11:51, Laurent Vivier wrote:
> Since commit 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing
> for signals on guest entry"), if CONFIG_VIRT_CPU_ACCOUNTING_GEN is set, the
> guest time is not accounted to guest time and user time, but instead to
> system time.
> 
> This is because guest_enter()/guest_exit() are called while interrupts
> are disabled and the tick counter cannot be updated between them.
> 
> To fix that, move guest_exit() after local_irq_enable(), and as
> guest_enter() is called with IRQ disabled, calls guest_enter_irqoff()
> instead.
> 
> Fixes: 8b24e69fc47e
> ("KVM: PPC: Book3S HV: Close race with testing for signals on guest entry")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  arch/powerpc/kvm/book3s_hv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 89707354c2ef..8274c2807202 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2885,7 +2885,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
>  	 */
>  	trace_hardirqs_on();
>  
> -	guest_enter();
> +	guest_enter_irqoff();
>  
>  	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
>  
> @@ -2893,8 +2893,6 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
>  
>  	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
>  
> -	guest_exit();
> -
>  	trace_hardirqs_off();
>  	set_irq_happened(trap);
>  
> @@ -2937,6 +2935,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
>  	kvmppc_set_host_core(pcpu);
>  
>  	local_irq_enable();
> +	guest_exit();
>  
>  	/* Let secondaries go back to the offline loop */
>  	for (i = 0; i < controlled_threads; ++i) {
> 
