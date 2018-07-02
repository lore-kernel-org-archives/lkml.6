Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C699C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE4121758
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJsKreuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE4121758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeGBWef (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:34:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34531 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbeGBWdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:33:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id e10-v6so4033pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44uRkWGk/Osvmk24aNdLebhqCx/Gifs6WBek1wZDfO8=;
        b=EJsKreuLczzPxxAeQS9U4zc42OStBcWtV3mG5AtxdY4SiLAO2PnVUq3GAUizBO1Enm
         D9p3Mtz/f6Jy6HHYXEi6CIgtI8oTug41GeHaAue5xdq/4HF4Q2b5iUSXXw/mz3tKZpyq
         ANE35Koraq1X+XhyRcDJyFeQwMe2L5+XdZG0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44uRkWGk/Osvmk24aNdLebhqCx/Gifs6WBek1wZDfO8=;
        b=lxF1+HfSMhCXM5OZyZXybCNh8gsFdoP1KwmKHNqRVICcZkb58+S8GXLLvcZd9rDiAL
         f1unaJxP1nBOKCGOUz/ay4noHNYz8c5FWIxNOGcvHVQSCsFGS9NeWZsPr0QUjkxNHZoc
         +mrG/C9/MubV5jvE76gQQ8ybyxa7p2e0bknsY+Kx1M9yvOTYTNQy0bJMcbDLZnjb4PRt
         BWm1JbKv8AuceUqNNwWHJ3fs0hpC5TTepowT3jl5Yzchv4VS29g2VcX2pesyOJ6Qizcq
         vn8aS5i2pnRGoEfG+Ro5ewaRHoOhVpmHeNgMevjSyLkNcuMOvCl1bFCsDjAfehgQFn/e
         XXnw==
X-Gm-Message-State: APt69E30EitTVydY7sAfcKCS7QjrebV8aPC0FfUwg0HemAaWLigbc1u1
        JzJZvTKxi4RRfeQWvayXTOV/Xg==
X-Google-Smtp-Source: AAOMgpfP2k8LGuujrnyseQ9BmVyBsws57GGsZjH7Bc31R/Ds9ZzH+p/gni7oHCRXAr744reyiszE8w==
X-Received: by 2002:a62:a8e:: with SMTP id 14-v6mr27103338pfk.57.1530570815969;
        Mon, 02 Jul 2018 15:33:35 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p11-v6sm21764132pgu.16.2018.07.02.15.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 15:33:34 -0700 (PDT)
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
Subject: [PATCH 1/6] perf tools: Use ioctl to communicate driver configuration to kernel
Date:   Mon,  2 Jul 2018 16:33:25 -0600
Message-Id: <1530570810-28929-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following in the footsteps of what was done for filters, adding the
necessary mechanic needed to push down driver specific configuration
to the kernel using an ioctl. By proceeding this way PMU specific
configuration can be communicated to each event.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/uapi/linux/perf_event.h       | 1 +
 tools/include/uapi/linux/perf_event.h | 1 +
 tools/perf/util/evsel.c               | 7 +++++++
 tools/perf/util/evsel.h               | 1 +
 4 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b8e288a1f740..b5b3241877df 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -460,6 +460,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..b5b3241877df 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -460,6 +460,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
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

