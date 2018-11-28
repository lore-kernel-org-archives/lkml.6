Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32470206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32470206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeK2Kpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:45:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:55028 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbeK2Kpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:45:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 15:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="117436390"
Received: from isister-mobl.amr.corp.intel.com ([10.255.76.222])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2018 15:42:23 -0800
Message-ID: <ff8ca3062cad3747a664e6888790cc3c58e24c7e.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/12] tracing: Unifying dynamic event interface
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date:   Wed, 28 Nov 2018 17:42:22 -0600
In-Reply-To: <20181128163101.d86844338bcba3fc3b0580f1@kernel.org>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
         <20181128163101.d86844338bcba3fc3b0580f1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, 2018-11-28 at 16:31 +0900, Masami Hiramatsu wrote:
> Ping?
> 
> Hi Tom,
> 
> This series, especially [09/12] tracing: Remove unneeded
> synth_event_mutex
> will effect your current working series. Please tell me your opinion.
> 

Sorry for the delay in reviewing this - I completely forgot about it in
my inbox.

It's all very nice, and the mutex updates along with the dyn_event
management make that part of the code much cleaner, thanks!

In any case, you can have my

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom


> Thank you,
> 
> On Mon,  5 Nov 2018 17:59:46 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > This is v2 series of unifying dynamic event interface on ftrace.
> > Currently ftrace has 3 dynamic event interfaces, kprobes, uprobes
> > and synthetic. This series unifies those dynamic event interfaces
> > to "dynamic_events" so that we can add other dynamic events easily
> > on same interface, e.g. function events.
> > The older interfaces are left on the tracefs for backward
> > compatibility.
> > 
> > dynamic_events syntax has no difference from kprobe_events and
> > uprobe_events. You can use same syntax for dynamic_events
> > interface.
> > For synthetic events, similar to the probe events, dynamic_events
> > adds "s:[GROUP/]" prefix, where the "GROUP/" must be "synthetic/".
> > 
> >  s:[synthetic/]<event-name> type arg [type arg]...
> > 
> > E.g.
> > 
> >  $ echo 'wakeup_latency u64 lat pid_t pid char' > synthetic_events
> > 
> > is same as
> > 
> >  $ echo 's:wakeup_latency u64 lat pid_t pid char' > dynamic_events
> > 
> > Or
> > 
> >  $ echo 's:synthetic/wakeup_latency u64 lat pid_t pid char' >
> > dynamic_events
> > 
> > This series modifies synthetic event interface behavior a bit,
> > reorder lock dependency and related cleanups so that we can
> > integrate
> > the synthetic event to dynamic_events interface. 
> > 
> > In this version, I changed the generic '!' erase command, which
> > now supports entire line style like other interfaces. So you can
> > delete events via dynamic_events as below
> > 
> >  $ cat dynamic_events | while read line; \
> >    do echo "!$line" >> dynamic_events; done
> > 
> > Also, the big change will be removing dyn_event_mutex and
> > synth_event_mutex because all those parts are protected by
> > event_mutex.
> > 
> > Changes from v2 are here;
> > 
> > New patches:
> >  - Reorder event_mutex and synth_event_mutex to solve
> >    AB-BA deadlock correctly. ([2/12])
> >  - Simplify creation and deletion of synthetic event. ([3/12])
> >  - Retern -ENOENT if there is no synthetic event when deleting
> > ([4/12])
> >  - Integrate similar probe argument parsers ([5/12])
> >  - Use dyn_event framework for synthetic events ([9/12])
> >  - Remove synth_event_mutex ([10/12])
> >  - Remove unused APIs ([11/12])
> > 
> > Modified patches:
> >  [6/12] - [8/12]
> >  - Generalize delete event and export as dyn_event_release_all().
> >  - Add match operation for find deleting event.
> >  - Reorder event_mutex and dyn_event_mutex to solve lock dependency
> >    issue.
> >  - Pass const char **argv for create operation and use -ECANCELED
> > to
> >    signal for trying next dyn_event_operations.
> >  - Remove dyn_event_mutex.
> > 
> >  [12/12]
> >  - Accept entire line, but instead of checking the given entire
> > line
> >    strictly, simply checking the event and group name.
> > 
> > Tom, thanks for your Ack for v1 series. Since I changed many things
> > from v1 (not only minor change), I decided to not add your Ack for
> > this version. Anyway, what I've added in this version are related
> > to
> > synthetic events. I need your review for those.
> > (especially removing synth_event_mutex)
> > 
> > You can try it from my git tree.
> > 
> >   https://github.com/mhiramat/linux/tree/unify-dynamic-events-v2
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (12):
> >       tracing/uprobes: Add busy check when cleanup all uprobes
> >       tracing: Lock event_mutex before synth_event_mutex
> >       tracing: Simplify creation and deletion of synthetic event
> >       tracing: Integrate similar probe argument parsers
> >       tracing: Add unified dynamic event framework
> >       tracing/kprobes: Use dyn_event framework for kprobe events
> >       tracing/uprobes: Use dyn_event framework for uprobe events
> >       tracing: Use dyn_event framework for synthetic events
> >       tracing: Remove unneeded synth_event_mutex
> >       tracing: Remove orphaned trace_add/remove_event_call
> > functions
> >       tracing: Add generic event-name based remove event method
> >       selftests/ftrace: Add testcases for dynamic event
> > 
> > 
> >  Documentation/trace/kprobetrace.rst                |    3 
> >  Documentation/trace/uprobetracer.rst               |    4 
> >  include/linux/trace_events.h                       |    4 
> >  kernel/trace/Kconfig                               |    6 
> >  kernel/trace/Makefile                              |    1 
> >  kernel/trace/trace.c                               |   12 +
> >  kernel/trace/trace_dynevent.c                      |  217
> > ++++++++++++
> >  kernel/trace/trace_dynevent.h                      |  119 +++++++
> >  kernel/trace/trace_events.c                        |   12 -
> >  kernel/trace/trace_events_hist.c                   |  322
> > ++++++++++--------
> >  kernel/trace/trace_kprobe.c                        |  357
> > ++++++++++----------
> >  kernel/trace/trace_probe.c                         |   74 ++++
> >  kernel/trace/trace_probe.h                         |    9 -
> >  kernel/trace/trace_uprobe.c                        |  305
> > ++++++++---------
> >  .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |   30 ++
> >  .../ftrace/test.d/dynevent/add_remove_synth.tc     |   27 ++
> >  .../ftrace/test.d/dynevent/clear_select_events.tc  |   50 +++
> >  .../ftrace/test.d/dynevent/generic_clear_event.tc  |   49 +++
> >  18 files changed, 1094 insertions(+), 507 deletions(-)
> >  create mode 100644 kernel/trace/trace_dynevent.c
> >  create mode 100644 kernel/trace/trace_dynevent.h
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.
> > tc
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.
> > tc
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> 

