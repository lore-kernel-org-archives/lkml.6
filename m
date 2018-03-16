Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCPM3O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:29:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751546AbeCPM3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:29:11 -0400
Subject: Re: [PATCH] KVM: x86: Fix device passthrough when SME is active
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180308231731.27881.84826.stgit@tlendack-t1.amdoffice.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <505b4128-2336-7d81-791a-6e95acdd2a62@redhat.com>
Date: Fri, 16 Mar 2018 13:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308231731.27881.84826.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 00:17, Tom Lendacky wrote:
> When using device passthrough with SME active, the MMIO range that is
> mapped for the device should not be mapped encrypted.  Add a check in
> set_spte() to insure that a page is not mapped encrypted if that page
> is a device MMIO page as indicated by kvm_is_mmio_pfn().
> 
> Cc: <stable@vger.kernel.org> # 4.14.x-
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kvm/mmu.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index f551962..763bb3b 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -2770,8 +2770,10 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  	else
>  		pte_access &= ~ACC_WRITE_MASK;
>  
> +	if (!kvm_is_mmio_pfn(pfn))
> +		spte |= shadow_me_mask;
> +
>  	spte |= (u64)pfn << PAGE_SHIFT;
> -	spte |= shadow_me_mask;
>  
>  	if (pte_access & ACC_WRITE_MASK) {
>  
> 

No, I'm applying it.

Paolo
