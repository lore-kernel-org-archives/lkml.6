Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCLJnT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752366AbeCLJnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:17 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Brendan Gregg <bgregg@netflix.com>,
        Stanislav Kozina <skozina@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>, Will Cohen <wcohen@redhat.com>,
        Eugene Syromiatnikov <esyromia@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC 00/13] perf bpf: Add support to run BEGIN/END code
Date: Mon, 12 Mar 2018 10:43:00 +0100
Message-Id: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this is *RFC* and the following patchset is very rough
and ugly 'prove of concept'-kind-of-toy code. I'm mostly
interested in opinions about if this could be useful in
your current eBPF usage.

Currently we can load eBPF code within the record command
and attach it to event. We have 2 ways of communicating
the data back to user: bpf-output event that goes to
perf.data or 'trace_printk' output in tracefs buffer.

AFAICS we're not covering quite large usage base that runs
code before and once the probe is finished to setup, collect
and display the collected data.

This patchset is adding support to run BEGIN and END
code snipets before and after eBPF probe is loaded.

This allow to write 'collecting' code in eBPF object,
like in the attached example (it's also part of the
patchset).

This patchset also adds 'bpf' command to ease up the
loading of eBPF files with options for compilation
and disassembly of eBPF objects:

      $ perf bpf -c samples/syscall-counts.c
      LLVM: dumping samples/syscall-counts.o

      $ perf bpf -d samples/syscall-counts.o | head
      Disassembly of raw_syscalls:sys_enter:
         0: (b7) r1 = 1
             b7 01 00 00 01 00 00 00
         1: (7b) *(u64 *)(r10 -8) = r1
             7b 1a f8 ff 00 00 00 00
         2: (bf) r6 = r10
      ...

      $ sudo perf bpf -e samples/syscall-counts.o -a
      BEGIN
      ^CEND
                    comm            value
                 firefox              182
           Socket Thread                8
         InotifyEventThr               26
         xmonad-x86_64-l              405
      ...

The patchset is also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/bpf

So far I need following following lines in .perfconfig to run this:
  [llvm]
  kbuild-dir=/home/jolsa/kernel/linux-perf
  clang-opt=-I/home/jolsa/kernel/linux-perf/tools/perf/util


thoughts? ;-) thanks,
jirka


Cc: Brendan Gregg <bgregg@netflix.com>
Cc: Stanislav Kozina <skozina@redhat.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Will Cohen <wcohen@redhat.com>
Cc: Eugene Syromiatnikov <esyromia@redhat.com>
Cc: Jerome Marchand <jmarchan@redhat.com>

---
#include <uapi/linux/bpf.h>
#include <bpf-helpers.h>
#include <bpf-userfuncs.h>

#define TASK_COMM_LEN 16

char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;

struct key_t {
        char comm[TASK_COMM_LEN];
};

struct bpf_map_def SEC("maps") counts_map = {
        .type = BPF_MAP_TYPE_HASH,
        .key_size = sizeof(struct key_t),
        .value_size = sizeof(u64),
        .max_entries = 100,
};

SEC("raw_syscalls:sys_enter")
int func(void *ctx)
{
        u64 *val, one = 1;
        struct key_t key;
        char comm[TASK_COMM_LEN];

        bpf_get_current_comm(&key.comm, sizeof(comm));

        val = bpf_map_lookup_elem(&counts_map, &key);
        if (val)
                (*val)++;
        else
                bpf_map_update_elem(&counts_map, &key, &one, BPF_NOEXIST);

        return 0;
}

int BEGIN(void)
{
        print("BEGIN\n");
        return 0;
}

void END(void)
{
        struct key_t key = {}, next_key;
        u64 value;
        int i = 0;

        print("END\n");
        print("\n              comm            value\n");

        while (bpfu_map_get_next_key(&counts_map, &key, &next_key) == 0) {
                if (bpfu_map_lookup_elem(&counts_map, &next_key, &value))
                        continue;

                print("%18s %16lu\n", next_key.comm, value);
                key = next_key;
        }
}

---
Jiri Olsa (13):
      lib bpf: Add bpf_program__insns function
      perf tools: Display ebpf compiling command in debug output
      perf tools: Add bpf command
      perf tools: Add bpf__compile function
      perf bpf: Add compile option
      perf bpf: Add disasm option
      libbpf: Make bpf_program__next skip .text section
      libbpf: Collect begin/end .text functions
      libbpf: Add bpf_insn__interpret function
      libbpf: Add bpf_object__run_(begin|end) functions
      perf bpf: Add helper header files
      perf bpf: Run begin/end programs
      perf samples: Add syscall-count.c object

 tools/lib/bpf/Build                 |   2 +-
 tools/lib/bpf/interp.c              | 245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c              | 125 +++++++++++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h              |   7 +++
 tools/perf/Build                    |   7 +++
 tools/perf/Makefile.config          |   1 +
 tools/perf/builtin-bpf.c            | 319 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h                |   1 +
 tools/perf/command-list.txt         |   1 +
 tools/perf/perf.c                   |   1 +
 tools/perf/samples/syscall-counts.c |  61 ++++++++++++++++++++++++
 tools/perf/util/bpf-helpers.h       | 246 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-loader.c        | 124 ++++++++++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/bpf-loader.h        |   4 ++
 tools/perf/util/bpf-userapi.h       |  11 +++++
 tools/perf/util/bpf-userfuncs.h     |  19 ++++++++
 tools/perf/util/llvm-utils.c        |  14 ++++++
 17 files changed, 1173 insertions(+), 15 deletions(-)
 create mode 100644 tools/lib/bpf/interp.c
 create mode 100644 tools/perf/builtin-bpf.c
 create mode 100644 tools/perf/samples/syscall-counts.c
 create mode 100644 tools/perf/util/bpf-helpers.h
 create mode 100644 tools/perf/util/bpf-userapi.h
 create mode 100644 tools/perf/util/bpf-userfuncs.h
