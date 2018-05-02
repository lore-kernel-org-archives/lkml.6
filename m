Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeEBPZJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbeEBPWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:05 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 40/52] perf sort: Use mmap->prot on "dcacheline" formatting
Date: Wed,  2 May 2018 12:19:30 -0300
Message-Id: <20180502151942.20542-41-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
