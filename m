Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32337C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B1920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWfL/vzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B1920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeK2JEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:04:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37041 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeK2JEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:04:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so18059936plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rRFTiKpTPNMFVfmzVrsI37RlXOAn7jocrARDPWf4AIU=;
        b=iWfL/vzJqLH03KRjkz2aSQpdRp0VFGKWA4Txo78bHC7lxCTCElxAS3ptgxvjANWUI0
         /4HbjaX0eZsQKtNpeDr3amrDJURrnCHtt6FgFeH1rGQo5h8uShBpLu01fBkxF/oHl+B/
         4gaGPOD4VTA35b6G/FqMFWCYXiycV35FIVACI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rRFTiKpTPNMFVfmzVrsI37RlXOAn7jocrARDPWf4AIU=;
        b=a1E595x9zYKOxKFMZTECSS7xa85y/Mfh/vlb+IBXJE1Oec6bmcTObLDPQiL22casf2
         yLU4giC/uR7hoVxdrULBUhFyl023BNi3QHC2JMaJCoyKcX4+HHWE77bgIeh6Kca5/V9X
         KwqnXKwR7b3PvaiLPZeohVIBPcMeQ3Hz/OXSkGc2Gfk+woE+DklTJX4P/QyZ1imCnq/F
         YVwVZvScfAOKQaBSgJINrI8i6ndLcS2w8QOYYzcdojatD6ialEtJfTI7DQ9eIWeFV+ui
         ch5NgvD8FYOBigABZJIMdYQ3QXTBFahOZtSaCYlhajbEFiv3lVwKQNPNCyiE60fsRby9
         TXXA==
X-Gm-Message-State: AA+aEWZrQH06VAWBUyvWfb91ymNBIfk8QryKK4rnmq3n5h6k/9uqwAd8
        ST2srZSMpauPW2+KdkTbkk0hsw==
X-Google-Smtp-Source: AFSGD/VtZc2q+OMUOyBnH3TubVVJnHnUtm3odnJyulU8S8ItFb+ZTnHETA51KwyQd/75SxVV4l+H+Q==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr38089963pll.33.1543442490423;
        Wed, 28 Nov 2018 14:01:30 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 12sm8698051pgd.35.2018.11.28.14.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:01:29 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] perf tools: Use ioctl function to send sink configuration to kernel
Date:   Wed, 28 Nov 2018 15:01:18 -0700
Message-Id: <1543442478-31465-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The communication of sink information for a trace session doesn't work when
more than one CPU is involved in the scenario due to the static nature of
sysFS.  As such communicate the sink information to each event by using the
driver's sink configuration information and an ioctl command.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 49 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.c           |  7 ++++++
 tools/perf/util/evsel.h           |  1 +
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..4f0563b99a07 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -619,6 +619,26 @@ static FILE *cs_device__open_file(const char *name)
 
 }
 
+static int cs_etm_check_drv_config_term(const char *name)
+{
+	struct stat st;
+	char path[PATH_MAX];
+	const char *sysfs;
+
+	/* CS devices are all found under sysFS */
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return -EINVAL;
+
+	snprintf(path, PATH_MAX,
+		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
+
+	if (stat(path, &st) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
 {
 	va_list args;
@@ -635,7 +655,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term_sysfs(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -650,6 +670,21 @@ static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 	return 0;
 }
 
+static int cs_etm_set_drv_config_term_ioctl(struct perf_evsel *evsel,
+					    struct perf_evsel_config_term *term)
+{
+	int ret;
+	const char *drv_cfg = term->val.drv_cfg;
+
+	/* First check the input */
+	ret = cs_etm_check_drv_config_term(drv_cfg);
+	if (ret)
+		return ret;
+
+	/* All good, apply configuration */
+	return perf_evsel__apply_drv_config(evsel, drv_cfg);
+}
+
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
 			  struct perf_evsel_config_term **err_term)
 {
@@ -660,7 +695,17 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
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
index 6d187059a373..a0374dab843f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1195,6 +1195,13 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, const char *config)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_DRV_CONFIG,
+				     (void *)config);
+}
+
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3147ca76c6fc..30083b0ae62c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -276,6 +276,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, const char *config);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4

