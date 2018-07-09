Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689C2208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILk4b8Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689C2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGITwx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:52:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42598 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGITwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:52:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so16231305lff.9;
        Mon, 09 Jul 2018 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fnQDiQqcCleINu9d7do1+bF/vxO5p/r/VlnqtCtiW1A=;
        b=ILk4b8Hq9EbJZlPvDidC8gQPnwc0a5ZCVBHc0NLjGlqyM/g18DuT0jFGlQ7fI87XEM
         OWqMGmLdWHEaWrn5JQYypUjJUHZz5pZb0sJyetaPQStsAYjRIi5A/KesdMur6QKfvBM7
         25/UuiKhkqipWAgwMbrN+Kxq7y/h9g5HzcXiNt3stS58rOfUxXAuK59wg0XUYBE1tB39
         GtPj43v+eOir3BNVhGsM3G27tucfyKkjPhWmHbsfL1fZLr+UBnYau/tEQvPjYtFoq10+
         jP/0i86msWBTZX+MUpao27SngQosra2VQFhivJ3pq/aZ5Lg1dYNJQsXYCZxz6ZKNnQ3D
         rTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fnQDiQqcCleINu9d7do1+bF/vxO5p/r/VlnqtCtiW1A=;
        b=E0/CyAwh96NOOjQ5ARI+M+y8+rH/IUQpsrwRBupuiByrP1dSX6CRQGxCAimvyMZglJ
         ipVRHE1k+9ObRRDcFYGWNmbBbylpsmdj7KgcQcKINuYtle+cj0PN0Wf8u4GLL94vF4Vt
         WKa721iKtwePEcoYa2SMoiQha4qZmIrKSra08tapstPuM3BlesgXOUq7y8QhpGeMJZlm
         LCnuQFQNTSTJXzkWl92YaQkSwreevK7z+VpppRJTZqxGJLCjjVXUeNUSBDg0Mwf+kU2E
         YtdxAhPhzHEuwWjtfxGyvaxakwyx2hQ0BiAVk/hi7PrP6kgAM8Mujv8f9jaaBzwjjHQK
         2b1w==
X-Gm-Message-State: APt69E1Z8mKOFcoMQQECkE3PhiOeik5u93yOZD+db6ejo1yvDucwZugx
        UEV+Vj/dsuFVEG5hnDDYPcGKhutV+tdAzRPItso=
X-Google-Smtp-Source: AAOMgpf45kZ5WSZN+2MF9NBO8zaqfGjnuhneX2F6qaWZfyDCt7WSOhgh32Fw8hWqUM3Wv6177rR25PgonPrvQO3hFxQ=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr590649lfk.132.1531165970051;
 Mon, 09 Jul 2018 12:52:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 12:52:48 -0700 (PDT)
In-Reply-To: <3652696.6JvIze6Ubc@ws-140106>
References: <20180709145612.4166409-1-arnd@arndb.de> <3652696.6JvIze6Ubc@ws-140106>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Jul 2018 21:52:48 +0200
X-Google-Sender-Auth: X7UvY_mr18sLVLYPwSkCaOiPyAQ
Message-ID: <CAK8P3a1cHSkG33c0N+8sYSC2WSGTVLWvCJmitjTnxOQQzrd4jw@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: fix compile testing warning
To:     Alexander Stein <alexander.stein@systec-electronic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:31 PM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> On Monday, July 9, 2018, 4:56:03 PM CEST Arnd Bergmann wrote:
>> Gcc cannot always see that BUG_ON(1) is guaranteed to not
>> return, so we get a warning message in some configurations:
>>
>> drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
>> drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void
>> function [-Werror=return-type]
>>
>> Using a plain BUG() is easier here and avoids the problem.
>>
>> Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpio/gpio-aspeed.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
>> index 1e00f4045f9d..2342e154029b 100644
>> --- a/drivers/gpio/gpio-aspeed.c
>> +++ b/drivers/gpio/gpio-aspeed.c
>> @@ -240,7 +240,7 @@ static inline void __iomem *bank_reg(struct aspeed_gpio
>> *gpio, case reg_cmdsrc1:
>>               return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
>>       }
>> -     BUG_ON(1);
>> +     BUG();
>>  }
>>
>>  #define GPIO_BANK(x) ((x) >> 5)
>
> Is the semantic of BUG() (and BUG_ON as well) to never return?

On most architectures and configurations yes, but not on some of
the minor architectures if CONFIG_BUG is disabled.

> If so, then
> just an idea: Is it possible to add some macro magic in BUG_ON(x) to fail
> compiling if x is compile-constant? Giving a hint the passed condition always
> fails, which indicates a problem, at least to me.

Not sure, that might not work well in cases where it's a compile-time
constant in some configurations but variable in others.

> From a short search I found this in drivers/gpu/vga/vgaarb.c L630-633:
>>       if (vgadev_find(pdev) != NULL) {
>>               BUG_ON(1);
>>               goto fail;
>>       }
> You can't fail with a BUG_ON(1) and try to do some error handling after that.

Right.

Traditionally when CONFIG_BUG was disabled, we would have continued
here, so that could have been intentional, but in any case a WARN_ON()
would have been more appropriate here.

      Arnd
