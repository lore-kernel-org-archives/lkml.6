Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4285C20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWkUOjDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4285C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392930AbeKVTCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:02:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeKVTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N78RD0fDMD9ZumajMmltGxJe9lJJI+9OMTunJ+nAHXE=; b=nWkUOjDm1IFY/HRfdmUMMNlIP
        50kfSaIEjvvAzIBUBierIqForfAkEDuZED9loTM+dyVq9cvA1L82I28APn3uSP2IsGnePMFYO8KoQ
        WwqgjBG79riwYkej+eVeQZeJghS+l9bVMARVF8Ebu6EPkOp3OT6w2AbZBOxWaZk/psiiVP9lT63xC
        7h6s2umK8d08OtifchSJp4s5P9MbH0yIMZIkyaGKJbHyWF66ii88VI9rnc9wC+YnOmVNPPQZkr3U9
        1F+fSk7Jlo8VOuTsbSQiszqLZSqhoS6jy/HsMgJIOV85iEhHbOtcAzXKWl4vIXO6eojf4HNzeKiYC
        0nu4Qxszg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPkGu-0001i5-Ij; Thu, 22 Nov 2018 08:23:36 +0000
Date:   Thu, 22 Nov 2018 00:23:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Michal Hocko <mhocko@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181122082336.GA2049@infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> TBH, if this DMA32 stuff is going to be contentious we could possibly just
> rip out the offending kmem_cache - it seemed like good practice for the
> use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> give the same 1KB alignment and chance of succeeding as the equivalent
> kmem_cache_alloc(), then we could quite easily make do with that instead.

Neither is the slab support for kmalloc, not do kmalloc allocations
have useful alignment apparently (at least if you use slub debug).

But I do agree with the sentiment of not wanting to spread GFP_DMA32
futher into the slab allocator.

I think you want a simple genalloc allocator for this rather special
use case.
