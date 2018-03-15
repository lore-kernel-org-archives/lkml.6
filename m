Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCOONH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:13:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37757 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeCOONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:13:06 -0400
X-Google-Smtp-Source: AG47ELvFYj1ktg1j/wnhES3h+7SqalO3aQsY0AwX3NGfh4Tr12VzGwGsuXqyBpQHBC50jXGDOIdVTQ==
Message-ID: <1521123183.2686.7.camel@arista.com>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
From: Dmitry Safonov <dima@arista.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Date: Thu, 15 Mar 2018 14:13:03 +0000
In-Reply-To: <20180315134649.skh2aukcmg5ud74y@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
         <20180315134649.skh2aukcmg5ud74y@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 14:46 +0100, Joerg Roedel wrote:
> On Thu, Feb 15, 2018 at 07:17:29PM +0000, Dmitry Safonov wrote:
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index accf58388bdb..6c4ea32ee6a9 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1618,17 +1618,13 @@ irqreturn_t dmar_fault(int irq, void
> > *dev_id)
> >  	int reg, fault_index;
> >  	u32 fault_status;
> >  	unsigned long flag;
> > -	bool ratelimited;
> >  	static DEFINE_RATELIMIT_STATE(rs,
> >  				      DEFAULT_RATELIMIT_INTERVAL,
> >  				      DEFAULT_RATELIMIT_BURST);
> >  
> > -	/* Disable printing, simply clear the fault when
> > ratelimited */
> > -	ratelimited = !__ratelimit(&rs);
> > -
> >  	raw_spin_lock_irqsave(&iommu->register_lock, flag);
> >  	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
> > -	if (fault_status && !ratelimited)
> > +	if (fault_status && __ratelimit(&rs))
> >  		pr_err("DRHD: handling fault status reg %x\n",
> > fault_status);
> 
> This looks aweful. Have you tried to limit the number of loops in
> this
> function and returning? You can handle the next faults by the next
> interrupt. This ensures that the cpu visits a scheduling point from
> time
> to time so that you don't see soft-lockups.

So, you suggest to remove ratelimit at all?
Do we really need printk flood for each happened fault?
Imagine, you've hundreds of mappings and then PCI link flapped..
Wouldn't it be better to keep ratelimiting?
I don't mind, just it looks a bit strange to me.

-- 
Thanks,
             Dmitry
