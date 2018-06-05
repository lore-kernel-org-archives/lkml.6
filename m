Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeFERwm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752995AbeFERwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:38 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/46] perf map: Consider PTI entry trampolines in rip_2objdump()
Date: Tue,  5 Jun 2018 14:50:24 -0300
Message-Id: <20180605175030.32549-41-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

perf tools uses map__rip_2objdump() to calculate objdump virtual addresses.
map__rip_2objdump() needs to be amended to deal with PTI entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1528183800-21577-1-git-send-email-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

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
2.14.3
