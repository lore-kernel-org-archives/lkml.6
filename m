Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E3C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250782080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250782080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeKLFyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51780 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728706AbeKLFyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:45 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsw-0000lM-DA; Sun, 11 Nov 2018 19:59:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001eI-RX; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dennis Yang" <dennisyang@qnap.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.770345245@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 207/366] dm thin: handle running out of data space vs
 concurrent discard
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit a685557fbbc3122ed11e8ad3fa63a11ebc5de8c3 upstream.

Discards issued to a DM thin device can complete to userspace (via
fstrim) _before_ the metadata changes associated with the discards is
reflected in the thinp superblock (e.g. free blocks).  As such, if a
user constructs a test that loops repeatedly over these steps, block
allocation can fail due to discards not having completed yet:
1) fill thin device via filesystem file
2) remove file
3) fstrim

=46rominitial report, here:
https://www.redhat.com/archives/dm-devel/2018-April/msg00022.html

"The root cause of this issue is that dm-thin will first remove
mapping and increase corresponding blocks' reference count to prevent
them from being reused before DISCARD bios get processed by the
underlying layers. However. increasing blocks' reference count could
also increase the nr_allocated_this_transaction in struct sm_disk
which makes smd->old_ll.nr_allocated +
smd->nr_allocated_this_transaction bigger than smd->old_ll.nr_blocks.
In this case, alloc_data_block() will never commit metadata to reset
the begin pointer of struct sm_disk, because sm_disk_get_nr_free()
always return an underflow value."

While there is room for improvement to the space-map accounting that
thinp is making use of: the reality is this test is inherently racey and
will result in the previous iteration's fstrim's discard(s) completing
vs concurrent block allocation, via dd, in the next iteration of the
loop.

No amount of space map accounting improvements will be able to allow
user's to use a block before a discard of that block has completed.

So the best we can really do is allow DM thinp to gracefully handle such
aggressive use of all the pool's data by degrading the pool into
out-of-data-space (OODS) mode.  We _should_ get that behaviour already
(if space map accounting didn't falsely cause alloc_data_block() to
believe free space was available).. but short of that we handle the
current reality that dm_pool_alloc_data_block() can return -ENOSPC.

Reported-by: Dennis Yang <dennisyang@qnap.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-thin.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -938,6 +938,8 @@ static void schedule_zero(struct thin_c
 
 static void set_pool_mode(struct pool *pool, enum pool_mode new_mode);
 
+static void requeue_bios(struct pool *pool);
+
 static void check_for_space(struct pool *pool)
 {
 	int r;
@@ -950,8 +952,10 @@ static void check_for_space(struct pool
 	if (r)
 		return;
 
-	if (nr_free)
+	if (nr_free) {
 		set_pool_mode(pool, PM_WRITE);
+		requeue_bios(pool);
+	}
 }
 
 /*
@@ -1028,7 +1032,10 @@ static int alloc_data_block(struct thin_
 
 	r = dm_pool_alloc_data_block(pool->pmd, result);
 	if (r) {
-		metadata_operation_failed(pool, "dm_pool_alloc_data_block", r);
+		if (r == -ENOSPC)
+			set_pool_mode(pool, PM_OUT_OF_DATA_SPACE);
+		else
+			metadata_operation_failed(pool, "dm_pool_alloc_data_block", r);
 		return r;
 	}
 

