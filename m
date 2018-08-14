Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13010C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA2D2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os22xq/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA2D2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbeHNRIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbeHNRIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:08:07 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C282170E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534256443;
        bh=f2loqOJwSQjH8jS8t1kKbLuFIlAx56YU92UfBIRQX4A=;
        h=In-Reply-To:References:From:Date:Subject:To:From;
        b=Os22xq/CjONRaJjuTK9sJfom1m5E3j8RqlXTgJdsQVnJYZyhAp7/3oc7VXJTsbnKC
         cdOIlTiUeFUkuIsrfoZyYgDJ7UVfa6P2OKIrT6QZ4RynfFThklYSvoBC0ItRtUhlI6
         QsFyOO4Pf67s4217nVtNeAO3YGqpJ7rDnKbh/Ens=
Received: by mail-wr1-f54.google.com with SMTP id j5-v6so17359790wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 07:20:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlH8i8GZeaPLxmxczgwq/6opKMfbk2x7xpGmUXaIpPRoDjEnSYmc
        HhI2j45AZQ6rxZMxqXtd+VapZHGTx7jYtX5WOx4RYg==
X-Google-Smtp-Source: AA+uWPzJD5BlnlHp9Awrpm/CHb6adFOyRa72FJ8bhCGQ7hIFC8IUEoPdJOQBMU2rH5YHBZLdmOW2UIluY6cRcI1xJAU=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr2948992wrh.148.1534256442224;
 Tue, 14 Aug 2018 07:20:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 07:20:20 -0700 (PDT)
In-Reply-To: <20180814011732.075EA6E0251@virtux32.softrans.com.au>
References: <20180814011732.075EA6E0251@virtux32.softrans.com.au>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 Aug 2018 07:20:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWP41MRGVT7oYoP5_f3jdh5nEvKmDrYuHWwsRgUZCGf=w@mail.gmail.com>
Message-ID: <CALCETrWP41MRGVT7oYoP5_f3jdh5nEvKmDrYuHWwsRgUZCGf=w@mail.gmail.com>
Subject: Re: [PATCH] Handle clock_gettime(CLOCK_TAI) in VDSO
To:     Matt Rickard <matt@softrans.com.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added a whole bunch of ccs]

On Mon, Aug 13, 2018 at 6:17 PM, Matt Rickard <matt@softrans.com.au> wrote:
> Process clock_gettime(CLOCK_TAI) in VDSO. This makes the call about as fast as
> CLOCK_REALTIME instead of taking about four times as long.
>
> Signed-off-by: Matt Rickard <matt@softrans.com.au>
> ---
>  arch/x86/entry/vdso/vclock_gettime.c    | 30 ++++++++++++++++++++++++++++++
>  arch/x86/entry/vsyscall/vsyscall_gtod.c |  2 ++
>  arch/x86/include/asm/vgtod.h            |  1 +
>  3 files changed, 33 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index f19856d95c60..bc8d8f086721 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c

...

>  notrace static void do_realtime_coarse(struct timespec *ts)
>  {
>         unsigned long seq;
> @@ -284,8 +305,17 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
>                 do_monotonic_coarse(ts);
>                 break;
>         default:
> +       /* Doubled switch statement to work around kernel Makefile error */
> +       /* See: https://www.mail-archive.com/gcc-bugs@gcc.gnu.org/msg567499.html */

NAK.

The issue here (after reading that thread) is that, with our current
compile options, gcc generates a jump table once the switch statement
hits five entries.  And it uses retpolines for it, and somehow it
generates the relocations in such a way that the vDSO build fails.  We
need to address this so that the vDSO build is reliable, but there's
an important question here:

Should the vDSO be built with retpolines, or should it be built with
indirect branches?  Or should we go out of our way to make sure that
the vDSO contains neither retpolines nor indirect branches?

We could accomplish the latter (sort of) by manually converting the
switch into the appropriate if statements, but that's rather ugly.

(Hmm.  We should add exports to directly read each clock source.
They'll be noticeably faster, especially when
cache-and-predictor-code.)
