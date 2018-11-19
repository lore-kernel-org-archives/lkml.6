Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E083DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A823D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9p87JII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A823D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeKTC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbeKTC5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2091F2086A;
        Mon, 19 Nov 2018 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645179;
        bh=1ktZqE/eu1PtDfSWIKXOWkTAPuxieXJ9vrz522wLP+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9p87JIIXf5n8DOMmaj/7DDHr5yk7acfKFrUUVGA51FNsW0FaTQmkCS0p0iBfu1HM
         sqO3S9vLu7euhmmU0si2N/aXYedioe0I913YdTttVOgWhXBSnG1zY/5PVtA8ILfzxC
         snjoVN6EGLUEUiLrUZixeWYot+OQs82TSiLQL+c4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/205] powerpc/memtrace: Remove memory in chunks
Date:   Mon, 19 Nov 2018 17:25:34 +0100
Message-Id: <20181119162622.367970245@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rashmica Gupta <rashmica.g@gmail.com>

[ Upstream commit 3f7daf3d7582dc6628ac40a9045dd1bbd80c5f35 ]

When hot-removing memory release_mem_region_adjustable() splits iomem
resources if they are not the exact size of the memory being
hot-deleted. Adding this memory back to the kernel adds a new resource.

Eg a node has memory 0x0 - 0xfffffffff. Hot-removing 1GB from
0xf40000000 results in the single resource 0x0-0xfffffffff being split
into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.

When we hot-add the memory back we now have three resources:
0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.

This is an issue if we try to remove some memory that overlaps
resources. Eg when trying to remove 2GB at address 0xf40000000,
release_mem_region_adjustable() fails as it expects the chunk of memory
to be within the boundaries of a single resource. We then get the
warning: "Unable to release resource" and attempting to use memtrace
again gives us this error: "bash: echo: write error: Resource
temporarily unavailable"

This patch makes memtrace remove memory in chunks that are always the
same size from an address that is always equal to end_of_memory -
n*size, for some n. So hotremoving and hotadding memory of different
sizes will now not attempt to remove memory that spans multiple
resources.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/memtrace.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -90,17 +90,15 @@ static bool memtrace_offline_pages(u32 n
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
 			  change_memblock_state);
 
-	lock_device_hotplug();
-	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
-	unlock_device_hotplug();
 
 	return true;
 }
 
 static u64 memtrace_alloc_node(u32 nid, u64 size)
 {
-	u64 start_pfn, end_pfn, nr_pages;
+	u64 start_pfn, end_pfn, nr_pages, pfn;
 	u64 base_pfn;
+	u64 bytes = memory_block_size_bytes();
 
 	if (!node_spanned_pages(nid))
 		return 0;
@@ -113,8 +111,21 @@ static u64 memtrace_alloc_node(u32 nid,
 	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
 
 	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
-		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true)
+		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true) {
+			/*
+			 * Remove memory in memory block size chunks so that
+			 * iomem resources are always split to the same size and
+			 * we never try to remove memory that spans two iomem
+			 * resources.
+			 */
+			lock_device_hotplug();
+			end_pfn = base_pfn + nr_pages;
+			for (pfn = base_pfn; pfn < end_pfn; pfn += bytes>> PAGE_SHIFT) {
+				remove_memory(nid, pfn << PAGE_SHIFT, bytes);
+			}
+			unlock_device_hotplug();
 			return base_pfn << PAGE_SHIFT;
+		}
 	}
 
 	return 0;


