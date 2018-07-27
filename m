Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99FA20873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0A2+Rf+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99FA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeG0J1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:27:03 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:45215 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeG0J1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:27:02 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6R860sG020449;
        Fri, 27 Jul 2018 17:06:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6R860sG020449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532678761;
        bh=AUoyiWxl0id1Kdy4msbi81EoBVpASvu3svy+TrC5FnE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0A2+Rf+6MvQE66SdHOjG0cHHZCApDrB9Hy2g7dS86Pr75W3E2cOhO2vrUpqCL9lQm
         zvJV34ciaodzoJ0Yk0wN4UpdchaB1nJgopsblYwmxxEeXU+Q7CcpvoXYLwGT/GcnqL
         K0opoYdzTQkVDvhplbP5YvbFKim6xGLkH83vv+48+CLcT0wzRU54Upr52jF2Jgo3yf
         X0fZn7ZnQIaD2LNjoFESmJJC15yUcivW0aLyTk9l9kb/ErSaXpyzryv1avhPCHzWFZ
         fdp6aksNLyVtXYO76IgRcONnAC1htgTZr+JWJ3SL7rg6vxYS/rDFayrcF7z15DiU41
         dd5f4e6eksjlA==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id k25-v6so2804193uao.11;
        Fri, 27 Jul 2018 01:06:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlHs9xpWkaEPT9hS1jR1oEziCX0VnhSrsegqvSlG2zdt38/s+93e
        9RZwEJoXEQhgqds5Vmp+e0BWKNLzIR+TZyv+WzE=
X-Google-Smtp-Source: AAOMgpcXcTLxFHz5xLKj3VCR6L5awPzvXwk5JPVORlrt8uH8mHSY2MEg0Jbk69kKX4Q72EVhywubK4dcLl84xYdziJs=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr3681181uaf.199.1532678759686;
 Fri, 27 Jul 2018 01:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 01:05:19
 -0700 (PDT)
In-Reply-To: <CAMuHMdXvbWrt44T4Sr_bDjS1YFfqZ82JHpH7f00FKYBHntyWSg@mail.gmail.com>
References: <1532654046-11901-1-git-send-email-yamada.masahiro@socionext.com> <CAMuHMdXvbWrt44T4Sr_bDjS1YFfqZ82JHpH7f00FKYBHntyWSg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 27 Jul 2018 17:05:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVuNHXvyyf2_=4-QpxYosnRPCSOyicAs7WYtHfRLfkQw@mail.gmail.com>
Message-ID: <CAK7LNASVuNHXvyyf2_=4-QpxYosnRPCSOyicAs7WYtHfRLfkQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: allow DMA request hook to return error status
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

2018-07-27 16:51 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Fri, Jul 27, 2018 at 3:15 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> dma_request_chan() may return ERR_PTR(-EPROBE_DEFER), but
>> tmio_mmc_request_dma() cannot propagate it since it is a
>> void function.
>>
>> Change the return type to int so that the driver can retry
>> probing later in case the DMA-engine driver is probed after
>> the TMIO MMC driver.
>>
>> I moved the call for tmio_mmc_request_dma() up because it may
>> fail now.  I also removed unneeded clearing of host->chan_{tx,rx}
>> because (struct tmio_mmc_host) is allocated by kzalloc().
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thanks for your patch!
>
> Isn't the idea to fall back to PIO if the DMA-engine driver is not found?
>
> Unfortunately there's no way to distinguish between "DMA-engine hasn't been
> probed yet" and "DMA-engine is not available" (e.g. CONFIG_RCAR_DMAC=n).
> In both cases, dma_request_chan() will return -EPROBE_DEFER.
> So if you treat this as an actual error, and propagate it, the following
> will happen:
>   - In case 1, the MMC driver will be reprobed successfully later.
>   - In case 2,the MMC driver will never succeed.
>
> Or am I missing something?


You are right.

drivers/Makefile lists 'dma/' before 'mmc/',
so this is not a real problem.

I will let my driver fallback to PIO for any error.

Thanks.




> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
