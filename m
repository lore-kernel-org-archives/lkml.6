Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeEGQAb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:00:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:26947 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbeEGQAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:00:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,374,1520924400";
   d="scan'208";a="39903617"
Date: Mon, 7 May 2018 10:02:12 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: NVMe Poll CQ on timeout
Message-ID: <20180507160211.GE20686@localhost.localdomain>
References: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:57:54AM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> Does anyone have any inputs ?

Hi,

I recall we did observe issues like this when legacy interrupts were
used, so the driver does try to use MSI/MSIx if possible.

The nvme_timeout() is called from the block layer when the driver didn't
provide a completion within the timeout (default is 30 seconds for IO,
60 seconds for admin).

This message you're seeing means the device did indeed post a completion
queue entry for the timed out command, but the driver believes it was
never notified via interrupt to check the completion queue.

This means either one of two things happened: the interrupt was raised
prior to the completion queue entry being written, or the interrupt was
never raised in the first place.

It might be possible to determine which if you can read the values from
/proc/irq/<irq#>/spurious and see if the "last_unhandled" aligns with
the expected completion time.

Thanks,
Keith

> > Hi,
> > 
> > We are testing NVMe cards on ARM64 platform, the card uses legacy
> > interrupts.
> > Intermittently we are hitting following case in drivers/nvme/host/pci.c
> >        /*
> >          * Did we miss an interrupt?
> >          */
> >         if (__nvme_poll(nvmeq, req->tag)) {
> >                 dev_warn(dev->ctrl.device,
> >                          "I/O %d QID %d timeout, completion polled\n",
> >                          req->tag, nvmeq->qid);
> >                 return BLK_EH_HANDLED;
> >         }
> > 
> > Can anyone tell when does nvme_timeout gets invoked ?
> > What does "Did we miss an interrupt mean" ? Does it mean host missing to
> > service a interrupt raised by EP card ?
> > 
> > Regards,
> > Bharat
