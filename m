Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BD03C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436DC208B9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2LU9RVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436DC208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935141AbeFMB1I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:27:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935098AbeFMB1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:27:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D1QhI3196287;
        Wed, 13 Jun 2018 01:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=I7YHtUjOiwjd3IP3X/0cHp0iqvuHR9MQT1ArFoVHpSM=;
 b=j2LU9RVIAC9oyv5mSbNFk4UUIHpGeUgVgM0J3LoHLNrxo6HyN8l+Sq+09FCBY5bHZx7R
 wkgrso6gp6d2F9CvdATbu7GcQjWSSisC8lHxJMD78d1Id3uphZFLApMCOg/VZcJ1xgtB
 AxfhfFpVmsBlnwIQYJ5/vQWN98vnm1Xx4/7bgaIrkc2lxGZuMcy55g65BXTJwV+k4rIJ
 04NcKpOFKKBXWOvFcYK53adc9b0OAddiJ3WBodm69fkFMr3RUTUw1aFEdBLmwBE56okM
 rBK59hFciyVTJidSt8CE8Y5vIt01NhqpjQH7IcMTPiiRDHwyHA6mE7tAas5/gyh0uy13 +A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jjp6brcd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:26:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D1Qqiv008845
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:26:53 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5D1QqKu004931;
        Wed, 13 Jun 2018 01:26:52 GMT
Received: from [10.154.144.7] (/10.154.144.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 18:26:51 -0700
Subject: Re: [PATCH v3 5/9] xen/gntdev: Allow mappings for DMA buffers
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-6-andr2000@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b78251d7-462a-fb1f-32e9-868a7236decb@oracle.com>
Date:   Tue, 12 Jun 2018 21:26:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-6-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:

>   
>   static void gntdev_print_maps(struct gntdev_priv *priv,
> @@ -121,8 +146,27 @@ static void gntdev_free_map(struct grant_map *map)
>   	if (map == NULL)
>   		return;
>   
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	if (map->dma_vaddr) {
> +		struct gnttab_dma_alloc_args args;
> +
> +		args.dev = map->dma_dev;
> +		args.coherent = map->dma_flags & GNTDEV_DMA_FLAG_COHERENT;


args.coherent = !!(map->dma_flags & GNTDEV_DMA_FLAG_COHERENT);


> +		args.nr_pages = map->count;
> +		args.pages = map->pages;
> +		args.frames = map->frames;
> +		args.vaddr = map->dma_vaddr;
> +		args.dev_bus_addr = map->dma_bus_addr;
> +
> +		gnttab_dma_free_pages(&args);
> +	} else
> +#endif
>   	if (map->pages)
>   		gnttab_free_pages(map->count, map->pages);
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	kfree(map->frames);
> +#endif
>   	kfree(map->pages);
>   	kfree(map->grants);
>   	kfree(map->map_ops);
> @@ -132,7 +176,8 @@ static void gntdev_free_map(struct grant_map *map)
>   	kfree(map);
>   }
>   
> -static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
> +static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
> +					  int dma_flags)
>   {
>   	struct grant_map *add;
>   	int i;
> @@ -155,6 +200,37 @@ static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
>   	    NULL == add->pages)
>   		goto err;
>   
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	add->dma_flags = dma_flags;
> +
> +	/*
> +	 * Check if this mapping is requested to be backed
> +	 * by a DMA buffer.
> +	 */
> +	if (dma_flags & (GNTDEV_DMA_FLAG_WC | GNTDEV_DMA_FLAG_COHERENT)) {
> +		struct gnttab_dma_alloc_args args;
> +
> +		add->frames = kcalloc(count, sizeof(add->frames[0]),
> +				      GFP_KERNEL);
> +		if (!add->frames)
> +			goto err;
> +
> +		/* Remember the device, so we can free DMA memory. */
> +		add->dma_dev = priv->dma_dev;
> +
> +		args.dev = priv->dma_dev;
> +		args.coherent = dma_flags & GNTDEV_DMA_FLAG_COHERENT;


And again here.


> +		args.nr_pages = count;
> +		args.pages = add->pages;
> +		args.frames = add->frames;
> +
> +		if (gnttab_dma_alloc_pages(&args))
> +			goto err;
> +
> +		add->dma_vaddr = args.vaddr;
> +		add->dma_bus_addr = args.dev_bus_addr;
> +	} else
> +#endif
>   	if (gnttab_alloc_pages(count, add->pages))
>   		goto err;
>   
> @@ -325,6 +401,14 @@ static int map_grant_pages(struct grant_map *map)
>   		map->unmap_ops[i].handle = map->map_ops[i].handle;
>   		if (use_ptemod)
>   			map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +		else if (map->dma_vaddr) {
> +			unsigned long mfn;


This should be called bfn now.


> +
> +			mfn = pfn_to_bfn(page_to_pfn(map->pages[i]));
> +			map->unmap_ops[i].dev_bus_addr = __pfn_to_phys(mfn);
> +		}
> +#endif
>   	}
>   	return err;
>   }
> @@ -548,6 +632,17 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>   	}
>   
>   	flip->private_data = priv;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	priv->dma_dev = gntdev_miscdev.this_device;
> +
> +	/*
> +	 * The device is not spawn from a device tree, so arch_setup_dma_ops
> +	 * is not called, thus leaving the device with dummy DMA ops.
> +	 * Fix this call of_dma_configure() with a NULL node to set


"Fix this by calling ..." I think.


> +	 * default DMA ops.
> +	 */
> +	of_dma_configure(priv->dma_dev, NULL);
> +#endif
>   	pr_debug("priv %p\n", priv);
>   
>   	return 0;


With those fixed,

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
