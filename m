Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335E5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37CE2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfACPBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:01:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:33128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729611AbfACPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB716ADE2;
        Thu,  3 Jan 2019 15:01:12 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] epoll: loosen irq safety in ep_poll_callback()
Date:   Thu,  3 Jan 2019 16:01:02 +0100
Message-Id: <20190103150104.17128-3-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103150104.17128-1-rpenyaev@suse.de>
References: <20190103150104.17128-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of the ep_poll_callback() (all set of wake_up_*poll()) disable
interrupts, so no need to save/restore irq flags.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3627c2e07149..3c373a510f65 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1124,13 +1124,18 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 {
 	int pwake = 0;
-	unsigned long flags;
 	struct epitem *epi = ep_item_from_wait(wait);
 	struct eventpoll *ep = epi->ep;
 	__poll_t pollflags = key_to_poll(key);
 	int ewake = 0;
 
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	/*
+	 * Called by irq context or interrupts are disabled by the wake_up_*poll
+	 * callers.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	spin_lock(&ep->wq.lock);
 
 	ep_set_busy_poll_napi_id(epi);
 
@@ -1207,7 +1212,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		pwake++;
 
 out_unlock:
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock(&ep->wq.lock);
 
 	/* We have to call this outside the lock */
 	if (pwake)
-- 
2.19.1

