Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeEOMuQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:50:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:14385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753079AbeEOMpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:45:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41390927"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V1 05/19] perf tools: Use the _stest symbol to identify the kernel map when loading kcore
Date: Tue, 15 May 2018 15:43:19 +0300
Message-Id: <1526388213-30696-6-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first symbol is not necessarily in the kernel text.  Instead of using
the first symbol, use the _stest symbol to identify the kernel map when
loading kcore.

This allows for the introduction of symbols to identify the x86 PTI
entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
1.9.1
