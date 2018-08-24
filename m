Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627BFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2662156E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l832ODyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2662156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHXG2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:28:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38918 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeHXG2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:28:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id m62-v6so1099894ywd.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b+kOzfNZgDnsRy5kV8VjGJX8JzTlgg2TDF4wOMZtUEU=;
        b=l832ODycSc9/oTWlKCHl6XsVfGwDZcTZ08aB1SNZjVdWlGXKIou9ag5dFNc3HTHfxn
         YpHxIC0I0ccjiX/hQ8UEopBYSEa8PvECNoDpTWMW/e8d5OXv9Hl/QR0amy7HXisQJXpF
         BSiyVTnsYM/zj1d+5oqKw9W0PIp4Sf2q1OGws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b+kOzfNZgDnsRy5kV8VjGJX8JzTlgg2TDF4wOMZtUEU=;
        b=Bj2FSTSJ0QnOCm+iQgr0WmIXOPD9JrfBjLKxfGhKwwLr8j8Ha2cMcJiY/IctruG0pK
         N7noJm3NVbfN+8gHgUoSsWR1ZkhDKJan+153F/V+cyriZg0fCRXkZWHZpEkQAUcAGYG+
         YjU79Tbspzd8bji3DoBvcBYLA+evREGOHNgnwO687ohIfwz1OAZYbnoQkac8DPKsnO1g
         EPkICpgH3W7mM1TP8k6bONhAhbZ9qtivXDgUmPPPjAkNJtWCmQF29frEQUjOTVnubzNm
         AZ6kMbpFQG92y3Sn34DgBnRqTWFgEWwyUJxsuYm3JoskwogTF8W5SWr3o55AY/4gwcEe
         5yrw==
X-Gm-Message-State: APzg51A4suhuY60QhMM74HwdDxI29rUzHkJmTBLIqzVI0+3ObquPg6VK
        kWDzxmV72d37CG1+VVQ4qNFtWPGSDxQ=
X-Google-Smtp-Source: ANB0VdZ8Hm0z76L7yAOfIxM6GJpORkqdeHlt9Ap7/W33c6kD3E9qlayfKz6ITaRM1nhqNwfnT7A94Q==
X-Received: by 2002:a0d:fac3:: with SMTP id k186-v6mr4438757ywf.456.1535079374969;
        Thu, 23 Aug 2018 19:56:14 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id v18-v6sm2652138ywv.9.2018.08.23.19.56.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 19:56:13 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id x67-v6so2606952ywg.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:56:13 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr4605731ywe.124.1535079373252;
 Thu, 23 Aug 2018 19:56:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 19:56:12
 -0700 (PDT)
In-Reply-To: <20180824010521.GA25451@embeddedor.com>
References: <20180824010521.GA25451@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 19:56:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
Message-ID: <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: tcon-top: Use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:05 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> index 55fe398..3040a79 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -129,8 +129,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>         if (!tcon_top)
>                 return -ENOMEM;
>
> -       clk_data = devm_kzalloc(dev, sizeof(*clk_data) +
> -                               sizeof(*clk_data->hws) * CLK_NUM,
> +       clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, CLK_NUM),
>                                 GFP_KERNEL);
>         if (!clk_data)
>                 return -ENOMEM;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
