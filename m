Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99974C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4A820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfAKHuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:50:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfAKHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:50:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0B7o7pK561741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Jan 2019 23:50:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0B7o6pn561729;
        Thu, 10 Jan 2019 23:50:06 -0800
Date:   Thu, 10 Jan 2019 23:50:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-0206131811fa6e4b3ed64b5f1c107e2815dcab42@git.kernel.org>
Cc:     mingo@kernel.org, ravi.bangoria@linux.ibm.com, mpe@ellerman.id.au,
        hpa@zytor.com, jolsa@redhat.com, tglx@linutronix.de,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
          mpe@ellerman.id.au, mingo@kernel.org, ravi.bangoria@linux.ibm.com
In-Reply-To: <20190110094936.3132-1-ravi.bangoria@linux.ibm.com>
References: <20190110094936.3132-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf powerpc: Rework syscall table generation
Git-Commit-ID: 0206131811fa6e4b3ed64b5f1c107e2815dcab42
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0206131811fa6e4b3ed64b5f1c107e2815dcab42
Gitweb:     https://git.kernel.org/tip/0206131811fa6e4b3ed64b5f1c107e2815dcab42
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Thu, 10 Jan 2019 15:19:35 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 10 Jan 2019 10:34:52 -0300

perf powerpc: Rework syscall table generation

Commit aff850393200 ("powerpc: add system call table generation
support") changed how systemcall table is generated for powerpc.
Incorporate these changes into perf as well.

Committer testing:

  $ podman run --entrypoint=/bin/sh --privileged -v /home/acme/git:/git --rm -ti docker.io/acmel/linux-perf-tools-build-ubuntu:18.04-x-powerpc64
  perfbuilder@d7a7af166a80:/git/perf$ head -2 /etc/os-release
  NAME="Ubuntu"
  VERSION="18.04.1 LTS (Bionic Beaver)"
  perfbuilder@d7a7af166a80:/git/perf$
  perfbuilder@d7a7af166a80:/git/perf$ make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- EXTRA_CFLAGS= -C /git/linux/tools/perf O=/tmp/build/perf
  make: Entering directory '/git/linux/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
    HOSTCC   /tmp/build/perf/fixdep.o
    HOSTLD   /tmp/build/perf/fixdep-in.o
    LINK     /tmp/build/perf/fixdep
  Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
  diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h
  sh: 1: command: Illegal option -c

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ OFF ]
  ...                      libaudit: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libelf: [ on  ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                      libslang: [ OFF ]
  ...                     libcrypto: [ OFF ]
  ...                     libunwind: [ OFF ]
  ...            libdw-dwarf-unwind: [ on  ]
  ...                          zlib: [ on  ]
  ...                          lzma: [ OFF ]
  ...                     get_cpuid: [ OFF ]
  ...                           bpf: [ on  ]

  Makefile.config:445: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
  Makefile.config:491: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
  Makefile.config:583: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
  Makefile.config:598: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
  Makefile.config:612: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
  Makefile.config:639: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
  Makefile.config:666: No python interpreter was found: disables Python support - please install python-devel/python-dev
  Makefile.config:721: No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling
  Makefile.config:750: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
  Makefile.config:763: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
  Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
  Makefile.config:840: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
    GEN      /tmp/build/perf/common-cmds.h
  <SNIP>
    CC       /tmp/build/perf/util/syscalltbl.o
  <SNIP>
    LD       /tmp/build/perf/libperf-in.o
    AR       /tmp/build/perf/libperf.a
    LINK     /tmp/build/perf/perf
  make: Leaving directory '/git/linux/tools/perf'
  perfbuilder@d7a7af166a80:/git/perf$ head /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c
  static const char *syscalltbl_powerpc_64[] = {
  	[0] = "restart_syscall",
  	[1] = "exit",
  	[2] = "fork",
  	[3] = "read",
  	[4] = "write",
  	[5] = "open",
  	[6] = "close",
  	[7] = "waitpid",
  	[8] = "creat",
  perfbuilder@d7a7af166a80:/git/perf$ tail /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c
  	[381] = "pwritev2",
  	[382] = "kexec_file_load",
  	[383] = "statx",
  	[384] = "pkey_alloc",
  	[385] = "pkey_free",
  	[386] = "pkey_mprotect",
  	[387] = "rseq",
  	[388] = "io_pgetevents",
  };
  #define SYSCALLTBL_POWERPC_64_MAX_ID 388
  perfbuilder@d7a7af166a80:/git/perf$ head /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c
  static const char *syscalltbl_powerpc_32[] = {
  	[0] = "restart_syscall",
  	[1] = "exit",
  	[2] = "fork",
  	[3] = "read",
  	[4] = "write",
  	[5] = "open",
  	[6] = "close",
  	[7] = "waitpid",
  	[8] = "creat",
  perfbuilder@d7a7af166a80:/git/perf$ tail /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c
  	[381] = "pwritev2",
  	[382] = "kexec_file_load",
  	[383] = "statx",
  	[384] = "pkey_alloc",
  	[385] = "pkey_free",
  	[386] = "pkey_mprotect",
  	[387] = "rseq",
  	[388] = "io_pgetevents",
  };
  #define SYSCALLTBL_POWERPC_32_MAX_ID 388
  perfbuilder@d7a7af166a80:/git/perf$

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20190110094936.3132-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/Makefile                   | 15 +++++++++++----
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  | 22 ++++++++++++----------
 .../perf/arch/powerpc/entry}/syscalls/syscall.tbl  |  0
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index a111239df182..e58d00d62f02 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -14,18 +14,25 @@ PERF_HAVE_JITDUMP := 1
 out    := $(OUTPUT)arch/powerpc/include/generated/asm
 header32 := $(out)/syscalls_32.c
 header64 := $(out)/syscalls_64.c
-sysdef := $(srctree)/tools/arch/powerpc/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls/
+syskrn := $(srctree)/arch/powerpc/kernel/syscalls/syscall.tbl
+sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
+sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header64): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '64' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+	(diff -B $(sysdef) $(syskrn) >/dev/null) \
+	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
 
 $(header32): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '32' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+	(diff -B $(sysdef) $(syskrn) >/dev/null) \
+	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
index ef52e1dd694b..6c58060aa03b 100755
--- a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
@@ -9,10 +9,9 @@
 # Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
 
 wordsize=$1
-gcc=$2
-input=$3
+SYSCALL_TBL=$2
 
-if ! test -r $input; then
+if ! test -r $SYSCALL_TBL; then
 	echo "Could not read input file" >&2
 	exit 1
 fi
@@ -20,18 +19,21 @@ fi
 create_table()
 {
 	local wordsize=$1
-	local max_nr
+	local max_nr nr abi sc discard
+	max_nr=-1
+	nr=0
 
 	echo "static const char *syscalltbl_powerpc_${wordsize}[] = {"
-	while read sc nr; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
+	while read nr abi sc discard; do
+		if [ "$max_nr" -lt "$nr" ]; then
+			printf '\t[%d] = "%s",\n' $nr $sc
+			max_nr=$nr
+		fi
 	done
 	echo '};'
 	echo "#define SYSCALLTBL_POWERPC_${wordsize}_MAX_ID $max_nr"
 }
 
-$gcc -m${wordsize} -E -dM -x c  $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -nu	       \
+grep -E "^[[:digit:]]+[[:space:]]+(common|spu|nospu|${wordsize})" $SYSCALL_TBL \
+	|sort -k1 -n                                                           \
 	|create_table ${wordsize}
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
similarity index 100%
copy from arch/powerpc/kernel/syscalls/syscall.tbl
copy to tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
