Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCNOsO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:48:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeCNOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:48:13 -0400
Date: Wed, 14 Mar 2018 15:48:10 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: jason.vas.dias@gmail.com
cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: Re: [PATCH v4.16-rc5 2/3] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <1521001222-10712-3-git-send-email-jason.vas.dias@gmail.com>
Message-ID: <alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de>
References: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com> <1521001222-10712-3-git-send-email-jason.vas.dias@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, jason.vas.dias@gmail.com wrote:

Again: Read and comply with Documentation/process/ and fix the complaints
of checkpatch.pl.

> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index fbc7371..2c46675 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -184,10 +184,9 @@ notrace static u64 vread_tsc(void)
>  
>  notrace static u64 vread_tsc_raw(void)
>  {
> -	u64 tsc
> +	u64 tsc  = (gtod->has_rdtscp ? rdtscp((void*)0) : rdtsc_ordered())
>  	  , last = gtod->raw_cycle_last;

Aside of the totally broken coding style including usage of (void*)0 :

Did you ever benchmark rdtscp() against rdtsc_ordered()?

If so, then the results want to be documented in the changelog and this
change only makes sense when rdtscp() is actually faster.

Please document how you measured that so others can actually run the same
tests and make their own judgement.

If it would turn out that rdtscp() is faster, which I doubt, then the
conditional is the wrong way to do that. It wants to be patched at boot
time which completely avoids conditionals.

Thanks,

	tglx
