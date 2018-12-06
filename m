Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B03208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131633;
	bh=6Eqoxe+VVgIR0CC6kXYLY3aAYeKHChJtLdOwf2TIn5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lUH3NO/qG8lQhvB90WNe3IiP4qJf032IpCjSEUk1XjRdkL1NkucNbDChncq5yaHCU
	 p4DGSAtRsc/kAGGzf6A6KvaKpH9Zd5ADoqr3uXbVscM13bo7Y0bcPo7tRGU6JniOBu
	 tf24ih4WMIV4DwS9BJsusbAvgB121kjZKmrhrr4I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B03208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLFV1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeLFV1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:11 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD5920989;
        Thu,  6 Dec 2018 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131629;
        bh=6Eqoxe+VVgIR0CC6kXYLY3aAYeKHChJtLdOwf2TIn5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/U2jwG3SIUpwUhDl364vnQlyZxohLYp8OKMqxWXnATnnJ1L13Gk12jTanTcwD/i4
         QeJUJ1vJsLACPerwYgfhDKFsMICTvL574BobS6wif+kSnrJtktuLH2WP31sR8gSl92
         vZDxC7aWSXVMJk58TrNBdqNTxh5HySumafVEzyMo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/75] perf script: Use fallbacks for branch stacks
Date:   Thu,  6 Dec 2018 18:24:56 -0300
Message-Id: <20181206212602.20474-10-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181106210712.12098-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                      | 12 ++++++------
 .../util/scripting-engines/trace-event-python.c  | 16 ++++++++--------
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
-- 
2.19.2

