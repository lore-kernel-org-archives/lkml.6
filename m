Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeDZFwb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:52:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeDZFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:52:28 -0400
Date: Wed, 25 Apr 2018 22:51:50 -0700
From: tip-bot for Namhyung Kim <tipbot@zytor.com>
Message-ID: <tip-ee05d21791db6db954bbb7b79bb18d88b5f6b7ff@git.kernel.org>
Cc: namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        kim.phillips@arm.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: tglx@linutronix.de, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org
In-Reply-To: <20180419235915.GA19067@sejong>
References: <20180419235915.GA19067@sejong>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf machine: Set main kernel end address
 properly
Git-Commit-ID: ee05d21791db6db954bbb7b79bb18d88b5f6b7ff
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

Commit-ID:  ee05d21791db6db954bbb7b79bb18d88b5f6b7ff
Gitweb:     https://git.kernel.org/tip/ee05d21791db6db954bbb7b79bb18d88b5f6b7ff
Author:     Namhyung Kim <namhyung@kernel.org>
AuthorDate: Mon, 19 Feb 2018 19:05:45 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 23 Apr 2018 10:52:55 -0300

perf machine: Set main kernel end address properly

map_groups__fixup_end() was called to set the end addresses of kernel
and module maps.  But now since machine__create_modules() sets the end
address of modules properly, the only remaining piece is the kernel map.

We can set it with adjacent module's address directly instead of calling
map_groups__fixup_end().  If there's no module after the kernel map, the
end address will be ~0ULL.

Since it also changes the start address of the kernel map, it needs to
re-insert the map to the kmaps in order to keep a correct ordering.  Kim
reported that it caused problems on ARM64.

Reported-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20180419235915.GA19067@sejong
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2eca8478e24f..32d50492505d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1019,13 +1019,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
 	return ret;
 }
 
-static void map_groups__fixup_end(struct map_groups *mg)
-{
-	int i;
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		__map_groups__fixup_end(mg, i);
-}
-
 static char *get_kernel_version(const char *root_dir)
 {
 	char version[PATH_MAX];
@@ -1233,6 +1226,7 @@ int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
+	struct map *map;
 	u64 addr = 0;
 	int ret;
 
@@ -1259,13 +1253,25 @@ int machine__create_kernel_maps(struct machine *machine)
 			machine__destroy_kernel_maps(machine);
 			return -1;
 		}
-		machine__set_kernel_mmap(machine, addr, 0);
+
+		/* we have a real start address now, so re-order the kmaps */
+		map = machine__kernel_map(machine);
+
+		map__get(map);
+		map_groups__remove(&machine->kmaps, map);
+
+		/* assume it's the last in the kmaps */
+		machine__set_kernel_mmap(machine, addr, ~0ULL);
+
+		map_groups__insert(&machine->kmaps, map);
+		map__put(map);
 	}
 
-	/*
-	 * Now that we have all the maps created, just set the ->end of them:
-	 */
-	map_groups__fixup_end(&machine->kmaps);
+	/* update end address of the kernel map using adjacent module address */
+	map = map__next(machine__kernel_map(machine));
+	if (map)
+		machine__set_kernel_mmap(machine, addr, map->start);
+
 	return 0;
 }
 
