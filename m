Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeBQLqx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:46:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeBQLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:46:52 -0500
Date: Sat, 17 Feb 2018 03:36:41 -0800
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-4281da235e3de91bb8deae44bc6506336ceaa88a@git.kernel.org>
Cc: jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, hpa@zytor.com, tmricht@linux.vnet.ibm.com,
        tglx@linutronix.de, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, acme@redhat.com, mingo@kernel.org
Reply-To: hpa@zytor.com, tmricht@linux.vnet.ibm.com, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mpe@ellerman.id.au,
        mingo@kernel.org, acme@redhat.com, brueckner@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com
In-Reply-To: <20180129083417.31240-4-ravi.bangoria@linux.vnet.ibm.com>
References: <20180129083417.31240-4-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace powerpc: Use generated syscall table
Git-Commit-ID: 4281da235e3de91bb8deae44bc6506336ceaa88a
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

Commit-ID:  4281da235e3de91bb8deae44bc6506336ceaa88a
Gitweb:     https://git.kernel.org/tip/4281da235e3de91bb8deae44bc6506336ceaa88a
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Mon, 29 Jan 2018 14:04:17 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:50 -0300

perf trace powerpc: Use generated syscall table

This should speed up accessing new system calls introduced with the
kernel rather than waiting for libaudit updates to include them.

It also enables users to specify wildcards, for example, perf trace -e
'open*', just like was already possible on x86 and s390.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20180129083417.31240-4-ravi.bangoria@linux.vnet.ibm.com
[ Do it for ppc32 as well ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config   | 2 ++
 tools/perf/util/syscalltbl.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0dfdaa9..577a5d2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -27,6 +27,8 @@ NO_SYSCALL_TABLE := 1
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
   NO_PERF_REGS := 0
+  NO_SYSCALL_TABLE := 0
+  CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
 
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 303bdb8..895122d 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -30,6 +30,14 @@ static const char **syscalltbl_native = syscalltbl_x86_64;
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
 static const char **syscalltbl_native = syscalltbl_s390_64;
+#elif defined(__powerpc64__)
+#include <asm/syscalls_64.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_powerpc_64;
+#elif defined(__powerpc__)
+#include <asm/syscalls_32.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_powerpc_32;
 #endif
 
 struct syscall {
