Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4AEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9EF218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKYMv/vV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfAaSrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37695 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfAaSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so1882192plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bRWUwYnj28kBvbJLtyjNHTdBWqKDkbKXjpXnSK8ue0c=;
        b=dKYMv/vVYjuiSgre0jRV1GEM0M8C+cEcETL2BWXZTHSoZiQ2SEBsPqSDRsCr6Kw8i8
         2JqPlL+ehsAS6kHAuDvFUkBhGrI/ScPCk3OTLiTA7lA6IIn2SZcJrNcOvWrK7oqKNSoN
         aDTrlc5k9W6W1uUmX+BIemad6qq/WMVyMiTd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bRWUwYnj28kBvbJLtyjNHTdBWqKDkbKXjpXnSK8ue0c=;
        b=c5ZroRUBddUnx2425ET+PiVbjNl+rtDRsQp1yYBGNipIxsFGC1jl6cdpFed4RQBt2K
         Wi+Fe3O5VmtDHxzrktH/jq329C6lSEM7P+3DXuopFggsv3NenRKLR+EI0Ck08q8GKnVA
         suWnMTbhZZSTmmahmZKoxhhSKEgYPUU3ni5ppqbw8KAC524l8B4DriD+ON/KpQFPHYE+
         F53OzkkXXNIbj2XBO372u6ujQSo0nEYnlKFhRCEOSJ/zJo1ZOGygC4pwqUEyitXuNmpI
         ga7iH6LBPn/a3uYuNXg8cPnXWxaG3AgB2UL3Ri/yq69nhTfqnPIzoLGbmMxismXV/IhS
         DEcg==
X-Gm-Message-State: AJcUuke5aLxPEBWvC6+rBMH+BnRG/8wbJD1T7NlDdoI6JX9vBm6oSu66
        Y5Lx1EfRGDnaQZZXy7H5qLmKlA==
X-Google-Smtp-Source: ALg8bN5ux3i3o1Ncjpv7IAxd1hpYjqWCeNIVuq9Cr+oy1o1TGUZhLOBLArOVo9u0Y9xm8az1sVDyYA==
X-Received: by 2002:a17:902:28e6:: with SMTP id f93mr35604380plb.239.1548960445634;
        Thu, 31 Jan 2019 10:47:25 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:47:24 -0800 (PST)
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
Subject: [PATCH v3 5/7] perf tools: Use event attributes to send sink information to kernel
Date:   Thu, 31 Jan 2019 11:47:12 -0700
Message-Id: <20190131184714.20388-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
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
 tools/perf/arch/arm/util/cs-etm.c | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..4f31cf0d1e6d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -5,6 +5,7 @@
  */
 
 #include <api/fs/fs.h>
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
@@ -22,6 +23,7 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
@@ -60,10 +62,48 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
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
+	if (evsel->attr.config2 & GENMASK(31, 0))
+		return 0;
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
+		evsel->attr.config2 |= hash;
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
@@ -92,6 +132,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
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

