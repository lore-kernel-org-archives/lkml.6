Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1464C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797FE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3ft6dmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797FE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeIZOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:02:08 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35178 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIZOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:02:07 -0400
Received: by mail-it1-f194.google.com with SMTP id 139-v6so1645132itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFu77F5sNY9c5BHkp7PR18fKHjrrsUk9CHFMf64NtTE=;
        b=F3ft6dmCUhNoc/C6ZbjNe+Hwi1orjhu6z/3reg2h+EKDH8Im3tlOSN1kyVZgyMQPyJ
         WKPNTCa99l9KSdqo4oE92t9YrGpWsUvjeazeyexcQG31lO6go4VvgjVt1Oi1cY8cgQrC
         TSt/+4WZ3bi4uvYNCGB3//U0XpwL2/gXjxr0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFu77F5sNY9c5BHkp7PR18fKHjrrsUk9CHFMf64NtTE=;
        b=onnQjs0iqieh6ojnq4ZWsCCFz5KVGk0uA8EbFUuyhjC9QevGlK084NqEKQYmmiG3lc
         LUYnJ6TykCju/TlGvW62kB+lULq9xKkQMM+eLEBir9ghb1mOZ6P5Dp/anG/zpLW0ex6C
         csnJdYAh8j6CjDn49jjNPEz3U576HQMaADa0xIOlZA4ELz/bHLUCetJK+LncnOjHlNZg
         pyUBaLz4eNEvb4jH18p3ck9Fp8/2fQc7es2kumdC9YcwclK+fC2aD8XT5IATo7rxgfYD
         KXQUqdT+3DVooG+jQ7Q2GBWABKs2TGvMO2L5CuyAU9VqsGo6YBQEZNnD12nPlMSDPTuu
         Ua7g==
X-Gm-Message-State: ABuFfog9wH5wZ5/s1llSVSUn6FNLjVWWBfeZdH9yHqqmnOtsW+pTaSwS
        L0wTHCRXMMftwjhs5AxiuduRfZ/QYJ93yneigamCyg==
X-Google-Smtp-Source: ACcGV62fTwt+sOmpURFXO6HaozeXOi8sBr6SYdr4c3GHau72vZ2FZOQWwDw5QbnjH4woV5hEjgo6D1WGRn1kf92aXdc=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr4294407jab.113.1537948229627;
 Wed, 26 Sep 2018 00:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
 <20180925192433.1377-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180925192433.1377-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:50:18 +0200
Message-ID: <CACRpkdaXE7Me8Q0Rrcooo_v_2oBJN1RSGUNHYudtTGQY7x8kqg@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 9:23 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The updated code of
> mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, boot hanging caused by incorrectly handled MMC device
> has been observed.
>
> As a side effect of that incorrect interpreation of the 'value'
> argument, wrong assumption is taken about the 'values' bitmap size
> never exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Nice!

Provided this works, Ulf can I have your ACK so I can queue this
with the rest of the gpio array rework in the GPIO tree?

Yours,
Linus Walleij
