Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeCEXQF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:16:05 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:33161 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeCEXQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:16:03 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Tue, 6 Mar 2018 08:16:00 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Du, Changbin" <changbin.du@intel.com>, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [RESEND PATCH] perf sched map: re-annotate shortname if thread
 comm changed
Message-ID: <20180305231600.GB8824@sejong>
References: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
 <20180302105254.234axj7b3nixakav@intel.com>
 <20180302113845.GC16348@krava>
 <20180302144732.GA2471@danjae.aot.lge.com>
 <20180305071136.qs3lsoh432mzbizw@intel.com>
 <20180305223754.GB7403@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305223754.GB7403@krava>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 05, 2018 at 11:37:54PM +0100, Jiri Olsa wrote:
> On Mon, Mar 05, 2018 at 03:11:36PM +0800, Du, Changbin wrote:
> 
> SNIP
> 
> > > > on the other hand it's simple enough and looks
> > > > like generic solution would be more tricky
> > > 
> > > What about adding perf_sched__process_comm() to set it in the
> > > thread::priv?
> > >
> > I can be done, then thread->comm_changed moves to thread_runtime->comm_changed.
> > Draft code as below. It is also a little tricky.
> > 
> > +int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
> > +                            union perf_event *event,
> > +                            struct perf_sample *sample,
> > +                            struct machine *machine)
> > +{
> > +       struct thread *thread;
> > +       struct thread_runtime *r;
> > +
> > +       perf_event__process_comm(tool, event, sample, machine);
> > +
> > +       thread = machine__findnew_thread(machine, pid, tid);
> 
> should you use machine__find_thread in here?

Yep, perf_event__process_comm() already created a new thread if needed.
And the return value of it should be checked.


> 
> > +       if (thread) {
> > +               r = thread__priv(thread);
> > +               if (r)
> > +                       r->comm_changed = true;
> > +               thread__put(thread);
> > +       }

Missing return.

> > +}
> > +
> >  static int perf_sched__read_events(struct perf_sched *sched)
> >  {
> >         const struct perf_evsel_str_handler handlers[] = {
> > @@ -3291,7 +3311,7 @@ int cmd_sched(int argc, const char **argv)
> >         struct perf_sched sched = {
> >                 .tool = {
> >                         .sample          = perf_sched__process_tracepoint_sample,
> > -                       .comm            = perf_event__process_comm,
> > +                       .comm            = perf_sched__process_comm,
> > 
> > 
> > But I'd keep 'comm_changed' where 'shortname' is defined. I think they should appears
> > togother. And 'shortname' is only used by sched command, too.
> 
> they can both go to struct thread_runtime then

Agreed.


> 
> > 
> > So I still prefer my privous simpler change. Thanks!
> 
> I was wrong thinking that the amount of code
> making it sched specific would be biger
> 
> we're trying to keep the core structs generic,
> so this one fits better 

Right.

Thanks,
Namhyung
