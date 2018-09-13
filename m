Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F75C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A810B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A810B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeIMSHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbeIMSE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 837CB3697D;
        Thu, 13 Sep 2018 12:55:36 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B840600C6;
        Thu, 13 Sep 2018 12:55:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 19/48] perf tools: Add thread::exited flag
Date:   Thu, 13 Sep 2018 14:54:21 +0200
Message-Id: <20180913125450.21342-20-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 13 Sep 2018 12:55:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding thread::exited to indicate the thread has exited,
and keeping the thread::dead flag to indicate thread
is on the dead list.

Link: http://lkml.kernel.org/n/tip-iak1784r9z2vhcnw6getmbdk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 3 +++
 tools/perf/util/thread.h  | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 999f200f24e7..5ae2baba27ca 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1828,6 +1828,9 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	rb_erase_init(&th->rb_node, &threads->entries);
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
+
+	th->dead = true;
+
 	/*
 	 * No need to have an additional reference for non-index file
 	 * as they can be released when reference holders died and
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index e8f779e83347..8a1114c2f43a 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -26,7 +26,8 @@ struct thread {
 	refcount_t		refcnt;
 	bool			comm_set;
 	int			comm_len;
-	bool			dead; /* if set thread has exited */
+	bool			exited;	/* if set thread has exited */
+	bool			dead;	/* if set thread is in dead tree */
 	struct list_head	namespaces_list;
 	struct rw_semaphore	namespaces_lock;
 	struct list_head	comm_list;
@@ -64,7 +65,7 @@ static inline void __thread__zput(struct thread **thread)
 
 static inline void thread__exited(struct thread *thread)
 {
-	thread->dead = true;
+	thread->exited = true;
 }
 
 struct namespaces *thread__namespaces(const struct thread *thread);
-- 
2.17.1

