Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012422145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7OYBACI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbeLQNUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:20:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeLQNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so12231915wrs.8;
        Mon, 17 Dec 2018 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YquMkg1TqdY2GtzLZyFc5MKg3xORVzW2lm+TNYyciQ0=;
        b=c7OYBACIt6py6KEPUlAzLJBmro7VoG0qieexN/5YG1+DMblCbrYg4aAXszyS2pjyJJ
         FwHcweXzVn4Wu9v1nzjH7WnV7yMeAqYVK7txRDa/2PR54e7uhvdsEocPeVFmnOFN6UPh
         9E70sEmuMki2QT4m9AWrV1plWoft7iiCl5ym6WJaYLUJvT0sZhI2SKBZ1qQo8ecjtR5l
         YQ/1PUHdEpUv1o3We+4VCc0tTO2Dh5HRcaRM2UXT1/hpCiM09+jAkUjkOS/jfiAK2AS0
         SlnLOQqAAQpOqG0TdH0tJt6AaYzf0pfwAni61XPih9Up9ClW11xxfhBOiRbppQciSvCu
         C7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YquMkg1TqdY2GtzLZyFc5MKg3xORVzW2lm+TNYyciQ0=;
        b=prU30/4n+uZDdT7GyxzgjosNBmTxUHXeQVwvnjxgzLE09Z8yUjS+jwG7mdgSGgZs0Y
         U91RW4oWaFXtcTdAXihZbmm6DfQFhTiiOZ0HVUy5YaLDf7eNhKR1jqozSOy4dnw4S2LM
         xX62jwNlYwUTEW21UHPd6gkYCAUC1tJdUw1Phh/Nx7nFAXTwISe0IG9PvTxuOU+nTr/i
         EsSePu1zhZfhzccqYeyzNK90CqvSQpTi4JTExoDGDcPFo9YQLIwTR2AsZtDsbyLbSS/z
         fMF+z0odizOD+6aM74P/GgGrekzuDhXVk6aBZxF0Xabv9GiADFwdI6vQ29rNpwzlENjl
         hBcA==
X-Gm-Message-State: AA+aEWaix0DhtfErjxQQWf472Pv+pl9U7ZAtvlK6qoidaMSU9Z6g5RIh
        RuANEzMd1q8Uy8dWjeZSYQ==
X-Google-Smtp-Source: AFSGD/VtPruNFCDIDFOU28ANzBXu+lS6eXsFc8M7XwHnzmK6QX9Jzv5Gl2xG85EU/FZ+TDRe9vKhLQ==
X-Received: by 2002:adf:8068:: with SMTP id 95mr10597725wrk.181.1545052780560;
        Mon, 17 Dec 2018 05:19:40 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:39 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/7] md: convert to kvmalloc
Date:   Mon, 17 Dec 2018 08:19:24 -0500
Message-Id: <20181217131929.11727-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181217131929.11727-1-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code really just wants a big flat buffer, so just do that.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: linux-raid@vger.kernel.org
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/md/raid5-ppl.c |  6 +--
 drivers/md/raid5.c     | 87 +++++++++++++++++++-----------------------
 drivers/md/raid5.h     |  9 +++--
 3 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 3a7c363265..0b096ddc9c 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -16,7 +16,6 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/crc32c.h>
-#include <linux/flex_array.h>
 #include <linux/async_tx.h>
 #include <linux/raid/md_p.h>
 #include "md.h"
@@ -165,7 +164,7 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
 		       struct dma_async_tx_descriptor *tx)
 {
 	int disks = sh->disks;
-	struct page **srcs = flex_array_get(percpu->scribble, 0);
+	struct page **srcs = percpu->scribble;
 	int count = 0, pd_idx = sh->pd_idx, i;
 	struct async_submit_ctl submit;
 
@@ -196,8 +195,7 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
 	}
 
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, tx,
-			  NULL, sh, flex_array_get(percpu->scribble, 0)
-			  + sizeof(struct page *) * (sh->disks + 2));
+			  NULL, sh, (void *) (srcs + sh->disks + 2));
 
 	if (count == 1)
 		tx = async_memcpy(sh->ppl_page, srcs[0], 0, 0, PAGE_SIZE,
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4990f0319f..c92e26fbcd 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -54,7 +54,6 @@
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/nodemask.h>
-#include <linux/flex_array.h>
 
 #include <trace/events/block.h>
 #include <linux/list_sort.h>
@@ -1394,22 +1393,16 @@ static void ops_complete_compute(void *stripe_head_ref)
 }
 
 /* return a pointer to the address conversion region of the scribble buffer */
-static addr_conv_t *to_addr_conv(struct stripe_head *sh,
-				 struct raid5_percpu *percpu, int i)
+static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
 {
-	void *addr;
-
-	addr = flex_array_get(percpu->scribble, i);
-	return addr + sizeof(struct page *) * (sh->disks + 2);
+	return percpu->scribble + i * percpu->scribble_obj_size;
 }
 
 /* return a pointer to the address conversion region of the scribble buffer */
-static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
+static addr_conv_t *to_addr_conv(struct stripe_head *sh,
+				 struct raid5_percpu *percpu, int i)
 {
-	void *addr;
-
-	addr = flex_array_get(percpu->scribble, i);
-	return addr;
+	return (void *) (to_addr_page(percpu, i) + sh->disks + 2);
 }
 
 static struct dma_async_tx_descriptor *
@@ -2238,21 +2231,23 @@ static int grow_stripes(struct r5conf *conf, int num)
  * calculate over all devices (not just the data blocks), using zeros in place
  * of the P and Q blocks.
  */
-static struct flex_array *scribble_alloc(int num, int cnt, gfp_t flags)
+static int scribble_alloc(struct raid5_percpu *percpu,
+			  int num, int cnt, gfp_t flags)
 {
-	struct flex_array *ret;
-	size_t len;
+	size_t obj_size =
+		sizeof(struct page *) * (num+2) +
+		sizeof(addr_conv_t) * (num+2);
+	void *scribble;
 
-	len = sizeof(struct page *) * (num+2) + sizeof(addr_conv_t) * (num+2);
-	ret = flex_array_alloc(len, cnt, flags);
-	if (!ret)
-		return NULL;
-	/* always prealloc all elements, so no locking is required */
-	if (flex_array_prealloc(ret, 0, cnt, flags)) {
-		flex_array_free(ret);
-		return NULL;
-	}
-	return ret;
+	scribble = kvmalloc_array(cnt, obj_size, flags);
+	if (!scribble)
+		return -ENOMEM;
+
+	kvfree(percpu->scribble);
+
+	percpu->scribble = scribble;
+	percpu->scribble_obj_size = obj_size;
+	return 0;
 }
 
 static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
@@ -2270,23 +2265,18 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 		return 0;
 	mddev_suspend(conf->mddev);
 	get_online_cpus();
+
 	for_each_present_cpu(cpu) {
 		struct raid5_percpu *percpu;
-		struct flex_array *scribble;
 
 		percpu = per_cpu_ptr(conf->percpu, cpu);
-		scribble = scribble_alloc(new_disks,
-					  new_sectors / STRIPE_SECTORS,
-					  GFP_NOIO);
-
-		if (scribble) {
-			flex_array_free(percpu->scribble);
-			percpu->scribble = scribble;
-		} else {
-			err = -ENOMEM;
+		err = scribble_alloc(percpu, new_disks,
+				     new_sectors / STRIPE_SECTORS,
+				     GFP_NOIO);
+		if (err)
 			break;
-		}
 	}
+
 	put_online_cpus();
 	mddev_resume(conf->mddev);
 	if (!err) {
@@ -6738,25 +6728,26 @@ raid5_size(struct mddev *mddev, sector_t sectors, int raid_disks)
 static void free_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu)
 {
 	safe_put_page(percpu->spare_page);
-	if (percpu->scribble)
-		flex_array_free(percpu->scribble);
 	percpu->spare_page = NULL;
+	kvfree(percpu->scribble);
 	percpu->scribble = NULL;
 }
 
 static int alloc_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu)
 {
-	if (conf->level == 6 && !percpu->spare_page)
+	if (conf->level == 6 && !percpu->spare_page) {
 		percpu->spare_page = alloc_page(GFP_KERNEL);
-	if (!percpu->scribble)
-		percpu->scribble = scribble_alloc(max(conf->raid_disks,
-						      conf->previous_raid_disks),
-						  max(conf->chunk_sectors,
-						      conf->prev_chunk_sectors)
-						   / STRIPE_SECTORS,
-						  GFP_KERNEL);
-
-	if (!percpu->scribble || (conf->level == 6 && !percpu->spare_page)) {
+		if (!percpu->spare_page)
+			return -ENOMEM;
+	}
+
+	if (scribble_alloc(percpu,
+			   max(conf->raid_disks,
+			       conf->previous_raid_disks),
+			   max(conf->chunk_sectors,
+			       conf->prev_chunk_sectors)
+			   / STRIPE_SECTORS,
+			   GFP_KERNEL)) {
 		free_scratch_buffer(conf, percpu);
 		return -ENOMEM;
 	}
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 8474c22412..cf991f1340 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -638,10 +638,11 @@ struct r5conf {
 	/* per cpu variables */
 	struct raid5_percpu {
 		struct page	*spare_page; /* Used when checking P/Q in raid6 */
-		struct flex_array *scribble;   /* space for constructing buffer
-					      * lists and performing address
-					      * conversions
-					      */
+		void		*scribble;  /* space for constructing buffer
+					     * lists and performing address
+					     * conversions
+					     */
+		int scribble_obj_size;
 	} __percpu *percpu;
 	int scribble_disks;
 	int scribble_sectors;
-- 
2.20.1

