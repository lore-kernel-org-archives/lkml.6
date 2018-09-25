Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82672208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0ropiiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82672208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeIYRF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:05:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38914 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeIYRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:05:28 -0400
Received: by mail-io1-f66.google.com with SMTP id l7-v6so20092449iok.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UdrOdezDHdnjn5yjfwjym5ycJKKIRGbuYptJzT8a+k=;
        b=B0ropiiD4gZltvpXQY8Nf2v+AEDR1lf5l0cxvo0otJFFEuL8ORBQAZHkx94+VIJWtO
         ifBoyeWEQVYuiLGJcdhxM2kxYtkpCJnOD+YqhRjUCq/84kEdIp/T4FonU5UXwec0hI+5
         gOCuS4y4O6GLsXLk4/yfBxC8z3ITQ2t+VL1+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UdrOdezDHdnjn5yjfwjym5ycJKKIRGbuYptJzT8a+k=;
        b=Gpya6F3wgXcOvdQ3SzM5dhbsVVtFWQNBh5wSmheX7WLlEkisNAVV59/GzlGh3pUhRZ
         BaZN4nFYZkQ4q/3ECYD641fpOIOrXqsOS4DayB/GiS29i9QjVp36pJX+QO7wqnDtAArk
         zXSnv6rzb24/6eds1LpzGhw8d5foJdksG87RfC3tBmdE3cA9TvfRPmQKOdGOnO70SQXQ
         Lz0b6Hw+noS4ENTJIZ1FpqhKL7PGQ+RS6RCIi/svtwA+8/L3D5WQr0i6RBBwRdKj52fo
         7uygojqEvO8j/zPOgxPeNccdogivk9PdVZibUACSmTD/N4tlx5MDcrYPI+tACORll/xM
         3z6Q==
X-Gm-Message-State: ABuFfohv3Z2dbakmXY5VeL4Efl+ISslqI+rSALwrtRrtlVjtgjlAymm7
        4CWFBucTNW+wZYBmcfOR6xGUV092lLEJ6qb+FzkTbQ==
X-Google-Smtp-Source: ACcGV637E/+kK2+uUqmTNdXWt/Rs3/m5SVGi+oWXEjwUjJIBugPTZCJOtNQW2Fu6HZwqzPn/eBsHefTMRv5r7ojjPko=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr336867iof.304.1537873108378;
 Tue, 25 Sep 2018 03:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180925061855.19557-1-natechancellor@gmail.com>
In-Reply-To: <20180925061855.19557-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 12:58:16 +0200
Message-ID: <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
To:     natechancellor@gmail.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 8:19 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another,
> which happens several times in the pinctrl drivers for a few reasons:
>
> * The PCONFDUMP macro, which sets the param member in pin_config_item.
> * The pinconf_generic_params structure, which is used by drivers to
>   configure their bindings, which has a param member like pin_config_item.
> * The pinconf_to_config_packed, which takes either the generic enum
>   pin_config_param or a specialized one.
>
> Drivers are allowed to extend this enumerated type because of the gap
> betweem PIN_CONFIG_END and PIN_CONFIG_MAX. Make it clear to Clang that
> this is allowed by changing param's type in all of these instances to
> int so no conversion needs to happen.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/138
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I'm not superhappy about this because that enum is great for readability,
even if the static syntax checker is unhappy.

If we can't have an enum here I would argue that we can just as well
remove the enum altogether and just use #define for the config
parameters, would you agree?

Yours,
Linus Walleij
