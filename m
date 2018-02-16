Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeBPJpL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:45:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbeBPJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:45:09 -0500
Date: Fri, 16 Feb 2018 01:44:58 -0800
From: tip-bot for Hendrik Brueckner <tipbot@zytor.com>
Message-ID: <tip-bdyhllhsq1zgxv2qx4m377y6@git.kernel.org>
Cc: jolsa@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        acme@redhat.com
Reply-To: jolsa@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        mpetlan@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf s390: Rework system call table creation by
 using syscall.tbl
Git-Commit-ID: 690d22d9d4423b4522fb44a71145403eef2df834
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

Commit-ID:  690d22d9d4423b4522fb44a71145403eef2df834
Gitweb:     https://git.kernel.org/tip/690d22d9d4423b4522fb44a71145403eef2df834
Author:     Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
AuthorDate: Thu, 8 Feb 2018 12:47:50 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 10:06:08 -0300

perf s390: Rework system call table creation by using syscall.tbl

Recently, s390 uses a syscall.tbl input file to generate its system call
table and unistd uapi header files.  Hence, update mksyscalltbl to use
it as input to create the system table for perf.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
LPU-Reference: 1518090470-2899-4-git-send-email-brueckner@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-bdyhllhsq1zgxv2qx4m377y6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/Makefile                    | 10 +++++++---
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl | 18 +++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 48228de..dfa6e31 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -10,15 +10,19 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 
 out    := $(OUTPUT)arch/s390/include/generated/asm
 header := $(out)/syscalls_64.c
-sysdef := $(srctree)/tools/arch/s390/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls/
+syskrn := $(srctree)/arch/s390/kernel/syscalls/syscall.tbl
+sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
+sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+        (diff -B $(sysdef) $(syskrn) >/dev/null) \
+        || echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, s390) $(RM) $(header)
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
index 7fa0d0a..72ecbb6 100755
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
@@ -3,25 +3,23 @@
 #
 # Generate system call table for perf
 #
-#
-# Copyright IBM Corp. 2017
+# Copyright IBM Corp. 2017, 2018
 # Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
 #
 
-gcc=$1
-input=$2
+SYSCALL_TBL=$1
 
-if ! test -r $input; then
+if ! test -r $SYSCALL_TBL; then
 	echo "Could not read input file" >&2
 	exit 1
 fi
 
 create_table()
 {
-	local max_nr
+	local max_nr nr abi sc discard
 
 	echo 'static const char *syscalltbl_s390_64[] = {'
-	while read sc nr; do
+	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
 	done
@@ -29,8 +27,6 @@ create_table()
 	echo "#define SYSCALLTBL_S390_64_MAX_ID $max_nr"
 }
 
-
-$gcc -m64 -E -dM -x c  $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -nu	       \
+grep -E "^[[:digit:]]+[[:space:]]+(common|64)" $SYSCALL_TBL	\
+	|sort -k1 -n					\
 	|create_table
