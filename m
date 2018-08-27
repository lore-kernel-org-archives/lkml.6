Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F12C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F0208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853F0208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH0Rhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:37:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36807 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeH0Rhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:37:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so7827524edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vhcm/rGk2kZtLi1XQPv8v7NPVrD8UYtwAM0OUX8x8w4=;
        b=q077YzcBTOjKuhC/bSJNboyCGYca6HYtsJXbSf0AB3oLqP9bmCQ7xiwHhCxGkQgQ5i
         Sw0od36XTDYzZTC/SLl/QXwXB7FCuav+98EleddQgigcyAW6AWVT59egZ0M9oRCO4dIC
         v8oFzfkfnRZtO0zPew0e1+PfiTjP0MYeW44/EbZ2b9gaHyRQSOMKjJ6//dseFxr80yWu
         xtr0OhG/cPZqK8yBrWN0b5KNPV6e0mLvjz760C6mJ3hmwGKVYCM1rXHvSsRqxmHffTqE
         NPZvXBa5erOhz4r2OQinhLXEoawA31/1icxQpiSxQN3Lkzlt9ABaMJ9gCViwqL/tzWBt
         DqtA==
X-Gm-Message-State: APzg51BPJ+mGhfEvuqL9frlN+sZJ+68QIOsSxQNnC1S1RaINme8yPnVj
        Ec8C8zeATL1ySgC1omAo5HI=
X-Google-Smtp-Source: ANB0Vdan5xWGnt2bbdmWlQhFraHHQfEHG5Yo3KKOnWPYdZd2es01DoIQXVUfBiaYCUzeL05Jcwp7ow==
X-Received: by 2002:a50:afa3:: with SMTP id h32-v6mr16871540edd.129.1535377867812;
        Mon, 27 Aug 2018 06:51:07 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c50-v6sm7851280ede.53.2018.08.27.06.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 06:51:06 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at should_reclaim_retry().
Date:   Mon, 27 Aug 2018 15:51:01 +0200
Message-Id: <20180827135101.15700-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Tetsuo Handa has reported that it is possible to bypass the short sleep
for PF_WQ_WORKER threads which was introduced by commit 373ccbe5927034b5
("mm, vmstat: allow WQ concurrency to discover memory reclaim doesn't make
any progress") and lock up the system if OOM.

The primary reason is that WQ_MEM_RECLAIM WQs are not guaranteed to
run even when they have a rescuer available. Those workers might be
essential for reclaim to make a forward progress, however. If we are
too unlucky all the allocations requests can get stuck waiting for a
WQ_MEM_RECLAIM work item and the system is essentially stuck in an OOM
condition without much hope to move on. Tetsuo has seen the reclaim
stuck on drain_local_pages_wq or xlog_cil_push_work (xfs). There might
be others.

Since should_reclaim_retry() should be a natural reschedule point,
let's do the short sleep for PF_WQ_WORKER threads unconditionally in
order to guarantee that other pending work items are started. This will
workaround this problem and it is less fragile than hunting down when
the sleep is missed. E.g. we used to have a sleeping point in the oom
path but this has been removed recently because it caused other issues.
Having a single sleeping point is more robust.

Reported-and-debugged-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Tejun Heo <tj@kernel.org>
---

Hi Andrew,
this has been previously posted [1] but it took quite some time to
finally understand the issue [2]. Can we push this to mmotm and
linux-next? I wouldn't hurry to merge this but the longer we have a
wider testing exposure the better.

Thanks!

[1] http://lkml.kernel.org/r/ca3da8b8-1bb5-c302-b190-fa6cebab58ca@I-love.SAKURA.ne.jp
[2] http://lkml.kernel.org/r/20180730145425.GE1206094@devbig004.ftw2.facebook.com

 mm/page_alloc.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e75865d58ba7..5fc5e500b5d0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3923,6 +3923,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 {
 	struct zone *zone;
 	struct zoneref *z;
+	bool ret = false;
 
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
@@ -3986,25 +3987,26 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 				}
 			}
 
-			/*
-			 * Memory allocation/reclaim might be called from a WQ
-			 * context and the current implementation of the WQ
-			 * concurrency control doesn't recognize that
-			 * a particular WQ is congested if the worker thread is
-			 * looping without ever sleeping. Therefore we have to
-			 * do a short sleep here rather than calling
-			 * cond_resched().
-			 */
-			if (current->flags & PF_WQ_WORKER)
-				schedule_timeout_uninterruptible(1);
-			else
-				cond_resched();
-
-			return true;
+			ret = true;
+			goto out;
 		}
 	}
 
-	return false;
+out:
+	/*
+	 * Memory allocation/reclaim might be called from a WQ
+	 * context and the current implementation of the WQ
+	 * concurrency control doesn't recognize that
+	 * a particular WQ is congested if the worker thread is
+	 * looping without ever sleeping. Therefore we have to
+	 * do a short sleep here rather than calling
+	 * cond_resched().
+	 */
+	if (current->flags & PF_WQ_WORKER)
+		schedule_timeout_uninterruptible(1);
+	else
+		cond_resched();
+	return ret;
 }
 
 static inline bool
-- 
2.18.0

