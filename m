Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D879C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73B62152F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTHS5TSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73B62152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbeHOAKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbeHOAKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:10:12 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5E3215EA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534281668;
        bh=PuY4qKSdNkcCDqFgQjKzPQ/keyA7vyJTftCvH+qoPhg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rTHS5TSwl2ZepNTe8hIQk9xuRJ1eNkER34Z0hUwiB491L2k8z7qFyF0aQhiXQTeZ4
         jhHRT+TiySLAXaFkFxI4ajTPZvknqT9yHFvGuNOm6mcxPDrQs+hRrorveB9/F5S0wi
         fM1bk+7GTTj+QZ6lzQsbu1n6kNdHK18zyiQ9/JAY=
Received: by mail-wm0-f42.google.com with SMTP id n11-v6so13529002wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:21:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlHD6vQRLVy6BJbZN0IUi6xOpgg0mcpAUmqx8X/bRRwq2386pFzU
        B/xnOqonJUlaUbSvFAAWwyXLYPuYE8KfOfbvVoI3Ag==
X-Google-Smtp-Source: AA+uWPz1GZh2adgqGnRfMdYRYNyZ6Hd7WOt0WBC7ZJP9ULFTxWJNVzv8iQMoB2yZC2j6FysAbSoHBlHA5xTlb91uTA4=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr11406646wmq.36.1534281666149;
 Tue, 14 Aug 2018 14:21:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 14:20:45 -0700 (PDT)
In-Reply-To: <1534264248.6862.23.camel@infradead.org>
References: <20180814011732.075EA6E0251@virtux32.softrans.com.au>
 <CALCETrWP41MRGVT7oYoP5_f3jdh5nEvKmDrYuHWwsRgUZCGf=w@mail.gmail.com> <1534264248.6862.23.camel@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 Aug 2018 14:20:45 -0700
X-Gmail-Original-Message-ID: <CALCETrX2tPRGfyzLgnT_usWGZ-3PA_dzx_i85t7M-0S9cKYZrg@mail.gmail.com>
Message-ID: <CALCETrX2tPRGfyzLgnT_usWGZ-3PA_dzx_i85t7M-0S9cKYZrg@mail.gmail.com>
Subject: Re: [PATCH] Handle clock_gettime(CLOCK_TAI) in VDSO
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 9:30 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2018-08-14 at 07:20 -0700, Andy Lutomirski wrote:
>> > +       /* Doubled switch statement to work around kernel Makefile error */
>> > +       /* See: https://www.mail-archive.com/gcc-bugs@gcc.gnu.org/msg567499.html */
>>
>> NAK.
>>
>> The issue here (after reading that thread) is that, with our current
>> compile options, gcc generates a jump table once the switch statement
>> hits five entries.  And it uses retpolines for it, and somehow it
>> generates the relocations in such a way that the vDSO build fails.
>> We
>> need to address this so that the vDSO build is reliable, but there's
>> an important question here:
>>
>> Should the vDSO be built with retpolines, or should it be built with
>> indirect branches?  Or should we go out of our way to make sure that
>> the vDSO contains neither retpolines nor indirect branches?
>>
>> We could accomplish the latter (sort of) by manually converting the
>> switch into the appropriate if statements, but that's rather ugly.
>>
>> (Hmm.  We should add exports to directly read each clock source.
>> They'll be noticeably faster, especially when
>> cache-and-predictor-code.)
>
> Surely it's kind of expected that the vDSO can't find an externally
> provided __x86_indirect_thunk_rax symbol, since we only provide one as
> part of the kernel image.
>
> Building the vDSO with -mindirect-branch=thunk(|-inline) should fix
> that, if we want retpolines in the vDSO.

I think that, if we want retpolines in the kernel, we probably want
them in the vDSO as well.  Although there's an argument to be made
that IBPB gives enough protection, at least against most targets.

>
> There's also -fno-jump-tables.

I'll probably do this, conditioned on CONFIG_RETPOLINE.  Or we should
do it kernel-wide.

hjl filed https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86952 based on
my comment in the other bug report.  gcc seems to be generating jump
tables when it shouldn't be doing so.
