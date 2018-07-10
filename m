Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E21FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15A420936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15A420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbeGJSeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbeGJSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07EFDD0B;
        Tue, 10 Jul 2018 18:34:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 46/53] dm: prevent DAX mounts if not supported
Date:   Tue, 10 Jul 2018 20:25:22 +0200
Message-Id: <20180710182501.406354959@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit dbc626597c39b24cefce09fbd8e9dea85869a801 upstream.

Currently device_supports_dax() just checks to see if the QUEUE_FLAG_DAX
flag is set on the device's request queue to decide whether or not the
device supports filesystem DAX.  Really we should be using
bdev_dax_supported() like filesystems do at mount time.  This performs
other tests like checking to make sure the dax_direct_access() path works.

We also explicitly clear QUEUE_FLAG_DAX on the DM device's request queue if
any of the underlying devices do not support DAX.  This makes the handling
of QUEUE_FLAG_DAX consistent with the setting/clearing of most other flags
in dm_table_set_restrictions().

Now that bdev_dax_supported() explicitly checks for QUEUE_FLAG_DAX, this
will ensure that filesystems built upon DM devices will only be able to
mount with DAX if all underlying devices also support DAX.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: commit 545ed20e6df6 ("dm: add infrastructure for DAX support")
Cc: stable@vger.kernel.org
Acked-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-table.c |    7 ++++---
 drivers/md/dm.c       |    3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -883,9 +883,7 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
 static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			       sector_t start, sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return q && blk_queue_dax(q);
+	return bdev_dax_supported(dev->bdev, PAGE_SIZE);
 }
 
 static bool dm_table_supports_dax(struct dm_table *t)
@@ -1815,6 +1813,9 @@ void dm_table_set_restrictions(struct dm
 
 	if (dm_table_supports_dax(t))
 		queue_flag_set_unlocked(QUEUE_FLAG_DAX, q);
+	else
+		queue_flag_clear_unlocked(QUEUE_FLAG_DAX, q);
+
 	if (dm_table_supports_dax_write_cache(t))
 		dax_write_cache(t->md->dax_dev, true);
 
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -961,8 +961,7 @@ static long dm_dax_direct_access(struct
 	if (len < 1)
 		goto out;
 	nr_pages = min(len, nr_pages);
-	if (ti->type->direct_access)
-		ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
+	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
 
  out:
 	dm_put_live_table(md, srcu_idx);


