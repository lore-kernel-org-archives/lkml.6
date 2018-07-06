Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECE1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710EB2402E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710EB2402E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeGFGRz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:17:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753198AbeGFGRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 706CAAF62;
        Fri,  6 Jul 2018 06:17:52 +0000 (UTC)
Date:   Fri, 6 Jul 2018 08:17:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
Message-ID: <20180706061750.GH32658@dhcp22.suse.cz>
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAMuHMdWEHSz34bN-U3gHW972w13f_Jrx_ObEsP3w8XZ1Gx65OA@mail.gmail.com>
 <20180704075410.GF22503@dhcp22.suse.cz>
 <89f48f7a-6cbf-ac9a-cacc-cd3ca79f8c66@suse.cz>
 <20180704123627.GM22503@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704123627.GM22503@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 14:36:27, Michal Hocko wrote:
> [CC Andrew - email thread starts
> http://lkml.kernel.org/r/1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com]

And updated version with typos fixed

From 63077ac611ff3f95afadf534902a8ab2984d5404 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 4 Jul 2018 14:31:46 +0200
Subject: [PATCH] memblock: do not complain about top-down allocations for
 !MEMORY_HOTREMOVE

Mike Rapoport is converting architectures from bootmem to nobootmem
allocator. While doing so for m68k Geert has noticed that he gets
a scary looking warning
WARNING: CPU: 0 PID: 0 at mm/memblock.c:230
memblock_find_in_range_node+0x11c/0x1be
memblock: bottom-up allocation failed, memory hotunplug may be affected
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted
4.18.0-rc3-atari-01343-gf2fb5f2e09a97a3c-dirty #7
Stack from 003c3e20:
        003c3e20 0039cf44 00023800 00433000 ffffffff 00001000 00240000 000238aa
        00378734 000000e6 004285ac 00000009 00000000 003c3e58 003787c0 003c3e74
        003c3ea4 004285ac 00378734 000000e6 003787c0 00000000 00000000 00000001
        00000000 00000010 00000000 00428490 003e3856 ffffffff ffffffff 003c3ed0
        00044620 003c3ee0 00417a10 00240000 00000010 00000000 00000000 00000001
        00000000 00000001 00240000 00000000 00000000 00000000 00001000 003e3856
Call Trace: [<00023800>] __warn+0xa8/0xc2
 [<00001000>] kernel_pg_dir+0x0/0x1000
 [<00240000>] netdev_lower_get_next+0x2/0x22
 [<000238aa>] warn_slowpath_fmt+0x2e/0x36
 [<004285ac>] memblock_find_in_range_node+0x11c/0x1be
 [<004285ac>] memblock_find_in_range_node+0x11c/0x1be
 [<00428490>] memblock_find_in_range_node+0x0/0x1be
 [<00044620>] vprintk_func+0x66/0x6e
 [<00417a10>] memblock_virt_alloc_internal+0xd0/0x156
 [<00240000>] netdev_lower_get_next+0x2/0x22
 [<00240000>] netdev_lower_get_next+0x2/0x22
 [<00001000>] kernel_pg_dir+0x0/0x1000
 [<00417b8c>] memblock_virt_alloc_try_nid_nopanic+0x58/0x7a
 [<00240000>] netdev_lower_get_next+0x2/0x22
 [<00001000>] kernel_pg_dir+0x0/0x1000
 [<00001000>] kernel_pg_dir+0x0/0x1000
 [<00010000>] EXPTBL+0x234/0x400
 [<00010000>] EXPTBL+0x234/0x400
 [<002f3644>] alloc_node_mem_map+0x4a/0x66
 [<00240000>] netdev_lower_get_next+0x2/0x22
 [<004155ca>] free_area_init_node+0xe2/0x29e
 [<00010000>] EXPTBL+0x234/0x400
 [<00411392>] paging_init+0x430/0x462
 [<00001000>] kernel_pg_dir+0x0/0x1000
 [<000427cc>] printk+0x0/0x1a
 [<00010000>] EXPTBL+0x234/0x400
 [<0041084c>] setup_arch+0x1b8/0x22c
 [<0040e020>] start_kernel+0x4a/0x40a
 [<0040d344>] _sinittext+0x344/0x9e8

The warning is basically saying that a top-down allocation can break
memory hotremove because memblock allocation is not movable. But m68k
doesn't even support MEMORY_HOTREMOVE so there is no point to warn
about it.

Make the warning conditional only to configurations that care.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memblock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 03d48d8835ba..2acec4033389 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -227,7 +227,8 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 		 * so we use WARN_ONCE() here to see the stack trace if
 		 * fail happens.
 		 */
-		WARN_ONCE(1, "memblock: bottom-up allocation failed, memory hotunplug may be affected\n");
+		WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
+					"memblock: bottom-up allocation failed, memory hotremove may be affected\n");
 	}
 
 	return __memblock_find_range_top_down(start, end, size, align, nid,
-- 
2.18.0

-- 
Michal Hocko
SUSE Labs
