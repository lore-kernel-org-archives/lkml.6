Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4298AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEB121888
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB121888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeGCT5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:57:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeGCT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:57:24 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBE63AEF;
        Tue,  3 Jul 2018 19:57:23 +0000 (UTC)
Date:   Tue, 3 Jul 2018 12:57:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
Message-Id: <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
In-Reply-To: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jul 2018 20:05:06 +0300 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Most functions in memblock already use phys_addr_t to represent a physical
> address with __memblock_free_late() being an exception.
> 
> This patch replaces u64 with phys_addr_t in __memblock_free_late() and
> switches several format strings from %llx to %pa to avoid casting from
> phys_addr_t to u64.
>
> ...
> 
> @@ -1343,9 +1343,9 @@ void * __init memblock_virt_alloc_try_nid_raw(
>  {
>  	void *ptr;
>  
> -	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=0x%llx max_addr=0x%llx %pF\n",
> -		     __func__, (u64)size, (u64)align, nid, (u64)min_addr,
> -		     (u64)max_addr, (void *)_RET_IP_);
> +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pF\n",
> +		     __func__, (u64)size, (u64)align, nid, &min_addr,
> +		     &max_addr, (void *)_RET_IP_);
>  

Did you see all this checkpatch noise?

: WARNING: Deprecated vsprintf pointer extension '%pF' - use %pS instead
: #54: FILE: mm/memblock.c:1348:
: +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pF\n",
: +		     __func__, (u64)size, (u64)align, nid, &min_addr,
: +		     &max_addr, (void *)_RET_IP_);
: ...
: 

 * - 'S' For symbolic direct pointers (or function descriptors) with offset
 * - 's' For symbolic direct pointers (or function descriptors) without offset
 * - 'F' Same as 'S'
 * - 'f' Same as 's'

I'm not sure why or when all that happened.

I suppose we should do that as a separate patch sometime.
