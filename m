Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F03F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F03F20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeKAHI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:08:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36735 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKAHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:08:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM8poj2561010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:08:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM8pTF2561007;
        Wed, 31 Oct 2018 15:08:51 -0700
Date:   Wed, 31 Oct 2018 15:08:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ggmoy6vxoygh5yim890ht0kf@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, dsahern@gmail.com, adrian.hunter@intel.com,
        jolsa@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
          namhyung@kernel.org, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace beauty: Use the mmap flags table
 generated from headers
Git-Commit-ID: 2f967f1dbbc1f746ad0deda8352bcf563d59e1c7
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

Commit-ID:  2f967f1dbbc1f746ad0deda8352bcf563d59e1c7
Gitweb:     https://git.kernel.org/tip/2f967f1dbbc1f746ad0deda8352bcf563d59e1c7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 16:30:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:53 -0300

perf trace beauty: Use the mmap flags table generated from headers

Instead of requiring us to go on and edit sources to add new flag.

  # perf trace -e *mmap sleep 0.1
     0.025 ( 0.005 ms): sleep/29876 mmap(len: 163746, prot: READ, flags: PRIVATE, fd: 3) = 0x7faa68ad1000
     0.059 ( 0.004 ms): sleep/29876 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7faa68acf000
     0.069 ( 0.006 ms): sleep/29876 mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3) = 0x7faa6851f000
     0.086 ( 0.009 ms): sleep/29876 mmap(addr: 0x7faa688cb000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 1753088) = 0x7faa688cb000
     0.101 ( 0.005 ms): sleep/29876 mmap(addr: 0x7faa688d1000, len: 14976, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7faa688d1000
     0.348 ( 0.005 ms): sleep/29876 mmap(len: 111950656, prot: READ, flags: PRIVATE, fd: 3) = 0x7faa61a5b000
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ggmoy6vxoygh5yim890ht0kf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 48 ++++++++++--------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 0605593552c6..c534bd96ef5c 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include <uapi/linux/mman.h>
+#include <linux/log2.h>
 
 static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 					       struct syscall_arg *arg)
@@ -30,50 +31,23 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 
 #define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
 
+static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+#include "trace/beauty/generated/mmap_flags_array.c"
+       static DEFINE_STRARRAY(mmap_flags);
+
+       return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, flags);
+}
+
 static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 						struct syscall_arg *arg)
 {
-	int printed = 0, flags = arg->val;
+	unsigned long flags = arg->val;
 
 	if (flags & MAP_ANONYMOUS)
 		arg->mask |= (1 << 4) | (1 << 5); /* Mask 4th ('fd') and 5th ('offset') args, ignored */
 
-#define	P_MMAP_FLAG(n) \
-	if (flags & MAP_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
-		flags &= ~MAP_##n; \
-	}
-
-	P_MMAP_FLAG(SHARED);
-	P_MMAP_FLAG(PRIVATE);
-#ifdef MAP_32BIT
-	P_MMAP_FLAG(32BIT);
-#endif
-	P_MMAP_FLAG(ANONYMOUS);
-	P_MMAP_FLAG(DENYWRITE);
-	P_MMAP_FLAG(EXECUTABLE);
-	P_MMAP_FLAG(FILE);
-	P_MMAP_FLAG(FIXED);
-#ifdef MAP_FIXED_NOREPLACE
-	P_MMAP_FLAG(FIXED_NOREPLACE);
-#endif
-	P_MMAP_FLAG(GROWSDOWN);
-	P_MMAP_FLAG(HUGETLB);
-	P_MMAP_FLAG(LOCKED);
-	P_MMAP_FLAG(NONBLOCK);
-	P_MMAP_FLAG(NORESERVE);
-	P_MMAP_FLAG(POPULATE);
-	P_MMAP_FLAG(STACK);
-	P_MMAP_FLAG(UNINITIALIZED);
-#ifdef MAP_SYNC
-	P_MMAP_FLAG(SYNC);
-#endif
-#undef P_MMAP_FLAG
-
-	if (flags)
-		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
-
-	return printed;
+	return mmap__scnprintf_flags(flags, bf, size);
 }
 
 #define SCA_MMAP_FLAGS syscall_arg__scnprintf_mmap_flags
