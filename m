Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E10FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397FF218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCf8c7Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeLSPWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:22:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45838 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeLSPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:22:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so19377633ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4juBtjJ0FVQs8o2MBppal6kfTqbhKLpXoQje4ojS/yg=;
        b=RCf8c7Cqy1WpX0Ybs82FuwaHwFlQ67QA9XMi8QAXKohbrAfBlEe5vpBqLELzlh4too
         24TUdkDuvqMEHNP07jdNYqN3IkQoOeg6ew/X5eWparduSUMsEJswwk8RGbTRCi7IEJJW
         ff1zTNbz2f5BPEudXMyAmhCsrAAEEOjqemilQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4juBtjJ0FVQs8o2MBppal6kfTqbhKLpXoQje4ojS/yg=;
        b=T5nHj0yxYY18fKwt4FTGzuA9hMDtQFMy5GpJQLH4e6IPFy/MQfv18vckpe3eaKYvUb
         pYE+p3VxEh5UsvFiPD6a4f36zRgDfF8LAQgXQhX7gEqy2XB9Ay1M1gLDwoiDKcWGqEew
         3jo5+Hz2Zo1WpxYS2sfvi0SrFA8pW2J+IsYNW3uxM3W9wajbPTvzRYITXpeRt7U7n/DJ
         /NMSlHdu7qx9ys4DKB2IbeJtiA+X7Cj2xuShJNDUoeB9iE2mpjEB4PA3BrUXW5YA+B9A
         0TfRJXvkYWkfTgMXIpUTebRxC0yEqSwhVTUK9TG6YrN1196gY4uWfISlikEatq9MhshS
         LdAw==
X-Gm-Message-State: AA+aEWaNm3ImJaT1XaBxqz5v5V/o/r44I3Toulme1FQ0AqkmTo93GZlD
        gkTiy2hsx9DWIOYThIjV5Sw4cyVTtUiFe6KFhOsIcTlN4hU=
X-Google-Smtp-Source: AFSGD/WcyZXa9/1TGJNU/0CI8EpRkr+4nRMHIRgYKGsy/55g7A3emXa4Tqf2mjfoPrvtxAB1bp0ZiPDORMwivfaXEkU=
X-Received: by 2002:a9d:5a81:: with SMTP id w1mr341117oth.317.1545232920951;
 Wed, 19 Dec 2018 07:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-5-kristina.martsenko@arm.com> <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
 <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com> <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
In-Reply-To: <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 19 Dec 2018 15:21:49 +0000
Message-ID: <CAFEAcA99QrjnHRT8_WK1MjUHv_X9yGMmnQAtWL94Y8=FJotikg@mail.gmail.com>
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        awallis@codeaurora.org, Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        amit.kachhap@arm.com, Dave P Martin <dave.martin@arm.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 20:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/10/18 2:12 PM, Kristina Martsenko wrote:
> > The plan was to disable trapping, yes. However, after that thread there
> > was a retrospective change applied to the architecture, such that the
> > XPACLRI (and XPACD/XPACI) instructions are no longer trapped by
> > HCR_EL2.API. (The public documentation on this has not been updated
> > yet.) This means that no HINT-space instructions should trap anymore.
>
> Ah, thanks for the update.  I'll update my QEMU patch set.

Just to follow up on this loose end, this change to HCR_EL2.API
trap behaviour is documented in the 00bet9 release of the system
register XML which came out today:
https://developer.arm.com/products/architecture/cpu-architecture/a-profile/exploration-tools/system-registers-for-armv8-a

thanks
-- PMM
