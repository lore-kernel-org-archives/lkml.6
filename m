Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C619C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAC82133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeLSNOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:14:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLSNOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:14:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AEF1C074EF9;
        Wed, 19 Dec 2018 13:14:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D00D60198;
        Wed, 19 Dec 2018 13:14:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BDDC816E29; Wed, 19 Dec 2018 14:14:52 +0100 (CET)
Date:   Wed, 19 Dec 2018 14:14:52 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 19 Dec 2018 13:14:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > +    mapping = xen_obj->base.filp->f_mapping;
> > > +    mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);

> > Let's see if I understand what you're doing:
> > 
> > Here you say that the pages should be DMA accessible for devices that can
> > only see 4GB.
> 
> Yes, your understanding is correct. As we are a para-virtualized device we
> do not have strict requirements for 32-bit DMA. But, via dma-buf export,
> the buffer we create can be used by real HW, e.g. one can pass-through
> real HW devices into a guest domain and they can import our buffer (yes,
> they can be IOMMU backed and other conditions may apply).
> So, this is why we are limiting to DMA32 here, just to allow more possible
> use-cases

Sure this actually helps?  It's below 4G in guest physical address
space, so it can be backed by pages which are actually above 4G in host
physical address space ...

> > > +    if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > > +            DMA_BIDIRECTIONAL)) {
> > 
> > 
> > Are you using the DMA streaming API as a way to flush the caches?
> Yes
> > Does this mean that GFP_USER isn't making the buffer coherent?
> 
> No, it didn't help. I had a question [1] if there are any other better way
> to achieve the same, but didn't have any response yet. So, I implemented
> it via DMA API which helped.

set_pages_array_*() ?

See arch/x86/include/asm/set_memory.h

HTH,
  Gerd

