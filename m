Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226QbH3IXYW+8YLzaeVVf5ml+js3CG0rSqqdtWYX1y4VE4at9lZMOSPgxQD4HKNhawBIjLJW
ARC-Seal: i=1; a=rsa-sha256; t=1519224927; cv=none;
        d=google.com; s=arc-20160816;
        b=gCUcTSlDjwwMgi7PVO9h454Td9kh5KQKTMfxPKCxuu1brCyMuGOjmzOhVBVBYARv0O
         2iroiIAtTrP08flkbwgZb++zliNc4b6kMrXPwYyy8HSdgs8krcG8RuSLeXTs7LpPu3X8
         Wt0h53dv36tZtMjkCgAIBO/27xxvsNE/9Hxa0E7+HUCbhsUI0FyjNnADts4FlM545K2W
         IDnP1R9tC4/cRCC0iPmtcBBeDat8XtClD4kgu7kX0Z24sy3IEKSmn7kfa7ts3lvwA27W
         Bo66ZGUjCJsmZ0TFvwZBfsxQy4gSLGI7UIIPNocNHUv/5tpXw5vtXfSsmfvZNXt1qK2/
         dCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=DePPXDiZMglkrPpx1Rt++dr2PeWN4e21+v62yQkIvC0=;
        b=hfJKY7tj+LdPant2GRJlp8RhDfLQmD/t+gs+2QG3fVRFQzsBTOU6MsjC/FZjRviuN0
         wog1MXuBXhnC+OnJBbXpgT+nnrmh2f7U58LAG9yFKbFmOQa7MP0Q5bBE1w6oc1HYQcyc
         WXBReew+FbOsOF8vhkk7hXz5IqAec4ynXT+XIzOQzVPWWXo+kct6NIgN6dq5i1w18NPo
         giL5ucHWZ5D8juNXhFEK4oNDWI96DnfUWTKWlqIi+MInKNqSbI/Csi6hUd/yKnwOV1HS
         NV3E0H0In+ErN7NQIUO88dsPGvwMx9FCUC7dmExF1tR9aaraTVabWeCn4d2AsuGYHYw8
         4aRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeBUOyd (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753374AbeBUOyc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:54:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613BD205F4
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
Subject: [PATCH v2 00/17] tracing: probeevent: Improve fetcharg features
Date: Wed, 21 Feb 2018 23:54:06 +0900
Message-Id: <151922484560.6217.1143686155616343906.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022797872064663?=
X-GMAIL-MSGID: =?utf-8?q?1593022797872064663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is the 2nd version of the fetch-arg improvement series.
This includes variable changes on fetcharg framework like,

- Add fetcharg testcases (syntax, argN, symbol, string and array)
- Rewrite fetcharg framework with fetch_insn, switch-case based
  instead of function pointer.
- Add "symbol" type support, which shows symbol+offset instead of
  address value.
- Add "$argN" fetcharg, which fetches function parameters.
  (currently only for x86-64)
- Add array type support (including string arrary :) ) ,
  which enables to get fixed length array from probeevents.

>From the v1, I've added many fixes and testcases. The 2 biggest
change are adding many testcases and support string array.
Note that the first 3 patches ([1/17] - [3/17]) can be applied
independently, since those are a bugfix and testcase for existing
features.

The string array type (e.g. +0(%si):string[2]) is a bit different
from other array types (like x16[8] etc.). For other types,
<base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
as +0(%di):x32.) But "string[1]" is not equal to "string".
The string type itself represents "char array", but string array
type represents "char * array". So, for example, +0(%di):string[1]
is equal to +0(+0(%di)):string.

The 1st version is here:
https://www.spinics.net/lists/linux-trace/msg00583.html

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

Masami Hiramatsu (17):
      tracing: probeevent: Fix to support minus offset from symbol
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      tracing: probeevent: Cleanup print argument functions
      tracing: probeevent: Cleanup argument field definition
      tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
      tracing: probeevent: Introduce new argument fetching code
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
 kernel/trace/trace.c                               |    7 
 kernel/trace/trace_kprobe.c                        |  364 ++++--------
 kernel/trace/trace_probe.c                         |  631 +++++++++-----------
 kernel/trace/trace_probe.h                         |  284 +++------
 kernel/trace/trace_probe_tmpl.h                    |  214 +++++++
 kernel/trace/trace_uprobe.c                        |  168 ++---
 .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 +
 .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   75 ++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   46 +
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   73 ++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   97 +++
 15 files changed, 1165 insertions(+), 891 deletions(-)
 create mode 100644 kernel/trace/trace_probe_tmpl.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
