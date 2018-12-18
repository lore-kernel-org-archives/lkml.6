Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1476C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99463214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeLRGxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:53:34 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33766 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbeLRGxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:53:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TG1j1yV_1545115948;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TG1j1yV_1545115948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Dec 2018 14:52:35 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm: swap: check if swap backing device is congested or not
Date:   Tue, 18 Dec 2018 14:52:27 +0800
Message-Id: <1545115948-25467-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap readahead would read in a few pages regardless if the underlying
device is busy or not.  It may incur long waiting time if the device is
congested, and it may also exacerbate the congestion.

Use inode_read_congested() to check if the underlying device is busy or
not like what file page readahead does.  Get inode from swap_info_struct.
Although we can add inode information in swap_address_space
(address_space->host), it may lead some unexpected side effect, i.e.
it may break mapping_cap_account_dirty().  Using inode from
swap_info_struct seems simple and good enough.

Just does the check in vma_cluster_readahead() since
swap_vma_readahead() is just used for non-rotational device which
much less likely has congestion than traditional HDD.

Although swap slots may be consecutive on swap partition, it still may be
fragmented on swap file. This check would help to reduce excessive stall
for such case.

Cc: Huang Ying <ying.huang@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/swap_state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index fd2f21e..7cc3c29 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -538,11 +538,15 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	bool do_poll = true, page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
+	struct inode *inode = si->swap_file->f_mapping->host;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
 
+	if (inode_read_congested(inode))
+		goto skip;
+
 	do_poll = false;
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
-- 
1.8.3.1

