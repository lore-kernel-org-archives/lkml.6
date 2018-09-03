Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9BDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5126D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2uoR0qMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5126D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeICTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:25 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C9420843;
        Mon,  3 Sep 2018 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986374;
        bh=zHeWlJAywaQQDqIaBFUhofngBRYbRsiVbpqAkO6cO30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uoR0qMTdF/vl4u/G6Bf7A1NWMqNCsv+mfa+XGYUP4DKDlzScsulGzt3EYb2pu4l0
         Ana8Xq8hdTsgoDsljIHXZISdBQajbT5ibX4kgBc7LywXEJ+hkXw623Bs22XbJnNIMK
         OeNXdVtthppYi78EH8G5oZ1fPLmLXp+6CvH6FiuA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/13] perf arm64: Fix include path for asm-generic/unistd.h
Date:   Mon,  3 Sep 2018 11:52:18 -0300
Message-Id: <20180903145224.12318-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

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
 
-- 
2.14.4

