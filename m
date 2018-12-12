Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A8820870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A8820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeLLLEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:04:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbeLLLEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:04:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66335AEFC;
        Wed, 12 Dec 2018 11:04:31 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] epoll: loosen irq safety in ep_poll_callback()
Date:   Wed, 12 Dec 2018 12:03:56 +0100
Message-Id: <20181212110357.25656-3-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212110357.25656-1-rpenyaev@suse.de>
References: <20181212110357.25656-1-rpenyaev@suse.de>
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
 fs/eventpoll.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3627c2e07149..ea0025e77519 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1124,13 +1124,15 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 {
 	int pwake = 0;
-	unsigned long flags;
 	struct epitem *epi = ep_item_from_wait(wait);
 	struct eventpoll *ep = epi->ep;
 	__poll_t pollflags = key_to_poll(key);
 	int ewake = 0;
 
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	/* Interrupts are disabled by the wake_up_*poll() callers */
+	lockdep_assert_irqs_disabled();
+
+	spin_lock(&ep->wq.lock);
 
 	ep_set_busy_poll_napi_id(epi);
 
@@ -1207,7 +1209,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		pwake++;
 
 out_unlock:
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock(&ep->wq.lock);
 
 	/* We have to call this outside the lock */
 	if (pwake)
-- 
2.19.1

