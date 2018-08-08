Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E863BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A57821797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A57821797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeHHU1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeHHU1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:27:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70632177D;
        Wed,  8 Aug 2018 18:07:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnSrL-0002JX-LK; Wed, 08 Aug 2018 14:06:59 -0400
Message-Id: <20180808180245.352784763@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 14:02:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC][PATCH v2 00/24] tools lib traceevent: Rename pevent to tep for preparation for library
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[
  Resending as quilt mail threading was broken, but luckily was fixed by
 http://git.savannah.nongnu.org/cgit/quilt.git/commit/?id=360b85e1f6b6d1aff5ada942fcee816e1ad7a13c
  And has been reported to Debian:
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=900784
]
  
Having libtraceevent turn into a proper library has long been asked for.
I never had time to do it before. Luckily, Tzvetomir was able to spend
the time to start the preparation. The first thing that needs to be done
is to handle namespace collisions. "pevent" was the prefix I chose, but
many people were displeased by it, as it didn't express what the functions
were used for. After discussing with many people at many conferences
I've come up with "tep", which means "Trace Event Parser". Please don't
question this. The bikeshed has been painted and I'm not changing the
color.

This series changes all the function names and data structures from the
"pevent_" prefix to the "tep_" prefix. Note, it does not change the
names of local variables or even parameters. "pevent" variables and
parameters still exist. We can change those later, but for now, I want
all global references to "pevent" to be "tep_" instead.

This is not complete. It is only one of many preparations to make
libtraceevent into a legitimate library. There's other naming conventions
that will be made. But for now, I would like to hear thoughts about
this change before we proceed further.

Instead of doing one big update, Tzvetomir grouped changes together.
I compiled each patch to make sure perf still builds without errors
at each step. I only used my own configuration, thus there may be
cases that perf might fail to build. Here's what I had:

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ OFF ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ on  ]
...                      libslang: [ OFF ]
...                     libcrypto: [ on  ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]

The above is the config I used for testing the build.

-- Steve

Tzvetomir Stoyanov (VMware) (24):
      tools/lib/traceevent, tools/perf: Rename struct pevent to struct tep_handle
      tools/lib/traceevent, tools/perf: Rename struct pevent_record to struct tep_record
      tools/lib/traceevent, tools/perf: Rename pevent plugin related APIs
      tools/lib/traceevent, tools/perf: Rename pevent alloc / free APIs
      tools/lib/traceevent, tools/perf: Rename pevent find APIs
      tools/lib/traceevent, tools/perf: Rename pevent parse APIs
      tools/lib/traceevent, tools/perf: Rename pevent print APIs
      tools/lib/traceevent, tools/perf: Rename pevent_read_number_* APIs
      tools/lib/traceevent, tools/perf: Rename pevent_register_* APIs
      tools/lib/traceevent, tools/perf: Rename pevent_set_* APIs
      tools/lib/traceevent, tools/perf: Rename traceevent_* APIs
      tools/lib/traceevent, tools/perf: Rename enum pevent_flag to enum tep_flag
      tools/lib/traceevent, tools/lib/lockdep/: Rename enunm pevent_errno to enum tep_errno
      tools/lib/traceevent: Rename pevent_function* APIs
      tools/lib/traceevent, tools/perf: Rename traceevent_plugin_* APIs
      tools/lib/traceevent: Rename pevent_filter* APIs
      tools/lib/traceevent: Rename pevent_register / unregister APIs
      tools/lib/traceevent: Rename pevent_data_ APIs
      tools/lib/traceevent: Rename pevent field APIs
      tools/lib/traceevent: Rename pevent_find_* APIs
      tools/lib/traceevent: Rename various pevent get/set/is APIs
      tools/lib/traceevent: Rename internal parser related APIs
      tools/lib/traceevent: Rename various pevent APIs
      tools/lib/traceevent: Rename static variables and functions in event-parse.c

----
 tools/lib/lockdep/Makefile                         |   4 +-
 tools/lib/traceevent/Makefile                      |   4 +-
 tools/lib/traceevent/event-parse.c                 | 696 ++++++++++-----------
 tools/lib/traceevent/event-parse.h                 | 458 +++++++-------
 tools/lib/traceevent/event-plugin.c                |  70 +--
 tools/lib/traceevent/parse-filter.c                | 288 ++++-----
 tools/lib/traceevent/plugin_cfg80211.c             |  20 +-
 tools/lib/traceevent/plugin_function.c             |  34 +-
 tools/lib/traceevent/plugin_hrtimer.c              |  56 +-
 tools/lib/traceevent/plugin_jbd2.c                 |  36 +-
 tools/lib/traceevent/plugin_kmem.c                 |  66 +-
 tools/lib/traceevent/plugin_kvm.c                  | 154 ++---
 tools/lib/traceevent/plugin_mac80211.c             |  28 +-
 tools/lib/traceevent/plugin_sched_switch.c         |  60 +-
 tools/lib/traceevent/plugin_scsi.c                 |  24 +-
 tools/lib/traceevent/plugin_xen.c                  |  20 +-
 tools/perf/builtin-kmem.c                          |   6 +-
 tools/perf/builtin-report.c                        |   6 +-
 tools/perf/builtin-script.c                        |   6 +-
 tools/perf/util/data-convert-bt.c                  |   6 +-
 tools/perf/util/evsel.c                            |   2 +-
 tools/perf/util/header.c                           |   6 +-
 tools/perf/util/machine.h                          |   2 +-
 tools/perf/util/python.c                           |  10 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +-
 .../util/scripting-engines/trace-event-python.c    |   6 +-
 tools/perf/util/sort.c                             |  16 +-
 tools/perf/util/sort.h                             |   2 +-
 tools/perf/util/trace-event-parse.c                |  34 +-
 tools/perf/util/trace-event-read.c                 |  44 +-
 tools/perf/util/trace-event-scripting.c            |   4 +-
 tools/perf/util/trace-event.c                      |  28 +-
 tools/perf/util/trace-event.h                      |  20 +-
 33 files changed, 1109 insertions(+), 1109 deletions(-)

