Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeEBRu3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:50:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeEBRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:50:26 -0400
Date: Wed, 2 May 2018 10:50:13 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0h3eof3kx3kq32ixg5fquf3p@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        dsahern@gmail.com, tglx@linutronix.de, wangnan0@huawei.com,
        hpa@zytor.com, adrian.hunter@intel.com, mingo@kernel.org,
        acme@redhat.com
Reply-To: tglx@linutronix.de, wangnan0@huawei.com, dsahern@gmail.com,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Remove needless map_type from
 machine__load_vmlinux_path()
Git-Commit-ID: 1d1a2654fffe1e5a80479ed4b6202467d2d0db46
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

Commit-ID:  1d1a2654fffe1e5a80479ed4b6202467d2d0db46
Gitweb:     https://git.kernel.org/tip/1d1a2654fffe1e5a80479ed4b6202467d2d0db46
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 12:18:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:11 -0300

perf machine: Remove needless map_type from machine__load_vmlinux_path()

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
