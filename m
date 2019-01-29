Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE78C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B6220880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfA2MCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:02:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfA2MCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:02:07 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goS5J-0002OX-OX; Tue, 29 Jan 2019 13:01:45 +0100
Date:   Tue, 29 Jan 2019 13:01:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hannes Reinecke <hare@suse.com>
cc:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
In-Reply-To: <5bff8227-16fd-6bca-c16e-3992ef6bec5a@suse.com>
Message-ID: <alpine.DEB.2.21.1901291257590.1513@nanos.tec.linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com> <5bff8227-16fd-6bca-c16e-3992ef6bec5a@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Hannes Reinecke wrote:
> That actually is a very good question, and I have been wondering about this
> for quite some time.
> 
> I find it a bit hard to envision a scenario where the IRQ affinity is
> automatically (and, more importantly, atomically!) re-routed to one of the
> other CPUs.
> And even it it were, chances are that there are checks in the driver
> _preventing_ them from handling those requests, seeing that they should have
> been handled by another CPU ...
> 
> I guess the safest bet is to implement a 'cleanup' worker queue which is
> responsible of looking through all the outstanding commands (on all hardware
> queues), and then complete those for which no corresponding CPU / irqhandler
> can be found.
> 
> But I defer to the higher authorities here; maybe I'm totally wrong and it's
> already been taken care of.

TBH, I don't know. I merily was involved in the genirq side of this. But
yes, in order to make this work correctly the basic contract for CPU
hotplug case must be:

If the last CPU which is associated to a queue (and the corresponding
interrupt) goes offline, then the subsytem/driver code has to make sure
that:

   1) No more requests can be queued on that queue

   2) All outstanding of that queue have been completed or redirected
      (don't know if that's possible at all) to some other queue.

That has to be done in that order obviously. Whether any of the
subsystems/drivers actually implements this, I can't tell.

Thanks,

	tglx
