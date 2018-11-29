Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A71C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F3C213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N4aj4C/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F3C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeK3E5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:57:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40865 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbeK3E47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:56:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so2100309lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eAD1FlhoNaI8od/JETaoVJBfVG8KUjUrJgH6gdEefs=;
        b=N4aj4C/+0fPBJ5+LMGSIrXc/on9r39woqdLZ0ZHErSm6GOzaBWC7k56Hz1kBRkGjUC
         hJdQGo5ScWD9H5YcOxCoBNZn7nCnNkXSBD1TVsD234RSJ+t1/luwgKQjQOwZAnZhv64f
         hrAfwWquiW9HLutDRyhd9NLkYkVDyXYkNvn2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eAD1FlhoNaI8od/JETaoVJBfVG8KUjUrJgH6gdEefs=;
        b=ZfltxzupMuKa2CiE1HCFcL2X3VGzKMBSRZxQ+Ox9PexbbJjs0jAzr92Hi5AoL62x8d
         txMU8z7DWbHccsX/uDTstCd1f6XzbKTbVRgu0BPyKvBl7oqiCagyLvh3pCy14IvDVZTu
         TcxOnZvdyYt7qg9vSEogyXiT2Tv+j3aP39DJ+JrAaa5mjusbjp5wFMw/zePtw5djriP3
         wLPj0H/DfJbIv7xkC6ZQApiwCSLaefPneDeckiuQ8dCfAXcFF0ChmpH9rQeNl4q25wTT
         hQN1bkIw0S9vBcFz3LHwl0SkrWqHTXFGtBrcJBTExhJI0uK4OZS8xpQ8oGDc6WqZqxhN
         NrJA==
X-Gm-Message-State: AA+aEWaEEqc50S8IHvKHjXLIGScyweTOSSjcbjoGMrNoMnV5EIHb0NGX
        m8l6q3wbC2i2HlsF9l6hkFjOXNHCso4=
X-Google-Smtp-Source: AFSGD/Xi+lKX0njO2yFmmEYk9TG7+NgR2y3tcV/E1n6mQeuLHngEn3t8vT4HyYRxueNc8ab4DUektw==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr1755143lfj.83.1543513846829;
        Thu, 29 Nov 2018 09:50:46 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p19-v6sm394400ljb.47.2018.11.29.09.50.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:50:45 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id z80-v6so2529122ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:50:44 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr1921520ljk.80.1543513843985;
 Thu, 29 Nov 2018 09:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com> <20181129124404.2fe55dd0@gandalf.local.home>
In-Reply-To: <20181129124404.2fe55dd0@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 09:50:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
Message-ID: <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
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

On Thu, Nov 29, 2018 at 9:44 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Well, the current method (as Jiri mentioned) did get the OK from at
> least Intel (and that was with a lot of arm twisting to do so).

Guys, when the comparison is to:

 - create a huge honking security hole by screwing up the stack frame

or

 - corrupt random registers because we "know" they aren't in use

then it really sounds pretty safe to just say "ok, just make it
aligned and update the instruction with an atomic cmpxchg or
something".

Of course, another option is to just say "we don't do the inline case,
then", and only ever do a call to a stub that does a "jmp"
instruction.

Problem solved, at the cost of some I$. Emulating a "jmp" is trivial,
in ways emulating a "call" is not.

              Linus
