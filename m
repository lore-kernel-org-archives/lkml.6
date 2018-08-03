Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32784C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB892177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqYNup+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB892177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeHCT0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:26:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50928 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeHCT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:26:38 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so7559227ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOKJgVih0koMFH6oX0QAv0yRK8fzk+A+EknAHULkhhA=;
        b=bqYNup+zXZy6YMshij4Es6VXPhAbZEasTN4ff54aAi0hSmmtj0JlY6L9UUSELrWYFD
         42s4N46P4MjY8QO6d/98ziUFXv3TB8lbLyoxyo2U9hLN6Xmv4ixJ0L9cM4go0AdRahAF
         ovtVreagiiKZDSBILKdOSysAetLAcLe7PTWT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOKJgVih0koMFH6oX0QAv0yRK8fzk+A+EknAHULkhhA=;
        b=jLkThCUa7rGdi7B4b807+eyyt/ofG+ghZ9fMAv544YBH0ADk+WKtYFXdbtH3/qaS3E
         amWXMD20WrXspdMbGRmSDPLMtQ2I0+la+zX8AuIoMaIXp2ZfdJEZBDLOnJOPqxVzHdIa
         ZUcbr5zeDsg9Q9DMiosojRWH4aMoknC16i4gaIXU4AJegdtxv519DTcZH4uqDcq2r4qV
         mPpCa7jvUOZZHUbbRGr7aFAyFAN6FcEG3sdcb3wIc4rzZVj/7oXKxFt9pyFHumFQ3u+l
         5y0hl4s38v1sGBxYzwXGNPyUJFWkNlqMzSDg2rsWh6QQJ7/IN6gcmRjmXPcj65x/H2yK
         Zelw==
X-Gm-Message-State: AOUpUlHRbePUKrds2pRz49F6gdHr/tC48SBlLL96bSfLvdSFc36hEvpU
        cSPTbUj9TFj/iVfX3QAvuf0dBiFaiUU41gqU14Dl4A==
X-Google-Smtp-Source: AAOMgpeKS5xQ3sscrombG5zsjmghlmiizLMj4s+ugvipkn6nffdBLQVgBKoM1AMLIrAtgtM4JO6Puwr4HJJAMEp769M=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr7025038itb.38.1533317363364;
 Fri, 03 Aug 2018 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180801051049.21360-1-yuehaibing@huawei.com>
In-Reply-To: <20180801051049.21360-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 19:29:11 +0200
Message-ID: <CACRpkdZeCfOvwQ5qsHwzTD-wAyhqXMjfGbp6CGBtXdq4UifCwg@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: berlin: fix 'pctrl->functions' allocation in berlin_pinctrl_build_state
To:     yuehaibing@huawei.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 7:11 AM YueHaibing <yuehaibing@huawei.com> wrote:

> fixes following Smatch static check warning:
>
>  drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
>
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
>
> Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: free pctrl->functions instead of function as Jisheng Zhang suggested
> v3: v2 I send a wrong patch,this is the correct patch.

Patch applied with Jisheng's ACK!

Yours,
Linus Walleij
