Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeBPTUG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbeBPTT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A35217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/41] perf powerpc: Generate system call table from asm/unistd.h
Date: Fri, 16 Feb 2018 16:17:39 -0300
Message-Id: <20180216191746.11095-35-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

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
 create mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 42dab7c8f508..a111239df182 100644
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
index 000000000000..ef52e1dd694b
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
-- 
2.14.3
