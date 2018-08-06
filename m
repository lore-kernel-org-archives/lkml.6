Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247E921920
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247E921920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbeHGAjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:39:13 -0400
Received: from foss.arm.com ([217.140.101.70]:46516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeHGAjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:39:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C487A9;
        Mon,  6 Aug 2018 15:28:02 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3B83F5D0;
        Mon,  6 Aug 2018 15:28:01 -0700 (PDT)
Date:   Mon, 6 Aug 2018 17:28:00 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf arm64: Fix include path for asm-generic/unistd.h
Message-Id: <20180806172800.bbcec3cfcc51e2facc978bf2@arm.com>
In-Reply-To: <20180723190121.GB13220@kernel.org>
References: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
        <20180718155752.GA1814@kernel.org>
        <20180720150653.GD4329@kernel.org>
        <20180723185905.GA13220@kernel.org>
        <20180723190121.GB13220@kernel.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It thus fixes the committer's test that cross-builds an arm64 perf
on an x86 platform running Ubuntu 14.04.5 LTS with an old toolchain:

$ tools/perf/arch/arm64/entry/syscalls/mksyscalltbl /gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc gcc `pwd`/tools tools/arch/arm64/include/uapi/asm/unistd.h | grep bpf
	[280] = "bpf",

Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
Hi, sorry for late response - was on vacation.  I was able to reproduce
and fix by adding this -I to the $hostcc line.  Please test, and let me
know if this is an acceptable fix.

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
 
-- 
2.17.1

