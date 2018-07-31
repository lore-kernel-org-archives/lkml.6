Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3820894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnUe48wC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbeGaXVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbeGaXVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:21:41 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836CA20894
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533073160;
        bh=7XlTnN3TbUIc0Uhq1moS53j+sBrgVUN8b52e2b0dFt4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pnUe48wCnbaDBdC4coc+9n9KwDL6gFTu3HkTZ7ZLDNot1bsAdEAvOYPKtfbtf0uWB
         K9DoGwC1Yj/6DgI8aapXETgFSnGpTU6KZImUyx0erR7eMXq1tpMhCgcBxo86pfjN5e
         QB/Ne8jbZuHWxAbqhRkH9OZUmEn7NLKzZPY7tL3k=
Received: by mail-wm0-f46.google.com with SMTP id y2-v6so4664682wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:39:20 -0700 (PDT)
X-Gm-Message-State: AOUpUlEy0d2cePtcN8+qXtYgnngZYf842sl0ejKQmfpVt4716zdSXyls
        1onGazsYELSB2RT1z0Wf5kBwG1y3dyS+/Pmgcfj0PA==
X-Google-Smtp-Source: AAOMgpfxQ1u09qqMY7ooUNZK45ZsKsk0aE4C3rNsBfB13A0xNDR6JtuOkX7zWjsj/nVwd2Bbsn0lTpyz//lve+/1LTQ=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr863046wmq.36.1533073158945;
 Tue, 31 Jul 2018 14:39:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 14:38:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807312220490.1713@nanos.tec.linutronix.de>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-7-git-send-email-fenghua.yu@intel.com> <2267fbe6-37e8-7063-d48f-1879f31d3258@kernel.org>
 <alpine.DEB.2.21.1807312220490.1713@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 31 Jul 2018 14:38:58 -0700
X-Gmail-Original-Message-ID: <CALCETrUZdbvo+FPrcKP2vbORAZmeaXvMiGm5r6Hxn+3GkSQTdw@mail.gmail.com>
Message-ID: <CALCETrUZdbvo+FPrcKP2vbORAZmeaXvMiGm5r6Hxn+3GkSQTdw@mail.gmail.com>
Subject: Re: [PATCH 6/7] x86/vdso: Add vDSO functions for user wait instructions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 2:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 23 Jul 2018, Andy Lutomirski wrote:
>> On 07/23/2018 05:55 AM, Fenghua Yu wrote:
>> >     static void __init init_vdso_funcs_data(void)
>> >   {
>> > +   struct system_counterval_t sys_counterval;
>> > +
>> >     if (static_cpu_has(X86_FEATURE_MOVDIRI))
>> >             vdso_funcs_data.movdiri_supported = true;
>> >     if (static_cpu_has(X86_FEATURE_MOVDIR64B))
>> >             vdso_funcs_data.movdir64b_supported = true;
>> > +   if (static_cpu_has(X86_FEATURE_WAITPKG))
>> > +           vdso_funcs_data.waitpkg_supported = true;
>> > +   if (static_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
>> > +           vdso_funcs_data.tsc_known_freq = true;
>> > +           sys_counterval = convert_art_ns_to_tsc(1);
>> > +           vdso_funcs_data.tsc_per_nsec = sys_counterval.cycles;
>> > +   }
>>
>> You're losing a ton of precision here.  You might even be losing *all* of the
>> precision and malfunctioning rather badly.
>
> Indeed.
>
>> The correct way to do this is:
>>
>> tsc_counts = ns * mul >> shift;
>
>> and the vclock code illustrates it.
>
> Albeit you cannot use the TSC mult/shift pair as that is for the TSC to
> nsec conversion.
>
> To get the proper mult/shift pair use clocks_calc_mult_shift(). Note that
> the scaled math has an upper limit when using 64 bit variables. You might
> need 128bit scaled math to make it work correctly.
>
>> convert_art_ns_to_tsc() is a bad example because it uses an expensive
>> division operation for no good reason except that no one bothered to
>> optimize it.
>
> Right. It's not a hot path function and it does the job and we would need
> 128bit scaled math to avoid mult overflows.
>
> Aside of that I have no idea why anyone would use convert_art_ns_to_tsc()
> for anything else than converting art to nsecs.
>
>> > +notrace int __vdso_umwait(int state, unsigned long nsec)
>>
>> __vdso_umwait_relative(), please.  Because some day (possibly soon) someone
>> will want __vdso_umwait_absolute() and its friend __vdso_read_art_ns() so they
>> can do:
>>
>> u64 start = __vdso_read_art_ns();
>
> Errm. No. You can't read ART. ART is only used by decives to which it is
> distributed. You can only read TSC here and convert that to nsecs.

Bah.

But my point remains -- I think that the user (non-vDSO) code should
think in nanoseconds, not TSC ticks.  That we have have a much better
chance of getting migration right.

>
>> __vdso_umonitor(...);
>> ... do something potentially slow or that might fault ...
>> __vdso_umwait_absolute(start + timeout);
>
> That definitely requires 128bit scaled math to work correctly, unless you
> make the timeout relative before conversion.
>
> But I really think we should avoid creating yet another interface to
> retrieve TSC time in nsecs. We have enough of these things already.
>
> Ideally we'd use CLOCK_MONOTONIC here, but that needs more thought as:
>
>   1) TSC might be disabled as the timekeeping clocksource
>
>   2) The mult/shift pair for converting to nanoseconds is affected by
>      NTP/PTP so it can be different from the initial mult/shift pair for
>      converting nanoseconds to TSC.
>
> A possible solution would be to use CLOCK_MOTONIC_RAW which is not affected
> by NTP/PTP adjustments. But that still has the issue of TSC not being the
> timekeeping clocksource. Bah, the whole TSC deadline mode sucks. I have no
> idea what's wrong with simple down counters. They Just Work.


I think it's not totally crazy to declare UMWAIT on a system with a
non-TSC clocksource to be unsupported.
