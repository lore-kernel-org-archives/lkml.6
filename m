Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62EC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4BE21915
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfAET5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:57:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:35408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfAET5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:57:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 11:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,444,1539673200"; 
   d="scan'208";a="124393644"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2019 11:57:49 -0800
Subject: [4.19-stable PATCH 2/2] dax: Use non-exclusive wait in
 wait_entry_unlocked()
From:   Dan Williams <dan.j.williams@intel.com>
To:     stable@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, sashal@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Date:   Sat, 05 Jan 2019 11:45:13 -0800
Message-ID: <154671751331.249397.2911347709356418652.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d8a706414af4827fc0b4b1c0c631c607351938b9 upstream.

get_unlocked_entry() uses an exclusive wait because it is guaranteed to
eventually obtain the lock and follow on with an unlock+wakeup cycle.
The wait_entry_unlocked() path does not have the same guarantee. Rather
than open-code an extra wakeup, just switch to a non-exclusive wait.

Cc: Matthew Wilcox <willy@infradead.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   16 +++++++---------
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

