Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427438AbeCBMRs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:17:48 -0500
Received: from ozlabs.org ([103.22.144.67]:44577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423042AbeCBMRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:17:44 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: boot: add strrchr function
In-Reply-To: <20180301152654.29275-1-robh@kernel.org>
References: <20180301152654.29275-1-robh@kernel.org>
Date: Fri, 02 Mar 2018 23:17:41 +1100
Message-ID: <87h8pywu1m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> libfdt gained a new dependency on strrchr, so copy the implementation
> from lib/string.c. Most of the string functions are in assembly, but
> stdio.c already has strnlen, so add strrchr there.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. This is a dependency for dtc/libfdt sync with upstream.

Yeah seems fine. At some point we should try and duplicate less code in
boot, but now is not that time.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
> index a701261b1781..98042eff7b26 100644
> --- a/arch/powerpc/boot/stdio.c
> +++ b/arch/powerpc/boot/stdio.c
> @@ -21,6 +21,16 @@ size_t strnlen(const char * s, size_t count)
>  	return sc - s;
>  }
>  
> +char *strrchr(const char *s, int c)
> +{
> +	const char *last = NULL;
> +	do {
> +		if (*s == (char)c)
> +			last = s;
> +	} while (*s++);
> +	return (char *)last;
> +}
> +
>  #ifdef __powerpc64__
>  
>  # define do_div(n, base) ({						\
> -- 
> 2.14.1
