Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6D622434
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhsEveRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6D622434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933975AbeFUVfI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:35:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933916AbeFUV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oc67Ns0UqOibrElXxRnwBGD88abnMwJHxmq49BxxDuY=; b=DhsEveROzIB5k0YbN+7cyrnh5
        TIOl1yNPU4f8giWVOUKmlgu4QLB7DqynCbBoT5ACrzOY114reXYajxl7aY18uXKBrU8HFUf0PjXqQ
        +qj0+V1RiKqDcS32JE8UPyj7wDXZtjRTlxJAc0U24yZHoYzb2sihqSuF+d2p+F9E0N/jkgNO57JM9
        GyLyrALTLUNNRKaLR1HZljPWowalsmQUe02kGe1ggQvL6kc6Vu1guBrV1dnIGXNa19kdghIrAZarH
        AJjUUxyxPosJRw37ok2hprpqy2KlKIzOnpXOpWOAReAMPXyuD2/5ZykhbePwQR0SCmTIiAYn7LXQc
        yJeaTr3kw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78a-0001ae-O8; Thu, 21 Jun 2018 21:29:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christos Gkekas <chris.gekas@gmail.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Joe Perches <joe@perches.com>, linux-block@vger.kernel.org
Subject: [PATCH 04/26] mtip32xx: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:13 -0700
Message-Id: <20180621212835.5636-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a use of ida_pre_get() and a personalised spinlock.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c73626decb46..2b6d6bce76df 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -118,7 +118,6 @@ static struct dentry *dfs_device_status;
 
 static u32 cpu_use[NR_CPUS];
 
-static DEFINE_SPINLOCK(rssd_index_lock);
 static DEFINE_IDA(rssd_index_ida);
 
 static int mtip_block_initialize(struct driver_data *dd);
@@ -3768,20 +3767,10 @@ static int mtip_block_initialize(struct driver_data *dd)
 		goto alloc_disk_error;
 	}
 
-	/* Generate the disk name, implemented same as in sd.c */
-	do {
-		if (!ida_pre_get(&rssd_index_ida, GFP_KERNEL)) {
-			rv = -ENOMEM;
-			goto ida_get_error;
-		}
-
-		spin_lock(&rssd_index_lock);
-		rv = ida_get_new(&rssd_index_ida, &index);
-		spin_unlock(&rssd_index_lock);
-	} while (rv == -EAGAIN);
-
-	if (rv)
+	rv = ida_alloc(&rssd_index_ida, GFP_KERNEL);
+	if (rv < 0)
 		goto ida_get_error;
+	index = rv;
 
 	rv = rssd_disk_name_format("rssd",
 				index,
@@ -3923,9 +3912,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 block_queue_alloc_tag_error:
 	mtip_hw_debugfs_exit(dd);
 disk_index_error:
-	spin_lock(&rssd_index_lock);
-	ida_remove(&rssd_index_ida, index);
-	spin_unlock(&rssd_index_lock);
+	ida_free(&rssd_index_ida, index);
 
 ida_get_error:
 	put_disk(dd->disk);
@@ -4013,9 +4000,7 @@ static int mtip_block_remove(struct driver_data *dd)
 	}
 	dd->disk  = NULL;
 
-	spin_lock(&rssd_index_lock);
-	ida_remove(&rssd_index_ida, dd->index);
-	spin_unlock(&rssd_index_lock);
+	ida_free(&rssd_index_ida, dd->index);
 
 	/* De-initialize the protocol layer. */
 	mtip_hw_exit(dd);
@@ -4055,9 +4040,7 @@ static int mtip_block_shutdown(struct driver_data *dd)
 		dd->queue = NULL;
 	}
 
-	spin_lock(&rssd_index_lock);
-	ida_remove(&rssd_index_ida, dd->index);
-	spin_unlock(&rssd_index_lock);
+	ida_free(&rssd_index_ida, dd->index);
 	return 0;
 }
 
-- 
2.17.1

