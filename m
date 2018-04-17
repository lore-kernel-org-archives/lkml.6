Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756063AbeDQQQB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:16:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbeDQQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:16:00 -0400
Date: Tue, 17 Apr 2018 09:15:57 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: drm: i915: Change return type to vm_fault_t
Message-ID: <20180417161557.GA3603@bombadil.infradead.org>
References: <20180417151127.GA31655@jordon-HP-15-Notebook-PC>
 <87h8o9g8be.fsf@intel.com>
 <CAFqt6zb_XqVKHPH5U4TubgDTgBURWv63cfa_OMQEyHjGZpKTHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zb_XqVKHPH5U4TubgDTgBURWv63cfa_OMQEyHjGZpKTHQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 09:14:32PM +0530, Souptick Joarder wrote:
> Not exactly. The plan for these patches is to introduce new vm_fault_t type
> in vm_operations_struct fault handlers. It's now available in 4.17-rc1. We will
> push all the required drivers/filesystem changes through different maintainers
> to linus tree. Once everything is converted into vm_fault_t type then Changing
> it from a signed to an unsigned int causes GCC to warn about an assignment
> from an incompatible type -- int foo(void) is incompatible with
> unsigned int foo(void).
> 
> Please refer 1c8f422059ae ("mm: change return type to vm_fault_t") in 4.17-rc1.

I think this patch would be clearer if you did

-	int ret;
+	int err;
+	vm_fault_t ret;

Then it would be clearer to the maintainer that you're splitting apart the
VM_FAULT and errno codes.

Sorry for not catching this during initial review.

> On Tue, Apr 17, 2018 at 8:59 PM, Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
> > On Tue, 17 Apr 2018, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> Use new return type vm_fault_t for fault handler. For
> >> now, this is just documenting that the function returns
> >> a VM_FAULT value rather than an errno. Once all instances
> >> are converted, vm_fault_t will become a distinct type.
> >>
> >> Reference id -> 1c8f422059ae ("mm: change return type to
> >> vm_fault_t")
> >>
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> ---
> >>  drivers/gpu/drm/i915/i915_drv.h |  3 ++-
> >>  drivers/gpu/drm/i915/i915_gem.c | 15 ++++++++-------
> >>  2 files changed, 10 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> >> index a42deeb..95b0d50 100644
> >> --- a/drivers/gpu/drm/i915/i915_drv.h
> >> +++ b/drivers/gpu/drm/i915/i915_drv.h
> >> @@ -51,6 +51,7 @@
> >>  #include <drm/drm_gem.h>
> >>  #include <drm/drm_auth.h>
> >>  #include <drm/drm_cache.h>
> >> +#include <linux/mm_types.h>
> >>
> >>  #include "i915_params.h"
> >>  #include "i915_reg.h"
> >> @@ -3363,7 +3364,7 @@ int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
> >>                          unsigned int flags);
> >>  int __must_check i915_gem_suspend(struct drm_i915_private *dev_priv);
> >>  void i915_gem_resume(struct drm_i915_private *dev_priv);
> >> -int i915_gem_fault(struct vm_fault *vmf);
> >> +vm_fault_t i915_gem_fault(struct vm_fault *vmf);
> >>  int i915_gem_object_wait(struct drm_i915_gem_object *obj,
> >>                        unsigned int flags,
> >>                        long timeout,
> >> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> >> index dd89abd..bdac690 100644
> >> --- a/drivers/gpu/drm/i915/i915_gem.c
> >> +++ b/drivers/gpu/drm/i915/i915_gem.c
> >> @@ -1882,7 +1882,7 @@ int i915_gem_mmap_gtt_version(void)
> >>   * The current feature set supported by i915_gem_fault() and thus GTT mmaps
> >>   * is exposed via I915_PARAM_MMAP_GTT_VERSION (see i915_gem_mmap_gtt_version).
> >>   */
> >> -int i915_gem_fault(struct vm_fault *vmf)
> >> +vm_fault_t i915_gem_fault(struct vm_fault *vmf)
> >>  {
> >>  #define MIN_CHUNK_PAGES ((1 << 20) >> PAGE_SHIFT) /* 1 MiB */
> >>       struct vm_area_struct *area = vmf->vma;
> >> @@ -1895,6 +1895,7 @@ int i915_gem_fault(struct vm_fault *vmf)
> >>       pgoff_t page_offset;
> >>       unsigned int flags;
> >>       int ret;
> >> +     vm_fault_t retval;
> >
> > What's the point of changing the name? An unnecessary change.
> >
> > BR,
> > Jani.
> >
> >>
> >>       /* We don't use vmf->pgoff since that has the fake offset */
> >>       page_offset = (vmf->address - area->vm_start) >> PAGE_SHIFT;
> >> @@ -2000,7 +2001,7 @@ int i915_gem_fault(struct vm_fault *vmf)
> >>                * and so needs to be reported.
> >>                */
> >>               if (!i915_terminally_wedged(&dev_priv->gpu_error)) {
> >> -                     ret = VM_FAULT_SIGBUS;
> >> +                     retval = VM_FAULT_SIGBUS;
> >>                       break;
> >>               }
> >>       case -EAGAIN:
> >> @@ -2017,21 +2018,21 @@ int i915_gem_fault(struct vm_fault *vmf)
> >>                * EBUSY is ok: this just means that another thread
> >>                * already did the job.
> >>                */
> >> -             ret = VM_FAULT_NOPAGE;
> >> +             retval = VM_FAULT_NOPAGE;
> >>               break;
> >>       case -ENOMEM:
> >> -             ret = VM_FAULT_OOM;
> >> +             retval = VM_FAULT_OOM;
> >>               break;
> >>       case -ENOSPC:
> >>       case -EFAULT:
> >> -             ret = VM_FAULT_SIGBUS;
> >> +             retval = VM_FAULT_SIGBUS;
> >>               break;
> >>       default:
> >>               WARN_ONCE(ret, "unhandled error in i915_gem_fault: %i\n", ret);
> >> -             ret = VM_FAULT_SIGBUS;
> >> +             retval = VM_FAULT_SIGBUS;
> >>               break;
> >>       }
> >> -     return ret;
> >> +     return retval;
> >>  }
> >>
> >>  static void __i915_gem_object_release_mmap(struct drm_i915_gem_object *obj)
> >> --
> >> 1.9.1
> >>
> >
> > --
> > Jani Nikula, Intel Open Source Technology Center
