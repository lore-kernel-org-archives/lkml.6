Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06877C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B362B24049
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQiALokg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B362B24049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeGEWOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:14:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39188 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbeGEWOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:14:01 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so1874717plq.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzK96jeA/4D0TqFmCbkbkljgpAZZ6IWuPjpeEQCo8Fg=;
        b=dQiALokgXK8v8B5m27XiIPV2jXkQuoMjG/LxQNrLoJWmpqdU2+2GRo6CcYqnTNJhkl
         mlYzFQeuN4jRUnFk+/f64BbrXsIeRV08+p7/H4rX6HnCr0FQvU5Cksr2inOxLVsLHUh6
         Z+u79nfsE7hykfUK2giLjnkVWvBjmyrVrINXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzK96jeA/4D0TqFmCbkbkljgpAZZ6IWuPjpeEQCo8Fg=;
        b=RJ1g1sxpiFHZpX4ESEpaEUUjSk3LCLXvG/SprgsceR1sghWTHbr14bkqUEkXnNG7RG
         r4y4bZ28okWISmd8FSAMBu9CJUMidenpkKHD0GLuucsbRcyEzMW8IZZkpzzmC6AGcFnN
         1z/SDoHC76BxBvVjgdqNEn+/+HIN00nQHTHBj2E4VY7pC032XvpbvqitkhLV9cIDEJaO
         KBqTGSThcHaEBVFsyon0j47nEFYbMzYn87xUiOXHkm/fPCIOiVX84k8suD05NiGvs82Z
         aIO4gY47B6+AhzzPj2l8x6tHQP5bSTxQd3/nR3Cv76ZA9LXU9ynpG+7W+OyhTgCdJpd7
         JY3A==
X-Gm-Message-State: APt69E0zCcfM1OBZWFCGDNNVJs21c7zYAAanx0We29fUQtZ/sv1Dvs5A
        4VZYiyOcFdLROMUiOhKoJlyOxw==
X-Google-Smtp-Source: AAOMgpcqnie4xwEDGNC1wzqcn9Wj4PnRfEenog7REGojrFncWUz8OdDEHjZNW/L+jX0ri46C/s7t8w==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1-v6mr7764642plb.96.1530828841321;
        Thu, 05 Jul 2018 15:14:01 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r89-v6sm13297486pfa.75.2018.07.05.15.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 15:14:00 -0700 (PDT)
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
Subject: [PATCH v2 5/7] perf tools: Use ioctl to communicate driver configuration to kernel
Date:   Thu,  5 Jul 2018 16:13:45 -0600
Message-Id: <1530828827-11604-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following in the footsteps of what was done for filters, adding the
necessary mechanic needed to push down driver specific configuration
to the kernel using an ioctl. By proceeding this way PMU specific
configuration such as CoreSight sink specification can be communicated
to each event.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/evsel.c | 7 +++++++
 tools/perf/util/evsel.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 94fce4f537e9..534aca4c642c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1162,6 +1162,13 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
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
index d277930b19a1..0f671bd2a988 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -271,6 +271,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, const char *config);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4

