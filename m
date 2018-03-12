Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeCLNpz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:45:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCLNpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:45:53 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Oleg Nesterov <onestero@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCHv3 0/8] hw_breakpoint: Breakpoint modification fixes and new modify ioctl
Date: Mon, 12 Mar 2018 14:45:40 +0100
Message-Id: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Milind Chabbi introduced new ioctl interface to change
live breakpoint [1]. It allows to change its bp_addr,
bp_len and bp_type throught new ioctl for perf breakpoint
event.

We already have a kernel interface for this via 
modify_user_hw_breakpoint function. This function however
does not update the breakpoint slot counts.

So when the same functionality was exposed to user space
(Milind's change), with simple test program I could put wrong
slots count on arm server [2] and ended up with no breakpoints
available on the system. Note it's not an issue on x86, because
it shares slot single counter for both data and inst types
(CONFIG_HAVE_MIXED_BREAKPOINTS_REGS).

This patchset contains my fixes for keeping breakpoint slots
count updated. On top of it there's Milind's change for new
_IOC_MODIFY_ATTRIBUTES ioctl interface to change a breakpoint.

As I mentioned above there're kernel users of
modify_user_hw_breakpoint function, all ptrace related
AFAICS, which could got broken.. so cc-ing Oleg ;-)

I ran gdb and strace tests suites and got same amount of
skip/fail tests as when I run them on unpatched machine,
so I assume nothing new got broken.

It's also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/bp

v3 changes:
  - rebased on Arnaldo's perf/core
  - minor format changes in PERF_EVENT_IOC_* hunks

v2 changes:
  - added check for the rest of the perf_event_attr fields
    to be the same as for kernel event

thanks,
jirka


[1] https://marc.info/?l=linux-kernel&m=151012255331565&w=2
[2] https://marc.info/?l=linux-man&m=151172469807302&w=2
---
Jiri Olsa (7):
      hw_breakpoint: Pass bp_type directly as find_slot_idx argument
      hw_breakpoint: Pass bp_type argument to __reserve_bp_slot|__release_bp_slot
      hw_breakpoint: Add modify_bp_slot function
      hw_breakpoint: Factor out __modify_user_hw_breakpoint function
      hw_breakpoint: Add perf_event_attr fields check in __modify_user_hw_breakpoint
      perf/core: Move perf_event_attr::sample_max_stack into perf_copy_attr
      perf tests: Add breakpoint accounting/modify test

Milind Chabbi (1):
      perf/core: fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES.

 include/linux/hw_breakpoint.h         |   7 +++++
 include/uapi/linux/perf_event.h       |  23 ++++++++-------
 kernel/events/core.c                  |  54 ++++++++++++++++++++++++++++++++--
 kernel/events/hw_breakpoint.c         | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 tools/include/uapi/linux/perf_event.h |  23 ++++++++-------
 tools/perf/tests/Build                |   1 +
 tools/perf/tests/bp_account.c         | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c       |   4 +++
 tools/perf/tests/tests.h              |   1 +
 9 files changed, 365 insertions(+), 58 deletions(-)
 create mode 100644 tools/perf/tests/bp_account.c
