Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F59C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C937C2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C937C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeJOPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:48:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeJOPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:48:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so16598366lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+UEMkIlPFyyJqpbqYVpgCX76XgDUY+jABnb/nRFPSI=;
        b=Ls8qmZFuPjjofBc4TKnXq+LLt9tPwLsJdCUifjlZ68y4PJuW+6gy5tHJNwDAaet/nT
         xhNetCBaWUnsrCRYy8kX04bVP5Oyedy6qVobJLq+LbjRYsfIQGlIddiWk0HhBa6ci260
         g1lARbwpKAaNn2q7u4839iAXR7x5bOYQql9Hl51nm+454pqn9cLRpThcyHgsG+J1EBfF
         ApHu30LJzV7GAuw80inHrwqd9Qbe/VTRAVhwqntfNqAeC43hjbVOZEiouEIewae3LpcL
         1wL0Y9CKTUAr85ZQOhMwbECXjm3Diw1wwT3wySNtGXfuGgg7iXrtbaIZvZCQMQF5YaZG
         sfMg==
X-Gm-Message-State: ABuFfohI29GSamdxJ+D36xropga4kPq9d2PLaB5uTWoZGlVQcpl/fDku
        nphqq65zqPw0q/6cBuOEVD5qMaEBExfw+rpFo6ltdA==
X-Google-Smtp-Source: ACcGV61HkEOo4GKLpfA2lVhEnevcY/fpO15lzPxIaYR/4i+jGeaXMenPqU9539Xa5WSnm8+XBbos5oXgOh1SiXwo39U=
X-Received: by 2002:a2e:574f:: with SMTP id r15-v6mr10981192ljd.106.1539590672844;
 Mon, 15 Oct 2018 01:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181005044629.26286-1-kai.heng.feng@canonical.com>
In-Reply-To: <20181005044629.26286-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 15 Oct 2018 10:04:21 +0200
Message-ID: <CAO-hwJJACzB4MmPxeyT1ERLyifeC06tg_DU+1PZwOruBf-42TQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Add a small delay after sleep command
 for Raydium touchpanel
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 6:46 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
> although it works in display manager.
>
> During user logging, the display manager exits, close the HID device,
> then the device gets runtime suspended and powered off. The desktop
> session begins shortly after, opens the HID device, then the device gets
> runtime resumed and powered on.
>
> If the trasition from display manager to desktop sesesion is fast, the
> touchpanel cannot switch from powered off to powered on in short
> timeframe. So add a small delay to workaround the issue.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Use quirk to only match affected touchpanel
> - Only delay the next power on if the time hasn't elapsed

Hi,

I like the patch much better. And I even would be tempted to have this
unconditionally enabled now that the general path doesn't have the
msleep in the middle.

So how about we merge this patch now, and if in the long run we see
more devices that require this quirk, then we can probably remove the
specific quirk and make it mandatory?

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
>  drivers/hid/hid-ids.h              |  3 +++
>  drivers/hid/i2c-hid/i2c-hid-core.c | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 16342188df19..c1b5f03eb630 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -926,6 +926,9 @@
>  #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003                0x3003
>  #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008                0x3008
>
> +#define I2C_VENDOR_ID_RAYDIUM          0x2386
> +#define I2C_PRODUCT_ID_RAYDIUM_4B33    0x4b33
> +
>  #define USB_VENDOR_ID_RAZER            0x1532
>  #define USB_DEVICE_ID_RAZER_BLADE_14   0x011D
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 4aab96cf0818..3cde7c1b9c33 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -49,6 +49,7 @@
>  #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV       BIT(0)
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
> +#define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
>
>  /* flags */
>  #define I2C_HID_STARTED                0
> @@ -158,6 +159,8 @@ struct i2c_hid {
>
>         bool                    irq_wake_enabled;
>         struct mutex            reset_lock;
> +
> +       unsigned long           sleep_delay;
>  };
>
>  static const struct i2c_hid_quirks {
> @@ -172,6 +175,8 @@ static const struct i2c_hid_quirks {
>         { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>                 I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> +       { I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
> +               I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>         { 0, 0 }
>  };
>
> @@ -387,6 +392,7 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>  {
>         struct i2c_hid *ihid = i2c_get_clientdata(client);
>         int ret;
> +       unsigned long now, delay;
>
>         i2c_hid_dbg(ihid, "%s\n", __func__);
>
> @@ -404,9 +410,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>                         goto set_pwr_exit;
>         }
>
> +       if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
> +           power_state == I2C_HID_PWR_ON) {
> +               now = jiffies;
> +               if (time_after(ihid->sleep_delay, now)) {
> +                       delay = jiffies_to_usecs(ihid->sleep_delay - now);
> +                       usleep_range(delay, delay + 1);
> +               }
> +       }
> +
>         ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
>                 0, NULL, 0, NULL, 0);
>
> +       if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
> +           power_state == I2C_HID_PWR_SLEEP)
> +               ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
> +
>         if (ret)
>                 dev_err(&client->dev, "failed to change power setting.\n");
>
> --
> 2.17.1
>
