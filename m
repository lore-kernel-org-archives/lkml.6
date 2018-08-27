Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2414AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA751208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lVazhHuK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q0k/PlI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA751208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH0UoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:44:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH0UoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:44:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7DC7606DD; Mon, 27 Aug 2018 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535389006;
        bh=8NyyRTX0SX7D0UuHcHWq80gYnbGevPxQyCdSMXAbQp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVazhHuKiysfCc760/2rJJ5yrJpG41mFW/3y5Ix2lgCjvcqwzbqAa9nhiTMJnIoMn
         hCKaRcnZFnsPTgbGnfpMgUhL057psMv9PTdqf+LyyzWJPR3HzRjHU2QPt8vBM4ebdE
         CSdcNOOF298r/+yO3NNi010W3RcctSa/26oyJRy0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E62760271;
        Mon, 27 Aug 2018 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535389005;
        bh=8NyyRTX0SX7D0UuHcHWq80gYnbGevPxQyCdSMXAbQp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0k/PlI4TOsazhVLLxI7jIBp4/cQ0J8AvnANPm89Pnw7sGKu88fJIFxhcV9cribdp
         Ye7kG1PwyfbqgglSCgxhuIs5iS1ULRhCfWaHu0iVzTL7y+xNb31djW4le7GRXIOTpX
         AF9h7GGYk8AyvybiLQkoWaG2xIim1HzhA860YK8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E62760271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 27 Aug 2018 10:56:44 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        rplsssn@codeaurora.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180827165644.GR5081@codeaurora.org>
References: <20180817163849.30750-1-ilina@codeaurora.org>
 <20180817163849.30750-2-ilina@codeaurora.org>
 <CACRpkdb+Opdn1eWZSRydS1Bafpqwcg83xEcT-YJC6D-kSSi1ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACRpkdb+Opdn1eWZSRydS1Bafpqwcg83xEcT-YJC6D-kSSi1ew@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26 2018 at 08:33 -0600, Linus Walleij wrote:
>On Fri, Aug 17, 2018 at 6:39 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
>> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>> domain can wakeup the SoC, when interrupts and GPIOs are routed to the
>> its interrupt controller. Only select GPIOs that are deemed wakeup
>> capable are routed to specific PDC pins. During low power state, the
>> pinmux interrupt controller may be non-functional but the PDC would be.
>> The PDC can detect the wakeup GPIO is triggered and bring the TLMM to an
>> operational state.
>>
>> Interrupts that are level triggered will be detected at the TLMM when
>> the controller becomes operational. Edge interrupts however need to be
>> replayed again.
>>
>> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
>> but keep it disabled. During suspend, we can enable the PDC IRQ instead
>> of the GPIO IRQ, which may or not be detected.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v1:
>>         - Trigger GPIO in h/w from PDC IRQ handler
>>         - Avoid big tables for GPIO-PDC map, pick from DT instead
>>         - Use handler_data
>
>Just for the record this is an impressive and much needed patch
>set, no other SoC developer has yet taken on the task of making this
>work so I very much appreciate that Qualcomm show the way.
>
>> +static int msm_gpio_pdc_pin_request(struct irq_data *d)
>> +static int msm_gpio_pdc_pin_release(struct irq_data *d)
>> +static int msm_gpio_irq_reqres(struct irq_data *d)
>> +{
>(...)
>> +       if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
>(...)
>> +static void msm_gpio_irq_relres(struct irq_data *d)
>> +{
>> +       gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
>> +}
>
>FYI Hans Verkuil is working on a patch set that moves the
>lock/unlock as IRQ call to the irqchip request() and release()
>functions so we can switch a GPIO irqchip line from IRQ
>mode to say output at runtime without too much trouble.
>(CEC needs this.)
>
Thanks, I will look into Hans's RFCv2. But what would help me would be
to avoid creating the IRQ for the GPIO itself (I have the latent IRQ),
if I could just return that instead in gpio_to_irq(), it might be
easier. I understand ->to_irq() is supposed to be a translate function
only, I can avoid the dance of enabling and diabling the PDC IRQ on
suspend and resume.

-- Lina

>I suspect that will make your work easier?
>
>Hans can you include Lina in the loop for your patches
>so she can take that into accoun because I think we might
>need that as a base for this.
>
>Yours,
>Linus Walleij
