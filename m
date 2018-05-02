Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeEBPdP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbeEBPUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:31 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/52] perf top: Use __map__is_kernel()
Date: Wed,  2 May 2018 12:18:58 -0300
Message-Id: <20180502151942.20542-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Shorter form to figure out if a given map is the kernel one and also
reduces the number of code accessing MAP__{FUNCTION,VARIABLE}, that
should go away at some point.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rn8pexelsxpx92ce3elu3wiw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f39bd60d2708..4e975f3ee3be 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -750,7 +750,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		machine->kptr_restrict_warned = true;
 	}
 
-	if (al.sym == NULL) {
+	if (al.sym == NULL && al.map != NULL) {
 		const char *msg = "Kernel samples will not be resolved.\n";
 		/*
 		 * As we do lazy loading of symtabs we only will know if the
@@ -764,7 +764,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    al.map == machine->vmlinux_maps[MAP__FUNCTION] &&
+		    __map__is_kernel(al.map) &&
 		    RB_EMPTY_ROOT(&al.map->dso->symbols[MAP__FUNCTION])) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
-- 
2.14.3
