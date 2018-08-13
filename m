Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733FAC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6F621709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y9yZs0eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6F621709
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeHNBUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:20:46 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42995 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNBUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:20:46 -0400
Received: by mail-yw1-f66.google.com with SMTP id y203-v6so14808834ywd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Y290NwS64F01JDqhNb4aoIc2B7O2pnfiChZ7MrbyII=;
        b=Y9yZs0egq6ZWk3xg4Lery7vfkTFsa+l2A4xjU+oNaZO+IMJoIRmjaG9YoT0aFm/VUY
         F3k9FMn2Gxk+7j1tW8Sl8/DnyVRqKROXNZD4YWtwgdEnoqAymOfGCQMK+z5WyHLV7ofg
         iAoC1mcYN56+NU4Sg1UJ/3nK1MMEty4K2TJXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Y290NwS64F01JDqhNb4aoIc2B7O2pnfiChZ7MrbyII=;
        b=t7otQnj5RSoIsSqi+VWiyUtDDQxbKX2shuhw47qsbAZgShCfztD4yYnje1zO7Nk8UR
         HZ+WTMrelHVDD114F5W5PDU0jbe+yhrXsYFkLn8rolqSfn9Rkk4uJbcrCOyBQthClg3E
         T6Cb2fRRwKHFAGqN/rhN2AHjrN9zmkmAr1PiyPfxvPOh56S5iYooj/2ow627rV58ldxg
         9fbf2nxc0SCogXnm/Fdf5UWJO7rVtnnVDSse4S2ArBKTHekPSLkJBGEbGW0zx+hOSWBZ
         XrHNXzSB6fr2JZai8JpN3/VIj1ne/uzEvyFoIjFzknbi5+tkI86ZQUJqaOlVXEpQ/W4J
         G3nA==
X-Gm-Message-State: AOUpUlFX7r31++uNXSnxl5ed+zGgRCIyA/1c6xpZfrZ7ykQ8eZGIfMiD
        kBpO+WRJxN8vBVYw3qVjcPTfC81UTcw=
X-Google-Smtp-Source: AA+uWPwBPEHq9w/XGO8rypO/XaPfRmYq+8ORqaDVy/S9oVswbv6aLlFknxe350MFw269lCO8C7fWbA==
X-Received: by 2002:a25:a468:: with SMTP id f95-v6mr11202838ybi.407.1534199791390;
        Mon, 13 Aug 2018 15:36:31 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 124-v6sm8607136yws.25.2018.08.13.15.36.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:36:30 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id w76-v6so14827988ywg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:36:29 -0700 (PDT)
X-Received: by 2002:a25:af4a:: with SMTP id c10-v6mr10977678ybj.463.1534199789342;
 Mon, 13 Aug 2018 15:36:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 15:36:28
 -0700 (PDT)
In-Reply-To: <20180813220419.4168133-1-arnd@arndb.de>
References: <20180813220419.4168133-1-arnd@arndb.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 15:36:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKJ2xHHn9w-H3N-Xc6cFHyDadcvUhoKJe0t44N6HEE3tQ@mail.gmail.com>
Message-ID: <CAGXu5jKJ2xHHn9w-H3N-Xc6cFHyDadcvUhoKJe0t44N6HEE3tQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 3:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
> warning because of an incorrect set of #ifdef guards:
>
> drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]
>
> Replacing the #ifdef with an IS_ENABLED() check shuts up the error
> and simplifies the logic.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/bluetooth/hci_h5.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..b10e64ba0ff4 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -841,7 +841,6 @@ static void h5_serdev_remove(struct serdev_device *serdev)
>         hci_uart_unregister_device(&h5->serdev_hu);
>  }
>
> -#ifdef CONFIG_BT_HCIUART_RTL
>  static int h5_btrtl_setup(struct h5 *h5)
>  {
>         struct btrtl_device_info *btrtl_dev;
> @@ -923,24 +922,21 @@ static struct h5_vnd rtl_vnd = {
>         .close          = h5_btrtl_close,
>         .acpi_gpio_map  = acpi_btrtl_gpios,
>  };
> -#endif
>
> -#ifdef CONFIG_ACPI
>  static const struct acpi_device_id h5_acpi_match[] = {
> -#ifdef CONFIG_BT_HCIUART_RTL
>         { "OBDA8723", (kernel_ulong_t)&rtl_vnd },
> -#endif
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
> -#endif
>
>  static struct serdev_device_driver h5_serdev_driver = {
>         .probe = h5_serdev_probe,
>         .remove = h5_serdev_remove,
>         .driver = {
>                 .name = "hci_uart_h5",
> -               .acpi_match_table = ACPI_PTR(h5_acpi_match),
> +               .acpi_match_table = (IS_ENABLED(CONFIG_BT_HCIUART_RTL) &&
> +                                    IS_ENABLED(CONFIG_ACPI)) ?
> +                                       h5_acpi_match : 0,
>         },
>  };
>
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
