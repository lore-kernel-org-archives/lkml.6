Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A52F20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A52F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405308AbeKVVYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:24:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42321 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeKVVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:24:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so6546875qka.9;
        Thu, 22 Nov 2018 02:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QP/5rIjIUoTDwMcGxTxpsYKhIa6trejZU2xbE2RO75M=;
        b=oI8DjROYJI/pZtYrpgKKoeW1mPxfYpSsn0b83vBdAQcJkrp/OSmAqNXMagz4HeIU9p
         HGh4bxa4H3U1swiQY9k3evJy0h7FRIM/nPez34GdB0JB8rp9OszSiTw0HE2Mr2B5pNm0
         B0pIH35xxAl2EzBs8+bDEHlFe5lLMhcpmmY7Df5z55cryq7tJRlbZNUA+JqVR50/p+ae
         1TClpHaxGfn0MQ5CZ79h/nk/jA2kkH4hz/B4TCwNHr0RShtxl9dTL478JJfIzP5N980K
         7ogZwaloPDk75WyW6U7+lDEF8IAYffIv0hBcXyVB7k8AfX+w7JI+B9O/daU4FJWCZoKi
         wrVg==
X-Gm-Message-State: AA+aEWbTOQvBkCCiBsKQh6LKc3t61qH+QSrjzllOPjYJNJ3zhSvpPUtH
        hOwLeG/6PVVoq83ZnZOUDdQkKY5tNSoFzgzrrkY=
X-Google-Smtp-Source: AFSGD/VM07BPPCgteGc3pMBzIEV7/W2+pbd+jhvIY7sRr1eijNYr0s+1yhl0jeeloT3E8AF3VLhDkEoaIplwDQ6Wp8Y=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr8642766qkf.107.1542883550390;
 Thu, 22 Nov 2018 02:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20181121141204.22819-1-tiny.windzz@gmail.com>
In-Reply-To: <20181121141204.22819-1-tiny.windzz@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 22 Nov 2018 11:45:34 +0100
Message-ID: <CAK8P3a0zwWTyLuihBMaggGkRHeYwo4UrxZrx1qBE=t=A4tKVEw@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
To:     tiny.windzz@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 3:40 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller.soc_is_tegra()
> doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
> soc_is_tegra() whcih automatically manages the reference count.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index cd8f41351add..0b40700b672a 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_match[] = {
>
>  bool soc_is_tegra(void)
>  {
> -       struct device_node *root;
> +       struct of_device_id *match = tegra_machine_match;
>
> -       root = of_find_node_by_path("/");
> -       if (!root)
> -               return false;
> +       while(match->compatible){
> +               if(of_machine_is_compatible(match->compatible))
> +                       return true;
> +               match++;
> +       }
>
> -       return of_match_node(tegra_machine_match, root) != NULL;
> +       return false;
>  }
> --
> 2.17.0
>
