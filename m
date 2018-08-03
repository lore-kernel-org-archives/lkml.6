Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A3C21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A3C21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeHCOVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:21:17 -0400
Received: from verein.lst.de ([213.95.11.211]:44118 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeHCOVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:21:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EC6E468D40; Fri,  3 Aug 2018 14:29:58 +0200 (CEST)
Date:   Fri, 3 Aug 2018 14:29:58 +0200
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
Subject: Re: [PATCH 10/11] irqchip: add a SiFive PLIC driver
Message-ID: <20180803122958.GA18301@lst.de>
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-11-hch@lst.de> <2416469e-c39e-6481-f5e0-ad191b858d06@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2416469e-c39e-6481-f5e0-ad191b858d06@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:13:26PM -0700, Atish Patra wrote:
>> + * which device 0 is defined as non-existant by the RISC-V Priviledged Spec.
> /s/existant/existent
>
> /s/Priviledged/Privileged
>> + * Each hart context has a vector of interupt enable bits associated with it.
> /s/interupt/interrupt

All fixed.

>> +	WARN_ON_ONCE(!handler->present);
>> +
>> +	csr_clear(sie, SIE_STIE);
>
> We should clear the SIE_SEIE not SIE_STIE. Correct ?

Yes, fixed.

>> +	if (plic_regs) {
>> +		pr_warning("PLIC already present.\n");
>
> Got a check-patch warning.
>
> WARNING: Prefer pr_warn(... to pr_warning(...
> #257: FILE: drivers/irqchip/irq-sifive-plic.c:191:
> +               pr_warning("PLIC already present.\n");

Fixed.

>> +
>> +		if (of_irq_parse_one(node, i, &parent)) {
>> +			pr_err("failed to parse parent for contxt %d.\n", i);
> /s/contxt/context

Fixed.

>> +			continue;
>> +		}
>> +
>> +		/* skip context holes */
>> +		if (parent.args[0] == -1)
>> +			continue;
>> +
>> +		cpu = plic_find_hart_id(parent.np->parent);
>
> Since plic_find_hart_id() is going to walk up the DT, we can pass only 
> parent.np instead of parent.np->parent. It does not increase any efficiency 
> either way. So not very necessary. Just thought of taking the advantage of 
> plic_find_hart_id.

Yeah, I'll update this.

Thanks for the review!
