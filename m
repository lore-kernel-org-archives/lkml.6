Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966071AbeEJAyD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:54:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43606 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965997AbeEJAyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:54:01 -0400
X-Google-Smtp-Source: AB8JxZp3261yJU5lV1oLY0xTkzoydUySJXVuoTPlXa4t6MVXwgtONvVV7QQMDsgzZ0kbNMFUX+t7QA==
Date: Wed, 9 May 2018 17:53:58 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 03/13] remoteproc: add release ops in rproc_mem_entry
 struct
Message-ID: <20180510005358.GG29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-4-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-4-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:

> Memory entry could be allocated in different ways (ioremap,
> dma_alloc_coherent, internal RAM allocator...).
> This patch introduces a release ops in rproc_mem_entry structure
> to associate dedicated release mechanism to each memory entry descriptor
> in order to keep remoteproc core generic.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 23 +++++++++++++++++++++--
>  include/linux/remoteproc.h           |  5 ++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index eb1b779..5f11536 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -597,6 +597,24 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
>  }
>  
>  /**
> + * rproc_release_carveout() - release acquired carveout
> + * @rproc: rproc handle
> + * @mem: the memory entry to release
> + *
> + * This function releases specified memory entry @mem allocated via
> + * dma_alloc_coherent() function by @rproc.
> + */
> +static int rproc_release_carveout(struct rproc *rproc,
> +				  struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = &rproc->dev;
> +
> +	/* clean up carveout allocations */
> +	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
> +	return 0;
> +}
> +
> +/**
>   * rproc_handle_carveout() - handle phys contig memory allocation requests
>   * @rproc: rproc handle
>   * @rsc: the resource entry
> @@ -730,6 +748,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	carveout->len = rsc->len;
>  	carveout->dma = dma;
>  	carveout->da = rsc->da;
> +	carveout->release = rproc_release_carveout;
>  
>  	list_add_tail(&carveout->node, &rproc->carveouts);
>  
> @@ -863,8 +882,8 @@ static void rproc_resource_cleanup(struct rproc *rproc)
>  
>  	/* clean up carveout allocations */
>  	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
> -		dma_free_coherent(dev->parent, entry->len, entry->va,
> -				  entry->dma);
> +		if (entry->release)
> +			entry->release(rproc, entry);
>  		list_del(&entry->node);
>  		kfree(entry);
>  	}
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 728d421..dedc138 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -305,12 +305,15 @@ struct fw_rsc_vdev {
>  	struct fw_rsc_vdev_vring vring[0];
>  } __packed;
>  
> +struct rproc;
> +
>  /**
>   * struct rproc_mem_entry - memory entry descriptor
>   * @va:	virtual address
>   * @dma: dma address
>   * @len: length, in bytes
>   * @da: device address
> + * @release: release associated memory
>   * @priv: associated data
>   * @node: list node
>   */
> @@ -321,9 +324,9 @@ struct rproc_mem_entry {
>  	u32 da;
>  	void *priv;
>  	struct list_head node;
> +	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
>  };
>  
> -struct rproc;
>  struct firmware;
>  
>  /**
> -- 
> 1.9.1
> 
