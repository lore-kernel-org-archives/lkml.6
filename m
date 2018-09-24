Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD32D20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R/C7Fyrw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NjRSj+lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD32D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeIXVi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:38:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeIXVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:38:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8589360275; Mon, 24 Sep 2018 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537803343;
        bh=2/odgQNhiVZLh5asPkZ0bd8jbF9pbwHTX22kJbUPikI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/C7FyrwUZrUsExUo5T5CMsoYlt2Tdtj+B/Kjct1ytXueF519KDr/gp86Lmk5bDlb
         7bZxWCDbQQTaPD16Kclp2knpwxR4V/OFItsdaV0YtTpMOy6c6Lr1MF5uS6VP+lXGlU
         FOvTisBKN6Mr4ECrD7ztqb6eD9020jMZn5fPVYoU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9222E60214;
        Mon, 24 Sep 2018 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537803342;
        bh=2/odgQNhiVZLh5asPkZ0bd8jbF9pbwHTX22kJbUPikI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjRSj+lIiipzhESl9vkFoOWups4TJTQXqHk3PDhSi7j2nsDvAT32a9yWucUvJnBX/
         76UcesjjajUmLccA69G0FYhuvgY0jNEOCGinbFfYYZbPbmm7EzrZXL6lMyN5WdcT6s
         z1Qk1+AYkQsETO/Se3knI+KBTox9O7ZJOomiuruY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9222E60214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 24 Sep 2018 09:35:41 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH v3 3/5] drivers: pinctrl: msm: enable PDC interrupt only
 during suspend
Message-ID: <20180924153541.GJ17420@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
 <20180904211810.5506-4-ilina@codeaurora.org>
 <868t3twl64.wl-marc.zyngier@arm.com>
 <20180922170909.GI17420@codeaurora.org>
 <867ejcwnn7.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <867ejcwnn7.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23 2018 at 03:48 -0600, Marc Zyngier wrote:
>On Sat, 22 Sep 2018 18:09:09 +0100,
>Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Sat, Sep 22 2018 at 10:29 -0600, Marc Zyngier wrote:
>> > Hi Lina,
>> >
>> > On Tue, 04 Sep 2018 22:18:08 +0100,
>> > Lina Iyer <ilina@codeaurora.org> wrote:

>> Also, I am exploring an option that was suggested by Stephen [1] to just
>> use the PDC interrupt as a parent of the GPIO IRQ and use a different
>> irqchip for the PDC interrupt. I ran into some issue with accessing
>> irqchip and irqdata of the PDC interrupt, since the irqchip was not in
>> hierarchy with the GPIO's irqchip. I haven't been able to find time to
>> resolve the issue that the set_parent_ functions, because of the
>> hierarchy.
>>
>> Essentially, we have two different mechanisms for GPIO IRQs based on
>> whether they can be woken up by the PDC interrupt.
>>
>> 	GPIO-IRQ --> PDC --> GIC
>>
>> 	GPIO-IRQ --> TLMM SUMMARY --> GIC
>>
>> Do you think the idea is feasible? It would avoid doing all this
>> enable/disable at every suspend and even during idle, when the TLMM
>> could be powered off.
>
>[me tries to page it all in again]
>
>You could have the PDC as part of the GPIO hierarchy:
>
>	GPIO -> PDC -> TLMM -> GIC
>
The PDC irqchip's parent is the GIC as set up in
drivers/irqchip/qcom-pdc.c. Wouldn't that conflict with the established
hierarchy?

>and always configure the PDC as a wake-up source. I just wonder if you
>can do that without setting up a parallel hierarchy between the PDC
>and the GIC. We already have similar things in the tree (see OMAP's
>wakeupgen), and it may be worth having a look.
Sure, will take a  look.

>The lack of interrupt
>replaying on the PDC is quite annoying (I have much stronger words in
>mind though), and I'm not sure we can easily fix that one without this
>parallel interrupt hack (you need something to inject edge interrupts
>in the TLMM).
>
The PDC replays the intterupt at the GIC, not the at the TLMM. So the
hierachy you recommended may not work as well here.
>>
>>
>> >> +			disable_irq(irqd->irq);
>> >> +			enable_irq(irq);
>> >> +		}
>> >> +	}
>> >
>> > Given that you're changing in_suspend and parsing the bitmap,
>> > shouldn't take the pdc spinlock?
>> >
>> Since we are the the only CPU running and suspend/resume (and even idle)
>> would be serialized I didn't see a reason for needing a lock.
>
>In that case, what is the purpose of 'in_suspend' if
>msm_gpio_irq_set_wake cannot happen during the suspend/resume phases?
>It all seems a bit inconsistent.
>
Well the disable_irq_wake that I call here, calls into the set_wake
callbacks. Hence the flag to indicate that we should ignore the PDC
interrupt configuration at that time. Let me see if I need to disable
the disable_irq_wake at all.

Thanks,
Lina

