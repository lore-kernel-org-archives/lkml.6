Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4847C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F7E2082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F7E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeLBEQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:16:24 -0500
Received: from verein.lst.de ([213.95.11.211]:56788 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeLBEQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:16:24 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BD4726732A; Sat,  1 Dec 2018 18:03:25 +0100 (CET)
Date:   Sat, 1 Dec 2018 18:03:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Message-ID: <20181201170325.GD20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-5-hch@lst.de> <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 07:05:23PM +0000, Robin Murphy wrote:
> It's a bit yuck that we now end up with arch_* hooks being a mix of arch 
> code and not-actually-arch-code, but I guess there's some hope of coming 
> back and streamlining things in future once all the big moves are done.

Yes, I hope we can use some form of common code here for most
architectures eventually.  But that will some time.

> I can't really be bothered to nitpick the typos above and the slight 
> inconsistencies in some of the cosmetic code changes, but one worthwhile 
> thing stands out...

I'm usually fine picking up nitpicks.  For now I'll apply the series
with the pointed out fixups, but if you want to send the fixups
I'd be glad.

>> +	val = gen_pool_alloc(atomic_pool, size);
>> +	if (val) {
>> +		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
>> +
>> +		*ret_page = phys_to_page(phys);
>
> Looks like phys_to_page() isn't particularly portable, so we probably want 
> an explicit pfn_to_page(__phys_to_pfn(phys)) here. Otherwise, the 
> fundamental refactoring looks OK.

Ok, I'll updated it.
