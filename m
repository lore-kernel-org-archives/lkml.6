Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEBP33 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeEBPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:14 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 23/52] perf tests vmlinux-kallsyms: Use machine__find_kernel_function(_by_name)
Date: Wed,  2 May 2018 12:19:13 -0300
Message-Id: <20180502151942.20542-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We had this for ages, IIRC for 'perf probe' use initially, so use them
instead of the variants that pass the map_type, that is going away.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x1jpogsvj822sh0q8leiaoep@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 4e6c804a3ab4..c7f43afd5f89 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -119,8 +119,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, sym->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, sym->end);
 
-		first_pair = machine__find_kernel_symbol(&kallsyms, type,
-							 mem_start, NULL);
+		first_pair = machine__find_kernel_function(&kallsyms, mem_start, NULL);
 		pair = first_pair;
 
 		if (pair && UM(pair->start) == mem_start) {
@@ -149,7 +148,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 				 */
 				continue;
 			} else {
-				pair = machine__find_kernel_symbol_by_name(&kallsyms, type, sym->name, NULL);
+				pair = machine__find_kernel_function_by_name(&kallsyms, sym->name, NULL);
 				if (pair) {
 					if (UM(pair->start) == mem_start)
 						goto next_pair;
-- 
2.14.3
