Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E77BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DA2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fVkaaosS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18DA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHXGhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:37:46 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41743 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeHXGhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:37:46 -0400
Received: by mail-yb0-f194.google.com with SMTP id z3-v6so2993207ybm.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L3lSm62PN8ogq6nCwcD7++HmLjCC7RmFbfrW/cenEOg=;
        b=fVkaaosS78Zw6uhAeHy3xYLLa0j/JVIYEwRoc1KGQwfnm+awUfao2KQC8mS2s6C9fm
         I4U2152H65YCe/X4vDMhDVbHKpqFl5p8R3j5M07lRd/ZtM81UZ1VlgRJGPZqE5si67wS
         6pA3o3PJiH1MPqKuzPwDvFybUdXIMJxb+EMqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L3lSm62PN8ogq6nCwcD7++HmLjCC7RmFbfrW/cenEOg=;
        b=hUVsxcAeZ7mHIJwqYiabyzu58tHewUDyHzQ/HZh+b/FnnZgqrsxFnhWDbFpqUmIaSH
         ihG0ZJ4r+s3u3e81X+/5s8gJs0QEnkqMo4fsbaXpVOhkEGRVY7zvvT0Vgb1gdNoJBzQK
         C/4UziEPmvzQMgIjZAuZ0dtkRBS6CLMizOr02FwSxrIPp3SSq9QmZbonQEdPdZUdwIv3
         SM1jTunPkRKbGoW+5V/9A+CDfkylXbWNpx8vmkT25TcX9HvL41w3ofPm70PsSalrxH1T
         QflyDlXRO7VB3gZQ3uGG5SjoQaMqM8bxqoe+t+fH2jAe2P5zGk0ZNTRG1JESCHQMSlWZ
         NtmA==
X-Gm-Message-State: AOUpUlF2UTgLIBhavwK2OlDa0vgA2dvPCBiDhpbuDQ7Y+0bifaflr2/K
        F702HZoK4IWKvEaSZyMRB+sK9DmMTcw=
X-Google-Smtp-Source: AA+uWPxOOIdLpx7zSv+itTQMuNfCl2OGXq3ldjy8zMtpZEY6qEcp62YbYAqn09Q62hygiqoWWpnuxA==
X-Received: by 2002:a25:a469:: with SMTP id f96-v6mr11534171ybi.241.1535079909387;
        Thu, 23 Aug 2018 20:05:09 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id s63-v6sm2512204ywd.63.2018.08.23.20.05.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 20:05:08 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id 14-v6so2614575ywe.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 20:05:07 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr4629756ywg.288.1535079907483;
 Thu, 23 Aug 2018 20:05:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 20:05:06
 -0700 (PDT)
In-Reply-To: <20180824011753.GA25826@embeddedor.com>
References: <20180824011753.GA25826@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 20:05:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJP4UbFbfRmLiDLT5Bq3CzBum7tRdXMXY3nPDQQ+bZZmQ@mail.gmail.com>
Message-ID: <CAGXu5jJP4UbFbfRmLiDLT5Bq3CzBum7tRdXMXY3nPDQQ+bZZmQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:17 PM, Gustavo A. R. Silva
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
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_ATOMIC);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_ATOMIC);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/soc/qcom/rpmh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index c7beb68..12c057a 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -362,8 +362,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>         if (!count)
>                 return -EINVAL;
>
> -       req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
> -                     GFP_ATOMIC);
> +       req = kzalloc(struct_size(req, rpm_msgs, count), GFP_ATOMIC);
>         if (!req)
>                 return -ENOMEM;
>         req->count = count;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
