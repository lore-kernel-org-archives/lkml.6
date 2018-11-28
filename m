Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6649DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE320832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRMnBk/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CE320832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeK2JEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:04:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40577 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeK2JEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:04:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so10100027pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OR+Emv/hXsuIpqoetjY/PmsPRuVeBGeNKk4nTUUJUzU=;
        b=IRMnBk/ELZHfdyqOzNiXDXXMFOgGNE01jpNMzoQRU9t1CwXX4MYuBvx1k25n4uQhJA
         X2BQ0yYsLtqDrktboR0ehpnwY1vRhaMx5/wAJqhlBjE41V31tso4ZKrXf4usxYPzKFew
         CHIiyE9STum4m75W01TsFRx3UeDFazllDTYkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OR+Emv/hXsuIpqoetjY/PmsPRuVeBGeNKk4nTUUJUzU=;
        b=mxTWqRwwNIO9fW9j+lqK4Z7UT/OHQkjSE32i9/n2I5ucHVJx6AyGaXL4Jg5EClT3dz
         crIXwbhwyqsZs9CVWxTjJe7X8peMRk+7+9kUTxhLam859T8a6qHd7ytDflcg+F4XO/3p
         T98vTTv0aMDrhOEZpoRvnan4W/IxmZFRXpjn+HDB9rOMLqDqSa1U8Ai7OHs0u6RDZh8r
         pJH7FNHwu+kSq3JbrZPK92pXKKYxYdaA+SIz0ZhrTHfaaZgIU5nOp7LrJrtt+tCqDb+8
         FGImnVXKafDEFQpbeWDIfyApz7sLgDKWgEzTBn6mzTZFYilbVuCQyMI0SXiDTExC44uZ
         dFSA==
X-Gm-Message-State: AA+aEWb17AwJzW8+JPLFXuP/8KkHgQ1HVZPBV5WGxP2Y5qw1KIKPv+We
        xszWx7Xo5eHUpZfrpLrqNQY4jg==
X-Google-Smtp-Source: AFSGD/V5GeAeppv2gI2HWx4avTDTrITmFUpI9eVchor2gRvJLE7xsEMvyfambAHzVW7jf01Gq0Fiwg==
X-Received: by 2002:a63:de46:: with SMTP id y6mr34645335pgi.198.1543442488773;
        Wed, 28 Nov 2018 14:01:28 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 12sm8698051pgd.35.2018.11.28.14.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:01:28 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/6] perf tools: Make perf_evsel accessible to PMU driver configuration code
Date:   Wed, 28 Nov 2018 15:01:17 -0700
Message-Id: <1543442478-31465-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the perf_evsel available to the PMU driver configuration code.  That
way function perf_evsel__run_ioctl() can be used from there and
information pertaining to the perf_evsel_config_term is still available.

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

