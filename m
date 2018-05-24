Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935773AbeEXUEh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:04:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:33176 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935330AbeEXUEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:04:34 -0400
Date: Thu, 24 May 2018 15:03:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] powerpc: Implement csum_ipv6_magic in assembly
Message-ID: <20180524200350.GG17342@gate.crashing.org>
References: <7a756b816161007903ca8b28aec662de27135c55.1527161282.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a756b816161007903ca8b28aec662de27135c55.1527161282.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me (one comment below):

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

On Thu, May 24, 2018 at 11:33:18AM +0000, Christophe Leroy wrote:
> +_GLOBAL(csum_ipv6_magic)
> +	lwz	r8, 0(r3)
> +	lwz	r9, 4(r3)
> +	addc	r0, r7, r8
> +	lwz	r10, 8(r3)
> +	adde	r0, r0, r9
> +	lwz	r11, 12(r3)
> +	adde	r0, r0, r10
> +	lwz	r8, 0(r4)
> +	adde	r0, r0, r11
> +	lwz	r9, 4(r4)
> +	adde	r0, r0, r8
> +	lwz	r10, 8(r4)
> +	adde	r0, r0, r9
> +	lwz	r11, 12(r4)
> +	adde	r0, r0, r10
> +	add	r5, r5, r6	/* assumption: len + proto doesn't carry */
> +	adde	r0, r0, r11
> +	adde	r0, r0, r5
> +	addze	r0, r0
> +	rotlwi	r3, r0, 16
> +	add	r3, r0, r3
> +	not	r3, r3
> +	rlwinm	r3, r3, 16, 16, 31
> +	blr
> +EXPORT_SYMBOL(csum_ipv6_magic)
> diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
> index d7f1a966136e..bf0546e546fc 100644
> --- a/arch/powerpc/lib/checksum_64.S
> +++ b/arch/powerpc/lib/checksum_64.S
> @@ -429,3 +429,31 @@ dstnr;	stb	r6,0(r4)
>  	stw	r6,0(r8)
>  	blr
>  EXPORT_SYMBOL(csum_partial_copy_generic)
> +
> +/*
> + * __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> + *			   const struct in6_addr *daddr,
> + *			   __u32 len, __u8 proto, __wsum sum)
> + */
> +
> +_GLOBAL(csum_ipv6_magic)
> +	ld	r8, 0(r3)
> +	ld	r9, 8(r3)
> +	add	r5, r5, r6
> +	addc	r0, r8, r9
> +	ld	r10, 0(r4)
> +	ld	r11, 8(r4)
> +	adde	r0, r0, r10
> +	add	r5, r5, r7
> +	adde	r0, r0, r11
> +	adde	r0, r0, r5
> +	addze	r0, r0
> +	rotldi  r3 ,r0, 32		/* fold two 32 bit halves together */

Typo (s/ ,/, /).

> +	add	r3, r0, r3
> +	srdi	r0, r3, 32
> +	rotlwi	r3, r0, 16		/* fold two 16 bit halves together */
> +	add	r3, r0, r3
> +	not	r3, r3
> +	rlwinm	r3, r3, 16, 16, 31
> +	blr
> +EXPORT_SYMBOL(csum_ipv6_magic)
> -- 
> 2.13.3
