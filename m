Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeDKOCw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:02:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:16071 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753258AbeDKOCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:02:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="215793631"
Message-ID: <1523455369.20087.16.camel@intel.com>
Subject: Re: [PATCH] X86/KVM: Do not allow DISABLE_EXITS_MWAIT when LAPIC
 ARAT is not available
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Date: Wed, 11 Apr 2018 07:02:49 -0700
In-Reply-To: <1523438163-768-1-git-send-email-karahmed@amazon.de>
References: <1523438163-768-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 11:16 +0200, KarimAllah Ahmed wrote:
> If the processor does not have an "Always Running APIC Timer" (aka ARAT),
> we should not give guests direct access to MWAIT. The LAPIC timer would
> stop ticking in deep C-states, so any host deadlines would not wakeup the
> host kernel.
> 
> The host kernel intel_idle driver handles this by switching to broadcast
> mode when ARAT is not available and MWAIT is issued with a deep C-state
> that would stop the LAPIC timer. When MWAIT is passed through, we can not
> tell when MWAIT is issued.
> 
> So just disable this capability when LAPIC ARAT is not available. I am not
> even sure if there are any CPUs with VMX support but no LAPIC ARAT or not.

ARAT was added on WSM, so NHM, the Core 2 family and a few PSC SKUs
support VMX+MWAIT but not ARAT.  

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Wanpeng Li <kernellwp@gmail.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b2ff74b..0334b25 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2819,7 +2819,8 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
>  static inline bool kvm_can_mwait_in_guest(void)
>  {
>  	return boot_cpu_has(X86_FEATURE_MWAIT) &&
> -		!boot_cpu_has_bug(X86_BUG_MONITOR);
> +		!boot_cpu_has_bug(X86_BUG_MONITOR) &&
> +		boot_cpu_has(X86_FEATURE_ARAT);
>  }
>  
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
