Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB29C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C819925701
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C819925701
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755046AbeFYJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:49:37 -0400
Received: from mail09.linbit.com ([212.69.161.110]:60767 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754786AbeFYJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:49:36 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2018 05:49:35 EDT
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0A4031012A9A;
        Mon, 25 Jun 2018 11:39:52 +0200 (CEST)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH] drbd: fix access after free
Date:   Mon, 25 Jun 2018 11:39:52 +0200
Message-Id: <20180625093952.20220-1-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have
  struct drbd_requests { ... struct bio *private_bio;  ... }
to hold a bio clone for local submission.

On local IO completion, we put that bio, and in case we want to use the
result later, we overload that member to hold the ERR_PTR() of the
completion result,

Which, before v4.3, used to be the passed in "int error",
so we could first bio_put(), then assign.

v4.3-rc1~100^2~21 4246a0b63bd8 block: add a bi_error field to struct bio
changed that:
  	bio_put(req->private_bio);
 -	req->private_bio = ERR_PTR(error);
 +	req->private_bio = ERR_PTR(bio->bi_error);

Which introduces an access after free,
because it was non obvious that req->private_bio == bio.

Impact of that was mostly unnoticable, because we only use that value
in a multiple-failure case, and even then map any "unexpected" error
code to EIO, so worst case we could potentially mask a more specific
error with EIO in a multiple failure case.

Unless the pointed to memory region was unmapped, as is the case with
CONFIG_DEBUG_PAGEALLOC, in which case this results in

  BUG: unable to handle kernel paging request

v4.13-rc1~70^2~75 4e4cbee93d56 block: switch bios to blk_status_t
changes it further to
  	bio_put(req->private_bio);
  	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));

And blk_status_to_errno() now contains a WARN_ON_ONCE() for unexpected
values, which catches this "sometimes", if the memory has been reused
quickly enough for other things.

Should also go into stable since 4.3, with the trivial change around 4.13.

Cc: stable@vger.kernel.org
Fixes: 4246a0b63bd8 block: add a bi_error field to struct bio
Reported-by: Sarah Newman <srn@prgmr.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_worker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 1476cb3439f4..5e793dd7adfb 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -282,8 +282,8 @@ void drbd_request_endio(struct bio *bio)
 		what = COMPLETED_OK;
 	}
 
-	bio_put(req->private_bio);
 	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));
+	bio_put(bio);
 
 	/* not req_mod(), we need irqsave here! */
 	spin_lock_irqsave(&device->resource->req_lock, flags);
-- 
2.17.1

