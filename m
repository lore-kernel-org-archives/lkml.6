Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBFEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93182208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93182208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965810AbeFRKEQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:04:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933182AbeFRISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86C03C75;
        Mon, 18 Jun 2018 08:18:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 071/279] mm: memcg: add __GFP_NOWARN in __memcg_schedule_kmem_cache_create()
Date:   Mon, 18 Jun 2018 10:10:56 +0200
Message-Id: <20180618080611.755599891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
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

From: Minchan Kim <minchan@kernel.org>

[ Upstream commit c892fd82cc0632d425ae011a4dd75eb59e9f84ee ]

If there is heavy memory pressure, page allocation with __GFP_NOWAIT
fails easily although it's order-0 request.  I got below warning 9 times
for normal boot.

     <snip >: page allocation failure: order:0, mode:0x2200000(GFP_NOWAIT|__GFP_NOTRACK)
     .. snip ..
     Call trace:
       dump_backtrace+0x0/0x4
       dump_stack+0xa4/0xc0
       warn_alloc+0xd4/0x15c
       __alloc_pages_nodemask+0xf88/0x10fc
       alloc_slab_page+0x40/0x18c
       new_slab+0x2b8/0x2e0
       ___slab_alloc+0x25c/0x464
       __kmalloc+0x394/0x498
       memcg_kmem_get_cache+0x114/0x2b8
       kmem_cache_alloc+0x98/0x3e8
       mmap_region+0x3bc/0x8c0
       do_mmap+0x40c/0x43c
       vm_mmap_pgoff+0x15c/0x1e4
       sys_mmap+0xb0/0xc8
       el0_svc_naked+0x24/0x28
     Mem-Info:
     active_anon:17124 inactive_anon:193 isolated_anon:0
      active_file:7898 inactive_file:712955 isolated_file:55
      unevictable:0 dirty:27 writeback:18 unstable:0
      slab_reclaimable:12250 slab_unreclaimable:23334
      mapped:19310 shmem:212 pagetables:816 bounce:0
      free:36561 free_pcp:1205 free_cma:35615
     Node 0 active_anon:68496kB inactive_anon:772kB active_file:31592kB inactive_file:2851820kB unevictable:0kB isolated(anon):0kB isolated(file):220kB mapped:77240kB dirty:108kB writeback:72kB shmem:848kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
     DMA free:142188kB min:3056kB low:3820kB high:4584kB active_anon:10052kB inactive_anon:12kB active_file:312kB inactive_file:1412620kB unevictable:0kB writepending:0kB present:1781412kB managed:1604728kB mlocked:0kB slab_reclaimable:3592kB slab_unreclaimable:876kB kernel_stack:400kB pagetables:52kB bounce:0kB free_pcp:1436kB local_pcp:124kB free_cma:142492kB
     lowmem_reserve[]: 0 1842 1842
     Normal free:4056kB min:4172kB low:5212kB high:6252kB active_anon:58376kB inactive_anon:760kB active_file:31348kB inactive_file:1439040kB unevictable:0kB writepending:180kB present:2000636kB managed:1923688kB mlocked:0kB slab_reclaimable:45408kB slab_unreclaimable:92460kB kernel_stack:9680kB pagetables:3212kB bounce:0kB free_pcp:3392kB local_pcp:688kB free_cma:0kB
     lowmem_reserve[]: 0 0 0
     DMA: 0*4kB 0*8kB 1*16kB (C) 0*32kB 0*64kB 0*128kB 1*256kB (C) 1*512kB (C) 0*1024kB 1*2048kB (C) 34*4096kB (C) = 142096kB
     Normal: 228*4kB (UMEH) 172*8kB (UMH) 23*16kB (UH) 24*32kB (H) 5*64kB (H) 1*128kB (H) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3872kB
     721350 total pagecache pages
     0 pages in swap cache
     Swap cache stats: add 0, delete 0, find 0/0
     Free swap  = 0kB
     Total swap = 0kB
     945512 pages RAM
     0 pages HighMem/MovableOnly
     63408 pages reserved
     51200 pages cma reserved

__memcg_schedule_kmem_cache_create() tries to create a shadow slab cache
and the worker allocation failure is not really critical because we will
retry on the next kmem charge.  We might miss some charges but that
shouldn't be critical.  The excessive allocation failure report is not
very helpful.

[mhocko@kernel.org: changelog update]
Link: http://lkml.kernel.org/r/20180418022912.248417-1-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2192,7 +2192,7 @@ static void __memcg_schedule_kmem_cache_
 {
 	struct memcg_kmem_cache_create_work *cw;
 
-	cw = kmalloc(sizeof(*cw), GFP_NOWAIT);
+	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
 	if (!cw)
 		return;
 


