Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeC2QS7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:18:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31733 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeC2QS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:18:58 -0400
Date: Thu, 29 Mar 2018 18:18:38 +0200
Message-ID: <20180329181838.Horde.opfAaSRmEf1pJwACgzIcVg8@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 04/19] powerpc/kvm: Prefer fault_in_pages_readable
 function
References: <20180322202007.23088-5-malat@debian.org>
 <20180328195811.27758-1-malat@debian.org>
In-Reply-To: <20180328195811.27758-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> Directly use fault_in_pages_readable instead of manual __get_user code. Fix
> warning treated as error with W=1:
>
>   arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not  
> used [-Werror=unused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> v2: use fault_in_pages_readable instead
>  arch/powerpc/kernel/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 9ad37f827a97..124c51030b75 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -25,6 +25,7 @@
>  #include <linux/kvm_para.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/pagemap.h>
>
>  #include <asm/reg.h>
>  #include <asm/sections.h>
> @@ -672,14 +673,13 @@ static void kvm_use_magic_page(void)
>  {
>  	u32 *p;
>  	u32 *start, *end;
> -	u32 tmp;
>  	u32 features;
>
>  	/* Tell the host to map the magic page to -4096 on all CPUs */
>  	on_each_cpu(kvm_map_magic_page, &features, 1);
>
>  	/* Quick self-test to see if the mapping works */
> -	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
> +	if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
>  		kvm_patching_worked = false;
>  		return;
>  	}
> --
> 2.11.0
