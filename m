Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD38214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="WAYQm0ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD38214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbeKVExt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:53:49 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:34322 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbeKVExt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1542824303;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=TDS/KSSAe75SnjHwizG1Vlz0DTA4ie/UQ0Qa1GsDDmM=;
        b=WAYQm0lyvi/k9f4dHBbDYfMfTF3Do7Smj479B6r1Hq6BAPwU0mgCQBoGFGjOzrty
        r2uoytJPtyxTUJoSqPiHiXpG2pukBxezPBJ71FD8hZ46M/oLpBhTTnjbFPBQfXWc91v
        tI+iL+nldwVTJjGWilUO2XPZSVdtDEvi//yiQr5A=
Date:   Wed, 21 Nov 2018 18:18:23 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Will Deacon <will.deacon@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
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
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
In-Reply-To: <a034e2c3-8933-caba-a113-ca08372da2b9@arm.com>
Message-ID: <01000167377e99b6-10666044-2e7d-4af3-9cae-9db9c1a9b279-000000@email.amazonses.com>
References: <20181111090341.120786-1-drinkcat@chromium.org> <20181111090341.120786-4-drinkcat@chromium.org> <20181121164638.GD24883@arm.com> <01000167375a15f8-362aa1e2-cf01-49b5-92b5-f0a4efcca477-000000@email.amazonses.com>
 <a034e2c3-8933-caba-a113-ca08372da2b9@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.11.21-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Robin Murphy wrote:

> On 21/11/2018 17:38, Christopher Lameter wrote:
> > On Wed, 21 Nov 2018, Will Deacon wrote:
> >
> > > > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
> >
> > SLAB_CACHE_DMA32??? WTH is going on here? We are trying to get rid of
> > the dma slab array.
>
> See the previous two patches in this series. If there's already a (better) way
> to have a kmem_cache which allocates its backing pages with GFP_DMA32, please
> do let us know.

Was not cced on the whole patchset. Trying to find it. Its best to
allocate DMA memory through the page based allocation functions.
dma_alloc_coherent() and friends.

