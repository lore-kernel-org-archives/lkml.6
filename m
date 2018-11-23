Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E1920685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E1920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504283AbeKWXOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:14:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394437AbeKWXOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:14:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE306AF6F;
        Fri, 23 Nov 2018 12:30:41 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:30:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181123123040.GH8625@dhcp22.suse.cz>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org>
 <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 13:23:41, Vlastimil Babka wrote:
> On 11/22/18 9:23 AM, Christoph Hellwig wrote:
[...]
> > But I do agree with the sentiment of not wanting to spread GFP_DMA32
> > futher into the slab allocator.
> 
> I don't see a problem with GFP_DMA32 for custom caches. Generic
> kmalloc() would be worse, since it would have to create a new array of
> kmalloc caches. But that's already ruled out due to the alignment.

Yes that makes quite a lot of sense to me. We do not really need a
generic support. Just make sure that if somebody creates a GFP_DMA32
restricted cache then allow allocating restricted memory from that.

Is there any fundamental reason that this wouldn't be possible?
-- 
Michal Hocko
SUSE Labs
