Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427411AbeCBMRV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:17:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53860 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423042AbeCBMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:17:16 -0500
Date: Fri, 2 Mar 2018 13:16:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Avoid paravirtualization calls in
 native_set_p4d()
In-Reply-To: <20180228150022.88560-1-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803021309020.1803@nanos.tec.linutronix.de>
References: <20180228150022.88560-1-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Kirill A. Shutemov wrote:

> p4d_val() and pgd_val() are paravirtualized and we should avoid using
> them in native_set_p4d().

I'm really unhappy with your changelogs.

... and we should avoid ....

Should is not strong enough as it leaves the option to not do it.

Aside of that you fail (again) to explain the WHY. Something like this:

native_set_p4d() uses p4d_val() and pgd_val() to do ".....". Both functions
are paravirtualized which is wrong because it brings paravirtualization
into the native implementation resulting in "$problem".

> Let's replace them with native_p4d_val() and native_pgd_val().

Let's? Just say:

Replace them with native_p4d_val() and native_pgd_val().

Documentation/process/... explains it really well change logs have to be
written in imperative mood.

Thanks,

	tglx

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Fixes: 91f606a8fa68 ("x86/mm: Replace compile-time checks for 5-level paging with runtime-time checks")
> ---
>  arch/x86/include/asm/pgtable_64.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> index 81dda8d1d0bd..163e01a0631d 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -224,9 +224,9 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
>  		return;
>  	}
>  
> -	pgd = native_make_pgd(p4d_val(p4d));
> +	pgd = native_make_pgd(native_p4d_val(p4d));
>  	pgd = pti_set_user_pgd((pgd_t *)p4dp, pgd);
> -	*p4dp = native_make_p4d(pgd_val(pgd));
> +	*p4dp = native_make_p4d(native_pgd_val(pgd));
>  }
>  
>  static inline void native_p4d_clear(p4d_t *p4d)
> -- 
> 2.16.1
> 
> 
