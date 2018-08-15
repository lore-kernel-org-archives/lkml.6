Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C9EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5CF215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YKLjhqlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CF215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeHOLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:33:00 -0400
Received: from m12-15.163.com ([220.181.12.15]:57133 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeHOLdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=oEO2X/Rko26SrxmRa2
        4J/081CM1b8tK+ol2x30mMJaU=; b=YKLjhqlW3EMCObgM9ReoL+eAPtKiteYIgB
        uoClzyAVJmSyDI3RcIVFYgBL+qZsj58YAjYINE25GKmmqESnAbpKyCST0cER3VQn
        orV2TAESaiLBpDoW18oNf/+BE9D0unUCME8Lkyg5ojpzqlnHAXHzeJA4c6K/wIWG
        CRF2/lH6s=
Received: from localhost.localdomain (unknown [117.136.38.140])
        by smtp11 (Coremail) with SMTP id D8CowAA3DEJA53Nb719pDg--.48186S4;
        Wed, 15 Aug 2018 16:41:36 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH 3/3] fix some potential memory leak in bcache_device_init
Date:   Wed, 15 Aug 2018 16:41:23 +0800
Message-Id: <20180815084123.7048-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAA3DEJA53Nb719pDg--.48186S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xuFWkCF45ur4xCryxGrg_yoW8Kr1xpF
        WxWa45trW8Ww42grZxZr4DXr1rC397Ka4ft3yxZ3W0g34qkr4YqFWfAr90qF4vkrZ7XFWa
        qr4UJw1Uu3WkJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UadgZUUUUU=
X-Originating-IP: [117.136.38.140]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiRwGj3Fc7D+5KkwAAst
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add some goto label to release memory in case we got wrong return value.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/super.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 14c31e03..b1197cb7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -768,6 +768,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 					 SIZE_MAX / sizeof(atomic_t));
 	size_t n;
 	int idx;
+	int ret = -ENOMEM;
 
 	if (!d->stripe_size)
 		d->stripe_size = 1 << 31;
@@ -777,18 +778,18 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
 		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
 			(unsigned)d->nr_stripes);
-		return -ENOMEM;
+		goto err1;
 	}
 
 	n = d->nr_stripes * sizeof(atomic_t);
 	d->stripe_sectors_dirty = kvzalloc(n, GFP_KERNEL);
 	if (!d->stripe_sectors_dirty)
-		return -ENOMEM;
+		goto err1;
 
 	n = BITS_TO_LONGS(d->nr_stripes) * sizeof(unsigned long);
 	d->full_dirty_stripes = kvzalloc(n, GFP_KERNEL);
 	if (!d->full_dirty_stripes)
-		return -ENOMEM;
+		goto err2;
 
 	idx = ida_simple_get(&bcache_device_idx, 0,
 				BCACHE_DEVICE_IDX_MAX, GFP_KERNEL);
@@ -799,7 +800,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER) ||
 	    !(d->disk = alloc_disk(BCACHE_MINORS))) {
 		ida_simple_remove(&bcache_device_idx, idx);
-		return -ENOMEM;
+		goto err3;
 	}
 
 	set_capacity(d->disk, sectors);
@@ -812,7 +813,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 
 	q = blk_alloc_queue(GFP_KERNEL);
 	if (!q)
-		return -ENOMEM;
+		goto err4;
 
 	blk_queue_make_request(q, NULL);
 	d->disk->queue			= q;
@@ -834,6 +835,16 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 	blk_queue_write_cache(q, true, true);
 
 	return 0;
+err4:
+	bioset_exit(&d->bio_split);
+	if(d->disk)
+		del_gendisk(d->disk);
+err3:
+	kvfree(d->full_dirty_stripes);
+err2:
+	kvfree(d->stripe_sectors_dirty);
+err1:
+	return ret;
 }
 
 /* Cached device */
-- 
2.17.1


