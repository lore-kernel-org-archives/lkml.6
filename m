Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeDXBFO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:05:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932652AbeDXBFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:05:11 -0400
Date: Tue, 24 Apr 2018 04:05:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
Subject: Re: [RFC v2] virtio: support packed ring
Message-ID: <20180424040258-mutt-send-email-mst@kernel.org>
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <515e635b-bc80-9b8d-72f9-b390ae5103ec@redhat.com>
 <20180423092908.77rii3gi7dcaf7o6@debian>
 <e08c55df-6ea2-cf7f-d7c9-91e55913ab16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e08c55df-6ea2-cf7f-d7c9-91e55913ab16@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 08:54:52AM +0800, Jason Wang wrote:
> 
> 
> On 2018年04月23日 17:29, Tiwei Bie wrote:
> > On Mon, Apr 23, 2018 at 01:42:14PM +0800, Jason Wang wrote:
> > > On 2018年04月01日 22:12, Tiwei Bie wrote:
> > > > Hello everyone,
> > > > 
> > > > This RFC implements packed ring support for virtio driver.
> > > > 
> > > > The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
> > > > by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
> > > > Minor changes are needed for the vhost code, e.g. to kick the guest.
> > > > 
> > > > TODO:
> > > > - Refinements and bug fixes;
> > > > - Split into small patches;
> > > > - Test indirect descriptor support;
> > > > - Test/fix event suppression support;
> > > > - Test devices other than net;
> > > > 
> > > > RFC v1 -> RFC v2:
> > > > - Add indirect descriptor support - compile test only;
> > > > - Add event suppression supprt - compile test only;
> > > > - Move vring_packed_init() out of uapi (Jason, MST);
> > > > - Merge two loops into one in virtqueue_add_packed() (Jason);
> > > > - Split vring_unmap_one() for packed ring and split ring (Jason);
> > > > - Avoid using '%' operator (Jason);
> > > > - Rename free_head -> next_avail_idx (Jason);
> > > > - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> > > > - Some other refinements and bug fixes;
> > > > 
> > > > Thanks!
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > ---
> > > >    drivers/virtio/virtio_ring.c       | 1094 +++++++++++++++++++++++++++++-------
> > > >    include/linux/virtio_ring.h        |    8 +-
> > > >    include/uapi/linux/virtio_config.h |   12 +-
> > > >    include/uapi/linux/virtio_ring.h   |   61 ++
> > > >    4 files changed, 980 insertions(+), 195 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 71458f493cf8..0515dca34d77 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -58,14 +58,15 @@
> > > [...]
> > > 
> > > > +
> > > > +	if (vq->indirect) {
> > > > +		u32 len;
> > > > +
> > > > +		desc = vq->desc_state[head].indir_desc;
> > > > +		/* Free the indirect table, if any, now that it's unmapped. */
> > > > +		if (!desc)
> > > > +			goto out;
> > > > +
> > > > +		len = virtio32_to_cpu(vq->vq.vdev,
> > > > +				      vq->vring_packed.desc[head].len);
> > > > +
> > > > +		BUG_ON(!(vq->vring_packed.desc[head].flags &
> > > > +			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
> > > It looks to me spec does not force to keep VRING_DESC_F_INDIRECT here. So we
> > > can safely remove this BUG_ON() here.
> > > 
> > > > +		BUG_ON(len == 0 || len % sizeof(struct vring_packed_desc));
> > > Len could be ignored for used descriptor according to the spec, so we need
> > > remove this BUG_ON() too.
> > Yeah, you're right! The BUG_ON() isn't right. I'll remove it.
> > And I think something related to this in the spec isn't very
> > clear currently.
> > 
> > In the spec, there are below words:
> > 
> > https://github.com/oasis-tcs/virtio-spec/blob/d4fec517dfcf/packed-ring.tex#L272
> > """
> > In descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
> > is reserved and is ignored by the device.
> > """
> > 
> > So when device writes back an used descriptor in this case,
> > device may not set the VIRTQ_DESC_F_WRITE flag as the flag
> > is reserved and should be ignored.
> > 
> > https://github.com/oasis-tcs/virtio-spec/blob/d4fec517dfcf/packed-ring.tex#L170
> > """
> > Element Length is reserved for used descriptors without the
> > VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
> > """
> > 
> > And this is the way how driver ignores the `len` in an used
> > descriptor.
> > 
> > https://github.com/oasis-tcs/virtio-spec/blob/d4fec517dfcf/packed-ring.tex#L241
> > """
> > To increase ring capacity the driver can store a (read-only
> > by the device) table of indirect descriptors anywhere in memory,
> > and insert a descriptor in the main virtqueue (with \field{Flags}
> > bit VIRTQ_DESC_F_INDIRECT on) that refers to a buffer element
> > containing this indirect descriptor table;
> > """
> > 
> > So the indirect descriptors in the table are read-only by
> > the device. And the only descriptor which is writeable by
> > the device is the descriptor in the main virtqueue (with
> > Flags bit VIRTQ_DESC_F_INDIRECT on). So if we ignore the
> > `len` in this descriptor, we won't be able to get the
> > length of the data written by the device.
> > 
> > So I think the `len` in this descriptor will carry the
> > length of the data written by the device (if the buffers
> > are writable to the device) even if the VIRTQ_DESC_F_WRITE
> > isn't set by the device. How do you think?
> 
> Yes I think so. But we'd better need clarification from Michael.

I think if you use a descriptor, and you want to supply len
to guest, you set VIRTQ_DESC_F_WRITE in the used descriptor.
Spec also says you must not set VIRTQ_DESC_F_INDIRECT then.
If that's a problem we could look at relaxing that last requirement -
does driver want INDIRECT in used descriptor to match
the value in the avail descriptor for some reason?

> > 
> > 
> > > The reason is we don't touch descriptor ring in the case of split, so
> > > BUG_ON()s may help there.
> > > 
> > > > +
> > > > +		for (j = 0; j < len / sizeof(struct vring_packed_desc); j++)
> > > > +			vring_unmap_one_packed(vq, &desc[j]);
> > > > +
> > > > +		kfree(desc);
> > > > +		vq->desc_state[head].indir_desc = NULL;
> > > > +	} else if (ctx) {
> > > > +		*ctx = vq->desc_state[head].indir_desc;
> > > > +	}
> > > > +
> > > > +out:
> > > > +	return vq->desc_state[head].num;
> > > > +}
> > > > +
> > > > +static inline bool more_used_split(const struct vring_virtqueue *vq)
> > > >    {
> > > >    	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
> > > >    }
> > > > +static inline bool more_used_packed(const struct vring_virtqueue *vq)
> > > > +{
> > > > +	u16 last_used, flags;
> > > > +	bool avail, used;
> > > > +
> > > > +	if (vq->vq.num_free == vq->vring_packed.num)
> > > > +		return false;
> > > > +
> > > > +	last_used = vq->last_used_idx;
> > > > +	flags = virtio16_to_cpu(vq->vq.vdev,
> > > > +				vq->vring_packed.desc[last_used].flags);
> > > > +	avail = flags & VRING_DESC_F_AVAIL(1);
> > > > +	used = flags & VRING_DESC_F_USED(1);
> > > > +
> > > > +	return avail == used;
> > > > +}
> > > This looks interesting, spec said:
> > > 
> > > "
> > > Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different for an
> > > available descriptor and
> > > equal for a used descriptor.
> > > Note that this observation is mostly useful for sanity-checking as these are
> > > necessary but not sufficient
> > > conditions - for example, all descriptors are zero-initialized. To detect
> > > used and available descriptors it is
> > > possible for drivers and devices to keep track of the last observed value of
> > > VIRTQ_DESC_F_USED/VIRTQ_-
> > > DESC_F_AVAIL. Other techniques to detect
> > > VIRTQ_DESC_F_AVAIL/VIRTQ_DESC_F_USED bit changes
> > > might also be possible.
> > > "
> > > 
> > > So it looks to me it was not sufficient, looking at the example codes in
> > > spec, do we need to track last seen used_wrap_counter here?
> > I don't think we have to track used_wrap_counter in
> > driver. There was a discussion on this:
> > 
> > https://lists.oasis-open.org/archives/virtio-dev/201802/msg00177.html
> > 
> > And after that, below sentence was added (it's also
> > in the above words you quoted):
> > 
> > """
> > Other techniques to detect
> > VIRTQ_DESC_F_AVAIL/VIRTQ_DESC_F_USED bit changes
> > might also be possible.
> > """
> > 
> > Best regards,
> > Tiwei Bie
> 
> I see, the extra condition "if (vq->vq.num_free == vq->vring_packed.num)"
> help in this case.
> 
> Thanks

I still think tracking a wrap counter is better.

> > 
> > > Thanks
