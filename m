Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65198C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BCE2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479290;
	bh=sdplpdCvwp3ioOEXwOpZze5e40V78qVatPAq70HNx7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DmjjAJ2RHyzncFiB8XPh1G8iZaC/M0hsGFoHL59nbb0I30pDQj6NFQQKhsekxfj0o
	 DmH2iCDciR5rB+NsudR82iUiMl7j40jnhOznqta0QQXyrA7NjbFxMBsoM01DBja91C
	 zvP9FpY7dDaBIrUGEBbeIG9fEQNk+7qItrGp5pnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfBFSyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfBFSth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:37 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7C92083B;
        Wed,  6 Feb 2019 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478976;
        bh=sdplpdCvwp3ioOEXwOpZze5e40V78qVatPAq70HNx7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVRMlszULUS/np06ELnT353Eq+w+wzl2E3n1KNoQOVGDDPcUhEzJJw/kYvan2/NrN
         YtowSGyz3E7Cdvc4LMmdZsPa2WXKWKCcx8p1mTHGkNhLUJz8MTuD0rRXTcm2Vopf1/
         31CAJIalu6av9Dr2z3bbAfFrgzKhpoICGdtWAsNc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/53] perf map: Move structs and prototypes for map groups to a separate header
Date:   Wed,  6 Feb 2019 15:48:17 -0300
Message-Id: <20190206184903.24054-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And since machine.h only needs what is in there, make it stop including
map.h and instead include this newly introduced map_groups.h instead.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dbob25fv5rp2rjpwlnterf38@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     |  1 +
 tools/perf/arch/arm64/tests/dwarf-unwind.c   |  1 +
 tools/perf/arch/powerpc/tests/dwarf-unwind.c |  1 +
 tools/perf/arch/x86/tests/dwarf-unwind.c     |  1 +
 tools/perf/ui/stdio/hist.c                   |  1 +
 tools/perf/util/machine.h                    |  2 +-
 tools/perf/util/map.c                        |  6 ++
 tools/perf/util/map.h                        | 87 +------------------
 tools/perf/util/map_groups.h                 | 91 ++++++++++++++++++++
 tools/perf/util/probe-event.c                |  1 +
 tools/perf/util/symbol-elf.c                 |  1 +
 11 files changed, 106 insertions(+), 87 deletions(-)
 create mode 100644 tools/perf/util/map_groups.h

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 9a0242e74cfc..2c35e532bc9a 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -3,6 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
+#include "map_groups.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 5522ce384723..a6a407fa1b8b 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -3,6 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
+#include "map_groups.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 5f39efef0856..5c178e4a1995 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -3,6 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
+#include "map_groups.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 7879df34569a..6ad0a1cedb13 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -3,6 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
+#include "map_groups.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 814abf5e9a5c..bb653a47f47a 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -5,6 +5,7 @@
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
+#include "../../util/map_groups.h"
 #include "../../util/sort.h"
 #include "../../util/evsel.h"
 #include "../../util/srcline.h"
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index e2f3df45410a..f70ab98a7bde 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -4,7 +4,7 @@
 
 #include <sys/types.h>
 #include <linux/rbtree.h>
-#include "map.h"
+#include "map_groups.h"
 #include "dso.h"
 #include "event.h"
 #include "rwsem.h"
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cf407cc9d915..fbeb0c6efaa6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -557,6 +557,12 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 	refcount_set(&mg->refcnt, 1);
 }
 
+void map_groups__insert(struct map_groups *mg, struct map *map)
+{
+	maps__insert(&mg->maps, map);
+	map->groups = mg;
+}
+
 static void __maps__purge(struct maps *maps)
 {
 	struct rb_root *root = &maps->entries;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5a889db4fca5..0e20749f2c55 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -6,12 +6,10 @@
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdbool.h>
 #include <linux/types.h>
-#include "rwsem.h"
 
 struct dso;
 struct ip_callchain;
@@ -48,38 +46,7 @@ struct map {
 	refcount_t		refcnt;
 };
 
-#define KMAP_NAME_LEN 256
-
-struct kmap {
-	struct ref_reloc_sym	*ref_reloc_sym;
-	struct map_groups	*kmaps;
-	char			name[KMAP_NAME_LEN];
-};
-
-struct maps {
-	struct rb_root	 entries;
-	struct rb_root	 names;
-	struct rw_semaphore lock;
-};
-
-struct map_groups {
-	struct maps	 maps;
-	struct machine	 *machine;
-	refcount_t	 refcnt;
-};
-
-struct map_groups *map_groups__new(struct machine *machine);
-void map_groups__delete(struct map_groups *mg);
-bool map_groups__empty(struct map_groups *mg);
-
-static inline struct map_groups *map_groups__get(struct map_groups *mg)
-{
-	if (mg)
-		refcount_inc(&mg->refcnt);
-	return mg;
-}
-
-void map_groups__put(struct map_groups *mg);
+struct kmap;
 
 struct kmap *__map__kmap(struct map *map);
 struct kmap *map__kmap(struct map *map);
@@ -187,61 +154,9 @@ void map__fixup_end(struct map *map);
 
 void map__reloc_vmlinux(struct map *map);
 
-void maps__insert(struct maps *maps, struct map *map);
-void maps__remove(struct maps *maps, struct map *map);
-struct map *maps__find(struct maps *maps, u64 addr);
-struct map *maps__first(struct maps *maps);
-struct map *map__next(struct map *map);
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
-                                         struct map **mapp);
-void map_groups__init(struct map_groups *mg, struct machine *machine);
-void map_groups__exit(struct map_groups *mg);
-int map_groups__clone(struct thread *thread,
-		      struct map_groups *parent);
-size_t map_groups__fprintf(struct map_groups *mg, FILE *fp);
-
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 				    u64 addr);
 
-static inline void map_groups__insert(struct map_groups *mg, struct map *map)
-{
-	maps__insert(&mg->maps, map);
-	map->groups = mg;
-}
-
-static inline void map_groups__remove(struct map_groups *mg, struct map *map)
-{
-	maps__remove(&mg->maps, map);
-}
-
-static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
-{
-	return maps__find(&mg->maps, addr);
-}
-
-struct map *map_groups__first(struct map_groups *mg);
-
-static inline struct map *map_groups__next(struct map *map)
-{
-	return map__next(map);
-}
-
-struct symbol *map_groups__find_symbol(struct map_groups *mg,
-				       u64 addr, struct map **mapp);
-
-struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
-					       const char *name,
-					       struct map **mapp);
-
-struct addr_map_symbol;
-
-int map_groups__find_ams(struct addr_map_symbol *ams);
-
-int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
-				   FILE *fp);
-
-struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
-
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
 
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
new file mode 100644
index 000000000000..4dcda33e0fdf
--- /dev/null
+++ b/tools/perf/util/map_groups.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_MAP_GROUPS_H
+#define __PERF_MAP_GROUPS_H
+
+#include <linux/refcount.h>
+#include <linux/rbtree.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/types.h>
+#include "rwsem.h"
+
+struct ref_reloc_sym;
+struct machine;
+struct map;
+struct thread;
+
+struct maps {
+	struct rb_root      entries;
+	struct rb_root	    names;
+	struct rw_semaphore lock;
+};
+
+void maps__insert(struct maps *maps, struct map *map);
+void maps__remove(struct maps *maps, struct map *map);
+struct map *maps__find(struct maps *maps, u64 addr);
+struct map *maps__first(struct maps *maps);
+struct map *map__next(struct map *map);
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
+
+struct map_groups {
+	struct maps	 maps;
+	struct machine	 *machine;
+	refcount_t	 refcnt;
+};
+
+#define KMAP_NAME_LEN 256
+
+struct kmap {
+	struct ref_reloc_sym *ref_reloc_sym;
+	struct map_groups    *kmaps;
+	char		     name[KMAP_NAME_LEN];
+};
+
+struct map_groups *map_groups__new(struct machine *machine);
+void map_groups__delete(struct map_groups *mg);
+bool map_groups__empty(struct map_groups *mg);
+
+static inline struct map_groups *map_groups__get(struct map_groups *mg)
+{
+	if (mg)
+		refcount_inc(&mg->refcnt);
+	return mg;
+}
+
+void map_groups__put(struct map_groups *mg);
+void map_groups__init(struct map_groups *mg, struct machine *machine);
+void map_groups__exit(struct map_groups *mg);
+int map_groups__clone(struct thread *thread, struct map_groups *parent);
+size_t map_groups__fprintf(struct map_groups *mg, FILE *fp);
+
+void map_groups__insert(struct map_groups *mg, struct map *map);
+
+static inline void map_groups__remove(struct map_groups *mg, struct map *map)
+{
+	maps__remove(&mg->maps, map);
+}
+
+static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
+{
+	return maps__find(&mg->maps, addr);
+}
+
+struct map *map_groups__first(struct map_groups *mg);
+
+static inline struct map *map_groups__next(struct map *map)
+{
+	return map__next(map);
+}
+
+struct symbol *map_groups__find_symbol(struct map_groups *mg, u64 addr, struct map **mapp);
+struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char *name, struct map **mapp);
+
+struct addr_map_symbol;
+
+int map_groups__find_ams(struct addr_map_symbol *ams);
+
+int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp);
+
+struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
+
+#endif // __PERF_MAP_GROUPS_H
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b0192160513d..0030f9b9bf7e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -42,6 +42,7 @@
 #include "cache.h"
 #include "color.h"
 #include "map.h"
+#include "map_groups.h"
 #include "symbol.h"
 #include "thread.h"
 #include <api/fs/fs.h>
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 848d1a0f8dc0..6b9a2a70da29 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 
 #include "map.h"
+#include "map_groups.h"
 #include "symbol.h"
 #include "demangle-java.h"
 #include "demangle-rust.h"
-- 
2.20.1

