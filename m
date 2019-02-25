Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0951BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0412186A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131733;
	bh=Z9tJqofuKDKhLPzvnLMixvqbLr6QUC74mp6qrC9/120=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeqb2FZ9e8/aibqVCVwp1FgK47NxA3JPf8U61U6/Qkwv8dmEF5Dq+ZJIHZIncybQR
	 9XepQsTfJfnfK89NAlqzWXQDZiDsFXFtYmbYfF8Eqf5CwZ8afclw4gaAdebflSk0pb
	 QHczMaXmlV+nOs0Xk7BJqVh7W4aRQsKAl1mHka9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfBYVzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfBYVVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:45 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3AB21848;
        Mon, 25 Feb 2019 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129704;
        bh=Z9tJqofuKDKhLPzvnLMixvqbLr6QUC74mp6qrC9/120=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWJYZNuV037gQNCN+iWGQn7MLhxkhRNYa7gZSY59jslTKGa9Xbjj4piyKDud33zwz
         lz3Y0+JY5//qB9boZ+FL4BIsTG9Shp8oNASTIr7EwJ2XVzjEQDnlMYP+SAT4DVqKjM
         OLzIvk2rZXuAnfBu45B7xGL/EEXcyVJc+C6TyEpw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mansour Alharthi <malharthi9@gatech.edu>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/37] perf: Copy parent's address filter offsets on clone
Date:   Mon, 25 Feb 2019 18:20:13 -0300
Message-Id: <20190225212035.24781-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

When a child event is allocated in the inherit_event() path, the VMA
based filter offsets are not copied from the parent, even though the
address space mapping of the new task remains the same, which leads to
no trace for the new task until exec.

Reported-by: Mansour Alharthi <malharthi9@gatech.edu>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Link: http://lkml.kernel.org/r/20190215115655.63469-2-alexander.shishkin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5aeb4c74fb99..2d89efc0a3e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1255,6 +1255,7 @@ static void put_ctx(struct perf_event_context *ctx)
  *	      perf_event_context::lock
  *	    perf_event::mmap_mutex
  *	    mmap_sem
+ *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
  *      pmus_lock
@@ -10312,6 +10313,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 			goto err_per_task;
 		}
 
+		/*
+		 * Clone the parent's vma offsets: they are valid until exec()
+		 * even if the mm is not shared with the parent.
+		 */
+		if (event->parent) {
+			struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
+
+			raw_spin_lock_irq(&ifh->lock);
+			memcpy(event->addr_filters_offs,
+			       event->parent->addr_filters_offs,
+			       pmu->nr_addr_filters * sizeof(unsigned long));
+			raw_spin_unlock_irq(&ifh->lock);
+		}
+
 		/* force hw sync on the address filters */
 		event->addr_filters_gen = 1;
 	}
-- 
2.20.1

