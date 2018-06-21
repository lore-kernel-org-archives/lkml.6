Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF5DC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355C422A84
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kw4EEQi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355C422A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeFUX6s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:58:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38978 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933022AbeFUX6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:58:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so213853eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvtyneTbzpZih6bP65LnWXyF3DYstJgWqWH3pVaSco4=;
        b=kw4EEQi0K6jl7iiUsIlDiZlOBtKcXHlW5Qb3nKmLEyy5fjvxw0Ic+G3L32egBvm+CM
         DB2M+oisROTDU5BmAPuVqivw8SNrZ3jToDzrGWEEIzlfgeFKopiww9NKoNGEg5ZS3UBr
         QeMipJ+nMKi+b7/YhcoEeXUhuh8VuwHwmJvVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvtyneTbzpZih6bP65LnWXyF3DYstJgWqWH3pVaSco4=;
        b=pLZCvuwNCvQBPrEZ9S7DFLG5m3wR3AouMnSsRKkY5q48y3KT1MneJG6q1mMp+25Mhz
         5UbUBjL+qEXrCenzjksbTOUz1lQaZeAHyAckvmgxb9WwIUbQ83fQde4m9FfQltajShpD
         n94HZiwCxmxoIKXpDC/JyfuGCqeoAj5ugCnZLnimwb0sKw6FqnlWCbDqBex0gWtUpeVu
         HQLCOd6oPlU0Iu3EIRBF/IEo1iqV2xaooH31s7b/NcdIaXvhxRlnRX6edQ+UJ3f9jgdg
         ysoftBZzriruql6MQQw6uO6TMP/agS+En7K8XMdIfKiFnsY9EhH61fwORfHhEedsb4JW
         xQ/w==
X-Gm-Message-State: APt69E1m486eU797WBRmKzkKIIvk0eiDgWlST1Sh5pncza2LCT/YcbPB
        zttN/dChSRVRqWZbsoGyV3OMsyAbIUY=
X-Google-Smtp-Source: ADUXVKKFgayfW5K4jZDxln1PefNElwG/17diYr7LSj1S+0KV/fFqWDOD18HYOzp+YBYVgXuuQoLRhQ==
X-Received: by 2002:a50:92d3:: with SMTP id l19-v6mr23350081eda.52.1529625525277;
        Thu, 21 Jun 2018 16:58:45 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id d16-v6sm6269422ede.21.2018.06.21.16.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 16:58:44 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id p11-v6so419227wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:58:43 -0700 (PDT)
X-Received: by 2002:a1c:800e:: with SMTP id b14-v6mr6464276wmd.83.1529625523658;
 Thu, 21 Jun 2018 16:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180621234138.30537-1-swboyd@chromium.org>
In-Reply-To: <20180621234138.30537-1-swboyd@chromium.org>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Thu, 21 Jun 2018 16:58:31 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ8YKUF1U4MKBfi9GQpFz=971j57w-1n-ggZHidMA4HEzQ@mail.gmail.com>
Message-ID: <CAE_wzQ8YKUF1U4MKBfi9GQpFz=971j57w-1n-ggZHidMA4HEzQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Add vddl regulator control
To:     swboyd@chromium.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        andriy.shevchenko@linux.intel.com,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 4:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some wacom w9013 devices have a vddl supply for "low valtage"
> requirements. Add support in this driver to turn on this low voltage
> supply. We can also drop a handful of error messages because the
> regulator core is already printing an error when bulk regulators fail to
> enable or disable.
>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dmitry Torokhov <dtor@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Use the bulk regulator APIs instead of open coding it (Dmitry)
>
>  .../bindings/input/hid-over-i2c.txt           |  3 +-
>  drivers/hid/i2c-hid/i2c-hid.c                 | 62 +++++++++----------
>  include/linux/platform_data/i2c-hid.h         |  7 +--
>  3 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> index 4d3da9d91de4..89e6ab89ba38 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> @@ -26,7 +26,8 @@ device-specific compatible properties, which should be used in addition to the
>
>  - compatible:
>    * "wacom,w9013" (Wacom W9013 digitizer). Supports:
> -    - vdd-supply
> +    - vdd-supply (3.3V)
> +    - vddl-supply (1.8V)
>      - post-power-on-delay-ms
>
>  - vdd-supply: phandle of the regulator that provides the supply voltage.
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index c1652bb7bd15..1d83531454c5 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1002,18 +1002,21 @@ static int i2c_hid_probe(struct i2c_client *client,
>                 return client->irq;
>         }
>
> -       ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
> +       ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);

The patch looks good, but I think this chunk needs to be split out.

Thanks,
Dmitry
