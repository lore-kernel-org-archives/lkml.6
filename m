Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933227AbeDXM5t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:57:49 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39868 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeDXM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:57:45 -0400
X-Google-Smtp-Source: AIpwx4+pJD4ptby7Tf14Kuqk37HtU7YC79XL9A1NwawiLcGW+Sdf/djKU6KibpbXGHWVqzwt5Sa41g==
Date: Tue, 24 Apr 2018 14:57:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Eric Anholt <eric@anholt.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: Introduce a new DRM driver for Broadcom V3D
 V3.x+
Message-ID: <20180424125740.GB31310@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180419192035.19898-1-eric@anholt.net>
 <20180419192035.19898-3-eric@anholt.net>
 <20180420085732.GQ31310@phenom.ffwll.local>
 <8736zpbg1z.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736zpbg1z.fsf@anholt.net>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 04:42:48PM -0700, Eric Anholt wrote:
> Daniel Vetter <daniel@ffwll.ch> writes:
> 
> > On Thu, Apr 19, 2018 at 12:20:35PM -0700, Eric Anholt wrote:
> >> This driver will be used to support Mesa on the Broadcom 7268 and 7278
> >> platforms.
> >> 
> >> V3D 3.3 introduces an MMU, which means we no longer need CMA or vc4's
> >> complicated CL/shader validation scheme.  This massively changes the
> >> GEM behavior, so I've forked off to a new driver.
> >> 
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >
> > Read through the entire thing, ignored the hw details, but dropped a few
> > comments all over. With those addressed one way or another this has my
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Can I call in a return favour for
> > https://patchwork.freedesktop.org/series/41219/ ?
> 
> Done.

Thanks!

> >> diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
> >> index d3ab6abae838..f982558fc25d 100644
> >> --- a/Documentation/gpu/drivers.rst
> >> +++ b/Documentation/gpu/drivers.rst
> >> @@ -10,6 +10,7 @@ GPU Driver Documentation
> >>     tegra
> >>     tinydrm
> >>     tve200
> >> +   v3d
> >>     vc4
> >>     bridge/dw-hdmi
> >>     xen-front
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index bca3c32fb141..7314d66833fd 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -4795,6 +4795,15 @@ S:	Maintained
> >>  F:	drivers/gpu/drm/omapdrm/
> >>  F:	Documentation/devicetree/bindings/display/ti/
> >>  
> >> +DRM DRIVERS FOR V3D
> >> +M:	Eric Anholt <eric@anholt.net>
> >> +T:	git git://github.com/anholt/linux
> >
> > This one also official? If it's just for now I'd drop it ...
> 
> Sure.
> 
> >> +/* Pins the shmem pages, fills in the .pages and .sgt fields of the BO, and maps
> >> + * it for DMA.
> >> + */
> >> +static int
> >> +v3d_bo_get_pages(struct v3d_bo *bo)
> >> +{
> >> +	struct drm_gem_object *obj = &bo->base;
> >> +	struct drm_device *dev = obj->dev;
> >> +	int npages = obj->size >> PAGE_SHIFT;
> >> +	int ret = 0;
> >> +
> >> +	mutex_lock(&bo->lock);
> >> +	if (bo->pages_refcount++ != 0)
> >> +		goto unlock;
> >> +
> >> +	if (!obj->import_attach) {
> >> +		bo->pages = drm_gem_get_pages(obj);
> >> +		if (IS_ERR(bo->pages)) {
> >> +			ret = PTR_ERR(bo->pages);
> >> +			goto unlock;
> >> +		}
> >> +
> >> +		bo->sgt = drm_prime_pages_to_sg(bo->pages, npages);
> >> +		if (IS_ERR(bo->sgt)) {
> >> +			ret = PTR_ERR(bo->sgt);
> >> +			goto put_pages;
> >> +		}
> >> +	} else {
> >> +		bo->pages = kcalloc(npages, sizeof(*bo->pages), GFP_KERNEL);
> >> +		if (!bo->pages)
> >> +			goto put_pages;
> >> +
> >> +		drm_prime_sg_to_page_addr_arrays(bo->sgt, bo->pages,
> >> +						 NULL, npages);
> >> +	}
> >> +
> >> +	/* Map the pages for use by the GPU. */
> >> +	dma_map_sg(dev->dev, bo->sgt->sgl,
> >> +		   bo->sgt->nents, DMA_BIDIRECTIONAL);
> >
> > For dma-buf you already get a mapped sgt, and the idea at least is to not
> > noodle around in internals like drm_prime_sg_to_page_addr_arrays does ...
> > That was just a hack Dave did to avoid rewriting all of ttm, which imo
> > shouldn't be copied all over the place (but it happens).
> >
> > Since you immediately convert the page list back into a mapped sg table
> > it's a bit silly.
> >
> > I guess longer-term we could switch the gem helpers to just use sg tables
> > directly, instead of going through pages arrays. But core mm folks just
> > got nasty on us doing that, so I'm not sure which direction we should go
> > here longer-term.
> 
> I moved the map/unmap to the !import case.  We still need the pages
> array for v3d_gem_fault().  If we have an alternative for that that
> isn't a linear walk of the sg at fault time, I'd be up for that.

For the import mmap case, do you really need it? Full generic dma-buf mmap
requires that you call the begin/end_cpu_access calls for flushing, so
this might not work. In practice you'll probably only ever deal with wc.

Other option would be to punch through to the dma_buf->mmap
implementation. Bit of vma shuffling should be able to take care of that,
see e.g. exynos_drm_gem_mmap. etnaviv has something similar, but going
through its own vtable.

Looking through all this (also the inverse of forwarding a dma_buf mmap to
the gem mmap code) looks all very much ripe for plenty of helpers. But I'm
not entirely sure on what we actually want here, and how much drivers want
to blindly forward everything (without also forwarding the begin/end
stuff).

> >> +int v3d_gem_fault(struct vm_fault *vmf)
> >> +{
> >> +	struct vm_area_struct *vma = vmf->vma;
> >> +	struct drm_gem_object *obj = vma->vm_private_data;
> >> +	struct v3d_bo *bo = to_v3d_bo(obj);
> >> +	unsigned long pfn;
> >> +	pgoff_t pgoff;
> >> +	int ret;
> >> +
> >> +	/* We don't use vmf->pgoff since that has the fake offset: */
> >> +	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> >> +	pfn = page_to_pfn(bo->pages[pgoff]);
> >
> > Freaked out for a bit, then noticed you're pinning everything. That makes
> > the bo->pages_refcount a bit confusing since totally not needed.
> >
> > I guess if you do have longer-term plans to roll out a shrinker I'd put at
> > least a FIXME here.
> 
> Yep, long-term shrinker plans.  Added a note to the kerneldoc about why
> we don't shrink yet.
> 
> >> +int v3d_mmap(struct file *filp, struct vm_area_struct *vma)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = drm_gem_mmap(filp, vma);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	v3d_set_mmap_vma_flags(vma);
> >
> > If it'd actually understand what these vma flag frobberies in most drivers
> > do I might come up with an idea how we can avoid the copypaste. Oh well.
> > Maybe a drm_gem_mmap_wc?
> 
> drm_gem_mmap seems to already be wc, just with different vma flags.  If
> you ever figure out the flag frobbing, please let me know. :(
> 
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +int v3d_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = drm_gem_mmap_obj(obj, obj->size, vma);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	v3d_set_mmap_vma_flags(vma);
> >> +
> >> +	return 0;
> >> +}
> >
> > A prime helper which checks out the gem mmap offset and then redirects
> > without having to dupe code would be nice I think. Given that everyone
> > know seems to want to implement prime mmap.
> 
> Agreed, other than the "wtf do the vma flags do" part.
> 
> >> +
> >> +void *v3d_prime_vmap(struct drm_gem_object *obj)
> >> +{
> >> +	WARN_ONCE(1, "not implemented");
> >> +	return NULL;
> >> +}
> >> +
> >> +void v3d_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
> >> +{
> >> +	/* Nothing to do */
> >> +}
> >
> > I think we should patch drm_prime.c to make these optional.
> 
> Done.
> 
> >> +
> >> +struct sg_table *
> >> +v3d_prime_get_sg_table(struct drm_gem_object *obj)
> >> +{
> >> +	struct v3d_bo *bo = to_v3d_bo(obj);
> >> +	int npages = obj->size >> PAGE_SHIFT;
> >> +
> >> +	return drm_prime_pages_to_sg(bo->pages, npages);
> >> +}
> >> +
> >> +struct drm_gem_object *
> >> +v3d_prime_import_sg_table(struct drm_device *dev,
> >> +			  struct dma_buf_attachment *attach,
> >> +			  struct sg_table *sgt)
> >> +{
> >> +	struct drm_gem_object *obj;
> >> +	struct v3d_bo *bo;
> >> +
> >> +	bo = v3d_bo_create_struct(dev, attach->dmabuf->size);
> >> +	if (IS_ERR(bo))
> >> +		return ERR_PTR(PTR_ERR(bo));
> >> +	obj = &bo->base;
> >> +
> >> +	bo->resv = attach->dmabuf->resv;
> >> +
> >> +	bo->sgt = sgt;
> >> +	v3d_bo_get_pages(bo);
> >> +
> >> +	v3d_mmu_insert_ptes(bo);
> >> +
> >> +	return obj;
> >> +}
> >
> > Again, maybe it's worth it to put the sgt pointer into the core
> > drm_gem_object struct and share a pile more of this code. Dunno.
> 
> I'm not sure what we would really be able to share from that.

So the super lofty long term goal I have is that we standardize all the
drivers on 1 way to go through the backing storage memory. Aka sgt (since
you can iterate pages with those too). I think that would allow us to
streamline a bunch of the code here, and avoid some of the impendence
mismatch between iterating over pages and iterating over sg and whatever
else there is. So the benefit would be more consistency among drivers, not
necessarily so much shared code.

Except Christoph Hellwig as dma-mapping maintainer just said in another
thread (about the peer2peer stuff Christian König is working on) that he
totally doesn't like us aiming to use sgt as the be-all-end-all of backing
storage structures for gpus.

I guess I'll just table this idea until someone else volunteers :-)

> >> +
> >> +int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
> >> +			struct drm_file *file_priv)
> >> +{
> >> +	struct drm_v3d_create_bo *args = data;
> >> +	struct v3d_bo *bo = NULL;
> >> +	int ret;
> >> +
> >> +	bo = v3d_bo_create(dev, file_priv, PAGE_ALIGN(args->size));
> >> +	if (IS_ERR(bo))
> >> +		return PTR_ERR(bo);
> >> +
> >> +	args->offset = bo->node.start << PAGE_SHIFT;
> >> +
> >> +	ret = drm_gem_handle_create(file_priv, &bo->base, &args->handle);
> >> +	drm_gem_object_unreference_unlocked(&bo->base);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
> >> +		      struct drm_file *file_priv)
> >> +{
> >> +	struct drm_v3d_mmap_bo *args = data;
> >> +	struct drm_gem_object *gem_obj;
> >> +
> >> +	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
> >> +	if (!gem_obj) {
> >> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
> >> +		return -ENOENT;
> >> +	}
> >> +
> >> +	/* The mmap offset was set up at BO allocation time. */
> >
> > vma node manager has it's own looking, you can just call this whenever you
> > want. And the offset is _not_ set up at create time :-)
> 
> Done.
> 
> >> +	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
> >> +
> >> +	drm_gem_object_unreference_unlocked(gem_obj);
> >> +	return 0;
> >> +}
> >> +
> >> +int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
> >> +			    struct drm_file *file_priv)
> >> +{
> >> +	struct drm_v3d_get_bo_offset *args = data;
> >> +	struct drm_gem_object *gem_obj;
> >> +	struct v3d_bo *bo;
> >> +
> >> +	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
> >> +	if (!gem_obj) {
> >> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
> >> +		return -ENOENT;
> >> +	}
> >> +	bo = to_v3d_bo(gem_obj);
> >> +
> >> +	args->offset = bo->node.start << PAGE_SHIFT;
> >> +
> >> +	drm_gem_object_unreference_unlocked(gem_obj);
> >> +	return 0;
> >> +}
> >
> > Hm, how does your hw work? Do you have one address space for everyone, but
> > can block out different ranges using this GMP thing? How big is the
> > address space (i.e. do we expect to run out of it)?
> >
> > You seem to only have a 32 bit address space, doesn't seem like given that
> > v3d looks like it'll be the broadcom gpu driver for plenty of future hw.
> 
> There are some notes about it in v3d_mmu.c's docs.  The MMU gives you a
> 4GB address space using a single-level page table, and CMA being a
> dumpster fire means you really don't want to allocate those 4MB page
> tables if you can avoid it, because it will often fail.  Thus, we put
> everyone in the same table.
> 
> GMP lets you read/write mask access of those vaddrs at 128kb granularity
> using an 8kb table.
> 
> The HW designers were of the opinion that running out of 4gb address
> space across all clients was unlikely to be a problem for quite a while.
> Keep in mind, these are boards with 2GB of memory and no swap currently.
> Once we find some usecase running out of their 4gb address space, we
> could potentially move them to their own address space and their own
> page table.

Ah, I didn't realize that we have the option to allocate more 4G address
spaces.

And agreed that 4G for gpu address space should be plenty. On intel gen7
is the first one with working ppgtt, and only 2GB of that. Only bdw/gen8+
increased it to 48b (which roughly matches the virtual space you have on
the cpu too). Still, anv happily soft-pins everything (so no virtual
evictions, only physical bo tracking like you can do here with this api).

If 2GB is fine on intel hsw with vk, I think your 4GB are totally fine for
vc5+. I was only really worried about having only 4G for everyone
together, but that's not the case.

> >> +static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
> >> +	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CL, v3d_submit_cl_ioctl, DRM_RENDER_ALLOW),
> >> +	DRM_IOCTL_DEF_DRV(V3D_WAIT_BO, v3d_wait_bo_ioctl, DRM_RENDER_ALLOW),
> >> +	DRM_IOCTL_DEF_DRV(V3D_CREATE_BO, v3d_create_bo_ioctl, DRM_RENDER_ALLOW),
> >> +	DRM_IOCTL_DEF_DRV(V3D_MMAP_BO, v3d_mmap_bo_ioctl, DRM_RENDER_ALLOW),
> >> +	DRM_IOCTL_DEF_DRV(V3D_GET_PARAM, v3d_get_param_ioctl, DRM_RENDER_ALLOW),
> >> +	DRM_IOCTL_DEF_DRV(V3D_GET_BO_OFFSET, v3d_get_bo_offset_ioctl, DRM_RENDER_ALLOW),
> >> +};
> >
> > So on your "Do I need DRM_AUTH" question ... heck do I know :-)
> >
> > What seems to be standard practice is to sprinkle a DRM_AUTH over all
> > DRM_RENDER_ALLOW ioctls which change stuff (i.e. all except GET_PARAM).
> > Note that DRM_AUTH has some very weak guarantees: Once authenticated,
> > always authenticated. The authentication doesn't follow the drm master
> > around, so if you VT switch you can happily read any other users memory
> > already, even with DRM_AUTH.
> >
> > The same applies for render nodes, except no authentication step to jump
> > over first.
> >
> > We also already have drivers with render nodes which don't have full
> > ppgtt, so doesn't seem to horrible idea either to start out without that
> > for v3d.
> >
> > tldr; I'd suggest you sprinkle DRM_AUTH over everything except GET_PARAM,
> > if only for cargo cult consistency :-)
> 
> Following the logic that makes GET_PARAM !AUTH, I believe all ioctls
> except SUBMIT_CL would be perfectly fine -- they're only operating on
> the BOs you have a handle to.
> 
> Talking with keithp at breakfast and doing a bit of testing just now, I
> think getting my GMP work finished will be easier than I thought -- V3D
> 3.x's binner OOM state machine is much nicer than 2.x, so my difficult
> synchronization problem for GMP switching might be a non-issue.  Still,
> I'd like to pursue the merge anyway, so I've flagged SUBMIT as AUTH
> (reasoning that if Ironlake can have DRIVER_RENDER, v3d can too).

Sounds reasonable, has my ack.

> >> +	platform_set_drvdata(pdev, drm);
> >> +	v3d->drm = drm;
> >> +	drm->dev_private = v3d;
> >
> > drm_dev_init plus just embed drm in v3d is my recommendation.
> 
> Not getting to use devm_kzalloc with that is weird, but I've changed
> over.

Well "Hotplug is Broken (tm)", but using devm_kzcalloc for any of the
drm-side structures is a no-go for actually hotpluggable hw. When you
hot-unplug then the struct device can all disappear, while the struct
drm_device has an entirely different lifetime and kinda needs to persist
(until all the userspace handles and stuff are gone). There's plenty of
other gaps and pitfalls with making this all properly work, and Noralf is
slowly working them down (for tinydrm unplug for panels).

I looked a bit into whether we could use devm_* helpers tied to the
drm_device lifetime, but that didn't look really doable.

In practice "don't do that then" applies, except for the few drivers who
actually can be hot-unplugged.

Aside: Even more fun is that exported objects like dma_buf or dma_fence
also can outlive your physical device struct, and worse, can outlive
drm_device. Hotunplug atm in drm is made full of fail.

Anyway, nothing for you to do, just wanted to provide some context.

> >> +/**
> >> + * _wait_for - magic (register) wait macro
> >> + *
> >> + * Does the right thing for modeset paths when run under kdgb or similar atomic
> >> + * contexts. Note that it's important that we check the condition again after
> >> + * having timed out, since the timeout could be due to preemption or similar and
> >> + * we've never had a chance to check the condition before the timeout.
> >> + */
> >> +#define _wait_for(COND, MS, W) ({ \
> >> +	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS) + 1;	\
> >> +	int ret__ = 0;							\
> >> +	while (!(COND)) {						\
> >> +		if (time_after(jiffies, timeout__)) {			\
> >> +			if (!(COND))					\
> >> +				ret__ = -ETIMEDOUT;			\
> >> +			break;						\
> >> +		}							\
> >> +		if (W && drm_can_sleep())  {				\
> >
> > drm_can_sleep considered harmful - it allows you to have huge busy-spin
> > waits in irq-off sections, which isn't cool. Since this isn't a modeset
> > driver I'd nuke this. i915 had a bunch of bugs where we've busy-spun for
> > tens of msec while disabling irqs, and since the magic prevent the usual
> > might_slip splat we didn't notice for a long time :-/
> 
> Dropped.
> 
> I wonder how much performance I'm leaving on the floor by msleep()ing in
> these loops instead of busy-waiting, though.  These usages should be
> "done in a few cycles" not "done in a few ms".  Hopefully I'm just never
> sleeping at all!

In i915 we have separate macros for the cases where we busy-loop and
expect it to be only a few usec at most. Those also have a timeout in
usecs (and obviously don't bother sleeping at all).

> >> +static bool v3d_fence_enable_signaling(struct dma_fence *fence)
> >> +{
> >> +	return true;
> >> +}
> >
> > This callback is optional and not needed when signalling is always enabled
> > for your fences.
> 
> That doesn't seem to be true:
> 
> void
> dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> 	       spinlock_t *lock, u64 context, unsigned seqno)
> {
> 	BUG_ON(!lock);
> 	BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
> 	       !ops->get_driver_name || !ops->get_timeline_name);

Oops, silly me misread the check of the return value of ->enable_signaling
as the check whether the callback is there.

We have quite a pile of trivial ->enable_signaling implementations, I
think I'm going to type a small patch series.

> >> +int
> >> +v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
> >> +		  struct drm_file *file_priv)
> >> +{
> >> +	int ret;
> >> +	struct drm_v3d_wait_bo *args = data;
> >> +	struct drm_gem_object *gem_obj;
> >> +	struct v3d_bo *bo;
> >> +	unsigned long start = jiffies;
> >> +	unsigned long timeout_jiffies =
> >> +		nsecs_to_jiffies_timeout(args->timeout_ns);
> >> +
> >> +	if (args->pad != 0)
> >> +		return -EINVAL;
> >> +
> >> +	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
> >> +	if (!gem_obj) {
> >> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
> >> +		return -EINVAL;
> >> +	}
> >> +	bo = to_v3d_bo(gem_obj);
> >> +
> >> +	ret = reservation_object_wait_timeout_rcu(bo->resv,
> >> +						  true, true,
> >> +						  timeout_jiffies);
> >> +
> >> +	/* Decrement the user's timeout, in case we got interrupted
> >> +	 * such that the ioctl will be restarted.
> >> +	 */
> >> +	args->timeout_ns -= jiffies_to_nsecs(jiffies - start);
> >
> > Just learned that if you want accuracy you need ktime_get before/after
> > waiting, since the entire jiffies thing is too inaccurate - if the irqs
> > gets delayed, jiffies isn't update. The other issue is that if you get
> > interrupted too quickly, jiffies doesn't update and you end up sleeping
> > for way too long.
> >
> > Not sure you care about that much accuracy :-)
> 
> Thanks for the note!  I've fixed it up.
> 
> How I wish the reservation was in the GEM BO and we could have a shared
> ioctl to do this.

Hm, good idea actually for a bit of refactoring. Would remove the need for
the gem_prime_res_obj callback which only exists to because the pointer
isn't in drm_gem_object.

> 
> >> +/**
> >> + * struct drm_v3d_submit_cl - ioctl argument for submitting commands to the 3D
> >> + * engine.
> >> + *
> >> + * This asks the kernel to have the GPU execute an optional binner
> >> + * command list, and a render command list.
> >> + */
> >> +struct drm_v3d_submit_cl {
> >> +	/* Pointer to the binner command list.
> >> +	 *
> >> +	 * This is the first set of commands executed, which runs the
> >> +	 * coordinate shader to determine where primitives land on the screen,
> >> +	 * then writes out the state updates and draw calls necessary per tile
> >> +	 * to the tile allocation BO.
> >> +	 */
> >> +	__u32 bcl_start;
> >> +
> >> +	 /** End address of the BCL (first byte after the BCL) */
> >> +	__u32 bcl_end;
> >> +
> >> +	/* Offset of the render command list.
> >> +	 *
> >> +	 * This is the second set of commands executed, which will either
> >> +	 * execute the tiles that have been set up by the BCL, or a fixed set
> >> +	 * of tiles (in the case of RCL-only blits).
> >> +	 */
> >> +	__u32 rcl_start;
> >> +
> >> +	 /** End address of the RCL (first byte after the RCL) */
> >> +	__u32 rcl_end;
> >> +
> >> +	/** An optional sync object to wait on before starting the BCL. */
> >> +	__u32 in_sync_bcl;
> >> +	/** An optional sync object to wait on before starting the RCL. */
> >> +	__u32 in_sync_rcl;
> >> +	/** An optional sync object to place the completion fence in. */
> >> +	__u32 out_sync;
> >> +
> >> +	/* Offset of the tile alloc memory
> >> +	 *
> >> +	 * This is optional on V3D 3.3 (where the CL can set the value) but
> >> +	 * required on V3D 4.1.
> >> +	 */
> >> +	__u32 qma;
> >> +
> >> +	/** Size of the tile alloc memory. */
> >> +	__u32 qms;
> >> +
> >> +	/** Offset of the tile state data array. */
> >> +	__u32 qts;
> >> +
> >> +	/* Pointer to a u32 array of the BOs that are referenced by the job.
> >> +	 */
> >> +	__u64 bo_handles;
> >> +
> >> +	/* Number of BO handles passed in (size is that times 4). */
> >> +	__u32 bo_handle_count;
> >
> > I think you want an __32 resv/flags/pad (and check it's 0) here, to align with
> > 8bytes. But I freely admit my ioctl struct layout knowledge is some good
> > cargo-cult :-)
> 
> Can you explain the reason for that?  I thought we'd talked about this
> before and decided that there was no need to align struct size to 8
> bytes, unless it's a struct that would be submitted as an array.

Hm right. Like I said, I'm just cargo-culting this.

The only downside I see is that mis-matched userspace might zero-extend
the struct. And if you initialize it explicitly instead of with memset or
= {}, then you might put garbage in there. And since the kernel doesn't
see this, you can't have a check for that. Later on you add a new field,
which then won't work because of old userspace.

But tbh I'm probably wrong on this too. Not sure ...

Anyway, all questions I had answered, so my Ack holds. I think some of the
ideas we've tossed around here for more refactoring would make great
Todo.rst entries. I'll throw them all into a patch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
