Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B60C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3756823E19
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3756823E19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeFVHQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:16:32 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44647 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbeFVHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:16:29 -0400
Received: by mail-qt0-f196.google.com with SMTP id 92-v6so703960qta.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZS+ojZXaIS2zHSZSG2Anfn1I2+pJOO2cuA45SekaGFo=;
        b=SlGIFfMaJfAoGAsxk5dYfaBEiKZbv8Bzs1+KP60VKSbKqSaKqf4nRLVAM2Kg0j/9RK
         wCszCCZByto2PeZ+LgIALSGOI2sW1npl7I+blK6lqzMTQS41OPJr4VxpBHQlLs2w6zdE
         C9SGrjwIh1n7f7Ge4lAMzn6CvdWTBM4WIw6jwckFGq+aah3oP7HTax6hIvQGnbEHl+/N
         JPLXTS1FeIvu5GkzYzumX4TskllHXSGb6fAwxdUIYcdz/Q0LQjRyabtOqz+QGh8OxM/C
         PcyOB0DgN+23fepKqsCcBgrTgSOTuYYVxNyafHh3iQkGs6zhvPRAjHg4td7OuJLjo4uw
         efoA==
X-Gm-Message-State: APt69E1jWsOlb/TIXGTKQB8xInSdy4nmlINloadbG008Kttb/qdWfPMo
        +PgRcBJrLikH+SmRCoW3aJiYC09KCISd20XlfoQGYg==
X-Google-Smtp-Source: AAOMgpcjaUdwY6EOJGEvZya0LDAlXl+pAdEUw82V0foBYm8Z4ktsUE4Cc5LcucF/C8rxxXcvxE80S+jpQynUM9yMOYc=
X-Received: by 2002:a0c:d0eb:: with SMTP id b40-v6mr358012qvh.236.1529651788738;
 Fri, 22 Jun 2018 00:16:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2bc7:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:16:28
 -0700 (PDT)
In-Reply-To: <20180622022717.134300-2-swboyd@chromium.org>
References: <20180622022717.134300-1-swboyd@chromium.org> <20180622022717.134300-2-swboyd@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 22 Jun 2018 09:16:28 +0200
Message-ID: <CAO-hwJJxSHqwEcypc-PVSDUoOSM4OHcOP18QJpoxq6OqKcbq-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] HID: i2c-hid: Use devm to allocate i2c_hid struct
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 4:27 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> Use devm here to save some lines and prepare for bulk regulator usage in
> this driver. Otherwise, when we devm bulk get regulators we'll free the
> containing i2c_hid structure and try to put regulator pointers from
> freed memory.
>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dmitry Torokhov <dtor@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index c1652bb7bd15..c7d6738dc524 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
>                 return client->irq;
>         }
>
> -       ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
> +       ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);

IIRC, I never made the switch towards devm for i2c_hid because at the
time there was a "all or nothing" rule regarding devm.
But given that the regulator already has a devm inside, I think we are
screwed here and we should probably try to devm-ize the module.

I seem to remember that someone posted a devm version of
hid_allocate_device/hid-add_device, but I don't think this ever went
upstream (because no use).

Otherwise, for the series:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin



>         if (!ihid)
>                 return -ENOMEM;
>
>         if (client->dev.of_node) {
>                 ret = i2c_hid_of_probe(client, &ihid->pdata);
>                 if (ret)
> -                       goto err;
> +                       return ret;
>         } else if (!platform_data) {
>                 ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
>                 if (ret)
> -                       goto err;
> +                       return ret;
>         } else {
>                 ihid->pdata = *platform_data;
>         }
> @@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
>
>  err:
>         i2c_hid_free_buffers(ihid);
> -       kfree(ihid);
>         return ret;
>  }
>
> @@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
>
>         regulator_disable(ihid->pdata.supply);
>
> -       kfree(ihid);
> -
>         return 0;
>  }
>
> --
> Sent by a computer through tubes
>
