Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4810F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfA3Mn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:43:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46995 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Mn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:43:57 -0500
Received: from [2a01:598:b890:92b7:fc90:b8ff:fed0:1fb6] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gopDO-0007h8-IP; Wed, 30 Jan 2019 13:43:38 +0100
Date:   Wed, 30 Jan 2019 13:43:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Garry <john.garry@huawei.com>
cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
In-Reply-To: <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
Message-ID: <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com> <20190129154433.GF15302@localhost.localdomain> <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com> <20190129172059.GC17132@localhost.localdomain> <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, John Garry wrote:
> On 29/01/2019 17:20, Keith Busch wrote:
> > On Tue, Jan 29, 2019 at 05:12:40PM +0000, John Garry wrote:
> > > On 29/01/2019 15:44, Keith Busch wrote:
> > > > 
> > > > Hm, we used to freeze the queues with CPUHP_BLK_MQ_PREPARE callback,
> > > > which would reap all outstanding commands before the CPU and IRQ are
> > > > taken offline. That was removed with commit 4b855ad37194f ("blk-mq:
> > > > Create hctx for each present CPU"). It sounds like we should bring
> > > > something like that back, but make more fine grain to the per-cpu
> > > > context.
> > > > 
> > > 
> > > Seems reasonable. But we would need it to deal with drivers where they
> > > only
> > > expose a single queue to BLK MQ, but use many queues internally. I think
> > > megaraid sas does this, for example.
> > > 
> > > I would also be slightly concerned with commands being issued from the
> > > driver unknown to blk mq, like SCSI TMF.
> > 
> > I don't think either of those descriptions sound like good candidates
> > for using managed IRQ affinities.
> 
> I wouldn't say that this behaviour is obvious to the developer. I can't see
> anything in Documentation/PCI/MSI-HOWTO.txt
> 
> It also seems that this policy to rely on upper layer to flush+freeze queues
> would cause issues if managed IRQs are used by drivers in other subsystems.
> Networks controllers may have multiple queues and unsoliciated interrupts.

It's doesn't matter which part is managing flush/freeze of queues as long
as something (either common subsystem code, upper layers or the driver
itself) does it.

So for the megaraid SAS example the BLK MQ layer obviously can't do
anything because it only sees a single request queue. But the driver could,
if the the hardware supports it. tell the device to stop queueing
completions on the completion queue which is associated with a particular
CPU (or set of CPUs) during offline and then wait for the on flight stuff
to be finished. If the hardware does not allow that, then managed
interrupts can't work for it.

Thanks,

	tglx
