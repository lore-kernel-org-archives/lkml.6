Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D32C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666C8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jaCwocTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfAIRgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:36:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37820 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAIRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:36:00 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so12193314iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUKfVyNlL9qZuc2QLDERIoYCjpm0wqKMkb6P4H4Z4a4=;
        b=jaCwocTt/bPE2YdhrAPxiUeNvnFkpM3FCu1zORaUkMPgY0me3m3AMXuRQN6t8JY42i
         /QzxphzoDqZfBSFP2A57JMII0J/PQgerGYgb8Lvm3K8Uize7LjeJCbhKhMzNIAH3+UrI
         CO73+b7WsFDYjKbFFBpUAm3JaVXU8J4eWAwpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUKfVyNlL9qZuc2QLDERIoYCjpm0wqKMkb6P4H4Z4a4=;
        b=rgggXJS7swoTZdcUSOj6uyNZZzNW7XHS3edShtU+2Nqif3THD5talVC00J5NIu125w
         1DVqouQ4RrJb4pefRzbwKjutZVzMkSDgLcE75Dm4cmq/uYFUm6Ho7f5FkBqC5rqyxBnr
         4VEry686bk6+9kGj5zH5N6kdfBViiSpYxF0zwMvJ7EEsJhELGV+jjqvPobvuQxRbHwnf
         bUEHOExoPBkWmPXGOrsVdg338a5Tu7fpey2UCbnB+fu2khEhz4B3YrpCxRfHUe7gguGA
         ZHjlD1BiFAiKOggzq0vNaFI3W2TOxG9lcgnDZLRuANCA0Ya7VKSiTpSYjjhUDVMtyAjV
         ahHA==
X-Gm-Message-State: AJcUukfy7n9d/Cv9QhtZf9IKQmj9jhMN2TCNTPPMKSrO+xsoWyhEpWam
        OGsPdjAuUePCCy7DYzZMEA+0ggcw3ENBFOOJPLiKhQ==
X-Google-Smtp-Source: ALg8bN4PMnH4wnbG62LXxjXudy5gKA4jiuVKyVy73xDWj+96zkkUWdgXgz2wVIoWxsxgMOu4xb+perGcTqXABCCaFCg=
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr4755784itl.51.1547055359510;
 Wed, 09 Jan 2019 09:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20190108112519.27473-1-kraxel@redhat.com> <20190108112519.27473-16-kraxel@redhat.com>
 <20190109101044.GS21184@phenom.ffwll.local> <20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
In-Reply-To: <20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Jan 2019 18:35:47 +0100
Message-ID: <CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 3:54 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jan 09, 2019 at 11:10:44AM +0100, Daniel Vetter wrote:
> > On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> > > The buffer object must be reserved before calling
> > > ttm_bo_validate for pinning/unpinning.
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Seems a bit a bisect fumble in your series here: legacy kms code reserved
> > the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
> > think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
> > avoid bisect fail I think you need to have these temporarily in your
> > cleanup/prepare_plane functions too.
>
> I think I've sorted that.  Have some other changes too, will probably
> send v3 tomorrow.
>
> > Looked through the entire series, this here is the only issue I think
> > should be fixed before merging (making atomic_enable optional can be done
> > as a follow-up if you feel like it). With that addressed on the series:
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Thanks.
>
> While being at it:  I'm also looking at dma-buf export and import
> support for the qemu drivers.
>
> Right now both qxl and virtio have gem_prime_get_sg_table and
> gem_prime_import_sg_table handlers which throw a WARN_ONCE() and return
> an error.
>
> If I understand things correctly it is valid to set all import/export
> callbacks (prime_handle_to_fd, prime_fd_to_handle,
> gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
> supporting dma-buf import/export and still advertise DRIVER_PRIME to
> indicate the other prime callbacks are supported (so generic fbdev
> emulation can use gem_prime_vmap etc).  Is that correct?

I'm not sure how much that's a good idea ... Never thought about it
tbh. All the fbdev/dma-buf stuff has plenty of hacks and
inconsistencies still, so I guess we can't make it much worse really.

> On exporting:
>
> TTM_PL_TT should be easy, just pin the buffer, grab the pages list and
> feed that into drm_prime_pages_to_sg.  Didn't try yet though.  Is that
> approach correct?
>
> Is it possible to export TTM_PL_VRAM objects (with backing storage being
> a pci memory bar)?  If so, how?

Not really in general. amdgpu upcasts to amdgpu_bo (if it's amgpu BO)
and then knows the internals so it can do a proper pci peer2peer
mapping. Or at least there's been lots of patches floating around to
make that happen.

I think other drivers migrate the bo out of VRAM.

> On importing:
>
> Importing into TTM_PL_TT object looks easy again, at least when the
> object is actually stored in RAM.  What if not?

They are all supposed to be stored in RAM. Note that all current ttm
importers totally break the abstraction, by taking the sg list,
throwing the dma mapping away and assuming there's a struct page
backing it. Would be good if we could stop spreading that abuse - the
dma-buf interfaces have been modelled after the ttm bo interfaces, so
shouldn't be too hard to wire this up correctly.

> Importing into TTM_PL_VRAM:  Impossible I think, without copying over
> the data.  Should that be done?  If so, how?  Or is it better to just
> not support import then?

Hm, since you ask about TTM concepts and not what this means in terms
of dma-buf: As long as you upcast to the ttm_bo you can do whatever
you want to really. But with plain dma-buf this doesn't work right now
(least because ttm assumes it gets system RAM on import, in theory you
could put the peer2peer dma mapping into the sg list and it should
work).
-Daniel

>
> thanks,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
