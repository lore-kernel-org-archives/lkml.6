Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF709C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6225920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6225920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeIJVIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:08:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeIJVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:08:43 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79262F73;
        Mon, 10 Sep 2018 16:13:53 +0000 (UTC)
Date:   Mon, 10 Sep 2018 18:13:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180910161350.GA10380@kroah.com>
References: <20180910060533.27172-1-hch@lst.de>
 <20180910060533.27172-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910060533.27172-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 08:05:30AM +0200, Christoph Hellwig wrote:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 8f882549edee..983506789402 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -927,6 +927,8 @@ struct dev_links_info {
>   * @offline:	Set after successful invocation of bus type's .offline().
>   * @of_node_reused: Set if the device-tree node is shared with an ancestor
>   *              device.
> + * @dma_coherent: this particular device is dma coherent, even if the
> + *		architecture supports non-coherent devices.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
>   * instance of struct device. The device structure contains the information
> @@ -1016,6 +1018,11 @@ struct device {
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> +	bool			dma_coherent:1;
> +#endif

It's just one bit, why not always have it enabled here?  If the arch
uses it or doesn't, no big deal.

Or are you using this to "catch" arches that mess something up?

thanks,

greg k-h
