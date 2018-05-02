Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeEBPWY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbeEBPWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:14 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 43/52] perf map: Use map->prot in place of type==MAP__FUNCTION
Date: Wed,  2 May 2018 12:19:33 -0300
Message-Id: <20180502151942.20542-44-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Equivalent, one step more in ditching enum map_type.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mrjjc87a4tpf896j5u4sql4e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ab12f2bc7669..a164e1ed5462 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -173,7 +173,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
 
-		if ((anon || no_dso) && nsi && type == MAP__FUNCTION) {
+		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
 			snprintf(newfilename, sizeof(newfilename),
 				 "/tmp/perf-%d.map", nsi->pid);
 			filename = newfilename;
@@ -213,7 +213,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * functions still return NULL, and we avoid the
 			 * unnecessary map__load warning.
 			 */
-			if (type != MAP__FUNCTION)
+			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso, map->type);
 		}
 		dso->nsinfo = nsi;
-- 
2.14.3
