Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B631F24049
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxkYtm14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B631F24049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeGEWOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:14:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35745 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753813AbeGEWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:14:03 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so1873199plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQAmyMFajI++8HwoDa2U9XFg2UmDhXlRNwslkHRjsDM=;
        b=MxkYtm14vqBDd1L4AMxbTZoCA2DMyV8Wr40xpsY936dcV1rFQscw0ocDVOZPudiNwB
         ptZBCYXp89alS5RnEUZS32CX++cGboHybRNc8mQZC7mvWgOS1YEql0a2OFCPpyuVB7/b
         AWxe5xmN2GjplCbR4ixgzoPw4Gtr5NaBJp8Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQAmyMFajI++8HwoDa2U9XFg2UmDhXlRNwslkHRjsDM=;
        b=ogQuk4op+f+TEjH7RHXtRvzowx6H1MHvtUyMy1rlPCZYLfTPwtFyWwGSqFmmEqPBxk
         p8Bw98xhD/wOMqSZOz4cc29R04LLCOSiz024f17azeuAiPR5pNPdzg6ySoRjiflziuXl
         TyiTGVuAJskcprQnBWcvhRnUYyVcjKOmIHgDWFZDfbizmaJ3TRGufg56AdxT05NJrmI7
         qaROeJ5eYFK5SOlnocQKYCVzKDcaFtmFubY4fhTwqKiRF+0ESeBE+de8xvsJbhUMkXMO
         BR/LTWYtmh42rG3xbKyxCLlxM8i3QfUDfDy5cJLW0ccMArMmq+qM6Ib695cFUoHx2hCz
         UCZw==
X-Gm-Message-State: APt69E1XrL5nulQ181jRWilDWBSZ/oCnetB40edAvwwE/MvbdRdtCCUf
        TTZvPTIMgQbnPrkgEese0qPkJQ==
X-Google-Smtp-Source: AAOMgpf52IhGW6pc5rX22MlwZ1Dc1R6m3DAR9wRoXSF+mQmh+nFvK/4QxCnYpyVHHk0eZfQSMbByCA==
X-Received: by 2002:a17:902:7606:: with SMTP id k6-v6mr7747802pll.56.1530828843405;
        Thu, 05 Jul 2018 15:14:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r89-v6sm13297486pfa.75.2018.07.05.15.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 15:14:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] perf tools: Make perf_evsel accessible to PMU driver configuration code
Date:   Thu,  5 Jul 2018 16:13:46 -0600
Message-Id: <1530828827-11604-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make structure perf_evsel available to the PMU driver configuration code.
That way function perf_evsel__apply_drv_config() can be used from within
that code and information pertaining to the 'perf_evsel_config_term' is
still available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 22 +++++++++++++++++++++-
 tools/perf/arch/arm/util/cs-etm.h |  3 ++-
 tools/perf/util/drv_configs.c     | 30 +++++++-----------------------
 tools/perf/util/pmu.h             |  3 ++-
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..d8081c2e6d44 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -635,7 +635,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -649,3 +649,23 @@ int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
 
 	return 0;
 }
+
+int cs_etm_set_drv_config(struct perf_evsel *evsel,
+			  struct perf_evsel_config_term **err_term)
+{
+	int err = 0;
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		err = cs_etm_set_drv_config_term(term);
+		if (err) {
+			*err_term = term;
+			break;
+		}
+	}
+
+	return err;
+}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 1a12e64f5127..a3f8dde6ccef 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -10,6 +10,7 @@
 #include "../../util/evsel.h"
 
 struct auxtrace_record *cs_etm_record_init(int *err);
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
+int cs_etm_set_drv_config(struct perf_evsel *evsel,
+			  struct perf_evsel_config_term **err_term);
 
 #endif
diff --git a/tools/perf/util/drv_configs.c b/tools/perf/util/drv_configs.c
index eec754243f4d..f7c1bcf08549 100644
--- a/tools/perf/util/drv_configs.c
+++ b/tools/perf/util/drv_configs.c
@@ -25,7 +25,6 @@ perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
 {
 	bool found = false;
 	int err = 0;
-	struct perf_evsel_config_term *term;
 	struct perf_pmu *pmu = NULL;
 
 	while ((pmu = perf_pmu__scan(pmu)) != NULL)
@@ -34,29 +33,14 @@ perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
 			break;
 		}
 
-	list_for_each_entry(term, &evsel->config_terms, list) {
-		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
-			continue;
+	/*
+	 * No need to continue if we didn't get a match or if there is no
+	 * driver configuration function for this PMU.
+	 */
+	if (!found || !pmu->set_drv_config)
+		return err;
 
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
+	return pmu->set_drv_config(evsel, err_term);
 }
 
 int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..47f44394042b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -29,7 +29,8 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
+	int (*set_drv_config)	(struct perf_evsel *evsel,
+				 struct perf_evsel_config_term **err_term);
 };
 
 struct perf_pmu_info {
-- 
2.7.4

