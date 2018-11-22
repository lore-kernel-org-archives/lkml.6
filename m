Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7509420838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SNwb6U/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7509420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392087AbeKWDnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:43:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32870 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388916AbeKWDnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:43:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so6981116lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugR/pBl3KdQ6ZcHhkbBykzrhgV4zZJ3qFIxPsTa39cg=;
        b=SNwb6U/zcindOVTotPf3EMMg4asOprrHbqhg+8b/S9xsBDT9gF6ls3MQtGCrd0l9mh
         p58J+rRwQqG6Zz+OxOVDviInIMzacJTS5cYqmZ2/K3VD255LRO4He9SbqFwwCikGbheX
         BCNl/8qamdc6bfT5AII5/AmJxYZcB7Wvb++Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugR/pBl3KdQ6ZcHhkbBykzrhgV4zZJ3qFIxPsTa39cg=;
        b=FQohw0RgRZfatlrO6s5OJRmDaR3sKmDloDyfUtZGnMOFPRj9FZYxT8rLt1SPJ+tg7b
         lCdgzwvOyYxkh6U1WbLWkfOm7Z8foSBfYphf2EW1mgD0gX2ztYgg2Vnmrfrzt2R2bbSI
         V1/46WbkVhObd/dPd8uwVwtccMsLVzrXAAFe7J+T1Xfa+m4F7PURxtQGj0+lCKi1tL0u
         N56S0zzOggO+YjUkIIdhZ3hu7seE0nsXFVyY+3/xfgyIa9ADNubOtIJYqbYiPckNwdfI
         rlmlyeBj1bffs/Ig/3w54aE8CfXj+hFSD4vDcOMYTz7I09/Rf7w2ayGi+xXVMy0kN3Yi
         QshA==
X-Gm-Message-State: AGRZ1gIMTgnMBX7QtDHb2uDwdRKqbfh3kf8sa0Wzt93ATu6ocruVMyOl
        ehjQk/Lm+UIZC2FE3qVBg7YuxWQdA67dFw==
X-Google-Smtp-Source: AJdET5eSKj+gy0HxGFMM3iHtoEUl+tdBLvikbPGbexs1rqijRmt4+0UqkMsazHQ8B1QCpV88AKV3SA==
X-Received: by 2002:a19:2b54:: with SMTP id r81mr7333335lfr.34.1542906162335;
        Thu, 22 Nov 2018 09:02:42 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7643724ljg.56.2018.11.22.09.02.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:02:42 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id s5-v6so8515022ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:02:41 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr7242500ljh.59.1542905767057;
 Thu, 22 Nov 2018 08:56:07 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
 <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com> <20181122103231.GA102790@gmail.com>
In-Reply-To: <20181122103231.GA102790@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 08:55:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG=hvKnsRByogG_7Pwwi+7UQ1AK52m5bTp9dUHhAOzfw@mail.gmail.com>
Message-ID: <CAHk-=wjG=hvKnsRByogG_7Pwwi+7UQ1AK52m5bTp9dUHhAOzfw@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     pabeni@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 2:32 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Random patch (with my "asm goto" hack included) attached, in case
> > people want to play with it.
>
> Doesn't even look all that hacky to me. Any hack in it that I didn't
> notice? :-)

The code to use asm goto sadly doesn't have any fallback at all for
the "no asm goto available".

I guess we're getting close to "we require asm goto support", but I
don't think we're there yet.

Also, while "unsafe_put_user()" has been converted to use asm goto
(and yes, it really does generate much nicer code), the same is not
true of "unsafe_get_user()". Because sadly, gcc does not support asm
goto with output values.

So, realistically, my patch is not _technically_ hacky, but it's
simply not viable as things stand, and it's more of a tech
demonstration than anything else.

               Linus
