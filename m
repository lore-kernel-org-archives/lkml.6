Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+q959eZsV7fk5zjCWS1SKX/RDf9cxui2QS9Q77DFp11JmRN3mabLBxsi/ck9FaLREd9JXM
ARC-Seal: i=1; a=rsa-sha256; t=1524658593; cv=none;
        d=google.com; s=arc-20160816;
        b=R3pdRPwUaU+1xSGlB3Lxzgg9AoNk+P4KO2K3u9WCU4nWSKvkT3DRj5Wl85n9H1/9HA
         izdHDewXKW1xlseveOXFomsE75vLPPEnof6CrIsyJugmEBv2/vHEKXxnGZU97kQG5qOr
         OlMXXi36MsX4LQJ58IETJbjugWcTROLWyNyufNEEnEkwLz5XGcPQjv+g387yD9UZOuj0
         yVPo+cqhgnuEtX2qyDY7bJ8nOTzR24rj45iFY0llh2Sk9E4Lz7zSyks/PLjYSqa3vuiR
         0pIHuXSpTTUdQmV9BzAJkMPbTWslisbSelmOFx7rt/GDzBMAUF0+KeOc3VNM6mAcMW4u
         U73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=v7U0xy+/zvfwVFvUbGlo8YmAvWhDAZXHvouOd5REBGw=;
        b=CGvCm3sz/jp3jfgTcoft5KlgcAXMzPhmND9CAORu3yz4f2Tjx7fFFix5ODjMOg5rpD
         DeVU9Eh0sNX8lykJlCakFB54P9W10iTrW3t0IWhNRshNKJvN2VSLigYfM8Ky7JQTSjm+
         KoFAHj4aJyjY2BFS/C5rrFMULTWgXKWkfPnX4NEeDUpu8TiPeYu+GdkORvQq0XykeouV
         KWZ7heKMmvkt5XJDK2L9+lmfIHwyi+ro0hd5679qXgQY+DYbsIfx6oO98I/ofeiuqaPB
         qwZbJfCqaXUu81cn2ZRfJihIc6RzVFg1wDYj+VI2ysJm30QdNn8V7ijk9koTURBtp0MM
         cU8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeDYMQc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeDYMQb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:16:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B2C21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Date: Wed, 25 Apr 2018 21:16:06 +0900
Message-Id: <152465856498.26224.16969986455942749517.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720408935389499?=
X-GMAIL-MSGID: =?utf-8?q?1598720408935389499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is the 7th version of the fetch-arg improvement series.
This includes variable changes on fetcharg framework like,

- Add fetcharg testcases (syntax, argN, symbol, string and array)
  and probepoint testcase.
- Rewrite fetcharg framework with fetch_insn, switch-case based
  instead of function pointer.
- Add "symbol" type support, which shows symbol+offset instead of
  address value.
- Add "$argN" fetcharg, which fetches function parameters.
  (currently only for x86-64)
- Add array type support (including string arrary :) ) ,
  which enables to get fixed length array from probe-events.
- Add array type support for perf-probe, so that user can
  dump partial array entries.

V6 is here:
 https://lkml.org/lkml/2018/3/17/75

Changes from the v6 are here:
 [6/16]  - Fix to return an error if failed to fetch string and
        fill zero-length data_loc in error case.
 [11/16] - Update document for restructured text.
 [15/16] - Fix README test.
 [16/16] - Add type-casting description (and note) to documentation.

And rebased on the latest Steve's ftrace/core branch.

Thank you,

---

Masami Hiramatsu (16):
      tracing: probeevent: Cleanup print argument functions
      tracing: probeevent: Cleanup argument field definition
      tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
      tracing: probeevent: Introduce new argument fetching code
      tracing: probeevent: Unify fetch type tables
      tracing: probeevent: Return consumed bytes of dynamic area
      tracing: probeevent: Append traceprobe_ for exported function
      tracing: probeevent: Unify fetch_insn processing common part
      tracing: probeevent: Add symbol type
      x86: ptrace: Add function argument access API
      tracing: probeevent: Add $argN for accessing function args
      tracing: probeevent: Add array type support
      selftests: ftrace: Add a testcase for symbol type
      selftests: ftrace: Add a testcase for $argN with kprobe_event
      selftests: ftrace: Add a testcase for array type with kprobe_event
      perf-probe: Add array argument support


 Documentation/trace/kprobetrace.rst                |   23 +
 arch/Kconfig                                       |    7 
 arch/x86/Kconfig                                   |    1 
 arch/x86/include/asm/ptrace.h                      |   38 +
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace_kprobe.c                        |  358 ++++--------
 kernel/trace/trace_probe.c                         |  620 +++++++++-----------
 kernel/trace/trace_probe.h                         |  282 +++------
 kernel/trace/trace_probe_tmpl.h                    |  216 +++++++
 kernel/trace/trace_uprobe.c                        |  176 ++----
 tools/perf/Documentation/perf-probe.txt            |   12 
 tools/perf/util/probe-event.c                      |   20 +
 tools/perf/util/probe-event.h                      |    2 
 tools/perf/util/probe-file.c                       |    5 
 tools/perf/util/probe-file.h                       |    1 
 tools/perf/util/probe-finder.c                     |   95 ++-
 .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 +
 .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   92 +++
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   77 ++
 19 files changed, 1127 insertions(+), 932 deletions(-)
 create mode 100644 kernel/trace/trace_probe_tmpl.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
