Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E102089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865865;
	bh=VkMYntYTOd4VGU0J0UTPz5xZ5jzskDT3mOGG4ysvDHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5DZkhwgxczxLJcW36knX1dq01eSuooOgGc8cvasGyMstXVE1LsS1xXUSt3Z91pUR
	 i8TWgGt6UJcED4HXiXsQsW5PoW1hMs0WAwj8WArPeRrF7rHPH3r5yQVme4bjbef8Qs
	 QTRTCZ7OaCBiiHBPruQ2QY1UWOVYZZ64BOISdiVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfAGM5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfAGM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1B32089F;
        Mon,  7 Jan 2019 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865859;
        bh=VkMYntYTOd4VGU0J0UTPz5xZ5jzskDT3mOGG4ysvDHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4C9/yix/n1BJQOBT6atGpLk74i6xlUVHWpw7Xqsanw8mrlQfLW4aM6rnh3KivwVY
         27JIX/wbsIUK3lEFFuNq8t9k2YngaNlhvAruDxyXj+u2Yy8fNz0kAhTorXGV8rIRxl
         WQg09ex3lGoCpAKxuFakqkxHOKZQqW03ST1EOUcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 137/170] dax: Use non-exclusive wait in wait_entry_unlocked()
Date:   Mon,  7 Jan 2019 13:32:44 +0100
Message-Id: <20190107104509.142464251@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit d8a706414af4827fc0b4b1c0c631c607351938b9 upstream.

get_unlocked_entry() uses an exclusive wait because it is guaranteed to
eventually obtain the lock and follow on with an unlock+wakeup cycle.
The wait_entry_unlocked() path does not have the same guarantee. Rather
than open-code an extra wakeup, just switch to a non-exclusive wait.

Cc: Matthew Wilcox <willy@infradead.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 415605fafaeb..09fa70683c41 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -275,18 +275,16 @@ static void wait_entry_unlocked(struct address_space *mapping, pgoff_t index,
 	ewait.wait.func = wake_exceptional_entry_func;
 
 	wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
-	prepare_to_wait_exclusive(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
+	/*
+	 * Unlike get_unlocked_entry() there is no guarantee that this
+	 * path ever successfully retrieves an unlocked entry before an
+	 * inode dies. Perform a non-exclusive wait in case this path
+	 * never successfully performs its own wake up.
+	 */
+	prepare_to_wait(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
 	xa_unlock_irq(&mapping->i_pages);
 	schedule();
 	finish_wait(wq, &ewait.wait);
-
-	/*
-	 * Entry lock waits are exclusive. Wake up the next waiter since
-	 * we aren't sure we will acquire the entry lock and thus wake
-	 * the next waiter up on unlock.
-	 */
-	if (waitqueue_active(wq))
-		__wake_up(wq, TASK_NORMAL, 1, &ewait.key);
 }
 
 static void unlock_mapping_entry(struct address_space *mapping, pgoff_t index)
-- 
2.19.1



