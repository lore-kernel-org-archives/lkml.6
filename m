Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E6DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E15219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E15219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeHHQpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:45:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeHHQpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:45:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEDFFAE9E;
        Wed,  8 Aug 2018 14:25:45 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 3/5] xen/blkfront: reorder tests in xlblk_init()
Date:   Wed,  8 Aug 2018 16:25:26 +0200
Message-Id: <20180808142528.31029-4-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180808142528.31029-1-jgross@suse.com>
References: <20180808142528.31029-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we don't want pv block devices we should not test parameters
for sanity and eventually print out error messages. So test precluding
conditions before checking parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkfront.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7c4b1b9d3971..36e4ca41e765 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2713,6 +2713,15 @@ static int __init xlblk_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	if (!xen_has_pv_disk_devices())
+		return -ENODEV;
+
+	if (register_blkdev(XENVBD_MAJOR, DEV_NAME)) {
+		pr_warn("xen_blk: can't get major %d with name %s\n",
+			XENVBD_MAJOR, DEV_NAME);
+		return -ENODEV;
+	}
+
 	if (xen_blkif_max_segments < BLKIF_MAX_SEGMENTS_PER_REQUEST)
 		xen_blkif_max_segments = BLKIF_MAX_SEGMENTS_PER_REQUEST;
 
@@ -2728,15 +2737,6 @@ static int __init xlblk_init(void)
 		xen_blkif_max_queues = nr_cpus;
 	}
 
-	if (!xen_has_pv_disk_devices())
-		return -ENODEV;
-
-	if (register_blkdev(XENVBD_MAJOR, DEV_NAME)) {
-		printk(KERN_WARNING "xen_blk: can't get major %d with name %s\n",
-		       XENVBD_MAJOR, DEV_NAME);
-		return -ENODEV;
-	}
-
 	INIT_DELAYED_WORK(&blkfront_work, blkfront_delay_work);
 
 	ret = xenbus_register_frontend(&blkfront_driver);
-- 
2.13.7

