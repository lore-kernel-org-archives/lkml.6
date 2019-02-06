Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D3AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E247E218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479045;
	bh=b7p6b7zuArbBRGq16IzvwIzLSHO+QUBDuGU2MO0Uoec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ekOH0x8A/J/bratc9jVdm1dgNCZ7z2orxoXqxbP/1mKBuFGl3u/2uG8qKPskh0Rmn
	 Olq0o9Nwx6OeGodLvc9HeBmnbJsGDh26WIJo7WDA+eVyWzSTnI510wNHTG36aqW/pY
	 N8YkRWl/XbCBhMlzu16bz9atvJVVbKY3Oro4NTNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBFSun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfBFSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:41 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC0A2083B;
        Wed,  6 Feb 2019 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479040;
        bh=b7p6b7zuArbBRGq16IzvwIzLSHO+QUBDuGU2MO0Uoec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0iERJWmh/uA29lZsgIDsDZzpk0bO9xSfWvfaEdNk/dQPkEbhOCgkW5I/oI1jrfKb
         E98Gu2EDXOhXj+0TZWrDem/eqE6cyoFpLYH/IU1qpn1jctkRFkMskFONtrbqtZgWhd
         vbLuGuQ/NKmjEKmRuUGeGw/7krCgZEvLq/GjdGVg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/53] perf pmu: Remove set_drv_config API
Date:   Wed,  6 Feb 2019 15:48:36 -0300
Message-Id: <20190206184903.24054-27-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

CoreSight was the only client of the PMU's set_drv_config() API.  Now
that it is no longer needed by CoreSight remove it from the code base.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-8-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c   | 10 -----
 tools/perf/builtin-stat.c     |  9 ----
 tools/perf/builtin-top.c      | 13 ------
 tools/perf/util/Build         |  1 -
 tools/perf/util/drv_configs.c | 78 -----------------------------------
 tools/perf/util/drv_configs.h | 26 ------------
 tools/perf/util/pmu.h         |  1 -
 7 files changed, 138 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 88ea11d57c6f..56e9d9e8c174 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -23,7 +23,6 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
-#include "util/drv_configs.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/symbol.h"
@@ -567,7 +566,6 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
-	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	/*
@@ -620,14 +618,6 @@ static int record__open(struct record *rec)
 		goto out;
 	}
 
-	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-		      err_term->val.drv_cfg, perf_evsel__name(pos), errno,
-		      str_error_r(errno, msg, sizeof(msg)));
-		rc = -1;
-		goto out;
-	}
-
 	rc = record__mmap(rec);
 	if (rc)
 		goto out;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e587808591e8..bb24f9c17f9a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -52,7 +52,6 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
-#include "util/drv_configs.h"
 #include "util/color.h"
 #include "util/stat.h"
 #include "util/header.h"
@@ -417,7 +416,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
-	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -514,13 +512,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		return -1;
 	}
 
-	if (perf_evlist__apply_drv_configs(evsel_list, &counter, &err_term)) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-		      err_term->val.drv_cfg, perf_evsel__name(counter), errno,
-		      str_error_r(errno, msg, sizeof(msg)));
-		return -1;
-	}
-
 	if (STAT_RECORD) {
 		int err, fd = perf_data__fd(&perf_stat.data);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 619406339e4b..231a90daa958 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -25,7 +25,6 @@
 #include "util/bpf-event.h"
 #include "util/config.h"
 #include "util/color.h"
-#include "util/drv_configs.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/event.h"
@@ -1186,10 +1185,6 @@ static void init_process_thread(struct perf_top *top)
 
 static int __cmd_top(struct perf_top *top)
 {
-	char msg[512];
-	struct perf_evsel *pos;
-	struct perf_evsel_config_term *err_term;
-	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 	pthread_t thread, thread_process;
 	int ret;
@@ -1240,14 +1235,6 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		goto out_delete;
 
-	ret = perf_evlist__apply_drv_configs(evlist, &pos, &err_term);
-	if (ret) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
-			str_error_r(errno, msg, sizeof(msg)));
-		goto out_delete;
-	}
-
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b69d6294c88c..a36e6e5a6f4f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -107,7 +107,6 @@ libperf-y += term.o
 libperf-y += help-unknown-cmd.o
 libperf-y += mem-events.o
 libperf-y += vsprintf.o
-libperf-y += drv_configs.o
 libperf-y += units.o
 libperf-y += time-utils.o
 libperf-y += expr-bison.o
diff --git a/tools/perf/util/drv_configs.c b/tools/perf/util/drv_configs.c
deleted file mode 100644
index eec754243f4d..000000000000
--- a/tools/perf/util/drv_configs.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * drv_configs.h: Interface to apply PMU specific configuration
- * Copyright (c) 2016-2018, Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#include "drv_configs.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "pmu.h"
-#include <errno.h>
-
-static int
-perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
-			      struct perf_evsel_config_term **err_term)
-{
-	bool found = false;
-	int err = 0;
-	struct perf_evsel_config_term *term;
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL)
-		if (pmu->type == evsel->attr.type) {
-			found = true;
-			break;
-		}
-
-	list_for_each_entry(term, &evsel->config_terms, list) {
-		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
-			continue;
-
-		/*
-		 * We have a configuration term, report an error if we
-		 * can't find the PMU or if the PMU driver doesn't support
-		 * cmd line driver configuration.
-		 */
-		if (!found || !pmu->set_drv_config) {
-			err = -EINVAL;
-			*err_term = term;
-			break;
-		}
-
-		err = pmu->set_drv_config(term);
-		if (err) {
-			*err_term = term;
-			break;
-		}
-	}
-
-	return err;
-}
-
-int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
-				   struct perf_evsel **err_evsel,
-				   struct perf_evsel_config_term **err_term)
-{
-	struct perf_evsel *evsel;
-	int err = 0;
-
-	evlist__for_each_entry(evlist, evsel) {
-		err = perf_evsel__apply_drv_configs(evsel, err_term);
-		if (err) {
-			*err_evsel = evsel;
-			break;
-		}
-	}
-
-	return err;
-}
diff --git a/tools/perf/util/drv_configs.h b/tools/perf/util/drv_configs.h
deleted file mode 100644
index 32bc9babc2e0..000000000000
--- a/tools/perf/util/drv_configs.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * drv_configs.h: Interface to apply PMU specific configuration
- * Copyright (c) 2016-2018, Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#ifndef __PERF_DRV_CONFIGS_H
-#define __PERF_DRV_CONFIGS_H
-
-#include "drv_configs.h"
-#include "evlist.h"
-#include "evsel.h"
-
-int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
-				   struct perf_evsel **err_evsel,
-				   struct perf_evsel_config_term **term);
-#endif
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1c12a61ed0dc..47253c3daf55 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -31,7 +31,6 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
 };
 
 struct perf_pmu_info {
-- 
2.20.1

