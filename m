Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 10049C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA028208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaV6Wplu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA028208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965311AbeFNOIn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964910AbeFNOIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:08:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C086208DA;
        Thu, 14 Jun 2018 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985320;
        bh=JvjW+vPvEvdewk3qA1IrK2ano7E+lK0WzE7x7oC50VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaV6WpluhUQKmAIuzU6UVaJ781zmMciddJexQkUz6a/00H1vhqT3E4GPfGSo85l4Q
         TEDuVdF6vv1sHvwuJ7C6OIhmtPqzdak3iz2hhg7MYILx+Y0rB+WUUuX5MYR1Sbj8ng
         HCuzW4CJ5LofwpHzbLUeo07GNTTVU2Q2LbGuYPIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 03/43] blkdev_report_zones_ioctl(): Use vmalloc() to allocate large buffers
Date:   Thu, 14 Jun 2018 16:04:07 +0200
Message-Id: <20180614132135.271532596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 327ea4adcfa37194739f1ec7c70568944d292281 upstream.

Avoid that complaints similar to the following appear in the kernel log
if the number of zones is sufficiently large:

  fio: page allocation failure: order:9, mode:0x140c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
  Call Trace:
  dump_stack+0x63/0x88
  warn_alloc+0xf5/0x190
  __alloc_pages_slowpath+0x8f0/0xb0d
  __alloc_pages_nodemask+0x242/0x260
  alloc_pages_current+0x6a/0xb0
  kmalloc_order+0x18/0x50
  kmalloc_order_trace+0x26/0xb0
  __kmalloc+0x20e/0x220
  blkdev_report_zones_ioctl+0xa5/0x1a0
  blkdev_ioctl+0x1ba/0x930
  block_ioctl+0x41/0x50
  do_vfs_ioctl+0xaa/0x610
  SyS_ioctl+0x79/0x90
  do_syscall_64+0x79/0x1b0
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Damien Le Moal <damien.lemoal@hgst.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-zoned.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -328,7 +328,11 @@ int blkdev_report_zones_ioctl(struct blo
 	if (!rep.nr_zones)
 		return -EINVAL;
 
-	zones = kcalloc(rep.nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
+	if (rep.nr_zones > INT_MAX / sizeof(struct blk_zone))
+		return -ERANGE;
+
+	zones = kvmalloc(rep.nr_zones * sizeof(struct blk_zone),
+			GFP_KERNEL | __GFP_ZERO);
 	if (!zones)
 		return -ENOMEM;
 
@@ -350,7 +354,7 @@ int blkdev_report_zones_ioctl(struct blo
 	}
 
  out:
-	kfree(zones);
+	kvfree(zones);
 
 	return ret;
 }


