Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF417C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A753218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeLSOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:10:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbeLSOKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78DFA4E33B;
        Wed, 19 Dec 2018 14:10:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 141CF17F43;
        Wed, 19 Dec 2018 14:10:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1E10A16E29; Wed, 19 Dec 2018 15:10:00 +0100 (CET)
Date:   Wed, 19 Dec 2018 15:10:00 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181219141000.k426c7o6ncsdzrn5@sirius.home.kraxel.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
 <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
 <dd166576-6771-a03f-bdee-ef798f789aed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd166576-6771-a03f-bdee-ef798f789aed@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 19 Dec 2018 14:10:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Sure this actually helps?  It's below 4G in guest physical address
> > space, so it can be backed by pages which are actually above 4G in host
> > physical address space ...
> 
> Yes, you are right here. This is why I wrote about the IOMMU
> and other conditions. E.g. you can have a device which only
> expects 32-bit, but thanks to IOMMU it can access pages above
> 4GiB seamlessly. So, this is why I *hope* that this code *may* help
> such devices. Do you think I don't need that and have to remove?

I would try without that, and maybe add a runtime option (module
parameter) later if it turns out some hardware actually needs that.
Devices which can do 32bit DMA only become less and less common these
days.

> > > > > +    if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > > > > +            DMA_BIDIRECTIONAL)) {
> > > > 
> > > > Are you using the DMA streaming API as a way to flush the caches?
> > > Yes
> > > > Does this mean that GFP_USER isn't making the buffer coherent?
> > > No, it didn't help. I had a question [1] if there are any other better way
> > > to achieve the same, but didn't have any response yet. So, I implemented
> > > it via DMA API which helped.
> > set_pages_array_*() ?
> > 
> > See arch/x86/include/asm/set_memory.h
> Well, x86... I am on arm which doesn't define that...

Oh, arm.  Maybe ask on a arm list then.  I know on arm you have to care
about caching a lot more, but that also is where my knowledge ends ...

Using dma_map_sg for cache flushing looks like a sledge hammer approach
to me.  But maybe it is needed to make xen flush the caches (xen guests
have their own dma mapping implementation, right?  Or is this different
on arm than on x86?).

cheers,
  Gerd

