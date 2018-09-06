Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7103C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0E20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmIeab5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB0E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeIFRgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:36:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51670 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeIFRgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:36:38 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so14587701itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xI4pb01POVYyYfifY/Nw/wjK5kaIjPidd8bHfuORLtA=;
        b=QmIeab5UuE6tqApc/KxxwaRSRP/rBf4qRwrDW7j8rYakSoz2e0l5JCSHCfOjci5EPT
         bYfk7FP20HVYvmabObbQHhvm8fisbnePjl06/OMfzQFBR6aaXfh9zFAZ7JvoVZht9XtH
         pbzhqlGNR+qlF/j2OYfoe6QKI4ljJ3YTQ/Xuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xI4pb01POVYyYfifY/Nw/wjK5kaIjPidd8bHfuORLtA=;
        b=UdDSiwYtKpSkye06fS9QGUFn1qjEpnBvOMZ6R99pKKewlNol7iqYOL6IelLm6SU3iw
         OwiJqAgr8K2lZoLfFOWcfsbbV+azXKIIhxOyUfvpACv7vfNV8sms16jcWSH/1OHvLGVb
         SmE/JPrkD2AivOAtQqBLvgPczjAcHzXaS+bPqsXO+3OYmQ8BWlCKOUoDm5Edq7sGhnuZ
         dBxGqpE1nQ85xOxDzleYKJCfqk9cmkh2gLDpuTX9vhO2NBN24gLUP/eC7bBONE5cUQfe
         D9wuozq+HIQ0U86yF+B95kHMob60IKqD7t1YnL/TvaMuRXQqAwYcp5QtSjOZlf6AWeH4
         JJ1Q==
X-Gm-Message-State: APzg51DuApQCBqdji2Lg4aEbB/soDI/62DIISNmv75XpHZv/omcMXOki
        bFUcVV0QQWtdOkin75Dg3NZrHY4BZlfGXSoqwVgDLA==
X-Google-Smtp-Source: ANB0VdY2RGG+wEONcGehZLuaHPzHDGohFL+3Y9vNlOkWnOl5haLvqc/EbaGEqn5v9f+kkBL60SHWNkNQJ1CDf5WIxZQ=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr1841916jab.113.1536238874472;
 Thu, 06 Sep 2018 06:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180905090555.9888-1-geert+renesas@glider.be>
In-Reply-To: <20180905090555.9888-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Sep 2018 15:01:02 +0200
Message-ID: <CACRpkdZMD-GJUtcSiP30Rb-XAR6OHXZvdmEgOY-CxgauDGvViQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: Fix VLA removal fallout
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for the patches!

On Wed, Sep 5, 2018 at 11:23 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> This patch series fixes various (mostly harmless) issues introduced by
> commit 3027743f83f867d8 ("gpio: Remove VLA from gpiolib").
>
> As per the "one patch should fix one issue"-policy, this series contains 3
> patches, although they all have the same Fixes: tag.
>
> W.r.t. propagating errors: while gpiod_set_array_value_complex() and its
> callers can now return an error code, this is currently limited to -ENOMEM.
> Actual failures setting a GPIO output value cannot be propagated, as
> gpio_chip.set() still returns void.  Do you want to change that?
> E.g. gen_74x164_set_value() can fail.
>
> Feel free to fold patches if deemed appropriate.

What I want to know is if these patches drive a truck through Janusz patch
set augmenting the array functions that I definately also plan to merge for
this kernel cycle.

Issues should be fixed of course, but if some of them already disappear
if I apply Janusz patches, I'd rather postpone ... is it going to be hard
to redo the cleanups on top of his patches?

Yours,
Linus Walleij
