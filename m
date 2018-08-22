Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D79C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27735214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27735214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeHVNNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:13:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53994 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeHVNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:13:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fsPlJ-0007Qa-Po; Wed, 22 Aug 2018 11:49:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Byungchul Park <byungchul.park@lge.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/2] workqueue: re-add lockdep dependencies for flushing
Date:   Wed, 22 Aug 2018 11:49:04 +0200
Message-Id: <20180822094904.15718-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180822094904.15718-1-johannes@sipsolutions.net>
References: <20180822094904.15718-1-johannes@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In flush_work(), we need to create a lockdep dependency so that
the following scenario is appropriately tagged as a problem:

  work_function()
  {
    mutex_lock(&mutex);
    ...
  }

  other_function()
  {
    mutex_lock(&mutex);
    flush_work(&work); // or cancel_work_sync(&work);
  }

This is a problem since the work might be running and be blocked
on trying to acquire the mutex.

Similarly, in flush_workqueue().

These were removed after cross-release partially caught these
problems, but now cross-release was reverted anyway. IMHO the
removal was erroneous anyway though, since lockdep should be
able to catch potential problems, not just actual ones, and
cross-release would only have caught the problem when actually
invoking wait_for_completion().

Fixes: fd1a5b04dfb8 ("workqueue: Remove now redundant lock acquisitions wrt. workqueue flushes")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/workqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a6c2b823f348..60e80198c3df 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2652,6 +2652,9 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
+	lock_map_acquire(&wq->lockdep_map);
+	lock_map_release(&wq->lockdep_map);
+
 	mutex_lock(&wq->mutex);
 
 	/*
@@ -2905,6 +2908,11 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
+	if (!from_cancel) {
+		lock_map_acquire(&work->lockdep_map);
+		lock_map_release(&work->lockdep_map);
+	}
+
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
-- 
2.14.4

