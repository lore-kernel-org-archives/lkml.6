Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeEBPXl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbeEBPWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:33 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 49/52] perf symbols: kallsyms__delta() needs the kmap, not the map
Date: Wed,  2 May 2018 12:19:39 -0300
Message-Id: <20180502151942.20542-50-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was only using the map to obtain its kmap, so do the validation in
its called, __dso__load_kallsyms() and pass the kmap, that will be used
in the following patches in similar simplifications.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-u6p9hbonlqzpl6o1z9xzxd75@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2517f2c2454f..76de63cecf98 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1267,14 +1267,10 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
  * If the kernel is relocated at boot time, kallsyms won't match.  Compute the
  * delta based on the relocation reference symbol.
  */
-static int kallsyms__delta(struct map *map, const char *filename, u64 *delta)
+static int kallsyms__delta(struct kmap *kmap, const char *filename, u64 *delta)
 {
-	struct kmap *kmap = map__kmap(map);
 	u64 addr;
 
-	if (!kmap)
-		return -1;
-
 	if (!kmap->ref_reloc_sym || !kmap->ref_reloc_sym->name)
 		return 0;
 
@@ -1288,15 +1284,19 @@ static int kallsyms__delta(struct map *map, const char *filename, u64 *delta)
 int __dso__load_kallsyms(struct dso *dso, const char *filename,
 			 struct map *map, bool no_kcore)
 {
+	struct kmap *kmap = map__kmap(map);
 	u64 delta = 0;
 
 	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
 		return -1;
 
+	if (!kmap || !kmap->kmaps)
+		return -1;
+
 	if (dso__load_all_kallsyms(dso, filename) < 0)
 		return -1;
 
-	if (kallsyms__delta(map, filename, &delta))
+	if (kallsyms__delta(kmap, filename, &delta))
 		return -1;
 
 	symbols__fixup_end(&dso->symbols);
-- 
2.14.3
