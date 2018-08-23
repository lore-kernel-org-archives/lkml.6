Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C858CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CE8208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdJo4I4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CE8208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeHXB2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:28:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38919 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeHXB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:28:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id m62-v6so880768ywd.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JLt6e8uIHCPQDr5itD+po6AEXwjf5aLrYfa32sgjtPU=;
        b=cdJo4I4VFditEmEwwkS93oQwdcpR/RdHqhHHcSM3M/dpkTIvtpuTIPDO6TW/N/66aR
         wJv0KHn1Fz/tR8B9WXpA0vILqCVt7AaV1q+gPhPpUR14zCq2kdL5fdqXrQqdaEtTJj+K
         SLxpmMEh5pcj6qx0GsdNDiYtUt0Jtebpx82bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JLt6e8uIHCPQDr5itD+po6AEXwjf5aLrYfa32sgjtPU=;
        b=pbaJRuSPFGeAh1Us3uPkIRk4poW7LvQjrDqlykty3+/uHvNqQXV0YJpABhYXMF8t2f
         k3NBBfPieVuLIS43YLnv+l7DqgrqqWsKQeq/a5YSKjasjTWSEOri73YIDGDek2SUqX67
         2VDGC4J2j6F6hlG+7Twxk9sA64NMrZMvl2tsiIQGqkCf29hOk5CRbmhxLG+DrziP8Wxs
         1FAk0WDVdXsyGpRIRMepX733Ut45YB1XnShNkenYyPWCQsMrJH6r81TwJWd13fJADezq
         B6Y4axUrudPKU4nFK3A2IJL68Ib7Hqi3nco6qFHVXWtSPZRpzOeDmMPc+U7+jiZA1J3K
         VXaw==
X-Gm-Message-State: APzg51AaNt+ZDR10Z8raK+fxRiZvIzDzH8wazhHWkjjhv+D1KBLSnnOs
        iWAyyqzInlvawqF+cLLzIxltD/f+KBo=
X-Google-Smtp-Source: ANB0VdaoiegqZe6zSu5jDg1nLDXNwS6Yc454+bYqBQpG115ZuhLEEleE9BjJrgYPclsmfJn5IzRtZQ==
X-Received: by 2002:a81:35d0:: with SMTP id c199-v6mr3930600ywa.182.1535061421083;
        Thu, 23 Aug 2018 14:57:01 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id h68-v6sm2370951ywc.7.2018.08.23.14.56.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 14:56:59 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id l189-v6so2371482ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:56:59 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr3906472ywg.353.1535061418527;
 Thu, 23 Aug 2018 14:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 14:56:57
 -0700 (PDT)
In-Reply-To: <20180823185140.GA29028@embeddedor.com>
References: <20180823185140.GA29028@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 14:56:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLOg-uB3wsyRNJd2rFEoT9_u2Q0YQXVWv38Z946S_t6xw@mail.gmail.com>
Message-ID: <CAGXu5jLOg-uB3wsyRNJd2rFEoT9_u2Q0YQXVWv38Z946S_t6xw@mail.gmail.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
