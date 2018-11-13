Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66965224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66965224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeKMTkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:40:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:50480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731526AbeKMTkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:40:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFF44B122;
        Tue, 13 Nov 2018 09:43:06 +0000 (UTC)
Date:   Tue, 13 Nov 2018 10:43:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     akpm@linux-foundation.org
Cc:     Kyungtae Kim <kt0755@gmail.com>, pavel.tatashin@microsoft.com,
        vbabka@suse.cz, osalvador@suse.de, rppt@linux.vnet.ibm.com,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        alexander.h.duyck@linux.intel.com, mgorman@techsingularity.net,
        lifeasageek@gmail.com, threeearcat@gmail.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181113094305.GM15120@dhcp22.suse.cz>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109084353.GA5321@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you take the patch please? This patch contains a comment
update as suggested by Tetsuo. I do not think there were any other
unresolved concerns.


From 9ad6b1d9c07b18dd25a6af8cccbc56d1fbe6b922 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 9 Nov 2018 09:35:29 +0100
Subject: [PATCH] mm, page_alloc: check for max order in hot path

Konstantin has noticed that kvmalloc might trigger the following warning
[Thu Nov  1 08:43:56 2018] WARNING: CPU: 0 PID: 6676 at mm/vmstat.c:986 __fragmentation_index+0x54/0x60
[...]
[Thu Nov  1 08:43:56 2018] Call Trace:
[Thu Nov  1 08:43:56 2018]  fragmentation_index+0x76/0x90
[Thu Nov  1 08:43:56 2018]  compaction_suitable+0x4f/0xf0
[Thu Nov  1 08:43:56 2018]  shrink_node+0x295/0x310
[Thu Nov  1 08:43:56 2018]  node_reclaim+0x205/0x250
[Thu Nov  1 08:43:56 2018]  get_page_from_freelist+0x649/0xad0
[Thu Nov  1 08:43:56 2018]  ? get_page_from_freelist+0x2d4/0xad0
[Thu Nov  1 08:43:56 2018]  ? release_sock+0x19/0x90
[Thu Nov  1 08:43:56 2018]  ? do_ipv6_setsockopt.isra.5+0x10da/0x1290
[Thu Nov  1 08:43:56 2018]  __alloc_pages_nodemask+0x12a/0x2a0
[Thu Nov  1 08:43:56 2018]  kmalloc_large_node+0x47/0x90
[Thu Nov  1 08:43:56 2018]  __kmalloc_node+0x22b/0x2e0
[Thu Nov  1 08:43:56 2018]  kvmalloc_node+0x3e/0x70
[Thu Nov  1 08:43:56 2018]  xt_alloc_table_info+0x3a/0x80 [x_tables]
[Thu Nov  1 08:43:56 2018]  do_ip6t_set_ctl+0xcd/0x1c0 [ip6_tables]
[Thu Nov  1 08:43:56 2018]  nf_setsockopt+0x44/0x60
[Thu Nov  1 08:43:56 2018]  SyS_setsockopt+0x6f/0xc0
[Thu Nov  1 08:43:56 2018]  do_syscall_64+0x67/0x120
[Thu Nov  1 08:43:56 2018]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

the problem is that we only check for an out of bound order in the slow
path and the node reclaim might happen from the fast path already. This
is fixable by making sure that kvmalloc doesn't ever use kmalloc for
requests that are larger than KMALLOC_MAX_SIZE but this also shows that
the code is rather fragile. A recent UBSAN report just underlines that
by the following report

 UBSAN: Undefined behaviour in mm/page_alloc.c:3117:19
 shift exponent 51 is too large for 32-bit type 'int'
 CPU: 0 PID: 6520 Comm: syz-executor1 Not tainted 4.19.0-rc2 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xd2/0x148 lib/dump_stack.c:113
  ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
  __ubsan_handle_shift_out_of_bounds+0x2b6/0x30b lib/ubsan.c:425
  __zone_watermark_ok+0x2c7/0x400 mm/page_alloc.c:3117
  zone_watermark_fast mm/page_alloc.c:3216 [inline]
  get_page_from_freelist+0xc49/0x44c0 mm/page_alloc.c:3300
  __alloc_pages_nodemask+0x21e/0x640 mm/page_alloc.c:4370
  alloc_pages_current+0xcc/0x210 mm/mempolicy.c:2093
  alloc_pages include/linux/gfp.h:509 [inline]
  __get_free_pages+0x12/0x60 mm/page_alloc.c:4414
  dma_mem_alloc+0x36/0x50 arch/x86/include/asm/floppy.h:156
  raw_cmd_copyin drivers/block/floppy.c:3159 [inline]
  raw_cmd_ioctl drivers/block/floppy.c:3206 [inline]
  fd_locked_ioctl+0xa00/0x2c10 drivers/block/floppy.c:3544
  fd_ioctl+0x40/0x60 drivers/block/floppy.c:3571
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0xb3c/0x1a30 block/ioctl.c:601
  block_ioctl+0x105/0x150 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
  ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
  do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Note that this is not a kvmalloc path. It is just that the fast path
really depends on having sanitzed order as well. Therefore move the
order check to the fast path.

Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a919ba5cb3c8..a2b68c513e22 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4060,17 +4060,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int cpuset_mems_cookie;
 	int reserve_flags;
 
-	/*
-	 * In the slowpath, we sanity check order to avoid ever trying to
-	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
-	 * be using allocators in order of preference for an area that is
-	 * too large.
-	 */
-	if (order >= MAX_ORDER) {
-		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
-		return NULL;
-	}
-
 	/*
 	 * We also sanity check to catch abuse of atomic reserves being used by
 	 * callers that are not in atomic context.
@@ -4364,6 +4353,15 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
+	/*
+	 * There are several places where we assume that the order value is sane
+	 * so bail out early if the request is out of bound.
+	 */
+	if (unlikely(order >= MAX_ORDER)) {
+		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
+		return NULL;
+	}
+
 	gfp_mask &= gfp_allowed_mask;
 	alloc_mask = gfp_mask;
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
-- 
2.19.1

-- 
Michal Hocko
SUSE Labs
