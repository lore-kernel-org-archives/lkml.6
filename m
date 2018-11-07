Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC3AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B5C2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B5C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeKHFoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:44:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKHFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:44:05 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17165AF7;
        Wed,  7 Nov 2018 20:12:09 +0000 (UTC)
Date:   Wed, 7 Nov 2018 12:12:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
Message-Id: <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
In-Reply-To: <20181107173859.24096-3-logang@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
        <20181107173859.24096-3-logang@deltatee.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 10:38:59 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:

> Presently the arches arm64, arm and sh have a function which loops through
> each memblock and calls memory present. riscv will require a similar
> function.
> 
> Introduce a common memblocks_present() function that can be used by
> all the arches. Subsequent patches will cleanup the arches that
> make use of this.
> 
> ...
>
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -239,6 +239,17 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
>  	}
>  }
>  
> +void __init memblocks_present(void)
> +{
> +	struct memblock_region *reg;
> +
> +	for_each_memblock(memory, reg) {
> +		memory_present(memblock_get_region_node(reg),
> +			       memblock_region_memory_base_pfn(reg),
> +			       memblock_region_memory_end_pfn(reg));
> +	}
> +}
> +

I don't like the name much.  To me, memblocks_present means "are
memblocks present" whereas this actually means "memblocks are present".
But whatever.  A little covering comment which describes what this
does and why it does it would be nice.

Acked-by: Andrew Morton <akpm@linux-foundation.org>

I can grab both patches and shall sneak them into 4.20-rcX, but feel
free to merge them into some git tree if you'd prefer.  If I see them
turn up in linux-next I shall drop my copy.

