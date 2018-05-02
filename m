Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeEBR7g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:59:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:59:31 -0400
Date: Wed, 2 May 2018 10:59:22 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-r1z0tbdc7tich469aw4szinx@git.kernel.org>
Cc: wangnan0@huawei.com, hpa@zytor.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, dsahern@gmail.com, jolsa@kernel.org
Reply-To: jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        dsahern@gmail.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        wangnan0@huawei.com, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf sort: Use mmap->prot on "dcacheline"
 formatting
Git-Commit-ID: 6769e98dde916dc0e7f8282b29ec3bb995da6d94
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

Commit-ID:  6769e98dde916dc0e7f8282b29ec3bb995da6d94
Gitweb:     https://git.kernel.org/tip/6769e98dde916dc0e7f8282b29ec3bb995da6d94
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 12:26:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:19 -0300

perf sort: Use mmap->prot on "dcacheline" formatting

To match the kernel when setting the PERF_RECORD_MISC_MMAP_DATA bit
in perf_event_attr.header.misc, that gets set when VM_EXEC is not
set in the vm_flags.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r1z0tbdc7tich469aw4szinx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 26a68dfd8a4f..49a41b4b59cf 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2,7 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
-#include <sys/mman.h>
+#include <linux/mman.h>
 #include "sort.h"
 #include "hist.h"
 #include "comm.h"
@@ -1211,7 +1211,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 
 		/* print [s] for shared data mmaps */
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
-		     map && (map->type == MAP__VARIABLE) &&
+		     map && !(map->prot & PROT_EXEC) &&
 		    (map->flags & MAP_SHARED) &&
 		    (map->maj || map->min || map->ino ||
 		     map->ino_generation))
