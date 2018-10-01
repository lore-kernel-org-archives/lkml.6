Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F93C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E5C2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcStzklx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E5C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeJAOzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:55:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36749 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:55:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id p89-v6so11279851ljb.3;
        Mon, 01 Oct 2018 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7pkHtSIPpwNIdKEIcKEuM+r+OnOX2cF/1cMeMMbUwg=;
        b=EcStzklxa75YO+t9w8zj1RWDV6szkVsQXHMelaOjRS4QQnv4da9xgkfQkSIqfuXkck
         ELbXHqK3aZs45j78/a2mgP/9LkXlOz548Dougt+2dlwF/gULlfkdi36OMXEo3FNns7XH
         zWO1vZv0+iEu7G/W+HSBuT6tSwP0My0p1OyXJE4BaBkMCeWe0KeO9YZb2Nq3lhshWuSL
         zmF2tPmiJzV/rDnccumlrkLLX+5IEwQl4wRjwKwohLFooIDjtqVJ6CNt2BAG/AGYUxrl
         1N7n+OtK/GkrKXVQczqLEAysfpw6E09Td9vRoMSUiGGV2BNQAVD9MR8OPYCP3xlTMqq4
         SK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7pkHtSIPpwNIdKEIcKEuM+r+OnOX2cF/1cMeMMbUwg=;
        b=rpiwg9MU88mtsHtbV0by2N3FaY1Vb8+D3Fx44DwqFa/SioYfXS7USTYne/3prBeaRB
         l459VqILx9XiK/a2vJbZvLgfkODHxHh6O+jpP6BdGISN757izEQZb2dpU/8l5cGFgGPP
         e7R6K995TVoMq7eK/n0BDTNZeZyiPlp51FxLC/f/Q16Oy3hDryiAbV5M+CX77XQAUyuZ
         YDWdjdmJrldEaNvnhtXZI8J1XJKMiXs2CNaz7vvnPvBAD5/xr75f4qzSD1/cnX4tf3f5
         vtYMKBpeLFk0jPasgT4bJ9tb2ehhT42vf7nhyjt9GSp4WZfWrta/anhsUpivNvOG75zY
         jfBQ==
X-Gm-Message-State: ABuFfoiQ7CvvBclirSd2bo3BEmE8PuWGzTSa2EMLy6qBK9jUd9ih6JBS
        Mi8JFf0N3TjYJw2hX18c9+sFblVvownZLl4gTnk=
X-Google-Smtp-Source: ACcGV60hJEzzL6foynvY5oNJZKv9Kky4Fi1iqqrJIen1nX3MMIMFALIquWO83iixLcI7GgD7bOMH8jaIYRHvZjifVOU=
X-Received: by 2002:a2e:921a:: with SMTP id k26-v6mr5466049ljg.163.1538381956985;
 Mon, 01 Oct 2018 01:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-6-ricardo.ribalda@gmail.com> <20180927193508.r25owgcwfeui2x7k@valkosipuli.retiisi.org.uk>
In-Reply-To: <20180927193508.r25owgcwfeui2x7k@valkosipuli.retiisi.org.uk>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 10:19:00 +0200
Message-ID: <CAPybu_3sh8KVZZruPrvvjEN=5=b56ciUjJXL5PK6GdV3mRG_Vg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] [media] ad5820: Add support for ad5821 and ad5823
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari
On Thu, Sep 27, 2018 at 9:35 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Thu, Sep 20, 2018 at 10:47:50PM +0200, Ricardo Ribalda Delgado wrote:
> > According to the datasheet, both AD5821 and AD5820 share a compatible
> > register-set:
> > http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf
> >
> > Some camera modules also refer that AD5823 is a replacement of AD5820:
> > https://download.kamami.com/p564094-OV8865_DS.pdf
>
> A silly question --- the maximum current of these devices differs from each
> other. Is the control value range still the same?

AFAIK yes, and fortuntately/unfortunatelly the control interface is in
a value, not in Amp, so there is nothing to convert on the driver.

Regards!

>
> >
> > Suggested-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  drivers/media/i2c/ad5820.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
> > index 5d1185e7f78d..c52af302d516 100644
> > --- a/drivers/media/i2c/ad5820.c
> > +++ b/drivers/media/i2c/ad5820.c
> > @@ -34,8 +34,6 @@
> >  #include <media/v4l2-device.h>
> >  #include <media/v4l2-subdev.h>
> >
> > -#define AD5820_NAME          "ad5820"
> > -
> >  /* Register definitions */
> >  #define AD5820_POWER_DOWN            (1 << 15)
> >  #define AD5820_DAC_SHIFT             4
> > @@ -368,7 +366,9 @@ static int ad5820_remove(struct i2c_client *client)
> >  }
> >
> >  static const struct i2c_device_id ad5820_id_table[] = {
> > -     { AD5820_NAME, 0 },
> > +     { "ad5820", 0 },
> > +     { "ad5821", 0 },
> > +     { "ad5823", 0 },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
> > @@ -376,6 +376,8 @@ MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id ad5820_of_table[] = {
> >       { .compatible = "adi,ad5820" },
> > +     { .compatible = "adi,ad5821" },
> > +     { .compatible = "adi,ad5823" },
>
> You could set the subdev name accordingly as well.
>
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(of, ad5820_of_table);
> > @@ -384,6 +386,8 @@ MODULE_DEVICE_TABLE(of, ad5820_of_table);
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id ad5820_acpi_ids[] = {
> >       { "AD5820" },
> > +     { "AD5821" },
> > +     { "AD5823" },
> >       { }
> >  };
> >
> > @@ -394,7 +398,7 @@ static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
> >
> >  static struct i2c_driver ad5820_i2c_driver = {
> >       .driver         = {
> > -             .name   = AD5820_NAME,
> > +             .name   = "ad5820",
> >               .pm     = &ad5820_pm,
> >               .of_match_table = of_match_ptr(ad5820_of_table),
> >               .acpi_match_table = ACPI_PTR(ad5820_acpi_ids),
>
> --
> Regards,
>
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi



-- 
Ricardo Ribalda
