Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166A420864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KnK/Cswf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166A420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392974AbeKVTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:04:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeKVTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XW9l0J9+/u1CtTbGj4CdPF0IGOMeVGwu5iVHuX/8c5w=; b=KnK/CswfB/AnWnQICIUPVdvqQ
        rPaVNdVKB67jItg5DT2nj8eV1uQafOTjgV0sQktBmgdAS3FdnE87Lo9HX5MbBoQrUpLNrrA5ZCLQQ
        L7PfcBtKzd/u7pbTYKrOtoAEWk1IAUz1Y0Dj9bnRKyahyKqCL//Jmb8qUgENZSgvasQHxH0EAI0bO
        qGFMM3R25+MqOMGxLZc8E9jRrnPemUVWZCGpzENY8Yg+5DfPosnXrqOktbew1N1Mz4GEfyaX/s3Wh
        A/kObycgMPofIsEUzUTc5Q30mhea/KKsy4awKvkGY4jZNo5dQprRoxxx/DGUSYgX9x2sZr0MLI5pR
        ycjm/3gRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPkJG-0003Ug-Sd; Thu, 22 Nov 2018 08:26:02 +0000
Date:   Thu, 22 Nov 2018 00:26:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20181122082602.GB2049@infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122023558.GO3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122023558.GO3065@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 06:35:58PM -0800, Matthew Wilcox wrote:
> I think you should look at using the page_frag allocator here.  You can
> use whatever GFP_DMA flags you like.

So I actually tries to use page_frag to solve the XFS unaligned kmalloc
allocations problem, and I don't think it is the right hammer for this
nail (or any other nail outside of networking).

The problem with the page_frag allocator is that it never reuses
fragments returned to the page, but only only frees the page once all
fragments are freed.  This means that if you have some long(er) term
allocations you are effectively creating memory leaks.
