Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2262OzP+Sp6ApBDhtYrqHrp1LmsFh1dXo+Ohm37KZ7GOjbnkKvungaYjG0vIkkhhUeA0Ausm
ARC-Seal: i=1; a=rsa-sha256; t=1519787990; cv=none;
        d=google.com; s=arc-20160816;
        b=C0BodGjqZqufwLVqGKnH5hhrVtGwYGlQVSeDTrz3VlpZQ99JOS6aLVb271i8zEtoZx
         DJUE0Q7SnQyuR8Er3uYW8Ju6MTeBXYpps9OD08jicidjkTaaD7Ie+4VZgWYbT4NTEDM+
         FsELrI5nT/JHuLRsiQMjR6A0KJiGVpmrVbl3zATiTAuVB2thA0QmFxupHdY7de5ftsBs
         k2zsrV9gU0Tl/o/JKlxyC+J2OP964B/apO5ijwmTUZgq1GNByJ/SO66y0UNkl8wj4EDN
         xqbAz5QLjURv0FHqMijuDFOBk9TX6sxziTdeW2NWRQrurTPqSAgAG+e01PRl/xJRzYG5
         O6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=ZP0yJH1GErsGyFixPE/ymyRB3XFTbNlYGgg7QH7XNdA=;
        b=LKdLbRr+EdQ3+hbCvcDn1EAt+JfLsnxHOtVUHDoMQXUnzFd4lta/13zbL9NiwLloNs
         62WU1OfzyDyfBSAeBrA8VvSSuf/WmgWjpYwxx0GnkIQ7XzwH4NCsUR59x8x2WTA1y/Yu
         eZvGopRalEL0jLDlxaSA/CD/U/bVfv1SslTZsj/hn8JHPzZeV1MabVCW5YKkcOKjMtcE
         e9/sEh+iEEnfH3pJzS0tGCr5R/e9qok8ukEvNH/Q5r/drQZ7wB8M3rYzbWqs2iWptBt4
         65ysNosGEBaN3La2RyIgiL+YOPCLkgDZY74SWwbRVJzBvBukQvOhYupc4dctDWdlYYVS
         9g7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeB1DTu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbeB1DTs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:19:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4142168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v4 00/19] tracing: probeevent: Improve fetcharg features
Date: Wed, 28 Feb 2018 12:19:23 +0900
Message-Id: <151978796240.2577.6531711990653677529.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613212363530705?=
X-GMAIL-MSGID: =?utf-8?q?1593613212363530705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is the 4th version of the fetch-arg improvement series.
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

V3 is here:
 https://lkml.org/lkml/2018/2/24/3 

Changes from the v3 are here:

 - [1/19] Fix to pass a sign to kstrtol (Thanks Namhyung!)
          and check UINT_MAX for kprobe's offset.
 - [4/19] Add new testcase for checking probepoint syntax.
 - [16/19] Fix to use calculated size correctly for field definition.
        (Thank you Namhyung!).
 - [19/19] Add format field tests.

Here are examples:

o 'symbol' type

 # echo 'p vfs_read $stack0:symbol' > kprobe_events 
 # echo 1 > events/kprobes/p_vfs_read_0/enable 
 # tail -n 3 trace
              sh-729   [007] ...2   105.753637: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=SyS_read+0x42/0x90
            tail-736   [000] ...2   105.754904: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=kernel_read+0x2c/0x40
            tail-736   [000] ...2   105.754929: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=kernel_read+0x2c/0x40


o $argN 

 # echo 'p vfs_read $arg0 $arg1 $arg2' > kprobe_events
 # echo 1 > events/kprobes/p_vfs_read_0/enable 
 # tail -n 3 trace
              sh-726   [007] ...2   134.288973: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=0xffff88001d98ec00 arg2=0x7ffeb4330f79 arg3=0x1
            tail-731   [000] ...2   134.289987: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=0xffff88001d9dd200 arg2=0xffff88001d8a0a00 arg3=0x80
            tail-731   [000] ...2   134.290016: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=0xffff88001d9dd200 arg2=0xffff88001faf4a00 arg3=0x150


o Array type

 # echo 'p vfs_read +0($stack):x64 +0($stack):x8[8]' > kprobe_events 
 # echo 1 > events/kprobes/p_vfs_read_0/enable 
 # tail -n 3 trace
              sh-729   [007] ...2    91.701664: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=0xffffffff811b1252 arg2={0x52,0x12,0x1b,0x81,0xff,0xff,0xff,0xff}
            tail-734   [000] ...2    91.702366: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=0xffffffff811b0dec arg2={0xec,0xd,0x1b,0x81,0xff,0xff,0xff,0xff}
            tail-734   [000] ...2    91.702386: p_vfs_read_0: (vfs_read+0x0/0x130) arg1=0xffffffff811b0dec arg2={0xec,0xd,0x1b,0x81,0xff,0xff,0xff,0xff}
 #
 # cat events/kprobes/p_vfs_read_0/format 
name: p_vfs_read_0
ID: 1069
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
	field:u64 arg1;	offset:16;	size:0;	signed:0;
	field:u8 arg2[8];	offset:24;	size:8;	signed:0;

print fmt: "(%lx) arg1=0x%Lx arg2={0x%x,0x%x,0x%x,0x%x,0x%x,0x%x,0x%x,0x%x}", REC->__probe_ip, REC->arg1, REC->arg2[0], REC->arg2[1], REC->arg2[2], REC->arg2[3], REC->arg2[4], REC->arg2[5], REC->arg2[6], REC->arg2[7]

o String Array type

 # echo "p create_trace_kprobe arg1=+0(%si):string[3]" > kprobe_events 
 # echo test1 test2 test3 >> kprobe_events 
sh: write error: Invalid argument
 # echo 'p vfs_read $stack' >> kprobe_events 
 # tail -n 2 trace 
              sh-744   [007] ...1   183.382407: p_create_trace_kprobe_0: (create_trace_kprobe+0x0/0x890) arg1={"test1","test2","test3"}
              sh-744   [007] ...1   230.487809: p_create_trace_kprobe_0: (create_trace_kprobe+0x0/0x890) arg1={"p","vfs_read","$stack"}


Thank you,

---

Masami Hiramatsu (19):
      [BUGFIX] tracing: probeevent: Fix to support minus offset from symbol
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      selftests: ftrace: Add a testcase for probepoint
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


 Documentation/trace/kprobetrace.txt                |   26 +
 arch/Kconfig                                       |    7 
 arch/x86/Kconfig                                   |    1 
 arch/x86/include/asm/ptrace.h                      |   38 +
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace_kprobe.c                        |  366 ++++--------
 kernel/trace/trace_probe.c                         |  628 +++++++++-----------
 kernel/trace/trace_probe.h                         |  284 +++------
 kernel/trace/trace_probe_tmpl.h                    |  214 +++++++
 kernel/trace/trace_uprobe.c                        |  168 ++---
 .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 +
 .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   92 +++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   46 +
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   77 ++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   97 +++
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |   43 +
 16 files changed, 1230 insertions(+), 891 deletions(-)
 create mode 100644 kernel/trace/trace_probe_tmpl.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
