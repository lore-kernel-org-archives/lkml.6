Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00D820818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00D820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeKIVBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:01:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46562 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIVBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:01:41 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gL4qb-00025s-3E; Fri, 09 Nov 2018 12:21:09 +0100
Date:   Fri, 9 Nov 2018 12:21:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
In-Reply-To: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
Message-ID: <alpine.DEB.2.21.1811091121340.1519@nanos.tec.linutronix.de>
References: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey,

On Thu, 8 Nov 2018, Aubrey Li wrote:

> Subject: .... x86/fpu: detect AVX task

What is an AVX task? I know what you mean, but for the casual reader this
is not very informative. So something like:

  x86/fpu: Track AVX usage of tasks

would be more informative and precise. The mechanism you add is tracking
the state and not just detecting in.

> XSAVES and its variants use init optimization to reduce the amount of
> data that they save to memory during context switch. Init optimization
> uses the state component bitmap to denote if a component is in its init
> configuration. We use this information to detect if a task contains AVX
> instructions.

Please avoid 'We use..'. Changelogs should be factual and precise and not
be written as first-person narrative.

Aside of that, you very well explained how XSAVES optimization works, but
that's only a small part of the picture. The changelog should also contain
a justification why this is necessary in the first place along with more
missing bits and pieces. And please use paragraphs to structure the
changelog instead of having one big lump.

Something like this:

  User space tools which do automated task placement need information about
  AVX usage of tasks, because of <reasons>....

  The extended control register (XCR) allows access to the XINUSE
  state-component bitmap, which allows software to discover the state of
  the init optimization used by XSAVEOPT and XSAVES. Set bits in the bitmap
  denote the usage of AVX, SIMD, FPU and other components. The XSAVE
  variants store only the state of used components to speed up the
  operation.

  The XGETBV instruction, if supported, allows software to read the
  state-component bitmap and use this information to detect the usage of
  the tracked components.

  Add accessor functions and per task state tracking to context switch.

  The tracking turns on the usage flag immediately, but requires 3
  consecutive context switches with no usage to clear it. This decay is
  required because of <reasons>....

You surely had all this information in your head when writing the code and
the changelog, so you could have spared me to dig all this out of the SDM.

> +/*
> + * This function is called during context switch to update AVX component state
> + */
> +static inline void update_avx_state(struct avx_state *avx)
> +{
> +	/*
> +	 * Check if XGETBV with ECX = 1 supported. XGETBV with ECX = 1
> +	 * returns the logical-AND of XCR0 and XINUSE. XINUSE is a bitmap
> +	 * by which the processor tracks the status of various components.
> +	 */
> +	if (!use_xgetbv1()) {
> +		avx->state = 0;

avx->state should be initialized to 0 when the task starts, so why
does it need to be cleared when XGETBV is not supported?

Also this is the only usage site of use_xgetbv1(). So please open code it
here and avoid the extra inline which does not provide any extra value in
this case.

> +		return;
> +	}
> +	/*
> +	 * XINUSE is dynamic to track component state because VZEROUPPER
> +	 * happens on every function end and reset the bitmap to the
> +	 * initial configuration.
> +	 *
> +	 * State decay is introduced to solve the race condition between
> +	 * context switch and a function end. State is aggressively set
> +	 * once it's detected but need to be cleared by decay 3 context
> +	 * switches

I have no idea what _the_ race condition between context switch and a
function end is about. Probably most readers wont have.

> +	 */
> +	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM) {

In the changelog and also in the code you say AVX (avx->state), but this
actually looks only for Hi16_ZMM state, which are the upper 16 AVX512
registers.

So again, this wants to be documented in the changelog along with an
explanation WHY this check is restricted to Hi16_ZMM state. And please
rename the variable accordingly. This is confusing at best.

> +		avx->state = 1;
> +		avx->decay_count = AVX_STATE_DECAY_COUNT;
> +	} else {
> +		if (avx->decay_count)
> +			avx->decay_count--;
> +		else
> +			avx->state = 0;
> +	}

Is there a reason why you need two variables for this?

	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM)
		tsk->hi16zmm_usage = HI16ZMM_DECAY_COUNT;
	else if (tsk->hi16zmm_usage)
		tsk->hi16zmm_usage--;

and the function which exposes it later to user space can just check
whether tsk->hi16zmm_usage is 0 or not.

This is context switch and we really want to avoid every pointless
instruction we can.

Thanks,

	tglx
