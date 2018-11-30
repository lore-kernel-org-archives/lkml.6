Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4993120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeVdY0ON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4993120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeK3UQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:16:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45086 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeK3UQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:16:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so4301445ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msbW71zcVZTDE/vM/KZLZouftnFVpG/GA8aRhA0bQCQ=;
        b=AeVdY0ONPdd72X3kE/xTImQJC/hRXjlVmYJWPlsNPPAn3jjKC2ONEt2O5BGdJYlAm4
         zvDJBAQGWa2mSrKgUThj9vucB0VCZSj/90F/gObaMPSc19JFAsuW0PkRQymoOnt9OYWW
         HAgM40KYLMP7nJUgP44rtWxkPP9aGqdS7m844=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msbW71zcVZTDE/vM/KZLZouftnFVpG/GA8aRhA0bQCQ=;
        b=ATMfFWCYmlcVNI8CPvdzenFocFFg3oMz4yKN54QGNkPU80qQPiR6kiUaw9xpiUDUaN
         uvp+7aNrGNp1ymCbR4xVcez5s2QnNsNNxtoP6ExFg3+GWmMVyXMs/4aKYhhNa+BZj4u4
         J1pQ1+5Hu0VO54GFc4zb15naU6QULrgQqJK4/1szeR7rYGIcfVTZ5RgN0sj+7BHdxvg8
         r8USLD+NuOf3UQ3D4iYLCZ6vlnqeQ0oq/rQ6nioxt7j2Gdl240mIi2w8vaRbws3E4P4u
         Pym3wb8vWXxGmUA9VTEtR9PQNAS9hJqXyC5lnzuIfg2samr9GpwDvSNDatynFaZIE96K
         rScA==
X-Gm-Message-State: AA+aEWZCmm33JHHlt5LalS9WuMTJ5QqfEIFwIeGHARmIeD3Esq97ho88
        WjAJt1ybOrYnJmESIy2cndXLAo7fE1MMlpE2Qptwrg==
X-Google-Smtp-Source: AFSGD/UvOaZYbIGaXjsfEcxhenBx62xtTXjfO63UXiBmvOCPOnKGEN8KNz+uflyAHFnTOSDTNKXCJwQPfhsc9VGQeBA=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr3321674ljc.66.1543568874635;
 Fri, 30 Nov 2018 01:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <20181128104350.31902-9-linus.walleij@linaro.org> <20181128152423.GW16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181128152423.GW16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Nov 2018 10:07:42 +0100
Message-ID: <CACRpkdaA2B_dwCr=RRNkMpWWY5cTKhvBH6nEfgGg_eunXY-87w@mail.gmail.com>
Subject: Re: [PATCH 08/10] regulator: max77686: Let core handle GPIO descriptor
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:24 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Nov 28, 2018 at 11:43:48AM +0100, Linus Walleij wrote:

> > @@ -255,8 +255,7 @@ static int max77686_of_parse_cb(struct device_node *np,
(...)
> > +             config->ena_gpiod = gpiod_get_from_of_node(np,
>
> As this is inside the of_parse_cb, it probably needs some thought
> on where the GPIO would need to be freed on which error paths, I
> am not sure it is immediately obvious to me but I suspect it will
> need to be freed in some cases.

I looked it over and came up with a patch making sure that if
the regulator_of_get_init_data() assigns config->ena_gpiod
it gets freed unless handled over to the regulator core.

Thanks for pointing this out, it was a tricky corner case!

Yours,
Linus Walleij
