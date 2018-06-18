Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF2EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EA020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EA020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935236AbeFRISj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:18:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935192AbeFRISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12A85C3C;
        Mon, 18 Jun 2018 08:18:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 080/279] powerpc/powernv/memtrace: Let the arch hotunplug code flush cache
Date:   Mon, 18 Jun 2018 10:11:05 +0200
Message-Id: <20180618080612.118612865@linuxfoundation.org>
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

From: Balbir Singh <bsingharora@gmail.com>

[ Upstream commit 7fd6641de28fe9b5bce0c38d2adee0a72a72619e ]

Don't do this via custom code, instead now that we have support in the
arch hotplug/hotunplug code, rely on those routines to do the right
thing.

The existing flush doesn't work because it uses ppc64_caches.l1d.size
instead of ppc64_caches.l1d.line_size.

Fixes: 9d5171a8f248 ("powerpc/powernv: Enable removal of memory for in memory tracing")
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/memtrace.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -82,19 +82,6 @@ static const struct file_operations memt
 	.open	= simple_open,
 };
 
-static void flush_memory_region(u64 base, u64 size)
-{
-	unsigned long line_size = ppc64_caches.l1d.size;
-	u64 end = base + size;
-	u64 addr;
-
-	base = round_down(base, line_size);
-	end = round_up(end, line_size);
-
-	for (addr = base; addr < end; addr += line_size)
-		asm volatile("dcbf 0,%0" : "=r" (addr) :: "memory");
-}
-
 static int check_memblock_online(struct memory_block *mem, void *arg)
 {
 	if (mem->state != MEM_ONLINE)
@@ -132,10 +119,6 @@ static bool memtrace_offline_pages(u32 n
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
 			  change_memblock_state);
 
-	/* RCU grace period? */
-	flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT),
-			    nr_pages << PAGE_SHIFT);
-
 	lock_device_hotplug();
 	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
 	unlock_device_hotplug();


