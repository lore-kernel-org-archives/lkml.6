Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeEPSFV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:05:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEPSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:05:20 -0400
Date: Wed, 16 May 2018 11:04:56 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5654997838c2ac9b1950d633fc97f354cc4180e7@git.kernel.org>
Cc: jolsa@redhat.com, dave.hansen@linux.intel.com, ak@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        joro@8bytes.org, acme@redhat.com, luto@kernel.org
Reply-To: adrian.hunter@intel.com, luto@kernel.org, joro@8bytes.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ak@linux.intel.com, jolsa@redhat.com
In-Reply-To: <1525866228-30321-6-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-6-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use the "_stest" symbol to identify the
 kernel map when loading kcore
Git-Commit-ID: 5654997838c2ac9b1950d633fc97f354cc4180e7
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

Commit-ID:  5654997838c2ac9b1950d633fc97f354cc4180e7
Gitweb:     https://git.kernel.org/tip/5654997838c2ac9b1950d633fc97f354cc4180e7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 9 May 2018 14:43:34 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 14:31:25 -0300

perf tools: Use the "_stest" symbol to identify the kernel map when loading kcore

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
 
