Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47614208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ITf7XLPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47614208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeHXA2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:28:07 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46637 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:28:06 -0400
Received: by mail-yb0-f196.google.com with SMTP id y20-v6so2646422ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HLBdnVGydHPPI9HlCXs/zCai70hz41phfgPqLAwxlJ8=;
        b=ITf7XLPpVWlOMz1KTRrwAj4bMjco4uvJBDgEsRpfYFx3oDEkBA8ELlX3yjHxqZHTF2
         Pi6ZuLt5q10hFp8MzwijxouAznQoOQ3MkitnceKpUx1NrUkNnBB3XLIuZtHyRKTMsTGj
         BoGltCxLmB7BWA2hBIFv45NXC1+7yvngHoadE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HLBdnVGydHPPI9HlCXs/zCai70hz41phfgPqLAwxlJ8=;
        b=OY96W5aql4Y5gVwKO9rScOUN+QvIQrqOQhr6ePIKHwLsk2FA9EQAEoeBYtFt5+7cp9
         MUz5mFaPZ6Hmiy/vWsu7xbVEoVNf0Xx98IKhIozZ3rPtZNW6hn5MKBKub+Tib8IabYgL
         6dRXyBq6TegQbCEWSSNUVpX31ydIprxMq/mD8xJ71OJ0B5JIXmkK6vS3vjgKlhu7J7Jf
         iNtf66wG4Q1E3ZDcn9dIm6VAzo7SCfd25aJnXR5MCw4Ve+lmZdUQWbhOdgvptnWS3Udo
         hflZ/ngjkZTXrud47j8jGUDCnqiHdichW2E9YsBzo6x6R1jPnCE0V6UzFw3Pury3f39e
         0QGQ==
X-Gm-Message-State: APzg51AFv3mRB+DAuR22gq2gBC94h389iwcGpailsJYNjcZed3BxG0ap
        5dZptH6PS/0jMgy2vT4JZCr0oGCkK1Y=
X-Google-Smtp-Source: ANB0VdbLjtgximlX5sFviMG/cvkVbha3tOIxXpv57F7QxSircHrUwPjfQe0DbMomJfNoT73kcjNZLg==
X-Received: by 2002:a25:6403:: with SMTP id y3-v6mr5136598ybb.323.1535057799412;
        Thu, 23 Aug 2018 13:56:39 -0700 (PDT)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com. [209.85.213.175])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2426684ywf.96.2018.08.23.13.56.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:56:38 -0700 (PDT)
Received: by mail-yb0-f175.google.com with SMTP id v13-v6so2652563ybq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:56:37 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr33242137ybh.209.1535057797080;
 Thu, 23 Aug 2018 13:56:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 13:56:35
 -0700 (PDT)
In-Reply-To: <20180823185140.GA29028@embeddedor.com>
References: <20180823185140.GA29028@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 13:56:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
Message-ID: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
Subject: Re: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:51 AM, Gustavo A. R. Silva
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
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 2cd5a7b..fe07310 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -199,8 +199,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>         if (!rtc)
>                 return;
>
> -       clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
> -                          GFP_KERNEL);
> +       clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
>         if (!clk_data) {
>                 kfree(rtc);
>                 return;

This looks like entirely correct to me, but I'm surprised the
Coccinelle script didn't discover this. I guess the isomorphisms don't
cover the parenthesis?

-Kees

-- 
Kees Cook
Pixel Security
