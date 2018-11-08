Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C13CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4206620844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOxYTDAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeKIHoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731993AbeKIHoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:15 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F031621019;
        Thu,  8 Nov 2018 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714804;
        bh=RNv5JV/WI/SNEVhg9NAOt0tkoxVGOkXQw4AvHeL0Zp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOxYTDAzsJhM5FpSzEEv7qC1EdON5Wpy3s1S+SJ26fljTw1dZhajgzdiQuCTCAxSG
         CeUrZA8ChGqEGbsmEAbT6njO/g8H8NuYOAUV7us5KMp1VGdIj2yuIDve6c++cST/zd
         tKcP1tVVGswbalTPOS4RVkOVjvA37SvhI2R76F4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 109/171] perf/core: Fix locking for children siblings group read
Date:   Thu,  8 Nov 2018 13:51:19 -0800
Message-Id: <20181108215135.236783346@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



