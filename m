Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD27C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4A925483
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4A925483
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934028AbeGAQvN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:51:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966018AbeGAQqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EAF4BAA6;
        Sun,  1 Jul 2018 16:46:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 4.17 211/220] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Date:   Sun,  1 Jul 2018 18:23:55 +0200
Message-Id: <20180701160916.969648521@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

commit 4557641b4c7046625c026fb809c47ef0d43ae595 upstream.

QUEUE_FLAG_DAX is an indication that a given block device supports
filesystem DAX and should not be set for PMEM namespaces which are in "raw"
mode.  These namespaces lack struct page and are prevented from
participating in filesystem DAX as of commit 569d0365f571 ("dax: require
'struct page' by default for filesystem dax").

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Mike Snitzer <snitzer@redhat.com>
Fixes: 569d0365f571 ("dax: require 'struct page' by default for filesystem dax")
Cc: stable@vger.kernel.org
Acked-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/pmem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -387,7 +387,8 @@ static int pmem_attach_disk(struct devic
 	blk_queue_logical_block_size(q, pmem_sector_size(ndns));
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	blk_queue_flag_set(QUEUE_FLAG_DAX, q);
+	if (pmem->pfn_flags & PFN_MAP)
+		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 	q->queuedata = pmem;
 
 	disk = alloc_disk_node(0, nid);


