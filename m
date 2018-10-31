Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78926C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274C42081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JV7y+nV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274C42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeJaT35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:29:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42066 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeJaT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:29:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id q6-v6so11208112lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brhXqZWk2CFBz+8dpPTkehoOD//C3pV+L6Z3GMryY+w=;
        b=JV7y+nV3jy9t68+Ya1AecdZWKegp+v9D7+KnK+MGkVyQtcBEpgb03tT0gx+KAWRyhy
         b03bTap8jR14x5G3m5nDlB8cqBTtogJa2TWvzqHcGxo3lfpwyZDCyEw2BpG+JWX0wVvd
         UR/RmNv6X73fshNLwLqP5IwTqqTSkTS42pnOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brhXqZWk2CFBz+8dpPTkehoOD//C3pV+L6Z3GMryY+w=;
        b=udhH04HtLe2Tu8K/CcORt1QygV05tZf45fIpIURIxxZ6aJJtXg2CID0urthB8tvINA
         dD9ULCE91VGb3fDx/5lTbCgPAQXGJ7WgePr1q33vgS6jFMErz19cjoCDm/FKNMgaqwW4
         KByJc//cqRoRP6YoCgWlXdn+bqwySM8sQaN8CX5h7RaKXmNf6wH3IeWRP8UpsmdOR7g+
         pMBGCDVQNKnsKeR/4KyZwD9mU1LyGQ5WLvJZjeS3y9jr3tqvVjnx++MqeQ7rSapBNs1q
         osJ4F8qX2OXcFOR3AnxD8KRFFDHVrhMol30U/+e0b8W6m+CLVSMHdh2a/LfowO/+Hdcb
         OFxA==
X-Gm-Message-State: AGRZ1gJkJilOL7EWIFaOE3ncRT8B7l4iRrP6WzFI8BaQKEXyINA/gclC
        XJ0/rESHzH+23b5yOMQWJauu/w2IaxhKYX03bUAkLQ==
X-Google-Smtp-Source: AJdET5fNQuHVKj1notSth1Eibb4D1d/faK2LqzABVSaOfxxWEug7AYmQVqhjOWnQsa/58+rE8X1+gQz3Bj+TgEiPA08=
X-Received: by 2002:a19:4849:: with SMTP id v70mr1463697lfa.62.1540981943687;
 Wed, 31 Oct 2018 03:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181024134040.115413-1-smuchun@gmail.com>
In-Reply-To: <20181024134040.115413-1-smuchun@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 11:32:11 +0100
Message-ID: <CACRpkdbht0wn=Vy4-M-sgEbsiY-S8u3eP0s_DM+j+6vWvZG5cQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix possible use after free on label
To:     smuchun@gmail.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

thanks for your patch!

On Wed, Oct 24, 2018 at 3:41 PM Muchun Song <smuchun@gmail.com> wrote:

> gpiod_request_commit() copies the pointer to the label
> passed as an argument only to be used later. But there's a
> chance the caller could immediately free the passed string
> (e.g., local variable). This could trigger a use after free
> when we use gpio label(e.g., gpiochip_unlock_as_irq(),
> gpiochip_is_requested()).
>
> To be on the safe side: duplicate the string with
> kstrdup_const() so that if an unaware user passes an address
> to a stack-allocated buffer, we won't get the arbitrary label.
>
> Signed-off-by: Muchun Song <smuchun@gmail.com>

I am a bit worried about the memory consumption for this,
but I guess typically this should not be much.

I am a little bit lost in const-correctness here, and I do
understand that the label could point to something allocated on
the stack, but it seems like an awkward way of shooting
oneself in the foot really. Allocate something and then
pass it as a const char *? That is something we could pretty
much detect with a cocinelle script I think?

Anyways: if you want to proceed with this approach, also
make sure to fix gpiod_set_consumer_name() to free previous
label and make a new strdup when called.

Yours,
Linus Walleij
