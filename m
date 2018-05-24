Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161243AbeEXT7c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:59:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:39691 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967926AbeEXT7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:59:31 -0400
Date: Thu, 24 May 2018 14:58:40 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Optimise __csum_partial()
Message-ID: <20180524195840.GF17342@gate.crashing.org>
References: <484bcfaccc1ec3d91b74aeaaa26a0ae66fe0955a.1527160868.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484bcfaccc1ec3d91b74aeaaa26a0ae66fe0955a.1527160868.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:22:27AM +0000, Christophe Leroy wrote:
> Improve __csum_partial by interleaving loads and adds.
> 
> On a 8xx, it brings neither improvement nor degradation.
> On a 83xx, it brings a 25% improvement.

Thanks!  Looks fine to me.

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

> ---
>  arch/powerpc/lib/checksum_32.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index d2238ea82209..aa224069f93a 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -47,16 +47,25 @@ _GLOBAL(__csum_partial)
>  	bdnz	2b
>  21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
>  	beq	3f
> +	lwz	r0,4(r3)
>  	mtctr	r6
> -22:	lwz	r0,4(r3)
>  	lwz	r6,8(r3)
> +	adde	r5,r5,r0
>  	lwz	r7,12(r3)
> +	adde	r5,r5,r6
>  	lwzu	r8,16(r3)
> +	adde	r5,r5,r7
> +	bdz	23f
> +22:	lwz	r0,4(r3)
> +	adde	r5,r5,r8
> +	lwz	r6,8(r3)
>  	adde	r5,r5,r0
> +	lwz	r7,12(r3)
>  	adde	r5,r5,r6
> +	lwzu	r8,16(r3)
>  	adde	r5,r5,r7
> -	adde	r5,r5,r8
>  	bdnz	22b
> +23:	adde	r5,r5,r8
>  3:	andi.	r0,r4,2
>  	beq+	4f
>  	lhz	r0,4(r3)
> -- 
> 2.13.3
