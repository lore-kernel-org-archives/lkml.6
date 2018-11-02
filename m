Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51545C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1720847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwUuVmv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A1720847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeKCD7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKCD7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:43 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94AE20848;
        Fri,  2 Nov 2018 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184689;
        bh=ANOuYbqUfzxiNxAHhYAsXFhyeMNJeWmOjTuXwy5dGqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwUuVmv0bSFZmLoFaN5Vby/foNfK1lV/iOJQvKd+sXubPmQS5dFid8If0pKFYLutF
         fMMIJ8OJh85HGJjxumoC4tjMFUz+GJF7N5He1eH82L9/FaUjxETe7rUI4SrhZ57zG0
         qAB27cLAUlgKvcv+/95yDJaF4WQtt7HPyNF3A7l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 038/143] perf/core: Fix perf_pmu_unregister() locking
Date:   Fri,  2 Nov 2018 19:33:43 +0100
Message-Id: <20181102182900.119831565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a9f9772114c8b07ae75bcb3654bd017461248095 ]

When we unregister a PMU, we fail to serialize the @pmu_idr properly.
Fix that by doing the entire thing under pmu_lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 2e80a82a49c4 ("perf: Dynamic pmu types")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4dbce29a9313..ee1c07c0b833 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9020,9 +9020,7 @@ static void free_pmu_context(struct pmu *pmu)
 	if (pmu->task_ctx_nr > perf_invalid_context)
 		return;
 
-	mutex_lock(&pmus_lock);
 	free_percpu(pmu->pmu_cpu_context);
-	mutex_unlock(&pmus_lock);
 }
 
 /*
@@ -9278,12 +9276,8 @@ EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
-	int remove_device;
-
 	mutex_lock(&pmus_lock);
-	remove_device = pmu_bus_running;
 	list_del_rcu(&pmu->entry);
-	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -9295,13 +9289,14 @@ void perf_pmu_unregister(struct pmu *pmu)
 	free_percpu(pmu->pmu_disable_count);
 	if (pmu->type >= PERF_TYPE_MAX)
 		idr_remove(&pmu_idr, pmu->type);
-	if (remove_device) {
+	if (pmu_bus_running) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
 		device_del(pmu->dev);
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
+	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
-- 
2.17.1



