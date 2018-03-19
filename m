Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755773AbeCSWt1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755358AbeCSWt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:49:26 -0400
Message-ID: <1521499764.3722.108.camel@redhat.com>
Subject: Re: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL
 allocation
From: Scott Wood <swood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Date: Mon, 19 Mar 2018 17:49:24 -0500
In-Reply-To: <20180319121527.zdmuwid4i3mjpwjw@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
         <1521316194.3722.74.camel@redhat.com>
         <20180317211013.rlou66s542ad4y2i@linutronix.de>
         <1521323019.3722.98.camel@redhat.com>
         <20180319121527.zdmuwid4i3mjpwjw@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 13:15 +0100, Sebastian Andrzej Siewior wrote:
> On 2018-03-17 16:43:39 [-0500], Scott Wood wrote:
> > If that's worth the lock dropping then fine (though why does only
> > one
> > of the two allocations use GFP_KERNEL?), but it doesn't need to be
> > a
> 
> That was a mistake, I planned to keep both as GFP_KERNEL.
> 
> > raw lock if the non-allocating users are separated.  Keeping them
> > separate will also preserve the WARNs if we somehow end up in an
> > atomic
> > context with no table (versus relying on atomic sleep debugging
> > that
> > may or may not be enabled), and make the code easier to understand
> > by
> > being explicit about which functions can be used from RT-atomic
> > context.
> 
> That separated part is okay. We could keep it. However, I am not sure
> if
> looking at the table irq_lookup_table[devid] without the lock is
> okay.
> The pointer is assigned without DTE entry/iommu-flush to be
> completed. 
> This does not look "okay".

Those callers are getting the devid from an irq_2_irte struct, which
was set up in irq_remapping_alloc() after get/alloc_irq_table() is
completed.

-Scott
