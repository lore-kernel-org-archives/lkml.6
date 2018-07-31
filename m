Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22C9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF3D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGaSOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:14:22 -0400
Received: from verein.lst.de ([213.95.11.211]:58102 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbeGaSOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:14:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D917B68D64; Tue, 31 Jul 2018 18:37:41 +0200 (CEST)
Date:   Tue, 31 Jul 2018 18:37:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
Message-ID: <20180731163741.GA2359@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-8-hch@lst.de> <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:04:52PM -0700, Atish Patra wrote:
>> +#define MAX_DEVICES			1024
>> +#define MAX_CONTEXTS			15872
>> +
>
> Is there any way we can preserve some of the comments in the original patch 
> about memory-mapped control registers or at least a reference where to find 
> the register offset calculations?

The comments really do not help to describe a why or how.  I'd love to
add a reference to a spec, but I could not find anything that looks
like an authoritative spec for the SiFive PLIC layout.

>> +	u32 __iomem *reg = plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
>
> shouldn't it be
> u32 __iomem *reg = plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART + 
> (hwirq / 32) * 4;

Yes, it should.  Fixed.

>> +		if (unlikely(irq <= 0)) {
>> +			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
>> +					hwirq);
>
> Ratlimiting the warning message here didn't help as ack_bad_irq() still 
> print message still flooded the console without any useful info.

I've dropped the somewhat pointless ack_bad_irq call, thanks.
