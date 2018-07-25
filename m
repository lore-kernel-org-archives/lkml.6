Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBACDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DCA20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DCA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGYWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:02:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbeGYWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:02:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKmNJm501129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:48:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKmNCN501124;
        Wed, 25 Jul 2018 13:48:23 -0700
Date:   Wed, 25 Jul 2018 13:48:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-2b5882435606c209ebc052230f03505ea477a252@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mingo@kernel.org, namhyung@kernel.org, mpe@ellerman.id.au,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        tmricht@linux.vnet.ibm.com, acme@redhat.com, tglx@linutronix.de,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, jolsa@redhat.com,
          tmricht@linux.vnet.ibm.com, acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
          mingo@kernel.org, namhyung@kernel.org, mpe@ellerman.id.au,
          kim.phillips@arm.com, brueckner@linux.ibm.com
In-Reply-To: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
References: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf arm64: Generate system call table from
 asm/unistd.h
Git-Commit-ID: 2b5882435606c209ebc052230f03505ea477a252
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

Commit-ID:  2b5882435606c209ebc052230f03505ea477a252
Gitweb:     https://git.kernel.org/tip/2b5882435606c209ebc052230f03505ea477a252
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 6 Jul 2018 16:34:43 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:52:48 -0300

perf arm64: Generate system call table from asm/unistd.h

This should speed up accessing new system calls introduced with the
kernel rather than waiting for libaudit updates to include them.

Using the existing other arch scripts resulted in this error:

  tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: 25: printf: __NR3264_ftruncate: expected numeric value

because, unlike other arches, asm-generic's unistd.h does things like:

  #define __NR_ftruncate __NR3264_ftruncate

Turning the scripts printf's %d into a %s resulted in this in the
generated syscalls.c file:

    static const char *syscalltbl_arm64[] = {
            [__NR3264_ftruncate] = "ftruncate",

So we use the host C compiler to fold the macros, and print them out
from within a temporary C program, in order to get the correct output:

    static const char *syscalltbl_arm64[] = {
            [46] = "ftruncate",

Committer notes:

Testing this with a container with an old toolchain breaks because it
ends up using the system's /usr/include/asm-generic/unistd.h, included
from tools/arch/arm64/include/uapi/asm/unistd.h when what is desired is
for it to include tools/include/uapi/asm-generic/unistd.h.

Since all that tools/arch/arm64/include/uapi/asm/unistd.h is to set a
define and then include asm-generic/unistd.h, do that directly and use
tools/include/uapi/asm-generic/unistd.h as the file to get the syscall
definitions to expand.

Testing it:

   tools/perf/arch/arm64/entry/syscalls/mksyscalltbl /gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc gcc tools/include/uapi/asm-generic/unistd.h

Now works and generates in the syscall string table.

Before it ended up as:

  $ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl /gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc gcc tools/arch/arm64/include/uapi/asm/unistd.h
  static const char *syscalltbl_arm64[] = {
  <stdin>: In function 'main':
  <stdin>:257:38: error: '__NR_getrandom' undeclared (first use in this function)
  <stdin>:257:38: note: each undeclared identifier is reported only once for each function it appears in
  <stdin>:258:41: error: '__NR_memfd_create' undeclared (first use in this function)
  <stdin>:259:32: error: '__NR_bpf' undeclared (first use in this function)
  <stdin>:260:37: error: '__NR_execveat' undeclared (first use in this function)
  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl: 47: tools/perf/arch/arm64/entry/syscalls/mksyscalltbl: /tmp/create-table-60liya: Permission denied
  };
  $

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180706163443.22626f5e9e10e5bab5e5c662@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/Makefile                    | 21 ++++++++
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 62 +++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 91de4860faad..f013b115dc86 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -4,3 +4,24 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+
+#
+# Syscall table generation for perf
+#
+
+out    := $(OUTPUT)arch/arm64/include/generated/asm
+header := $(out)/syscalls.c
+sysdef := $(srctree)/tools/include/uapi/asm-generic/unistd.h
+sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
+systbl := $(sysprf)/mksyscalltbl
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+$(header): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(sysdef) > $@
+
+clean::
+	$(call QUIET_CLEAN, arm64) $(RM) $(header)
+
+archheaders: $(header)
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
new file mode 100755
index 000000000000..52e197317d3e
--- /dev/null
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate system call table for perf. Derived from
+# powerpc script.
+#
+# Copyright IBM Corp. 2017
+# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
+# Changed by: Kim Phillips <kim.phillips@arm.com>
+
+gcc=$1
+hostcc=$2
+input=$3
+
+if ! test -r $input; then
+	echo "Could not read input file" >&2
+	exit 1
+fi
+
+create_table_from_c()
+{
+	local sc nr last_sc
+
+	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
+
+	{
+
+	cat <<-_EoHEADER
+		#include <stdio.h>
+		#define __ARCH_WANT_RENAMEAT
+		#include "$input"
+		int main(int argc, char *argv[])
+		{
+	_EoHEADER
+
+	while read sc nr; do
+		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", __NR_$sc);"
+		last_sc=$sc
+	done
+
+	printf "%s\n" "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\n\", __NR_$last_sc);"
+	printf "}\n"
+
+	} | $hostcc -o $create_table_exe -x c -
+
+	$create_table_exe
+
+	rm -f $create_table_exe
+}
+
+create_table()
+{
+	echo "static const char *syscalltbl_arm64[] = {"
+	create_table_from_c
+	echo "};"
+}
+
+$gcc -E -dM -x c  $input	       \
+	|sed -ne 's/^#define __NR_//p' \
+	|sort -t' ' -k2 -nu	       \
+	|create_table
