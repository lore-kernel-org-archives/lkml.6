Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967623AbeEXM6C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:58:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39753 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964789AbeEXM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:58:01 -0400
X-Google-Smtp-Source: AB8JxZoPgNLvXuHiseS7cvk7TqDnVOg3LSP22Q5zBSqKyNu8xv87bjVNZUc5kD7Dm5l97RwKZTuQxg==
Date: Thu, 24 May 2018 14:57:56 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] gpu: drm: vgem: Change return type to vm_fault_t
Message-ID: <20180524125756.GO3438@phenom.ffwll.local>
Mail-Followup-To: Souptick Joarder <jrdr.linux@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org
References: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
 <CAFqt6zZ6VaPXoPs+3exLjNZ6yzS=v9=2TMXdFqHf_Zv5zEvSAA@mail.gmail.com>
 <20180510185138.GL33053@art_vandelay>
 <20180514162617.GD28661@phenom.ffwll.local>
 <CAFqt6zZ+ExTFKmzRycJiSW-u718pbGm1Ute+1UXF2NPn1WpLfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZ+ExTFKmzRycJiSW-u718pbGm1Ute+1UXF2NPn1WpLfA@mail.gmail.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 03:05:35PM +0530, Souptick Joarder wrote:
> On Mon, May 14, 2018 at 9:56 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, May 10, 2018 at 02:51:38PM -0400, Sean Paul wrote:
> >> On Thu, May 10, 2018 at 07:58:11PM +0530, Souptick Joarder wrote:
> >> > Hi Sean,
> >> >
> >> > On Mon, Apr 16, 2018 at 8:32 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> > > Use new return type vm_fault_t for fault handler.
> >> > >
> >> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> > > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> >> > > ---
> >> > >  drivers/gpu/drm/vgem/vgem_drv.c | 5 ++---
> >> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> >> > >
> >> > > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> >> > > index 2524ff1..c64a859 100644
> >> > > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> >> > > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> >> > > @@ -61,13 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
> >> > >         kfree(vgem_obj);
> >> > >  }
> >> > >
> >> > > -static int vgem_gem_fault(struct vm_fault *vmf)
> >> > > +static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
> >> > >  {
> >> > >         struct vm_area_struct *vma = vmf->vma;
> >> > >         struct drm_vgem_gem_object *obj = vma->vm_private_data;
> >> > >         /* We don't use vmf->pgoff since that has the fake offset */
> >> > >         unsigned long vaddr = vmf->address;
> >> > > -       int ret;
> >> > > +       vm_fault_t ret = VM_FAULT_SIGBUS;
> >> > >         loff_t num_pages;
> >> > >         pgoff_t page_offset;
> >> > >         page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
> >> > > @@ -77,7 +77,6 @@ static int vgem_gem_fault(struct vm_fault *vmf)
> >> > >         if (page_offset > num_pages)
> >> > >                 return VM_FAULT_SIGBUS;
> >> > >
> >> > > -       ret = -ENOENT;
> >> > >         mutex_lock(&obj->pages_lock);
> >> > >         if (obj->pages) {
> >> > >                 get_page(obj->pages[page_offset]);
> >> > > --
> >> > > 1.9.1
> >> > >
> >> >
> >> > Any further comment on this patch ?
> >>
> >> Patch looks good to me. My build test fails, though, since vm_fault_t doesn't
> >> exist in drm-misc-next yet.
> >
> > vm_fault_t is already in upstream, just needs Maarten to do a backmerge.
> > Which I think he's done by now ... Otherwise nag him more :-)
> > -Daniel
> >
> >>
> >> So, for now,
> >>
> >> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> >>
> >>
> >> --
> >> Sean Paul, Software Engineer, Google / Chromium OS
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> Daniel/ Sean, is this patch already merged for 4.18 ?

Nope, fell through the cracks. Thanks for the reminder, queued for 4.18
now.
-Daniel

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
