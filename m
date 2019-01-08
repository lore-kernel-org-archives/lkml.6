Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3134C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0D82087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAHKBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:01:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:58378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfAHKBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:01:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01C31B0DD;
        Tue,  8 Jan 2019 10:01:36 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] epoll: remove wrong assert that ep_poll_callback is always called with irqs off
Date:   Tue,  8 Jan 2019 11:01:21 +0100
Message-Id: <20190108100121.20247-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That was wrong assumption that all drivers disable irqs before waking up
a wait queue.  Even assert line is removed the whole logic stays correct:
epoll always locks rwlock with irqs disabled and by itself does not call
from interrupts, thus it is up to driver how to call wake_up_locked(),
because if driver does not handle any interrupts (like fuse in the the
report) of course it is safe on its side to take a simple spin_lock.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Reported-by: syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f307c8679027..f5f88250cdf2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1217,12 +1217,6 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	__poll_t pollflags = key_to_poll(key);
 	int ewake = 0;
 
-	/*
-	 * Called by irq context or interrupts are disabled by the wake_up_*poll
-	 * callers.
-	 */
-	lockdep_assert_irqs_disabled();
-
 	read_lock(&ep->lock);
 
 	ep_set_busy_poll_napi_id(epi);
-- 
2.19.1

