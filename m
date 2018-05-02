Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeEBSBj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:01:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeEBSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:01:32 -0400
Date: Wed, 2 May 2018 11:01:20 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6m18iv1ty7nh7kxlfmn89sgz@git.kernel.org>
Cc: tglx@linutronix.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, dsahern@gmail.com, acme@redhat.com,
        adrian.hunter@intel.com, wangnan0@huawei.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, acme@redhat.com,
        dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Use map->prot in place of
 type==MAP__FUNCTION
Git-Commit-ID: e9814df8645d82b6c5d185537f9510028e35c385
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

Commit-ID:  e9814df8645d82b6c5d185537f9510028e35c385
Gitweb:     https://git.kernel.org/tip/e9814df8645d82b6c5d185537f9510028e35c385
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 16:11:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 16:15:08 -0300

perf symbols: Use map->prot in place of type==MAP__FUNCTION

Its equivalent, one less use of enum map_type.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6m18iv1ty7nh7kxlfmn89sgz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e1fd236c96d3..fe0e0d84a586 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/kernel.h>
+#include <linux/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/param.h>
@@ -1217,7 +1218,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Read new maps into temporary lists */
-	err = file__read_maps(fd, md.type == MAP__FUNCTION, kcore_mapfn, &md,
+	err = file__read_maps(fd, map->prot & PROT_EXEC, kcore_mapfn, &md,
 			      &is_64_bit);
 	if (err)
 		goto out_err;
@@ -1285,7 +1286,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	close(fd);
 
-	if (map->type == MAP__FUNCTION)
+	if (map->prot & PROT_EXEC)
 		pr_debug("Using %s for kernel object code\n", kcore_filename);
 	else
 		pr_debug("Using %s for kernel data\n", kcore_filename);
