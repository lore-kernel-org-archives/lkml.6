Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeCONB4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:01:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53361 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeCONBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:01:55 -0400
Date: Thu, 15 Mar 2018 14:01:53 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
 get_irq_table()
Message-ID: <20180315130153.3ba2loj5oplogdew@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-6-bigeasy@linutronix.de>
 <20180315125342.q74wurk6bdbhl6hy@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315125342.q74wurk6bdbhl6hy@8bytes.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-15 13:53:42 [+0100], Joerg Roedel wrote:
> On Fri, Feb 23, 2018 at 11:27:31PM +0100, Sebastian Andrzej Siewior wrote:
> > @@ -4103,10 +4093,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
> >  		return ret;
> >  
> >  	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
> > -		if (get_irq_table(devid, true))
> > +		struct irq_remap_table *table;
> > +		struct amd_iommu *iommu;
> > +
> > +		table = get_irq_table(devid);
> > +		if (table) {
> > +			if (!table->min_index) {
> > +				/*
> > +				 * Keep the first 32 indexes free for IOAPIC
> > +				 * interrupts.
> > +				 */
> > +				table->min_index = 32;
> > +				iommu = amd_iommu_rlookup_table[devid];
> > +				for (i = 0; i < 32; ++i)
> > +					iommu->irte_ops->set_allocated(table, i);
> > +			}
> 
> I think this needs to be protected by the table->lock.

Which part any why? The !->min_index part plus extending(setting to 32)?

Sebastian
