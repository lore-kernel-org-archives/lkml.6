Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2CD2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2CD2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHUP6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:58:48 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59886 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeHUP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:58:47 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fs5Nd-00017c-7M; Tue, 21 Aug 2018 14:03:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] workqueue: create lockdep dependency in flush_work()
Date:   Tue, 21 Aug 2018 14:03:17 +0200
Message-Id: <20180821120317.4115-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180821120317.4115-1-johannes@sipsolutions.net>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/workqueue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a6c2b823f348..29d4d84ba512 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2852,6 +2852,11 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 
 	might_sleep();
 
+	if (!from_cancel) {
+		lock_map_acquire(&work->lockdep_map);
+		lock_map_release(&work->lockdep_map);
+	}
+
 	local_irq_disable();
 	pool = get_work_pool(work);
 	if (!pool) {
-- 
2.14.4

