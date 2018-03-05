Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeCEHUj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:20:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:57769 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbeCEHUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:20:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="22030670"
Date: Mon, 5 Mar 2018 15:11:36 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, "Du, Changbin" <changbin.du@intel.com>,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RESEND PATCH] perf sched map: re-annotate shortname if thread
 comm changed
Message-ID: <20180305071136.qs3lsoh432mzbizw@intel.com>
References: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
 <20180302105254.234axj7b3nixakav@intel.com>
 <20180302113845.GC16348@krava>
 <20180302144732.GA2471@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302144732.GA2471@danjae.aot.lge.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Mar 02, 2018 at 11:47:32PM +0900, Namhyung Kim wrote:
> Hi,
> 
> On Fri, Mar 02, 2018 at 12:38:45PM +0100, Jiri Olsa wrote:
> > On Fri, Mar 02, 2018 at 06:52:54PM +0800, Du, Changbin wrote:
> > > Hello, any comment?
> > 
> > sry, overlooked this one
> > 
> > SNIP
> > 
> > > > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > > > index 68b65b1..c660fe6 100644
> > > > --- a/tools/perf/util/thread.c
> > > > +++ b/tools/perf/util/thread.c
> > > > @@ -212,6 +212,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
> > > >  			unwind__flush_access(thread);
> > > >  	}
> > > >  
> > > > +	thread->comm_changed = true;
> > > >  	thread->comm_set = true;
> > > >  
> > > >  	return 0;
> > > > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > > > index 40cfa36..b9a328b 100644
> > > > --- a/tools/perf/util/thread.h
> > > > +++ b/tools/perf/util/thread.h
> > > > @@ -27,6 +27,7 @@ struct thread {
> > > >  	int			cpu;
> > > >  	refcount_t		refcnt;
> > > >  	char			shortname[3];
> > > > +	bool			comm_changed;
> > 
> > I don't like that it's in struct thread and set by generic function,
> > and just one command (sched) checks/sets it back.. I'd rather see it
> > in thread::priv area..
> 
> 100% agreed.
> 
> 
> > on the other hand it's simple enough and looks
> > like generic solution would be more tricky
> 
> What about adding perf_sched__process_comm() to set it in the
> thread::priv?
>
I can be done, then thread->comm_changed moves to thread_runtime->comm_changed.
Draft code as below. It is also a little tricky.

+int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
+                            union perf_event *event,
+                            struct perf_sample *sample,
+                            struct machine *machine)
+{
+       struct thread *thread;
+       struct thread_runtime *r;
+
+       perf_event__process_comm(tool, event, sample, machine);
+
+       thread = machine__findnew_thread(machine, pid, tid);
+       if (thread) {
+               r = thread__priv(thread);
+               if (r)
+                       r->comm_changed = true;
+               thread__put(thread);
+       }
+}
+
 static int perf_sched__read_events(struct perf_sched *sched)
 {
        const struct perf_evsel_str_handler handlers[] = {
@@ -3291,7 +3311,7 @@ int cmd_sched(int argc, const char **argv)
        struct perf_sched sched = {
                .tool = {
                        .sample          = perf_sched__process_tracepoint_sample,
-                       .comm            = perf_event__process_comm,
+                       .comm            = perf_sched__process_comm,


But I'd keep 'comm_changed' where 'shortname' is defined. I think they should appears
togother. And 'shortname' is only used by sched command, too.

So I still prefer my privous simpler change. Thanks!

> Thanks,
> Namhyung

-- 
Thanks,
Changbin Du
