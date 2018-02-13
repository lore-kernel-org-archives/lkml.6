Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933619AbeBMP2h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933515AbeBMP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:28:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269B22172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 13 Feb 2018 10:28:28 -0500
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
Subject: Re: [PATCH 17/18] tracing: Add indirect to indirect access for
 function based events
Message-ID: <20180213102828.11bf186c@gandalf.local.home>
In-Reply-To: <20180213092737.GJ31513@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231019.582037880@goodmis.org>
        <20180209051301.GE28206@sejong>
        <20180209104758.093d31ad@gandalf.local.home>
        <20180212021534.GH31513@sejong>
        <20180212122354.1d2fb867@gandalf.local.home>
        <20180213092737.GJ31513@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 18:27:37 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Mon, Feb 12, 2018 at 12:23:54PM -0500, Steven Rostedt wrote:
> > On Mon, 12 Feb 2018 11:15:34 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >   
> > > > It should have been:
> > > > 
> > > > 		return process_redirects(arg, val, buf);    
> > > 
> > > But I think you need to consider data type of the arg when
> > > dereferencing the last redirect.  
> > 
> > What for?  
> 
> Otherwise it'd return a value of unsigned long type regardless of the
> type of the arg.  I thought it should have same logic as indirect
> args.

OK, I see what you are saying. Yeah, I think it should have the check,
or ...

> 
> But it seems not matter since record_entry() would copy it only for
> the arg->size.  Then type check in __get_arg() might be unnecessary
> too.

No, on big endian boxes it can break. I think the answer is to have the
final assignment do the conversion. Or I should have a helper function
to do it.

> 
> > 
> > Also this code has also changed. I haven't posted new patches but my
> > latest is in my git tree in the branch ftrace/dynamic-ftrace-events.  
> 
> I've checked it.  And it seems to have another problem for indirect
> (but not redirect) arrays and strings.  Like 'x32[1] foo[2]'?

Yep, I know the issue there, I haven't gotten around to fixing it.

Thanks!

-- Steve
