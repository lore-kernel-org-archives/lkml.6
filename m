Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F720870
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866F720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeIFLlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:41:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39240 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIFLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:41:30 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so11119829qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kON1c8qpWeHlEstzIDzKFaDhqYPpR/jIHzoCwIo2djg=;
        b=bhqLFQ1NL2wEEqA/sGRdAkUY/VXeeT/jbZUJZHuI3YzcoA/rdMVF2A+WzgqrJFj7z/
         O5vF8Qz83lHoyHvOlHGBO2fQAPaFq8wsnavG0BU8bSjTl6U6GUX8I83sGMB9WWw4T+Iv
         +6seg3S3mYhRXcjXF/9uchVgB9U0cWJ4VafUH5qLHoDbtTuMuN9/Y4uLEixvhhTWMuF8
         oaNJ8HmkcJuLm6abHqwUKBfMAei8ASqbM0P9iSUaSFwEex8tbeOoIinQ+uZHNNhTeaNa
         ughRK7jWlykPN1pq0ML/sdamfzsAsEiU+mRvcKdoM3bt0d00j/SEy6McBTkQaCWr8s6h
         ca3Q==
X-Gm-Message-State: APzg51AgVNvr5tUoWFSQTk618DBg+kanEaCrmfP34V6+Q2j5FrnDebhJ
        SdbVJjvt7gw4gyqioeAckem/6dNJoYwdsJKN/2ZRGg==
X-Google-Smtp-Source: ANB0VdZ8bc/Q/352pFFY9MUBzUvUTJO6NECewDOUAukrMKwSraCc/UOn+og0VZHRjB5fE3aD2+VMvP+8Sbit/oV6zAs=
X-Received: by 2002:a0c:d067:: with SMTP id d36-v6mr989456qvh.216.1536217649869;
 Thu, 06 Sep 2018 00:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180906025518.30191-1-kai.heng.feng@canonical.com>
In-Reply-To: <20180906025518.30191-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 6 Sep 2018 09:07:18 +0200
Message-ID: <CAO-hwJJTjDv0gj=3KkZDBz3cXejx-N+f_Jd2Bxk1xhogyxHMLg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Don't reset device upon system resume
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:55 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Raydium touchscreen triggers interrupt storm after system-wide suspend:
> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
> report (58/65535)
>
> According to Raydium, Windows driver does not reset the device after
> system resume.
>
> The HID over I2C spec does specify a reset should be used at
> intialization, but it doesn't specify if reset is required for system
> suspend.
>
> Tested this patch on other i2c-hid touchpanels I have and those
> touchpanels do work after S3 without doing reset. If any regression
> happens to other touchpanel vendors, we can use quirk for Raydium
> devices.
>
> There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep
> it there.
>
> Cc: Aaron Ma <aaron.ma@canonical.com>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Jiri, note that this will replace https://patchwork.kernel.org/patch/10583481/

Cheers,
Benjamin

> ---
> v2:
>  Remove Raydium devices' ID and quirk.
>  Rewording.
>
>  drivers/hid/hid-ids.h         |  4 ----
>  drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7da93d789080..e254ae802688 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -530,10 +530,6 @@
>  #define I2C_VENDOR_ID_HANTICK          0x0911
>  #define I2C_PRODUCT_ID_HANTICK_5288    0x5288
>
> -#define I2C_VENDOR_ID_RAYD             0x2386
> -#define I2C_PRODUCT_ID_RAYD_3118       0x3118
> -#define I2C_PRODUCT_ID_RAYD_4B33       0x4B33
> -
>  #define USB_VENDOR_ID_HANWANG          0x0b57
>  #define USB_DEVICE_ID_HANWANG_TABLET_FIRST     0x5000
>  #define USB_DEVICE_ID_HANWANG_TABLET_LAST      0x8fff
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 57126f6837bb..f3076659361a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -170,12 +170,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>         { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>                 I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> -       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> -               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
>                 I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> -               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { 0, 0 }
>  };
>
> @@ -1237,11 +1233,16 @@ static int i2c_hid_resume(struct device *dev)
>         pm_runtime_enable(dev);
>
>         enable_irq(client->irq);
> -       ret = i2c_hid_hwreset(client);
> +
> +       /* Instead of resetting device, simply powers the device on. This
> +        * solves "incomplete reports" on Raydium devices 2386:3118 and
> +        * 2386:4B33
> +        */
> +       ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>         if (ret)
>                 return ret;
>
> -       /* RAYDIUM device (2386:3118) need to re-send report descr cmd
> +       /* Some devices need to re-send report descr cmd
>          * after resume, after this it will be back normal.
>          * otherwise it issues too many incomplete reports.
>          */
> --
> 2.17.1
>
