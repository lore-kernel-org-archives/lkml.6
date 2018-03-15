Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeCOOPp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:15:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53607 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeCOOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:15:43 -0400
Date: Thu, 15 Mar 2018 15:15:41 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
 get_irq_table()
Message-ID: <20180315141541.6g3xc6yi4siafuwr@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-6-bigeasy@linutronix.de>
 <20180315125342.q74wurk6bdbhl6hy@8bytes.org>
 <20180315130153.3ba2loj5oplogdew@linutronix.de>
 <20180315130723.dunmpmbkswwvq54g@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180315130723.dunmpmbkswwvq54g@8bytes.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-15 14:07:23 [+0100], Joerg Roedel wrote:
> On Thu, Mar 15, 2018 at 02:01:53PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-03-15 13:53:42 [+0100], Joerg Roedel wrote:
> > > On Fri, Feb 23, 2018 at 11:27:31PM +0100, Sebastian Andrzej Siewior wrote:
> > > > @@ -4103,10 +4093,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
> > > >  		return ret;
> > > >  
> > > >  	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
> > > > -		if (get_irq_table(devid, true))
> > > > +		struct irq_remap_table *table;
> > > > +		struct amd_iommu *iommu;
> > > > +
> > > > +		table = get_irq_table(devid);
> > > > +		if (table) {
> > > > +			if (!table->min_index) {
> > > > +				/*
> > > > +				 * Keep the first 32 indexes free for IOAPIC
> > > > +				 * interrupts.
> > > > +				 */
> > > > +				table->min_index = 32;
> > > > +				iommu = amd_iommu_rlookup_table[devid];
> > > > +				for (i = 0; i < 32; ++i)
> > > > +					iommu->irte_ops->set_allocated(table, i);
> > > > +			}
> > > 
> > > I think this needs to be protected by the table->lock.
> > 
> > Which part any why? The !->min_index part plus extending(setting to 32)?
> 
> In particular the set_allocated part, when get_irq_table() returns the
> table is visible to other users as well. I have not checked the
> irq-layer locking to be sure that can happen, though.

->set_allocated() operates only on 0…31 and other could be used at the
same time. However 0…31 should be accessed by other user before they are
ready.

irq_remapping_alloc() is that ->alloc() callback invoked via
irq_domain_alloc_irqs_hierarchy() and each caller has to hold the
&irq_domain_mutex mutex. So we should not have those in parallel.

Is it possible to have those entries accessed before the setup is
complete? My understanding is that this setup is performed once during
boot (especially that ioapic part) and not again.

>From looking at that hunk, it should not hurt to add that lock, just
wanted to check it is really needed.

Sebastian
