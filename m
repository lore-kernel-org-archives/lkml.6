Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936085AbeEYKNE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:13:04 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44936 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936026AbeEYKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:13:02 -0400
X-Google-Smtp-Source: ADUXVKJsnRPgEgBhVu+L49RriIwJNZt3xVW4zXzKuJkZwSQNZBE2Mv/8xHfkby4Wr1CJTMdCOV87Dg==
MIME-Version: 1.0
X-Originating-IP: [193.151.80.5]
In-Reply-To: <20180524120733.GA24269@jamesdev>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
 <20180521163932.GA12779@jamesdev> <20180524120733.GA24269@jamesdev>
From: Mathias Kresin <dev@kresin.me>
Date: Fri, 25 May 2018 13:12:39 +0300
X-Gmail-Original-Message-ID: <CABwW5nkcBT3FmUy6A_t3E5VU3Z78eut3anPe06=yYbLeMrtg3A@mail.gmail.com>
Message-ID: <CABwW5nkcBT3FmUy6A_t3E5VU3Z78eut3anPe06=yYbLeMrtg3A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
To: James Hogan <jhogan@kernel.org>
Cc: John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        hauke@hauke-m.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PAD9EL011046

2018-05-24 15:07 GMT+03:00 James Hogan <jhogan@kernel.org>:
> On Mon, May 21, 2018 at 05:39:32PM +0100, James Hogan wrote:
>> On Sun, Apr 08, 2018 at 10:30:03AM +0200, Mathias Kresin wrote:
>> > While doing a global software reset, these bits are not cleared and let
>> > some bootloader fail to initialise the GPHYs. The bootloader don't
>> > expect the GPHYs in reset, as they aren't during power on.
>> >
>> > The asserts were a workaround for a wrong syscon-reboot mask. With a
>> > mask set which includes the GPHY resets, these resets aren't required
>> > any more.
>> >
>> > Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
>> > Cc: stable@vger.kernel.org # 4.14+
>> > Signed-off-by: Mathias Kresin <dev@kresin.me>
>>
>> Applied for 4.17. Thanks for the acks/reviews folk!
>
> drivers/soc/lantiq/gphy.c: In function ‘xway_gphy_remove’:
> drivers/soc/lantiq/gphy.c:198:6: warning: unused variable ‘ret’ [-Wunused-variable]
>   int ret;
>       ^~~
> drivers/soc/lantiq/gphy.c:196:17: warning: unused variable ‘dev’ [-Wunused-variable]
>   struct device *dev = &pdev->dev;
>                  ^~~
>
> Easily fixed, I can drop those two lines:
>
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> index 8c31ae750987..feeb17cebc25 100644
> --- a/drivers/soc/lantiq/gphy.c
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -193,9 +193,7 @@ static int xway_gphy_probe(struct platform_device *pdev)
>
>  static int xway_gphy_remove(struct platform_device *pdev)
>  {
> -       struct device *dev = &pdev->dev;
>         struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
> -       int ret;
>
>         iowrite32be(0, priv->membase);
>
> However it does raise the question, it sounds like a fix, but was this
> patch tested and the warning just overlooked?

Yes the patch is tested. It is committed to OpenWrt on top of 4.14
since a while.

It is as simple as I didn't noticed the warnings.

Thanks a lot for fixing the warnings
Mathias
