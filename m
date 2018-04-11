Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDKNXj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:23:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753091AbeDKNXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:23:36 -0400
Date: Wed, 11 Apr 2018 16:23:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>, jasowang@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost: return bool from *_access_ok() functions
Message-ID: <20180411162327-mutt-send-email-mst@kernel.org>
References: <20180411023541.15776-1-stefanha@redhat.com>
 <20180411023541.15776-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411023541.15776-3-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:35:41AM +0800, Stefan Hajnoczi wrote:
> Currently vhost *_access_ok() functions return int.  This is error-prone
> because there are two popular conventions:
> 
> 1. 0 means failure, 1 means success
> 2. -errno means failure, 0 means success
> 
> Although vhost mostly uses #1, it does not do so consistently.
> umem_access_ok() uses #2.
> 
> This patch changes the return type from int to bool so that false means
> failure and true means success.  This eliminates a potential source of
> errors.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vhost.h |  4 ++--
>  drivers/vhost/vhost.c | 66 +++++++++++++++++++++++++--------------------------
>  2 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index d8ee85ae8fdc..6c844b90a168 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -178,8 +178,8 @@ void vhost_dev_cleanup(struct vhost_dev *);
>  void vhost_dev_stop(struct vhost_dev *);
>  long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
>  long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
> -int vhost_vq_access_ok(struct vhost_virtqueue *vq);
> -int vhost_log_access_ok(struct vhost_dev *);
> +bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
> +bool vhost_log_access_ok(struct vhost_dev *);
>  
>  int vhost_get_vq_desc(struct vhost_virtqueue *,
>  		      struct iovec iov[], unsigned int iov_count,
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fc805b7fad9d..0fcb51a9940c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -641,14 +641,14 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
>  
> -static int log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
> +static bool log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
>  {
>  	u64 a = addr / VHOST_PAGE_SIZE / 8;
>  
>  	/* Make sure 64 bit math will not overflow. */
>  	if (a > ULONG_MAX - (unsigned long)log_base ||
>  	    a + (unsigned long)log_base > ULONG_MAX)
> -		return 0;
> +		return false;
>  
>  	return access_ok(VERIFY_WRITE, log_base + a,
>  			 (sz + VHOST_PAGE_SIZE * 8 - 1) / VHOST_PAGE_SIZE / 8);
> @@ -661,30 +661,30 @@ static bool vhost_overflow(u64 uaddr, u64 size)
>  }
>  
>  /* Caller should have vq mutex and device mutex. */
> -static int vq_memory_access_ok(void __user *log_base, struct vhost_umem *umem,
> -			       int log_all)
> +static bool vq_memory_access_ok(void __user *log_base, struct vhost_umem *umem,
> +				int log_all)
>  {
>  	struct vhost_umem_node *node;
>  
>  	if (!umem)
> -		return 0;
> +		return false;
>  
>  	list_for_each_entry(node, &umem->umem_list, link) {
>  		unsigned long a = node->userspace_addr;
>  
>  		if (vhost_overflow(node->userspace_addr, node->size))
> -			return 0;
> +			return false;
>  
>  
>  		if (!access_ok(VERIFY_WRITE, (void __user *)a,
>  				    node->size))
> -			return 0;
> +			return false;
>  		else if (log_all && !log_access_ok(log_base,
>  						   node->start,
>  						   node->size))
> -			return 0;
> +			return false;
>  	}
> -	return 1;
> +	return true;
>  }
>  
>  static inline void __user *vhost_vq_meta_fetch(struct vhost_virtqueue *vq,
> @@ -701,13 +701,13 @@ static inline void __user *vhost_vq_meta_fetch(struct vhost_virtqueue *vq,
>  
>  /* Can we switch to this memory table? */
>  /* Caller should have device mutex but not vq mutex */
> -static int memory_access_ok(struct vhost_dev *d, struct vhost_umem *umem,
> -			    int log_all)
> +static bool memory_access_ok(struct vhost_dev *d, struct vhost_umem *umem,
> +			     int log_all)
>  {
>  	int i;
>  
>  	for (i = 0; i < d->nvqs; ++i) {
> -		int ok;
> +		bool ok;
>  		bool log;
>  
>  		mutex_lock(&d->vqs[i]->mutex);
> @@ -717,12 +717,12 @@ static int memory_access_ok(struct vhost_dev *d, struct vhost_umem *umem,
>  			ok = vq_memory_access_ok(d->vqs[i]->log_base,
>  						 umem, log);
>  		else
> -			ok = 1;
> +			ok = true;
>  		mutex_unlock(&d->vqs[i]->mutex);
>  		if (!ok)
> -			return 0;
> +			return false;
>  	}
> -	return 1;
> +	return true;
>  }
>  
>  static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
> @@ -959,21 +959,21 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
>  	spin_unlock(&d->iotlb_lock);
>  }
>  
> -static int umem_access_ok(u64 uaddr, u64 size, int access)
> +static bool umem_access_ok(u64 uaddr, u64 size, int access)
>  {
>  	unsigned long a = uaddr;
>  
>  	/* Make sure 64 bit math will not overflow. */
>  	if (vhost_overflow(uaddr, size))
> -		return -EFAULT;
> +		return false;
>  
>  	if ((access & VHOST_ACCESS_RO) &&
>  	    !access_ok(VERIFY_READ, (void __user *)a, size))
> -		return -EFAULT;
> +		return false;
>  	if ((access & VHOST_ACCESS_WO) &&
>  	    !access_ok(VERIFY_WRITE, (void __user *)a, size))
> -		return -EFAULT;
> -	return 0;
> +		return false;
> +	return true;
>  }
>  
>  static int vhost_process_iotlb_msg(struct vhost_dev *dev,
> @@ -988,7 +988,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  			ret = -EFAULT;
>  			break;
>  		}
> -		if (umem_access_ok(msg->uaddr, msg->size, msg->perm)) {
> +		if (!umem_access_ok(msg->uaddr, msg->size, msg->perm)) {
>  			ret = -EFAULT;
>  			break;
>  		}
> @@ -1135,10 +1135,10 @@ static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
>  	return 0;
>  }
>  
> -static int vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
> -			struct vring_desc __user *desc,
> -			struct vring_avail __user *avail,
> -			struct vring_used __user *used)
> +static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
> +			 struct vring_desc __user *desc,
> +			 struct vring_avail __user *avail,
> +			 struct vring_used __user *used)
>  
>  {
>  	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> @@ -1161,8 +1161,8 @@ static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
>  		vq->meta_iotlb[type] = node;
>  }
>  
> -static int iotlb_access_ok(struct vhost_virtqueue *vq,
> -			   int access, u64 addr, u64 len, int type)
> +static bool iotlb_access_ok(struct vhost_virtqueue *vq,
> +			    int access, u64 addr, u64 len, int type)
>  {
>  	const struct vhost_umem_node *node;
>  	struct vhost_umem *umem = vq->iotlb;
> @@ -1220,7 +1220,7 @@ EXPORT_SYMBOL_GPL(vq_iotlb_prefetch);
>  
>  /* Can we log writes? */
>  /* Caller should have device mutex but not vq mutex */
> -int vhost_log_access_ok(struct vhost_dev *dev)
> +bool vhost_log_access_ok(struct vhost_dev *dev)
>  {
>  	return memory_access_ok(dev, dev->umem, 1);
>  }
> @@ -1228,8 +1228,8 @@ EXPORT_SYMBOL_GPL(vhost_log_access_ok);
>  
>  /* Verify access for write logging. */
>  /* Caller should have vq mutex and device mutex */
> -static int vq_log_access_ok(struct vhost_virtqueue *vq,
> -			    void __user *log_base)
> +static bool vq_log_access_ok(struct vhost_virtqueue *vq,
> +			     void __user *log_base)
>  {
>  	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>  
> @@ -1242,14 +1242,14 @@ static int vq_log_access_ok(struct vhost_virtqueue *vq,
>  
>  /* Can we start vq? */
>  /* Caller should have vq mutex and device mutex */
> -int vhost_vq_access_ok(struct vhost_virtqueue *vq)
> +bool vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  {
>  	if (!vq_log_access_ok(vq, vq->log_base))
> -		return 0;
> +		return false;
>  
>  	/* Access validation occurs at prefetch time with IOTLB */
>  	if (vq->iotlb)
> -		return 1;
> +		return true;
>  
>  	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
>  }
> -- 
> 2.14.3
