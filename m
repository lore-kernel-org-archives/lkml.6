Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42ABC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B032086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HH+5jkuU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n8+TPbMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B032086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIYXYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:24:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIYXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:24:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 00E2D600ED; Tue, 25 Sep 2018 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537895767;
        bh=pq5GUkvJqeZXxBFOkLmZGmrNOinvzo7t8jA4sYA34N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HH+5jkuUs+0+d8ID3L47NUYkIAt5+n97mMsHtfLDJB6WPCIgPQlKKb7+0Bfd9T+wX
         O3VJK/+HTGHpdC5sVPy0I8qhxtzsv1elyjPLvaG6ElAcsQwOaRMkL4P8JhphuCQr5O
         aYp5K3shanndNkqct10AI64vkG2tPipfpeGwIlxE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2766B60116;
        Tue, 25 Sep 2018 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537895766;
        bh=pq5GUkvJqeZXxBFOkLmZGmrNOinvzo7t8jA4sYA34N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8+TPbMmBhGBrSortlRhaNIPOMR7Va5xLTMEzHjjnV/ipfcGrIVGF0xAFhc7IcwVC
         4GqGsJnk6oSfEE1ZY7xff8sGyczdKmRcuJRuaP4DYsjBTDW8g0k6EySLeukh6qw68a
         nDixkRjztAuT4urgT0N6OIE3O0vLhQCSdmpQYkh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2766B60116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 25 Sep 2018 11:16:05 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/9] Implement wake event support on Tegra186 and later
Message-ID: <20180925171605.GK17420@codeaurora.org>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <CACRpkdbLoz+gSFa292OFNszeS6tNywpBRHyGwL9SK2u5s=UhZw@mail.gmail.com>
 <20180925095723.GC7097@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180925095723.GC7097@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Linus, for bringing this to my attention.

Hi Thierry,

On Tue, Sep 25 2018 at 03:57 -0600, Thierry Reding wrote:
>On Tue, Sep 25, 2018 at 10:48:39AM +0200, Linus Walleij wrote:
>> Hi Thierry,
>>
>> thanks for working on the wakeup business!
>>
>> This patch gets me a bit confused on our different approaches
>> toward wakeups in the kernel, so I included Lina, Marc and Ulf
>> to see if we can get some common understanding.
>>
>> On Fri, Sep 21, 2018 at 12:25 PM Thierry Reding
>> <thierry.reding@gmail.com> wrote:
>>
>> > The following is a set of patches that allow certain interrupts to be
>> > used as wakeup sources on Tegra186 and later. To implement this, each
>> > of the GPIO controllers' IRQ domain needs to become hierarchical, and
>> > parented to the PMC domain. The PMC domain in turn implements a new
>> > IRQ domain that is a child to the GIC IRQ domain.
>> >
>> > The above ensures that the interrupt chip implementation of the PMC is
>> > called at the correct time. The ->irq_set_type() and ->irq_set_wake()
>> > implementations program the PMC wake registers in a way to enable the
>> > given interrupts as wakeup sources.
>> >
>> > This is based on a suggestion from Thomas Gleixner that resulted from
>> > the following thread:
>> >
>> >         https://lkml.org/lkml/2018/9/13/1042
>>
>> I am not sure if you are aware about Lina's series
>> "Wakeup GPIO support for SDM845 SoC"
>> that is now in v3:
>> https://patchwork.kernel.org/cover/10587965/
>>
>> It appears to me, though I am blissfully ignorant of the
>> details, that there is a relationship between this patch
>> series and the other one.
>>
>> Your approach is to insert an hiearchical PMC irq controller
>> and Lina's approach is to simply put a mechanism on the
>> side to inject IRQs into the GIC after sleep (IIUC).
>
>From a quick look at Lina's patches, I think it's more like adding a
>demultiplex in the TLMM. So the TLMM effectively has interrupt handlers
>for all wakeup interrupts so that when a wakeup interrupt happens, the
>GPIO interrupts can be replayed (using the interrupt status bit in the
>GPIO controller, if I'm reading things right).
>
I don't really have to replay the interrupt at the GPIO controller. The
PDC (= PMC on Tegra) receives the same interrupt line as the GPIO
controller and can wake up the system. The reason for this replaying the
interrupt status at the GPIO is because, the action handler registered
for the GPIO, by the driver, needs to be invoked for the PDC interrupt.
I haven't found a clean way to use the same action handler on the PDC
interrupt line. I couldn't set up the PDC as parent of the GPIO, because
not all GPIOs are routed through the PDC and secondly, the summary line
(mux line) from the GPIO is routed directly to the GIC and not the PDC.

>From a very high level view both seem indeed to be very similar and have
>the same goal. Both are in a partition that is always powered on and the
>goal is to enable wake up from certain interrupts. One difference I see
>is that the PMC on Tegra allows wake events to originate from sources
>other than GPIOs. For example the RTC or PMIC interrupts (at the GIC)
>can be a source for the wake event, as can a number of other special
>signals. The PDC on the other hand seems to be limited to GPIOs as wake
>events.
>
The PDC (= PMC on Tegra) can wake up GPIOs as well as the regular
interrupts. GIC is the parent of the PDC.

>Another area, more low-level, where these setups seem to be different is
>that the PMC isn't really a proper interrupt controller in itself. It is
>more of a top-level interrupt gate. If you enable a given wake event
>(that is, unmask the "interrupt"), that event will be able to
>
This is an area where the PDC and PMC seem to be different. PDC is an
interrupt controller that is always ON and if it detects an interrupt
from any source that is enabled, it can wake up the GIC and replay the
interrupt at the GIC.

>> I guess your hierarchy is in response to this mail from tglx:
>> https://lkml.org/lkml/2018/9/14/339
>
>Yes, there was some good discussion in that thread which helped me come
>up with this solution. I think it's pretty elegant because it allows all
>of this interaction to happen almost automatically via the existing
>infrastructure. I'm not sure the same could be applied to the PDC,
>though, because of the need to manually replay the interrupt. That's not
>something I think can be done with just the simple parent/child
>relationship that we use on Tegra.
>
I wasn't able to use the hierarchy because not all GPIOs and the summary
line are routed to the PDC. But I am exploring options of hierarchy as
well.

Thanks,
Lina

>On the other hand, I don't think implementing something akin to Lina's
>proposal would work on Tegra because in our case the PMC doesn't
>actually raise an interrupt on wake. The hardware will simply wake up
>the system, at which point all the signals will be forwarded as normal,
>so the GPIO or GIC will see the interrupts as if they happened during
>normal runtime.
>
>> So from a birds eye point of view I don't see how the Tegra
>> PMC irq controller and Qualcomm's PDC power domain
>> controller are conceptually different. Are you doing the same
>> thing in two different ways for the same problem space
>> here?
>>
>> Or are these hardwares so very different that they really
>> warrant two different approaches to wakeups?
>>
>> I guess I miss a bit of hardware insight... is the key difference
>> that in Qualcomm's PDC the IRQs need to be replayed/injected
>> by software while Tegra's PMC will do this in hardware?
>
>Yes, I think you're exactly right here. As I said above, I don't think
>there's a way to replay interrupts with a pure parent/child hierarchy
>because the hierarchy doesn't actually do anything at the interrupt
>handler level. You'd need to set up additional demultiplexing at that
>point to make it work, which is pretty much the equivalent of what Lina
>has proposed.
>
>On the other hand, since we don't get interrupts from the PMC for wake
>events themselves, we can't replay interrupts on Tegra. And we don't
>have to.
>
>Unfortunately, these seem to be really similar pieces of hardware but
>with just enough of a low-level difference to require completely
>different solutions.
>
>Thierry


