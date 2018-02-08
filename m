Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBHPnu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBHPnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:43:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2128021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:43:43 -0500
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
Subject: Re: [PATCH 09/18] tracing: Add indexing of arguments for function
 based events
Message-ID: <20180208104343.2fa63eda@gandalf.local.home>
In-Reply-To: <20180208105924.GB26290@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.338259949@goodmis.org>
        <20180208105924.GB26290@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 19:59:24 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > @@ -347,6 +361,8 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
> >  	char buf[8];
> >  	int ret;
> >  
> > +	val += arg->index;
> > +
> >  	if (!arg->indirect)
> >  		return val;  
> 
> So this also works without the indirect, and just add the immediate to
> the value.

Not sure what you are asking here. The immediate adds to the current
value, where as the indirect will then look what's at that location.

If the arg (val) is 0xffffffffabcd0000

	u64 val+8

Will return: 0xffffffffabcd0008

	u64 val[1]

will return what's at location 0xffffffffabcd0008

"u64 val+8[0]" is the same as "u64 val[1]"

Note: "u64 val[0]+8" will return what's at location 0xffffffffabcd0000
plus 8.

-- Steve
