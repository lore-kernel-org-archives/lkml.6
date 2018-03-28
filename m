Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeC1UZE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752318AbeC1UZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:25:02 -0400
Date: Wed, 28 Mar 2018 22:24:57 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Cc: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: VMX: Remove ple_window_actual_max
Message-ID: <20180328202457.GI26753@flask>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
 <1521232646-79580-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521232646-79580-3-git-send-email-babu.moger@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 16:37-0400, Babu Moger:
> Get rid of ple_window_actual_max, because its benefits are really
> minuscule and the logic is complicated.
> 
> The overflows(and underflow) are controlled in __ple_window_grow
> and _ple_window_shrink respectively.
> 
> Suggested-by: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kvm/vmx.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> @@ -178,7 +178,6 @@
>  module_param(ple_window_shrink, uint, 0444);
>  
>  /* Default is to compute the maximum so we can never overflow. */
> -static uint ple_window_actual_max = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
>  static uint ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
>  module_param(ple_window_max, uint, 0444);
>  
> @@ -6645,14 +6644,12 @@ static uint __grow_ple_window(uint val)
>  	if (ple_window_grow < 1)
>  		return ple_window;
>  
> -	val = min(val, ple_window_actual_max);
> -
>  	if (ple_window_grow < ple_window)
>  		val *= ple_window_grow;
>  	else
>  		val += ple_window_grow;
>  
> -	return val;
> +	return min(val, ple_window_max);

I added a bit of logic to avoid wraparounds.
