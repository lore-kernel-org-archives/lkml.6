Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71285C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F7821A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7821A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeHFNm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:42:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbeHFNm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:42:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4AFAAD6A;
        Mon,  6 Aug 2018 11:34:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 3/4] xen/blkfront: reorder tests in xlblk_init()
Date:   Mon,  6 Aug 2018 13:34:02 +0200
Message-Id: <20180806113403.24728-5-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180806113403.24728-1-jgross@suse.com>
References: <20180806113403.24728-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we don't want pv block devices we should not test parameters
for sanity and eventually print out error messages. So test precluding
conditions before checking parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 19feb8835fc4..f72d96384326 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2718,6 +2718,15 @@ static int __init xlblk_init(void)
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
 
@@ -2733,15 +2742,6 @@ static int __init xlblk_init(void)
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

