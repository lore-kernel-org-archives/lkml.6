Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81920879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F81920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeLMPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:45:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:44:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 200C4308429A;
        Thu, 13 Dec 2018 15:44:59 +0000 (UTC)
Received: from redhat.com (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with SMTP id 51CA2600C5;
        Thu, 13 Dec 2018 15:44:55 +0000 (UTC)
Date:   Thu, 13 Dec 2018 10:44:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20181213102713-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213101022.12475-4-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Dec 2018 15:44:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:10:22PM +0800, Jason Wang wrote:
> It was noticed that the copy_user() friends that was used to access
> virtqueue metdata tends to be very expensive for dataplane
> implementation like vhost since it involves lots of software check,
> speculation barrier, hardware feature toggling (e.g SMAP). The
> extra cost will be more obvious when transferring small packets.
> 
> This patch tries to eliminate those overhead by pin vq metadata pages
> and access them through vmap(). During SET_VRING_ADDR, we will setup
> those mappings and memory accessors are modified to use pointers to
> access the metadata directly.
> 
> Note, this was only done when device IOTLB is not enabled. We could
> use similar method to optimize it in the future.
> 
> Tests shows about ~24% improvement on TX PPS when using virtio-user +
> vhost_net + xdp1 on TAP (CONFIG_HARDENED_USERCOPY is not enabled):
> 
> Before: ~5.0Mpps
> After:  ~6.1Mpps
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 178 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h |  11 +++
>  2 files changed, 189 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index bafe39d2e637..1bd24203afb6 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -443,6 +443,9 @@ void vhost_dev_init(struct vhost_dev *dev,
>  		vq->indirect = NULL;
>  		vq->heads = NULL;
>  		vq->dev = dev;
> +		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
> +		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
> +		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
>  		mutex_init(&vq->mutex);
>  		vhost_vq_reset(dev, vq);
>  		if (vq->handle_kick)
> @@ -614,6 +617,102 @@ static void vhost_clear_msg(struct vhost_dev *dev)
>  	spin_unlock(&dev->iotlb_lock);
>  }
>  
> +static int vhost_init_vmap(struct vhost_vmap *map, unsigned long uaddr,
> +			   size_t size, int write)
> +{
> +	struct page **pages;
> +	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
> +	int npinned;
> +	void *vaddr;
> +
> +	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
> +	if (npinned != npages)
> +		goto err;
> +

As I said I have doubts about the whole approach, but this
implementation in particular isn't a good idea
as it keeps the page around forever.
So no THP, no NUMA rebalancing, userspace-controlled
amount of memory locked up and not accounted for.

Don't get me wrong it's a great patch in an ideal world.
But then in an ideal world no barriers smap etc are necessary at all.


> +	vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
> +	if (!vaddr)
> +		goto err;
> +
> +	map->pages = pages;
> +	map->addr = vaddr + (uaddr & (PAGE_SIZE - 1));
> +	map->npages = npages;
> +
> +	return 0;
> +
> +err:
> +	if (npinned > 0)
> +		release_pages(pages, npinned);
> +	kfree(pages);
> +	return -EFAULT;
> +}
> +
> +static void vhost_uninit_vmap(struct vhost_vmap *map)
> +{
> +	if (!map->addr)
> +		return;
> +
> +	vunmap(map->addr);
> +	release_pages(map->pages, map->npages);
> +	kfree(map->pages);
> +
> +	map->addr = NULL;
> +	map->pages = NULL;
> +	map->npages = 0;
> +}
> +
> +static void vhost_clean_vmaps(struct vhost_virtqueue *vq)
> +{
> +	vhost_uninit_vmap(&vq->avail_ring);
> +	vhost_uninit_vmap(&vq->desc_ring);
> +	vhost_uninit_vmap(&vq->used_ring);
> +}
> +
> +static int vhost_setup_vmaps(struct vhost_virtqueue *vq, unsigned long avail,
> +			     unsigned long desc, unsigned long used)
> +{
> +	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +	size_t avail_size, desc_size, used_size;
> +	int ret;
> +
> +	vhost_clean_vmaps(vq);
> +
> +	avail_size = sizeof(*vq->avail) +
> +		     sizeof(*vq->avail->ring) * vq->num + event;
> +	ret = vhost_init_vmap(&vq->avail_ring, avail, avail_size, false);
> +	if (ret) {
> +		vq_err(vq, "Fail to setup vmap for avail ring!\n");
> +		goto err_avail;
> +	}
> +
> +	desc_size = sizeof(*vq->desc) * vq->num;
> +	ret = vhost_init_vmap(&vq->desc_ring, desc, desc_size, false);
> +	if (ret) {
> +		vq_err(vq, "Fail to setup vmap for desc ring!\n");
> +		goto err_desc;
> +	}
> +
> +	used_size = sizeof(*vq->used) +
> +		    sizeof(*vq->used->ring) * vq->num + event;
> +	ret = vhost_init_vmap(&vq->used_ring, used, used_size, true);
> +	if (ret) {
> +		vq_err(vq, "Fail to setup vmap for used ring!\n");
> +		goto err_used;
> +	}
> +
> +	return 0;
> +
> +err_used:
> +	vhost_uninit_vmap(&vq->used_ring);
> +err_desc:
> +	vhost_uninit_vmap(&vq->avail_ring);
> +err_avail:
> +	return -EFAULT;
> +}
> +
>  void vhost_dev_cleanup(struct vhost_dev *dev)
>  {
>  	int i;
> @@ -626,6 +725,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		if (dev->vqs[i]->call_ctx)
>  			eventfd_ctx_put(dev->vqs[i]->call_ctx);
>  		vhost_vq_reset(dev, dev->vqs[i]);
> +		vhost_clean_vmaps(dev->vqs[i]);
>  	}
>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> @@ -873,6 +973,14 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>  
>  static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_used *used = vq->used_ring.addr;
> +
> +		*((__virtio16 *)&used->ring[vq->num]) =
> +			cpu_to_vhost16(vq, vq->avail_idx);
> +		return 0;
> +	}
> +
>  	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
>  			      vhost_avail_event(vq));
>  }
> @@ -881,6 +989,13 @@ static inline int vhost_put_used(struct vhost_virtqueue *vq,
>  				 struct vring_used_elem *head, int idx,
>  				 int count)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_used *used = vq->used_ring.addr;
> +
> +		memcpy(used->ring + idx, head, count * sizeof(*head));
> +		return 0;
> +	}
> +
>  	return vhost_copy_to_user(vq, vq->used->ring + idx, head,
>  				  count * sizeof(*head));
>  }
> @@ -888,6 +1003,13 @@ static inline int vhost_put_used(struct vhost_virtqueue *vq,
>  static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
>  
>  {
> +	if (!vq->iotlb) {
> +		struct vring_used *used = vq->used_ring.addr;
> +
> +		used->flags = cpu_to_vhost16(vq, vq->used_flags);
> +		return 0;
> +	}
> +
>  	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
>  			      &vq->used->flags);
>  }
> @@ -895,6 +1017,13 @@ static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
>  static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
>  
>  {
> +	if (!vq->iotlb) {
> +		struct vring_used *used = vq->used_ring.addr;
> +
> +		used->idx = cpu_to_vhost16(vq, vq->last_used_idx);
> +		return 0;
> +	}
> +
>  	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
>  			      &vq->used->idx);
>  }
> @@ -926,12 +1055,26 @@ static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
>  static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
>  				      __virtio16 *idx)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_avail *avail = vq->avail_ring.addr;
> +
> +		*idx = avail->idx;
> +		return 0;
> +	}
> +
>  	return vhost_get_avail(vq, *idx, &vq->avail->idx);
>  }
>  
>  static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
>  				       __virtio16 *head, int idx)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_avail *avail = vq->avail_ring.addr;
> +
> +		*head = avail->ring[idx & (vq->num - 1)];
> +		return 0;
> +	}
> +
>  	return vhost_get_avail(vq, *head,
>  			       &vq->avail->ring[idx & (vq->num - 1)]);
>  }
> @@ -939,24 +1082,52 @@ static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
>  static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
>  					__virtio16 *flags)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_avail *avail = vq->avail_ring.addr;
> +
> +		*flags = avail->flags;
> +		return 0;
> +	}
> +
>  	return vhost_get_avail(vq, *flags, &vq->avail->flags);
>  }
>  
>  static inline int vhost_get_used_event(struct vhost_virtqueue *vq,
>  				       __virtio16 *event)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_avail *avail = vq->avail_ring.addr;
> +
> +		*event = (__virtio16)avail->ring[vq->num];
> +		return 0;
> +	}
> +
>  	return vhost_get_avail(vq, *event, vhost_used_event(vq));
>  }
>  
>  static inline int vhost_get_used_idx(struct vhost_virtqueue *vq,
>  				     __virtio16 *idx)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_used *used = vq->used_ring.addr;
> +
> +		*idx = used->idx;
> +		return 0;
> +	}
> +
>  	return vhost_get_used(vq, *idx, &vq->used->idx);
>  }
>  
>  static inline int vhost_get_desc(struct vhost_virtqueue *vq,
>  				 struct vring_desc *desc, int idx)
>  {
> +	if (!vq->iotlb) {
> +		struct vring_desc *d = vq->desc_ring.addr;
> +
> +		*desc = *(d + idx);
> +		return 0;
> +	}
> +
>  	return vhost_copy_from_user(vq, desc, vq->desc + idx, sizeof(*desc));
>  }
>  
> @@ -1551,6 +1722,13 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  			}
>  		}
>  
> +		if (!vq->iotlb && vhost_setup_vmaps(vq, a.avail_user_addr,
> +							a.desc_user_addr,
> +							a.used_user_addr)) {
> +			r = -EINVAL;
> +			break;
> +		}
> +
>  		vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
>  		vq->desc = (void __user *)(unsigned long)a.desc_user_addr;
>  		vq->avail = (void __user *)(unsigned long)a.avail_user_addr;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 466ef7542291..89dc0ad3d055 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -80,6 +80,12 @@ enum vhost_uaddr_type {
>  	VHOST_NUM_ADDRS = 3,
>  };
>  
> +struct vhost_vmap {
> +	struct page **pages;
> +	void *addr;
> +	int npages;
> +};
> +
>  /* The virtqueue structure describes a queue attached to a device. */
>  struct vhost_virtqueue {
>  	struct vhost_dev *dev;
> @@ -90,6 +96,11 @@ struct vhost_virtqueue {
>  	struct vring_desc __user *desc;
>  	struct vring_avail __user *avail;
>  	struct vring_used __user *used;
> +
> +	struct vhost_vmap avail_ring;
> +	struct vhost_vmap desc_ring;
> +	struct vhost_vmap used_ring;
> +
>  	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
>  	struct file *kick;
>  	struct eventfd_ctx *call_ctx;
> -- 
> 2.17.1
