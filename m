Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99520C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C42208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he9FZNqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C42208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935524AbeFMWOZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:14:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39934 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935315AbeFMWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:14:22 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so1927542pgc.6;
        Wed, 13 Jun 2018 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UW9sSW50Nqqcm62yVd75791q2L5Ws36u3/sT32ffQh4=;
        b=he9FZNqJc0eO2bkBQLV7rl9p/XWZnWpdjWl5nX4Clvxznea4xJTFmNtAmyrUZGqOBH
         evvxBFaQK/6kAzzVT8rH58nKMuO8GpSTwOdD22YONi7tgLkbiM3fg6ifWt64c6GFosts
         aU3yLMi2c0T9M2LmCcYxd+KU8fAN+NC9SS2mso1uyGX2ErKbGDCU3TtKK6ydzSWSmcta
         nP3jImNmjXI1wybu3UwUvplyCOl9/pPQs/Df9WWiYZJwoLceJ4BeFzlt7ZjLZFj3Xmv4
         TQRDB2UX9aeGrvXMWw0H1MoxAemLzhGMpXs1GzQ+c6KlDnrLx6zmiQ9K33a/dtvkQBq7
         WHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UW9sSW50Nqqcm62yVd75791q2L5Ws36u3/sT32ffQh4=;
        b=tVhBg33YVTjBaE41kIKDXiIkB3w/dmn7kzoJ4rEr48zzmp5a7yrLUjr60MuRRlcWRe
         NFFWlUKRzzG0LLhNyQn6TGbKgPdAAWevq4I0v+21/7UPIBgrPTadU5ty6MKk530IaRbr
         rThCPdFsbV4DLCZAPWHn5rqHXhevIIN8xPkPm7pwl24hvuVkzAXDedbpyFc0CYatKvug
         HnbFkfyOcluIAipb4vFOKMZQ8Fi2PLt0jgPc/isK+ryBC3ZZn+JYTu0Scp4tuKiliI4O
         ATeXpYKn94ijlkNXeQSt7laTqZeEkdBrSyyr7cAgwtr+NM3zUPM9LD+bBlyL+ZDbsJh7
         fINw==
X-Gm-Message-State: APt69E2OPXaF+ngw5hmoDiHE1UUik/B4/ZnytAU+r2B1Ys9wbm2bk4SA
        DhjiAoYIrcF8CvlC3lG7RO6tvQdm
X-Google-Smtp-Source: ADUXVKJjLDXU24qLbjs81LlXIS4ELNL7+JgGShhRtb6bptz3/5UvXx1Jy3tXD9oNxRRvhc3D26Hw+Q==
X-Received: by 2002:a62:3c96:: with SMTP id b22-v6mr6518786pfk.235.1528928061885;
        Wed, 13 Jun 2018 15:14:21 -0700 (PDT)
Received: from xldev-tmpl.dev.purestorage.com ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id h16-v6sm5022028pfn.80.2018.06.13.15.14.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 15:14:21 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:14:18 -0600
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     linux-block@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix bsg_unregister and bsg_open race
Message-ID: <20180613221417.GA22778@xldev-tmpl.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing implementation allows races between bsg_unregister and
bsg_open paths. bsg_ungegister and request_queue cleanup and
deletion may start and complete right after bsg_get_device (in bsg_open path)
retrieves bsg_class_device and releases the mutex. Then bsg_open path
touches freed memory of bsg_class_device and request_queue.

One possible fix is to hold the mutex all the way through bsg_get_device
instead of releasing it after bsg_class_device retrieval.

From a8647f9cfb3b2b69dcac493554cb6ea2f9b4c2dd Mon Sep 17 00:00:00 2001
From: Anatoliy Glagolev <glagolig@gmail.com>
Date: Wed, 13 Jun 2018 15:38:51 -0600
Subject: [PATCH] Fix race of bsg_open and bsg_unregister
Signed-Off-By: Anatoliy Glagolev <glagolig@gmail.com>

---
 block/bsg.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 132e657..10bc6a4 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -693,6 +693,8 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 	struct bsg_device *bd;
 	unsigned char buf[32];
 
+	lockdep_assert_held(&bsg_mutex);
+
 	if (!blk_get_queue(rq))
 		return ERR_PTR(-ENXIO);
 
@@ -707,14 +709,12 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 	bsg_set_block(bd, file);
 
 	atomic_set(&bd->ref_count, 1);
-	mutex_lock(&bsg_mutex);
 	hlist_add_head(&bd->dev_list, bsg_dev_idx_hash(iminor(inode)));
 
 	strncpy(bd->name, dev_name(rq->bsg_dev.class_dev), sizeof(bd->name) - 1);
 	bsg_dbg(bd, "bound to <%s>, max queue %d\n",
 		format_dev_t(buf, inode->i_rdev), bd->max_queue);
 
-	mutex_unlock(&bsg_mutex);
 	return bd;
 }
 
@@ -722,7 +722,7 @@ static struct bsg_device *__bsg_get_device(int minor, struct request_queue *q)
 {
 	struct bsg_device *bd;
 
-	mutex_lock(&bsg_mutex);
+	lockdep_assert_held(&bsg_mutex);
 
 	hlist_for_each_entry(bd, bsg_dev_idx_hash(minor), dev_list) {
 		if (bd->queue == q) {
@@ -732,7 +732,6 @@ static struct bsg_device *__bsg_get_device(int minor, struct request_queue *q)
 	}
 	bd = NULL;
 found:
-	mutex_unlock(&bsg_mutex);
 	return bd;
 }
 
@@ -746,16 +745,18 @@ static struct bsg_device *bsg_get_device(struct inode *inode, struct file *file)
 	 */
 	mutex_lock(&bsg_mutex);
 	bcd = idr_find(&bsg_minor_idr, iminor(inode));
-	mutex_unlock(&bsg_mutex);
 
 	if (!bcd)
 		return ERR_PTR(-ENODEV);
 
 	bd = __bsg_get_device(iminor(inode), bcd->queue);
-	if (bd)
+	if (bd) {
+		mutex_unlock(&bsg_mutex);
 		return bd;
+	}
 
 	bd = bsg_add_device(inode, bcd->queue, file);
+	mutex_unlock(&bsg_mutex);
 
 	return bd;
 }
-- 
1.9.1

