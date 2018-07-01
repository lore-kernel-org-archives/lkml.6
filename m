Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E153C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83F925429
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83F925429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032514AbeGAQqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965956AbeGAQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CBE6AA6;
        Sun,  1 Jul 2018 16:46:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        NeilBrown <neilb@suse.com>, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.17 210/220] dm: use bio_split() when splitting out the already processed bio
Date:   Sun,  1 Jul 2018 18:23:54 +0200
Message-Id: <20180701160916.931066645@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit f21c601a2bb319ec19eb4562eadc7797d90fd90e upstream.

Use of bio_clone_bioset() is inefficient if there is no need to clone
the original bio's bio_vec array.  Best to use the bio_clone_fast()
variant.  Also, just using bio_advance() is only part of what is needed
to properly setup the clone -- it doesn't account for the various
bio_integrity() related work that also needs to be performed (see
bio_split).

Address both of these issues by switching from bio_clone_bioset() to
bio_split().

Fixes: 18a25da8 ("dm: ensure bio submission follows a depth-first tree walk")
Cc: stable@vger.kernel.org # 4.15+, requires removal of '&' before md->queue->bio_split
Reported-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1582,10 +1582,9 @@ static blk_qc_t __split_and_process_bio(
 				 * the usage of io->orig_bio in dm_remap_zone_report()
 				 * won't be affected by this reassignment.
 				 */
-				struct bio *b = bio_clone_bioset(bio, GFP_NOIO,
-								 md->queue->bio_split);
+				struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
+							  GFP_NOIO, md->queue->bio_split);
 				ci.io->orig_bio = b;
-				bio_advance(bio, (bio_sectors(bio) - ci.sector_count) << 9);
 				bio_chain(b, bio);
 				ret = generic_make_request(bio);
 				break;


