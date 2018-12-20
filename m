Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B66C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E19E21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeLTG4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:56:39 -0500
Received: from shell.v3.sk ([90.176.6.54]:53581 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbeLTG4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:56:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D2A646B422;
        Thu, 20 Dec 2018 07:56:34 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kN4wDB2_bIq8; Thu, 20 Dec 2018 07:56:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 811DB6B43E;
        Thu, 20 Dec 2018 07:56:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O0QsEjHXBdUE; Thu, 20 Dec 2018 07:56:31 +0100 (CET)
Received: from localhost (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D82156B422;
        Thu, 20 Dec 2018 07:56:30 +0100 (CET)
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
From:   Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v3] irqchip/mmp: only touch the PJ4 & FIQ bits on enable/disable
Date:   Thu, 20 Dec 2018 07:43:15 +0100
Message-ID: <1545288195.11355.1@nedofet.local>
In-Reply-To: <b1139e52-3f0c-05af-0944-96cb048e6cc9@arm.com>
References: <20181219172822.18349-1-lkundrak@v3.sk> <fc85f7e6-fc78-9e7c-258e-a0a60d195686@arm.com> <10639e018803dd2b7efa0a99ca78df1a533fdb4c.camel@v3.sk> <b1139e52-3f0c-05af-0944-96cb048e6cc9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 19/12/2018 18:37, Lubomir Rintel wrote:
>> On Wed, 2018-12-19 at 18:29 +0000, Marc Zyngier wrote:
>>> On 19/12/2018 17:28, Lubomir Rintel wrote:
>>>> On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
>>>> and 72 interrupts. Don't reset the "route to SP" bit (4).
>>>>
>>>> I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
>>>> SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
>>>> ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
>>>> was not helpful.
>>>>
>>>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>>>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>>>
>>>> ---
>>>> Changes since v2:
>>>> - Correct subsystem maintainers on Cc (irqchip)
>>>>
>>>> Changes since v1:
>>>> - Adjusted wording & ack from Pavel
>>>>
>>>>  drivers/irqchip/irq-mmp.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
>>>> index 25f32e1d7764..1ed38f9f1d0a 100644
>>>> --- a/drivers/irqchip/irq-mmp.c
>>>> +++ b/drivers/irqchip/irq-mmp.c
>>>> @@ -190,7 +190,7 @@ static const struct mmp_intc_conf mmp_conf = {
>>>>  static const struct mmp_intc_conf mmp2_conf = {
>>>>  	.conf_enable	= 0x20,
>>>>  	.conf_disable	= 0x0,
>>>> -	.conf_mask	= 0x7f,
>>>> +	.conf_mask	= 0x60,
>>>
>>> You seem to have identified that ICU_INT_ROUTE_PJ4_IRQ and
>>> ICU_INT_ROUTE_PJ4_FIQ bits are the only ones to be touched. So why don't
>>> you use these constants? This number soup is quite unhealthy.
>> 
>> Yeah, but those #defines live in mach-mmp, so some moving would be
>> necessary. If you indeed prefer that then I can follow up with a patch
>> that does that.
> 
> Given that nothing in the tree uses these #defines at all, they can be
> swiftly moved in one single go.

Will do.

>>> It'd be good to Cc some of the folks who initially wrote this code
>>> (Haojian Zhuang, Eric Miao -- assuming they are still around) and get
>>> some testing on a non OLPC platform, just to make sure there is no
>>> regression due to this. I have the nagging feeling that this could be a
>>> platform specific thing rather than a universal setting.
>> 
>> They've been Cc'd on previous spins of the patch (and tens of other
>> mmp-related patches that were in circulation lately), but they never
>> returned a response. It is safe to assume they're AWOL.
> 
> OK, so what else in the known universe uses the same SoC and runs
> mainline? This really needs wider testing if we can't get information
> from the MV folks.

While I can't possibly know for sure, I think it's fairly sure there are no
users beyond OLPC. The only MMP2 board that would run this was "Brownstone"
(that can't be obtained anymore) and the whole mmp2-dt support was
unbootable until recently without anyone noticing.

I think we're safe here. If anyone with a Brownstone board running mainline
exists (unlikely), linux-next + a few RCs are going to give them a good
chance to test this,

> 
> Thanks,
> 
> 	M.

Cheers,
Lubo
