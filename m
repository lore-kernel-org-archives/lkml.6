Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54439C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272B72184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfACTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:30:01 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53425 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbfACTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:30:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0THTEqVm_1546543673;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THTEqVm_1546543673)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jan 2019 03:28:00 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        daniel.m.jordan@oracle.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 1/2] mm: swap: check if swap backing device is congested or not
Date:   Fri,  4 Jan 2019 03:27:52 +0800
Message-Id: <1546543673-108536-1-git-send-email-yang.shi@linux.alibaba.com>
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

The test with page_fault1 of will-it-scale (sometimes tracing may just
show runtest.py that is the wrapper script of page_fault1), which basically
launches NR_CPU threads to generate 128MB anonymous pages for each thread,
on my virtual machine with congested HDD shows long tail latency is reduced
significantly.

Without the patch
 page_fault1_thr-1490  [023]   129.311706: funcgraph_entry:      #57377.796 us |  do_swap_page();
 page_fault1_thr-1490  [023]   129.369103: funcgraph_entry:        5.642us   |  do_swap_page();
 page_fault1_thr-1490  [023]   129.369119: funcgraph_entry:      #1289.592 us |  do_swap_page();
 page_fault1_thr-1490  [023]   129.370411: funcgraph_entry:        4.957us   |  do_swap_page();
 page_fault1_thr-1490  [023]   129.370419: funcgraph_entry:        1.940us   |  do_swap_page();
 page_fault1_thr-1490  [023]   129.378847: funcgraph_entry:      #1411.385 us |  do_swap_page();
 page_fault1_thr-1490  [023]   129.380262: funcgraph_entry:        3.916us   |  do_swap_page();
 page_fault1_thr-1490  [023]   129.380275: funcgraph_entry:      #4287.751 us |  do_swap_page();

With the patch
      runtest.py-1417  [020]   301.925911: funcgraph_entry:      #9870.146 us |  do_swap_page();
      runtest.py-1417  [020]   301.935785: funcgraph_entry:        9.802us   |  do_swap_page();
      runtest.py-1417  [020]   301.935799: funcgraph_entry:        3.551us   |  do_swap_page();
      runtest.py-1417  [020]   301.935806: funcgraph_entry:        2.142us   |  do_swap_page();
      runtest.py-1417  [020]   301.935853: funcgraph_entry:        6.938us   |  do_swap_page();
      runtest.py-1417  [020]   301.935864: funcgraph_entry:        3.765us   |  do_swap_page();
      runtest.py-1417  [020]   301.935871: funcgraph_entry:        3.600us   |  do_swap_page();
      runtest.py-1417  [020]   301.935878: funcgraph_entry:        7.202us   |  do_swap_page();

Acked-by: Tim Chen <tim.c.chen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v5: Elaborate more about the test case per Daniel
v4: Added observed effects in the commit log per Andrew
v3: Move inode deference under swap device type check per Tim Chen
v2: Check the swap device type per Tim Chen

 mm/swap_state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index fd2f21e..78d500e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -538,11 +538,18 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	bool do_poll = true, page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
+	struct inode *inode = NULL;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
 
+	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
+		inode = si->swap_file->f_mapping->host;
+		if (inode_read_congested(inode))
+			goto skip;
+	}
+
 	do_poll = false;
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
-- 
1.8.3.1

