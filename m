Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB702087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB702087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJKCTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJKCTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:19:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9C32085B;
        Wed, 10 Oct 2018 18:56:10 +0000 (UTC)
Date:   Wed, 10 Oct 2018 14:56:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181010145608.2094d254@gandalf.local.home>
In-Reply-To: <20181010183330.ootwmz6deazg2k2n@treble>
References: <20181006093905.46276505@vmware.local.home>
        <20181008072134.GB5663@hirez.programming.kicks-ass.net>
        <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
        <20181008155757.GC5663@hirez.programming.kicks-ass.net>
        <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
        <20181009021710.qwt5hpntyeps44h3@treble>
        <20181008235750.59da83ae@gandalf.local.home>
        <20181010175237.e7m3sldcu2maoqcq@treble>
        <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
        <20181010181605.arsyjxwdztztrjih@treble>
        <20181010183330.ootwmz6deazg2k2n@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 13:33:30 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Re-reading your suggestion, I may have misunderstood what you're
> suggesting here, but I'm thinking about doing something like what you
> proposed earlier:
> 
>     GLOBAL(tramp)
>       jmp *current_func(%rip)
>     ENDPROC(tramp)
> 
> That is, doing an indirect jump instead of the above direct jump, so
> that any previous references to the trampoline would still work (and it
> would also work during early boot).
> 
> Though it should probably be a retpoline instead of an indirect jump.

But do we care, as it only takes place during text_poke_bp() right?

I don't think we need to worry about training trampoline branch
prediction that can only be hit when something enables the jump.

-- Steve
