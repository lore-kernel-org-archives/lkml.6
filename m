Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E59ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C3120883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftXH+y9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C3120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeJYWyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbeJYWyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:00 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85AFA20870;
        Thu, 25 Oct 2018 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477263;
        bh=V5XLa/ujWXTx9o5wX86QaxiVenlJpKNxuOvxoCJ3Dvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftXH+y9EKnwAYrlkNjCC0isLG83Y5+Zw4Joq0ePr3WligGlYWt1pTIgdBJwJ15O5g
         SEFtB5+TDFK7aSw09p9lEWuyw4BeUnhXNtFH3ZHCDrICK2xAjl3YExMwcJKco6UnQC
         PjLtYKVZMJH9amJc3NMToGRAhNIJtdSbtHuchLcU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kostya Serebryany <kcc@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 84/98] perf: Fix PERF_EVENT_IOC_PERIOD deadlock
Date:   Thu, 25 Oct 2018 10:18:39 -0400
Message-Id: <20181025141853.214051-84-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 642c2d671ceff40e9453203ea0c66e991e11e249 ]

Dmitry reported a fairly silly recursive lock deadlock for
PERF_EVENT_IOC_PERIOD, fix this by explicitly doing the inactive part of
__perf_event_period() instead of calling that function.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: c7999c6f3fed ("perf: Fix PERF_EVENT_IOC_PERIOD migration race")
Link: http://lkml.kernel.org/r/20151130115615.GJ17308@twins.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f08f691de59..7b2f9d432fe7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3929,7 +3929,14 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 		goto retry;
 	}
 
-	__perf_event_period(&pe);
+	if (event->attr.freq) {
+		event->attr.sample_freq = value;
+	} else {
+		event->attr.sample_period = value;
+		event->hw.sample_period = value;
+	}
+
+	local64_set(&event->hw.period_left, 0);
 	raw_spin_unlock_irq(&ctx->lock);
 
 	return 0;
-- 
2.17.1

