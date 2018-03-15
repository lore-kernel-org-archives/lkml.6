Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeCONqy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:46:54 -0400
Received: from 8bytes.org ([81.169.241.247]:42592 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeCONqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:46:52 -0400
Date: Thu, 15 Mar 2018 14:46:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Message-ID: <20180315134649.skh2aukcmg5ud74y@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215191729.15777-1-dima@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 07:17:29PM +0000, Dmitry Safonov wrote:
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index accf58388bdb..6c4ea32ee6a9 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1618,17 +1618,13 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  	int reg, fault_index;
>  	u32 fault_status;
>  	unsigned long flag;
> -	bool ratelimited;
>  	static DEFINE_RATELIMIT_STATE(rs,
>  				      DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
>  
> -	/* Disable printing, simply clear the fault when ratelimited */
> -	ratelimited = !__ratelimit(&rs);
> -
>  	raw_spin_lock_irqsave(&iommu->register_lock, flag);
>  	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
> -	if (fault_status && !ratelimited)
> +	if (fault_status && __ratelimit(&rs))
>  		pr_err("DRHD: handling fault status reg %x\n", fault_status);

This looks aweful. Have you tried to limit the number of loops in this
function and returning? You can handle the next faults by the next
interrupt. This ensures that the cpu visits a scheduling point from time
to time so that you don't see soft-lockups.



	Joerg
