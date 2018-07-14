Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFEE20873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0uzFI7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFEE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeGNIee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:34:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34422 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeGNIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:34:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so26303321edi.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iflpxDqFo3iHd8++S1H7X2GPCTJMUhlfuvFXqcPtMMU=;
        b=R0uzFI7PJhtvaZ/3cvagkGZ007gSIhV8iX0nNc7Y4bLpqXFslFL0Aiucfg+gcKOSMM
         BcTm2Q6o/iN4IunOFn3in/d6oED+7Wl2CjozHvrzJfLFCEnRpmThDKKhaEa3sY4nY6Fl
         BwrGy1yYWWkd2zDyOURHk0hB6zBkyI1nM61uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iflpxDqFo3iHd8++S1H7X2GPCTJMUhlfuvFXqcPtMMU=;
        b=bpu0fVfKvtFtAFuauj4fRhvKmW0zmVPqDuJeqfVav+/ulybl2AlYF4YybBp5TtbCBK
         qGbGyQycIv3UPyd5jFpJSLZ0pKfobJ7mtu1RJkPM1j/y0ota/TGsJ0sf2MlWKXUnkS/x
         EXlR/gYlob8VtVFWY1O1TJaAPSPfvkIenIXHFTvI5+UhlDSgsfHLOIQESm5z8M7euVOQ
         V2J+yaoHX05kKos/Qa1uWwVacr1Zoc3UVggzoEsg8Go2P7eim8CeUm/BOYGzJKZ9FFRU
         bJRj33xQhoXA648n/uZjwujaXDmWwOMR6w0IChJJ/rXL9mUBf+APGy4xTou7QyqKR5i4
         ++pg==
X-Gm-Message-State: AOUpUlGzw0DDMlOM/isabdJXVEjqvU6irut263uhrTFLEQjn3XSMn4aJ
        NouitO8cLpOwJvXxGjCQ6tjRRn0Mfe+dXg==
X-Google-Smtp-Source: AAOMgpcs9pL4sOvm/IzHUYYgkoSG5ZV65lKFVsG92tAmChzAlLNwsLtwyNViMTgLp2zXBGtnOZ1zHA==
X-Received: by 2002:a50:bdc7:: with SMTP id z7-v6mr10221541edh.84.1531556177282;
        Sat, 14 Jul 2018 01:16:17 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id g14-v6sm15565534edm.25.2018.07.14.01.16.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 01:16:16 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id a3-v6so17913615wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:16:15 -0700 (PDT)
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr6852030wrd.67.1531556175198;
 Sat, 14 Jul 2018 01:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-15-toddpoynor@gmail.com>
In-Reply-To: <20180714055816.223754-15-toddpoynor@gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sat, 14 Jul 2018 11:16:03 +0300
X-Gmail-Original-Message-ID: <CAE_wzQ9aCarAOmBECwmfUjZjWBXzOHiE3OahG0WvZXeLoJvjVw@mail.gmail.com>
Message-ID: <CAE_wzQ9aCarAOmBECwmfUjZjWBXzOHiE3OahG0WvZXeLoJvjVw@mail.gmail.com>
Subject: Re: [PATCH 14/18] staging: gasket: fix class create bug handling
To:     toddpoynor@gmail.com
Cc:     rspringer@google.com, jnjoseph@google.com, benchan@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        frankhu@chromium.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 8:59 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>
> From: Todd Poynor <toddpoynor@google.com>
>
> class_create() never returns NULL, and this driver should never return
> PTR_ERR(NULL) anyway.
>
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Reviewed-by: Dmitry Torokhov <dtor@chromium.org>

> ---
>  drivers/staging/gasket/gasket_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index f7d8f66e8746..0ef37667e0f1 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -341,7 +341,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
>         internal->class =
>                 class_create(driver_desc->module, driver_desc->name);
>
> -       if (IS_ERR_OR_NULL(internal->class)) {
> +       if (IS_ERR(internal->class)) {
>                 gasket_nodev_error("Cannot register %s class [ret=%ld]",
>                                    driver_desc->name, PTR_ERR(internal->class));
>                 ret = PTR_ERR(internal->class);
> --
> 2.18.0.203.gfac676dfb9-goog
>
