Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FEA2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503399AbfBNWY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:24:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406621AbfBNWY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:24:57 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guPQu-0002wd-CC; Thu, 14 Feb 2019 23:24:40 +0100
Date:   Thu, 14 Feb 2019 23:24:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Jan_H=2E_Sch=F6nherr?= <jan@schnhrr.de>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] x86/tsc: Allow quick PIT calibration despite
 interruptions
In-Reply-To: <20190214214608.8672-1-jan@schnhrr.de>
Message-ID: <alpine.DEB.2.21.1902142320300.1646@nanos.tec.linutronix.de>
References: <20190214214608.8672-1-jan@schnhrr.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1302279153-1550183080=:1646"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1302279153-1550183080=:1646
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Feb 2019, Jan H. Schönherr wrote:

Cc+: Linus (he wrote the original implementation and might have opinions)

> Some systems experience regular interruptions (60 Hz SMI?), that prevent
> the quick PIT calibration from succeeding: individual interruptions can be
> so long, that the PIT MSB is observed to decrement by 2 or 3 instead of 1.
> The existing code cannot recover from this.
> 
> The system in question is an AMD Ryzen Threadripper 2950X, microcode
> 0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.
> 
> Change the code to handle (almost) arbitrary interruptions, as long
> as they happen only once in a while and they do not take too long.
> Specifically, also cover an interruption during the very first reads.
> 
> Signed-off-by: Jan H. Schönherr <jan@schnhrr.de>
> ---
> 
> v2:
> - Dropped the other hacky patch for the time being.
> - Fixed the early exit check.
> - Hopefully fixed all inaccurate math in v1.
> - Extended comments.

That looks halfways sane, but I'm way too tired to wrap my head around
it right now.

Vs. comments: The big comment above pit_verify_msb() needs a big overhaul
as well.

Thanks,

	tglx

Keeping patch for reference.

>  arch/x86/kernel/tsc.c | 91 +++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index e9f777bfed40..aced427371f7 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -485,7 +485,7 @@ static inline int pit_verify_msb(unsigned char val)
>  static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *deltap)
>  {
>  	int count;
> -	u64 tsc = 0, prev_tsc = 0;
> +	u64 tsc = get_cycles(), prev_tsc = 0;
>  
>  	for (count = 0; count < 50000; count++) {
>  		if (!pit_verify_msb(val))
> @@ -500,7 +500,7 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
>  	 * We require _some_ success, but the quality control
>  	 * will be based on the error terms on the TSC values.
>  	 */
> -	return count > 5;
> +	return count > 0 && pit_verify_msb(val - 1);
>  }
>  
>  /*
> @@ -515,7 +515,8 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
>  static unsigned long quick_pit_calibrate(void)
>  {
>  	int i;
> -	u64 tsc, delta;
> +	u64 tsc = 0, delta;
> +	unsigned char start;
>  	unsigned long d1, d2;
>  
>  	if (!has_legacy_pic())
> @@ -547,43 +548,65 @@ static unsigned long quick_pit_calibrate(void)
>  	 */
>  	pit_verify_msb(0);
>  
> -	if (pit_expect_msb(0xff, &tsc, &d1)) {
> -		for (i = 1; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
> -			if (!pit_expect_msb(0xff-i, &delta, &d2))
> -				break;
> -
> -			delta -= tsc;
> -
> -			/*
> -			 * Extrapolate the error and fail fast if the error will
> -			 * never be below 500 ppm.
> -			 */
> -			if (i == 1 &&
> -			    d1 + d2 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11)
> -				return 0;
> -
> -			/*
> -			 * Iterate until the error is less than 500 ppm
> -			 */
> -			if (d1+d2 >= delta >> 11)
> -				continue;
> -
> -			/*
> -			 * Check the PIT one more time to verify that
> -			 * all TSC reads were stable wrt the PIT.
> -			 *
> -			 * This also guarantees serialization of the
> -			 * last cycle read ('d2') in pit_expect_msb.
> -			 */
> -			if (!pit_verify_msb(0xfe - i))
> -				break;
> -			goto success;
> +	/*
> +	 * Reading the PIT may fail or experience unexpected delays (due to
> +	 * SMIs, for example). Assuming, that these underlying interruptions
> +	 * happen only once in a while, we wait for two successful reads.
> +	 * Of these, we assume that the better one was not delayed and use
> +	 * it as the base for later calculations.
> +	 */
> +	for (i = 0; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
> +		if (!pit_expect_msb(0xff - i, &delta, &d2))
> +			continue;
> +
> +		if (!tsc) {
> +			/* first success */
> +			start = i;
> +			tsc = delta;
> +			d1 = d2;
> +			continue;
>  		}
> +
> +		/* second success */
> +		delta -= tsc;
> +		do_div(delta, i - start);
> +		if (d2 < d1) {
> +			start = i;
> +			tsc += delta;
> +			d1 = d2;
> +		}
> +		goto calibrate;
> +	}
> +
> +	pr_info("Fast TSC calibration failed (couldn't even start)\n");
> +	return 0;
> +
> +calibrate:
> +	/*
> +	 * Extrapolate the error based on the better of the first two successes
> +	 * and fail fast if the error will never be below 500 ppm.
> +	 */
> +	if (d1 + d1 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11) {
> +		pr_info("Fast TSC calibration failed (wouldn't work)\n");
> +		return 0;
>  	}
> +
> +	for (i++; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
> +		if (!pit_expect_msb(0xff - i, &delta, &d2))
> +			continue;
> +
> +		delta -= tsc;
> +
> +		/* Stop when the error is less than 500 ppm */
> +		if (d1 + d2 < delta >> 11)
> +			goto success;
> +	}
> +
>  	pr_info("Fast TSC calibration failed\n");
>  	return 0;
>  
>  success:
> +	i -= start;
>  	/*
>  	 * Ok, if we get here, then we've seen the
>  	 * MSB of the PIT decrement 'i' times, and the
> -- 
> 2.19.2
> 
> 
--8323329-1302279153-1550183080=:1646--
