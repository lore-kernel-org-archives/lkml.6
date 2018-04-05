Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeDEPQx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:16:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDEPQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:16:52 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [RFC 0/9] bpf: Add buildid check support
Date: Thu,  5 Apr 2018 17:16:36 +0200
Message-Id: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
eBPF programs loaded for kprobes are allowed to read kernel
internal structures. We check the provided kernel version
to ensure that the program is loaded for the proper kernel. 

The problem is that the version check is not enough, because
it only follows the version setup from kernel's Makefile.
However, the internal kernel structures change based on the
.config data, so in practise we have different kernels with
same version.

The eBPF kprobe program thus then get loaded for different
kernel than it's been built for, get wrong data (silently)
and provide misleading output.

This patchset implements additional check in eBPF loading code
on provided build ID (from kernel's elf image, .notes section
GNU build ID) to ensure we load the eBPF program on correct
kernel.

Also available in here (based on bpf-next/master):
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/checksum

This patchset consists of several changes:

- adding CONFIG_BUILDID_H option that instructs the build
  to generate uapi header file with build ID data, that
  will be included by eBPF program

- adding CONFIG_BPF_BUILDID_CHECK option and new bpf_attr
  field to allow build ID checking when loading the eBPF
  program

- changing libbpf to read and pass build ID to the kernel

- several small side fixes

- example perf eBPF code in bpf-samples/bpf-stdout-example.c
  to show the build ID support/usage.

    # perf record -vv  -e ./bpf-samples/bpf-stdout-example.c kill 2>&1 | grep buildid
    libbpf: section(7) buildid, size 21, link 0, flags 3, type=1
    libbpf: kernel buildid of ./bpf-samples/bpf-stdout-example.c is: 6e25edeb408513184e2753bebad25d42314501a0

  The buildid is provided the same way we provide kernel
  version, in a special "buildid" section:

    # cat ./bpf-samples/bpf-stdout-example.c
    ...
    #include <linux/buildid.h>

    char _buildid[] SEC("buildid") = LINUX_BUILDID_DATA;
    ...

  where LINUX_BUILDID_DATA is defined in the generated buildid.h.

please note it's an RFC ;-) any comments and suggestions are welcome

thanks,
jirka


---
Jiri Olsa (9):
      perf tools: Make read_build_id function public
      perf tools: Add fetch_kernel_buildid function
      kbuild: Do not pass arguments to link-vmlinux.sh
      kbuild: Add filechk2 function
      bpf: Add CONFIG_BUILDID_H option
      bpf: Add CONFIG_BPF_BUILDID_CHECK option
      libbpf: Synchronize uapi bpf.h header
      libbpf: Add support to attach buildid to program load
      perf tools: The buildid usage in example eBPF program

 Makefile                                    | 14 +++++++++++++-
 include/uapi/linux/bpf.h                    |  2 ++
 init/Kconfig                                | 12 ++++++++++++
 kernel/bpf/syscall.c                        | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 scripts/Kbuild.include                      | 24 ++++++++++++++++++++++++
 scripts/Makefile                            |  1 +
 scripts/extract-buildid.c                   | 42 ++++++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/Makefile                  |  5 ++++-
 tools/include/uapi/linux/bpf.h              |  3 +++
 tools/lib/bpf/bpf.c                         |  6 ++++--
 tools/lib/bpf/bpf.h                         |  5 +++--
 tools/lib/bpf/libbpf.c                      | 46 ++++++++++++++++++++++++++++++++++++++++------
 tools/perf/bpf-samples/bpf-stdout-example.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/bpf.c                      |  9 ++++++++-
 tools/perf/util/symbol-minimal.c            | 50 ++------------------------------------------------
 tools/perf/util/util.c                      | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/util.h                      |  6 ++++++
 17 files changed, 355 insertions(+), 62 deletions(-)
 create mode 100644 scripts/extract-buildid.c
 create mode 100644 tools/perf/bpf-samples/bpf-stdout-example.c
