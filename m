Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D77EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F111221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeK3EwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:52:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbeK3EwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:52:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F9975AFF5;
        Thu, 29 Nov 2018 17:46:02 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A5F4601B9;
        Thu, 29 Nov 2018 17:45:58 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:45:55 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Message-ID: <20181129174555.dapti2w4acrbm2jp@treble>
References: <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
 <20181129163342.tp5wlfcyiazwwyoh@treble>
 <20181129164914.GA9027@hirez.programming.kicks-ass.net>
 <0FDA053D-7ADC-4F42-AEA5-99DA155FCED0@amacapital.net>
 <20181129171539.GD9027@hirez.programming.kicks-ass.net>
 <20181129122000.7fb4fb04@gandalf.local.home>
 <20181129122156.782e739e@gandalf.local.home>
 <666E3CE2-CD96-4271-8F9C-614F96D24F26@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <666E3CE2-CD96-4271-8F9C-614F96D24F26@amacapital.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Nov 2018 17:46:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:41:33AM -0800, Andy Lutomirski wrote:
> 
> > On Nov 29, 2018, at 9:21 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > On Thu, 29 Nov 2018 12:20:00 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > 
> >> r8 = return address
> >> r9 = function to call
> >> 
> > 
> > Bad example, r8 and r9 are args, but r10 and r11 are available.
> > 
> > -- Steve
> > 
> >>    push r8
> >>    jmp *r9
> >> 
> >> Then have the regs->ip point to that trampoline.
> 
> Cute. That’ll need ORC annotations and some kind of retpoline to replace the indirect jump, though.

I'm going with this idea, but the BP is so rare that I really don't see
why a retpoline would be needed.

-- 
Josh
