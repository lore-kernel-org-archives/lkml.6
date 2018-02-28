Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeB1Gyt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:54:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53326 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeB1Gyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:54:47 -0500
X-Google-Smtp-Source: AH8x225/AxaWNVL3uMBmGDhNfF/gnchFMRHJ1rGbl4QXhz90RvA/JJU3LRmcoG7ZHfLSg55IGEz0Uw==
Subject: Re: [PATCH RESEND v5 1/2] KVM: X86: Introduce kvm_get_msr_feature()
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38179d9e-537a-f002-a98d-5b48b10a4ea9@redhat.com>
Date: Wed, 28 Feb 2018 07:54:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2018 07:03, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Introduce kvm_get_msr_feature() to handle the msrs which are supported 
> by different vendors and sharing the same emulation logic.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d4985a9..efc8554 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1062,13 +1062,25 @@ static u32 msr_based_features[] = {
>  
>  static unsigned int num_msr_based_features;
>  
> +static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
> +{
> +	switch (msr->index) {
> +	default:
> +		if (kvm_x86_ops->get_msr_feature(msr))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
>  {
>  	struct kvm_msr_entry msr;
> +	int r;
>  
>  	msr.index = index;
> -	if (kvm_x86_ops->get_msr_feature(&msr))
> -		return 1;
> +	r = kvm_get_msr_feature(&msr);
> +	if (r)
> +		return r;
>  
>  	*data = msr.data;
>  
> @@ -4538,7 +4550,7 @@ static void kvm_init_msr_list(void)
>  		struct kvm_msr_entry msr;
>  
>  		msr.index = msr_based_features[i];
> -		if (kvm_x86_ops->get_msr_feature(&msr))
> +		if (kvm_get_msr_feature(&msr))
>  			continue;
>  
>  		if (j < i)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
