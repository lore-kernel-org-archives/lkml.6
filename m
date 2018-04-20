Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755347AbeDTOd1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755322AbeDTOdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E3821841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/17] perf trace: Support MAP_FIXED_NOREPLACE
Date: Fri, 20 Apr 2018 11:32:19 -0300
Message-Id: <20180420143227.16030-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Introduced in a4ff8e8620d3 ("mm: introduce MAP_FIXED_NOREPLACE"), and
now that we have that define in the just syncronized
tools/arch/*/include/uapi/asm/mman.h files, add support for it.

This should really transition to autogeneration of string tables as
done for various other things:

  $ ls /tmp/build/perf/trace/beauty/generated/*.c
  arch_errno_name_array.c kcmp_type_array.c madvise_behavior_array.c
  pkey_alloc_access_rights_array.c prctl_option_array.c
  $ head /tmp/build/perf/trace/beauty/generated/madvise_behavior_array.c
  static const char *madvise_advices[] = {
	[0] = "NORMAL",
	[1] = "RANDOM",
	[2] = "SEQUENTIAL",
	[3] = "WILLNEED",
	[4] = "DONTNEED",
	[8] = "FREE",
	[9] = "REMOVE",
	[10] = "DONTFORK",
	[11] = "DOFORK",
  $

Till then, add support for this the old way.

Also it has to be ifdef'ed, because arches like mips still don't define
it. The proper solution will be to have per-arch tables for these
values to support cross-analysis.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-td9t5vhjltqnlzaurkkgq8cn@git.kernel.org
Signef-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 417e3ecfe9d7..9f68077b241b 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -54,6 +54,9 @@ static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 	P_MMAP_FLAG(EXECUTABLE);
 	P_MMAP_FLAG(FILE);
 	P_MMAP_FLAG(FIXED);
+#ifdef MAP_FIXED_NOREPLACE
+	P_MMAP_FLAG(FIXED_NOREPLACE);
+#endif
 	P_MMAP_FLAG(GROWSDOWN);
 	P_MMAP_FLAG(HUGETLB);
 	P_MMAP_FLAG(LOCKED);
-- 
2.14.3
