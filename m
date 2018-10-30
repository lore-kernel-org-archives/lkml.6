Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C73C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009272081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wQ4plRSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009272081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeJaD15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55430 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeJaD14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:56 -0400
Received: by mail-it1-f194.google.com with SMTP id e17so13336151itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y5BsDQmc5dLZKcxCUwh1dtXo4oyHvmazmNAUSxG7ysA=;
        b=wQ4plRSc/xR6AA0ydQd7opC1U4kC0qs2liAeermPEOb8+9FYYztWC+edXPYCcVBBQs
         ghkpkpY+uCHavWvq4vMR3IIdMfnY73VrgCHYdfEK72RnLnakf5ZC9GkLSx7zRA/LSiIR
         oFOuHwcbdtMaycKYRlFUFpd87dPgdyFhYBvsMc0oauR8vHA6gqBVIKk6URLZqaYT0Iv+
         zOuMYhnqMLIUdQcXYf6Sx6R5XmmMRuBQ9eVXmwZKZ8uk4TgG/jNLMTu2xxLh2PjWYom6
         XeQd5ljRVH3uxDC+CIFBYxrfJiyGLeMEbKRdJLZnLIGlHLeiGGW+prwrYvgLOQOF3G7N
         fmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y5BsDQmc5dLZKcxCUwh1dtXo4oyHvmazmNAUSxG7ysA=;
        b=QlJLbvurNoCo0qGXrKHOh6cjkuIIzLEgnHcw2ig0f0knBIHhBhRM/Rfq5rxKQVDLGw
         nrrMNg/ZPexMj5uyFYp1jnItesVvkXYkiedIUrvBTWwqgBTEnkIz+3zS4ZcoY0r4/5X7
         wg4NO7KfhkfUPA59cUux64CFzatWmQ/b2pRQU2bx0j6EX9I9AoSWSq2HXKu4Hf1AYWs2
         SgxVa0ItoB8Ur7pK++MtMSx9UrSkZg97mINkD1NOgR/5Jwnz43bKk0ClCU2FZSQrbg9t
         5ALb311bYAppEov96mnydAHJJey5GS0ECKvooX7Y8UHwA7QBzW/gDqDdK0vLrcxsZV0o
         sDyA==
X-Gm-Message-State: AGRZ1gKhtbm/Wv9+dPnOddy7A6YsxbJCXvhmIpCjs06xoW4tqi7yEhWl
        YoFmFxwcHWfSBhZ7PUJ7EPlbmnHcwZY=
X-Google-Smtp-Source: AJdET5c8lgFP+5G3+iVQMsg+cmnq+NP40CxMu4iI55YCg16CoUttivf10ZpFbuiS++2hXW9WN660WQ==
X-Received: by 2002:a24:ed0c:: with SMTP id r12-v6mr629ith.53.1540924400045;
        Tue, 30 Oct 2018 11:33:20 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/16] blk-mq: initial support for multiple queue maps
Date:   Tue, 30 Oct 2018 12:32:48 -0600
Message-Id: <20181030183252.17857-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a queue offset to the tag map. This enables users to map
iteratively, for each queue map type they support.

Bump maximum number of supported maps to 2, we're now fully
able to support more than 1 map.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-cpumap.c  | 9 +++++----
 block/blk-mq-pci.c     | 2 +-
 block/blk-mq-virtio.c  | 2 +-
 include/linux/blk-mq.h | 3 ++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 6e6686c55984..03a534820271 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -14,9 +14,10 @@
 #include "blk.h"
 #include "blk-mq.h"
 
-static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
+static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
+			      unsigned int nr_queues, const int cpu)
 {
-	return cpu % nr_queues;
+	return qmap->queue_offset + (cpu % nr_queues);
 }
 
 static int get_first_sibling(unsigned int cpu)
@@ -44,11 +45,11 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 		 * performace optimizations.
 		 */
 		if (cpu < nr_queues) {
-			map[cpu] = cpu_to_queue_index(nr_queues, cpu);
+			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
 		} else {
 			first_sibling = get_first_sibling(cpu);
 			if (first_sibling == cpu)
-				map[cpu] = cpu_to_queue_index(nr_queues, cpu);
+				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
 			else
 				map[cpu] = map[first_sibling];
 		}
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 40333d60a850..1dce18553984 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -43,7 +43,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
 			goto fallback;
 
 		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = queue;
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
 	return 0;
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 661fbfef480f..370827163835 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -44,7 +44,7 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 			goto fallback;
 
 		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = queue;
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
 	return 0;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 26768c8f5af5..8e80d5043079 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -78,10 +78,11 @@ struct blk_mq_hw_ctx {
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
+	unsigned int queue_offset;
 };
 
 enum {
-	HCTX_MAX_TYPES = 1,
+	HCTX_MAX_TYPES = 2,
 };
 
 struct blk_mq_tag_set {
-- 
2.17.1

