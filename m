Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261A720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TSDrvArY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261A720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeGYTHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:07:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5669 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532541286; x=1564077286;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qugCRF+yrowuIomfDArrNBHEH2RcsrJRj1KcJrN9z7o=;
  b=TSDrvArYQWpxAt9cOm6vcWodmLiEawqO8/lcege9v5Gfj8QFSO8bcz16
   JH7P8arwxVgxirBPbUw9dpFyIKf0ixioN4dGJAZFK3nk9ZbNZkJ2vgrtC
   DjT7EqLGQR3eKCOexY+823PQLIY3Z6F3COn5EeJnZBZhlNdg7Dm9pmNfu
   Q2Q38B1K5gfphqLGY1YPQJTgyX/ltKZz94/dm/Tn9OYUh0TOca/WbQ24v
   2vdgc/YkLgYV1jlZXA3hKAuYoCcO9JICq5DxjMEx/IvIuQrpumRNXz0Is
   FhURKeQW2uGHhNH6kuqPMbkMUJEv1ppz2b+UDpIShB2aeiPj7B4lV7E6B
   A==;
X-IronPort-AV: E=Sophos;i="5.51,401,1526313600"; 
   d="scan'208";a="188656533"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2018 01:54:46 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jul 2018 10:43:23 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jul 2018 10:54:46 -0700
Subject: Re: [PATCH 3/6] irqchip: RISC-V Local Interrupt Controller Driver
To:     Marc Zyngier <marc.zyngier@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20180725093649.32332-1-hch@lst.de>
 <20180725093649.32332-4-hch@lst.de>
 <c3ccb953-cd75-4a37-636a-ca643602053a@arm.com>
 <20180725112457.GA24502@lst.de>
 <53518395-83bb-9c2f-bd96-287cc83a1c63@arm.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <afef2fc3-de3a-66f5-36c7-7341931b8a29@wdc.com>
Date:   Wed, 25 Jul 2018 10:54:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <53518395-83bb-9c2f-bd96-287cc83a1c63@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 4:37 AM, Marc Zyngier wrote:
> On 25/07/18 12:24, Christoph Hellwig wrote:
>> On Wed, Jul 25, 2018 at 12:18:39PM +0100, Marc Zyngier wrote:
>>> This feels odd. It means that you cannot have the following sequence:
>>>
>>> 	local_irq_disable();
>>> 	enable_irq(x); // where x is owned by a remote hart
>>>
>>> as smp_call_function_single() requires interrupts to be enabled.
>>>
>>> More fundamentally, why are you trying to make these interrupts look
>>> global while they aren't? arm/arm64 have similar restrictions with GICv2
>>> and earlier, and treats these interrupts as per-cpu.
>>>
>>> Given that the drivers that deal with drivers connected to the per-hart
>>> irqchip are themselves likely to be aware of the per-cpu aspect, it
>>> would make sense to align things (we've been through that same
>>> discussion about the clocksource driver a few weeks back).
>>
>> Right now the only direct consumers are said clocksource, the PLIC
>> driver later in this series and the RISC-V arch IPI code.  None of them
>> is going to do a manual enable_irq, so I guess the remote case of the
>> code is simply dead code.  I'll take a look at converting them to
>> per-cpu.  I guess the GICv2 driver is the best template?
> 
> I think you can do a much better job than the GICv2 driver ;-). You have
> the chance of a clean slate, and no legacy (or ACPI) junk to deal with!
> 
> I think this is just a matter of moving the HLIC declaration in DT to be
> outside of the cpu nodes (you just have a single HLIC node that is valid
> for all the CPUs in the system), and making the interrupts percpu_devid
> in your mapping function (see gic_irq_domain_map for reference).
> 

If I am not wrong, we need to change the interrupt-extended property in 
PLIC DT entry as well. Currently, there are 5 entries corresponding to 
individual HLIC. I was also planning to start working on converting HLIC 
to per-cpu but it got delayed because of travel.

Christoph: I am not sure if you have access to HighFive Unleashed board. 
If not I would be happy to test it on the board whenever your patches 
are ready.

Regards,
Atish
> Thanks,
> 
> 	M.
> 

