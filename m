Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF668C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D9720821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dI+r2Nk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D9720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbeKVNNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:13:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbeKVNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uJWuAiR0aKRNZpOKfCGpaBuWs/uQvQUdDOIk9CUm6n8=; b=dI+r2Nk4sjX8zZvgbHgK9wAnZ
        +tqq0iMlROZfVnDu9JCx/FwEMIXsBhRXd9FNRRaQCmeIiUAzwp5lKpyYvHTWS7vfhErVc4e8xNze3
        v9yY/HmqR7BP4IgLv68s0gUQu2VScIH+/+704DjLZwse6b08RicTufFhDGzDAVKM281zdn+/JapU/
        Ut+oBCUJcBS4XTD5BhIotY4RBQxAa3rysAHIPHySXq5ApDwxSI08lz0BQHRGTuGg7hdzp2hMy22/i
        zPsfjuaQhvxpLt44XpTE2FCz5mg1UxjT9dPBYnquC3ASSZBaXLLzX7tMNu/VfdjC8S1VovulXd9na
        ySYvofg6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeqU-0007gP-KM; Thu, 22 Nov 2018 02:35:58 +0000
Date:   Wed, 21 Nov 2018 18:35:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181122023558.GO3065@bombadil.infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> These are IOMMU page tables, rather than CPU ones, so we're already well
> outside arch code - indeed the original motivation of io-pgtable was to be
> entirely independent of the p*d types and arch-specific MM code (this Armv7
> short-descriptor format is already "non-native" when used by drivers in an
> arm64 kernel).

There was quite a lot of explanation missing from this patch description!

> There are various efficiency reasons for using regular kernel memory instead
> of coherent DMA allocations - for the most part it works well, we just have
> the odd corner case like this one where the 32-bit format gets used on
> 64-bit systems such that the tables themselves still need to be allocated
> below 4GB (although the final output address can point at higher memory by
> virtue of the IOMMU in question not implementing permissions and repurposing
> some of those PTE fields as extra address bits).
> 
> TBH, if this DMA32 stuff is going to be contentious we could possibly just
> rip out the offending kmem_cache - it seemed like good practice for the
> use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> give the same 1KB alignment and chance of succeeding as the equivalent
> kmem_cache_alloc(), then we could quite easily make do with that instead.

I think you should look at using the page_frag allocator here.  You can
use whatever GFP_DMA flags you like.
