Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59227ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16514208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fH4pW69z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fH4pW69z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16514208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeGLUPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:15:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732249AbeGLUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:15:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ACA360B6B; Thu, 12 Jul 2018 20:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531425873;
        bh=A1wAqMLm9duPJD9A78Ueky/EVya5Up3X8vNp9EscHZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fH4pW69z6/7cRm3N+DajyJIHu2j2UT3Fm3uy0edJEi8DuPhY844Dmfsjo8kgR76dT
         YcN/6Acc4vxwGPm3crW4jVMCl5tvZlLeYjV3Ko7uei5Tg1tjblw+sH0rZgjMYWUuNe
         hajWrciyEX2+BUkn1+pjG+0sX4G0SQt0xsfyl0Ng=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBEAC6074D;
        Thu, 12 Jul 2018 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531425873;
        bh=A1wAqMLm9duPJD9A78Ueky/EVya5Up3X8vNp9EscHZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fH4pW69z6/7cRm3N+DajyJIHu2j2UT3Fm3uy0edJEi8DuPhY844Dmfsjo8kgR76dT
         YcN/6Acc4vxwGPm3crW4jVMCl5tvZlLeYjV3Ko7uei5Tg1tjblw+sH0rZgjMYWUuNe
         hajWrciyEX2+BUkn1+pjG+0sX4G0SQt0xsfyl0Ng=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBEAC6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 12 Jul 2018 14:04:32 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH] pinctrl: msm: Pass along set_wake failures
Message-ID: <20180712200432.GA887@codeaurora.org>
References: <20180619234349.166190-1-evgreen@chromium.org>
 <20180709173022.GH2050@tuxbook-pro>
 <CAE=gft5+oOFv8y-XCtiQ8mc7gQ1FFSK0+bPk=mJu--ovLfDDJg@mail.gmail.com>
 <20180710203805.GA14825@codeaurora.org>
 <CAE=gft7RURCr0Lj8qO+i5EjwD25xkdqS+UB5RC_02-7FLdM1fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft7RURCr0Lj8qO+i5EjwD25xkdqS+UB5RC_02-7FLdM1fg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12 2018 at 10:31 -0600, Evan Green wrote:
>On Tue, Jul 10, 2018 at 1:38 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Tue, Jul 10 2018 at 12:53 -0600, Evan Green wrote:
>> >On Mon, Jul 9, 2018 at 10:27 AM Bjorn Andersson
>> ><bjorn.andersson@linaro.org> wrote:
>> >Our understanding is the downstream kernel had an interrupt hierarchy
>> >of GIC > PDC > TLMM & everybody else. In the downstream world PDC
>> >acted transparently, forwarding most requests directly onto the GIC,
>> >but quietly handling wake interrupts as well. With the upstream PDC
>> >driver, the #interrupt-cells got changed to 2, and it seemed like
>> >folks didn't like the idea that PDC was acting transparently. Correct
>> >me if I'm wrong there. So now we're sort of unsure about how to wire
>> >in PDC. If we make everybody an interrupt child of PDC, then we lose
>> >the ability to specify the third GIC parameter, and we're stuck
>> >expressing interrupts with respect to PDC pins, which is an awkward
>> >mental translation.
>> Its an unfortunate side effect of the design. Drivers will have to
>> request the PDC pin for wakeup IRQs.
>
>Would they use the PDC pin to request their regular interrupt, and the
>PDC would turn around and ask the GIC for them, and also enable the
>wakeup interrupt?>
Yes, drivers would need to request a PDC pin since using the
interrupts-extended format and then enable that interrupt was a wakeup
interrupt.

> Or would devices have some sort of separate entry for wakeup
> interrupts?
Not sure how you mean. If it's the DT you are asking, then yes, they
would need to have a separate entry in DT.

	wake-device {
        	interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;
	};

See Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt

Thanks,
Lina

