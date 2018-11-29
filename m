Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772B120863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772B120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeK3ERB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:17:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeK3ERB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:17:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37CCBC05000A;
        Thu, 29 Nov 2018 17:10:57 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27314620C8;
        Thu, 29 Nov 2018 17:10:52 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:10:50 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129171050.iio53bw67fbiwzud@treble>
References: <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
 <20181129163342.tp5wlfcyiazwwyoh@treble>
 <20181129164914.GA9027@hirez.programming.kicks-ass.net>
 <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 29 Nov 2018 17:10:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:59:31AM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 29, 2018, at 8:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Thu, Nov 29, 2018 at 10:33:42AM -0600, Josh Poimboeuf wrote:
> >>> can't we 'fix' that again? The alternative is moving that IRET-frame and
> >>> fixing everything up, which is going to be fragile, ugly and such
> >>> things more.
> > 
> >> This seems to work...
> > 
> > That's almost too easy... nice!
> 
> It is indeed too easy: you’re putting pt_regs in the wrong place for
> int3 from user mode, which is probably a root hole if you arrange for
> a ptraced process to do int3 and try to write to whatever register
> aliases CS.
> 
> If you make it conditional on CPL, do it for 32-bit as well, add
> comments convince yourself that there isn’t a better solution

I could do that - but why subject 32-bit to it?  I was going to make it
conditional on CONFIG_HAVE_STATIC_CALL_INLINE which is 64-bit only.

> (like pointing IP at a stub that retpolines to the target by reading
> the function pointer, a la the unoptimizable version), then okay, I
> guess, with only a small amount of grumbling.

I tried that in v2, but Peter pointed out it's racy:

  https://lkml.kernel.org/r/20181126160217.GR2113@hirez.programming.kicks-ass.net

-- 
Josh
