Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ACAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1474F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1474F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeIJVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:02:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:02:09 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzOiW-0004F8-QO; Mon, 10 Sep 2018 18:07:12 +0200
Date:   Mon, 10 Sep 2018 18:07:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anup Patel <anup@brainfault.org>
cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller
 Driver
In-Reply-To: <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
References: <20180906123651.28500-1-anup@brainfault.org> <20180906123651.28500-4-anup@brainfault.org> <20180906140628.GA10580@infradead.org> <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de> <20180910132924.GA6987@infradead.org>
 <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de> <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de> <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
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

On Mon, 10 Sep 2018, Anup Patel wrote:

> On Mon, Sep 10, 2018 at 7:19 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Mon, Sep 10, 2018 at 03:45:42PM +0200, Thomas Gleixner wrote:
> >> > He has an irqchip that is called from the RISC-V exception handler
> >> > when the interrupt flag is set in scause and then dispatches to one
> >> > of:  IPI, timer, actual irqchip.
> >>
> >> So the per cpu timer is the only per cpu interrupt and that thing is used
> >> unconditionally, right?
> >
> > Yes.  external is chained and IPI is still handled explicitly.
> 
> On riscv64, there are 64 local interrupts (i.e. per-CPU interrupts).
> 
> Three of these local interrupts have clearly defined use:
> 1. Software interrupt (inter-processor interrupt)
> 2. External interrupt (interrupt from PLIC)
> 3. Timer interrupt (interrupt from per-CPU timer)
> 
> Other local interrupts are available for future use.
> 
> Taking inspiration from ARM world, I had give quite a few
> examples how these RISC-V local interrupts can be used
> for other purposes:
> 1. per-CPU interrupt for per-HART performance monitoring unit
> 2. interrupt controller virtualizaton extension can use per-CPU
> interrupts for managing resources (just like ARM GICv2/v3 virt
> extensions)
> 3. bus errors can be reported as per-CPU interrupts
> 
> Considering above, it is better to have a distinct irqchip and
> irq_domain for all local interrupts (just like this patch).

If that's the future usage and that's what my impression was, under which I
changed my mind, yes, then having a domain model is certainly of advantage
especially when those things end up being different per SoC.

Thanks,

	tglx
