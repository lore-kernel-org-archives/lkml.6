Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8BEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BBA218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEitRYvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAaSrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37618 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAaSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so1887467pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgDBy5pU4TSH5DxOCpIvkhjQNbxctYyd7XLZVLAf0nI=;
        b=OEitRYvbdt7M0rQEZwQ0hu+ke2w8T89lMjjsZruG8ofpjewHOgcDS5hxPEAP+vX1sO
         d/YF2ewC8ZGswcUekRvxuUhYkaj7difJ/dM9j1X0+lxgL2AC0QAFahUvWVLvkxJt0JXV
         ZGDf0aPWW6bIapvpzabnJQq4r7GTT8D8bPMNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgDBy5pU4TSH5DxOCpIvkhjQNbxctYyd7XLZVLAf0nI=;
        b=lObWh219t3ixqfD/3HFkfqd4n/N+hDx8KdIWtKJ9wWnjTYyHzOjbwiKDwZsS9BYMzL
         RbV7HOSf6ggTkuaqwhe0zp26mfNFPqIX5gWUOy7GGceR0jJKjlnsxoYu6J1Z9/CuESVY
         t010gXENtAkTROoyOZq8zAqNw9LrdkXKEU9/4dE+pCkr4sgNlb7piBM0kRCmWByxTJ5R
         Xx59EZSGTRdtVnEbiMlmSAOVMNXlG26vUnRpFpd6kZP1iY1nkGuDQ2u2OUuojP6Kd3Zv
         HTrQBTk8uAXJTF9pXQLEdwW7O+njO/oEMiZxiUsswlRnGFdL2jRXZKAfmo9ajjYeYvLp
         bAEQ==
X-Gm-Message-State: AJcUukckbJ5rOa6gfG4k7TglH3sOULbjrsyCJIBn6ufgXtDrjNqx7dDf
        1nSH5y/ixSXL+mdJYlzUForPSh/w9XTc5A==
X-Google-Smtp-Source: ALg8bN5zCSvaw0TDn5aCH92YZ1sv62Z9CwcBzL5+6SWWfyCH0sDj8EUnOb0JFFBnpbtmsfRdB1Ph7Q==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr31458623pgv.407.1548960447382;
        Thu, 31 Jan 2019 10:47:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:47:26 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/7] perf tools: Removing CoreSight set_drv_config() API
Date:   Thu, 31 Jan 2019 11:47:13 -0700
Message-Id: <20190131184714.20388-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that event's config2 attribute is used to communicate sink selection
to the kernel, remove the old set_drv_config() implementation since it
is no longer needed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
index e047571e6080..e4619f2fe7ce 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -8,7 +8,6 @@
 #include <linux/coresight-pmu.h>
 #include <linux/perf_event.h>
 
-#include "cs-etm.h"
 #include "arm-spe.h"
 #include "../../util/pmu.h"
 
@@ -19,7 +18,6 @@ struct perf_event_attr
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		pmu->set_drv_config = cs_etm_set_drv_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		return arm_spe_pmu_default_config(pmu);
-- 
2.17.1

