Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4CEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C6521479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pACAayBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C6521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKUTRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUTRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:17:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEC220989;
        Wed, 21 Nov 2018 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542789806;
        bh=8mSO5fKus+S0K5O8ffeykVg1dZVgcnOowTRh+lBQrC0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pACAayBLaG+xZx0NRB/MK3NQhazlO8435l0VzxOtm4QUwM4fuFXRQtcoaizpKxnUJ
         T+eSPmFAHyvQd/WWtkEm7QKJGHOq06RFb7cocR3mQ/mfTu4wq/IBsNTjwuoXhGYJse
         sTrQwJS7Iz4xYylX4F2FJp02XNhBmndZQWAonyz0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c1eff982-c7f3-5095-1a82-2ae9afe20b4c@sifive.com>
Cc:     Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
 <20181020135024.28573-2-paul.walmsley@sifive.com>
 <154045364470.53599.7774255558661483303@swboyd.mtv.corp.google.com>
 <c1eff982-c7f3-5095-1a82-2ae9afe20b4c@sifive.com>
Message-ID: <154278980575.88331.16504895003109700312@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] clk: analogbits: add Wide-Range PLL library
Date:   Wed, 21 Nov 2018 00:43:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2018-11-08 17:01:54)
> On 10/25/18 12:47 AM, Stephen Boyd wrote:
> > Quoting Paul Walmsley (2018-10-20 06:50:22)
> >> diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/ana=
logbits/wrpll-cln28hpc.c
> >> new file mode 100644
> >> index 000000000000..ebdef859cbf5
> >> --- /dev/null
> >> +++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
> >> @@ -0,0 +1,387 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 SiFive, Inc.
> >> + * Wesley Terpstra
> >> + * Paul Walmsley
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> > Can you drop these two paragraphs? It's duplicated from the SPDX tag.
> =

> =

> Yep, fixed.
> =

> =

> >> + * This library supports configuration parsing and reprogramming of
> >> + * the CLN28HPC variant of the Analog Bits Wide Range PLL.  The
> >> + * intention is for this library to be reusable for any device that
> >> + * integrates this PLL; thus the register structure and programming
> >> + * details are expected to be provided by a separate IP block driver.
> >> + *
> >> + * The bulk of this code is primarily useful for clock configurations
> >> + * that must operate at arbitrary rates, as opposed to clock configur=
ations
> >> + * that are restricted by software or manufacturer guidance to a smal=
l,
> >> + * pre-determined set of performance points.
> >> + *
> >> + * References:
> >> + * - Analog Bits "Wide Range PLL Datasheet", version 2015.10.01
> >> + * - SiFive FU540-C000 Manual v1p0, Chapter 7 "Clocking and Reset"
> > Any html links?
> =

> =

> The Analog Bits datasheet is not available on-line, to my knowledge.=C2=
=A0
> The comments in this driver are an attempt to document it for software
> developers.
> =

> =

> The SiFive datasheet is available online; just added a link to the commen=
ts.

Ok.

> =

> =

> >> + */
> >> +
> >> +#include <linux/bug.h>
> > Is this used?
> =

> =

> Yes - the library doesn't compile without it:

Alright.

> =

> =

> >> +#include <linux/err.h>
> >> +#include <linux/log2.h>
> >> +#include <linux/math64.h>
> >> +#include <linux/clk/analogbits-wrpll-cln28hpc.h>
> >> +
> >> +/* MIN_INPUT_FREQ: minimum input clock frequency, in Hz (Fref_min) */
> >> +#define MIN_INPUT_FREQ                 7000000
> >> +
> >> +/* MAX_INPUT_FREQ: maximum input clock frequency, in Hz (Fref_max) */
> >> +#define MAX_INPUT_FREQ                 600000000
> >> +
> >> +/* MIN_POST_DIVIDE_REF_FREQ: minimum post-divider reference frequency=
, in Hz */
> >> +#define MIN_POST_DIVR_FREQ             7000000
> >> +
> >> +/* MAX_POST_DIVIDE_REF_FREQ: maximum post-divider reference frequency=
, in Hz */
> >> +#define MAX_POST_DIVR_FREQ             200000000
> >> +
> >> +/* MIN_VCO_FREQ: minimum VCO frequency, in Hz (Fvco_min) */
> >> +#define MIN_VCO_FREQ                   2400000000UL
> >> +
> >> +/* MAX_VCO_FREQ: maximum VCO frequency, in Hz (Fvco_max) */
> >> +#define MAX_VCO_FREQ                   4800000000ULL
> >> +
> >> +/* MAX_DIVQ_DIVISOR: maximum output divisor.  Selected by DIVQ =3D 6 =
*/
> >> +#define MAX_DIVQ_DIVISOR               64
> >> +
> >> +/* MAX_DIVR_DIVISOR: maximum reference divisor.  Selected by DIVR =3D=
 63 */
> >> +#define MAX_DIVR_DIVISOR               64
> >> +
> >> +/* MAX_LOCK_US: maximum PLL lock time, in microseconds (tLOCK_max) */
> >> +#define MAX_LOCK_US                    70
> >> +
> >> +/*
> >> + * ROUND_SHIFT: number of bits to shift to avoid precision loss in th=
e rounding
> >> + *              algorithm
> >> + */
> >> +#define ROUND_SHIFT                    20
> >> +
> >> +/*
> >> + * Private functions
> >> + */
> >> +
> >> +/**
> >> + * __wrpll_calc_filter_range() - determine PLL loop filter bandwidth
> >> + * @post_divr_freq: input clock rate after the R divider
> >> + *
> >> + * Select the value to be presented to the PLL RANGE input signals, b=
ased
> >> + * on the input clock frequency after the post-R-divider @post_divr_f=
req.
> >> + * This code follows the recommendations in the PLL datasheet for fil=
ter
> >> + * range selection.
> >> + *
> >> + * Return: The RANGE value to be presented to the PLL configuration i=
nputs,
> >> + *         or -1 upon error.
> >> + */
> >> +static int __wrpll_calc_filter_range(unsigned long post_divr_freq)
> >> +{
> >> +       u8 range;
> >> +
> >> +       if (post_divr_freq < MIN_POST_DIVR_FREQ ||
> >> +           post_divr_freq > MAX_POST_DIVR_FREQ) {
> >> +               WARN(1, "%s: post-divider reference freq out of range:=
 %lu",
> >> +                    __func__, post_divr_freq);
> >> +               return -1;
> >> +       }
> >> +
> >> +       if (post_divr_freq < 11000000)
> >> +               range =3D 1;
> >> +       else if (post_divr_freq < 18000000)
> >> +               range =3D 2;
> >> +       else if (post_divr_freq < 30000000)
> >> +               range =3D 3;
> >> +       else if (post_divr_freq < 50000000)
> >> +               range =3D 4;
> >> +       else if (post_divr_freq < 80000000)
> >> +               range =3D 5;
> >> +       else if (post_divr_freq < 130000000)
> >> +               range =3D 6;
> >> +       else
> >> +               range =3D 7;
> >> +
> >> +       return range;
> >> +}
> >> +
> >> +/**
> >> + * __wrpll_calc_fbdiv() - return feedback fixed divide value
> >> + * @c: ptr to a struct analogbits_wrpll_cfg record to read from
> >> + *
> >> + * The internal feedback path includes a fixed by-two divider; the
> >> + * external feedback path does not.  Return the appropriate divider
> >> + * value (2 or 1) depending on whether internal or external feedback
> >> + * is enabled.  This code doesn't test for invalid configurations
> >> + * (e.g. both or neither of WRPLL_FLAGS_*_FEEDBACK are set); it relies
> >> + * on the caller to do so.
> >> + *
> >> + * Context: Any context.  Caller must protect the memory pointed to by
> >> + *          @c from simultaneous modification.
> > Would that ever be needed? Presumably the flag isn't changing.
> =

> =

> It's just another way of writing that the caller needs to lock the data
> pointed to by c against simultaneous modification, freeing, etc.=C2=A0
> Ideally this would be obvious to callers by virtue of the pointer being
> passed, but figured there was no harm in explicitly stating it.=C2=A0 Let=
 me
> know if you want me to remove the comment.

Hmm ok. Doesn't hurt so no need to change.
> =

> =

> >> +       }
> >> +
> >> +       s =3D div_u64(MAX_VCO_FREQ, target_rate);
> >> +       if (s <=3D 1) {
> >> +               divq =3D 1;
> >> +               *vco_rate =3D MAX_VCO_FREQ;
> >> +       } else if (s > MAX_DIVQ_DIVISOR) {
> >> +               divq =3D ilog2(MAX_DIVQ_DIVISOR);
> >> +               *vco_rate =3D MIN_VCO_FREQ;
> >> +       } else {
> >> +               divq =3D ilog2(s);
> >> +               *vco_rate =3D target_rate << divq;
> >> +       }
> >> +
> >> +wcd_out:
> >> +       return divq;
> >> +}
> >> +
> >> +/**
> >> + * __wrpll_update_parent_rate() - update PLL data when parent rate ch=
anges
> >> + * @c: ptr to a struct analogbits_wrpll_cfg record to write PLL data =
to
> >> + * @parent_rate: PLL input refclk rate (pre-R-divider)
> >> + *
> >> + * Pre-compute some data used by the PLL configuration algorithm when
> >> + * the PLL's reference clock rate changes.  The intention is to avoid
> >> + * computation when the parent rate remains constant - expected to be
> >> + * the common case.
> >> + *
> >> + * Returns: 0 upon success or -1 if the reference clock rate is out o=
f range.
> >> + */
> >> +static int __wrpll_update_parent_rate(struct analogbits_wrpll_cfg *c,
> >> +                                     unsigned long parent_rate)
> >> +{
> >> +       u8 max_r_for_parent;
> > Does this need to be a u8? It makes the min_t below required instead of
> > using an unsigned int.
> =

> =

> I've changed this as you request, and added the (subsequently required)
> type suffix to the macro value, along with an appropriate comment.
> =

> =

> >> +
> >> +       if (parent_rate > MAX_INPUT_FREQ || parent_rate < MIN_POST_DIV=
R_FREQ)
> >> +               return -1;
> > Please pick some valid error code instead of -1 (I thought checkpatch
> > complained about this?). =

> =

> =

> checkpatch isn't complaining here.=C2=A0 Anyway, fixed to return a reason=
able
> error code.

Ok. I must be remembering some never upstreamed checkpatch patch, ouch!

> =

> =

> > Is this case even possible?
> =

> =

> If analogbits_wrpll_configure_for_rate() is called with a parent_rate
> outside of the PLL's specification range, it seems reasonable to fail --
> or do you see the situation differently?=C2=A0 These parent rate restrict=
ions
> are defined in the PLL datasheet.

I've been pushing driver writers to use clk_hw_set_rate_range() so that
the core framework will clamp the frequency to what is supported. Can
you somehow use that for these clks?

> =

> =

> >  It would be nicer
> > if this function just returned void.
> =

> =

> =C2=A0Is it that you'd prefer the rate check to be moved into
> analogbits_wrpll_configure_for_rate()?=C2=A0 Or that you'd prefer that I =
not
> validate the input parent rate at all?

I lost the context! But I think I'm just saying that if the clamping is
done in the core framework with limits then this function can just
return void because there aren't errors to be had.

> =

> =

> >> +
> >> +       c->_parent_rate =3D parent_rate;
> >> +       max_r_for_parent =3D div_u64(parent_rate, MIN_POST_DIVR_FREQ);
> >> +       c->_max_r =3D min_t(u8, MAX_DIVR_DIVISOR, max_r_for_parent);
> >> +
> >> +       /* Round up */
> >> +       c->_init_r =3D div_u64(parent_rate + MAX_POST_DIVR_FREQ - 1,
> >> +                            MAX_POST_DIVR_FREQ);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +/*
> >> + * Public functions
> >> + */
> >> +
> >> +/**
> >> + * analogbits_wrpll_configure() - compute PLL configuration for a tar=
get rate
> >> + * @c: ptr to a struct analogbits_wrpll_cfg record to write into
> >> + * @target_rate: target PLL output clock rate (post-Q-divider)
> >> + * @parent_rate: PLL input refclk rate (pre-R-divider)
> >> + *
> >> + * Given a pointer to a PLL context @c, a desired PLL target output
> >> + * rate @target_rate, and a reference clock input rate @parent_rate,
> >> + * compute the appropriate PLL signal configuration values.  PLL
> >> + * reprogramming is not glitchless, so the caller should switch any
> >> + * downstream logic to a different clock source or clock-gate it
> >> + * before presenting these values to the PLL configuration signals.
> >> + *
> >> + * The caller must pass this function a pre-initialized struct
> >> + * analogbits_wrpll_cfg record: either initialized to zero (with the
> >> + * exception of the .name and .flags fields) or read from the PLL.
> >> + *
> >> + * Context: Any context.  Caller must protect the memory pointed to b=
y @c
> >> + *          from simultaneous access or modification.
> >> + *
> >> + * Return: 0 upon success; anything else upon failure.
> >> + */
> >> +int analogbits_wrpll_configure_for_rate(struct analogbits_wrpll_cfg *=
c,
> >> +                                       u32 target_rate,
> >> +                                       unsigned long parent_rate)
> >> +{
> >> +       unsigned long ratio;
> >> +       u64 target_vco_rate, delta, best_delta, f_pre_div, vco, vco_pr=
e;
> >> +       u32 best_f, f, post_divr_freq, fbcfg;
> >> +       u8 fbdiv, divq, best_r, r;
> >> +
> >> +       if (!c)
> >> +               return -1;
> > -EINVAL? Of course, it's probably better to just not care and blow up if
> > the user of the API passes in NULL.
> =

> =

> Agreed for statically-scoped functions it's most likely overkill.=C2=A0 B=
ut
> for globally-scoped functions like this, it seemed better to catch the
> errors rather than to blow up. The underlying approach was intended to
> be standard precondition-based (paranoia-based?) development.=C2=A0 Seems
> like I often screw up the calling side during development, so figured
> this approach would save human time.=C2=A0 The performance impact seems
> minimal.=C2=A0 That said, if it's your strong preference or requirement f=
or
> these to be dropped, I will of course do it - let me know.

I would still prefer to remove it. It's a semi-global API that's really
only used and exported by clk providers. We should expect an oops and
big callstack/crash if some driver author is using the API improperly.
Hopefully those developers are testing their code, and they see that
it's experiencing problems here. So the calling side screwing up during
development will very quickly realize they're doing something wrong vs.
noticing later that some clk is not there.

> =

> =

> In the meantime, have changed the return value to -EINVAL per your commen=
t.

Ok!

> =

> =

> >> +
> >> +       if (c->flags =3D=3D 0) {
> >> +               WARN(1, "%s called with uninitialized PLL config", __f=
unc__);
> > Do we really need the stacktrace in this case? Or can this be downgraded
> > to a pr_warn() and return some error value that isn't -1?
> =

> =

> Since this case should never happen, and indicates either a bug in the
> code or corrupted memory, the intention was to warn loudly so it was
> difficult to be ignore.=C2=A0 So I would prefer to keep it annoying.=C2=
=A0 But
> again, if it's important, would be OK with changing it - let me know.=C2=
=A0
> Usually I try to be more paranoid with the globally-scoped functions
> (like this one) than with the file-local functions.
> =

> =

> >> +               return -1;
> >> +       }
> >> +
> >> +       fbcfg =3D WRPLL_FLAGS_INT_FEEDBACK_MASK | WRPLL_FLAGS_EXT_FEED=
BACK_MASK;
> >> +       if ((c->flags & fbcfg) =3D=3D fbcfg) {
> >> +               WARN(1, "%s called with invalid PLL config", __func__);
> >> +               return -1;
> >> +       }
> >> +
> >> +       if (c->flags =3D=3D WRPLL_FLAGS_EXT_FEEDBACK_MASK) {
> >> +               WARN(1, "%s: external feedback mode not currently supp=
orted",
> >> +                    __func__);
> >> +               return -1;
> >> +       }
> > Like a bunch of this stuff, why are we checking things that the caller
> > should know to do itself? I'd prefer we keep things simple and assume
> > the caller knows what they're doing.
> =

> =

> My thinking was that it's easy to screw up if someone is unfamiliar with
> the library.=C2=A0 Since the preconditions are computationally simple to
> verify, the runtime cost is essentially zero.=C2=A0 Put differently, they=
 are
> intended to trade off a small amount of CPU time to save a larger amount
> of human time.
> =


Can we move the checks to build time with some macro that defines the
configuration structure and has BUILD_BUG_ON() checks? Sure it doesn't
have much runtime overhead, but it has a codesize overhead and mental
logic overhead for something that would be better served with some
static check or documentation/comments and code review. Put another way,
it's not like this configuration is coming from random user input and so
we need to validate the input to make sure it's sane. We can validate
the input when merging the code or when building the code and avoid this
all.

> =

> =

> >> +}
> >> diff --git a/include/linux/clk/analogbits-wrpll-cln28hpc.h b/include/l=
inux/clk/analogbits-wrpll-cln28hpc.h
> >> new file mode 100644
> >> index 000000000000..cc4268f16067
> >> --- /dev/null
> >> +++ b/include/linux/clk/analogbits-wrpll-cln28hpc.h
> >> +
> >> +/**
> >> + * struct analogbits_wrpll_cfg - WRPLL configuration values
> >> + * @divr: reference divider value (6 bits), as presented to the PLL s=
ignals.
> >> + * @divf: feedback divider value (9 bits), as presented to the PLL si=
gnals.
> >> + * @divq: output divider value (3 bits), as presented to the PLL sign=
als.
> >> + * @flags: PLL configuration flags.  See above for more information.
> >> + * @range: PLL loop filter range.  See below for more information.
> >> + * @_output_rate_cache: cached output rates, swept across DIVQ.

Drop the full-stops on here too please.

> >> + * @_parent_rate: PLL refclk rate for which values are valid
> >> + * @_max_r: maximum possible R divider value, given @parent_rate
> >> + * @_init_r: initial R divider value to start the search from
> >> + *
> >> + * @divr, @divq, @divq, @range represent what the PLL expects to see
> >> + * on its input signals.  Thus @divr and @divf are the actual divisors
> >> + * minus one.  @divq is a power-of-two divider; for example, 1 =3D
> >> + * divide-by-2 and 6 =3D divide-by-64.  0 is an invalid @divq value.
> >> + *
> >> + * When initially passing a struct analogbits_wrpll_cfg record, the
> >> + * record should be zero-initialized with the exception of the @flags
> >> + * field.  The only flag bits that need to be set are either
> >> + * WRPLL_FLAGS_INT_FEEDBACK or WRPLL_FLAGS_EXT_FEEDBACK.
> >> + *
> >> + * Field names beginning with an underscore should be considered
> >> + * private to the wrpll-cln28hpc.c code.
> > Ah ok. Are the functions also done this way for a private/public API
> > split. =

> =

> =

> Yep.

Ok.

> =

> =

> > We don't typically care about this in the kernel, just mark it
> > static if it's private and non-static if it's public for functions.
> =

> =

> Used to do it this way a long ago, perhaps a bit less incompetently -
> here's an example:
> =

> =

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/mach-omap2/omap_hwmod.c?h=3Dv4.1#n383
> =

> =

> I personally prefer the explicit indication that the identifier was
> scoped file-local in the calling functions.=C2=A0 But am fine changing it=
 per
> your comments, and have done so.

Ok. I haven't really seen the underscores, except for in the cases when
some framework API needs to be split into some backend multi-plexing
function to handle different options while keeping the original function
signature around. Put another way, it's not a kernel idiom for driver
code, but I'm not too worried about it, so go with your own style if it
makes you happy.

> =

> =

> > And for struct members we have
> > kernel doc 'private' tag that can tell users to not do something. Or
> > worst case, an opaque pointer is stored and only defined in the C file.
> =

> =

> In any case, I've changed the identifier names to align to your comments.

Ok. Please also use the private tag to indicate that these are internal
things that shouldn't be used.

> =

> =

> >> + */
> >> +struct analogbits_wrpll_cfg {
> >> +       u8 divr;
> >> +       u8 divq;
> >> +       u8 range;
> >> +       u8 flags;
> >> +       u16 divf;
> >> +       u32 _output_rate_cache[DIVQ_VALUES];
> >> +       unsigned long _parent_rate;
> >> +       u8 _max_r;
> >> +       u8 _init_r;
> >> +};
> >> +
> >> +/*
> >> + * Function prototypes
> >> + */
> > Please don't have these types of comments. They don't help.
> =

> =

> Dropped this one.=C2=A0 Do you want me to nuke the similar comments in
> wrpll-cln28hpc.c, separating the private function section from the
> public functions, for example?
> =


Yes.

