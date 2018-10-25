Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9551C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB5B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdzJNWno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB5B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeJYWtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbeJYWtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:20 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBB121479;
        Thu, 25 Oct 2018 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476983;
        bh=e+ZiUDZJrBdgPJQ5sjPTNLBtQLzmGLahdZguLaJpF+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdzJNWno2ZrPpG1BKMUNpTdzOEYQ1zVWb1Ccit9UGzwgGSmcdwZQ9fvDGM51AKidU
         w5SBsBnusKSjRPV1+SDAtDRVG7XITUsPhI1E7kqNNsZ7cewagGCdBmMmNx+x1TjBMp
         pJEw1tD2/eGveSZO6SwHJYgW/jHzy/T68KVLMEJw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 81/98] perf/core: Fix locking for children siblings group read
Date:   Thu, 25 Oct 2018 10:14:06 -0400
Message-Id: <20181025141423.213774-81-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 2aeb1883547626d82c597cce2c99f0b9c62e2425 ]

We're missing ctx lock when iterating children siblings
within the perf_read path for group reading. Following
race and crash can happen:

User space doing read syscall on event group leader:

T1:
  perf_read
    lock event->ctx->mutex
    perf_read_group
      lock leader->child_mutex
      __perf_read_group_add(child)
        list_for_each_entry(sub, &leader->sibling_list, group_entry)

---->   sub might be invalid at this point, because it could
        get removed via perf_event_exit_task_context in T2

Child exiting and cleaning up its events:

T2:
  perf_event_exit_task_context
    lock ctx->mutex
    list_for_each_entry_safe(child_event, next, &child_ctx->event_list,...
      perf_event_exit_event(child)
        lock ctx->lock
        perf_group_detach(child)
        unlock ctx->lock

---->   child is removed from sibling_list without any sync
        with T1 path above

        ...
        free_event(child)

Before the child is removed from the leader's child_list,
(and thus is omitted from perf_read_group processing), we
need to ensure that perf_read_group touches child's
siblings under its ctx->lock.

Peter further notes:

| One additional note; this bug got exposed by commit:
|
|   ba5213ae6b88 ("perf/core: Correct event creation with PERF_FORMAT_GROUP")
|
| which made it possible to actually trigger this code-path.

Tested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: ba5213ae6b88 ("perf/core: Correct event creation with PERF_FORMAT_GROUP")
Link: http://lkml.kernel.org/r/20170720141455.2106-1-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95bd00d9f2c3..06b359af4322 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4331,7 +4331,9 @@ EXPORT_SYMBOL_GPL(perf_event_read_value);
 static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
+	struct perf_event_context *ctx = leader->ctx;
 	struct perf_event *sub;
+	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
 
@@ -4361,12 +4363,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 	}
 
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	return 0;
 }
 
-- 
2.17.1

