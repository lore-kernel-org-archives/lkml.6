Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DABCC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410DC20C48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHLhyH2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410DC20C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbeGBWeQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:34:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43686 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932263AbeGBWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:33:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so8581247plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWMIpVbHHUucjZTQ8WkuficHw0asDAcRYsZ+36nc5jY=;
        b=XHLhyH2KP3lLTK/guTRSVHiMbf778wKy4jaVyunMI8WBQGllgdtTd/Y0BCMRoWSqkY
         BNFNXKBqOarjdxxxS8gPKE+vWLZsU5E9SsS24Q6gOc06ncho1aPEW6DQRtyhKug5co81
         JTOUFAw5bkia7Q9PjEs9YYOOVErfWmtp1iJ1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWMIpVbHHUucjZTQ8WkuficHw0asDAcRYsZ+36nc5jY=;
        b=PPb57fBNGUYKe0GxhQ9Bs7t9noIz4ORVP8Hbo6dwFasB4HUCQpq7W6n9k8JbxARUqV
         yoXdgSzuilCF8R2Rt9BSkhV6AGCFYuBR5pW8o9B2sTa9WQGHCce6geYpbz6ZHxc72Iur
         sWpSDT39L8tkpvwilzevmeyGjXzoY6If3ZidaPPJUBwV8ypLdk441yfwws6epR5K8gk7
         vMwbpU+4b4Nyzcn8XfErCP1/y4KxQvJfZ7WmrhTMuB6nntzY7yGAx6wgiwioht4Jd3Uz
         0hox0CNT/5U+riuiYWaF1LHjY/1b6sUU7aVuSOKvEU+sFWYwth851CaJ0fVIbBNqUjRw
         X13A==
X-Gm-Message-State: APt69E32AT0lkG/FiphzwTMo6EBDrA3c4BhkS5ghKCZRofVtqlY7FB9Y
        5/wrDFVYDDktD/wOnDIbdI4Q9w==
X-Google-Smtp-Source: ADUXVKKG54+6oKktL4vuM/IlEsdavQ3MuOuohKsETjdjfNtjSU4G44uLgi2oqHdL7DquVioBDLh1Pg==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21-v6mr27432493plo.91.1530570820538;
        Mon, 02 Jul 2018 15:33:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p11-v6sm21764132pgu.16.2018.07.02.15.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 15:33:39 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        mathieu.poirier@linaro.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] perf tools: Use ioctl function to send sink configuration to kernel
Date:   Mon,  2 Jul 2018 16:33:27 -0600
Message-Id: <1530570810-28929-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using sysFS to communicate sink information for a trace session doesn't
work when more than one CPU is involved in the scenario.  As such
communicate the sink information to each event by using the SET_DRV_CONFIG
ioctl command.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 54 ++++-----------------------------------
 1 file changed, 5 insertions(+), 49 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..cb0978eb7181 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -599,55 +599,10 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	return NULL;
 }
 
-static FILE *cs_device__open_file(const char *name)
+static int cs_etm_set_drv_config_term(struct perf_evsel *evsel,
+				      const char *term)
 {
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
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
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
+	return perf_evsel__apply_drv_config(evsel, term);
 }
 
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
@@ -660,7 +615,8 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		err = cs_etm_set_drv_config_term(term);
+		err = cs_etm_set_drv_config_term(evsel,
+						 term->val.drv_cfg);
 		if (err) {
 			*err_term = term;
 			break;
-- 
2.7.4

