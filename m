Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DABECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDB120868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDB120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJZVVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:21:55 -0400
Received: from verein.lst.de ([213.95.11.211]:36659 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeJZVVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:21:55 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 49A0468C93; Fri, 26 Oct 2018 14:44:55 +0200 (CEST)
Date:   Fri, 26 Oct 2018 14:44:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] arm64: use the generic swiotlb_dma_ops
Message-ID: <20181026124455.GA28571@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-11-hch@lst.de> <738dfd71-f78b-1d73-712c-73a4b6d4141c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738dfd71-f78b-1d73-712c-73a4b6d4141c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:52:51PM +0100, Robin Murphy wrote:
>> scatterlist *sgl,
>> -				  int nelems, enum dma_data_direction dir,
>> -				  unsigned long attrs)
>> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
>
> I realise I'm spotting this a bit late, but does this interface really need 
> somewhat-atypical signed PFNs?

It has been a while since I wrote this code, and I can't remember the
reason for it except that I'm pretty sure I copy and pasted it from
existing code somewhere.

Switching it to unsigned long should be fine, and patches are welcome.

>> +static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
>> +				      struct page *page, size_t size)
>
> If __iommu_get_sgtable() is now the only user, I'd say just inline these 
> remnants there (or let that case call dma_common_sgtable() if that's what 
> swiotlb_dma_ops are now relying on). Either way the "__swiotlb" is now a 
> complete misnomer.

It is.  But we hopefully kill both the only user and this helper in
the 4.21 merge window when moving the iommu dma api wrappers to common
code.
