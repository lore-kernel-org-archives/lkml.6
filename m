Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3058DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA8C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CguLS4IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA8C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeKESSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:18:49 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA9420819;
        Mon,  5 Nov 2018 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408410;
        bh=VyuqcYOcRiwEs3jMJO3V5vlvjlzAzdxshh7oqF60v7M=;
        h=From:To:Cc:Subject:Date:From;
        b=CguLS4IBn2O2n7MhBt3SfYxXFVT2VAITnkf1NYYONscl16jOryo3nWkyqvy3ock5e
         bqv+9VNstUs5kKuz4Lf+T1RQxRJAyBHP4Tw+jyLtIJNBq6viX4V5Ay6WFyIBktERax
         y2+s3qhHP5HAmaL45WKocXs4ubCqsU/Pa9El6iZk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 00/12] tracing: Unifying dynamic event interface
Date:   Mon,  5 Nov 2018 17:59:46 +0900
Message-Id: <154140838606.17322.15294184388075458777.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 series of unifying dynamic event interface on ftrace.
Currently ftrace has 3 dynamic event interfaces, kprobes, uprobes
and synthetic. This series unifies those dynamic event interfaces
to "dynamic_events" so that we can add other dynamic events easily
on same interface, e.g. function events.
The older interfaces are left on the tracefs for backward
compatibility.

dynamic_events syntax has no difference from kprobe_events and
uprobe_events. You can use same syntax for dynamic_events interface.
For synthetic events, similar to the probe events, dynamic_events
adds "s:[GROUP/]" prefix, where the "GROUP/" must be "synthetic/".

 s:[synthetic/]<event-name> type arg [type arg]...

E.g.

 $ echo 'wakeup_latency u64 lat pid_t pid char' > synthetic_events

is same as

 $ echo 's:wakeup_latency u64 lat pid_t pid char' > dynamic_events

Or

 $ echo 's:synthetic/wakeup_latency u64 lat pid_t pid char' > dynamic_events

This series modifies synthetic event interface behavior a bit,
reorder lock dependency and related cleanups so that we can integrate
the synthetic event to dynamic_events interface. 

In this version, I changed the generic '!' erase command, which
now supports entire line style like other interfaces. So you can
delete events via dynamic_events as below

 $ cat dynamic_events | while read line; \
   do echo "!$line" >> dynamic_events; done

Also, the big change will be removing dyn_event_mutex and
synth_event_mutex because all those parts are protected by
event_mutex.

Changes from v2 are here;

New patches:
 - Reorder event_mutex and synth_event_mutex to solve
   AB-BA deadlock correctly. ([2/12])
 - Simplify creation and deletion of synthetic event. ([3/12])
 - Retern -ENOENT if there is no synthetic event when deleting ([4/12])
 - Integrate similar probe argument parsers ([5/12])
 - Use dyn_event framework for synthetic events ([9/12])
 - Remove synth_event_mutex ([10/12])
 - Remove unused APIs ([11/12])

Modified patches:
 [6/12] - [8/12]
 - Generalize delete event and export as dyn_event_release_all().
 - Add match operation for find deleting event.
 - Reorder event_mutex and dyn_event_mutex to solve lock dependency
   issue.
 - Pass const char **argv for create operation and use -ECANCELED to
   signal for trying next dyn_event_operations.
 - Remove dyn_event_mutex.

 [12/12]
 - Accept entire line, but instead of checking the given entire line
   strictly, simply checking the event and group name.

Tom, thanks for your Ack for v1 series. Since I changed many things
from v1 (not only minor change), I decided to not add your Ack for
this version. Anyway, what I've added in this version are related to
synthetic events. I need your review for those.
(especially removing synth_event_mutex)

You can try it from my git tree.

  https://github.com/mhiramat/linux/tree/unify-dynamic-events-v2

Thank you,

---

Masami Hiramatsu (12):
      tracing/uprobes: Add busy check when cleanup all uprobes
      tracing: Lock event_mutex before synth_event_mutex
      tracing: Simplify creation and deletion of synthetic event
      tracing: Integrate similar probe argument parsers
      tracing: Add unified dynamic event framework
      tracing/kprobes: Use dyn_event framework for kprobe events
      tracing/uprobes: Use dyn_event framework for uprobe events
      tracing: Use dyn_event framework for synthetic events
      tracing: Remove unneeded synth_event_mutex
      tracing: Remove orphaned trace_add/remove_event_call functions
      tracing: Add generic event-name based remove event method
      selftests/ftrace: Add testcases for dynamic event


 Documentation/trace/kprobetrace.rst                |    3 
 Documentation/trace/uprobetracer.rst               |    4 
 include/linux/trace_events.h                       |    4 
 kernel/trace/Kconfig                               |    6 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |   12 +
 kernel/trace/trace_dynevent.c                      |  217 ++++++++++++
 kernel/trace/trace_dynevent.h                      |  119 +++++++
 kernel/trace/trace_events.c                        |   12 -
 kernel/trace/trace_events_hist.c                   |  322 ++++++++++--------
 kernel/trace/trace_kprobe.c                        |  357 ++++++++++----------
 kernel/trace/trace_probe.c                         |   74 ++++
 kernel/trace/trace_probe.h                         |    9 -
 kernel/trace/trace_uprobe.c                        |  305 ++++++++---------
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |   30 ++
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |   27 ++
 .../ftrace/test.d/dynevent/clear_select_events.tc  |   50 +++
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |   49 +++
 18 files changed, 1094 insertions(+), 507 deletions(-)
 create mode 100644 kernel/trace/trace_dynevent.c
 create mode 100644 kernel/trace/trace_dynevent.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_synth.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
