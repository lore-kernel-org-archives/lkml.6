Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeCHVIs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:08:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751248AbeCHVIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:08:47 -0500
Date: Thu, 8 Mar 2018 22:08:04 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH v2 2/3] x86/kvm/hyper-v: remove stale entries from
 vec_bitmap/auto_eoi_bitmap on vector change
Message-ID: <20180308210804.GN12290@flask>
References: <20180301141514.3482-1-vkuznets@redhat.com>
 <20180301141514.3482-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301141514.3482-3-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 15:15+0100, Vitaly Kuznetsov:
> When a new vector is written to SINx we update vec_bitmap/auto_eoi_bitmap
> but we forget to remove old vector from these masks (in case it is not
> present in some other SINTx).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  arch/x86/include/uapi/asm/hyperv.h |  2 ++
>  arch/x86/kvm/hyperv.c              | 32 ++++++++++++++++++++++----------
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> index 197c2e6c7376..62c778a303a1 100644
> --- a/arch/x86/include/uapi/asm/hyperv.h
> +++ b/arch/x86/include/uapi/asm/hyperv.h
> @@ -318,6 +318,8 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
>  #define HV_SYNIC_SINT_COUNT		(16)
>  /* Define the expected SynIC version. */
>  #define HV_SYNIC_VERSION_1		(0x1)
> +/* Valid SynIC vectors are 16-255. */
> +#define HV_SYNIC_FIRST_VALID_VECTOR	(16)
>  
>  #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
>  #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 05f414525538..6d14f808145d 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -74,13 +74,30 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
>  	return false;
>  }
>  
> +static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> +				int vector)
> +{
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return;
> +
> +	if (synic_has_vector_connected(synic, vector))
> +		__set_bit(vector, synic->vec_bitmap);
> +	else
> +		__clear_bit(vector, synic->vec_bitmap);
> +
> +	if (synic_has_vector_auto_eoi(synic, vector))
> +		__set_bit(vector, synic->auto_eoi_bitmap);
> +	else
> +		__clear_bit(vector, synic->auto_eoi_bitmap);
> +}
> +
>  static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
>  			  u64 data, bool host)
>  {
> -	int vector;
> +	int vector, old_vector;
>  
>  	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
> -	if (vector < 16 && !host)
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
>  		return 1;
>  	/*
>  	 * Guest may configure multiple SINTs to use the same vector, so
> @@ -88,18 +105,13 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
>  	 * bitmap of vectors with auto-eoi behavior.  The bitmaps are
>  	 * updated here, and atomically queried on fast paths.
>  	 */
> +	old_vector = synic_read_sint(synic, sint) & HV_SYNIC_SINT_VECTOR_MASK;
>  
>  	atomic64_set(&synic->sint[sint], data);
>  
> -	if (synic_has_vector_connected(synic, vector))
> -		__set_bit(vector, synic->vec_bitmap);
> -	else
> -		__clear_bit(vector, synic->vec_bitmap);
> +	synic_update_vector(synic, old_vector);
> 
> -	if (synic_has_vector_auto_eoi(synic, vector))
> -		__set_bit(vector, synic->auto_eoi_bitmap);
> -	else
> -		__clear_bit(vector, synic->auto_eoi_bitmap);
> +	synic_update_vector(synic, vector);

This looks like it solves the problem when we get two SINTs with the
same vector back-to-back , but shouldn't these bits really be cleared on
EOI (either auto or manual)?

Thanks.
