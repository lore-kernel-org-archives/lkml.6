Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A616EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C23208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeqwXudQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C23208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeG0Nb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbeG0Nb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:31:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC11208AD;
        Fri, 27 Jul 2018 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693420;
        bh=NOG5CEnZYZjHqBTZJvBJl9eV5ddvKI7k35IQuWCm1vo=;
        h=From:To:Cc:Subject:Date:From;
        b=qeqwXudQkh757HVvz52Pvi0VizNFfepfnwq5cYC5eCTUNq3HoBazM1UM5VwcSw2U0
         6C0uqygvgTywBxBkoRnx1FaQcl6Y0lRUkyI8wxMUcY3T9GbB1nA1ECS1z5KzLhUUeR
         zka/IH5KnccCCPeB0FOFUb4qMqrOVql9vZD1TQ6U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] selftests/ftrace: Improve ftracetest with coverage check
Date:   Fri, 27 Jul 2018 21:09:56 +0900
Message-Id: <153269339575.3084.16279591141931053689.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a series of patches for improving ftracetest testcase
using gcov/lcov. It is still in progress, and I have got good
improvement of line/function coverage under kernel/trace with
this series. (Note that this kernel enables ftrace startup
tests)

Without this series
Lines:		10156	17200	59.0 %
Functions:	1069	1772	60.3 %

With this series
Lines:		11130	17200	64.7 %
Functions:	1185	1772	66.9 %

Of course we don't need to make it 100%, because ftracetest
is a function/specification test, and there are functions and
lines which never be called (like critical error detection :) ).
Also, ftrace has some amount of code for perf and bpf subsystem
which should be tested by perf/bpf tests.
However, GCOV(LCOV) gives us a good insight into which
functions are covered or not covered by the test cases.

This series has some ftracetest framework improvements too,
which are for debugging ftracetest itself.

Tracing/Gcov-kernel:
 - Add CONFIG_GCOV_PROFILE_FRACE, which enables gcov profiling
   only on tracing subsystem (under kernel/trace/). This may not
   needed for everyone (like a debugging feature).
   So it can be dropped anyway.

Ftracetest framework improvements:
 - Add --stop-fail for detecting failure soon.
 - Add --console for interactively debugging a testcase by shell.
 - Add testcase-number prefix to logfile for finding log easier.
 - Improve general init function
 - Call general init function after all testcases.
 - Remove init/cleanup code from all testcase (since general init
   function will fixed it up)

Testcase fixes:
 - Fix to check $comm availability.
 - Make checkbashisms clean

Testcase improvements:
 - Use loopback address instead of localhost
 - Improve kprobe on module testcase to load/unload module
 - Improve kprobe testcase to check log data
 - Improve kretprobe testcase to check log data
 - Test kprobe-event argument with various bitsize
 - Check set_event_pid result

Adding testcases:
 - Add kprobe event with $comm argument testcase
 - Add kprobe profile testcase
 - Add kprobe-event with symbol argument test
 - Add nop tracer testcase
 - Add trace_printk sample module testcase
 - Add ringbuffer size changing testcase
 - Add function profiling statistics testcase
 - Add max stack tracer testcase
 - Add function filter on module testcase
 - Add trace_pipe testcase
 
TBD:
Following testcase improvements are remaining.
 - Checking of various supported types (like u8, u64 etc.)
   testcases
 - Filter actions for ftrace testcases

Thank you,

---

Masami Hiramatsu (25):
      tracing: Allow gcov profiling on only ftrace subsystem
      selftests/ftrace: Add --stop-fail hidden option for debug
      selftests/ftrace: Add --console hidden option
      selftests/ftrace: Add case number prefix to logfile
      selftests/ftrace: More initialize features in initialize_ftrace
      selftests/ftrace: Cleanup ftrace after running test
      selftests/ftrace: Remove unneeded per-test init/cleanup ftrace
      selftests/ftrace: Fix to test kprobe $comm arg only if available
      selftests/ftrace: Fix checkbashisms errors
      selftests/ftrace: Use loopback address instead of localhost
      selftests/ftrace: Improve kprobe on module testcase to load/unload module
      selftests/ftrace: Improve kprobe testcase to check log data
      selftests/ftrace: Improve kretprobe testcase to check log data
      selftests/ftrace: Test kprobe-event argument with various bitsize
      selftests/ftrace: Check set_event_pid result
      selftests/ftrace: Add kprobe event with $comm argument testcase
      selftests/ftrace: Add kprobe profile testcase
      selftests/ftrace: Add a testcase for nop tracer
      selftests/ftrace: Add kprobe-event with symbol argument test
      selftests/ftrace: Add trace_printk sample module test
      selftests/ftrace: Add ringbuffer size changing testcase
      selftests/ftrace: Add function profiling stat testcase
      selftests/ftrace: Add max stack tracer testcase
      selftests/ftrace: Add function filter on module testcase
      selftests/ftrace: Add trace_pipe testcase


 kernel/trace/Kconfig                               |   13 +++++
 kernel/trace/Makefile                              |    5 ++
 tools/testing/selftests/ftrace/config              |    5 ++
 tools/testing/selftests/ftrace/ftracetest          |   32 +++++++++++-
 .../ftrace/test.d/00basic/ringbuffer_size.tc       |   21 ++++++++
 .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |   15 ++++++
 .../selftests/ftrace/test.d/event/event-enable.tc  |    8 ---
 .../selftests/ftrace/test.d/event/event-pid.tc     |    6 +-
 .../ftrace/test.d/event/subsystem-enable.tc        |    8 ---
 .../ftrace/test.d/event/toplevel-enable.tc         |    8 ---
 .../selftests/ftrace/test.d/event/trace_printk.tc  |   27 ++++++++++
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |    4 --
 .../ftrace/test.d/ftrace/fgraph-filter.tc          |    9 ---
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |    8 ---
 .../ftrace/test.d/ftrace/func_event_triggers.tc    |    3 -
 .../ftrace/test.d/ftrace/func_mod_trace.tc         |   24 +++++++++
 .../ftrace/test.d/ftrace/func_profile_stat.tc      |   23 +++++++++
 .../ftrace/test.d/ftrace/func_profiler.tc          |    4 --
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |   13 -----
 .../ftrace/test.d/ftrace/func_stack_tracer.tc      |   39 +++++++++++++++
 .../test.d/ftrace/func_traceonoff_triggers.tc      |   11 ----
 tools/testing/selftests/ftrace/test.d/functions    |    4 ++
 .../ftrace/test.d/kprobe/add_and_remove.tc         |    3 -
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |    3 -
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |    8 ++-
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |   17 +++++++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    5 --
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   39 +++++++++++++++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |    8 +--
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |   52 ++++++++++++--------
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |    5 --
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    9 ---
 .../ftrace/test.d/kprobe/kprobe_module.tc          |   36 ++++++++++++--
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |    9 ++-
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |    4 --
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    5 --
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    4 --
 .../selftests/ftrace/test.d/kprobe/profile.tc      |   15 ++++++
 .../testing/selftests/ftrace/test.d/tracer/nop.tc  |   22 ++++++++
 .../inter-event/trigger-extended-error-support.tc  |   12 -----
 .../inter-event/trigger-field-variable-support.tc  |   15 ------
 .../trigger-inter-event-combined-hist.tc           |   15 ------
 .../inter-event/trigger-multi-actions-accept.tc    |   14 -----
 .../inter-event/trigger-onmatch-action-hist.tc     |   15 ------
 .../trigger-onmatch-onmax-action-hist.tc           |   15 ------
 .../inter-event/trigger-onmax-action-hist.tc       |   15 ------
 .../trigger-synthetic-event-createremove.tc        |   12 -----
 .../ftrace/test.d/trigger/trigger-eventonoff.tc    |   12 -----
 .../ftrace/test.d/trigger/trigger-filter.tc        |   14 -----
 .../ftrace/test.d/trigger/trigger-hist-mod.tc      |   12 -----
 .../ftrace/test.d/trigger/trigger-hist.tc          |   12 -----
 .../ftrace/test.d/trigger/trigger-multihist.tc     |   16 ------
 .../ftrace/test.d/trigger/trigger-snapshot.tc      |   12 -----
 .../ftrace/test.d/trigger/trigger-stacktrace.tc    |   12 -----
 .../test.d/trigger/trigger-trace-marker-hist.tc    |   11 ----
 .../trigger/trigger-trace-marker-snapshot.tc       |   16 +-----
 .../trigger-trace-marker-synthetic-kernel.tc       |   12 -----
 .../trigger/trigger-trace-marker-synthetic.tc      |   12 -----
 .../ftrace/test.d/trigger/trigger-traceonoff.tc    |   12 -----
 59 files changed, 388 insertions(+), 412 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/nop.tc

--
Masami Hiramatsu (Linaro)
