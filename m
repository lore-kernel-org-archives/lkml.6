Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E68C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666F925EEE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666F925EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965046AbeF0MqS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:46:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964963AbeF0MqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65C6970206;
        Wed, 27 Jun 2018 12:46:15 +0000 (UTC)
Received: from localhost (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8DA11166E3;
        Wed, 27 Jun 2018 12:46:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org
Subject: [PATCH V7 01/24] dm: use bio_split() when splitting out the already processed bio
Date:   Wed, 27 Jun 2018 20:45:25 +0800
Message-Id: <20180627124548.3456-2-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 12:46:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 12:46:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

Use of bio_clone_bioset() is inefficient if there is no need to clone
the original bio's bio_vec array.  Best to use the bio_clone_fast()
variant.  Also, just using bio_advance() is only part of what is needed
to properly setup the clone -- it doesn't account for the various
bio_integrity() related work that also needs to be performed (see
bio_split).

Address both of these issues by switching from bio_clone_bioset() to
bio_split().

Fixes: 18a25da8 ("dm: ensure bio submission follows a depth-first tree walk")
Cc: stable@vger.kernel.org
Reported-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: NeilBrown <neilb@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e65429a29c06..a3b103e8e3ce 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1606,10 +1606,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				 * the usage of io->orig_bio in dm_remap_zone_report()
 				 * won't be affected by this reassignment.
 				 */
-				struct bio *b = bio_clone_bioset(bio, GFP_NOIO,
-								 &md->queue->bio_split);
+				struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
+							  GFP_NOIO, &md->queue->bio_split);
 				ci.io->orig_bio = b;
-				bio_advance(bio, (bio_sectors(bio) - ci.sector_count) << 9);
 				bio_chain(b, bio);
 				ret = generic_make_request(bio);
 				break;
-- 
2.9.5

