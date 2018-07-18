Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4007D2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOCSYYCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4007D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGRW2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:28:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32993 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbeGRW2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:28:17 -0400
Received: by mail-it0-f66.google.com with SMTP id y124-v6so253721itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQAmyMFajI++8HwoDa2U9XFg2UmDhXlRNwslkHRjsDM=;
        b=IOCSYYCDhtpAP51yrwIXCOrnAheFCri7FXo/wF12PyJQpLV/zi26WZb4qawpC1D4Tr
         1wEq/NTg7lhbzERFueEVwjuxmYakZp4Mr6LEcaCUpW3uK+Tqaz0owx6P3p0eK/SiTpAr
         T/hJIlcIpMM+JaNjtVvpq9ExM7KPOsN0QXPdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQAmyMFajI++8HwoDa2U9XFg2UmDhXlRNwslkHRjsDM=;
        b=KDb82N0yJ4gdpFI+wlPS2POJ1Nj004cOuT283s0oZZYxTZbMcQH9y8NaIY8iCcdX9H
         jP3v00UkIxAYHqKgpOY7/pJzlyHufM6XDXpNgvt8KZhoqtNAPJQrGH6DjfnbTUjbSZVM
         XSCu7US9gPRJ1oZmMAYknvC3kCX1UfByG+jpXNCYWrVT3NscF5pPLtyi84Ja4A25b6Dh
         BYNHq+ftBCD9CmnEPw0WPyHTsHei7O6qIpDBYymEBXYmoVVKQkUmEwY2OJ4lmZMvkx2X
         KWa4Clw+T6y2Go9dQVEiTXZqOpJj8F+W2+oE6eD/ApgHxEoEfQtTsEx3EbOIdcDH9A/8
         yUoQ==
X-Gm-Message-State: AOUpUlFNJMt4fM5JO5yx0VPzuJCQ8jOONj6hFbllSFZkmnwb0+m5yDOS
        ZEJrfgSoR0/zthE8aJ9SyPTzoQ==
X-Google-Smtp-Source: AAOMgpfq3ul4U6/rv/ofrCqfFysQPSoypms/Zp1dQJSshHRTR775fzvchAzXPkxkuWFXo44pgrtVbg==
X-Received: by 2002:a24:83c6:: with SMTP id d189-v6mr2490711ite.75.1531950506126;
        Wed, 18 Jul 2018 14:48:26 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2093386ita.35.2018.07.18.14.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 14:48:25 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, kim.phillips@arm.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/7] perf tools: Make perf_evsel accessible to PMU driver configuration code
Date:   Wed, 18 Jul 2018 15:48:06 -0600
Message-Id: <1531950487-24554-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
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

