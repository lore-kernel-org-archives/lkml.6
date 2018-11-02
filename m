Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A7ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51DA2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYE1hVKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51DA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeKBM5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:57:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37081 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeKBM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:57:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so358325pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 20:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FsNk+2mtru0RBl4MF1bnphQrQ8mXFYh6ENJNQjXa8Sk=;
        b=cYE1hVKSgH7OBzSQWjxo0a1l08+UwepYyMbcfQ/o9xqOQevkumxnLBfZOEgg8Hhq7V
         K0wfUG316W6RZuMaP88MNHo1qvZz8Uwo+lgyUY/bNGLH2KymSdHVcMilqnecnYzkTXQQ
         NP728/eLyDEicT24TOTcRFWFyAr3B8cyitG0Z5MdRR1ztB9RWAMDxXRsZPevwPl6rtIT
         i00tzFRtd9HqvxJCtxGRTQbTl7vyZpC9SmGcCWaNMCqLXyEAO1+iLn4tESdnd0voNxUV
         pvy/SkrNY52AKQ2pZ41HxxjbcnMlmWKVQESV0BZ1AM3itzFMYNMPXT0Vuj+VtH/5R7mz
         3WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FsNk+2mtru0RBl4MF1bnphQrQ8mXFYh6ENJNQjXa8Sk=;
        b=N+LH33YigSrT5ZOe1aHlTYmMQAYk0CHGFaExZkQPXa2HkLfdrXZliHt20cYcAnmrqu
         SsBXYjXkfSeOpDuvoGKb3FpJI14F5l4LsKWum/nSdFWVOZ2umpU9o5/Ip8fCl1W7aFD3
         t/6KiRSYlzodcmsSru3P3H0/tYA0MTUdQUDmCmtRkVvOxrCIjUEiUf+mzsK6ELdVXiWo
         cbjFoTo0S3RtEUSYS1/Mz2u6Qqbc6Jdz7dMP3+Uq8ttNnKtZ0FPqecVN8EkgJOr8ymtY
         nRKpMVB/OaZ4xScVO4s3AxouMzpMgPcfbxTlM8uJodWcxuVxxMGhopLFMZ8jRELlG+Fu
         cPMg==
X-Gm-Message-State: AGRZ1gIavguoCsseYqDtvRAmQd5qU2toTV2yw8vUOZzbzacAsmnAwOIT
        +bYv+lz57H3tys0VNaV7XCo=
X-Google-Smtp-Source: AJdET5faCcs1ZbjZpBjN1SfPOG7W0it+gRW4CQ/WA1ErSiqltdmoleSoJ3uwq7bX+qc3EDXl6oKczQ==
X-Received: by 2002:a63:955a:: with SMTP id t26mr9604755pgn.449.1541130730320;
        Thu, 01 Nov 2018 20:52:10 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id s14-v6sm16759878pgk.39.2018.11.01.20.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 20:52:09 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:52:05 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memory_hotplug: cond_resched in __remove_pages
Message-ID: <20181102035205.GG16399@350D>
References: <20181031125840.23982-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031125840.23982-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:58:40PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have received a bug report that unbinding a large pmem (>1TB)
> can result in a soft lockup:
> [  380.339203] NMI watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [ndctl:4365]
> [...]
> [  380.339316] Supported: Yes
> [  380.339318] CPU: 9 PID: 4365 Comm: ndctl Not tainted 4.12.14-94.40-default #1 SLE12-SP4
> [  380.339318] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0833.051120182255 05/11/2018
> [  380.339319] task: ffff9cce7d4410c0 task.stack: ffffbe9eb1bc4000
> [  380.339325] RIP: 0010:__put_page+0x62/0x80
> [  380.339326] RSP: 0018:ffffbe9eb1bc7d30 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff10
> [  380.339327] RAX: 000040540081c0d3 RBX: ffffeb8f03557200 RCX: 000063af40000000
> [  380.339328] RDX: 0000000000000002 RSI: ffff9cce75bff498 RDI: ffff9e4a76072ff8
> [  380.339329] RBP: 0000000a43557200 R08: 0000000000000000 R09: ffffbe9eb1bc7bb0
> [  380.339329] R10: ffffbe9eb1bc7d08 R11: 0000000000000000 R12: ffff9e194a22a0e0
> [  380.339330] R13: ffff9cce7062fc10 R14: ffff9e194a22a0a0 R15: ffff9cce6559c0e0
> [  380.339331] FS:  00007fd132368880(0000) GS:ffff9cce7ea40000(0000) knlGS:0000000000000000
> [  380.339332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  380.339332] CR2: 00000000020820a0 CR3: 000000017ef7a003 CR4: 00000000007606e0
> [  380.339333] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  380.339334] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  380.339334] PKRU: 55555554
> [  380.339334] Call Trace:
> [  380.339338]  devm_memremap_pages_release+0x152/0x260
> [  380.339342]  release_nodes+0x18d/0x1d0
> [  380.339347]  device_release_driver_internal+0x160/0x210
> [  380.339350]  unbind_store+0xb3/0xe0
> [  380.339355]  kernfs_fop_write+0x102/0x180
> [  380.339358]  __vfs_write+0x26/0x150
> [  380.339363]  ? security_file_permission+0x3c/0xc0
> [  380.339364]  vfs_write+0xad/0x1a0
> [  380.339366]  SyS_write+0x42/0x90
> [  380.339370]  do_syscall_64+0x74/0x150
> [  380.339375]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [  380.339377] RIP: 0033:0x7fd13166b3d0
> 
> It has been reported on an older (4.12) kernel but the current upstream
> code doesn't cond_resched in the hot remove code at all and the given
> range to remove might be really large. Fix the issue by calling cond_resched
> once per memory section.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memory_hotplug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7e6509a53d79..1d87724fa558 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -587,6 +587,7 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
>  	for (i = 0; i < sections_to_remove; i++) {
>  		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
>  
> +		cond_resched();
>  		ret = __remove_section(zone, __pfn_to_section(pfn), map_offset,
>  				altmap);
>  		map_offset = 0;

Quick math tells me we're doing less than 44GiB's per second of offlining then?

Here is a quick untested patch that might help with the speed as well

In hot remove, we try to clear poisoned pages, but
a small optimization to check if num_poisoned_pages
is 0 helps remove the iteration through nr_pages.

NOTE: We can make num_poisoned_pages counter per
section and speed this up even more in case we
do have some poisoned pages

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 mm/sparse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 33307fc05c4d..c4280ef0f383 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -724,6 +724,9 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 	if (!memmap)
 		return;
 
+	if (atomic_long_read(&num_poisoned_pages) == 0)
+		return;
+
 	for (i = 0; i < nr_pages; i++) {
 		if (PageHWPoison(&memmap[i])) {
 			atomic_long_sub(1, &num_poisoned_pages);

Anyway for this patch:
Acked-by: Balbir Singh <bsingharora@gmail.com>
