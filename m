Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeEHEBc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbeEHEBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:01:30 -0400
Date: Tue, 8 May 2018 13:01:27 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-Id: <20180508130127.c9de04e9d9c93a90e9891ae0@kernel.org>
In-Reply-To: <20180507113003.66045d18@gandalf.local.home>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
        <20180505113803.45700179a93091b114ec6984@kernel.org>
        <20180506005143.7bd9030db298fcfbade73434@kernel.org>
        <20180507113003.66045d18@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018 11:30:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 6 May 2018 00:51:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > OK, now I think it is a time to introduce new unified interface for dynamic events,
> > tracefs/dynamic_events and make uprobe_events and kprobe_events as symbolic-links
> > to the new interface file.
> 
> So basically make one file that does all the work?
> 
> I'm not sure we can keep the other files as symbolic links. Because we
> don't want the kprobe_events showing up in the uprobe_events file, and
> vice versa. We need to keep all this backward compatible.

Good catch!
Can't we check which file the user opened? If not, even though
we can setup a filter in ops->open().

> 
> But I do like the idea of one file to rule them all, approach.

Thanks!

> 
> -- Steve
> 
> 
> > 
> > Actually, there is no reason we split those 2 interfaces, since
> > both have similar, but very clear syntax differences.
> > 
> > o Uprobe event definition
> >   p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
> >   r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
> >   -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
> > 
> > o Kprobe event definition
> >   p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]  : Set a probe
> >   r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]  : Set a return probe
> >   -:[GRP/]EVENT                                         : Clear a probe
> > 
> > At first, it is clear that those can share the parser. 2nd, it is easy to
> > distinguish those, because Uprobe event must require the PATH which starts
> > with '/', on the other hand, Kprobe event must NOT start with '/'.
> > (both SYM and MOD will start with alphabet or '_', of course MEMADDR
> > will start with digits)
> > 
> > If we can merge those to unified dynamic_events interface, I think
> > 'f[:[GRP/]EVENT] SYM(CAST)' is also acceptable, since it is no more
> > only for kprobe/uprobe. We can directly add some other dynamic
> > events via dynamic_events interface. ;)
> > 
> > Thank you,
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
