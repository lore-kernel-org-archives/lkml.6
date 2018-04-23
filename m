Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDWFmW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:42:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeDWFmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:42:21 -0400
Subject: Re: [RFC v2] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jfreimann@redhat.com
References: <20180401141216.8969-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <515e635b-bc80-9b8d-72f9-b390ae5103ec@redhat.com>
Date: Mon, 23 Apr 2018 13:42:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180401141216.8969-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月01日 22:12, Tiwei Bie wrote:
> Hello everyone,
>
> This RFC implements packed ring support for virtio driver.
>
> The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
> by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
> Minor changes are needed for the vhost code, e.g. to kick the guest.
>
> TODO:
> - Refinements and bug fixes;
> - Split into small patches;
> - Test indirect descriptor support;
> - Test/fix event suppression support;
> - Test devices other than net;
>
> RFC v1 -> RFC v2:
> - Add indirect descriptor support - compile test only;
> - Add event suppression supprt - compile test only;
> - Move vring_packed_init() out of uapi (Jason, MST);
> - Merge two loops into one in virtqueue_add_packed() (Jason);
> - Split vring_unmap_one() for packed ring and split ring (Jason);
> - Avoid using '%' operator (Jason);
> - Rename free_head -> next_avail_idx (Jason);
> - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> - Some other refinements and bug fixes;
>
> Thanks!
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/virtio/virtio_ring.c       | 1094 +++++++++++++++++++++++++++++-------
>   include/linux/virtio_ring.h        |    8 +-
>   include/uapi/linux/virtio_config.h |   12 +-
>   include/uapi/linux/virtio_ring.h   |   61 ++
>   4 files changed, 980 insertions(+), 195 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71458f493cf8..0515dca34d77 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -58,14 +58,15 @@
>   

[...]

> +
> +	if (vq->indirect) {
> +		u32 len;
> +
> +		desc = vq->desc_state[head].indir_desc;
> +		/* Free the indirect table, if any, now that it's unmapped. */
> +		if (!desc)
> +			goto out;
> +
> +		len = virtio32_to_cpu(vq->vq.vdev,
> +				      vq->vring_packed.desc[head].len);
> +
> +		BUG_ON(!(vq->vring_packed.desc[head].flags &
> +			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));

It looks to me spec does not force to keep VRING_DESC_F_INDIRECT here. 
So we can safely remove this BUG_ON() here.

> +		BUG_ON(len == 0 || len % sizeof(struct vring_packed_desc));

Len could be ignored for used descriptor according to the spec, so we 
need remove this BUG_ON() too.

The reason is we don't touch descriptor ring in the case of split, so 
BUG_ON()s may help there.

> +
> +		for (j = 0; j < len / sizeof(struct vring_packed_desc); j++)
> +			vring_unmap_one_packed(vq, &desc[j]);
> +
> +		kfree(desc);
> +		vq->desc_state[head].indir_desc = NULL;
> +	} else if (ctx) {
> +		*ctx = vq->desc_state[head].indir_desc;
> +	}
> +
> +out:
> +	return vq->desc_state[head].num;
> +}
> +
> +static inline bool more_used_split(const struct vring_virtqueue *vq)
>   {
>   	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
>   }
>   
> +static inline bool more_used_packed(const struct vring_virtqueue *vq)
> +{
> +	u16 last_used, flags;
> +	bool avail, used;
> +
> +	if (vq->vq.num_free == vq->vring_packed.num)
> +		return false;
> +
> +	last_used = vq->last_used_idx;
> +	flags = virtio16_to_cpu(vq->vq.vdev,
> +				vq->vring_packed.desc[last_used].flags);
> +	avail = flags & VRING_DESC_F_AVAIL(1);
> +	used = flags & VRING_DESC_F_USED(1);
> +
> +	return avail == used;
> +}

This looks interesting, spec said:

"
Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different for an 
available descriptor and
equal for a used descriptor.
Note that this observation is mostly useful for sanity-checking as these 
are necessary but not sufficient
conditions - for example, all descriptors are zero-initialized. To 
detect used and available descriptors it is
possible for drivers and devices to keep track of the last observed 
value of VIRTQ_DESC_F_USED/VIRTQ_-
DESC_F_AVAIL. Other techniques to detect 
VIRTQ_DESC_F_AVAIL/VIRTQ_DESC_F_USED bit changes
might also be possible.
"

So it looks to me it was not sufficient, looking at the example codes in 
spec, do we need to track last seen used_wrap_counter here?

Thanks
