Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933876AbeBMPgM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933442AbeBMPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:36:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3C721780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org
Subject: [RFC PATCH 0/8] tracing: probeevent: Improve fetcharg features
Date: Wed, 14 Feb 2018 00:35:45 +0900
Message-Id: <151853614489.31487.10683006682475678487.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series improves probeevent variable fetcharg framework,

- Rewrite fetcharg framework with fetch_insn, switch-case based
  instead of function pointer. (maybe good for retpoline)
- Add "symbol" type support, which shows symbol+offset instead of
  address value.
- Add "$argN" fetcharg, which fetches function parameters.
  (currently only for x86-64)
- Add array type support for basic types (except for string),
  which enables to get fixed length array from probeevents.

All ideas came from Steve's function event tracer. Thanks Steve!

I'll add string (pointer) array support and testcases for these
features in the next version.

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


Thanks,

---

Masami Hiramatsu (8):
      tracing: probeevent: Cleanup print argument functions
      tracing: probeevent: Cleanup argument field definition
      tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
      tracing: probeevent: Introduce new argument fetching code
      tracing: probeevent: Add symbol type
      x86: ptrace: Add function argument access API
      tracing: probeevent: Add $argN for accessing function args
      tracing: probeevent: Add an array for basic types


 Documentation/trace/kprobetrace.txt |   20 +
 arch/Kconfig                        |    7 
 arch/x86/Kconfig                    |    1 
 arch/x86/include/asm/ptrace.h       |   38 ++
 kernel/trace/trace_kprobe.c         |  396 +++++++++--------------
 kernel/trace/trace_probe.c          |  614 ++++++++++++++++-------------------
 kernel/trace/trace_probe.h          |  313 +++++++++---------
 kernel/trace/trace_uprobe.c         |  188 ++++++-----
 8 files changed, 771 insertions(+), 806 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
