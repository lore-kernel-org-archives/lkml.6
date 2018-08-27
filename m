Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680D520898
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680D520898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH0QRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:17:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42531 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0QRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:17:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so17686393qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPrUNaM1JQfAPeIKE97jAkVRBFMZZjw10wqPENHrDrQ=;
        b=uO7rW53uALeAltzTaWl+IPqeyMxNbcHf+FOmm/FUicXyUI+hkrrdPe9Dc+wm+3QL7F
         j3Fx94fSpK9OjZBFBjTVzdY75zVnQ3eUReXwUGfiUecPZaAN5Z1d63r6bi3lZLWZNDpC
         iYwMnL9fWlOzmSmDOl8W/CFjVUdpuSOJxHuEPG5YkV/v4K4Tqe8tEgx5iLqlARIReyrJ
         ev1g7b01SAAovBHT8ApIK599bYOHhq6dscP8vVEVTVLtnp+xgOSAZvJHr1qp9Cuj/TsJ
         TQhmZ9gyvnabpTakAg/Ri0OgyNqAoOhzckSY0BJR9YiJdQsdlzf5VVTgOa+EMoGf4JHe
         JFbA==
X-Gm-Message-State: APzg51BqauCdQeUSmEM73j/8irN6lnRebHBjKPnibdBuWA8I3m+9W9IJ
        FzoPC0FlEaQsbACMywHm74hQCtD3nzKrzE4gpsk8Vg==
X-Google-Smtp-Source: ANB0VdZ/7F3OSal5HselBlxHRB2+Avge0Er/4PMQk5KFMF6Feif3hTL9CWWxfDiYJShzjt3zqR+iRaJib88T53hyako=
X-Received: by 2002:ac8:704c:: with SMTP id y12-v6mr3391573qtm.325.1535373065399;
 Mon, 27 Aug 2018 05:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180821085513.13739-1-acelan.kao@canonical.com>
In-Reply-To: <20180821085513.13739-1-acelan.kao@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 27 Aug 2018 14:30:53 +0200
Message-ID: <CAO-hwJJAfDvgRqWxFS=0Ga2SbhA3LbttjiG79vzZKTiZQizYoA@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Fix flooded incomplete report after S3 on
 Rayd touchscreen
To:     acelan.kao@canonical.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:55 AM AceLan Kao <acelan.kao@canonical.com> wrote:
>
> The incomplete report flooded after S3 and touchscreen becomes
> malfunctioned.
> [ 1367.646244] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/18785)
> [ 1367.649471] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/28743)
> [ 1367.651092] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/26757)
> [ 1367.652658] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/52280)
> [ 1367.654287] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/56059)
>
> Adding device ID, 04F3:30CC, to the quirk to re-send report description
> after resume.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

Looks good:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-ids.h         | 1 +
>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c7981ddd8776..e80bcd71fe1e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -528,6 +528,7 @@
>
>  #define I2C_VENDOR_ID_RAYD             0x2386
>  #define I2C_PRODUCT_ID_RAYD_3118       0x3118
> +#define I2C_PRODUCT_ID_RAYD_4B33       0x4B33
>
>  #define USB_VENDOR_ID_HANWANG          0x0b57
>  #define USB_DEVICE_ID_HANWANG_TABLET_FIRST     0x5000
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index eae0cb3ddec6..5fd1159fc095 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -174,6 +174,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
>                 I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> +       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> +               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { 0, 0 }
>  };
>
> --
> 2.17.1
>
