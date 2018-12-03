Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C3C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKui9vrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C3C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeLCWzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:55:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41588 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeLCWzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:55:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so7128616pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
        b=dKui9vrQfBjN7EW8N937VokmclZqajH1JGzyoa16yHvUwKfx6Al5KjESQQs9Ro9+2P
         0u5Q5IECHU3Oe8W2VZ3NlpD5cVMTOuoRtXXB7xacHUkJ7Xd0eM1m5cTJtRoS5bQexVb3
         uDZslqp9Y9n/UVkr+tYme+8Uq+hgQNAolvrcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
        b=VQFl8ew+J45Yr30gOwJolVpktdyi7+INqu0Tq6z5uEvSj5fWLz4raZr8QuGt9jotV1
         NKkRKyPNmqsBBRcuYC8vqN3MIZsuD1t3fIHfgC9FwkxkxPtayYaNiHKkTragBsFRKCx4
         D+iN6toBgmXqw9E3d+BppE0Yk3RoHpCX+oACP0QEYtj8zLbQ0A07CLKkt/ueJAhY4BX/
         TyHaFeUbi8Guvp2CnrVAzg9xxRqAQO25G64OxIqy1YafS/Dv/KLIKhh6Ea/1hCmvWaX4
         aV3Ncv/8z2o1/SzY5+dDvNS228dPj2CHNYa8xXCjlJ5lzo2rc7Cns46WZ1nbCNvKdhGc
         tpNQ==
X-Gm-Message-State: AA+aEWZ4AytAPHQy7hVXjZ6hhiDEYAtGZz9WiasbiCOfCJGf0EPud77y
        gwE/KSJTMqUtkK4VuWLLsO9LSrQC5+c=
X-Google-Smtp-Source: AFSGD/WCfhAVS3Rr85zZIWf8gp40TUyaehMWbcaUuyPjoNpPjcEmmex7H1rJs/U2prA0VSMkg5r5Vw==
X-Received: by 2002:a63:e754:: with SMTP id j20mr14307610pgk.228.1543877709046;
        Mon, 03 Dec 2018 14:55:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 14:55:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 6/6] perf tools: Use ioctl function to send sink information to kernel
Date:   Mon,  3 Dec 2018 15:54:56 -0700
Message-Id: <1543877696-17174-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The communication of sink information for a trace session doesn't work when
more than one CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
an ioctl command.  The information sent to the kernel is the component's HW
address, which is guaranteed to be unique on the CoreSight bus and known to
the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 66 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.c           |  6 ++++
 tools/perf/util/evsel.h           |  1 +
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..41e394806707 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,11 +22,13 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
 #define ENABLE_SINK_MAX	128
 #define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
+#define AMBA_BUS_DEVICE_PATH "/bus/amba/devices/"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
@@ -619,6 +621,41 @@ static FILE *cs_device__open_file(const char *name)
 
 }
 
+static int cs_etm_check_drv_config_term(const char *name, u64 *addr)
+{
+	char path[PATH_MAX];
+	const char *sysfs;
+	int err;
+	FILE *file;
+	u64 start;
+
+	/* CS devices are all found under sysFS */
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return -EINVAL;
+
+	/* The resource file contains the HW start address of this component */
+	snprintf(path, PATH_MAX,
+		 "%s" AMBA_BUS_DEVICE_PATH "%s" "/resource", sysfs, name);
+
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("Unable to open file: %s\n", path);
+		return -EINVAL;
+	}
+
+	/* We just need the first value */
+	err = fscanf(file, "%016lx", &start);
+	if (err != 1) {
+		pr_debug("Unable to get resource start value for: %s\n", path);
+		return -EINVAL;
+	}
+
+	*addr = start;
+
+	return 0;
+}
+
 static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
 {
 	va_list args;
@@ -635,7 +672,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term_sysfs(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -650,6 +687,21 @@ static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 	return 0;
 }
 
+static int cs_etm_set_drv_config_term_ioctl(struct perf_evsel *evsel,
+					    struct perf_evsel_config_term *term)
+{
+	u64 addr;
+	int ret;
+
+	/* First check the input */
+	ret = cs_etm_check_drv_config_term(term->val.drv_cfg, &addr);
+	if (ret)
+		return ret;
+
+	/* All good, apply configuration */
+	return perf_evsel__apply_drv_config(evsel, addr);
+}
+
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
 			  struct perf_evsel_config_term **err_term)
 {
@@ -660,7 +712,17 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		err = cs_etm_set_drv_config_term(term);
+		/* First try the new interface, i.e ioctl() */
+		err = cs_etm_set_drv_config_term_ioctl(evsel, term);
+		if (!err)
+			continue;
+
+		/*
+		 * Something went wrong, we are probably working with an older
+		 * kernel.  As such use the sysFS interface, which will only
+		 * work for per-thread scenarios.
+		 */
+		err = cs_etm_set_drv_config_term_sysfs(term);
 		if (err) {
 			*err_term = term;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d187059a373..8aa2b79c3314 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1195,6 +1195,12 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_DRV_CONFIG, &addr);
+}
+
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3147ca76c6fc..6be7560bc986 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -276,6 +276,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4

