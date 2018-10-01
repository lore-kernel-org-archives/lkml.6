Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612C32089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdxsoKZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612C32089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJARBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:01:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36395 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbeJARBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:01:37 -0400
Received: by mail-io1-f66.google.com with SMTP id p4-v6so3131573iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THM6kc82mMstt4+zJoSfqZigSugW3/mfNxEP+tVrN74=;
        b=KdxsoKZqk8t+2eIMUQP9++XuiiWF6j5GYR/NaLmlWgDxUl5uOVHI7q+JGfSJirX9tN
         FqMNrp1SL6XLvHN0mBjQXJPrddiFZUV+rSYqYQUEQToatQzTYtae0jluNEN/Dpc35n2N
         pL0x6a3xwD/BtoEw/lY+t765VcnlZZu2M8bRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THM6kc82mMstt4+zJoSfqZigSugW3/mfNxEP+tVrN74=;
        b=cpikPr/xbppsNHZddS2wwsnvU8JLsyLHUfd1IImY1e6rX25FJjqkPhCMM0VPrx5tVN
         51A6lGb1tLEG3vSP4r5KyXyRclW9yUYUsQk6OnkDHKrFIS1wyudDJt0e0r7SRO0IJZl9
         NC6tZaL86C8UeYHPv+VOx4H2XrRQPnbAaTrmqtXfMB9gA082zZOVG12rrwYUCFxTWhD4
         BZ4jdbWFFeNvxc9Wq85RXVphLtq/I2z+rqEgXPeZPB8fjVp0DltQx9lxEHU+YWSY7JdF
         nLZBvLbdv5qnFjCDeevEwYfhK99Y2fnQcwcUsq8SZXC+gwglpnpYUlN2fp259kHewWXr
         i0yQ==
X-Gm-Message-State: ABuFfoiKQpT5v9Sb2hVG8xvHiO50L3Dxg10EUZcKBpSUqygQO/seVWq4
        GXzv5DLPq3f8Ozed6YgC1rAtfKsPWvSBUX8ernmw6Q==
X-Google-Smtp-Source: ACcGV61L2gQrvU1Niq7Y35IOGz4oyPzHhoNiQZa1c1ji58cobp2MSbOPeWcudsA1SWkFF7f6qWFWdz1nDUX7Rk9pkeY=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr6326932iof.304.1538389471412;
 Mon, 01 Oct 2018 03:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180927113810.30721-1-geert+renesas@glider.be>
In-Reply-To: <20180927113810.30721-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 12:24:18 +0200
Message-ID: <CACRpkdYgX6aMACDdE6yMkur9txQq1hKCMfaLj_+FTg4vg-+Mzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpio: Fix VLA removal fallout
To:     Geert Uytterhoeven <geert+renesas@glider.be>
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

On Thu, Sep 27, 2018 at 1:38 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> This patch series fixes various (mostly harmless) issues introduced by
> commit 3027743f83f867d8 ("gpio: Remove VLA from gpiolib").
>
> As per the "one patch should fix one issue"-policy, this series contains 3
> patches, although they all have the same Fixes: tag.
>
> Changes compared to v1:
>   - Rebase on top of gpio array rework.

Patches applied, thanks Geert!

> W.r.t. propagating errors: while gpiod_set_array_value_complex() and its
> callers can now return an error code, this is currently limited to -ENOMEM.
> Actual failures setting a GPIO output value cannot be propagated, as
> gpio_chip.set() still returns void.  Do you want to change that?
> E.g. gen_74x164_set_value() can fail.

I think we discussed it at one point and said that it's something
we should fix some day, just nobody has got around to do it.

Yours,
Linus Walleij
