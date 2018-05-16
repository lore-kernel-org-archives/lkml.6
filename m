Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEPXPK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeEPXPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:15:09 -0400
Date: Thu, 17 May 2018 08:15:04 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 11/14] ftrace/selftest: Have the reset_trigger code
 be a bit more careful
Message-Id: <20180517081504.119ed2cd0fedc2a43199d86a@kernel.org>
In-Reply-To: <20180516100004.1e9c774c@gandalf.local.home>
References: <20180514205845.017925650@goodmis.org>
        <20180514205958.915494639@goodmis.org>
        <20180516215350.4fb775e101bc6a122bfe3282@kernel.org>
        <20180516100004.1e9c774c@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 10:00:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 May 2018 21:53:50 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 14 May 2018 16:58:56 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > The trigger code is picky in how it can be disabled as there may be
> > > dependencies between different events and synthetic events. Change the order
> > > on how triggers are reset.
> > > 
> > >  1) Reset triggers of all synthetic events first
> > >  2) Remove triggers with actions attached to them
> > >  3) Remove all other triggers
> > > 
> > > If this order isn't followed, then some triggers will not be reset, and an
> > > error may happen because a trigger is busy.  
> > 
> > Ah, right!
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks!
> 
> > 
> > I think this should go into stable tree too.
> 
> I wonder if I should break this into two patches then.
> 
> One for the actions before attached, and one for synthetic events?
> 
> Hmm, maybe not. As it can handle not having synthetic events, it should
> be OK to let the update go to a time when they were not there.
> 
> Thoughts?

I think the latest test-set can be run on the any stable kernel,
and this correctly checks existence of the knob, so you don't need
to split it.

Thank you, 

> 
> -- Steve
> 
> > 
> > Thank you!
> > 
> > > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  .../testing/selftests/ftrace/test.d/functions | 21 ++++++++++++++++---
> > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > > index 2a4f16fc9819..8393b1c06027 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/functions
> > > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > > @@ -15,14 +15,29 @@ reset_tracer() { # reset the current tracer
> > >      echo nop > current_tracer
> > >  }
> > >  
> > > -reset_trigger() { # reset all current setting triggers
> > > -    grep -v ^# events/*/*/trigger |
> > > +reset_trigger_file() {
> > > +    # remove action triggers first
> > > +    grep -H ':on[^:]*(' $@ |
> > > +    while read line; do
> > > +        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
> > > +	file=`echo $line | cut -f1 -d:`
> > > +	echo "!$cmd" >> $file
> > > +    done
> > > +    grep -Hv ^# $@ |
> > >      while read line; do
> > >          cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
> > > -	echo "!$cmd" > `echo $line | cut -f1 -d:`
> > > +	file=`echo $line | cut -f1 -d:`
> > > +	echo "!$cmd" > $file
> > >      done
> > >  }
> > >  
> > > +reset_trigger() { # reset all current setting triggers
> > > +    if [ -d events/synthetic ]; then
> > > +        reset_trigger_file events/synthetic/*/trigger
> > > +    fi
> > > +    reset_trigger_file events/*/*/trigger
> > > +}
> > > +
> > >  reset_events_filter() { # reset all current setting filters
> > >      grep -v ^none events/*/*/filter |
> > >      while read line; do
> > > -- 
> > > 2.17.0
> > > 
> > >   
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
