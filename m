Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82798C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595DF2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfARPup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:50:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43875 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:50:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id z18so8280785qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rDhBy24lmquqEChoLcC8jJawFxISjOlSqV15N18Uhk=;
        b=Esmx9KT39Lu9rRkX9HU01QnB5W2tttNGMUBTQSfQGLmZX/v546uFHdUUR9wqdS2D/H
         I30h+7KBqSGp/hjwNjmTrEwAUTyVwh6Px/ILbJ0B17depwOWWDTgW/jkZOXTcGubmDQn
         DhKmY+IObnpR8HPd8VnQE0ExnXiqvYJkiihgduJ7uxMBJqOHPp4uUQ2S8oAic2/lbCLu
         G6qJq73xyYYLypaR9ovZSYvTveu2QjxrzYhMMTBfyZ5bPTlXZyyxmZcpt8GLZJdpHUwv
         d51cSWHWNYW461Q5SmeXD4yaDyVC2CAxBmcj9K4UWapV3JkSskkM9KiFpyTgt8BG6We1
         4HAg==
X-Gm-Message-State: AJcUukdTBgg+6Er1O31Fh1nOQcJ+9jTxnZBPM+Uoiin7Mkr3sralFyPI
        sQAtd4ShU6SSTUg2J5de5730Fy2FwRBWtlYxznV8KQ==
X-Google-Smtp-Source: ALg8bN6qepOmI14E2FSsIIIop1LrDepMTPcqlMSs4nFtaHj/wQLmEgeGxm3LK/VOpSgjkSpMw44Wo5H0Sfh6kp6K/TQ=
X-Received: by 2002:a37:4792:: with SMTP id u140mr15758674qka.301.1547826643888;
 Fri, 18 Jan 2019 07:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20190107072429.23828-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190107072429.23828-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 18 Jan 2019 16:50:32 +0100
Message-ID: <CAO-hwJKo=EaPoXJLGUvjq3QRng1V1NkO7A5zYGojbPyxxyJYHA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

On Mon, Jan 7, 2019 at 8:24 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> While using Elan touchpads, the message floods:
> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
>
> Though the message flood is annoying, the device it self works without
> any issue. I suspect that the device in question takes too much time to
> pull the IRQ back to high after I2C host has done reading its data.
>
> Since the host receives all useful data, let's ignore the input report
> when there's no data.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks for the v3.

This patch has just been brought to my attention, and I have one
question before applying it:
are those messages (without your patch) occurring all the time, or
just after resume?

I wonder if the pm_suspend delay we talked about in the other thread
would fix that issue in a cleaner way.

Cheers,
Benjamin

> ---
> v3:
> Fix compiler error/warnings.
>
> v2:
> Use dev_warn_once() to warn the user about the situation.
>
>  drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 8555ce7e737b..2f940c1de616 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -50,6 +50,7 @@
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
> +#define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
>
>  /* flags */
>  #define I2C_HID_STARTED                0
> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>         { USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> +                I2C_HID_QUIRK_BOGUS_IRQ },
>         { 0, 0 }
>  };
>
> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>                 return;
>         }
>
> +       if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
> +               dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but "
> +                             "there's no data\n", __func__);
> +               return;
> +       }
> +
>         if ((ret_size > size) || (ret_size < 2)) {
>                 dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
>                         __func__, size, ret_size);
> --
> 2.17.1
>
