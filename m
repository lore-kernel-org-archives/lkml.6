Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GX4yLIKVGVuSawAAmS7hNA
	; Thu, 07 Jun 2018 20:28:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A17E66089E; Thu,  7 Jun 2018 20:28:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E396760452;
	Thu,  7 Jun 2018 20:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E396760452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFGU2r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:28:47 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40462 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbeFGU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:28:46 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fR1WW-000445-04; Thu, 07 Jun 2018 21:28:44 +0100
Message-ID: <1528403323.2289.84.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 010/268] xen-swiotlb: fix the check condition for
 xen_swiotlb_free_coherent
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Joe Jin <joe.jin@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date: Thu, 07 Jun 2018 21:28:43 +0100
In-Reply-To: <20180528100203.277622038@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100203.277622038@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 11:59 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Joe Jin <joe.jin@oracle.com>
> 
> commit 4855c92dbb7b3b85c23e88ab7ca04f99b9677b41 upstream.
> 
> When run raidconfig from Dom0 we found that the Xen DMA heap is reduced,
> but Dom Heap is increased by the same size. Tracing raidconfig we found
> that the related ioctl() in megaraid_sas will call dma_alloc_coherent()
> to apply memory. If the memory allocated by Dom0 is not in the DMA area,
> it will exchange memory with Xen to meet the requiment. Later drivers
> call dma_free_coherent() to free the memory, on xen_swiotlb_free_coherent()
> the check condition (dev_addr + size - 1 <= dma_mask) is always false,

I think this was meant to say (dev_addr + size - 1 > dma_mask), i.e.
the condition that is replaced by this commit.  If that's always false,
the new condition (the logical inverse) must always be true.

[...]
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -359,7 +359,7 @@ xen_swiotlb_free_coherent(struct device
>  	 * physical address */
>  	phys = xen_bus_to_phys(dev_addr);
>  
> -	if (((dev_addr + size - 1 > dma_mask)) ||
> +	if (((dev_addr + size - 1 <= dma_mask)) ||
>  	    range_straddles_page_boundary(phys, size))
>  		xen_destroy_contiguous_region(phys, order);
>  

So now we will always call xen_destroy_contiguous_region(), whether or
not xen_create_contiguous_region() was called during allocation.  Is
that really the intent?  If so, the entire condition could be removed
to make this clear.

Alternately, if the commit message is correct, the condition could be
simplified to range_straddles_page_boundary(...).

But I'm not at all convinced that either of these is correct.  It seems
like you need to either find a way of distinguishing between memory
allocated with or without the use of xen_create_contiguous_region(), or
to use it unconditionally.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
