Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1929C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C92E218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545153944;
	bh=loy0paVawQwjHFRQsEUvd8ZqIAGPlkera54Y5/bM1XA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xcyqvkYVG7gvLLZMlchWL5cOnSWuBTNLAmvvjYPBBjwp3lEf9ND9Ikt80F9aqds+B
	 58reRgRYKi/kZQKrA9N8GKOHCk/Zish5VH2gdJiBciKxXpKF/uqDeTNo+kUnba0iDQ
	 A+71B5p/7R8kBgTSPKdDtLFMz6ids3O8NOswRrWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeLRRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeLRRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:25:40 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58858218A3;
        Tue, 18 Dec 2018 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545153940;
        bh=loy0paVawQwjHFRQsEUvd8ZqIAGPlkera54Y5/bM1XA=;
        h=From:To:Cc:Subject:Date:From;
        b=tu7UZ4zijEZM+rWzwswqX7EHz6NG8rkoAsf0Jis9GQym910OzghrXDpjJLACyT1jK
         j60jr+CH7r7np7w+DyUyQ7ojTGELi3TkzW4TFuUk1sorfxkeo2fn/DUsRjc8Nqz8tZ
         JSZlaQvF336JZBa7WekyKNs22zseH49JvMjL4yH8=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: [PATCH] dm: give req_size precisely given by user
Date:   Tue, 18 Dec 2018 09:25:37 -0800
Message-Id: <20181218172537.12300-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes dm be aware of io_pages to assign sane req_size for reads.

Cc: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Fixes: 9491ae4a ("mm: don't cap request size based on read-ahead setting")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/md/dm-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9038c302d5c2..886790428241 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1927,6 +1927,9 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	 */
 	if (blk_queue_is_zoned(q))
 		blk_revalidate_disk_zones(t->md->disk);
+
+	/* io_pages is used for readahead */
+	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
-- 
2.19.0.605.g01d371f741-goog

