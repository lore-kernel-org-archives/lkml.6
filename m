Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6717AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3AD240A7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gI1CBvT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3AD240A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbeGEWN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:13:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44349 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeGEWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:13:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id j3-v6so6570312pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+RIY2UuP5aJSr2EjMCmde75UASQQURVa37fsARUKY8=;
        b=gI1CBvT0BGibui7weucnBH3LCNGfiFEjOcmvqibEyCvMl054ZdQ2jCwPU/yu/2WJZc
         FkiB0FAfNtJC+uDKXMgMewYa20cNphm0HasaoZWNHabHHW+ZtOygyNGptShiaiO1AtWU
         YU5EwYNMBNv4BlYiIPHcoi2v5deJ3VoGN/I9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+RIY2UuP5aJSr2EjMCmde75UASQQURVa37fsARUKY8=;
        b=HJWrEKz+x0IXzfecCowWUtkjKRY+JOd76AAYn6/wM0Cq8+jMPxBAV6TkGEU6hDAvVf
         cijMykXIx9yCO+mwSjpz/nCkvn2n43irTGR5hQmH1PuAM7mZYdwGDlhi8YNmcNoFGx2d
         OoYKQtRT+eGUbsacncQpvIGE+oQ/tvX4WSawUiEb3J05qKNKcORQoJbtcTKI78e4/BSI
         3x1ieDOhWOg/9ZCgGufxz94zrIApaibPtS/ptcxeDL0Jvo14BgFO5LKTsu2xGURBcYdn
         occtdccdcq6tsn8+52TlSSOWcsMfn8CGKp4/of7LGv4NVIxb0cJy7KrHskASuNr2yn+U
         XTYw==
X-Gm-Message-State: APt69E04mBbkQ1Ui9MZeWvMqdyoXWnldOaOvu56mzh0evNEiN+M31oM/
        Kdt42bd18xIgZxiEEwzJ9LgS1oioQ5o=
X-Google-Smtp-Source: AAOMgpcdaWNwdj1rvnsW/e60XBVDyFSsjDU+QtAL+sXPqUhKB/ZPzX52DB89U8YzfEE4c7DSEmEb7g==
X-Received: by 2002:a63:82c7:: with SMTP id w190-v6mr7128829pgd.253.1530828832914;
        Thu, 05 Jul 2018 15:13:52 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r89-v6sm13297486pfa.75.2018.07.05.15.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 15:13:52 -0700 (PDT)
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
Subject: [PATCH v2 1/7] perf: Introduce ioctl to communicate driver configuration to kernel
Date:   Thu,  5 Jul 2018 16:13:41 -0600
Message-Id: <1530828827-11604-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
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

