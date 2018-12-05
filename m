Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D7206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02D7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeLELh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:37:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:33296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeLELh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:37:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35203B07E;
        Wed,  5 Dec 2018 11:37:24 +0000 (UTC)
Date:   Wed, 5 Dec 2018 12:37:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
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
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
Message-ID: <20181205113722.GG1286@dhcp22.suse.cz>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
 <20181205095557.GE1286@dhcp22.suse.cz>
 <CANMq1KCnpSUKoz83LcEgAkhCi8QVPH715xtgdQD23r-tYusrPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KCnpSUKoz83LcEgAkhCi8QVPH715xtgdQD23r-tYusrPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 19:01:03, Nicolas Boichat wrote:
[...]
> > Secondly, why do we need a new sysfs file? Who is going to consume it?
> 
> We have cache_dma, so it seems consistent to add cache_dma32.

I wouldn't copy a pattern unless there is an explicit usecase for it.
We do expose way too much to userspace and that keeps kicking us later.
Not that I am aware of any specific example for cache_dma but seeing
other examples I would rather be more careful.

> I wasn't aware of tools/vm/slabinfo.c, so I can add support for
> cache_dma32 in a follow-up patch. Any other user I should take care
> of?

In general zones are inernal MM implementation details and the less we
export to userspace the better.

> > Then why do we need SLAB_MERGE_SAME to cover GFP_DMA32 as well?
> 
> SLAB_MERGE_SAME tells us which flags _need_ to be the same for the
> slabs to be merged. We don't want slab caches with GFP_DMA32 and
> ~GFP_DMA32 to be merged, so it should be in there.
> (https://elixir.bootlin.com/linux/v4.19.6/source/mm/slab_common.c#L342).

Ohh, my bad, I have misread the change. Sure we definitely not want to
allow merging here. My bad.
-- 
Michal Hocko
SUSE Labs
