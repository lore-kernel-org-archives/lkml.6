Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E74420833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E74420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIJO6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:58:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeIJO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:58:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA52RF1806609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:05:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA52rh1806606;
        Mon, 10 Sep 2018 03:05:02 -0700
Date:   Mon, 10 Sep 2018 03:05:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Hellstrom <tipbot@zytor.com>
Message-ID: <tip-e13e2366d8415e029fe96a62502955083e272cef@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, thellstrom@vmware.com, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, thellstrom@vmware.com
In-Reply-To: <20180903140708.2401-1-thellstrom@vmware.com>
References: <20180903140708.2401-1-thellstrom@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/mutex: Fix mutex debug call and ww_mutex
 documentation
Git-Commit-ID: e13e2366d8415e029fe96a62502955083e272cef
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e13e2366d8415e029fe96a62502955083e272cef
Gitweb:     https://git.kernel.org/tip/e13e2366d8415e029fe96a62502955083e272cef
Author:     Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate: Mon, 3 Sep 2018 16:07:08 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:05:10 +0200

locking/mutex: Fix mutex debug call and ww_mutex documentation

The following commit:

  08295b3b5bee ("Implement an algorithm choice for Wound-Wait mutexes")

introduced a reference in the documentation to a function that was
removed in an earlier commit.

It also forgot to remove a call to debug_mutex_add_waiter() which is now
unconditionally called by __mutex_add_waiter().

Fix those bugs.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dri-devel@lists.freedesktop.org
Fixes: 08295b3b5bee ("Implement an algorithm choice for Wound-Wait mutexes")
Link: http://lkml.kernel.org/r/20180903140708.2401-1-thellstrom@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/mutex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 1a81a1257b3f..3f8a35104285 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -389,7 +389,7 @@ static bool __ww_mutex_wound(struct mutex *lock,
 		/*
 		 * wake_up_process() paired with set_current_state()
 		 * inserts sufficient barriers to make sure @owner either sees
-		 * it's wounded in __ww_mutex_lock_check_stamp() or has a
+		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
@@ -946,7 +946,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	debug_mutex_lock_common(lock, &waiter);
-	debug_mutex_add_waiter(lock, &waiter, current);
 
 	lock_contended(&lock->dep_map, ip);
 
