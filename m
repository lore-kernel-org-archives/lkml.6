Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbeDYOxK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754196AbeDYOxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:53:06 -0400
Date: Wed, 25 Apr 2018 17:52:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org,
        jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com,
        david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org,
        marcel@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com,
        lcapitulino@redhat.com
Subject: Re: [RFC v2 1/2] virtio: add pmem driver
Message-ID: <20180425174705-mutt-send-email-mst@kernel.org>
References: <20180425112415.12327-1-pagupta@redhat.com>
 <20180425112415.12327-2-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112415.12327-2-pagupta@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 04:54:13PM +0530, Pankaj Gupta wrote:
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 6d5c3b2..5ebd049 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_PMEM         21 /* virtio pmem */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */

Please register the device id with virtio TC.


> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 0000000..2ec27cb
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,58 @@
> +/* Virtio pmem Driver
> + *
> + * Discovers persitent memory range information
> + * from host and provides a virtio based flushing
> + * interface.
> + */
> +
> +#ifndef _LINUX_VIRTIO_PMEM_H
> +#define _LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
> +
> +
> +struct virtio_pmem_config {
> +

don't add empty lines pls.

> +	uint64_t start;
> +	uint64_t size;

Used LE fields for everything.

> +};
> +
> +struct virtio_pmem {
> +
> +	struct virtio_device *vdev;
> +	struct virtqueue *req_vq;
> +
> +	uint64_t start;
> +	uint64_t size;
> +} __packed;

This does not belong in uapi, and should not be packed either.

> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +void virtio_pmem_flush(struct device *dev)
> +{
> +	struct scatterlist sg;
> +	struct virtio_device *vdev  = dev_to_virtio(dev->parent->parent);
> +	struct virtio_pmem   *vpmem = vdev->priv;
> +	char *buf = "FLUSH";
> +	int err;
> +
> +	sg_init_one(&sg, buf, sizeof(buf));
> +
> +	err = virtqueue_add_outbuf(vpmem->req_vq, &sg, 1, buf, GFP_KERNEL);
> +
> +	if (err) {
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> +		return;
> +	}
> +
> +	virtqueue_kick(vpmem->req_vq);
> +};

this doesn't belong in uapi.

> +
> +#endif
> -- 
> 2.9.3
