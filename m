Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeDMOYw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:24:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:12424 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbeDMOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:24:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,445,1517904000";
   d="scan'208";a="33148498"
Message-ID: <1523629474.25328.14.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH 2/6] tracing: Add trace event error log
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date: Fri, 13 Apr 2018 09:24:34 -0500
In-Reply-To: <20180413094515.19fb3691@gandalf.local.home>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
         <194bd34e689dd6df9e48855111fd6c5c66e37fc9.1523545519.git.tom.zanussi@linux.intel.com>
         <20180412182001.75bfb4e2@gandalf.local.home>
         <1523577133.11817.31.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180413094515.19fb3691@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 2018-04-13 at 09:45 -0400, Steven Rostedt wrote:
> On Thu, 12 Apr 2018 18:52:13 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Hi Steve,
> > 
> > On Thu, 2018-04-12 at 18:20 -0400, Steven Rostedt wrote:
> > > On Thu, 12 Apr 2018 10:13:17 -0500
> > > Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> > >   
> > > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > > index 6fb46a0..f2dc7e6 100644
> > > > --- a/kernel/trace/trace.h
> > > > +++ b/kernel/trace/trace.h
> > > > @@ -1765,6 +1765,9 @@ extern ssize_t trace_parse_run_command(struct file *file,
> > > >  		const char __user *buffer, size_t count, loff_t *ppos,
> > > >  		int (*createfn)(int, char**));
> > > >  
> > > > +extern void event_log_err(const char *loc, const char *cmd, const char *fmt,
> > > > +			  ...);
> > > > +
> > > >  /*
> > > >   * Normal trace_printk() and friends allocates special buffers
> > > >   * to do the manipulation, as well as saves the print formats
> > > > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > > > index 05c7172..fd02e22 100644
> > > > --- a/kernel/trace/trace_events.c
> > > > +++ b/kernel/trace/trace_events.c
> > > > @@ -1668,6 +1668,164 @@ static void ignore_task_cpu(void *data)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +#define EVENT_LOG_ERRS_MAX	(PAGE_SIZE / sizeof(struct event_log_err))  
> > >   
> > > > +#define EVENT_ERR_LOG_MASK	(EVENT_LOG_ERRS_MAX - 1)  
> > > 
> > > BTW, the above only works if EVENT_LOG_ERRS_MAX is a power of two,
> > > which it's not guaranteed to be.
> > >   
> > 
> > My assumption was that we'd only ever need a page or two for the
> > error_log and so would always would be a power of two, since the size of
> > the struct event_log_err is 512.
> 
> Assumptions are not what we want to rely on. There should be something
> like:
> 
> 	BUILD_BUG_ON(EVENT_LOG_ERRS_MAX & EVENT_ERR_LOG_MASK);
> 
> Which would guarantee that your assumption is correct otherwise the
> kernel wont build.
> 

OK.

> 
> > 
> > Anyway, I should probably have put comments about all this in the code,
> > and I will, but the way it works kind of assumes a very small number of
> > errors - it's replacing a simple 'last error' facility for the hist
> > triggers and making it a common facility for other things that have
> > similar needs like Masami's kprobe_events errors.  For those purposes, I
> > assumed it would suffice to simply be able to show that last 8 or some
> > similar small number of errors and constantly recycle the slots.
> 
> The errors are still in the files that have the errors right? Perhaps
> just have a file that lists the files that contain errors. That way if
> something goes wrong, you can examine that file and then look at the
> file that contains the error?
> 

No, that's part of the motivation for this change - currently there is
just one last 'last error', the output tacked onto whichever event's
hist file you read (normally this would be the one you just got the
error for, but doesn't have to be) - there isn't a last error per event.
Masami of course found this unintuitive, which it is, I agree, and
wanted a single file (error_log) to look into for the last error.  In
addition, it should have a logging interface that any trace event
command could use, such as kprobe_events.

> And I'm not sure it being in the events directory is the best place
> either, especially, if you plan to have it handle kprobe_events because
> that's not in the events directory.
> 

Yeah, I put it there because it's associated with trace events - putting
it in tracing/ would imply that it's meant for ftrace in general (which
maybe it should be but this isn't).  Actually I'm not sure kprobe_events
shouldn't be in tracing/events too..

> > 
> > Basically it just splits the page into 16 strings, 2 per error, one for
> > the actual error text, the other for the command the user entered.  The
> > struct event_log_err just overlays a struct on top of 2 strings just to
> > make it easier to manage.
> > 
> > Anyway, because it is such a small number, and we start with a zeroed
> > page, whenever we print the error log, we print all 16 strings even if
> > we only have one error (2 strings).  The rest are NULL and print
> > nothing.  We start with the tail, which could also be thought of as the
> > 'oldest' or the 'first' error in the buffer and just cycle through them
> > all.  Hope that clears up some of the other questions you had about how
> > a non-full log gets printed, etc...
> 
> OK, I was thinking a NULL entry would return NULL, but we are
> returning a pointer to NULL. That's where I missed it.
>  
> > 
> > > > +
> > > > +struct event_log_err {
> > > > +	char			err[MAX_FILTER_STR_VAL];
> > > > +	char			cmd[MAX_FILTER_STR_VAL];
> > > > +};  
> > > 
> > > I like the event_log_err idea, but the above can be shrunk to:
> > > 
> > > struct err_info {
> > > 	u8	type; /* I can only imagine 254 types */
> > > 	u8	pos;  /* MAX_FILTER_STR_VAR = 256 */
> > > };
> > > 
> > > struct event_log_err {
> > > 	struct err_info		info;
> > > 	char			cmd[MAX_FILTER_STR_VAL];
> > > };
> > > 
> > > There's no reason to put in a bunch of text that's going to be static
> > > anyway. Have a lookup table like we do for filters.
> > > 
> > > +				log_err("Variable name not unique, need to use fully qualified name (%s) for variable: ", fqvar(system, event_name, var_name, true));
> > >   
> > 
> > Hmm, most of the log_errs use printf strings that get expanded, so need
> > a destination buffer, the event_log_err->err string, but I think I see
> > what you're getting at - that we can get rid of the format strings
> > altogether and make them static strings if we use the method of simply
> > printing the static string and putting a caret where the error is as
> > below.
> > 
> > > 
> > > Instead of making the fqvar, find the location of the variable, and add:
> > > 
> > >  blah blah $var blah blah
> > >             ^
> > >   Variable name not unique, need to use fully qualified name for variable
> > >   
> > 
> > OK, if we can do this for every error type, then we can use the lookup
> > table and the caret position instead of format strings.  Which means
> > getting rid of the simple ring of strings, but whatever..
> 
> I still don't know about this change. It feels rather hacky and quickly
> thrown together. This is going to be something we will have to support
> indefinitely, and I want to have a bit more thought in it before we do
> anything.
> 
> This isn't something I want to push into this merge window. Let's think
> about it more. Is this really the best way to show errors?
> 

Yeah, I agree - I'd rather get it right than get it in now.  I thought
this made sense, and was based on input from Masami, which I may have
misinterpreted, but I'll wait for some more ideas about the best way to
do this.

Thanks,

Tom

> -- Steve
> 
> 
> > 
> > > > +
> > > > +static char *event_err_log;
> > > > +static unsigned int event_err_log_tail;
> > > > +
> > > > +struct event_log_err *get_event_log_err(void)
> > > > +{
> > > > +	struct event_log_err *err;
> > > > +	char *errpos;
> > > > +
> > > > +	if (!event_err_log) {
> > > > +		event_err_log = (char *)get_zeroed_page(GFP_KERNEL);
> > > > +		if (!event_err_log)
> > > > +			return NULL;
> > > > +	}
> > > > +
> > > > +	errpos = event_err_log + event_err_log_tail * sizeof(*err);
> > > > +	err = (struct event_log_err *)errpos;
> > > > +
> > > > +	event_err_log_tail = (event_err_log_tail + 1) & EVENT_ERR_LOG_MASK;  
> > >
