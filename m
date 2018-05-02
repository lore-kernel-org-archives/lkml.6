Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeEBPVR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeEBPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:11 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 22/52] perf machine: Remove needless map_type from machine__load_vmlinux_path()
Date: Wed,  2 May 2018 12:19:12 -0300
Message-Id: <20180502151942.20542-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since it uses machine__kernel_map() and this function always returns the
MAP__FUNCTION map, it doesn't make sense to call it with MAP__VARIABLE.

And also this is a step in the direction of nuking the MAP__{FUNCTION,VARIABLE}
split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0h3eof3kx3kq32ixg5fquf3p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 2 +-
 tools/perf/util/machine.c           | 4 ++--
 tools/perf/util/machine.h           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index b99e60593664..4e6c804a3ab4 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -94,7 +94,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	 * maps__reloc_vmlinux will notice and set proper ->[un]map_ip routines
 	 * to fixup the symbols.
 	 */
-	if (machine__load_vmlinux_path(&vmlinux, type) <= 0) {
+	if (machine__load_vmlinux_path(&vmlinux) <= 0) {
 		pr_debug("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
 		err = TEST_SKIP;
 		goto out;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d39432c7db86..0017c4a1fb97 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1005,13 +1005,13 @@ int __machine__load_kallsyms(struct machine *machine, const char *filename,
 	return ret;
 }
 
-int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
+int machine__load_vmlinux_path(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
 	int ret = dso__load_vmlinux_path(map->dso, map);
 
 	if (ret > 0)
-		dso__set_loaded(map->dso, type);
+		dso__set_loaded(map->dso, map->type);
 
 	return ret;
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index dc95404959ee..ac3b8403df2e 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -245,7 +245,7 @@ static inline int machine__load_kallsyms(struct machine *machine, const char *fi
 	return __machine__load_kallsyms(machine, filename, MAP__FUNCTION);
 }
 
-int machine__load_vmlinux_path(struct machine *machine, enum map_type type);
+int machine__load_vmlinux_path(struct machine *machine);
 
 size_t machine__fprintf_dsos_buildid(struct machine *machine, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm);
-- 
2.14.3
