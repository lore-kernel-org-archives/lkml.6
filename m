Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BFBC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3632F223A9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3632F223A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeHJDjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:39:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeHJDjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:39:54 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8294D9D3;
        Fri, 10 Aug 2018 01:12:25 +0000 (UTC)
Date:   Thu, 9 Aug 2018 18:12:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     toshi.kani@hpe.com, tglx@linutronix.de, bp@suse.de,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        dan.j.williams@intel.com, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, malat@debian.org, bhelgaas@google.com,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rppt@linux.vnet.ibm.com
Subject: Re: [PATCH v3] resource: Merge resources on a node when hot-adding
 memory
Message-Id: <20180809181224.0b7417e51215565dbda9f665@linux-foundation.org>
In-Reply-To: <20180809025409.31552-1-rashmica.g@gmail.com>
References: <20180809025409.31552-1-rashmica.g@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Aug 2018 12:54:09 +1000 Rashmica Gupta <rashmica.g@gmail.com> wrote:

> When hot-removing memory release_mem_region_adjustable() splits
> iomem resources if they are not the exact size of the memory being
> hot-deleted. Adding this memory back to the kernel adds a new
> resource.
> 
> Eg a node has memory 0x0 - 0xfffffffff. Offlining and hot-removing
> 1GB from 0xf40000000 results in the single resource 0x0-0xfffffffff being
> split into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.
> 
> When we hot-add the memory back we now have three resources:
> 0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.
> 
> Now if we try to remove some memory that overlaps these resources,
> like 2GB from 0xf40000000, release_mem_region_adjustable() fails as it
> expects the chunk of memory to be within the boundaries of a single
> resource.
> 
> This patch adds a function request_resource_and_merge(). This is called
> instead of request_resource_conflict() when registering a resource in
> add_memory(). It calls request_resource_conflict() and if hot-removing is
> enabled (if it isn't we won't get resource fragmentation) we attempt to
> merge contiguous resources on the node.

What is the end-user impact of this patch?

Do you believe the fix should be merged into 4.18?  Backporting into
-stable kernels?  If so, why?

Thanks.
