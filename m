Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A5FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C4420891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbML4fjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C4420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeFQQr7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:47:59 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38290 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933989AbeFQQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:47:57 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so8222730vkb.5;
        Sun, 17 Jun 2018 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hbjt+ml6jVS2ftOMqYpCX/BT86nn1W1rqqwt2/gfJ6o=;
        b=IbML4fjlgnFGxVe+bBAp+QrbMg0AYhJt1B/3okOuq8TjsGcTeRpeLGI6wSy/q57qKN
         Jpt53uigy8MDo0Qfi9NxBshJxAY/I6XI1M08vIssn0EOf5gP8YqkW6ilLD5BkQDroFg/
         Y4cQiBMNQNSd/63E11JABIgnGR8DhqUQrHv5INB3O+UsDX3/NN+66ChalnwbuXFG4CJR
         CNV3N+I2qCZlyakL5ptqRQ3Rz2UjjRG2A+o7vdOKLrkZcQMQwBT8KTQXgHQ93zsrsnqd
         9C7A8wwBIqOOeoyRb5cLhHHRlQWEasZwQKwc3VVr4qxdiR0ky26Zcw9SAJmDKe6zBUbr
         wI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hbjt+ml6jVS2ftOMqYpCX/BT86nn1W1rqqwt2/gfJ6o=;
        b=eBBzKcawipY5OWEg9Ibs2sIyLo0gj880reOnQbjfAqk/p6mRd7MM2rOqRCIhmNk1BD
         FPaNTnBe4HzlX/51AtgsMinioEz6f/cRpR0wLArUSXHRRVjKaJbK331NdE2TlRxE5diA
         2kC9qf+GzepT68aqrbuAuEdfBg7xJ5cQnfK6+E38fcDU+gcMrE5rjqLTHqnOJTD6t2gD
         x5Ezf8IllhZgenoc9+fSU5sbq1GDY/kTT0LJ8gaO0ATjhjhtWTaUUV/Azxfkd0/dkY0J
         rvrjwtIm9z0L33f/6ZEwtr2pta8+Re7KP2o3b6YrkPfjyn3EbJW86rcgasyxLcYNibOO
         S4zA==
X-Gm-Message-State: APt69E00HTxYrA+g96KNcLY+0hpCZcAq37VveS0m9z5P30+WfKtG8d4Z
        BI+Wy6M7TAFupT12mzVFr0n9WvgtJAQX6ky9A/13Kg==
X-Google-Smtp-Source: ADUXVKJ2q8u6kw4Xds/SGOh/USwvzokNlTwU9PAxkh0LZE1WXeZf9QuQmAzOg9IOIm+1dlWhRzBvF5wKn5tYEZmS+T4=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr5320894vkd.15.1529254076413;
 Sun, 17 Jun 2018 09:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180617140326.12854-1-youling257@gmail.com>
In-Reply-To: <20180617140326.12854-1-youling257@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Jun 2018 19:47:44 +0300
Message-ID: <CAHp75VeBWw1VOJiSHTdKpnrOFiCoKDmxt6HS1ctoWjhKHBiN7Q@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS
To:     youling 257 <youling257@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch, my comments below.

On Sun, Jun 17, 2018 at 5:03 PM youling257 <youling257@gmail.com> wrote:
>
> Add touchscreen info for the ONDA V891W Dual OS

It would be nice to end sentences with period.

>
> Signed-off-by: youling257 <youling257@gmail.com>

There is still couple of things that prevents me to apply:
 - please use your real name in SoB
 - you forget to add Hans' tag

> ---
>  drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 6284946cb0d1..2ad9327c8c0f 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -221,6 +221,24 @@ static const struct ts_dmi_data onda_v891w_v1_data = {
>         .properties     = onda_v891w_v1_props,
>  };
>
> +static const struct property_entry onda_v891w_v3_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl3676-onda-v891w-v3.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data onda_v891w_v3_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = onda_v891w_v3_props,
> +};
> +
>  static const struct property_entry pipo_w2s_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
> @@ -481,6 +499,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
>                 },
>         },
> +       {
> +               /* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
> +               .driver_data = (void *)&onda_v891w_v3_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
> +                       DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
> +               },
> +       },
>         {
>                 /* Pipo W2S */
>                 .driver_data = (void *)&pipo_w2s_data,
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
