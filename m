Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDE1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CB320850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjQUylK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CB320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLCWzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:55:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeLCWzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:55:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so6404634pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m66nW8iS1E+go7FhvR8iwCr/rCMmVZB6DxxcxVV5OJA=;
        b=EjQUylK1BINMhHoByAtjuUYcrcMPz4Z0p6OJ+UuyZ4XGwa+b2BF+8GhR4rNhzouffc
         mxtwzG+5pp32+g9gzo0/5BWnQBltZmNyjF/k4csDBe6E7LE39h4e5Bg9/qk5gXu5+tS5
         WqkbqVCttjr8cVwi7C7sKHvcIng56MShKw1lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m66nW8iS1E+go7FhvR8iwCr/rCMmVZB6DxxcxVV5OJA=;
        b=tAW5W0PY6n+uc1DUPeLoz1ZCBFOfMsdatyrsPH3pRwmm66tRBJNVK0ZVWpeB2915/u
         vBwd+y5dwzr0jC4RCAvJRmVxbIc9IQxYZg7mIa0G6SYgHVhC0COFRjC9Sn/rDTz8wMfN
         xbIY6hbgrK/ngmFSusvNUnxjP8x7KCV9115XBz2ATIJQBmH0Y4hdU5n1RuAxX/zGyELs
         rDzyL0tyjOb5tN1Puwv82YUJAmJMy6ZEfojmTcrV7h5+Ox8mmKHpJlgpX4tW7crhQ9mQ
         ZSgYKsqPofvEvV7rB481NBZhzEFRijVmHExALXOaLboJyWbkJtFXfr7jXpiwGh+ibkYB
         VGGg==
X-Gm-Message-State: AA+aEWYaojlisAO251NS656eS++iNpq7kHyHdFLSI6MJTSR89OEO6HUI
        jvQbtMvPptpGY+wsAfzshm+4UA==
X-Google-Smtp-Source: AFSGD/W2uitOqwtZyRgEp69Oct5X66ejR/jdnhNPOl3ADOFr7Hmb+LFYZdgdxrvfSUultDolEFAudw==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr2608108pgo.369.1543877700608;
        Mon, 03 Dec 2018 14:55:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 14:55:00 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/6] perf: Introduce ioctl to communicate driver configuration to kernel
Date:   Mon,  3 Dec 2018 15:54:51 -0700
Message-Id: <1543877696-17174-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
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

