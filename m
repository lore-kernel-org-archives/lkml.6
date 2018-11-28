Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED111C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31E320863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqXuzvI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31E320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeK2JE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:04:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34385 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2JE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:04:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so10109608pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eueZ6W2njB74JvX/8hNBYwCtCguZgj9QXyJ/Slfihak=;
        b=IqXuzvI8sZmoSzDTRIroeYklOjkcok3XwjvmzBpMLij3wxHT3C8rlZx3taYzRctJvA
         RlVvxw5cmlLiYERph2+vXCyd1VH2ymbssjgiwRzuCOlQMsLo/A02Ey5ajzFE5Kw1eEZe
         JpmIed5MQ13g1k6EbXX1/U11Pb71l3goGBy4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eueZ6W2njB74JvX/8hNBYwCtCguZgj9QXyJ/Slfihak=;
        b=m862NNFJbtJenCLhOMF5N1c+bCmZBIi9dPlLalRDdcHSk2YkOAXHSOWiZnIYe62yUP
         jKbhM298uWAVQtkHRQtdQpXsbOqJZEu1lFexy7bw6lEsCxEnr/46wBt2vCvmYoYY+o6e
         LCtzRO/PBi/o1HEjKz2eZ9dG2HWkm4HVfNuyh126d281leWsRRhAjPFyIGyp38JD/IPg
         n5z9SVkHLMEHhZI0KCP4cL/mt5qX+U3DPUrYIQSuX02hfxAgUPnT0oFM2SbCbwNZlMoF
         g/E/tVgxzGi1+3GyGp+wGsnJNfByx0zEbJcbwh+AK0TrMWG/GFL1DFcygyH9GZvDh/+n
         TTuQ==
X-Gm-Message-State: AA+aEWZm+GJ/VNcMHbxAFRJ6iklk0Bvl41JtqG9654xJhDPVjaVOHq3K
        pwqe4uvaL5vVJY41Z/7DLpmgsw==
X-Google-Smtp-Source: AFSGD/VnF+Koox+jTKg7BiF0OedimZ7VaGXUSUkkQ/2PVKM5eNFqMPdTsT8Ym5LUO182rDDnRVIwTw==
X-Received: by 2002:a63:8c2:: with SMTP id 185mr35273310pgi.26.1543442482168;
        Wed, 28 Nov 2018 14:01:22 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 12sm8698051pgd.35.2018.11.28.14.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:01:21 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/6] perf: Introduce ioctl to communicate driver configuration to kernel
Date:   Wed, 28 Nov 2018 15:01:13 -0700
Message-Id: <1543442478-31465-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
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
index 9de8780ac8d9..bb558caeb33b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -462,6 +462,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9de8780ac8d9..bb558caeb33b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -462,6 +462,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
-- 
2.7.4

