Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeEPKob (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbeEPKo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:44:28 -0400
Date: Wed, 16 May 2018 06:44:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH v2 05/14] tracing: Do not show filter file for ftrace
 internal events
Message-ID: <20180516064425.6cdd45e1@gandalf.local.home>
In-Reply-To: <20180516091025.GB30309@danjae.aot.lge.com>
References: <20180514205845.017925650@goodmis.org>
        <20180514205958.061558690@goodmis.org>
        <20180516091025.GB30309@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 18:10:25 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

  
> >  	/*
> >  	 * Only event directories that can be enabled should have
> > -	 * triggers.
> > +	 * triggers or filters.
> >  	 */
> > -	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
> > +	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
> > +		trace_create_file("filter", 0644, file->dir, file,
> > +				  &ftrace_event_filter_fops);
> > +
> >  		trace_create_file("trigger", 0644, file->dir, file,
> >  				  &event_trigger_fops);
> > +	}
> >  
> >  #ifdef CONFIG_HIST_TRIGGERS
> >  	trace_create_file("hist", 0444, file->dir, file,  
> 
> What about moving the "hist" file as well since it's meaningless
> without the trigger.

I thought about doing this too. But when I had to manually create the
trigger file, I'll have to also manually create the hist file. As the
hist file is read only and rather harmless, I figured I'd just leave it
as is. The filter file is a command file and this patch wants to remove
the confusion of writing into the file and having no effect.

-- Steve
