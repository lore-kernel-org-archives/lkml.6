Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCOPTV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:19:21 -0400
Received: from 8bytes.org ([81.169.241.247]:46700 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbeCOPTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:19:20 -0400
Date: Thu, 15 Mar 2018 16:19:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
 get_irq_table()
Message-ID: <20180315151917.pgheszruqnnjbqb4@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-6-bigeasy@linutronix.de>
 <20180315125342.q74wurk6bdbhl6hy@8bytes.org>
 <20180315130153.3ba2loj5oplogdew@linutronix.de>
 <20180315130723.dunmpmbkswwvq54g@8bytes.org>
 <20180315141541.6g3xc6yi4siafuwr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180315141541.6g3xc6yi4siafuwr@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:15:41PM +0100, Sebastian Andrzej Siewior wrote:
> ->set_allocated() operates only on 0…31 and other could be used at the
> same time. However 0…31 should be accessed by other user before they are
> ready.
> 
> irq_remapping_alloc() is that ->alloc() callback invoked via
> irq_domain_alloc_irqs_hierarchy() and each caller has to hold the
> &irq_domain_mutex mutex. So we should not have those in parallel.
> 
> Is it possible to have those entries accessed before the setup is
> complete? My understanding is that this setup is performed once during
> boot (especially that ioapic part) and not again.
> 
> From looking at that hunk, it should not hurt to add that lock, just
> wanted to check it is really needed.

Okay, if the irq-layer does the needed locking, then we don't need
another lock here. There is the modify_irte_ga() path for the
virtualized irq routing into KVM guests, but there should be no KVM
guests running when setup the ioapic routing entries.



	Joerg
