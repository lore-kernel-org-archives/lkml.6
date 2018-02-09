Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeBIBKJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbeBIBKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:10:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706F721789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 20:10:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 12/18] tracing: Add accessing direct address from
 function based events
Message-ID: <20180208201003.62ad9526@gandalf.local.home>
In-Reply-To: <20180209003436.GB28206@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.828677654@goodmis.org>
        <20180209003436.GB28206@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 09:34:36 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > +Direct memory access
> > +====================
> > +
> > +Function arguments are not the only thing that can be recorded from a function
> > +based event. Memory addresses can also be examined. If there's a global variable
> > +that you want to monitor via an interrupt, you can put in the address directly.
> > +
> > +  # grep total_forks /proc/kallsyms
> > +ffffffff82354c18 B total_forks
> > +
> > +  # echo 'do_IRQ(int total_forks=0xffffffff82354c18)' > function_events  
> 
> Couldn't we use the symbol name directly?  Maybe it needs a syntax to
> indicate global variable.  Like this?
> 
>   # echo 'do_IRQ(int $total_forks)' > function_events

Or perhaps use "@"?

But that's a good idea and not hard to implement.


> >  	case FUNC_STATE_TYPE:
> > -		if (!isalpha(token[0]) || token[0] == '_')
> > -			break;
> >  		if (WARN_ON(!fevent->last_arg))
> >  			break;
> > -		fevent->last_arg->name = kstrdup(token, GFP_KERNEL);
> > -		if (!fevent->last_arg->name)
> > +		if (update_arg_name(fevent, token) < 0)
> > +			break;
> > +		if (strncmp(token, "0x", 2) == 0)
> > +			goto equal;  
> 
> Not sure it's needed here.  IIUC it should see '=' first and you used
> the same token with arg->name.  Hmm.. do you want support accessing to
> an unnamed address directly like below?
> 
>   # echo 'do_IRQ(int 0xffffffff82354c18)' > function_events 

Yes this works, and was the original way. Someone at DevConf.cz
(Arnaldo maybe, can't remember) recommended giving a name and then we
came up with the "=" sign to use.

> 
> > +		if (!isalpha(token[0]) && token[0] != '_')
> >  			break;  
> 
> Maybe you want to check it before the update_arg_name().

Hmm, perhaps, I guess I should see what the error messages shows.

Thanks!

-- Steve
