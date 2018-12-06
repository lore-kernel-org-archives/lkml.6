Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B554CC67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D2720989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131930;
	bh=LeeKI04tqtLe4hm6MvdrziIKvuoAgGHW2J8rs/tOGLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C5bWNtg8ZtKNFLWXH7LfSfDhP8OODLp76q4d5F6QICBg1EjWg+sgE46e0BkgDhFQl
	 otfGuFVHAYPysC59tWNrj1c0Dq/NG05u54louAEIJVtjbC3KE4zh9hBeqNTZ0ntgJx
	 +nqBRlSQUogbgSZO8xiFzY3DkuT+pZq92uXENL78=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D2720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLFVbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeLFVbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:31:23 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA552082B;
        Thu,  6 Dec 2018 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131882;
        bh=LeeKI04tqtLe4hm6MvdrziIKvuoAgGHW2J8rs/tOGLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnoPVScYSgTcUaR/RTO7nJM+7nKkyl8wKJqJ/jBA+2b+dJ+HCeJEpI1a/ayMxH76a
         97y5g5Yvy7TrAYEoncMAwXPRe7TvpFIHPDJSUrIDRl/6OtNPUBqcZcfFADbw+rdeO/
         DF+Se8yH3uj1z3w9fIyAGG6xoeZHCYFIyUdT/WNw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dmitry Levin <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 74/75] perf ordered_events: Add first_time() method
Date:   Thu,  6 Dec 2018 18:26:01 -0300
Message-Id: <20181206212602.20474-75-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To get the timestamp in the first event in the queue.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-appp27jw1ul8kgg872j43r5o@git.kernel.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 11 +++++++++++
 tools/perf/util/ordered-events.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 46965643020b..897589507d97 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -343,6 +343,17 @@ int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp)
 	return __ordered_events__flush(oe, OE_FLUSH__TIME, timestamp);
 }
 
+u64 ordered_events__first_time(struct ordered_events *oe)
+{
+	struct ordered_event *event;
+
+	if (list_empty(&oe->events))
+		return 0;
+
+	event = list_first_entry(&oe->events, struct ordered_event, list);
+	return event->timestamp;
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index f352af20e167..0920fb0ec6cc 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -61,6 +61,7 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
 void ordered_events__reinit(struct ordered_events *oe);
+u64 ordered_events__first_time(struct ordered_events *oe);
 
 static inline
 void ordered_events__set_alloc_size(struct ordered_events *oe, u64 size)
-- 
2.19.2

