Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F7E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F7E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeGYMsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:48:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbeGYMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:48:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA96F80D;
        Wed, 25 Jul 2018 04:37:14 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC69D3F575;
        Wed, 25 Jul 2018 04:37:12 -0700 (PDT)
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20180725093649.32332-1-hch@lst.de>
 <20180725093649.32332-4-hch@lst.de>
 <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com>
 <20180725112457.GA24502@lst.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <53518395-83bb-9c2f-bd96-287cc83a1c63@arm.com>
Date:   Wed, 25 Jul 2018 12:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725112457.GA24502@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/18 12:24, Christoph Hellwig wrote:
> On Wed, Jul 25, 2018 at 12:18:39PM +0100, Marc Zyngier wrote:
>> This feels odd. It means that you cannot have the following sequence:
>>
>> 	local_irq_disable();
>> 	enable_irq(x); // where x is owned by a remote hart
>>
>> as smp_call_function_single() requires interrupts to be enabled.
>>
>> More fundamentally, why are you trying to make these interrupts look
>> global while they aren't? arm/arm64 have similar restrictions with GICv2
>> and earlier, and treats these interrupts as per-cpu.
>>
>> Given that the drivers that deal with drivers connected to the per-hart
>> irqchip are themselves likely to be aware of the per-cpu aspect, it
>> would make sense to align things (we've been through that same
>> discussion about the clocksource driver a few weeks back).
> 
> Right now the only direct consumers are said clocksource, the PLIC
> driver later in this series and the RISC-V arch IPI code.  None of them
> is going to do a manual enable_irq, so I guess the remote case of the
> code is simply dead code.  I'll take a look at converting them to
> per-cpu.  I guess the GICv2 driver is the best template?

I think you can do a much better job than the GICv2 driver ;-). You have
the chance of a clean slate, and no legacy (or ACPI) junk to deal with!

I think this is just a matter of moving the HLIC declaration in DT to be
outside of the cpu nodes (you just have a single HLIC node that is valid
for all the CPUs in the system), and making the interrupts percpu_devid
in your mapping function (see gic_irq_domain_map for reference).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
