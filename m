Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0154CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43A72083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43A72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbeGJSaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732596AbeGJSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FCDDEB4;
        Tue, 10 Jul 2018 18:29:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sarah Newman <srn@prgmr.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 23/52] drbd: fix access after free
Date:   Tue, 10 Jul 2018 20:24:51 +0200
Message-Id: <20180710182451.706696675@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>

commit 64dafbc9530c10300acffc57fae3269d95fa8f93 upstream.

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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/drbd/drbd_worker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -269,8 +269,8 @@ void drbd_request_endio(struct bio *bio)
 		what = COMPLETED_OK;
 	}
 
-	bio_put(req->private_bio);
 	req->private_bio = ERR_PTR(bio->bi_error);
+	bio_put(bio);
 
 	/* not req_mod(), we need irqsave here! */
 	spin_lock_irqsave(&device->resource->req_lock, flags);


