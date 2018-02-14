Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161267AbeBNRe1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:34:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161215AbeBNReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:34:09 -0500
Date: Wed, 14 Feb 2018 11:34:07 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Message-ID: <20180214173407.guhytdurv4pmhzvk@treble>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
 <20180214120112.43821b5e@gandalf.local.home>
 <a4ad6f69-8836-779b-f7e7-0e303885c7f5@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4ad6f69-8836-779b-f7e7-0e303885c7f5@akamai.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:18:20PM -0500, Jason Baron wrote:
> 
> 
> On 02/14/2018 12:01 PM, Steven Rostedt wrote:
> > On Wed, 14 Feb 2018 10:40:41 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> >> When the jump label code encounters an address which isn't recognized by
> >> kernel_text_address(), it just silently fails.
> >>
> >> This can be dangerous because jump labels are used in a variety of
> >> places, and are generally expected to work.  Convert the silent failure
> >> to a warning.
> > 
> > I made ftrace function tracing work on init code, can we do the same
> > with tracepoints (aka jump labels)?
> > 
> 
> jump labels do work on init code, except they don't work on it after it
> has been freed :)
> 
> It uses 'kernel_text_address()', which will return true for init code if
> system_state < SYSTEM_RUNNING. See: core_kernel_text().
> 
> So I'm guessing that the warnings here are coming from init code that
> has already been freed. Are we sure that these warnings are coming from
> init code that hasn't already been freed?

Ah, I see.  I missed that 'system_state < SYSTEM_RUNNING' check.  It was
nicely hidden. :-)

So I guess patches 2 & 3 can be dropped, as those tracepoints can still
be used during boot.

And in patch 1 the warning conditions need to be tweaked a bit to
exclude the __init case.

-- 
Josh
