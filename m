Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeB1P13 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:27:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:30179 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932748AbeB1P1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:27:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="31324427"
Date: Wed, 28 Feb 2018 08:27:41 -0700
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
Message-ID: <20180228152741.GA16002@localhost.localdomain>
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180227151311.GD10832@localhost.localdomain>
 <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:53:31AM +0800, jianchao.wang wrote:
> On 02/27/2018 11:13 PM, Keith Busch wrote:
> > On Tue, Feb 27, 2018 at 04:46:17PM +0800, Jianchao Wang wrote:
> >> Currently, adminq and ioq0 share the same irq vector. This is
> >> unfair for both amdinq and ioq0.
> >>  - For adminq, its completion irq has to be bound on cpu0.
> >>  - For ioq0, when the irq fires for io completion, the adminq irq
> >>    action has to be checked also.
> > 
> > This change log could use some improvements. Why is it bad if admin
> > interrupts affinity is with cpu0?
> 
> adminq interrupts should be able to fire everywhere.
> do we have any reason to bound it on cpu0 ?

Your patch will have the admin vector CPU affinity mask set to
0xff..ff. The first set bit for an online CPU is the one the IRQ handler
will run on, so the admin queue will still only run on CPU 0.
 
> > Are you able to measure _any_ performance difference on IO queue 1 vs IO
> > queue 2 that you can attribute to IO queue 1's sharing vector 0?
> 
> Actually, I didn't get any performance improving on my own NVMe card.
> But it may be needed on some enterprise card, especially the media is persist memory.
> nvme_irq will be invoked twice when ioq0 irq fires, this will introduce another unnecessary DMA
> accessing on cq entry.

A CPU reading its own memory isn't a DMA. It's just a cheap memory read.
