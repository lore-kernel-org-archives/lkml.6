Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCKSBr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 14:01:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44655 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbeCKSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 14:01:46 -0400
Date: Sun, 11 Mar 2018 11:01:35 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andi <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.16-rc4 1/1] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <d10bglsa.fsf@gmail.com>
Message-ID: <alpine.DEB.2.21.1803111048360.3841@nanos.tec.linutronix.de>
References: <d10bglsa.fsf@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2018, Jason Vas Dias wrote:

This looks better now. Though running that patch through checkpatch.pl
results in:

total: 28 errors, 20 warnings, 139 lines checked

....

> +notrace static u64 vread_tsc_raw(void)

Why do you need a separate function? I asked you to use vread_tsc(). So you
might have reasons for doing that, but please then explain WHY and not just
throw the stuff in my direction w/o any comment.

> +{
> +        u64 tsc, last=gtod->raw_cycle_last;
> +        if( likely( gtod->has_rdtscp ) ) {
> +                u32     tsc_lo, tsc_hi,
> +                        tsc_cpu __attribute__((unused));
> +                asm volatile
> +                ( "rdtscp"
> +                /* ^- has built-in cancellation point / pipeline stall "barrier" */
> +                : "=a" (tsc_lo)
> +                , "=d" (tsc_hi)
> +                , "=c" (tsc_cpu)
> +                ); // since all variables 32-bit, eax, edx, ecx used - NOT rax, rdx, rcx                 
> +                tsc      = ((((u64)tsc_hi) & 0xffffffffUL) << 32) | (((u64)tsc_lo) & 0xffffffffUL);

This is not required to make the vdso accessor for monotonic raw work.

If at all then the rdtscp support wants to be in a separate patch with a
proper explanation.

Aside of that the code for rdtscp wants to be in a proper inline helper in
the relevant header file and written according to the coding style the
kernel uses for asm inlines.

> +        } else {
> +                tsc      = rdtsc_ordered();
> +        }
> +	if (likely(tsc >= last))
> +		return tsc;        
> +        asm volatile ("");                                
> +        return last;
> +}

The rest looks ok.

Thanks,

	tglx
