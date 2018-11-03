Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D0C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAB02082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8ejecIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAB02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeKDIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:16:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53907 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeKDIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:16:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so4904667wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o1+nvI1A8lAiNNwY8IaZyHRE99FXzRqQ0x2poLNwu10=;
        b=J8ejecIge04+YuHjo8icOVasHzItxlMpaJE4A61zIZlkh1s2rTT7w7C9RoX5ZaDAMi
         03ibQdYZCMMVHpV46KfrkfDvlNxTIbwbQrDbNyNwlJVvsQGqsKBsJONZ8kmWLhMRoX6n
         iphzuyGRoA9lK6EWeqMAsRxkFgz7OOpoPZVJnQtrt3QU0xGsQzEGQbMK+Ed1lKGcdQ6S
         5hieUWU3g/PnqLdh1OL8xCESz8oLe7qolRH/oAsLdz0EhK51qNC01ClhrSALbXTSmIca
         c6tF7FjaLX8Wxf6ngOYQyynLdJ+TT/gAvVm3TU26WUFjxqZeTS/qZvn7yqVO1kwq2QCq
         jCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=o1+nvI1A8lAiNNwY8IaZyHRE99FXzRqQ0x2poLNwu10=;
        b=igfd4GDioRhvkkGQyYz1nuTG8YoM3Ghkun378p/7m4bEazmBicNTJNmLB47kYJR1+R
         RCw5o6brhZNJERfcRS9HHSOVXYsSMUTZp7dDU7f6aykq5wXn+vtr6k/WLCBhq8WIcEO1
         /H9Bfp0TC+QLKT0HTgYe5luijuTEaJz3Hw37nXgAdWd9O1dVBefslb2FH5gCjLBzIu9R
         1q8cH+60WDM+dpTdXZihWkXLCcnqOD4m0lrwfheijGx3oiIIuMt2gmehZe2LDlTl0U3M
         qhhbDU56trCgdvGZOThHwC2nEEHrVF9ELdEf79wLFWDie22DImcUZch3aSeGuzuFnHm+
         1Puw==
X-Gm-Message-State: AGRZ1gInMkOnsG4trgUbV9VowmITyNHvIMB7t3GrB2Q+8l/rB7jhW37s
        zIbnPvQ6dt9FTwLhD7NDff0=
X-Google-Smtp-Source: AJdET5duOHnXye2GZAcy2ES0Kk9sTMQJqSnA2vOoGn5B4VP6lmGSHAyXmg+i7nwQCVFnyi39qcLClw==
X-Received: by 2002:a1c:1752:: with SMTP id 79-v6mr1948957wmx.145.1541286204792;
        Sat, 03 Nov 2018 16:03:24 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c24-v6sm67868993wre.44.2018.11.03.16.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 16:03:24 -0700 (PDT)
Date:   Sun, 4 Nov 2018 00:03:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] perf updates/fixes
Message-ID: <20181103230322.GA62400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 29995d296e3e9ce4f9767963ecbef143ade26c36 Merge tag 'perf-urgent-for-mingo-4.20-20181031' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

These are almost all tooling updates: 'perf top', 'perf trace' and 'perf 
script' fixes and updates, an UAPI header sync with the merge window 
versions, license marker updates, much improved Sparc support from David 
Miller, and a number of fixes.

 Thanks,

	Ingo

------------------>
Adrian Hunter (19):
      perf scripts python: call-graph-from-sql.py: Use SPDX license identifier
      perf scripts python: call-graph-from-sql.py: Provide better default column sizes
      perf scripts python: call-graph-from-sql.py: Set a minimum window size
      perf scripts python: call-graph-from-sql.py: Change icon
      perf scripts python: call-graph-from-sql.py: Make a "Main" function
      perf scripts python: call-graph-from-sql.py: Separate the database details into a class
      perf scripts python: call-graph-from-sql.py: Add a class for global data
      perf scripts python: call-graph-from-sql.py: Remove use of setObjectName()
      perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel
      perf scripts python: call-graph-from-sql.py: Add data helper functions
      perf scripts python: call-graph-from-sql.py: Refactor TreeItem class
      perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py
      perf scripts python: exported-sql-viewer.py: Add support for multiple sub-windows
      perf scripts python: exported-sql-viewer.py: Add ability to find symbols in the call-graph
      perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font
      perf scripts python: exported-sql-viewer.py: Add ability to display all the database tables
      perf scripts python: exported-sql-viewer.py: Add All branches report
      perf intel-pt: Insert callchain context into synthesized callchains
      perf intel-pt/bts: Calculate cpumode for synthesized samples

Alexey Budankov (1):
      perf record: Encode -k clockid frequency into Perf trace

Andi Kleen (5):
      perf script: Add --insn-trace for instruction decoding
      perf script: Make itrace script default to all calls
      tools script: Add --call-trace and --call-ret-trace
      perf script: Implement --graph-function
      perf script: Support total cycles count

Arnaldo Carvalho de Melo (28):
      tools lib subcmd: Introduce OPTION_ULONG
      perf trace: Introduce --max-events
      perf evsel: Introduce per event max_events property
      perf evsel: Mark a evsel as disabled when asking the kernel do disable it
      perf trace: Drop addr_location refcounts
      perf trace: Drop thread refcount in trace__event_handler()
      perf trace: Introduce per-event maximum number of events property
      tools include uapi: Grab a copy of linux/fs.h
      perf beauty: Add a generator for MS_ mount/umount's flag constants
      perf beauty: Switch from GPL v2.0 to LGPL v2.1
      perf beauty: Introduce strarray__scnprintf_flags()
      perf trace beauty: Allow syscalls to mask an argument before considering it
      perf trace beauty: Beautify mount/umount's 'flags' argument
      perf trace: Consider syscall aliases too
      perf trace: Beautify the umount's 'name' argument
      perf trace: Beautify mount's first pathname arg
      perf top: Allow disabling the overwrite mode
      perf top: Do not use overwrite mode by default
      tools include uapi: Update linux/fs.h copy
      tools arch uapi: Update asm-generic/unistd.h and arm64 unistd.h copies
      tools include uapi: Update asound.h copy
      perf beauty: Add a generator for MAP_ mmap's flag constants
      perf beauty: Wire up the mmap flags table generator to the Makefile
      perf trace beauty: Use the mmap flags table generated from headers
      tools include uapi: Update linux/mmap.h copy
      tools headers: Sync the various kvm.h header copies
      tools headers uapi: Update linux/netlink.h header copy
      tools headers uapi: Update linux/if_link.h header copy

Colin Ian King (1):
      perf/core: Clean up inconsisent indentation

David Miller (5):
      perf annotate: Add Sparc support
      perf jitdump: Add Sparc support.
      perf symbols: Set PLT entry/header sizes properly on Sparc
      perf top: Start display thread earlier
      perf tools: Don't clone maps from parent when synthesizing forks

David S. Miller (1):
      perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}

Hongxu Jia (1):
      perf arm64: Fix generate system call table failed with /tmp mounted with noexec

Jiri Olsa (1):
      perf stat: Poll for monitored tasks being alive

Leo Yan (1):
      perf cs-etm: Correct CPU mode for samples

Milian Wolff (3):
      perf script: Allow extended console debug output
      perf script: Flush output stream after events in verbose mode
      perf unwind: Take pgoff into account when reporting elf to libdwfl


 include/uapi/linux/perf_event.h                    |    2 +
 kernel/events/core.c                               |    2 +-
 tools/arch/arm64/include/uapi/asm/unistd.h         |    1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |    1 +
 tools/arch/s390/include/uapi/asm/kvm.h             |    2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |    6 +-
 tools/include/uapi/asm-generic/unistd.h            |    2 +
 tools/include/uapi/linux/fs.h                      |  393 ++++
 tools/include/uapi/linux/if_link.h                 |    1 +
 tools/include/uapi/linux/kvm.h                     |   21 +-
 tools/include/uapi/linux/mman.h                    |    2 +
 tools/include/uapi/linux/netlink.h                 |    1 +
 tools/include/uapi/linux/perf_event.h              |    2 +
 tools/include/uapi/sound/asound.h                  |    2 +-
 tools/lib/subcmd/parse-options.c                   |   19 +
 tools/lib/subcmd/parse-options.h                   |    2 +
 tools/perf/Documentation/build-xed.txt             |   19 +
 tools/perf/Documentation/intel-pt.txt              |    2 +-
 tools/perf/Documentation/itrace.txt                |    7 +-
 tools/perf/Documentation/perf-script.txt           |   18 +
 tools/perf/Documentation/perf-top.txt              |   10 +
 tools/perf/Documentation/perf-trace.txt            |   67 +
 tools/perf/Makefile.perf                           |   19 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |    2 +-
 tools/perf/arch/sparc/Makefile                     |    2 +
 tools/perf/arch/sparc/annotate/instructions.c      |  169 ++
 tools/perf/builtin-record.c                        |   24 +-
 tools/perf/builtin-script.c                        |  166 +-
 tools/perf/builtin-stat.c                          |   24 +
 tools/perf/builtin-top.c                           |   21 +-
 tools/perf/builtin-trace.c                         |   98 +-
 tools/perf/check-headers.sh                        |    1 +
 tools/perf/perf.h                                  |    1 +
 tools/perf/scripts/python/call-graph-from-sql.py   |  339 ----
 tools/perf/scripts/python/export-to-postgresql.py  |    2 +-
 tools/perf/scripts/python/export-to-sqlite.py      |    2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 2128 ++++++++++++++++++++
 tools/perf/trace/beauty/Build                      |    1 +
 tools/perf/trace/beauty/beauty.h                   |    7 +
 tools/perf/trace/beauty/clone.c                    |    3 +-
 tools/perf/trace/beauty/drm_ioctl.sh               |    1 +
 tools/perf/trace/beauty/eventfd.c                  |    2 +-
 tools/perf/trace/beauty/fcntl.c                    |    3 +-
 tools/perf/trace/beauty/flock.c                    |    2 +-
 tools/perf/trace/beauty/futex_op.c                 |    2 +-
 tools/perf/trace/beauty/futex_val3.c               |    2 +-
 tools/perf/trace/beauty/ioctl.c                    |    3 +-
 tools/perf/trace/beauty/kcmp.c                     |    3 +-
 tools/perf/trace/beauty/kcmp_type.sh               |    1 +
 tools/perf/trace/beauty/kvm_ioctl.sh               |    1 +
 tools/perf/trace/beauty/madvise_behavior.sh        |    1 +
 tools/perf/trace/beauty/mmap.c                     |   50 +-
 tools/perf/trace/beauty/mmap_flags.sh              |   32 +
 tools/perf/trace/beauty/mode_t.c                   |    2 +-
 tools/perf/trace/beauty/mount_flags.c              |   43 +
 tools/perf/trace/beauty/mount_flags.sh             |   15 +
 tools/perf/trace/beauty/msg_flags.c                |    2 +-
 tools/perf/trace/beauty/open_flags.c               |    2 +-
 tools/perf/trace/beauty/perf_event_open.c          |    2 +-
 tools/perf/trace/beauty/perf_ioctl.sh              |    1 +
 tools/perf/trace/beauty/pid.c                      |    3 +-
 tools/perf/trace/beauty/pkey_alloc.c               |   30 +-
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  |    1 +
 tools/perf/trace/beauty/prctl.c                    |    3 +-
 tools/perf/trace/beauty/prctl_option.sh            |    1 +
 tools/perf/trace/beauty/sched_policy.c             |    2 +-
 tools/perf/trace/beauty/seccomp.c                  |    2 +-
 tools/perf/trace/beauty/signum.c                   |    2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |    1 +
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |    1 +
 tools/perf/trace/beauty/sockaddr.c                 |    2 +-
 tools/perf/trace/beauty/socket.c                   |    2 +-
 tools/perf/trace/beauty/socket_ipproto.sh          |    1 +
 tools/perf/trace/beauty/socket_type.c              |    2 +-
 tools/perf/trace/beauty/statx.c                    |    3 +-
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |    1 +
 tools/perf/trace/beauty/waitid_options.c           |    2 +-
 tools/perf/util/annotate.c                         |    8 +
 tools/perf/util/auxtrace.c                         |   17 +-
 tools/perf/util/auxtrace.h                         |    5 +-
 tools/perf/util/cs-etm.c                           |   42 +-
 tools/perf/util/env.h                              |    1 +
 tools/perf/util/event.c                            |    1 +
 tools/perf/util/evlist.c                           |    2 +-
 tools/perf/util/evsel.c                            |   27 +-
 tools/perf/util/evsel.h                            |    5 +
 tools/perf/util/genelf.h                           |    6 +
 tools/perf/util/header.c                           |   23 +
 tools/perf/util/header.h                           |    1 +
 tools/perf/util/intel-bts.c                        |   20 +-
 tools/perf/util/intel-pt.c                         |   31 +-
 tools/perf/util/machine.c                          |   54 +-
 tools/perf/util/parse-events.c                     |    8 +
 tools/perf/util/parse-events.h                     |    1 +
 tools/perf/util/parse-events.l                     |    1 +
 tools/perf/util/symbol-elf.c                       |   12 +-
 tools/perf/util/symbol.h                           |    3 +-
 tools/perf/util/thread-stack.c                     |   44 +-
 tools/perf/util/thread-stack.h                     |    2 +-
 tools/perf/util/thread.c                           |   13 +-
 tools/perf/util/thread.h                           |    4 +-
 tools/perf/util/unwind-libdw.c                     |    4 +-
 102 files changed, 3616 insertions(+), 539 deletions(-)
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100644 tools/perf/Documentation/build-xed.txt
 create mode 100644 tools/perf/arch/sparc/annotate/instructions.c
 delete mode 100644 tools/perf/scripts/python/call-graph-from-sql.py
 create mode 100755 tools/perf/scripts/python/exported-sql-viewer.py
 create mode 100755 tools/perf/trace/beauty/mmap_flags.sh
 create mode 100644 tools/perf/trace/beauty/mount_flags.c
 create mode 100755 tools/perf/trace/beauty/mount_flags.sh

