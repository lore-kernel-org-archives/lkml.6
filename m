Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E32222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502182AbfBNPfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:35:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502133AbfBNPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:35:09 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guJ2X-0002p4-L1; Thu, 14 Feb 2019 16:35:05 +0100
Date:   Thu, 14 Feb 2019 16:35:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Marc Zyngier <Marc.Zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: How to know if there is a pending interrupt when they are
 masked?
In-Reply-To: <bf2e6e81-7218-05e0-fd6e-27c9c5418813@linaro.org>
Message-ID: <alpine.DEB.2.21.1902141620510.1561@nanos.tec.linutronix.de>
References: <bf2e6e81-7218-05e0-fd6e-27c9c5418813@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, Daniel Lezcano wrote:
> today we have the possibility to mask the local interrupt with the
> command local_irq_disable / local_irq_enable.
> 
> The power management path disables the local interrupt in order to
> initiate a power down sequence. If there is a pending interrupt this one
> will make the power down function to abort, thus exiting right after
> calling the shutdown function after costly operations. It could be
> interesting to check if there is a pending interrupt before initiating
> the power down sequence.
> 
> Is there a way to know if there is a pending interrupt on the current
> CPU when the local interrupt are disabled? Something like,
> local_irq_pending() function ?

We have nothing like that today, but it would be possible to implement this
at least on x86 by peeking the local APIC registers.

OTOH, the question is whether it's worth the trouble because the interrupt
could come in right after the query and the same issue which you want to
address persists. It only makes sense if it reduces the time window so
significantly that it actually matters.

Thanks,

	tglx
