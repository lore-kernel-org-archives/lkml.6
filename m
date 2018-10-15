Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2017BC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E82A20876
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E82A20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJOIwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:52:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:45629 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeJOIwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:52:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9F0lDBk027228;
        Sun, 14 Oct 2018 19:47:15 -0500
Message-ID: <9cfe508c687068853a6e5e030962a78467a8d313.camel@kernel.crashing.org>
Subject: Re: [PATCH 01/33] powerpc: use mm zones more sensibly
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Oct 2018 11:47:13 +1100
In-Reply-To: <20181009132500.17643-2-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
         <20181009132500.17643-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 15:24 +0200, Christoph Hellwig wrote:
>   * Find the least restrictive zone that is entirely below the
> @@ -324,11 +305,14 @@ void __init paging_init(void)
>         printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>                (long int)((top_of_ram - total_ram) >> 20));
>  
> +#ifdef CONFIG_ZONE_DMA
> +       max_zone_pfns[ZONE_DMA] = min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
> +#endif
> +       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
> -       limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
> +       max_zone_pfns[ZONE_HIGHMEM] = max_pfn
                                               ^
Missing a  ";" here  --------------------------|

Sorry ... works with that fix on an old laptop with highmem.

>  #endif
> -       limit_zone_pfn(TOP_ZONE, top_of_ram >> PAGE_SHIFT);
> -       zone_limits_final = true;
> +
>         free_area_init_nodes(max_zone_pfns);
>  

