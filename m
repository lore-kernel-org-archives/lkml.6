Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C73C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC212146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a0nGlItL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC212146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeK3GSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:18:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42189 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3GSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:18:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so2289731lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/bNQ/Pc62g0EcD7cXiKa8ldbAv3wQfSSnIXm2IFY8c=;
        b=a0nGlItLf2VKnsAMa6aV2E2lbBHIExa/sSj99eIgQ6x++vx2EbUufGLFGv8okwNz71
         ffZGPE8WVYZrb5cQPCA/h1rYedX4vxhlVjsiiR8/eSxOJ3b6+fEX8jkfd28TqJYB/9k1
         Iw7NSzk6XHIXS+1fkr/nNHCp3+qe7gyxMHtws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/bNQ/Pc62g0EcD7cXiKa8ldbAv3wQfSSnIXm2IFY8c=;
        b=J7IoqYrhMni+2CTJEg6UCV3QvBf2BKP0VAmHieoQAV5pfxgpwcTyTPe5wov3s5UtVP
         jbFE8Dud4fXDamTsD+GlI+xo/OUXKP1Ot7dS80+N2nWw/WzK60BP+nMjZolMr50sn6JX
         X4x+bJyp/SJeA5sRRib+6mhEOVEGE+O9o52cyFLuY1lO5lt/QtJtqGOP9a+uIFj4l5AS
         ObEjxBgEAPqLjR0X4FofCuZLJoUgQm/6LUodz2zNCqxctAUlOv//doII5N/t2Sh0yVb0
         qy5Yg7jCY/2WWFL/znOkUPxsmgRK2mv1o/bipgQJyPwYzoaTnQTHRt9+te6qxafuY52r
         VABA==
X-Gm-Message-State: AA+aEWapFD34RcoP911DbahjdczsXEeC8zWsBn9GhINsUsbnZQKUIK4x
        i0WMzwTirpsg4JQfg5DlcHEY0dGD5eg=
X-Google-Smtp-Source: AFSGD/WEy288w1mFuka5Q6aE4McMtiWimYShsSyz11AbDuq3GnZcX+0HT9QfeH9x7nm3Y8Jm3kPlUA==
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr1771489lfa.106.1543518729481;
        Thu, 29 Nov 2018 11:12:09 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v11-v6sm406945ljc.57.2018.11.29.11.12.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:12:08 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id p6so2310516lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:12:07 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr1937463lfc.147.1543518727041;
 Thu, 29 Nov 2018 11:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 11:11:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxtKjkDbvA4EK0aU+FpqALyW+p79_nuPy99PjYFnkbvQ@mail.gmail.com>
Message-ID: <CAHk-=whxtKjkDbvA4EK0aU+FpqALyW+p79_nuPy99PjYFnkbvQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
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

On Thu, Nov 29, 2018 at 11:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What you can do then is basically add a single-byte prefix to the
> "call" instruction that does nothing (say, cs override), and then
> replace *that* with a 'int3' instruction.

Hmm. the segment prefixes are documented as being "reserved" for
branch instructions. I *think* that means just conditional branches
(Intel at one point used the prefixes for static prediction
information), not "call", but who knows..

It might be better to use an empty REX prefix on x86-64 or something like that.

               Linus
