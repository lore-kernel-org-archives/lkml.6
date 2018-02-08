Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBHPsr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHPso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:48:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D580021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:48:40 -0500
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
Subject: Re: [PATCH 11/18] tracing: Add symbol type to function based events
Message-ID: <20180208104840.6c9667b7@gandalf.local.home>
In-Reply-To: <20180208110341.GC26290@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.653298332@goodmis.org>
        <20180208110341.GC26290@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 20:03:41 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > @@ -76,6 +76,7 @@ typedef u64 x64;
> >  typedef u32 x32;
> >  typedef u16 x16;
> >  typedef u8 x8;
> > +typedef void * symbol;
> >  
> >  #define TYPE_TUPLE(type)			\
> >  	{ #type, sizeof(type), is_signed_type(type) }
> > @@ -97,7 +98,8 @@ typedef u8 x8;
> >  	TYPE_TUPLE(x16),			\
> >  	TYPE_TUPLE(u8),				\
> >  	TYPE_TUPLE(s8),				\
> > -	TYPE_TUPLE(x8)
> > +	TYPE_TUPLE(x8),				\
> > +	TYPE_TUPLE(symbol)
> >  
> >  static struct func_type {
> >  	char		*name;
> > @@ -262,7 +264,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
> >  	switch (state) {
> >  	case FUNC_STATE_INIT:
> >  		unsign = 0;
> > -		if (!isalpha(token[0]))
> > +		if (!isalpha(token[0]) && token[0] != '_')
> >  			break;  
> 
> Hmm.. it seems that it needs to be moved to the patch 1?

Agreed.

> 
> 
> >  		/* Do not allow wild cards */
> >  		if (strstr(token, "*") || strstr(token, "?"))
> > @@ -305,7 +307,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
> >  		return FUNC_STATE_TYPE;
> >  
> >  	case FUNC_STATE_TYPE:
> > -		if (!isalpha(token[0]))
> > +		if (!isalpha(token[0]) || token[0] == '_')
> >  			break;  
> 
> Why is different that the above?  Anyway, '_' is not an alphabet..

That's a bug. I thought I fixed that. Ah, in v2 I fixed it in a later
patch. I'll restructure to fix it in the proper place.

Thanks!

-- Steve
