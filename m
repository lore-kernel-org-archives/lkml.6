Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfA2Q1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:27:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfA2Q1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:27:44 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goWEO-0001ah-7x; Tue, 29 Jan 2019 17:27:24 +0100
Date:   Tue, 29 Jan 2019 17:27:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Garry <john.garry@huawei.com>
cc:     Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
In-Reply-To: <bdd457db-6898-a085-bfaf-99d29d81467d@huawei.com>
Message-ID: <alpine.DEB.2.21.1901291717370.1513@nanos.tec.linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com> <5bff8227-16fd-6bca-c16e-3992ef6bec5a@suse.com> <alpine.DEB.2.21.1901291257590.1513@nanos.tec.linutronix.de> <bdd457db-6898-a085-bfaf-99d29d81467d@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, John Garry wrote:
> On 29/01/2019 12:01, Thomas Gleixner wrote:
> > If the last CPU which is associated to a queue (and the corresponding
> > interrupt) goes offline, then the subsytem/driver code has to make sure
> > that:
> > 
> >    1) No more requests can be queued on that queue
> > 
> >    2) All outstanding of that queue have been completed or redirected
> >       (don't know if that's possible at all) to some other queue.
> 
> This may not be possible. For the HW I deal with, we have symmetrical delivery
> and completion queues, and a command delivered on DQx will always complete on
> CQx. Each completion queue has a dedicated IRQ.

So you can stop queueing on DQx and wait for all outstanding ones to come
in on CQx, right?

> > That has to be done in that order obviously. Whether any of the
> > subsystems/drivers actually implements this, I can't tell.
> 
> Going back to c5cb83bb337c25, it seems to me that the change was made with the
> idea that we can maintain the affinity for the IRQ as we're shutting it down
> as no interrupts should occur.
> 
> However I don't see why we can't instead keep the IRQ up and set the affinity
> to all online CPUs in offline path, and restore the original affinity in
> online path. The reason we set the queue affinity to specific CPUs is for
> performance, but I would not say that this matters for handling residual IRQs.

Oh yes it does. The problem is especially on x86, that if you have a large
number of queues and you take a large number of CPUs offline, then you run
into vector space exhaustion on the remaining online CPUs.

In the worst case a single CPU on x86 has only 186 vectors available for
device interrupts. So just take a quad socket machine with 144 CPUs and two
multiqueue devices with a queue per cpu. ---> FAIL

It probably fails already with one device because there are lots of other
devices which have regular interrupt which cannot be shut down.

Thanks,

	tglx

