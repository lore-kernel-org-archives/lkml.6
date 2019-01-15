Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5763820866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqRrsVaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391343AbfAOXIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:08:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47069 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391292AbfAOXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so2013922pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gPrWMMpDRosRuuCKq7RVqqPV5xVc5OS0HdA7yr9gVbk=;
        b=QqRrsVaBJ7rICeZftdrm7Ke54BLqO4IpJ+ykpcY8TsczjNwJap13T56otWVRsJ2+6d
         HQIW4hI5sXRNBTbBG/FIL660lxD3zLbuIlWAXp0VjrpyFfrw5YhfqDp4DSvpo7XBtL+/
         qN5NlzimZrdkkaRSehkgJWGsM4F4jzcZMfrAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gPrWMMpDRosRuuCKq7RVqqPV5xVc5OS0HdA7yr9gVbk=;
        b=jT1e/aCUZjo530Syqbjo2E//q5Y/2OGLoJhu+s1Bco3QMviZvaIiyaG6mK9To7Q/qZ
         a+TDLTdI+hIZUvT8bq3cYW7Vd/r60xmWK32FkIFl8yBvTHwGu1yq7IyeTcEgxJ0bvA7j
         k4z2siB7LAGxwbMpCHuwwNf8lMyEs6DIj/Tn+wyDKCk45VZZaRdDD4Qv1mfXvBIb7rlq
         AfmZLlDMDQoe8k9cyLZ0qMglES6jPhhpzRbq/gDuFwaRb5fg/Qez8EvG/Dd4ZNqdD773
         3YQYe+HWnR/EKM85B4kKUpdQGv15639ds6rPqn0WLoRthtp91N6T/d9eSUVgCJeFGQJ9
         M0yg==
X-Gm-Message-State: AJcUukfbH8fLY1cSuk74MdFSXCkIB2bVwd7aqZ6URPiCiDgB8EwkUhUZ
        ZEBzfBtXiIQ0GwZ3xeFQeTCfLA==
X-Google-Smtp-Source: ALg8bN7d7naR6+z1U4DvgU8Htv0DbSptiG8r/8AUM4tBwI3+UrAiOCzopbH0dYKm9ks4/LdW332fhg==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr5958903pgg.401.1547593675503;
        Tue, 15 Jan 2019 15:07:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:07:54 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] perf tools: Use event attributes to send sink information to kernel
Date:   Tue, 15 Jan 2019 16:07:40 -0700
Message-Id: <20190115230742.13730-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The communication of sink information for a trace session doesn't work when
more than on CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
perf_event::attr:config2 attribute.  The information sent to the kernel is
an hash of the sink's name, which is unique in a system.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..4aa6193dcb50 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,6 +22,7 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
@@ -60,10 +61,45 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
+				struct perf_evsel *evsel)
+{
+	char msg[BUFSIZ], path[PATH_MAX], *sink;
+	struct perf_evsel_config_term *term;
+	int ret = -EINVAL;
+	u32 hash;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		sink = term->val.drv_cfg;
+		snprintf(path, PATH_MAX, "sinks/%s", sink);
+
+		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
+		if (ret != 1) {
+			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
+			       sink, perf_evsel__name(evsel), errno,
+			       str_error_r(errno, msg, sizeof(msg)));
+			return ret;
+		}
+
+		evsel->attr.config2 = (u64)hash;
+		return 0;
+	}
+
+	/*
+	 * No sink was provided on the command line - for _now_ treat
+	 * this as an error.
+	 */
+	return ret;
+}
+
 static int cs_etm_recording_options(struct auxtrace_record *itr,
 				    struct perf_evlist *evlist,
 				    struct record_opts *opts)
 {
+	int ret;
 	struct cs_etm_recording *ptr =
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
@@ -92,6 +128,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cs_etm_evsel)
 		return 0;
 
+	ret = cs_etm_set_sink_attr(cs_etm_pmu, cs_etm_evsel);
+	if (ret)
+		return ret;
+
 	if (opts->use_clockid) {
 		pr_err("Cannot use clockid (-k option) with %s\n",
 		       CORESIGHT_ETM_PMU_NAME);
-- 
2.17.1

