Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B507ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8942075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+vKzZpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8942075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeGRW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:28:05 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55107 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbeGRW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:28:04 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so6291021itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+RIY2UuP5aJSr2EjMCmde75UASQQURVa37fsARUKY8=;
        b=U+vKzZpJlQlYHPJlmfZfZONwUe7bQOIGrdw+YxEVhLk1t8p0L9wNAH+GYzJQSPiTZ3
         P1y+buF7Kh/q+IeOQXRpGOONg2UjxUNJugY+uPB7utMV3/fdi+qjAa9ZEguVhKTvDOK/
         eTk4ljhFqoC/3YyZaDKXyJd8SnWXhnVNI78M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+RIY2UuP5aJSr2EjMCmde75UASQQURVa37fsARUKY8=;
        b=PrilneLj8aQ4dmaFQevzBebCCzpsc+GkLKiRD1ZwC+roQhGvEcETGN65BUhT7Udvxc
         wJv5Wm5lSkEas64kWyClum4DOUw4qkaPL3Rty0MxdX+Z1nHRACKd+tYGOVq3T9XwX3AB
         LUSVuCYMMODhTBo6VltRQlMWmF/E2mq3VSZMdQhuwRm/QZ8shjvDxLTbJfpZz07FfCP2
         B4CwhFIR4WtYUpg1UF4jVwdmnUAVvGH1jkjlfXjDViVzcFOYNWgPtXcDr0ImxpsIEA4v
         YhDdWZrtXtbE/EzHEFRyTn+MRu9uBaPrL37hh2oK0n2JQSnZ2JvKCtXeIi3LkEOAsQzf
         xlHA==
X-Gm-Message-State: AOUpUlFRUo44LhGGc5Bjpk9lh1WUOUL+w19lqX5G66Vls29gzgkUfk67
        gXUCv0V1v+j36/4TZmkl7SJGgQ==
X-Google-Smtp-Source: AAOMgpdTDaYTcnGy19Lvc0ntxWekh+mLOsk2nBBrZQZLokJr/5/E/Z8RRg1G0oPZoYB6ADeZH4p/rw==
X-Received: by 2002:a02:105:: with SMTP id c5-v6mr6941852jad.139.1531950493405;
        Wed, 18 Jul 2018 14:48:13 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2093386ita.35.2018.07.18.14.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 14:48:12 -0700 (PDT)
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
Subject: [PATCH v3 1/7] perf: Introduce ioctl to communicate driver configuration to kernel
Date:   Wed, 18 Jul 2018 15:48:01 -0600
Message-Id: <1531950487-24554-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a new IOCTL command to communicate PMU specific configuration to
PMU kernel drivers.  This can be anything a PMU might need for
configuration that doesn't fit in the perf_event_attr structure, such
as the CoreSight sink to use for a session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/uapi/linux/perf_event.h       | 1 +
 tools/include/uapi/linux/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

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
-- 
2.7.4

