Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EE62083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfA2Lys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:54:48 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:41316 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbfA2Lyr (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 29 Jan 2019 06:54:47 -0500
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 29 Jan 2019 12:54:45 +0100
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     John Garry <john.garry@huawei.com>, tglx@linutronix.de,
        Christoph Hellwig <hch@lst.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <5bff8227-16fd-6bca-c16e-3992ef6bec5a@suse.com>
Date:   Tue, 29 Jan 2019 12:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 12:25 PM, John Garry wrote:
> Hi,
> 
> I have a question on $subject which I hope you can shed some light on.
> 
> According to commit c5cb83bb337c25 ("genirq/cpuhotplug: Handle managed 
> IRQs on CPU hotplug"), if we offline the last CPU in a managed IRQ 
> affinity mask, the IRQ is shutdown.
> 
> The reasoning is that this IRQ is thought to be associated with a 
> specific queue on a MQ device, and the CPUs in the IRQ affinity mask are 
> the same CPUs associated with the queue. So, if no CPU is using the 
> queue, then no need for the IRQ.
> 
> However how does this handle scenario of last CPU in IRQ affinity mask 
> being offlined while IO associated with queue is still in flight?
> 
> Or if we make the decision to use queue associated with the current CPU, 
> and then that CPU (being the last CPU online in the queue's IRQ 
> afffinity mask) goes offline and we finish the delivery with another CPU?
> 
> In these cases, when the IO completes, it would not be serviced and 
> timeout.
> 
> I have actually tried this on my arm64 system and I see IO timeouts.
> 
That actually is a very good question, and I have been wondering about 
this for quite some time.

I find it a bit hard to envision a scenario where the IRQ affinity is 
automatically (and, more importantly, atomically!) re-routed to one of 
the other CPUs.
And even it it were, chances are that there are checks in the driver 
_preventing_ them from handling those requests, seeing that they should 
have been handled by another CPU ...

I guess the safest bet is to implement a 'cleanup' worker queue which is 
responsible of looking through all the outstanding commands (on all 
hardware queues), and then complete those for which no corresponding CPU 
/ irqhandler can be found.

But I defer to the higher authorities here; maybe I'm totally wrong and 
it's already been taken care of.

But if there is no generic mechanism this really is a fit topic for 
LSF/MM, as most other drivers would be affected, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
