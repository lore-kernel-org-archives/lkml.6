Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18034C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C604020878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bftqpUl/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="azWmmejp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C604020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbeGJUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:38:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGJUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:38:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC4A660B18; Tue, 10 Jul 2018 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531255088;
        bh=hyNqHxTM2ATUYNNPkMogwMP0q3tsA8JcQrb/mmI0Ots=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bftqpUl/zzu8sa5eRPmh77HTMdIHSXU8+rkgfUSBfAG7aRUHcWLGgM7S1tnN/wFaF
         OKh9jpKo7HM5T3Ch76tH7d0JYANy4fFwLAJR7tibPJV5TkpYxNwACX20KOxl5F6c9e
         p5sfIpqXzWqVUIQ44Qern15MKZCIZPRJMJboHbRU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A59560C8E;
        Tue, 10 Jul 2018 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531255086;
        bh=hyNqHxTM2ATUYNNPkMogwMP0q3tsA8JcQrb/mmI0Ots=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azWmmejpLFizt+ReAMw77L25xH9/C+HHPsFPZ4LIBPUq+jm9K+KSTw3Qc2WJOzysT
         o3PeaLeUNHjWIe5wATQ48i1mM7mj6jCGBBvbJTyJ9HziQKMjOjuLiixl1zX49X+RYZ
         /ntmAxRqE+302cJUTFMIpAdZ7/+gJXDXIIk3lm9s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A59560C8E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 10 Jul 2018 14:38:05 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH] pinctrl: msm: Pass along set_wake failures
Message-ID: <20180710203805.GA14825@codeaurora.org>
References: <20180619234349.166190-1-evgreen@chromium.org>
 <20180709173022.GH2050@tuxbook-pro>
 <CAE=gft5+oOFv8y-XCtiQ8mc7gQ1FFSK0+bPk=mJu--ovLfDDJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft5+oOFv8y-XCtiQ8mc7gQ1FFSK0+bPk=mJu--ovLfDDJg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10 2018 at 12:53 -0600, Evan Green wrote:
>On Mon, Jul 9, 2018 at 10:27 AM Bjorn Andersson
><bjorn.andersson@linaro.org> wrote:
>>
>> Sorry for not getting back to you in a timely manner Evan, I wanted to
>> read up more on the details of how this is supposed to work. I still
>> haven't done so, but here's my concern:
>>
>> When we power down the SoC we're no longer powering either the TLMM or
>> the GIC, so the MPM or PDC is used to waking the system on some set of
>> triggers. As such set_wake on an individual pin or irq should be routed
>> to the MPM/PDC driver, which (in the PDC case) is implemented using
>> hierarchical irq domains.
>>
>> As such I think that we shouldn't toggle the wake property of the
>> summary pin at all; i.e. the patch should remove that call rather than
>> propagating what I believe is a constant failure.
>>
>> Regards,
>> Bjorn
>
>Hi Bjorn,
>That's okay, I always feel bad pinging. Thanks for the thoughtful
>response. Stephen and I are starting to think about how wake
>interrupts should work with regard to the PDC, and we're at a place
>where we're a bit unsure of the path forward.
>
>Our understanding is the downstream kernel had an interrupt hierarchy
>of GIC > PDC > TLMM & everybody else. In the downstream world PDC
>acted transparently, forwarding most requests directly onto the GIC,
>but quietly handling wake interrupts as well. With the upstream PDC
>driver, the #interrupt-cells got changed to 2, and it seemed like
>folks didn't like the idea that PDC was acting transparently. Correct
>me if I'm wrong there. So now we're sort of unsure about how to wire
>in PDC. If we make everybody an interrupt child of PDC, then we lose
>the ability to specify the third GIC parameter, and we're stuck
>expressing interrupts with respect to PDC pins, which is an awkward
>mental translation.
Its an unfortunate side effect of the design. Drivers will have to
request the PDC pin for wakeup IRQs.

>In this world, does TLMM need to do direct-connect
>stuff to get wake-able GPIO interrupts working? It would kind of have
>a foot in both worlds, with its summary interrupt as a GIC interrupt
>but the wakeable ones as parented by PDC?
>
With GPIOs, I am trying to hack the TLMM driver to request a PDC pin,
when the IRQ associated with the GPIO is requested as a wakeup
interrupt. In that case, the TLMM driver would do the GPIO->PDC pin
translation and request it. There is no hierarchy between TLMM and PDC.

Will try a RFC patch in a week or two.

-- Lina

>So anyway, with regard to this patch, I'm happy to create a second
>spin that simply removes this function, but for me at least it brought
>up some larger questions we've been wrestling with.
>-Evan
>--
>To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
