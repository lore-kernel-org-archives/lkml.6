Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCOM6g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:58:36 -0400
Received: from 8bytes.org ([81.169.241.247]:42140 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeCOM6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:58:34 -0400
Date: Thu, 15 Mar 2018 13:58:32 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 08/10] iommu/amd: drop the lock while allocating new irq
 remap table
Message-ID: <20180315125832.kfxoqfnxdajeg2yl@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-9-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-9-bigeasy@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:27:34PM +0100, Sebastian Andrzej Siewior wrote:
> The irq_remap_table is allocated while the iommu_table_lock is held with
> interrupts disabled. While this works it makes RT scream very loudly.
> >From looking at the call sites, all callers are in the early device
> initialisation (apic_bsp_setup(), pci_enable_device(),
> pci_enable_msi()) so make sense to drop the lock which also enables
> interrupts and try to allocate that memory with GFP_KERNEL instead
> GFP_ATOMIC.
> 
> Since during the allocation the iommu_table_lock is dropped, we need to
> recheck if table exists after the lock has been reacquired. I *think*
> that it is impossible that the "devid" entry appears in irq_lookup_table
> while the lock is dropped since the same device can only be probed once.
> It is more likely that another device added an `alias' entry. However I
> check for both cases, just to be sure.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This looks like it conflicts with the x86/amd branch as well.
