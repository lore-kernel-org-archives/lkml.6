Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF70C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442642084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfBCOVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55820 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730494AbfBCOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:27 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeD-0006RA-S9; Sun, 03 Feb 2019 14:21:25 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006se-5R; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jens Axboe" <axboe@kernel.dk>, "Coly Li" <colyli@suse.de>,
        "tang.junhui" <tang.junhui@zte.com.cn>,
        "Michael Lyle" <mlyle@lyle.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.277992422@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 068/305] bcache: fix wrong cache_misses statistics
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "tang.junhui" <tang.junhui@zte.com.cn>

commit c157313791a999646901b3e3c6888514ebc36d62 upstream.

Currently, Cache missed IOs are identified by s->cache_miss, but actually,
there are many situations that missed IOs are not assigned a value for
s->cache_miss in cached_dev_cache_miss(), for example, a bypassed IO
(s->iop.bypass = 1), or the cache_bio allocate failed. In these situations,
it will go to out_put or out_submit, and s->cache_miss is null, which leads
bch_mark_cache_accounting() to treat this IO as a hit IO.

[ML: applied by 3-way merge]

Signed-off-by: tang.junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/request.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -462,6 +462,7 @@ struct search {
 	unsigned		recoverable:1;
 	unsigned		write:1;
 	unsigned		read_dirty_data:1;
+	unsigned		cache_missed:1;
 
 	unsigned long		start_time;
 
@@ -651,6 +652,7 @@ static inline struct search *search_allo
 
 	s->orig_bio		= bio;
 	s->cache_miss		= NULL;
+	s->cache_missed		= 0;
 	s->d			= d;
 	s->recoverable		= 1;
 	s->write		= (bio->bi_rw & REQ_WRITE) != 0;
@@ -774,7 +776,7 @@ static void cached_dev_read_done_bh(stru
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 
 	bch_mark_cache_accounting(s->iop.c, s->d,
-				  !s->cache_miss, s->iop.bypass);
+				  !s->cache_missed, s->iop.bypass);
 	trace_bcache_read(s->orig_bio, !s->cache_miss, s->iop.bypass);
 
 	if (s->iop.error)
@@ -793,6 +795,8 @@ static int cached_dev_cache_miss(struct
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 	struct bio *miss, *cache_bio;
 
+	s->cache_missed = 1;
+
 	if (s->cache_miss || s->iop.bypass) {
 		miss = bio_next_split(bio, sectors, GFP_NOIO, s->d->bio_split);
 		ret = miss == bio ? MAP_DONE : MAP_CONTINUE;

