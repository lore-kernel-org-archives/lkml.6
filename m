Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB755C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA922084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DuTlMrV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA922084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeLENyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:54:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeLENyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tX4Y9yN01q44Qpvl+qeo/BASivX6y01jxRNqPm4MzZU=; b=DuTlMrV5pCd8Fm6+Hm+0C2lHq
        m79KlL9ccjF22q+tUCTUq7igAnC3kbv9snkDjoGEtJIDxztoBNNco2HcwAzNvSCG6JO8pCRgdlBo2
        Weqym8geC2GV93P9yw0RzjwRYc02fpfGFmXcWSsCN56fDgBmU/EtgA0WKs1a4ExKCxPg5hZEmBYfo
        PUvwdBqhsYkqh+AJLCrmo+xQ6EOxvPLN2H4NtX6Y2YAGUxPSlcAYmL8tDL6oWI5WYr/waFt2hsR6d
        QgeAs/tdkuYf6BAifMLwjOzqKoXRXKqGGBML/wRkptZS69NkiKKt8aZUouUFX1F0n5MIb13x2KIWR
        mGnrcgurQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUXcs-0007xk-Bb; Wed, 05 Dec 2018 13:54:06 +0000
Date:   Wed, 5 Dec 2018 05:54:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
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
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Message-ID: <20181205135406.GA29031@infradead.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-4-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205054828.183476-4-drinkcat@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:48:28PM +0800, Nicolas Boichat wrote:
> IOMMUs using ARMv7 short-descriptor format require page tables
> (level 1 and 2) to be allocated within the first 4GB of RAM, even
> on 64-bit systems.

> +#ifdef CONFIG_ZONE_DMA32
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
> +#else
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
> +#endif

How does using GFP_DMA make sense based on the above?  If the system
has more than 32-bits worth of RAM it should be using GFP_DMA32, else
GFP_KERNEL, not GFP_DMA for an arch defined small addressability pool.
