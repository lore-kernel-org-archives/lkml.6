Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D412086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D412086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJKDkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:40:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:40:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A62EF3082E07;
        Wed, 10 Oct 2018 20:16:14 +0000 (UTC)
Received: from treble (ovpn-124-83.rdu2.redhat.com [10.10.124.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C341482263;
        Wed, 10 Oct 2018 20:16:11 +0000 (UTC)
Date:   Wed, 10 Oct 2018 15:16:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20181010201609.3zwvzpr3ulredpek@treble>
References: <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble>
 <20181008235750.59da83ae@gandalf.local.home>
 <20181010175237.e7m3sldcu2maoqcq@treble>
 <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
 <20181010181605.arsyjxwdztztrjih@treble>
 <20181010183330.ootwmz6deazg2k2n@treble>
 <20181010145608.2094d254@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010145608.2094d254@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 10 Oct 2018 20:16:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:56:08PM -0400, Steven Rostedt wrote:
> On Wed, 10 Oct 2018 13:33:30 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > Re-reading your suggestion, I may have misunderstood what you're
> > suggesting here, but I'm thinking about doing something like what you
> > proposed earlier:
> > 
> >     GLOBAL(tramp)
> >       jmp *current_func(%rip)
> >     ENDPROC(tramp)
> > 
> > That is, doing an indirect jump instead of the above direct jump, so
> > that any previous references to the trampoline would still work (and it
> > would also work during early boot).
> > 
> > Though it should probably be a retpoline instead of an indirect jump.
> 
> But do we care, as it only takes place during text_poke_bp() right?
> 
> I don't think we need to worry about training trampoline branch
> prediction that can only be hit when something enables the jump.

Yeah, I guess it depends on if we'd expect anybody (or gcc) to get a
function pointer to the trampoline itself.  I can just create a warning
for that in objtool.

-- 
Josh
