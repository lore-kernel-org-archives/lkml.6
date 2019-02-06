Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B256C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E27F2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479040;
	bh=y1hJcwFfmM7GowVfJ/o6QbsDTQqNuGG8uGw2xjQ2wpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UzmA7BTmS01lnZCQ/9dyovNJL3ne2n3koe2WbhEoamVTkyHxAgkOclExwAMv7ytFN
	 IvFQbCYx38B5OTmpWsGjsyIXq9jb1hEelBPc+1u101DAXqe1qybDrKUHKyu7xcnJvp
	 4bEoPtSYdABZ1X/dfFgNO3ZZGFybX2uSk3Yjf7rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBFSui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfBFSuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:37 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD380218D3;
        Wed,  6 Feb 2019 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479035;
        bh=y1hJcwFfmM7GowVfJ/o6QbsDTQqNuGG8uGw2xjQ2wpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoJc9A5n7e3mOsJLHtlZ3RGftrFnl+9kRWCpTs7XbcKp5cHIxPNwCONyiG1W4ZwiJ
         xBnUCS3onjWxSX5HgUXkMXN5Zsz16qpphsgs7sG6T5JlCVS410pQE0fZVJvi6SDLi4
         VcvfadMFekNHCh1hVhrGCD1HymtLvJdEu5YLyRac=
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
Subject: [PATCH 25/53] perf coresight: Remove set_drv_config() API
Date:   Wed,  6 Feb 2019 15:48:35 -0300
Message-Id: <20190206184903.24054-26-acme@kernel.org>
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

Now that the event's config2 attribute is used to communicate sink
selection to the kernel, remove the old set_drv_config() implementation
since it is no longer needed.

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
Link: http://lkml.kernel.org/r/20190131184714.20388-7-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 54 -------------------------------
 tools/perf/arch/arm/util/cs-etm.h |  3 --
 tools/perf/arch/arm/util/pmu.c    |  2 --
 3 files changed, 59 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4f31cf0d1e6d..911426721170 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -27,9 +27,6 @@
 #include <stdlib.h>
 #include <sys/stat.h>
 
-#define ENABLE_SINK_MAX	128
-#define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
-
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
@@ -642,54 +639,3 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 out:
 	return NULL;
 }
-
-static FILE *cs_device__open_file(const char *name)
-{
-	struct stat st;
-	char path[PATH_MAX];
-	const char *sysfs;
-
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		return NULL;
-
-	snprintf(path, PATH_MAX,
-		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
-
-	if (stat(path, &st) < 0)
-		return NULL;
-
-	return fopen(path, "w");
-
-}
-
-static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
-{
-	va_list args;
-	FILE *file;
-	int ret = -EINVAL;
-
-	va_start(args, fmt);
-	file = cs_device__open_file(name);
-	if (file) {
-		ret = vfprintf(file, fmt, args);
-		fclose(file);
-	}
-	va_end(args);
-	return ret;
-}
-
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
-{
-	int ret;
-	char enable_sink[ENABLE_SINK_MAX];
-
-	snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
-		 term->val.drv_cfg, "enable_sink");
-
-	ret = cs_device__print_file(enable_sink, "%d", 1);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 1a12e64f5127..a3354bda4fe8 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -7,9 +7,6 @@
 #ifndef INCLUDE__PERF_CS_ETM_H__
 #define INCLUDE__PERF_CS_ETM_H__
 
-#include "../../util/evsel.h"
-
 struct auxtrace_record *cs_etm_record_init(int *err);
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
 
 #endif
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 64a677b518d0..bbc297a7e2e3 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -9,7 +9,6 @@
 #include <linux/perf_event.h>
 #include <linux/string.h>
 
-#include "cs-etm.h"
 #include "arm-spe.h"
 #include "../../util/pmu.h"
 
@@ -20,7 +19,6 @@ struct perf_event_attr
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		pmu->set_drv_config = cs_etm_set_drv_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		return arm_spe_pmu_default_config(pmu);
-- 
2.20.1

