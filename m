Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCMOMs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752372AbeCMOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:12:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D92C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 13 Mar 2018 10:12:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180313101244.7350c00a@vmware.local.home>
In-Reply-To: <20180313101401.GD16389@krava>
References: <20180310023442.791997138@goodmis.org>
        <20180310023907.798690563@goodmis.org>
        <20180312151017.GE23111@krava>
        <20180312144001.788380fa@vmware.local.home>
        <20180312185414.GA13138@krava>
        <20180312195245.346cef71@vmware.local.home>
        <20180313101401.GD16389@krava>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 11:14:01 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > Jiri, If you apply the below, does it fix it for you?  
> 
> yes, the crash is gone and I can set filter ftrace/function,

Great!

> but I'm still having some issues put that filter through perf
> 
>   # perf record -e ftrace:function --filter "ip == 0xffffffffa41e8490" ls
> 
> but I might be just missing something.. it's been a while ;-) I'm looking to that

I have to ask. Did that work with the old code? The ftrace filter was
special in the old code and I tried to simulate it in the new code.
I'm not sure I checked if ip can take an address, but from what the code
looked like, it wouldn't. It looked like it required a name of a
function. Something that gets passed into "set_ftrace_filter" which is
not an address.

So instead of doing something like:

 perf record -e ftrace:function --filter "ip == 0xffffffff810ccfa0" ls

You would need to do

 perf record -e ftrace:function --filter "ip == schedule_tail" ls

because perf doesn't use the filter for the function, it uses the
ftrace_ops->hash tables. If it would simply take the address, we could
just use the trace_events_filter logic, and not make it a special case.

-- Steve
