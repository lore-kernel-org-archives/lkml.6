Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E49C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8222082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8222082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJ3GTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:19:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3GTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:19:38 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHF5u-0003Uz-Dy; Mon, 29 Oct 2018 22:29:06 +0100
Date:   Mon, 29 Oct 2018 22:29:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Long Li <longli@microsoft.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Choose CPU based on allocated IRQs
In-Reply-To: <20181023014044.15888-1-longli@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1810292138480.5984@nanos.tec.linutronix.de>
References: <20181023014044.15888-1-longli@linuxonhyperv.com>
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

Long,

On Tue, 23 Oct 2018, Long Li wrote:

thanks for this patch.

A trivial formal thing ahead. The subject line

   [PATCH] Choose CPU based on allocated IRQs

is lacking a proper subsystem prefix. In most cases you can figure the
prefix out by running 'git log path/to/file' which in this case will show
you that most commits touching this file use the prefix 'genirq/matrix:'.

So the proper subject would be:

   [PATCH] genirq/matrix: Choose CPU based on allocated IRQs

Subsystem prefixes are important to see where a patch belongs to right from
the subject. Without that it could belong to any random part of the kernel
and needs further inspection of the patch itself. This applies to both
email and to git shortlog listings.

> From: Long Li <longli@microsoft.com>
> 
> In irq_matrix, "available" is set when IRQs are allocated earlier in the IRQ
> assigning process.
> 
> Later, when IRQs are activated those values are not good indicators of what
> CPU to choose to assign to this IRQ.

Can you please explain why you think that available is the wrong indicator
and which problem you are trying to solve?

The WHY is really the most important part of a changelog.

> Change to choose CPU for an IRQ based on how many IRQs are already allocated
> on this CPU.

Looking deeper. The initial values are:

    available = alloc_size - (managed + systembits)
    allocated = 0

There are two distinct functionalities which modify 'available' and
'allocated' (omitting the reverse operations for simplicity):

1) managed interrupts

   reserve_managed()
	managed++;
	available--;

   alloc_managed()
        allocated++;

2) regular interrupts

   alloc()
	allocated++;
	available--;

So 'available' can be lower than 'allocated' depending on the number of
reserved managed interrupts, which have not yet been activated.

So for all regular interrupts we really want to look at the number of
'available' vectors because the reserved managed ones are already accounted
there and they need to be taken into account.

For the spreading of managed interrupts in alloc_managed() that's indeed a
different story and 'allocated' is more correct. But even that is not
completely accurate and can lead to the wrong result. The accurate solution
would be to account the managed _and_ allocated vectors separately and do
the spreading for managed interrupts based on that.

Thanks,

	tglx
