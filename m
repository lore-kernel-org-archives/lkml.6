Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC2QYm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:24:42 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40516 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeC2QYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:24:40 -0400
X-Google-Smtp-Source: AIpwx4/uwCOfViyOeVaAwMmlYhAlGd3qg4mZOuDs7QuuoDNj/WYQMJAvOFRPMtTAz9mJm2R2pi8VhQ==
Subject: Re: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
Date: Thu, 29 Mar 2018 09:24:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329160721.4691-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2018 9:07 AM, Logan Gunthorpe wrote:
> When allocating an SGL, the fibre channel target uses the number
> of entities mapped as the number of entities in a given scatter
> gather list. This is incorrect.
>
> The DMA-API-HOWTO document gives this note:
>
>     The 'nents' argument to the dma_unmap_sg call must be
>     the _same_ one you passed into the dma_map_sg call,
>     it should _NOT_ be the 'count' value _returned_ from the
>     dma_map_sg call.
>
> The fc code only stores the count value returned form the dma_map_sg()
> call and uses that value in the call to dma_unmap_sg().
>
> The dma_map_sg() call will return a lower count than nents when multiple
> SG entries were merged into one. This implies that there will be fewer
> DMA address and length entries but the original number of page entries
> in the SGL. So if this occurs, when the SGL reaches nvmet_execute_rw(),
> a bio would be created with fewer than the total number of entries.
>
> As odd as it sounds, and as far as I can tell, the number of SG entries
> mapped does not appear to be used anywhere in the fc driver and therefore
> there's no current need to store it.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Fixes: c53432030d8642 ("nvme-fabrics: Add target support for FC transport")
> ---

Signed-off-by: James Smart  <james.smart@broadcom.com>

Patch looks fine.

As for "not used anywhere", be careful as the structure being prepped is 
passed from the nvme-fc transport to an underlying lldd. So the 
references would likely be in the lldd.

-- james
