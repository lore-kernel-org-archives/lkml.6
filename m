Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171C6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A3820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mFHb07Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A3820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437534AbeKWB4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:56:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437521AbeKWB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nWrZgwa7r2a/FhuhYkmj1dUm7Z3eStSfH9e6ex5hZcc=; b=mFHb07TwwuWQZZvcDIZ2QSpbx
        ctkN27i19y2RPVd4QvnXxzOfzxqTCcTVX6+swAiw0S/vhF5qI8UQ5kYgdEXM8Lu0iIootX6fDxMxB
        svoQGiNDrzjAL/DukFJ8psp/TI+md80m7r8Dx5jvcuF3HnHTv5Xgez6rcBdbOLRQXvfQjyqOrCPLC
        Ea536gR4a6AMuLbzWYdui2opM8o3GlLoPM6xq6s5Bja56tL8UOk0qJuZHUL+/ZeI4THy5rLoZZhLT
        nDXnX9A+XAYYjhec5BXljOox2eKOCBAItaKAUBC4k7cztoFU+2zqr6t46wTwZUGNNjsw1RK/cknsh
        FAocP1jHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPqiW-0000Ck-CM; Thu, 22 Nov 2018 15:16:32 +0000
Date:   Thu, 22 Nov 2018 07:16:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Will Deacon <will.deacon@arm.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        linux-mm@kvack.org, Christopher Lameter <cl@linux.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Huaisheng Ye <yehs1@lenovo.com>,
        David Rientjes <rientjes@google.com>,
        yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>,
        Tomasz Figa <tfiga@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181122151632.GP3065@bombadil.infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122023558.GO3065@bombadil.infradead.org>
 <20181122082602.GB2049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122082602.GB2049@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:26:02AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 21, 2018 at 06:35:58PM -0800, Matthew Wilcox wrote:
> > I think you should look at using the page_frag allocator here.  You can
> > use whatever GFP_DMA flags you like.
> 
> So I actually tries to use page_frag to solve the XFS unaligned kmalloc
> allocations problem, and I don't think it is the right hammer for this
> nail (or any other nail outside of networking).
> 
> The problem with the page_frag allocator is that it never reuses
> fragments returned to the page, but only only frees the page once all
> fragments are freed.  This means that if you have some long(er) term
> allocations you are effectively creating memory leaks.

Yes, your allocations from the page_frag allocator have to have similar
lifetimes.  I thought that would be ideal for XFS though; as I understood
the problem, these were per-IO allocations, and IOs to the same filesystem
tend to take roughly the same amount of time.  Sure, in an error case,
some IOs will take a long time before timing out, but it should be OK
to have pages unavailable during that time in these rare situations.
What am I missing?
