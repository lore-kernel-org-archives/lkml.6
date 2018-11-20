Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382B9C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0190220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dm7o7QRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0190220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeKUBTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:19:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52930 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeKUBTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:19:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAKEhw8t194790;
        Tue, 20 Nov 2018 14:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=aBxL7mnVL6jMWl1rhJvgZAnSP2ekQ2vOtmS4k1O300g=;
 b=Dm7o7QRVjgUVpOqJKnSwAS89YYW/UpGsldILXXVEe7b55guqUPafCb9ZT+AJHjL0jKu0
 JJdTw8vwGrILcT+Z6VEJmiwA7IwiMtxQhy6Xv28PTFUf0ntGN+XsWw1tegCIYelTszF7
 EUy5eyCbYS+cshbjtzfnv8LuAH98+/+un67klUEwDymo/vj/qK+r0KI+y2oCDh5K3l+Y
 dCUFE+1oRKBUugdHbnFyrShbbrwKvVxlz5HzOSGfyBZ4xaBxfN2FfplwL6mkR12XCfo3
 NuhOkjFH//N0gxIAfLXdJNjxb4Ft741t1ttMOy7utc5IFlpkDoTQjNjh5E86Lbzl3cP0 4w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ntadtvbx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 14:49:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAKEnjrN010619
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 14:49:45 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAKEniPr005325;
        Tue, 20 Nov 2018 14:49:44 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 06:49:44 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 38D206A00D4; Tue, 20 Nov 2018 09:49:43 -0500 (EST)
Date:   Tue, 20 Nov 2018 09:49:43 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>, sstabellini@kernel.org
Cc:     hch@lst.de, m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] swiotlb: Skip cache maintenance on map error
Message-ID: <20181120144943.GI10917@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <a77c838eb070fb46c51802aa22c28bd8e1f9741c.1542722463.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77c838eb070fb46c51802aa22c28bd8e1f9741c.1542722463.git.robin.murphy@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811200133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:09:53PM +0000, Robin Murphy wrote:
> If swiotlb_bounce_page() failed, calling arch_sync_dma_for_device() may
> lead to such delights as performing cache maintenance on whatever
> address phys_to_virt(SWIOTLB_MAP_ERROR) looks like, which is typically
> outside the kernel memory map and goes about as well as expected.
> 
> Don't do that.

+Stefano
> 
> Fixes: a4a4330db46a ("swiotlb: add support for non-coherent DMA")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5731daa09a32..045930e32c0e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -679,7 +679,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	}
>  
>  	if (!dev_is_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0 &&
> +	    dev_addr != DIRECT_MAPPING_ERROR)
>  		arch_sync_dma_for_device(dev, phys, size, dir);
>  
>  	return dev_addr;
> -- 
> 2.19.1.dirty
> 
