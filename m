Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeDUHuo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:50:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeDUHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:50:43 -0400
Date: Sat, 21 Apr 2018 00:50:28 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-td9t5vhjltqnlzaurkkgq8cn@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        namhyung@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        acme@redhat.com, dsahern@gmail.com, mhocko@suse.com,
        adrian.hunter@intel.com
Reply-To: wangnan0@huawei.com, jolsa@kernel.org, adrian.hunter@intel.com,
        mhocko@suse.com, dsahern@gmail.com, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, namhyung@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Support MAP_FIXED_NOREPLACE
Git-Commit-ID: 4e5c01a7c746130033eb6e7153b346b8ca61e7a5
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

Commit-ID:  4e5c01a7c746130033eb6e7153b346b8ca61e7a5
Gitweb:     https://git.kernel.org/tip/4e5c01a7c746130033eb6e7153b346b8ca61e7a5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 16 Apr 2018 16:39:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:34:52 -0300

perf trace: Support MAP_FIXED_NOREPLACE

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
