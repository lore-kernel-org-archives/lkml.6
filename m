Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4685FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D72089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA2sXKD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6D72089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeKIHeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbeKIHdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390D420892;
        Thu,  8 Nov 2018 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714187;
        bh=TDwxN8a2Cl6OVpmax91PTFxvW7LqOwHe/+wxo65Qi+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oA2sXKD1tzir9owIOa7Y0NJ6pd3zZCnU/PPvf93a5scq3upIeRh62JvgSGRdUeAst
         owLdgjyia4qb1yHI98isBKY0a+MBcJOz+p5nFJq4X+2xIuqGEnWm/2N9KyB+y6Qxrs
         A4Qy4mJ27hexynhUqEUWWwBtXp6VZaKR4NvjT5rk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Subject: [PATCH 3.18 112/144] perf: Fix PERF_EVENT_IOC_PERIOD deadlock
Date:   Thu,  8 Nov 2018 13:51:23 -0800
Message-Id: <20181108215105.986230598@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -3929,7 +3929,14 @@ retry:
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



