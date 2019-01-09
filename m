Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D444DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D3721738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfAIUwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:52:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfAIUwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:52:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4102381F0E;
        Wed,  9 Jan 2019 20:52:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853875C57A;
        Wed,  9 Jan 2019 20:51:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BA42016E03; Wed,  9 Jan 2019 21:51:58 +0100 (CET)
Date:   Wed, 9 Jan 2019 21:51:58 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Message-ID: <20190109205158.qx7a2gfyprbvpok5@sirius.home.kraxel.org>
References: <20190108112519.27473-1-kraxel@redhat.com>
 <20190108112519.27473-16-kraxel@redhat.com>
 <20190109101044.GS21184@phenom.ffwll.local>
 <20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
 <CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 09 Jan 2019 20:52:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > If I understand things correctly it is valid to set all import/export
> > callbacks (prime_handle_to_fd, prime_fd_to_handle,
> > gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
> > supporting dma-buf import/export and still advertise DRIVER_PRIME to
> > indicate the other prime callbacks are supported (so generic fbdev
> > emulation can use gem_prime_vmap etc).  Is that correct?
> 
> I'm not sure how much that's a good idea ... Never thought about it
> tbh. All the fbdev/dma-buf stuff has plenty of hacks and
> inconsistencies still, so I guess we can't make it much worse really.

Setting prime_handle_to_fd + prime_fd_to_handle to NULL has the effect
that drm stops advertising DRM_PRIME_CAP_{IMPORT,EXPORT} to userspace.

Which looks better to me than telling userspace we support it then throw
errors unconditionally when userspace tries to use that.

> > Is it possible to export TTM_PL_VRAM objects (with backing storage being
> > a pci memory bar)?  If so, how?
> 
> Not really in general. amdgpu upcasts to amdgpu_bo (if it's amgpu BO)
> and then knows the internals so it can do a proper pci peer2peer
> mapping. Or at least there's been lots of patches floating around to
> make that happen.

That is limited to bo sharing between two amdgpu devices, correct?

> I think other drivers migrate the bo out of VRAM.

Well, that doesn't look too useful.  bochs and qxl virtual hardware
can't access buffers outside VRAM.  So, while I could migrate the
buffers to RAM (via memcpy) when exporting they would at the same time
become unusable for the GPU ...

> > On importing:
> >
> > Importing into TTM_PL_TT object looks easy again, at least when the
> > object is actually stored in RAM.  What if not?
> 
> They are all supposed to be stored in RAM. Note that all current ttm
> importers totally break the abstraction, by taking the sg list,
> throwing the dma mapping away and assuming there's a struct page
> backing it. Would be good if we could stop spreading that abuse - the
> dma-buf interfaces have been modelled after the ttm bo interfaces, so
> shouldn't be too hard to wire this up correctly.

Ok.  With virtio-gpu (where objects are backed by RAM pages anyway)
wiring this up should be easy.

But given there is no correct sample code I can look at it would be cool
if you could give some more hints how this is supposed to work.  The
gem_prime_import_sg_table() callback gets a sg list passed in after all,
so I probably would have tried to take the sg list too ...

> > Importing into TTM_PL_VRAM:  Impossible I think, without copying over
> > the data.  Should that be done?  If so, how?  Or is it better to just
> > not support import then?
> 
> Hm, since you ask about TTM concepts and not what this means in terms
> of dma-buf:

Ok, more details on the quesion:

dma-buf: whatever the driver gets passed into the
gem_prime_import_sg_table() callback.

import into TTM_PL_VRAM: qemu driver which supports VRAM storage only
(bochs, qxl), so the buffer has to be stored there if we want do
something with it (like scanning out to a crtc).

> As long as you upcast to the ttm_bo you can do whatever
> you want to really.

Well, if the dma-buf comes from another device (say export vgem bo, then
try import into bochs/qxl/virtio) I can't upcast.

When the dma-buf comes from the same device drm_gem_prime_import_dev()
will notice and take a shortcut (skip import, just increase refcount
instead), so I don't have to worry about that case in the
gem_prime_import_sg_table() callback.

> But with plain dma-buf this doesn't work right now
> (least because ttm assumes it gets system RAM on import, in theory you
> could put the peer2peer dma mapping into the sg list and it should
> work).

Well, qemu display devices don't have peer2peer dma support.
So I guess the answer is "doesn't work".

cheers,
  Gerd

