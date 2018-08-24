Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E620C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009142145D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBgCwSwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009142145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeHXVXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbeHXVXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:23:49 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F7F21477
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535132889;
        bh=sRiH7Dy5I73dG+MsTzXyloD5DJE0ZYp384/dzDRC9B8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LBgCwSwfWC1+Ofrjzr+ewSYJ+QU+dghOamhhXk50CcQCjFJsGXGPCCigBgG+KWWqb
         +CmfBrZ9o1yOzRvzZH3qqWivvB/eZaUl28ab22konEk3fKo575hkG66wMM1MpgvqoL
         zGiIc975D0ZHBzcGojjTbmuzKYeVtCOAJEYpzMx8=
Received: by mail-wm0-f42.google.com with SMTP id 207-v6so2396267wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:48:09 -0700 (PDT)
X-Gm-Message-State: APzg51AjkqiioFJBEQMY8gTi/147k14Wu0oArdBApF8Yr9KByHoJE8bk
        HSLA3PdnfWkp5L1QSeS/sNPOXgANKPkczFZ9e06XnA==
X-Google-Smtp-Source: ANB0VdZHGdb8QiuGGrSty/IHEDKCEj49joeRUjJ1uWxCxuAvEKIUd7l2EV2/gqCRWlS5/C3vHh7/NDVbjZvz79oyQKg=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr1965252wmq.36.1535132888132;
 Fri, 24 Aug 2018 10:48:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 10:47:47 -0700 (PDT)
In-Reply-To: <20180817121251.4EB5318E01A1@virtux64.softrans.com.au>
References: <20180817121251.4EB5318E01A1@virtux64.softrans.com.au>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 24 Aug 2018 10:47:47 -0700
X-Gmail-Original-Message-ID: <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com>
Message-ID: <CALCETrXY=PSdp6mpQ89yBQPsMrDj7j2p8AyLR1o4_+heiMzRbQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
To:     Matt Rickard <matt@softrans.com.au>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nit: if it's not literally a resend, don't call it "RESEND" in
$SUBJECT.  Call it v2, please.

Also, I added LKML and relevant maintainers to cc.  John and Stephen:
this is a purely x86 patch, but it digs into the core timekeeping
structures a bit.

On Fri, Aug 17, 2018 at 5:12 AM, Matt Rickard <matt@softrans.com.au> wrote:
> Process clock_gettime(CLOCK_TAI) in vDSO. This makes the call about as fast as
> CLOCK_REALTIME instead of taking about four times as long.

I'm conceptually okay with this, but the bug encountered last time
around makes me suspect that GCC is generating genuinely horrible
code.  Can you benchmark CLOCK_MONOTONIC before and after to make sure
there isn't a big regression?  Please do this benchmark with
CONFIG_RETPOLINE=y.

If there is a regression, then the code will need some reasonable
restructuring to fix it.  Or perhaps -fno-jump-tables.

--Andy

> Signed-off-by: Matt Rickard <matt@softrans.com.au>
> ---
>  arch/x86/entry/vdso/vclock_gettime.c    | 25 +++++++++++++++++++++++++
>  arch/x86/entry/vsyscall/vsyscall_gtod.c |  2 ++
>  arch/x86/include/asm/vgtod.h            |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index f19856d95c60..91ed1bb2a3bb 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -246,6 +246,27 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
>         return mode;
>  }
>
> +notrace static int __always_inline do_tai(struct timespec *ts)
> +{
> +       unsigned long seq;
> +       u64 ns;
> +       int mode;
> +
> +       do {
> +               seq = gtod_read_begin(gtod);
> +               mode = gtod->vclock_mode;
> +               ts->tv_sec = gtod->tai_time_sec;
> +               ns = gtod->wall_time_snsec;
> +               ns += vgetsns(&mode);
> +               ns >>= gtod->shift;
> +       } while (unlikely(gtod_read_retry(gtod, seq)));
> +
> +       ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> +       ts->tv_nsec = ns;
> +
> +       return mode;
> +}
> +
>  notrace static void do_realtime_coarse(struct timespec *ts)
>  {
>         unsigned long seq;
> @@ -277,6 +298,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
>                 if (do_monotonic(ts) == VCLOCK_NONE)
>                         goto fallback;
>                 break;
> +       case CLOCK_TAI:
> +               if (do_tai(ts) == VCLOCK_NONE)
> +                       goto fallback;
> +               break;
>         case CLOCK_REALTIME_COARSE:
>                 do_realtime_coarse(ts);
>                 break;
> diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
> index e1216dd95c04..d61392fe17f6 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
> @@ -53,6 +53,8 @@ void update_vsyscall(struct timekeeper *tk)
>         vdata->monotonic_time_snsec     = tk->tkr_mono.xtime_nsec
>                                         + ((u64)tk->wall_to_monotonic.tv_nsec
>                                                 << tk->tkr_mono.shift);
> +       vdata->tai_time_sec             = tk->xtime_sec
> +                                       + tk->tai_offset;
>         while (vdata->monotonic_time_snsec >=
>                                         (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
>                 vdata->monotonic_time_snsec -=
> diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
> index fb856c9f0449..adc9f7b20b9c 100644
> --- a/arch/x86/include/asm/vgtod.h
> +++ b/arch/x86/include/asm/vgtod.h
> @@ -32,6 +32,7 @@ struct vsyscall_gtod_data {
>         gtod_long_t     wall_time_coarse_nsec;
>         gtod_long_t     monotonic_time_coarse_sec;
>         gtod_long_t     monotonic_time_coarse_nsec;
> +       gtod_long_t     tai_time_sec;
>
>         int             tz_minuteswest;
>         int             tz_dsttime;
