Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeFEHbV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:31:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:5445 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeFEHbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:31:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="53861881"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Fix object code reading for PTI entry trampolines
Date: Tue,  5 Jun 2018 10:30:00 +0300
Message-Id: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix object code reading and the "Object code reading" test for PTI entry
trampolines.

perf tools uses map__rip_2objdump() to calculate objdump virtual addresses.
map__rip_2objdump() needs to be amended to deal with PTI entry trampolines.
Also the "Object code reading" test will not create maps for the PTI entry
trampolines unless the machine environment exists to show that the arch is
x86_64.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/code-reading.c |  1 +
 tools/perf/util/map.c           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index afa4ce21ba7c..4892bd2dc33e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -560,6 +560,7 @@ static int do_test_code_reading(bool try_kcore)
 	pid = getpid();
 
 	machine = machine__new_host();
+	machine->env = &perf_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 92abc8e248c5..89ac5b5dc218 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -449,6 +449,20 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
  */
 u64 map__rip_2objdump(struct map *map, u64 rip)
 {
+	struct kmap *kmap = __map__kmap(map);
+
+	/*
+	 * vmlinux does not have program headers for PTI entry trampolines and
+	 * kcore may not either. However the trampoline object code is on the
+	 * main kernel map, so just use that instead.
+	 */
+	if (kmap && is_entry_trampoline(kmap->name) && kmap->kmaps && kmap->kmaps->machine) {
+		struct map *kernel_map = machine__kernel_map(kmap->kmaps->machine);
+
+		if (kernel_map)
+			map = kernel_map;
+	}
+
 	if (!map->dso->adjust_symbols)
 		return rip;
 
-- 
1.9.1
