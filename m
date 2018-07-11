Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0649BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B386D208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B386D208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeGKKpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:45:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbeGKKpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:45:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE43E7C6CA;
        Wed, 11 Jul 2018 10:42:04 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7747A1C5A6;
        Wed, 11 Jul 2018 10:42:02 +0000 (UTC)
Date:   Wed, 11 Jul 2018 18:41:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        yasu.isimatu@gmail.com, keescook@chromium.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com, mhocko@suse.com, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180711104158.GE2070@MiWiFi-R3L-srv>
References: <20180711094244.GA2019@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711094244.GA2019@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 10:42:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 10:42:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 at 05:42pm, Chao Fan wrote:
> Hi all,
> 
> I found there is a BUG about KASLR and ZONE_MOVABLE.
> 
> When users use 'kernelcore=' parameter without 'movable_node',
> movable memory is evenly distributed to all nodes. The size of
> ZONE_MOVABLE depends on the kernel parameter 'kernelcore=' and
> 'movablecore='.
> But sometiomes, KASLR may put the uncompressed kernel to the
> tail position of a node, which will cause the kernel memory
> set as ZONE_MOVABLE. This region can not be offlined.
> 
> Here is a very simple test in my qemu-kvm machine, there is
> only one node:
> 
> The command line:
> [root@localhost ~]# cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-4.18.0-rc3+ root=/dev/mapper/fedora_localhost--live-root
> ro resume=/dev/mapper/fedora_localhost--live-swap
> rd.lvm.lv=fedora_localhost-live/root rd.lvm.lv=fedora_localhost-live/swap
> console=ttyS0 earlyprintk=ttyS0,115200n8 memblock=debug kernelcore=50%
> 
> I use 'kernelcore=50%' here.
> 
> Here is my early print result, I print the random_addr after KASLR chooses
> physical memory:
> early console in extract_kernel
> input_data: 0x000000000266b3b1
> input_len: 0x00000000007d8802
> output: 0x0000000001000000
> output_len: 0x0000000001e15698
> kernel_total_size: 0x0000000001a8b000
> trampoline_32bit: 0x000000000009d000
> booted via startup_32()
> Physical KASLR using RDRAND RDTSC...
> random_addr: 0x000000012f000000
> Virtual KASLR using RDRAND RDTSC...
> 
> The address for kernel is 0x000000012f000000
> 
> Here is the log of ZONE:
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001f57fffff]
> [    0.000000]   Device   empty
> [    0.000000] Movable zone start for each node
> [    0.000000]   Node 0: 0x000000011b000000
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x00000001f57fffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000000001000-0x00000001f57fffff]
> 
> Only one node in my machine, ZONE_MOVABLE begins from 0x000000011b000000,
> which is lower than 0x000000012f000000.
> So KASLR put the kernel to the ZONE_MOVABLE.
> Try to solve this problem, I think there should be a new tactic in function
> find_zone_movable_pfns_for_nodes() of mm/page_alloc.c. If kernel is uncompressed
> in a tail position, then just set the memory after the kernel as ZONE_MOVABLE,
> at the same time, memory in other nodes will be set as ZONE_MOVABLE.

Hmm, it's an issue, worth fixing it. Otherwise the size of
movable area will be smaller than we expect when add "kernel_core="
or "movable_core=".

Add a check in find_zone_movable_pfns_for_nodes(), and use min() to get
the starting address of movable area between aligned '_etext'
and start_pfn. It will go to label 'restart' to calculate the 2nd round
if not satisfiled. 

Hi Chao,

Could you check if below patch works for you?


From ab6e47c6a78d1a4ccb577b995b7b386f3149732f Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 Jul 2018 18:30:04 +0800
Subject: [PATCH] mm, page_alloc: find movable zone after kernel text

In find_zone_movable_pfns_for_nodes(), when try to find the starting
PFN movable zone begins in each node, kernel text position is not
considered. KASLR may put kernel after which movable zone begins.

Fix it by finding movable zone after kernel text.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100..fe346b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6678,6 +6678,8 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 			unsigned long size_pages;
 
 			start_pfn = max(start_pfn, zone_movable_pfn[nid]);
+			/* KASLR may put kernel after 'start_pfn', start after kernel */
+			start_pfn = max(start_pfn, PAGE_ALIGN(_etext));
 			if (start_pfn >= end_pfn)
 				continue;
 
-- 
2.1.0

