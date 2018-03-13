Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AG47ELvZJL2E6QUyhnYsoaYf/FIkkxgw/BgkL12oyVytLKjYDgJ9MLprFJiLEzHsJ/4XKeaS5TPu
ARC-Seal: i=1; a=rsa-sha256; t=1520933991; cv=none;
        d=google.com; s=arc-20160816;
        b=xmzErhtkl4Z9eE0ZRqLw10uSkK6mXZ0LY2wyr4VJP8iYpDat3hpRddd19hPvspN7Sr
         6v4i1ZC1HqZjegm9aLM7ILRWysrZCtt5rfyTS0ULGBzeiXdgAwhSpl16sru2L4mPjENU
         Zw98caZwLOI1lINT1CzPNnE0bPd05j2baESIxibMWGPCoGLzZSo4J14sMEiesBf/Rsp3
         66L1pZFWA3O5iBfj59keWq6uOHOAIdp/L6FNrM5B3aUQuaW08dDlM8H+7/hZbqnR96RY
         6C3qWXEH9PF1A5h1tbYsrhb0lHbRHoI0GL99zndiO7tfefUxXUjyXhqmM9esjepBnSUX
         2NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=QWbK8WpUxSJzqR3+i43mX1HR9b6GZmUo7JfJAtbVAnU=;
        b=TFLOAo2L4qam6/ejtPn4nnx7ubEu1HMRARrEAM3e1zK7Zohm9/ahIFrk1Q475f4tpB
         Y3/WyKZnbErotcupP5RQkmDI2fZsH+m0+Dw1AislKb7SDNFmU+PIvA2vXcv9PZGEGCSA
         PS25pNN0mmfGSkhrS+v0XqO+7LN+3g1UpxGpd124Y6+ZfZQbbsYy1YSSzBZICLjA3tlk
         r5e6k1xFaBiP4KM7RwlDCZp7E0YCJizKyp7FEMBxBGnMFEjPwOWeec7AZvUUWiXqQ+rp
         2MHpvpUs4mGTDvHFURb3r/boH0vvonAANp9cZTyFw7Hh5oyizxBX0xWCGe8seLYfYlVY
         dbzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will.deacon@arm.com, robdclark@gmail.com, tfiga@chromium.org, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
Date: Tue, 13 Mar 2018 10:40:26 +0100
Message-ID: <8903307.QazHKW0JrR@aspire.rjw.lan>
In-Reply-To: <20180313085534.11650-2-vivek.gautam@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org> <20180313085534.11650-2-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594814881294873136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
> The lists managing the device-links can be traversed to
> find the link between two devices. The device_link_add() APIs
> does traverse these lists to check if there's already a link
> setup between the two devices.
> So, add a new APIs, device_link_find(), to find an existing
> device link between two devices - suppliers and consumers.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
>  * New patch added to this series.
> 
>  drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>  include/linux/device.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5847364f25d9..e8c9774e4ba2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  	return 0;
>  }
>  
> +/**
> + * device_link_find - find any existing link between two devices.
> + * @consumer: Consumer end of the link.
> + * @supplier: Supplier end of the link.
> + *
> + * Returns pointer to the existing link between a supplier and
> + * and consumer devices, or NULL if no link exists.
> + */
> +struct device_link *device_link_find(struct device *consumer,
> +				     struct device *supplier)
> +{
> +	struct device_link *link = NULL;
> +
> +	if (!consumer || !supplier)
> +		return NULL;
> +
> +	list_for_each_entry(link, &supplier->links.consumers, s_node)
> +		if (link->consumer == consumer)
> +			break;
> +

Any mutual exclusion?

Or is the caller expected to take care of it?  And if so, then how?

> +	return link;
> +}
> +EXPORT_SYMBOL_GPL(device_link_find);
> +
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
>  		goto out;
>  	}
>  
> -	list_for_each_entry(link, &supplier->links.consumers, s_node)
> -		if (link->consumer == consumer)
> -			goto out;
> +	link = device_link_find(consumer, supplier);
> +	if (link)
> +		goto out;
>  
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
>  	if (!link)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405ed525..13bc1884c3eb 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
>  struct device_link *device_link_add(struct device *consumer,
>  				    struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
> +struct device_link *device_link_find(struct device *consumer,
> +				     struct device *supplier);
>  
>  #ifdef CONFIG_PRINTK
>  
> 
