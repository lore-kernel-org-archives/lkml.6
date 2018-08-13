Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74BCC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9225B217C5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9225B217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeHMQno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:43:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729638AbeHMQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:43:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E085B002;
        Mon, 13 Aug 2018 14:01:17 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 4/5] xen/blkback: move persistent grants flags to bool
Date:   Mon, 13 Aug 2018 16:01:13 +0200
Message-Id: <20180813140114.20126-5-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180813140114.20126-1-jgross@suse.com>
References: <20180813140114.20126-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct persistent_gnt flags member is meant to be a bitfield of
different flags. There is only PERSISTENT_GNT_ACTIVE flag left, so
convert it to a bool named "active".

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkback/blkback.c | 13 ++++++-------
 drivers/block/xen-blkback/common.h  |  7 +------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 9eae7b243f68..fd1e19f1a49f 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -255,8 +255,7 @@ static int add_persistent_gnt(struct xen_blkif_ring *ring,
 		}
 	}
 
-	bitmap_zero(persistent_gnt->flags, PERSISTENT_GNT_FLAGS_SIZE);
-	set_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags);
+	persistent_gnt->active = true;
 	/* Add new node and rebalance tree. */
 	rb_link_node(&(persistent_gnt->node), parent, new);
 	rb_insert_color(&(persistent_gnt->node), &ring->persistent_gnts);
@@ -280,11 +279,11 @@ static struct persistent_gnt *get_persistent_gnt(struct xen_blkif_ring *ring,
 		else if (gref > data->gnt)
 			node = node->rb_right;
 		else {
-			if(test_bit(PERSISTENT_GNT_ACTIVE, data->flags)) {
+			if (data->active) {
 				pr_alert_ratelimited("requesting a grant already in use\n");
 				return NULL;
 			}
-			set_bit(PERSISTENT_GNT_ACTIVE, data->flags);
+			data->active = true;
 			atomic_inc(&ring->persistent_gnt_in_use);
 			return data;
 		}
@@ -295,10 +294,10 @@ static struct persistent_gnt *get_persistent_gnt(struct xen_blkif_ring *ring,
 static void put_persistent_gnt(struct xen_blkif_ring *ring,
                                struct persistent_gnt *persistent_gnt)
 {
-	if(!test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
+	if (!persistent_gnt->active)
 		pr_alert_ratelimited("freeing a grant already unused\n");
 	persistent_gnt->last_used = jiffies;
-	clear_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags);
+	persistent_gnt->active = false;
 	atomic_dec(&ring->persistent_gnt_in_use);
 }
 
@@ -429,7 +428,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
 		BUG_ON(persistent_gnt->handle ==
 			BLKBACK_INVALID_HANDLE);
 
-		if (test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
+		if (persistent_gnt->active)
 			continue;
 		if (!scan_used && !persistent_gnt_timeout(persistent_gnt))
 			continue;
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 7bff72db3b7e..2339b8d39c5e 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -233,11 +233,6 @@ struct xen_vbd {
 
 struct backend_info;
 
-/* Number of available flags */
-#define PERSISTENT_GNT_FLAGS_SIZE	1
-/* This persistent grant is currently in use */
-#define PERSISTENT_GNT_ACTIVE		0
-
 /* Number of requests that we can fit in a ring */
 #define XEN_BLKIF_REQS_PER_PAGE		32
 
@@ -246,7 +241,7 @@ struct persistent_gnt {
 	grant_ref_t gnt;
 	grant_handle_t handle;
 	unsigned long last_used;
-	DECLARE_BITMAP(flags, PERSISTENT_GNT_FLAGS_SIZE);
+	bool active;
 	struct rb_node node;
 	struct list_head remove_node;
 };
-- 
2.13.7

