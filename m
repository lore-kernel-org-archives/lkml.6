Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8144C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02512133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcFN1iqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfA0UcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:32:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41471 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0UcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:32:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so6323278pgq.8;
        Sun, 27 Jan 2019 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSK3zkF4qiqbJQU70H588EwbFtk9ADV29oj9m37AlvE=;
        b=AcFN1iqTQaJE+IfF+4e+2QhW8wmhGoO9NdxVS7fDd9tgJGhRLu7Dtmp5qjG5y6Vpaz
         qZcNl+ZH389gWaWFQfutmjiHCEH3OnX8IpVuTsBwgnQlP8Ott7R8l9L/j5MMC1Rog479
         NuQFLBQ4/azctof7rJAcEdbWvv9zhoQp7A58/XMHlkce5cOaj0Sd41ojKVe9Sk26AUEU
         kzq/tbHfHT2gsIQqAu744MRSBAyzMgIrPMbdNLW7YttuQyqZtuVRfT1lrvEajNa86HeK
         zolv/IAX6JrU6om+tKHg0bdXFNlkZD7ekwV8aO5pBhchzeU9aXPuAow/IIJIhVemlcbO
         Pyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSK3zkF4qiqbJQU70H588EwbFtk9ADV29oj9m37AlvE=;
        b=Xq42xIzC0JpEuTvGAAO1a1UFLSkd1mFxUZniXZuVYzbqtG/HIPgFXfk9fNofLuTfg1
         9nBJa9qWlnMV7uUrvEOcWhV4KMiO7xyVOUptvROQeC2PUfAa09TGdae+rMpMcbQuvkjA
         nWokmrCpFz0utTgu5NGuOTmqLI6XWrdN6UxAjZzXkpeWTejIcqQ6/4xTfIyg4hSZdFGF
         715GaNCCk/xrdIKobh12Mrfi+N1eldqsobJCS4zp175ZlNU66u5R21o79rOWu86dIntY
         sZ6JWJpCxFwS4lefIgFw1ZNJ+vBIQqNFeoYPgVWIlDEjVu3LY2fo8KCGTRbmZwVInpVT
         KveQ==
X-Gm-Message-State: AJcUukfHnMBPIY920AHthTfNgfK30puVMkf3KYLCrCLsClp4e6EQZucp
        wlu7M9IkqKiofgmJq+QInV/13cPZW+sLe92dbBA=
X-Google-Smtp-Source: ALg8bN4K1IWL9rPL/yGZyyWFsRsHFdRZoj04/wj9/W08qdbekKg76O9hh9hFoTzFq0/SI1TfEdBIXtVJl8h9i9XBync=
X-Received: by 2002:a63:d450:: with SMTP id i16mr17204191pgj.246.1548621132026;
 Sun, 27 Jan 2019 12:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20190122200302.19861-1-2pi@mok.nu>
In-Reply-To: <20190122200302.19861-1-2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Jan 2019 22:32:00 +0200
Message-ID: <CAHp75Vfv1sMyAQn=ue0hroqAnbkhQayCj64xNBHO5PRRv53GSA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: fix potential null pointer dereferences
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> In the function wmi_dev_match() there are three variables that
> potentially can result in a null pointer dereference. Namely:
> dev/wblock, driver/wmi_driver, and wmi_driver->id_table.
>
> Check for NULL and return that the driver can't handle the device if any
> of these variables would result in a null pointer dereference.
>
> The NULL checks are performed prior to running container_of() for the
> variables dev/wblock and driver/wmi_driver.
>
> Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> ---
>  drivers/platform/x86/wmi.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index bea35be68706..c596479e8b13 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -763,10 +763,18 @@ static void wmi_dev_release(struct device *dev)
>
>  static int wmi_dev_match(struct device *dev, struct device_driver *driver)
>  {
> -       struct wmi_driver *wmi_driver =
> -               container_of(driver, struct wmi_driver, driver);

AFAIU this is just a pointer arithmetics, no need to move it.

> -       struct wmi_block *wblock = dev_to_wblock(dev);

> -       const struct wmi_device_id *id = wmi_driver->id_table;
> +       const struct wmi_device_id *id;
> +       struct wmi_block *wblock;
> +       struct wmi_driver *wmi_driver;
> +

> +       if (dev == NULL || driver == NULL)
> +               return 0;

On which circumstances this may ever happen?

> +       wblock = dev_to_wblock(dev);
> +       wmi_driver = container_of(driver, struct wmi_driver, driver);
> +
> +       if (wmi_driver->id_table == NULL)
> +               return 0;
> +       id = wmi_driver->id_table;
>
>         while (id->guid_string) {
>                 uuid_le driver_guid;
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
