Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40150C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A8D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeLNUXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:23:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:23:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKNXT01451338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:23:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKNX2l1451335;
        Fri, 14 Dec 2018 12:23:33 -0800
Date:   Fri, 14 Dec 2018 12:23:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4ea9a7a364b6311b98c4a4e8e3692cdc253015dc@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, hpa@zytor.com, davem@davemloft.net,
        ak@linux.intel.com, jolsa@redhat.com, tglx@linutronix.de,
        acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org
Reply-To: mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
          jolsa@redhat.com, ak@linux.intel.com, mathieu.poirier@linaro.org,
          hpa@zytor.com, davem@davemloft.net, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com
In-Reply-To: <20181106210712.12098-4-adrian.hunter@intel.com>
References: <20181106210712.12098-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Use fallbacks for branch stacks
Git-Commit-ID: 4ea9a7a364b6311b98c4a4e8e3692cdc253015dc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4ea9a7a364b6311b98c4a4e8e3692cdc253015dc
Gitweb:     https://git.kernel.org/tip/4ea9a7a364b6311b98c4a4e8e3692cdc253015dc
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Nov 2018 23:07:12 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:47 -0300

perf script: Use fallbacks for branch stacks

Branch stacks do not necessarily have the same cpumode as the 'ip'. Use
the fallback functions in those cases.

This patch depends on patch "perf tools: Add fallback functions for cases
where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181106210712.12098-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                            | 12 ++++++------
 tools/perf/util/scripting-engines/trace-event-python.c | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 04913136bac9..3ea98fe72f7f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -724,8 +724,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		if (PRINT_FIELD(DSO)) {
 			memset(&alf, 0, sizeof(alf));
 			memset(&alt, 0, sizeof(alt));
-			thread__find_map(thread, sample->cpumode, from, &alf);
-			thread__find_map(thread, sample->cpumode, to, &alt);
+			thread__find_map_fb(thread, sample->cpumode, from, &alf);
+			thread__find_map_fb(thread, sample->cpumode, to, &alt);
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -771,8 +771,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_symbol(thread, sample->cpumode, from, &alf);
-		thread__find_symbol(thread, sample->cpumode, to, &alt);
+		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
+		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
@@ -816,11 +816,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
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
