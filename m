Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeEQN0d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:26:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39572 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeEQN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:26:32 -0400
X-Google-Smtp-Source: AB8JxZqx/XfVVoPNvVFeQlOWdGOev9uA6QxhtZwNnlFb7adE7Inr5+fi/i4kEjTgrztqIL+JljSSqQ==
Date: Thu, 17 May 2018 23:26:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/lib: Remove .balign inside string functions for
 PPC32
Message-ID: <20180517231938.4b1b8172@roar.ozlabs.ibm.com>
In-Reply-To: <20180517100413.856096F938@po14934vm.idsi0.si.c-s.fr>
References: <20180517100413.856096F938@po14934vm.idsi0.si.c-s.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 12:04:13 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> commit 87a156fb18fe1 ("Align hot loops of some string functions")
> degraded the performance of string functions by adding useless
> nops
> 
> A simple benchmark on an 8xx calling 100000x a memchr() that
> matches the first byte runs in 41668 TB ticks before this patch
> and in 35986 TB ticks after this patch. So this gives an
> improvement of approx 10%
> 
> Another benchmark doing the same with a memchr() matching the 128th
> byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
> after this patch, so regardless on the number of loops, removing
> those useless nops improves the test by 5683 TB ticks.
> 
> Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  Was sent already as part of a serie optimising string functions.
>  Resending on itself as it is independent of the other changes in the
> serie
> 
>  arch/powerpc/lib/string.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
> index a787776822d8..a026d8fa8a99 100644
> --- a/arch/powerpc/lib/string.S
> +++ b/arch/powerpc/lib/string.S
> @@ -23,7 +23,9 @@ _GLOBAL(strncpy)
>  	mtctr	r5
>  	addi	r6,r3,-1
>  	addi	r4,r4,-1
> +#ifdef CONFIG_PPC64
>  	.balign 16
> +#endif
>  1:	lbzu	r0,1(r4)
>  	cmpwi	0,r0,0
>  	stbu	r0,1(r6)

The ifdefs are a bit ugly, but you can't argue with the numbers. These
alignments should be IFETCH_ALIGN_BYTES, which is intended to optimise
the ifetch performance when you have such a loop (although there is
always a tradeoff for a single iteration).

Would it make sense to define that for 32-bit as well, and you could use
it here instead of the ifdefs? Small CPUs could just use 0.

Thanks,
Nick
