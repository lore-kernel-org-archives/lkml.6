Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeBVImg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:42:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35387 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeBVIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:42:34 -0500
X-Google-Smtp-Source: AH8x225no/ZWm9cTOL4rKZ3dZHHjx7n4AFESvWibPBYzn04JObgvmjoOOuyNFkP7m9raKm++nmABXQ==
Date: Thu, 22 Feb 2018 09:42:31 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Vikram Sethi <vikrams@codeaurora.org>
Subject: Re: [PATCH] KVM: arm/arm64: No need to zero CNTVOFF in
 kvm_timer_vcpu_put() for VHE
Message-ID: <20180222084231.GA29376@cbox>
References: <1519054687-14405-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519054687-14405-1-git-send-email-shankerd@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shanker,

On Mon, Feb 19, 2018 at 09:38:07AM -0600, Shanker Donthineni wrote:
> In AArch64/AArch32, the virtual counter uses a fixed virtual offset
> of zero in the following situations as per ARMv8 specifications:
> 
> 1) HCR_EL2.E2H is 1, and CNTVCT_EL0/CNTVCT are read from EL2.
> 2) HCR_EL2.{E2H, TGE} is {1, 1}, and either:
>    — CNTVCT_EL0 is read from Non-secure EL0 or EL2.
>    — CNTVCT is read from Non-secure EL0.
> 
> So, no need to zero CNTVOFF_EL2/CNTVOFF for VHE case.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  virt/kvm/arm/arch_timer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 70268c0..86eca324 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -541,9 +541,11 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
>  	 * The kernel may decide to run userspace after calling vcpu_put, so
>  	 * we reset cntvoff to 0 to ensure a consistent read between user
>  	 * accesses to the virtual counter and kernel access to the physical
> -	 * counter.
> +	 * counter of non-VHE case. For VHE, the virtual counter uses a fixed
> +	 * virtual offset of zero, so no need to zero CNTVOFF_EL2 register.
>  	 */
> -	set_cntvoff(0);
> +	if (!has_vhe())
> +		set_cntvoff(0);
>  }
>  
>  /*

I'm okay with this change.  I don't think there's a huge gain here
though.

Marc, any thoughts or concerns?

Thanks,
-Christoffer
