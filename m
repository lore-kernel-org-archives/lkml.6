Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FE9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851D9214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUvOrxtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeLQRV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:21:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38547 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbeLQRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:21:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so6427518pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m66nW8iS1E+go7FhvR8iwCr/rCMmVZB6DxxcxVV5OJA=;
        b=jUvOrxtHlUgY/BFT4v3ZK6gRAks785QtJRvw46Ep6IRQVOgDtruq4cxZlhLqUy+z1T
         PMFlT99Q/QaWBntvS9KUjESXmSD26TxOwa91kqwylbOHv2NZUuW19Pg2YICcEl5lSy9f
         8pcK3qsHFRwG7jQRlZjsinIo2nFdnH1gvNWg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m66nW8iS1E+go7FhvR8iwCr/rCMmVZB6DxxcxVV5OJA=;
        b=MLJROg8fbqp4GbfacShWvNWYgBVED0QzOz/EiKlPax5pdkv4olfRhU2jTPHVupJbuH
         Wv3KhQSM5WCyYgBrsCpFYs4Cso84KRqC1dWi9bbBePdftcWN4uYYhHROUMmd6T3FHtZg
         v1akBBwRL3narj3Yz4n5Wn1DkGCopNSFIGtP/FqW8w2tllEv3Fo8FdXfNqgp0e03h0Gj
         KkHFhGcYMzXXSzOu6qIxV7w/+w29Syz7xfUuTvJNQXyz/xLMpS+4wEZpvx8ZWHuAlaQo
         awFK9yQN9fn80YR3sNncbXuXnrK6x0b7U51Rzrd4jeY7EQDLEtTNf6UUL8rDEXHuIwXN
         CFyA==
X-Gm-Message-State: AA+aEWYK6WOBv9AD0HmgbOB515lbFlwqiI0acBGyw8hz8GIDI9rZD6Y9
        0JDE7Ep4evW9QnMg0bP3G5BU0g==
X-Google-Smtp-Source: AFSGD/X4rNaJfW/npRwt3TGxmZ3I0y9o/KLYnds1Guaz3YDiztq3DWEHWqEZf+h5mHTczt2NcjK3Ew==
X-Received: by 2002:a62:7086:: with SMTP id l128mr13520574pfc.68.1545067311075;
        Mon, 17 Dec 2018 09:21:51 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 09:21:50 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 1/6] perf: Introduce ioctl to communicate driver configuration to kernel
Date:   Mon, 17 Dec 2018 10:21:41 -0700
Message-Id: <1545067306-31687-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
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
index 9de8780ac8d9..a39d8dc2e7a9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -462,6 +462,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9de8780ac8d9..a39d8dc2e7a9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -462,6 +462,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, __u64 *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
-- 
2.7.4

