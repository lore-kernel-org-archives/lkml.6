Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3381FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8FC21531
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8FC21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965785AbeGAQ2z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:28:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965757AbeGAQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:28:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCCCF92B;
        Sun,  1 Jul 2018 16:28:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dennis Yang <dennisyang@qnap.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.9 100/101] dm thin: handle running out of data space vs concurrent discard
Date:   Sun,  1 Jul 2018 18:22:26 +0200
Message-Id: <20180701160801.145614656@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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

>From initial report, here:
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
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1384,6 +1384,8 @@ static void schedule_external_copy(struc
 
 static void set_pool_mode(struct pool *pool, enum pool_mode new_mode);
 
+static void requeue_bios(struct pool *pool);
+
 static void check_for_space(struct pool *pool)
 {
 	int r;
@@ -1396,8 +1398,10 @@ static void check_for_space(struct pool
 	if (r)
 		return;
 
-	if (nr_free)
+	if (nr_free) {
 		set_pool_mode(pool, PM_WRITE);
+		requeue_bios(pool);
+	}
 }
 
 /*
@@ -1474,7 +1478,10 @@ static int alloc_data_block(struct thin_
 
 	r = dm_pool_alloc_data_block(pool->pmd, result);
 	if (r) {
-		metadata_operation_failed(pool, "dm_pool_alloc_data_block", r);
+		if (r == -ENOSPC)
+			set_pool_mode(pool, PM_OUT_OF_DATA_SPACE);
+		else
+			metadata_operation_failed(pool, "dm_pool_alloc_data_block", r);
 		return r;
 	}
 


