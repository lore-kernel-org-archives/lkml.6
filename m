Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbeEWJfn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:35:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37583 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeEWJfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:35:37 -0400
X-Google-Smtp-Source: AB8JxZq8xe5THlrlEsLjh7IlRLonOOJtLfBwDNt7i4vmU9ggl0k92NJ3CuLrXq65BbcioB6aqaJQ2JOOo9v2eN6V0JU=
MIME-Version: 1.0
In-Reply-To: <20180514162617.GD28661@phenom.ffwll.local>
References: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
 <CAFqt6zZ6VaPXoPs+3exLjNZ6yzS=v9=2TMXdFqHf_Zv5zEvSAA@mail.gmail.com>
 <20180510185138.GL33053@art_vandelay> <20180514162617.GD28661@phenom.ffwll.local>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 23 May 2018 15:05:35 +0530
Message-ID: <CAFqt6zZ+ExTFKmzRycJiSW-u718pbGm1Ute+1UXF2NPn1WpLfA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: vgem: Change return type to vm_fault_t
To: Sean Paul <seanpaul@chromium.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 9:56 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, May 10, 2018 at 02:51:38PM -0400, Sean Paul wrote:
>> On Thu, May 10, 2018 at 07:58:11PM +0530, Souptick Joarder wrote:
>> > Hi Sean,
>> >
>> > On Mon, Apr 16, 2018 at 8:32 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> > > Use new return type vm_fault_t for fault handler.
>> > >
>> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> > > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> > > ---
>> > >  drivers/gpu/drm/vgem/vgem_drv.c | 5 ++---
>> > >  1 file changed, 2 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
>> > > index 2524ff1..c64a859 100644
>> > > --- a/drivers/gpu/drm/vgem/vgem_drv.c
>> > > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
>> > > @@ -61,13 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
>> > >         kfree(vgem_obj);
>> > >  }
>> > >
>> > > -static int vgem_gem_fault(struct vm_fault *vmf)
>> > > +static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
>> > >  {
>> > >         struct vm_area_struct *vma = vmf->vma;
>> > >         struct drm_vgem_gem_object *obj = vma->vm_private_data;
>> > >         /* We don't use vmf->pgoff since that has the fake offset */
>> > >         unsigned long vaddr = vmf->address;
>> > > -       int ret;
>> > > +       vm_fault_t ret = VM_FAULT_SIGBUS;
>> > >         loff_t num_pages;
>> > >         pgoff_t page_offset;
>> > >         page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
>> > > @@ -77,7 +77,6 @@ static int vgem_gem_fault(struct vm_fault *vmf)
>> > >         if (page_offset > num_pages)
>> > >                 return VM_FAULT_SIGBUS;
>> > >
>> > > -       ret = -ENOENT;
>> > >         mutex_lock(&obj->pages_lock);
>> > >         if (obj->pages) {
>> > >                 get_page(obj->pages[page_offset]);
>> > > --
>> > > 1.9.1
>> > >
>> >
>> > Any further comment on this patch ?
>>
>> Patch looks good to me. My build test fails, though, since vm_fault_t doesn't
>> exist in drm-misc-next yet.
>
> vm_fault_t is already in upstream, just needs Maarten to do a backmerge.
> Which I think he's done by now ... Otherwise nag him more :-)
> -Daniel
>
>>
>> So, for now,
>>
>> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>>
>>
>> --
>> Sean Paul, Software Engineer, Google / Chromium OS
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Daniel/ Sean, is this patch already merged for 4.18 ?
