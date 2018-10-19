Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A2ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EA22145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EA22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJSWhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:37:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39183 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:37:55 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDVoI-0000jr-In; Fri, 19 Oct 2018 16:31:30 +0200
Date:   Fri, 19 Oct 2018 16:31:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-kernel@vger.kernel.org,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Subject: Re: [PATCH] genirq: Fix race on spurious interrupt detection
In-Reply-To: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
Message-ID: <alpine.DEB.2.21.1810191554030.6075@nanos.tec.linutronix.de>
References: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Lukas Wunner wrote:
> Commit 1e77d0a1ed74 ("genirq: Sanitize spurious interrupt detection of
> threaded irqs") made detection of spurious interrupts work for threaded
> handlers by:
> 
> a) incrementing a counter every time the thread returns IRQ_HANDLED, and
> b) checking whether that counter has increased every time the thread is
>    woken.
> 
> However for oneshot interrupts, the commit unmasks the interrupt before
> incrementing the counter.  If another interrupt occurs right after
> unmasking but before the counter is incremented, that interrupt is
> incorrectly considered spurious:
> 
> time
>  |  irq_thread()
>  |    irq_thread_fn()
>  |      action->thread_fn()
>  |      irq_finalize_oneshot()
>  |        unmask_threaded_irq()            /* interrupt is unmasked */
>  |
>  |                  /* interrupt fires, incorrectly deemed spurious */
>  |
>  |    atomic_inc(&desc->threads_handled); /* counter is incremented */
>  v
> 
> I am seeing this with a hi3110 CAN controller receiving data at high
> volume (from a separate machine sending with "cangen -g 0 -i -x"):
> The controller signals a huge number of interrupts (hundreds of millions
> per day) and every second there are about a dozen which are deemed
> spurious.  The issue is benign in this case, mostly just an irritation,
> but I'm worrying that at high CPU load and in the presence of higher
> priority tasks, the number of incorrectly detected spurious interrupts
> might increase beyond the 99,900 threshold and cause disablement of the
> IRQ.

I doubt that this can happen in reality, so I'd rather reword that
paragraph slightly:

  In theory high CPU load and in the presence of higher priority tasks, the
  number of incorrectly detected spurious interrupts might increase beyond
  the 99,900 threshold and cause disablement of the interrupt.

  In practice it just increments the spurious interrupt count. But that can
  cause people to waste time investigating it over and over.

Hmm?

Thanks,

	tglx
