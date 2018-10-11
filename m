Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4614C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8634020652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8634020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJKVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:04:46 -0400
Received: from verein.lst.de ([213.95.11.211]:42926 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJKVEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:04:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CB5BA68BFE; Thu, 11 Oct 2018 15:37:30 +0200 (CEST)
Date:   Thu, 11 Oct 2018 15:37:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Waterman <andrew@sifive.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>,
        Rob Herring <robh@kernel.org>, Zong Li <zong@andestech.com>
Subject: Re: [PATCH 5/5] RISC-V: Implement sparsemem
Message-ID: <20181011133730.GB7276@lst.de>
References: <20181005161642.2462-1-logang@deltatee.com> <20181005161642.2462-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005161642.2462-6-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Log2 of the upper bound of the size of a struct page. Used for sizing
> + * the vmemmap region only, does not affect actual memory footprint.
> + * We don't use sizeof(struct page) directly since taking its size here
> + * requires its definition to be available at this point in the inclusion
> + * chain, and it may not be a power of 2 in the first place.
> + */
> +#define STRUCT_PAGE_MAX_SHIFT	6

I know this is copied from arm64, but wouldn't this be a good time
to move this next to the struct page defintion?

Also this:

arch/arm64/mm/init.c:   BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));

should move to comment code (or would have to be duplicated for riscv)

> +#define VMEMMAP_SIZE	(UL(1) << (CONFIG_VA_BITS - PAGE_SHIFT - 1 + \
> +				   STRUCT_PAGE_MAX_SHIFT))

Might be more readable with a another define, and without abuse of the
horrible UL macro:

#define VMEMMAP_SHIFT \
	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
#define VMEMMAP_SIZE	(1UL << VMEMMAP_SHIFT)

> +#define VMEMMAP_END	(VMALLOC_START - 1)
> +#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
> +
> +#define vmemmap		((struct page *)VMEMMAP_START)

This could also use some comments..

> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_SPARSEMEM_H
> +#define __ASM_SPARSEMEM_H
> +
> +#ifdef CONFIG_SPARSEMEM
> +#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
> +#define SECTION_SIZE_BITS	30
> +#endif
> +
> +#endif

For potentially wide-spanning ifdefs like inclusion headers it always
is nice to have a comment with the symbol on the endif line.
