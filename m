Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7786320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbeKGGgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:36:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:32232 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeKGGgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:36:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 13:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="102068274"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2018 13:09:06 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH V2 3/3] perf tools: Use fallbacks for branch stacks
Date:   Tue,  6 Nov 2018 23:07:12 +0200
Message-Id: <20181106210712.12098-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106210712.12098-1-adrian.hunter@intel.com>
References: <20181106210712.12098-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch stacks do not necessarily have the same cpumode as the 'ip'. Use the
fallback functions in those cases.

This patch depends on patch "perf tools: Add fallback functions for cases
where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # 4.19
---
 tools/perf/builtin-script.c                      | 12 ++++++------
 .../util/scripting-engines/trace-event-python.c  | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b5bc85bd0bbe..a7b4d3f611c5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -728,8 +728,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		if (PRINT_FIELD(DSO)) {
 			memset(&alf, 0, sizeof(alf));
 			memset(&alt, 0, sizeof(alt));
-			thread__find_map(thread, sample->cpumode, from, &alf);
-			thread__find_map(thread, sample->cpumode, to, &alt);
+			thread__find_map_fb(thread, sample->cpumode, from, &alf);
+			thread__find_map_fb(thread, sample->cpumode, to, &alt);
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -775,8 +775,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_symbol(thread, sample->cpumode, from, &alf);
-		thread__find_symbol(thread, sample->cpumode, to, &alt);
+		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
+		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
@@ -820,11 +820,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		if (thread__find_map(thread, sample->cpumode, from, &alf) &&
+		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
 		    !alf.map->dso->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
-		if (thread__find_map(thread, sample->cpumode, to, &alt) &&
+		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
 		    !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 69aa93d4ee99..0c4b050f6fc2 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -494,14 +494,14 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 		pydict_set_item_string_decref(pyelem, "cycles",
 		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
 
-		thread__find_map(thread, sample->cpumode,
-				 br->entries[i].from, &al);
+		thread__find_map_fb(thread, sample->cpumode,
+				    br->entries[i].from, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "from_dsoname",
 					      _PyUnicode_FromString(dsoname));
 
-		thread__find_map(thread, sample->cpumode,
-				 br->entries[i].to, &al);
+		thread__find_map_fb(thread, sample->cpumode,
+				    br->entries[i].to, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "to_dsoname",
 					      _PyUnicode_FromString(dsoname));
@@ -576,14 +576,14 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 		if (!pyelem)
 			Py_FatalError("couldn't create Python dictionary");
 
-		thread__find_symbol(thread, sample->cpumode,
-				    br->entries[i].from, &al);
+		thread__find_symbol_fb(thread, sample->cpumode,
+				       br->entries[i].from, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "from",
 					      _PyUnicode_FromString(bf));
 
-		thread__find_symbol(thread, sample->cpumode,
-				    br->entries[i].to, &al);
+		thread__find_symbol_fb(thread, sample->cpumode,
+				       br->entries[i].to, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "to",
 					      _PyUnicode_FromString(bf));
-- 
2.17.1

