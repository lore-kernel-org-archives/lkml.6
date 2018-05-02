Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeEBPWW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeEBPWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:17 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 44/52] perf symbols: Use map->prot in place of type==MAP__FUNCTION
Date: Wed,  2 May 2018 12:19:34 -0300
Message-Id: <20180502151942.20542-45-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
