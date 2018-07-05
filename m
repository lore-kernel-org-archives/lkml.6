Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876AF2403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876AF2403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeGEXMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:12:21 -0400
Received: from foss.arm.com ([217.140.101.70]:57194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753895AbeGEXMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:12:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 064EF15B2;
        Thu,  5 Jul 2018 16:12:18 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0053F5BA;
        Thu,  5 Jul 2018 16:12:17 -0700 (PDT)
Date:   Thu, 5 Jul 2018 18:12:16 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] perf arm64: Generate system call table from
 asm/unistd.h
Message-Id: <20180705181216.0cc737d217d9acda567bd519@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
Changes in V2:
 - added the "sc" and "nr" local variables, for the sake of completion (Hendrik
   Brueckner)
 - Removed the unsafe -u from mktemp, added more X's, and now pipe the
   C code to the $hostcc command, so we now only require a single temp
   file that is written by gcc. (Hendrik Brueckner)
 - used cat << EoHEADER instead of echos for the c file header, to make it more
   readable (Hendrik Brueckner)
 - $RM -> rm, to be able to run standalone (Hendrik Brueckner)
 - moved the rm into the function that makes the file
 - converted other echos to printf "%s\n" for more portable printing of
   backslash characters (bash and dash built-in echo commands differ in
   how many escape backslashes are needed).  The initial "%s\n" is needed
   in order to keep the external printf command from interpreting the %ds.

 tools/perf/arch/arm64/Makefile                | 21 +++++++
 .../arch/arm64/entry/syscalls/mksyscalltbl    | 61 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100755 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 91de4860faad..85fdf4949db3 100644
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
+sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
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
index 000000000000..f806542eb3cc
--- /dev/null
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -0,0 +1,61 @@
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
+cat << _EoHEADER
+#include <stdio.h>
+#include "$input"
+int main(int argc, char *argv[])
+{
+_EoHEADER
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
-- 
2.17.1

