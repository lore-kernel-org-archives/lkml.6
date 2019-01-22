Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE374C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F51921019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7ZvJSuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAVSMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:12:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38719 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfAVSL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:11:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so11406253pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W6/A2tfSYGw9pTsmVq4n41iTRg138j1rlpbipIKTLNs=;
        b=K7ZvJSujgUfGxnCrede2OGo/ax6P3FNh6L3H192OJa8ot97BuR3wzx9K8SDLBeOkTe
         4S3o9LR6UwV8HDoFSAR8Vq/3h8CRshuYiWFFmE6Wq2K1oNunLsPmHYFkR9NARbWi/9yK
         N6zEp3DoqJPXqPfYO90XrmuSlklLeIAfDcn9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W6/A2tfSYGw9pTsmVq4n41iTRg138j1rlpbipIKTLNs=;
        b=qTXpnkD8Alt/8T02zuBGKoaESM3UjnRWnY56amBvt5uNrEjZ67JKHcLl6I9auuJl7j
         JxfCoIRWzxP0jowaKco/1wbKsNW+ide5BfIRQEMqeWbeDw4ERUXMnYsQEHcY793bnoZV
         7jF/fxviSH/WUzYCslctpC2ATbbGgv0yke8NY9epXQjTjWk4Mp6IUJ4/taCiQcZvE18O
         fP2XOeVmwwGFi2hCtEHdLyF8CIw2nI0gjGHW/nQ2iA0/WkReKYGFaO9/6ECXYOil9a+J
         a1DWtTvRQh04q8c1TnaA2RRi0ohoG1i5AvzSxOLDBaxQ58Z6wtBMe8Q2v04eslzR1jM0
         L8Dw==
X-Gm-Message-State: AJcUukdU+7EJelXo1XsJL1knxJ1GSZ46L+qkUy1G05RbGMBC5N8a1EYW
        u9uTScSVq2s8CXLItn/qemnX6A==
X-Google-Smtp-Source: ALg8bN4KOUN8xvSnGVqbaii1u68MNliActBhE/OlLVltBkwCV5ctGm9yLnMMrCAf5pUjKjZE7MkNcw==
X-Received: by 2002:a65:6684:: with SMTP id b4mr33005880pgw.55.1548180719155;
        Tue, 22 Jan 2019 10:11:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:11:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Subject: [PATCH v2 7/7] perf tools: Remove PMU::set_drv_config API
Date:   Tue, 22 Jan 2019 11:11:44 -0700
Message-Id: <20190122181144.26645-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight was the only client of the PMU's set_drv_config() API.  Now
that it is no longer needed by CoreSight remove it from the code base.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
index 882285fb9f64..b637c37b8479 100644
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
@@ -566,7 +565,6 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
-	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	/*
@@ -619,14 +617,6 @@ static int record__open(struct record *rec)
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
index 63a3afc7f32b..9c5b3b94bb38 100644
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
@@ -418,7 +417,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
-	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -515,13 +513,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
index f64e312db787..33e448f702b6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -24,7 +24,6 @@
 #include "util/annotate.h"
 #include "util/config.h"
 #include "util/color.h"
-#include "util/drv_configs.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/event.h"
@@ -1184,10 +1183,6 @@ static void init_process_thread(struct perf_top *top)
 
 static int __cmd_top(struct perf_top *top)
 {
-	char msg[512];
-	struct perf_evsel *pos;
-	struct perf_evsel_config_term *err_term;
-	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 	pthread_t thread, thread_process;
 	int ret;
@@ -1232,14 +1227,6 @@ static int __cmd_top(struct perf_top *top)
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
index af72be7f5b3b..71e697e7df2d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,7 +104,6 @@ libperf-y += term.o
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
index 350c54e0bd3d..569a6cbffd5a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -30,7 +30,6 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
 };
 
 struct perf_pmu_info {
-- 
2.17.1

