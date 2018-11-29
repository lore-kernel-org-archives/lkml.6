Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD73C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F89213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F89213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbeK3EuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbeK3EuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:50:17 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E5821104;
        Thu, 29 Nov 2018 17:44:06 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:44:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129124404.2fe55dd0@gandalf.local.home>
In-Reply-To: <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
        <20181126171036.chcbmb35ygpxziub@treble>
        <20181126175624.bruqfbkngbucpvxr@treble>
        <20181126200801.GW2113@hirez.programming.kicks-ass.net>
        <20181126212628.4apztfazichxnt7r@treble>
        <20181127084330.GX2113@hirez.programming.kicks-ass.net>
        <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
        <20181129094210.GC2131@hirez.programming.kicks-ass.net>
        <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
        <20181129143853.GO2131@hirez.programming.kicks-ass.net>
        <20181129163342.tp5wlfcyiazwwyoh@treble>
        <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
        <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
        <20181129121307.12393c57@gandalf.local.home>
        <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 09:35:11 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Nov 29, 2018 at 9:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > No, we really do need to sync after we change the second part of the
> > command with the int3 on it. Unless there's another way to guarantee
> > that the full instruction gets seen when we replace the int3 with the
> > finished command.  
> 
> Making sure the call instruction is aligned with the I$ fetch boundary
> should do that.
> 
> It's not in the SDM, but neither was our current behavior - we
> were/are just relying on "it will work".
>

Well, the current method (as Jiri mentioned) did get the OK from at
least Intel (and that was with a lot of arm twisting to do so).

-- Steve
