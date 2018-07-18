Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12736ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D72075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vx0Upq58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeGRW2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:28:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37327 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbeGRW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:28:15 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so5375329ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzK96jeA/4D0TqFmCbkbkljgpAZZ6IWuPjpeEQCo8Fg=;
        b=Vx0Upq58oqevY3SqboDQJX1fA3xSX2npr5PrLEOKB8M9FghncKRiO0iKyekvaENNfz
         WAnEBn1VTZLtHjIGMf46eEoSxVTfv4q4VvS4xiIp4XV3e8AH8JKM83swgDGOQqtp3eWz
         T882tnnaP6Us+IWEgbLXmypBYppuKqwirvmBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzK96jeA/4D0TqFmCbkbkljgpAZZ6IWuPjpeEQCo8Fg=;
        b=CuHXqnAwKj8pjTPuRaQzIhKal2eE1UZKFPFNnHW5NkNFOZgp5f/UZgz8AnwfYSGc7c
         21L/jxOlByEWcZllRXNvH4ngtnu7X1N1aBHtpTa7jKL6kqWu298tP7ML0NMvu42dgXun
         p21jq1nSqOC0zoCA772bdnBrGEDCI719/cBMTT9JjQM8mLlMkzE4HAJWQZYmG7FKLtB2
         21ABDcJtdLotEBULDEvOudeva9qTmKXMJ2Jyey1dIvgWzvGEv/6cQh+sLX3zCldLQ64J
         TwFJFTVc1uD/qt0+r+yCUo12/7tpiIIIRSl5v4jFy6zPld69YIKHFFXxvwWmPIKQ1CPR
         bH9Q==
X-Gm-Message-State: AOUpUlFgWcRadMChVGJh2XF9FZxWFXXY+WLFDzo/MxZmLdqNn06G86BH
        i2uphsFU25RzxggRRf8KTJa/lQ==
X-Google-Smtp-Source: AA+uWPzIfU06TTJWYKNC4AqTnMM678f6e/qKZ2CFE7u5m906IKBKicKb2sGeTtSDOaCGf5Cmq/2HPQ==
X-Received: by 2002:a6b:4f03:: with SMTP id d3-v6mr6822623iob.176.1531950503608;
        Wed, 18 Jul 2018 14:48:23 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2093386ita.35.2018.07.18.14.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 14:48:22 -0700 (PDT)
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
Subject: [PATCH v3 5/7] perf tools: Use ioctl to communicate driver configuration to kernel
Date:   Wed, 18 Jul 2018 15:48:05 -0600
Message-Id: <1531950487-24554-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
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

