Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934501AbeE2NsQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934327AbeE2NsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:48:13 -0400
Date: Tue, 29 May 2018 10:48:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: heads up: moving intel-pt-decoder/Build header checks to
 check_headers.sh
Message-ID: <20180529134809.GB20886@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

	We've made tools/perf/check-headers.sh the mechanism to check
for drift on kernel file copies we have in tools/, and it assumes that
if we have tools/a/b/c/d, then it came from a/b/c/d in the kernel
sources, e.g. a copy of the kernel's arch/x86/lib/x86-opcode-map.txt
would be in tools/arch/x86/lib/x86-opcode-map.txt.

	That is not the case with the intel-pt-decoder, so I'm thinking
about moving those files to comply with the model used for other copies,
as having it in util/intel-pt-decoder/ isn't strictly required, i.e.
those files could conceivably be used for other purposes besides
decoding intel-pt traces, say for disassembly/annotate, that albeit not
planned (at least by me) for the near future, would be something
interesting to investigate doing.

	IIRC Ingo was the one to point me out this, and now I saw the
warning about it being different flying by in the middle of the build,
differently from what is done by check-headers.sh, that is to show
everything that drifted in one single block, at the start of the build.

	So unless you have a strong objection to this, I'll continue
investigation about how do do it with tools/perf/check-headers.sh,

Thanks,

- Arnaldo

P.S: See how the check-headers.sh stand out at the start and how the
intel-pt-decoder copies get buried in the middle:

[acme@seventh perf]$ rm -rf /tmp/build/perf/ ; mkdir -p /tmp/build/perf ; make -C tools/perf O=/tmp/build/perf install-bin
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep
Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                      libslang: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]

  GEN      /tmp/build/perf/common-cmds.h
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/fd/array.o
  LD       /tmp/build/perf/fd/libapi-in.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/fs/tracing_path.o
  PERF_VERSION = 4.17.rc6.ge91755
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/exec-cmd.o
  CC       /tmp/build/perf/str_error_r.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/help.o
  LD       /tmp/build/perf/libapi-in.o
  CC       /tmp/build/perf/parse-utils.o
  AR       /tmp/build/perf/libapi.a
  CC       /tmp/build/perf/kbuffer-parse.o
  CC       /tmp/build/perf/pager.o
  LD       /tmp/build/perf/libtraceevent-in.o
  CC       /tmp/build/perf/parse-options.o
  LINK     /tmp/build/perf/libtraceevent.a
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  CC       /tmp/build/perf/run-command.o
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  CC       /tmp/build/perf/sigchain.o
  CC       /tmp/build/perf/libbpf.o
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/bpf.o
  LD       /tmp/build/perf/libsubcmd-in.o
  CC       /tmp/build/perf/nlattr.o
  AR       /tmp/build/perf/libsubcmd.a
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  LD       /tmp/build/perf/libbpf-in.o
  MKDIR    /tmp/build/perf/jvmti/
  LINK     /tmp/build/perf/libbpf.a
  CC       /tmp/build/perf/jvmti/libjvmti.o
  MKDIR    /tmp/build/perf/jvmti/
  GEN      perf-archive
  CC       /tmp/build/perf/jvmti/jvmti_agent.o
  GEN      perf-with-kcore
  CC       /tmp/build/perf/plugin_jbd2.o
  MKDIR    /tmp/build/perf/ui/gtk/
  MKDIR    /tmp/build/perf/ui/gtk/
  CC       /tmp/build/perf/ui/gtk/browser.o
  CC       /tmp/build/perf/ui/gtk/hists.o
  LD       /tmp/build/perf/jvmti/jvmti-in.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  MKDIR    /tmp/build/perf/ui/gtk/
  CC       /tmp/build/perf/ui/gtk/setup.o
  CC       /tmp/build/perf/ui/gtk/util.o
  CC       /tmp/build/perf/ui/gtk/helpline.o
  CC       /tmp/build/perf/ui/gtk/progress.o
  CC       /tmp/build/perf/ui/gtk/annotate.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/annotate.o
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  CC       /tmp/build/perf/plugin_kmem.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  CC       /tmp/build/perf/plugin_kvm.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/plugin_mac80211.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  CC       /tmp/build/perf/plugin_function.o
  LD       /tmp/build/perf/plugin_function-in.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/block-range.o
  CC       /tmp/build/perf/plugin_xen.o
  LD       /tmp/build/perf/plugin_xen-in.o
  CC       /tmp/build/perf/plugin_scsi.o
  LD       /tmp/build/perf/ui/gtk/gtk-in.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  LD       /tmp/build/perf/gtk-in.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  CC       /tmp/build/perf/builtin-bench.o
  LINK     /tmp/build/perf/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugin_kmem.so
  CC       /tmp/build/perf/builtin-annotate.o
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LINK     /tmp/build/perf/pmu-events/jevents
  LINK     /tmp/build/perf/plugin_function.so
  LINK     /tmp/build/perf/libperf-jvmti.so
  LINK     /tmp/build/perf/plugin_xen.so
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  INSTALL  trace_plugins
  CC       /tmp/build/perf/builtin-diff.o
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  GEN      /tmp/build/perf/python/perf.so
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/util/ctype.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/util/db-export.o
  CC       /tmp/build/perf/builtin-ftrace.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/builtin-help.o
  CC       /tmp/build/perf/builtin-sched.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/util/mmap.o
  CC       /tmp/build/perf/util/memswap.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
  CC       /tmp/build/perf/util/perf_regs.o
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/util/print_binary.o
  CC       /tmp/build/perf/util/rbtree.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/builtin-kallsyms.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/util/hweight.o
  CC       /tmp/build/perf/util/smt.o
  CC       /tmp/build/perf/util/strbuf.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/arch/common.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/util/top.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/header.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/tsc.o
  CC       /tmp/build/perf/arch/x86/util/pmu.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/util/dso.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/regs_load.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/dwarf-unwind.o
  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  CC       /tmp/build/perf/arch/x86/tests/arch-tests.o
  CC       /tmp/build/perf/arch/x86/tests/rdpmc.o
  CC       /tmp/build/perf/arch/x86/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/arch/x86/util/perf_regs.o
  CC       /tmp/build/perf/arch/x86/util/group.o
  CC       /tmp/build/perf/arch/x86/util/machine.o
  CC       /tmp/build/perf/arch/x86/tests/insn-x86.o
  CC       /tmp/build/perf/arch/x86/util/event.o
  LD       /tmp/build/perf/arch/x86/tests/libperf-in.o
  CC       /tmp/build/perf/arch/x86/util/dwarf-regs.o
  CC       /tmp/build/perf/arch/x86/util/unwind-libunwind.o
  CC       /tmp/build/perf/arch/x86/util/auxtrace.o
  CC       /tmp/build/perf/arch/x86/util/intel-pt.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/util/symbol_fprintf.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/util/metricgroup.o
  CC       /tmp/build/perf/arch/x86/util/intel-bts.o
  CC       /tmp/build/perf/util/header.o
  LD       /tmp/build/perf/arch/x86/util/libperf-in.o
  LD       /tmp/build/perf/arch/x86/libperf-in.o
  LD       /tmp/build/perf/arch/libperf-in.o
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/ui/helpline.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/builtin-report.o
  CC       /tmp/build/perf/util/callchain.o
  CC       /tmp/build/perf/builtin-stat.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/util/values.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/ui/browser.o
  CC       /tmp/build/perf/util/map.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/annotate.o
  CC       /tmp/build/perf/builtin-timechart.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/hists.o
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/util/syscalltbl.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/util/namespaces.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  CC       /tmp/build/perf/util/parse-events-bison.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/ui/browsers/map.o
  CC       /tmp/build/perf/ui/browsers/scripts.o
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/ui/browsers/header.o
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  LD       /tmp/build/perf/ui/browsers/libperf-in.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/setup.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/util.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/ui/tui/helpline.o
  CC       /tmp/build/perf/ui/tui/progress.o
  LD       /tmp/build/perf/ui/tui/libperf-in.o
  LD       /tmp/build/perf/ui/libperf-in.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  CC       /tmp/build/perf/builtin-c2c.o
  CC       /tmp/build/perf/builtin-trace.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/util/xyarray.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/util/cgroup.o
  MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/builtin-probe.o
  LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/libperf-in.o
  CC       /tmp/build/perf/util/target.o
  MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/util/rblist.o
  LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/libperf-in.o
  LD       /tmp/build/perf/scripts/libperf-in.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/counts.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/util/stat.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-pipe.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  CC       /tmp/build/perf/trace/beauty/flock.o
  CC       /tmp/build/perf/bench/mem-functions.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/trace/beauty/ioctl.o
  CC       /tmp/build/perf/tests/builtin-test.o
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  LD       /tmp/build/perf/trace/beauty/libperf-in.o
  CC       /tmp/build/perf/util/stat-shadow.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/tests/parse-events.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/util/record.o
  CC       /tmp/build/perf/util/srcline.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  CC       /tmp/build/perf/bench/numa.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/perf.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/call-path.o
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/auxtrace.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD       /tmp/build/perf/util/intel-pt-decoder/libperf-in.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/util/intel-pt.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  CC       /tmp/build/perf/tests/fdarray.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/tests/hists_output.o
  CC       /tmp/build/perf/util/intel-bts.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  LD       /tmp/build/perf/util/scripting-engines/libperf-in.o
  CC       /tmp/build/perf/util/arm-spe.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/util/arm-spe-pkt-decoder.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/tests/bp_signal.o
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/tests/bp_account.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
  CC       /tmp/build/perf/tests/task-exit.o
  CC       /tmp/build/perf/util/vsprintf.o
  CC       /tmp/build/perf/util/drv_configs.o
  CC       /tmp/build/perf/util/units.o
  CC       /tmp/build/perf/util/time-utils.o
  BISON    /tmp/build/perf/util/expr-bison.c
  CC       /tmp/build/perf/util/branch.o
  CC       /tmp/build/perf/util/mem2node.o
  CC       /tmp/build/perf/util/bpf-loader.o
  CC       /tmp/build/perf/util/bpf-prologue.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/util/symbol-elf.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  CC       /tmp/build/perf/util/probe-file.o
  CC       /tmp/build/perf/tests/thread-mg-share.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  CC       /tmp/build/perf/util/probe-event.o
  CC       /tmp/build/perf/util/probe-finder.o
  CC       /tmp/build/perf/util/dwarf-aux.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/util/dwarf-regs.o
  CC       /tmp/build/perf/util/unwind-libunwind-local.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/util/unwind-libunwind.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/util/data-convert-bt.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/util/zlib.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/util/lzma.o
  CC       /tmp/build/perf/tests/event_update.o
  CC       /tmp/build/perf/util/demangle-java.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/util/demangle-rust.o
  CC       /tmp/build/perf/tests/expr.o
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  CC       /tmp/build/perf/util/jitdump.o
  CC       /tmp/build/perf/tests/sdt.o
  CC       /tmp/build/perf/tests/is_printable_array.o
  CC       /tmp/build/perf/tests/bitmap.o
  CC       /tmp/build/perf/tests/perf-hooks.o
  CC       /tmp/build/perf/tests/clang.o
  CC       /tmp/build/perf/util/genelf.o
  CC       /tmp/build/perf/tests/unit_number__scnprintf.o
  CC       /tmp/build/perf/util/genelf_debug.o
  CC       /tmp/build/perf/util/perf-hooks.o
  CC       /tmp/build/perf/tests/mem2node.o
  CC       /tmp/build/perf/tests/dwarf-unwind.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/pmu-flex.o
  LD       /tmp/build/perf/perf-in.o
  LD       /tmp/build/perf/util/libperf-in.o
  LD       /tmp/build/perf/libperf-in.o
  AR       /tmp/build/perf/libperf.a
  LINK     /tmp/build/perf/libperf-gtk.so
  LINK     /tmp/build/perf/perf
  INSTALL  GTK UI
  INSTALL  binaries
  INSTALL  tests
  INSTALL  libperf-jvmti.so
  INSTALL  libexec
  INSTALL  lib
  INSTALL  include/bpf
  INSTALL  lib
  INSTALL  examples/bpf
  INSTALL  perf-archive
  INSTALL  perf-with-kcore
  INSTALL  strace/groups
  INSTALL  perl-scripts
  INSTALL  python-scripts
  INSTALL  perf_completion-script
  INSTALL  perf-tip
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@seventh perf]$ 
