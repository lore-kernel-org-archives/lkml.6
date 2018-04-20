Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDTXm5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:42:57 -0400
Received: from anholt.net ([50.246.234.109]:40240 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbeDTXmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:42:54 -0400
From: Eric Anholt <eric@anholt.net>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+
In-Reply-To: <20180420085732.GQ31310@phenom.ffwll.local>
References: <20180419192035.19898-1-eric@anholt.net> <20180419192035.19898-3-eric@anholt.net> <20180420085732.GQ31310@phenom.ffwll.local>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 20 Apr 2018 16:42:48 -0700
Message-ID: <8736zpbg1z.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Vetter <daniel@ffwll.ch> writes:

> On Thu, Apr 19, 2018 at 12:20:35PM -0700, Eric Anholt wrote:
>> This driver will be used to support Mesa on the Broadcom 7268 and 7278
>> platforms.
>>=20
>> V3D 3.3 introduces an MMU, which means we no longer need CMA or vc4's
>> complicated CL/shader validation scheme.  This massively changes the
>> GEM behavior, so I've forked off to a new driver.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Read through the entire thing, ignored the hw details, but dropped a few
> comments all over. With those addressed one way or another this has my
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Can I call in a return favour for
> https://patchwork.freedesktop.org/series/41219/ ?

Done.

>> diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.r=
st
>> index d3ab6abae838..f982558fc25d 100644
>> --- a/Documentation/gpu/drivers.rst
>> +++ b/Documentation/gpu/drivers.rst
>> @@ -10,6 +10,7 @@ GPU Driver Documentation
>>     tegra
>>     tinydrm
>>     tve200
>> +   v3d
>>     vc4
>>     bridge/dw-hdmi
>>     xen-front
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bca3c32fb141..7314d66833fd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4795,6 +4795,15 @@ S:	Maintained
>>  F:	drivers/gpu/drm/omapdrm/
>>  F:	Documentation/devicetree/bindings/display/ti/
>>=20=20
>> +DRM DRIVERS FOR V3D
>> +M:	Eric Anholt <eric@anholt.net>
>> +T:	git git://github.com/anholt/linux
>
> This one also official? If it's just for now I'd drop it ...

Sure.

>> +/* Pins the shmem pages, fills in the .pages and .sgt fields of the BO,=
 and maps
>> + * it for DMA.
>> + */
>> +static int
>> +v3d_bo_get_pages(struct v3d_bo *bo)
>> +{
>> +	struct drm_gem_object *obj =3D &bo->base;
>> +	struct drm_device *dev =3D obj->dev;
>> +	int npages =3D obj->size >> PAGE_SHIFT;
>> +	int ret =3D 0;
>> +
>> +	mutex_lock(&bo->lock);
>> +	if (bo->pages_refcount++ !=3D 0)
>> +		goto unlock;
>> +
>> +	if (!obj->import_attach) {
>> +		bo->pages =3D drm_gem_get_pages(obj);
>> +		if (IS_ERR(bo->pages)) {
>> +			ret =3D PTR_ERR(bo->pages);
>> +			goto unlock;
>> +		}
>> +
>> +		bo->sgt =3D drm_prime_pages_to_sg(bo->pages, npages);
>> +		if (IS_ERR(bo->sgt)) {
>> +			ret =3D PTR_ERR(bo->sgt);
>> +			goto put_pages;
>> +		}
>> +	} else {
>> +		bo->pages =3D kcalloc(npages, sizeof(*bo->pages), GFP_KERNEL);
>> +		if (!bo->pages)
>> +			goto put_pages;
>> +
>> +		drm_prime_sg_to_page_addr_arrays(bo->sgt, bo->pages,
>> +						 NULL, npages);
>> +	}
>> +
>> +	/* Map the pages for use by the GPU. */
>> +	dma_map_sg(dev->dev, bo->sgt->sgl,
>> +		   bo->sgt->nents, DMA_BIDIRECTIONAL);
>
> For dma-buf you already get a mapped sgt, and the idea at least is to not
> noodle around in internals like drm_prime_sg_to_page_addr_arrays does ...
> That was just a hack Dave did to avoid rewriting all of ttm, which imo
> shouldn't be copied all over the place (but it happens).
>
> Since you immediately convert the page list back into a mapped sg table
> it's a bit silly.
>
> I guess longer-term we could switch the gem helpers to just use sg tables
> directly, instead of going through pages arrays. But core mm folks just
> got nasty on us doing that, so I'm not sure which direction we should go
> here longer-term.

I moved the map/unmap to the !import case.  We still need the pages
array for v3d_gem_fault().  If we have an alternative for that that
isn't a linear walk of the sg at fault time, I'd be up for that.

>> +int v3d_gem_fault(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma =3D vmf->vma;
>> +	struct drm_gem_object *obj =3D vma->vm_private_data;
>> +	struct v3d_bo *bo =3D to_v3d_bo(obj);
>> +	unsigned long pfn;
>> +	pgoff_t pgoff;
>> +	int ret;
>> +
>> +	/* We don't use vmf->pgoff since that has the fake offset: */
>> +	pgoff =3D (vmf->address - vma->vm_start) >> PAGE_SHIFT;
>> +	pfn =3D page_to_pfn(bo->pages[pgoff]);
>
> Freaked out for a bit, then noticed you're pinning everything. That makes
> the bo->pages_refcount a bit confusing since totally not needed.
>
> I guess if you do have longer-term plans to roll out a shrinker I'd put at
> least a FIXME here.

Yep, long-term shrinker plans.  Added a note to the kerneldoc about why
we don't shrink yet.

>> +int v3d_mmap(struct file *filp, struct vm_area_struct *vma)
>> +{
>> +	int ret;
>> +
>> +	ret =3D drm_gem_mmap(filp, vma);
>> +	if (ret)
>> +		return ret;
>> +
>> +	v3d_set_mmap_vma_flags(vma);
>
> If it'd actually understand what these vma flag frobberies in most drivers
> do I might come up with an idea how we can avoid the copypaste. Oh well.
> Maybe a drm_gem_mmap_wc?

drm_gem_mmap seems to already be wc, just with different vma flags.  If
you ever figure out the flag frobbing, please let me know. :(

>> +
>> +	return ret;
>> +}
>> +
>> +int v3d_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *v=
ma)
>> +{
>> +	int ret;
>> +
>> +	ret =3D drm_gem_mmap_obj(obj, obj->size, vma);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	v3d_set_mmap_vma_flags(vma);
>> +
>> +	return 0;
>> +}
>
> A prime helper which checks out the gem mmap offset and then redirects
> without having to dupe code would be nice I think. Given that everyone
> know seems to want to implement prime mmap.

Agreed, other than the "wtf do the vma flags do" part.

>> +
>> +void *v3d_prime_vmap(struct drm_gem_object *obj)
>> +{
>> +	WARN_ONCE(1, "not implemented");
>> +	return NULL;
>> +}
>> +
>> +void v3d_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>> +{
>> +	/* Nothing to do */
>> +}
>
> I think we should patch drm_prime.c to make these optional.

Done.

>> +
>> +struct sg_table *
>> +v3d_prime_get_sg_table(struct drm_gem_object *obj)
>> +{
>> +	struct v3d_bo *bo =3D to_v3d_bo(obj);
>> +	int npages =3D obj->size >> PAGE_SHIFT;
>> +
>> +	return drm_prime_pages_to_sg(bo->pages, npages);
>> +}
>> +
>> +struct drm_gem_object *
>> +v3d_prime_import_sg_table(struct drm_device *dev,
>> +			  struct dma_buf_attachment *attach,
>> +			  struct sg_table *sgt)
>> +{
>> +	struct drm_gem_object *obj;
>> +	struct v3d_bo *bo;
>> +
>> +	bo =3D v3d_bo_create_struct(dev, attach->dmabuf->size);
>> +	if (IS_ERR(bo))
>> +		return ERR_PTR(PTR_ERR(bo));
>> +	obj =3D &bo->base;
>> +
>> +	bo->resv =3D attach->dmabuf->resv;
>> +
>> +	bo->sgt =3D sgt;
>> +	v3d_bo_get_pages(bo);
>> +
>> +	v3d_mmu_insert_ptes(bo);
>> +
>> +	return obj;
>> +}
>
> Again, maybe it's worth it to put the sgt pointer into the core
> drm_gem_object struct and share a pile more of this code. Dunno.

I'm not sure what we would really be able to share from that.

>> +
>> +int v3d_create_bo_ioctl(struct drm_device *dev, void *data,
>> +			struct drm_file *file_priv)
>> +{
>> +	struct drm_v3d_create_bo *args =3D data;
>> +	struct v3d_bo *bo =3D NULL;
>> +	int ret;
>> +
>> +	bo =3D v3d_bo_create(dev, file_priv, PAGE_ALIGN(args->size));
>> +	if (IS_ERR(bo))
>> +		return PTR_ERR(bo);
>> +
>> +	args->offset =3D bo->node.start << PAGE_SHIFT;
>> +
>> +	ret =3D drm_gem_handle_create(file_priv, &bo->base, &args->handle);
>> +	drm_gem_object_unreference_unlocked(&bo->base);
>> +
>> +	return ret;
>> +}
>> +
>> +int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
>> +		      struct drm_file *file_priv)
>> +{
>> +	struct drm_v3d_mmap_bo *args =3D data;
>> +	struct drm_gem_object *gem_obj;
>> +
>> +	gem_obj =3D drm_gem_object_lookup(file_priv, args->handle);
>> +	if (!gem_obj) {
>> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
>> +		return -ENOENT;
>> +	}
>> +
>> +	/* The mmap offset was set up at BO allocation time. */
>
> vma node manager has it's own looking, you can just call this whenever you
> want. And the offset is _not_ set up at create time :-)

Done.

>> +	args->offset =3D drm_vma_node_offset_addr(&gem_obj->vma_node);
>> +
>> +	drm_gem_object_unreference_unlocked(gem_obj);
>> +	return 0;
>> +}
>> +
>> +int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
>> +			    struct drm_file *file_priv)
>> +{
>> +	struct drm_v3d_get_bo_offset *args =3D data;
>> +	struct drm_gem_object *gem_obj;
>> +	struct v3d_bo *bo;
>> +
>> +	gem_obj =3D drm_gem_object_lookup(file_priv, args->handle);
>> +	if (!gem_obj) {
>> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
>> +		return -ENOENT;
>> +	}
>> +	bo =3D to_v3d_bo(gem_obj);
>> +
>> +	args->offset =3D bo->node.start << PAGE_SHIFT;
>> +
>> +	drm_gem_object_unreference_unlocked(gem_obj);
>> +	return 0;
>> +}
>
> Hm, how does your hw work? Do you have one address space for everyone, but
> can block out different ranges using this GMP thing? How big is the
> address space (i.e. do we expect to run out of it)?
>
> You seem to only have a 32 bit address space, doesn't seem like given that
> v3d looks like it'll be the broadcom gpu driver for plenty of future hw.

There are some notes about it in v3d_mmu.c's docs.  The MMU gives you a
4GB address space using a single-level page table, and CMA being a
dumpster fire means you really don't want to allocate those 4MB page
tables if you can avoid it, because it will often fail.  Thus, we put
everyone in the same table.

GMP lets you read/write mask access of those vaddrs at 128kb granularity
using an 8kb table.

The HW designers were of the opinion that running out of 4gb address
space across all clients was unlikely to be a problem for quite a while.
Keep in mind, these are boards with 2GB of memory and no swap currently.
Once we find some usecase running out of their 4gb address space, we
could potentially move them to their own address space and their own
page table.

>> +static const struct drm_ioctl_desc v3d_drm_ioctls[] =3D {
>> +	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CL, v3d_submit_cl_ioctl, DRM_RENDER_ALLOW=
),
>> +	DRM_IOCTL_DEF_DRV(V3D_WAIT_BO, v3d_wait_bo_ioctl, DRM_RENDER_ALLOW),
>> +	DRM_IOCTL_DEF_DRV(V3D_CREATE_BO, v3d_create_bo_ioctl, DRM_RENDER_ALLOW=
),
>> +	DRM_IOCTL_DEF_DRV(V3D_MMAP_BO, v3d_mmap_bo_ioctl, DRM_RENDER_ALLOW),
>> +	DRM_IOCTL_DEF_DRV(V3D_GET_PARAM, v3d_get_param_ioctl, DRM_RENDER_ALLOW=
),
>> +	DRM_IOCTL_DEF_DRV(V3D_GET_BO_OFFSET, v3d_get_bo_offset_ioctl, DRM_REND=
ER_ALLOW),
>> +};
>
> So on your "Do I need DRM_AUTH" question ... heck do I know :-)
>
> What seems to be standard practice is to sprinkle a DRM_AUTH over all
> DRM_RENDER_ALLOW ioctls which change stuff (i.e. all except GET_PARAM).
> Note that DRM_AUTH has some very weak guarantees: Once authenticated,
> always authenticated. The authentication doesn't follow the drm master
> around, so if you VT switch you can happily read any other users memory
> already, even with DRM_AUTH.
>
> The same applies for render nodes, except no authentication step to jump
> over first.
>
> We also already have drivers with render nodes which don't have full
> ppgtt, so doesn't seem to horrible idea either to start out without that
> for v3d.
>
> tldr; I'd suggest you sprinkle DRM_AUTH over everything except GET_PARAM,
> if only for cargo cult consistency :-)

Following the logic that makes GET_PARAM !AUTH, I believe all ioctls
except SUBMIT_CL would be perfectly fine -- they're only operating on
the BOs you have a handle to.

Talking with keithp at breakfast and doing a bit of testing just now, I
think getting my GMP work finished will be easier than I thought -- V3D
3.x's binner OOM state machine is much nicer than 2.x, so my difficult
synchronization problem for GMP switching might be a non-issue.  Still,
I'd like to pursue the merge anyway, so I've flagged SUBMIT as AUTH
(reasoning that if Ironlake can have DRIVER_RENDER, v3d can too).

>> +	platform_set_drvdata(pdev, drm);
>> +	v3d->drm =3D drm;
>> +	drm->dev_private =3D v3d;
>
> drm_dev_init plus just embed drm in v3d is my recommendation.

Not getting to use devm_kzalloc with that is weird, but I've changed
over.

>> +/**
>> + * _wait_for - magic (register) wait macro
>> + *
>> + * Does the right thing for modeset paths when run under kdgb or simila=
r atomic
>> + * contexts. Note that it's important that we check the condition again=
 after
>> + * having timed out, since the timeout could be due to preemption or si=
milar and
>> + * we've never had a chance to check the condition before the timeout.
>> + */
>> +#define _wait_for(COND, MS, W) ({ \
>> +	unsigned long timeout__ =3D jiffies + msecs_to_jiffies(MS) + 1;	\
>> +	int ret__ =3D 0;							\
>> +	while (!(COND)) {						\
>> +		if (time_after(jiffies, timeout__)) {			\
>> +			if (!(COND))					\
>> +				ret__ =3D -ETIMEDOUT;			\
>> +			break;						\
>> +		}							\
>> +		if (W && drm_can_sleep())  {				\
>
> drm_can_sleep considered harmful - it allows you to have huge busy-spin
> waits in irq-off sections, which isn't cool. Since this isn't a modeset
> driver I'd nuke this. i915 had a bunch of bugs where we've busy-spun for
> tens of msec while disabling irqs, and since the magic prevent the usual
> might_slip splat we didn't notice for a long time :-/

Dropped.

I wonder how much performance I'm leaving on the floor by msleep()ing in
these loops instead of busy-waiting, though.  These usages should be
"done in a few cycles" not "done in a few ms".  Hopefully I'm just never
sleeping at all!


>> +static bool v3d_fence_enable_signaling(struct dma_fence *fence)
>> +{
>> +	return true;
>> +}
>
> This callback is optional and not needed when signalling is always enabled
> for your fences.

That doesn't seem to be true:

void
dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
	       spinlock_t *lock, u64 context, unsigned seqno)
{
	BUG_ON(!lock);
	BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
	       !ops->get_driver_name || !ops->get_timeline_name);

>> +int
>> +v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
>> +		  struct drm_file *file_priv)
>> +{
>> +	int ret;
>> +	struct drm_v3d_wait_bo *args =3D data;
>> +	struct drm_gem_object *gem_obj;
>> +	struct v3d_bo *bo;
>> +	unsigned long start =3D jiffies;
>> +	unsigned long timeout_jiffies =3D
>> +		nsecs_to_jiffies_timeout(args->timeout_ns);
>> +
>> +	if (args->pad !=3D 0)
>> +		return -EINVAL;
>> +
>> +	gem_obj =3D drm_gem_object_lookup(file_priv, args->handle);
>> +	if (!gem_obj) {
>> +		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
>> +		return -EINVAL;
>> +	}
>> +	bo =3D to_v3d_bo(gem_obj);
>> +
>> +	ret =3D reservation_object_wait_timeout_rcu(bo->resv,
>> +						  true, true,
>> +						  timeout_jiffies);
>> +
>> +	/* Decrement the user's timeout, in case we got interrupted
>> +	 * such that the ioctl will be restarted.
>> +	 */
>> +	args->timeout_ns -=3D jiffies_to_nsecs(jiffies - start);
>
> Just learned that if you want accuracy you need ktime_get before/after
> waiting, since the entire jiffies thing is too inaccurate - if the irqs
> gets delayed, jiffies isn't update. The other issue is that if you get
> interrupted too quickly, jiffies doesn't update and you end up sleeping
> for way too long.
>
> Not sure you care about that much accuracy :-)

Thanks for the note!  I've fixed it up.

How I wish the reservation was in the GEM BO and we could have a shared
ioctl to do this.

>> +/**
>> + * struct drm_v3d_submit_cl - ioctl argument for submitting commands to=
 the 3D
>> + * engine.
>> + *
>> + * This asks the kernel to have the GPU execute an optional binner
>> + * command list, and a render command list.
>> + */
>> +struct drm_v3d_submit_cl {
>> +	/* Pointer to the binner command list.
>> +	 *
>> +	 * This is the first set of commands executed, which runs the
>> +	 * coordinate shader to determine where primitives land on the screen,
>> +	 * then writes out the state updates and draw calls necessary per tile
>> +	 * to the tile allocation BO.
>> +	 */
>> +	__u32 bcl_start;
>> +
>> +	 /** End address of the BCL (first byte after the BCL) */
>> +	__u32 bcl_end;
>> +
>> +	/* Offset of the render command list.
>> +	 *
>> +	 * This is the second set of commands executed, which will either
>> +	 * execute the tiles that have been set up by the BCL, or a fixed set
>> +	 * of tiles (in the case of RCL-only blits).
>> +	 */
>> +	__u32 rcl_start;
>> +
>> +	 /** End address of the RCL (first byte after the RCL) */
>> +	__u32 rcl_end;
>> +
>> +	/** An optional sync object to wait on before starting the BCL. */
>> +	__u32 in_sync_bcl;
>> +	/** An optional sync object to wait on before starting the RCL. */
>> +	__u32 in_sync_rcl;
>> +	/** An optional sync object to place the completion fence in. */
>> +	__u32 out_sync;
>> +
>> +	/* Offset of the tile alloc memory
>> +	 *
>> +	 * This is optional on V3D 3.3 (where the CL can set the value) but
>> +	 * required on V3D 4.1.
>> +	 */
>> +	__u32 qma;
>> +
>> +	/** Size of the tile alloc memory. */
>> +	__u32 qms;
>> +
>> +	/** Offset of the tile state data array. */
>> +	__u32 qts;
>> +
>> +	/* Pointer to a u32 array of the BOs that are referenced by the job.
>> +	 */
>> +	__u64 bo_handles;
>> +
>> +	/* Number of BO handles passed in (size is that times 4). */
>> +	__u32 bo_handle_count;
>
> I think you want an __32 resv/flags/pad (and check it's 0) here, to align=
 with
> 8bytes. But I freely admit my ioctl struct layout knowledge is some good
> cargo-cult :-)

Can you explain the reason for that?  I thought we'd talked about this
before and decided that there was no need to align struct size to 8
bytes, unless it's a struct that would be submitted as an array.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlraevgACgkQtdYpNtH8
nuguig/8DImFsnZifvJnwttIDTRiVRvGRF9/f0K/Ea12ZBuYlrSTznveLFnLX95W
WNgUHM1okOU2b8x7tvWWhJYSSBCPHAS7nDrCYEIKPAJmwOb5P2p4cKD6saMGFMP6
BfSZi8/bmzFvN1gnVS5cSSKXwogy54cNANTalf/rLs9COf3tU5gJe1w1Oe4FfMGc
o1Uz9lkZxZQkNVu6DyStX4d+3vrsYVQJg91hi/ghpqnVU6CLW35ZhwJVQOc2Nw3C
oJMp86utIDr1HdXwB3uAQnzZtmqobDztzBZeiVhEidciLunCnPV5SQA5RvLHL848
k5f0N38n/sSmDL1jj1kCV2oryH1q1Li2GUwN9XDvYkreTx4i9avG/LIsIUxMyUAG
vlVvVpLFxxf2tL6eN894JTF6sIaHYq8rUnvxF+7KtvzDZMfbDaYIkMPPvayZR7lC
uIbd0W1WP8Dtz2R5WW0SsfoEP15O7Im7XenM5uQLeLmh9Bq85De7xhBFqTEvOVN/
i2LyHpeDD9gkTRdmCh1SumBMUDxNfN6LEID4a5nwrhQWMdfCIQlHEDSa9oWd2uIB
FGh1NApuN21Gh/sV53VI8TIOW35YV2Hik68cRzU1WFicZLN4hNnHyRthLluhP0yA
jj60728LK8xY64fdy0DdlvM2ezDY0AO8b9OJqAix4NSGyDD5xd8=
=A7Lz
-----END PGP SIGNATURE-----
--=-=-=--
