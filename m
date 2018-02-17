Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeBQLrW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:47:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeBQLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:47:21 -0500
Date: Sat, 17 Feb 2018 03:36:10 -0800
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-8e2ff72aa35e1a8a53894ae46751a83543338e14@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        mpe@ellerman.id.au, ravi.bangoria@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
        tmricht@linux.vnet.ibm.com, namhyung@kernel.org
Reply-To: jolsa@redhat.com, tmricht@linux.vnet.ibm.com, namhyung@kernel.org,
        mpe@ellerman.id.au, tglx@linutronix.de, mingo@kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, hpa@zytor.com
In-Reply-To: <20180129083417.31240-3-ravi.bangoria@linux.vnet.ibm.com>
References: <20180129083417.31240-3-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf powerpc: Generate system call table from
 asm/unistd.h
Git-Commit-ID: 8e2ff72aa35e1a8a53894ae46751a83543338e14
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e2ff72aa35e1a8a53894ae46751a83543338e14
Gitweb:     https://git.kernel.org/tip/8e2ff72aa35e1a8a53894ae46751a83543338e14
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Mon, 29 Jan 2018 14:04:16 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:48 -0300

perf powerpc: Generate system call table from asm/unistd.h

This should speed up accessing new system calls introduced with the
kernel rather than waiting for libaudit updates to include them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20180129083417.31240-3-ravi.bangoria@linux.vnet.ibm.com
[ Made it generate syscall_32.c as well to fix the build on 32-bit ppc ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/Makefile                   | 25 +++++++++++++++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  | 37 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 42dab7c..a111239 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -6,3 +6,28 @@ endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
+
+#
+# Syscall table generation for perf
+#
+
+out    := $(OUTPUT)arch/powerpc/include/generated/asm
+header32 := $(out)/syscalls_32.c
+header64 := $(out)/syscalls_64.c
+sysdef := $(srctree)/tools/arch/powerpc/include/uapi/asm/unistd.h
+sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls/
+systbl := $(sysprf)/mksyscalltbl
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+$(header64): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' '64' '$(CC)' $(sysdef) > $@
+
+$(header32): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' '32' '$(CC)' $(sysdef) > $@
+
+clean::
+	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
+
+archheaders: $(header32) $(header64)
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
new file mode 100755
index 0000000..ef52e1d
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate system call table for perf. Derived from
+# s390 script.
+#
+# Copyright IBM Corp. 2017
+# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
+
+wordsize=$1
+gcc=$2
+input=$3
+
+if ! test -r $input; then
+	echo "Could not read input file" >&2
+	exit 1
+fi
+
+create_table()
+{
+	local wordsize=$1
+	local max_nr
+
+	echo "static const char *syscalltbl_powerpc_${wordsize}[] = {"
+	while read sc nr; do
+		printf '\t[%d] = "%s",\n' $nr $sc
+		max_nr=$nr
+	done
+	echo '};'
+	echo "#define SYSCALLTBL_POWERPC_${wordsize}_MAX_ID $max_nr"
+}
+
+$gcc -m${wordsize} -E -dM -x c  $input	       \
+	|sed -ne 's/^#define __NR_//p' \
+	|sort -t' ' -k2 -nu	       \
+	|create_table ${wordsize}
