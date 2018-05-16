Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeEPOtz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeEPOtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:51 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/11] perf tools: Use the "_stest" symbol to identify the kernel map when loading kcore
Date: Wed, 16 May 2018 11:49:06 -0300
Message-Id: <20180516144908.22212-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The first symbol is not necessarily in the kernel text.  Instead of
using the first symbol, use the _stest symbol to identify the kernel map
when loading kcore.

This allows for the introduction of symbols to identify the x86_64 PTI
entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1525866228-30321-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f48dc157c2bd..4a39f4d0a174 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1149,7 +1149,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	bool is_64_bit;
 	int err, fd;
 	char kcore_filename[PATH_MAX];
-	struct symbol *sym;
+	u64 stext;
 
 	if (!kmaps)
 		return -EINVAL;
@@ -1198,13 +1198,13 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		old_map = next;
 	}
 
-	/* Find the kernel map using the first symbol */
-	sym = dso__first_symbol(dso);
-	list_for_each_entry(new_map, &md.maps, node) {
-		if (sym && sym->start >= new_map->start &&
-		    sym->start < new_map->end) {
-			replacement_map = new_map;
-			break;
+	/* Find the kernel map using the '_stext' symbol */
+	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
+		list_for_each_entry(new_map, &md.maps, node) {
+			if (stext >= new_map->start && stext < new_map->end) {
+				replacement_map = new_map;
+				break;
+			}
 		}
 	}
 
-- 
2.14.3
