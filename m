Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B274C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999E620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d0TFVOpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999E620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeK3KLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:11:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37015 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3KLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:11:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so3298710lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMeapazcCq4K2PTu43rTSG3C2FOHd+Oww9LxG20Pe2k=;
        b=d0TFVOpoJGG9Z//1y5eaJlkSG7j01yWruLJXUnis4VXitO1gsQjvOLzMtoz4sA4UY6
         5311RXnHx+vQWFJDlUHIkxA8kWU1e/+EHXC63odI6eqTRxsajnzwuplA2Y1sx2FVKTv0
         75BxUviFTEZtxXbsw4BBSCB8ZQrvFZ8phnD0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMeapazcCq4K2PTu43rTSG3C2FOHd+Oww9LxG20Pe2k=;
        b=JIljjfekTIPgLp6H4K+yJJcsjyc+p4wEtK6Yim+4l88BMMvQKimm84maNPm2kvQsCq
         efbrksZnuVrEMFg5vcIOppsb1Wko4xsQJ7bMnxskFKja/nKCqfbAWtXGqmJggZyhNClb
         azaMWX2eOjvQMaYrRTbU6w84UoFp67tu1Lse5SiDwFFVKfYUGqE5JP00U4bqw9C0gzTu
         yv+/s9J5iNwwxnKwwZWGgDYc2Vv0+cMtPLiTvMs1usTRlolb72Ii+TlfIQ5MV+6uAGTf
         ghlbjtCueAN1joiFrsVLsgw4peg7jWcl2O7D8UxWr0NHGu/9ylcM+FRcn6wd3EVCd39f
         aE+Q==
X-Gm-Message-State: AA+aEWZgUmy/MLuSwOIiYJL1oqLjywZeyg9UVkwPM/iAjRQRKv7mqxmh
        EFcVU+VTTjGxjvcH5EpaJ1+Hl1/tn0g=
X-Google-Smtp-Source: AFSGD/UgU69RsuH70AEz9BZrtW6EIYhQgY+r29vnOV13hEbTzqn3Fw/JHmpSWsGcUREwYA1K8+UtEA==
X-Received: by 2002:a2e:2019:: with SMTP id g25-v6mr2208936ljg.20.1543532678709;
        Thu, 29 Nov 2018 15:04:38 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w193sm521488lff.24.2018.11.29.15.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:04:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id p6so2748705lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:04:37 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr2355333lfc.147.1543532677388;
 Thu, 29 Nov 2018 15:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20181129121307.12393c57@gandalf.local.home> <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com> <20181129202452.56f4j2wdct6qbaqo@treble>
In-Reply-To: <20181129202452.56f4j2wdct6qbaqo@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 15:04:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiO87jDPP8FZ7EfwfbFNQRdr64Pa+g33do7tKiTFYz8BA@mail.gmail.com>
Message-ID: <CAHk-=wiO87jDPP8FZ7EfwfbFNQRdr64Pa+g33do7tKiTFYz8BA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:25 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Nov 29, 2018 at 11:27:00AM -0800, Andy Lutomirski wrote:
> >
> > I propose a different solution:
> >
> > As in this patch set, we have a direct and an indirect version.  The
> > indirect version remains exactly the same as in this patch set.  The
> > direct version just only does the patching when all seems well: the
> > call instruction needs to be 0xe8, and we only do it when the thing
> > doesn't cross a cache line.  Does that work?  In the rare case where
> > the compiler generates something other than 0xe8 or crosses a cache
> > line, then the thing just remains as a call to the out of line jmp
> > trampoline.  Does that seem reasonable?  It's a very minor change to
> > the patch set.
>
> Maybe that would be ok.  If my math is right, we would use the
> out-of-line version almost 5% of the time due to cache misalignment of
> the address.

Note that I don't think cache-line alignment is necessarily sufficient.

The I$ fetch from the cacheline can happen in smaller chunks, because
the bus between the I$ and the instruction decode isn't a full
cacheline (well, it is _now_ in modern big cores, but it hasn't always
been).

So even if the cacheline is updated atomically, I could imagine seeing
a partial fetch from the I$ (old values) and then a second partial
fetch (new values).

It would be interesting to know what the exact fetch rules are.

             Linus
