Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966087AbeEJBGG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:06:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40259 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966013AbeEJBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:06:04 -0400
X-Google-Smtp-Source: AB8JxZr4dqNkQXcDyo/1sbfkuFVN1LVrYw9gyDYVTdDQWil8Ug45H8WZwsmWckGBxSfH8vk3QlChgA==
Date: Wed, 9 May 2018 18:06:01 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 11/13] remoteproc: create vdev subdevice with specific
 dma memory pool
Message-ID: <20180510010601.GJ29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-12-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-12-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:
> @@ -479,6 +481,41 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  			goto unwind_vring_allocations;
>  	}
>  
> +	/* Initialise vdev subdevice */
> +	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> +	rvdev->dev.parent = rproc->dev.parent;
> +	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> +	dev_set_drvdata(&rvdev->dev, rvdev);
> +	dma_set_coherent_mask(&rvdev->dev, DMA_BIT_MASK(32));
> +
> +	ret = device_register(&rvdev->dev);
> +	if (ret)
> +		goto unwind_vring_allocations;
> +
> +	/* Try to find dedicated vdev buffer carveout */
> +	carveout = rproc_find_carveout_by_name(rproc, name);
> +
> +	if (carveout) {
> +		phys_addr_t pa;
> +
> +		if (carveout->va) {
> +			dev_warn(dev, "vdev %d buffer carveout already mapped\n",
> +				 rvdev->index);
> +			pa = rproc_va_to_pa(carveout->va);
> +		} else {
> +			/* Use dma address as carveout no memmapped yet */
> +			pa = (phys_addr_t)carveout->dma;
> +		}
> +
> +		/* Associate vdev buffer memory pool to vdev subdevice */
> +		ret = dmam_declare_coherent_memory(&rvdev->dev, pa,
> +						   carveout->da,
> +						   carveout->len,
> +						   DMA_MEMORY_EXCLUSIVE);
> +		if (ret < 0)
> +			goto unregister_device;
> +	}
> +

So with this there will be one more device between rproc->dev and the
virtio dev, for the sake of memory management. So e.g. a rpmsg device
will still need to allocate memory from dev->parent->parent; which now
possibly has a specific dma_mem.

Is it not possible to assign the memory to the vdev->dev and allow the
virtio devices can allocate memory from their parent device?

Regards,
Bjorn
