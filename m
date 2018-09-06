Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3709EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47D220869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47D220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeIFRkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:40:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIFRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:40:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D479q303003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:04:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D47n4303000;
        Thu, 6 Sep 2018 06:04:07 -0700
Date:   Thu, 6 Sep 2018 06:04:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-5ab1de932e2923f490645ad017a689c5b58dc433@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com, kim.phillips@arm.com,
        mpe@ellerman.id.au, ravi.bangoria@linux.vnet.ibm.com,
        mingo@kernel.org, peterz@infradead.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
          mpe@ellerman.id.au, kim.phillips@arm.com,
          tmricht@linux.vnet.ibm.com, mingo@kernel.org,
          ravi.bangoria@linux.vnet.ibm.com, peterz@infradead.org,
          jolsa@redhat.com, alexander.shishkin@linux.intel.com,
          hpa@zytor.com
In-Reply-To: <20180806172800.bbcec3cfcc51e2facc978bf2@arm.com>
References: <20180806172800.bbcec3cfcc51e2facc978bf2@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf arm64: Fix include path for
 asm-generic/unistd.h
Git-Commit-ID: 5ab1de932e2923f490645ad017a689c5b58dc433
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

Commit-ID:  5ab1de932e2923f490645ad017a689c5b58dc433
Gitweb:     https://git.kernel.org/tip/5ab1de932e2923f490645ad017a689c5b58dc433
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Mon, 6 Aug 2018 17:28:00 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:49:24 -0300

perf arm64: Fix include path for asm-generic/unistd.h

The new syscall table support for arm64 mistakenly used the system's
asm-generic/unistd.h file when processing the
tools/arch/arm64/include/uapi/asm/unistd.h file's include directive:

	#include <asm-generic/unistd.h>

See "Committer notes" section of commit 2b5882435606 "perf arm64:
Generate system call table from asm/unistd.h" for more details.

This patch removes the committer's temporary workaround, and instructs
the host compiler to search the build tree's include path for the right
copy of the unistd.h file, instead of the one on the system's
/usr/include path.

It thus fixes the committer's test that cross-builds an arm64 perf on an
x86 platform running Ubuntu 14.04.5 LTS with an old toolchain:

$ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl /gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc gcc `pwd`/tools tools/arch/arm64/include/uapi/asm/unistd.h | grep bpf
	[280] = "bpf",

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
Link: http://lkml.kernel.org/r/20180806172800.bbcec3cfcc51e2facc978bf2@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/Makefile                    | 5 +++--
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index f013b115dc86..dbef716a1913 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -11,7 +11,8 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 
 out    := $(OUTPUT)arch/arm64/include/generated/asm
 header := $(out)/syscalls.c
-sysdef := $(srctree)/tools/include/uapi/asm-generic/unistd.h
+incpath := $(srctree)/tools
+sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
 sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
 systbl := $(sysprf)/mksyscalltbl
 
@@ -19,7 +20,7 @@ systbl := $(sysprf)/mksyscalltbl
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(sysdef) > $@
+	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, arm64) $(RM) $(header)
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 52e197317d3e..2dbb8cade048 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -11,7 +11,8 @@
 
 gcc=$1
 hostcc=$2
-input=$3
+incpath=$3
+input=$4
 
 if ! test -r $input; then
 	echo "Could not read input file" >&2
@@ -28,7 +29,6 @@ create_table_from_c()
 
 	cat <<-_EoHEADER
 		#include <stdio.h>
-		#define __ARCH_WANT_RENAMEAT
 		#include "$input"
 		int main(int argc, char *argv[])
 		{
@@ -42,7 +42,7 @@ create_table_from_c()
 	printf "%s\n" "	printf(\"#define SYSCALLTBL_ARM64_MAX_ID %d\\n\", __NR_$last_sc);"
 	printf "}\n"
 
-	} | $hostcc -o $create_table_exe -x c -
+	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
 
 	$create_table_exe
 
