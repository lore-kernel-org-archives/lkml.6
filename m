Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A92206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfAIOyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:54:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2403 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfAIOyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:54:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5879EC07015A;
        Wed,  9 Jan 2019 14:54:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2527608DD;
        Wed,  9 Jan 2019 14:54:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D664C16E03; Wed,  9 Jan 2019 15:54:43 +0100 (CET)
Date:   Wed, 9 Jan 2019 15:54:43 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Message-ID: <20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
References: <20190108112519.27473-1-kraxel@redhat.com>
 <20190108112519.27473-16-kraxel@redhat.com>
 <20190109101044.GS21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109101044.GS21184@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 14:54:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:10:44AM +0100, Daniel Vetter wrote:
> On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> > The buffer object must be reserved before calling
> > ttm_bo_validate for pinning/unpinning.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Seems a bit a bisect fumble in your series here: legacy kms code reserved
> the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
> think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
> avoid bisect fail I think you need to have these temporarily in your
> cleanup/prepare_plane functions too.

I think I've sorted that.  Have some other changes too, will probably
send v3 tomorrow.

> Looked through the entire series, this here is the only issue I think
> should be fixed before merging (making atomic_enable optional can be done
> as a follow-up if you feel like it). With that addressed on the series:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks.

While being at it:  I'm also looking at dma-buf export and import
support for the qemu drivers.

Right now both qxl and virtio have gem_prime_get_sg_table and
gem_prime_import_sg_table handlers which throw a WARN_ONCE() and return
an error.

If I understand things correctly it is valid to set all import/export
callbacks (prime_handle_to_fd, prime_fd_to_handle,
gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
supporting dma-buf import/export and still advertise DRIVER_PRIME to
indicate the other prime callbacks are supported (so generic fbdev
emulation can use gem_prime_vmap etc).  Is that correct?

On exporting:

TTM_PL_TT should be easy, just pin the buffer, grab the pages list and
feed that into drm_prime_pages_to_sg.  Didn't try yet though.  Is that
approach correct?

Is it possible to export TTM_PL_VRAM objects (with backing storage being
a pci memory bar)?  If so, how?

On importing:

Importing into TTM_PL_TT object looks easy again, at least when the
object is actually stored in RAM.  What if not?

Importing into TTM_PL_VRAM:  Impossible I think, without copying over
the data.  Should that be done?  If so, how?  Or is it better to just
not support import then?

thanks,
  Gerd

