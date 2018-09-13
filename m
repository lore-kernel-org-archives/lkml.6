Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A8CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C833720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C833720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeIMTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbeIMTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29149D19;
        Thu, 13 Sep 2018 13:53:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 050/197] workqueue: re-add lockdep dependencies for flushing
Date:   Thu, 13 Sep 2018 15:29:59 +0200
Message-Id: <20180913131843.539392943@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 87915adc3f0acdf03c776df42e308e5a155c19af ]

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
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2652,6 +2652,9 @@ void flush_workqueue(struct workqueue_st
 	if (WARN_ON(!wq_online))
 		return;
 
+	lock_map_acquire(&wq->lockdep_map);
+	lock_map_release(&wq->lockdep_map);
+
 	mutex_lock(&wq->mutex);
 
 	/*
@@ -2905,6 +2908,11 @@ static bool __flush_work(struct work_str
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


