Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59923C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B01E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544569182;
	bh=B9K8JF1KEzLFQkdF+d99IKGOrMfXbxoV91CfNwK6mB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0daczV7cVzY/ALG8vbIENTHVuVufdQ10ui/Owf86/rgmParYkB0j/zKIgZcwQEaII
	 7DCD4/eKyuZUhE6my2buzr7Mxr3zEagZjwbRKwZwK/zdXKCaIvDmv471TdAHEHSsqW
	 cGRAMaBB6NER+np0NREaP0sCXJa9yYErOcEkaZ7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B01E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLKW7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:59:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLKW7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:59:40 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EBBB208E7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544569179;
        bh=B9K8JF1KEzLFQkdF+d99IKGOrMfXbxoV91CfNwK6mB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x+IGJcdpD1VVeRM5WhLODI27IQcV8w7lF+Pb9DlThZ9HXwIToVLYTg/38lhihXWlM
         TnFXBTJHECEN0My4OkliOG8+shHROyb8WtxcJrQXd9FNUS7F7XVK/G4s/jUTa5YpIV
         jPOrUgojPfoieFf9NiLNhzICPo0dVvnBrLueAROg=
Received: by mail-wr1-f47.google.com with SMTP id v13so15799654wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:59:39 -0800 (PST)
X-Gm-Message-State: AA+aEWaweWVQ7TGtLWy/JF+TCOmAMf+j/LVIcWmQIemzk9wQCcxwzc0y
        xeHpD52v60TJmT1hZXziY9vlevym7CxVLg1OIPRXOA==
X-Google-Smtp-Source: AFSGD/UrRpnQz9WkkJFxkTjjCN8B8t+lALFWKj+kZJpCHJjLHxig0zNT/l5VZCZ25wUln4VwRtjosNLSOI2/ViJHu9w=
X-Received: by 2002:a5d:5502:: with SMTP id b2mr15854756wrv.330.1544569178088;
 Tue, 11 Dec 2018 14:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20181211222326.14581-1-bp@alien8.de> <20181211222326.14581-5-bp@alien8.de>
In-Reply-To: <20181211222326.14581-5-bp@alien8.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Dec 2018 14:59:26 -0800
X-Gmail-Original-Message-ID: <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
Message-ID: <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Lutomirski <luto@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:23 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Currently, the kernel uses
>
>   [LM]FENCE; RDTSC
>
> in the timekeeping code, to guarantee monotonicity of time where the
> *FENCE is selected based on vendor.
>
> Replace that sequence with RDTSCP which is faster or on-par and gives
> the same guarantees.
>
> A microbenchmark on Intel shows that the change is on-par.
>
> On AMD, the change is either on-par with the current LFENCE-prefixed
> RDTSC and some are slightly better with RDTSCP.
>
> The comparison is done with the LFENCE-prefixed RDTSC (and not with the
> MFENCE-prefixed one, as one would normally expect) because all modern
> AMD families make LFENCE serializing and thus avoid the heavy MFENCE by
> effectively enabling X86_FEATURE_LFENCE_RDTSC.
>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: x86@kernel.org
> Link: https://lkml.kernel.org/r/20181119184556.11479-1-bp@alien8.de
> ---
>  arch/x86/include/asm/msr.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 91e4cf189914..5cc3930cb465 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -217,6 +217,8 @@ static __always_inline unsigned long long rdtsc(void)
>   */
>  static __always_inline unsigned long long rdtsc_ordered(void)
>  {
> +       DECLARE_ARGS(val, low, high);
> +
>         /*
>          * The RDTSC instruction is not ordered relative to memory
>          * access.  The Intel SDM and the AMD APM are both vague on this
> @@ -227,9 +229,19 @@ static __always_inline unsigned long long rdtsc_ordered(void)
>          * ordering guarantees as reading from a global memory location
>          * that some other imaginary CPU is updating continuously with a
>          * time stamp.
> +        *
> +        * Thus, use the preferred barrier on the respective CPU, aiming for
> +        * RDTSCP as the default.
>          */
> -       barrier_nospec();
> -       return rdtsc();
> +       asm volatile(ALTERNATIVE_3("rdtsc",
> +                                  "mfence; rdtsc", X86_FEATURE_MFENCE_RDTSC,
> +                                  "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
> +                                  "rdtscp", X86_FEATURE_RDTSCP)
> +                       : EAX_EDX_RET(val, low, high)
> +                       /* RDTSCP clobbers ECX with MSR_TSC_AUX. */
> +                       :: "ecx");
> +
> +       return EAX_EDX_VAL(val, low, high);
>  }

This whole series seems reasonable, except that it caused me to look
at barrier_nospec().  And I had a bit of a WTF moment, as in "WTF does
RDTSC have to do with a speculation protection barrier".  Does it
actually make sense?
