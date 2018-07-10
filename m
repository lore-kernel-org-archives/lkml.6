Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF3208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEF3208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390151AbeGJShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:37:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbeGJShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:37:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F9CEACC;
        Tue, 10 Jul 2018 18:36:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 4.17 49/56] dax: check for QUEUE_FLAG_DAX in bdev_dax_supported()
Date:   Tue, 10 Jul 2018 20:25:31 +0200
Message-Id: <20180710182505.887388067@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit 15256f6cc4b44f2e70503758150267fd2a53c0d6 upstream.

Add an explicit check for QUEUE_FLAG_DAX to __bdev_dax_supported().  This
is needed for DM configurations where the first element in the dm-linear or
dm-stripe target supports DAX, but other elements do not.  Without this
check __bdev_dax_supported() will pass for such devices, letting a
filesystem on that device mount with the DAX option.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Mike Snitzer <snitzer@redhat.com>
Fixes: commit 545ed20e6df6 ("dm: add infrastructure for DAX support")
Cc: stable@vger.kernel.org
Acked-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/dax/super.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -85,6 +85,7 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	struct dax_device *dax_dev;
+	struct request_queue *q;
 	pgoff_t pgoff;
 	int err, id;
 	void *kaddr;
@@ -97,6 +98,13 @@ bool __bdev_dax_supported(struct block_d
 				bdevname(bdev, buf));
 		return false;
 	}
+
+	q = bdev_get_queue(bdev);
+	if (!q || !blk_queue_dax(q)) {
+		pr_debug("%s: error: request queue doesn't support dax\n",
+				bdevname(bdev, buf));
+		return false;
+	}
 
 	err = bdev_dax_pgoff(bdev, 0, PAGE_SIZE, &pgoff);
 	if (err) {


