Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368C7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C12E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C12E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeIKAdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:33:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40318 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeIKAdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:33:47 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzS0V-0007xA-VJ; Mon, 10 Sep 2018 21:38:00 +0200
Date:   Mon, 10 Sep 2018 21:37:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anup Patel <anup@brainfault.org>
cc:     Christoph Hellwig <hch@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller
 Driver
In-Reply-To: <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809102133240.1419@nanos.tec.linutronix.de>
References: <20180910132924.GA6987@infradead.org> <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de> <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com> <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de> <20180910161143.GA1053@infradead.org> <CAAhSdy0kgsy0QFDQGYeVy6vxu8v7UwRGbdJC9Hhz+36TNYjyGA@mail.gmail.com>
 <20180910163936.GA18699@infradead.org> <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
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
> On Mon, Sep 10, 2018 at 10:09 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Mon, Sep 10, 2018 at 10:05:42PM +0530, Anup Patel wrote:
> >> I am quite sure RISC-V spec does not restrict the use of other
> >> local interrupts. Different CPU implementations can have their
> >> own local interrupts.
> >
> > Please take a look at sections 3.1.14 and 4.1.1 of the RISC-V privileged
> > spec 1.10.
> 
> RISC-V priv spec 1.10 defines the 9 bits in MIE and MIP registers and
> other bits are reserved.
> 
> The unused bits in MIP are WIRI (reserved write ignored and read ignored)
> and unused bits in MIE are WPRI (reserved write preserve values and
> read ignored).
> 
> The RISC-V priv spec 1.10 does not tell that unused reserved bits in
> MIE/MIP cannot be used for:
> 1. CPU implementation specific local interrupts
> 2. Per-CPU device interrupts.
> 
> The RISC-V priv spec 1.10 tries to only describe MIE/MIP bits which
> are mandatory on any RISC-V 1.10 compliant CPU but it possible to
> used other reserved bits for implementation specific local interrupts.

Processor local interrupts really should be architected and there are
really not that many of them.

But well, RISC-V decided obvsiouly not to learn from mistakes made by
others.

That said, if your cpu local interrupts are not architectural and cannot be
made software configured architectural, then you will end up sooner than
later with the need for an irqdomain in order to handle the implementer
specific crap.

Thanks,

	tglx
