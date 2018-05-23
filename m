Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754586AbeEWItM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:49:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35149 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754341AbeEWItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:49:08 -0400
X-Google-Smtp-Source: AB8JxZrvMw7Y4lcONrZXYBw0SIC8HC0v3XWZoJBzgDmPnK2Vcmx23RUSn0BRWMYVlqmpKd67r4rHOg==
Date: Wed, 23 May 2018 10:49:04 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: airlied@redhat.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Cihangir =?iso-8859-1?Q?Akt=FCrk?= <cakturk@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Hocko <mhocko@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] gpu: drm: udl: Adding new typedef vm_fault_t
Message-ID: <20180523084904.GN3438@phenom.ffwll.local>
Mail-Followup-To: Souptick Joarder <jrdr.linux@gmail.com>,
        airlied@redhat.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Cihangir =?iso-8859-1?Q?Akt=FCrk?= <cakturk@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, Michal Hocko <mhocko@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20180425045922.GA21590@jordon-HP-15-Notebook-PC>
 <CAFqt6zZeQLMkdha4DD2uMp=LOX879BrR6pf4_fwXzc3nr=G-Rw@mail.gmail.com>
 <CAFqt6zascSzTd9QR1rNxdRV=Ta-nuVksj9mtNE0Fzb4qQ21EvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zascSzTd9QR1rNxdRV=Ta-nuVksj9mtNE0Fzb4qQ21EvQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 10:27:44AM +0530, Souptick Joarder wrote:
> On Thu, May 10, 2018 at 7:18 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Wed, Apr 25, 2018 at 10:29 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> Use new return type vm_fault_t for fault and huge_fault
> >> handler. For now, this is just documenting that the
> >> function returns a VM_FAULT value rather than an errno.
> >> Once all instances are converted, vm_fault_t will become
> >> a distinct type.
> >>
> >> Commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> >>
> >> Previously vm_insert_page() returns err which driver
> >> mapped into VM_FAULT_* type. The new function vmf_
> >> insert_page() will replace this inefficiency by
> >> returning VM_FAULT_* type.
> >>
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> >> ---
> >> v2: Updated the change log
> >>
> >>  drivers/gpu/drm/udl/udl_drv.h |  3 ++-
> >>  drivers/gpu/drm/udl/udl_gem.c | 15 ++-------------
> >>  2 files changed, 4 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
> >> index 2a75ab8..11151c4 100644
> >> --- a/drivers/gpu/drm/udl/udl_drv.h
> >> +++ b/drivers/gpu/drm/udl/udl_drv.h
> >> @@ -16,6 +16,7 @@
> >>
> >>  #include <linux/usb.h>
> >>  #include <drm/drm_gem.h>
> >> +#include <linux/mm_types.h>
> >>
> >>  #define DRIVER_NAME            "udl"
> >>  #define DRIVER_DESC            "DisplayLink"
> >> @@ -134,7 +135,7 @@ struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
> >>  int udl_gem_vmap(struct udl_gem_object *obj);
> >>  void udl_gem_vunmap(struct udl_gem_object *obj);
> >>  int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
> >> -int udl_gem_fault(struct vm_fault *vmf);
> >> +vm_fault_t udl_gem_fault(struct vm_fault *vmf);
> >>
> >>  int udl_handle_damage(struct udl_framebuffer *fb, int x, int y,
> >>                       int width, int height);
> >> diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
> >> index dee6bd9..cf5fe35 100644
> >> --- a/drivers/gpu/drm/udl/udl_gem.c
> >> +++ b/drivers/gpu/drm/udl/udl_gem.c
> >> @@ -100,13 +100,12 @@ int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
> >>         return ret;
> >>  }
> >>
> >> -int udl_gem_fault(struct vm_fault *vmf)
> >> +vm_fault_t udl_gem_fault(struct vm_fault *vmf)
> >>  {
> >>         struct vm_area_struct *vma = vmf->vma;
> >>         struct udl_gem_object *obj = to_udl_bo(vma->vm_private_data);
> >>         struct page *page;
> >>         unsigned int page_offset;
> >> -       int ret = 0;
> >>
> >>         page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> >>
> >> @@ -114,17 +113,7 @@ int udl_gem_fault(struct vm_fault *vmf)
> >>                 return VM_FAULT_SIGBUS;
> >>
> >>         page = obj->pages[page_offset];
> >> -       ret = vm_insert_page(vma, vmf->address, page);
> >> -       switch (ret) {
> >> -       case -EAGAIN:
> >> -       case 0:
> >> -       case -ERESTARTSYS:
> >> -               return VM_FAULT_NOPAGE;
> >> -       case -ENOMEM:
> >> -               return VM_FAULT_OOM;
> >> -       default:
> >> -               return VM_FAULT_SIGBUS;
> >> -       }
> >> +       return vmf_insert_page(vma, vmf->address, page);
> >>  }
> >>
> >>  int udl_gem_get_pages(struct udl_gem_object *obj)
> >> --
> >> 1.9.1
> >>
> >
> > Any comment on this patch ?
> 
> If no comment, we would like to get this patch in queue
> for 4.18.

4.18 is done already, queued up for 4.19 in drm-misc-next.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
