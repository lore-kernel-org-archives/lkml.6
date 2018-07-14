Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA37ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB120873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cW2cYvgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAB120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeGNIZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:25:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44927 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeGNIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:25:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id d17-v6so14180325eds.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nL6BQKuwkG4bBOt4i3NR2ApsksW7C5jSTAm0yQKngUY=;
        b=cW2cYvgDcip2LQs3Sb9941d4sYVL+HItaGfzqMc+tvxf4+u+C5vzwOCxTTV8c5gsbl
         BiQX1UOZI6qpmXXlDRFHdHjBL4hkcRZsJYqjdrk9WGMShoVK+GB1aSDvqa2JojrkVzRA
         pyLQZGggfcYPQuThnw/O89xOtX1VKIYmJD3bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nL6BQKuwkG4bBOt4i3NR2ApsksW7C5jSTAm0yQKngUY=;
        b=PZ91rlrhutfvlFZmgXI4KsZn2S/gOBW38n5kPFfkwu0f4MtwFwaws6rMgD1csEhZ0/
         dPS96u0tI1LK32lUWZwEoUP7EncnuSpM1/DkMRWjdht5kCG1iZmZZ3ppaBen5ih6fovC
         JF059B3I6WzLbgIlVIYFTKEj7FQAHla8PqcZKun313irLCShWS63iO+Oe+7onUo00Bsu
         77R3Wn1TPbxFuGSRKIriGp7WGlDR1ECWq04e/OPVc8X70hUCVXiqpy3uMFUaWQU33PW1
         QAl5YP+fu2LAuFk7eaOO0ptfzjBlhYlD1h6VQbL14YjiM/OsFM7pJHAW3HqBI5mObNbP
         GfxA==
X-Gm-Message-State: AOUpUlGefe38zmcdpIUvJUtIC+YVz15QSaPMv+Eh6L0lCSr7Egq8b4lS
        fot/9h3ZfRBND9YHQUYkwCfX6AGashEakA==
X-Google-Smtp-Source: AAOMgpd7woiKpb4WSGwCBkZ27IVrS6GP9TN5ghFm2hyugrQF+Mslmn/rJq4UDnn77roUNyuZEK4lSQ==
X-Received: by 2002:a50:bdc7:: with SMTP id z7-v6mr10196384edh.84.1531555656478;
        Sat, 14 Jul 2018 01:07:36 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id b4-v6sm10730032edl.57.2018.07.14.01.07.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 01:07:34 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id c4-v6so14455258wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:07:34 -0700 (PDT)
X-Received: by 2002:adf:bc92:: with SMTP id g18-v6mr6985259wrh.266.1531555653918;
 Sat, 14 Jul 2018 01:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-7-toddpoynor@gmail.com>
In-Reply-To: <20180714055816.223754-7-toddpoynor@gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sat, 14 Jul 2018 11:07:21 +0300
X-Gmail-Original-Message-ID: <CAE_wzQ9BCLryFUrytYEJ+tSsog4nUXEr4cbtYNgbq3w7U-qezQ@mail.gmail.com>
Message-ID: <CAE_wzQ9BCLryFUrytYEJ+tSsog4nUXEr4cbtYNgbq3w7U-qezQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] staging: gasket: fix deadlock in pci driver
 unregister path
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

On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>
> From: Todd Poynor <toddpoynor@google.com>
>
> g_mutex held across pci_unregister_driver() call, also held in
> gasket_pci_remove(), which deadlocks.
>
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 3bdf7d36b397..6d240dc59557 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -668,13 +668,10 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
>         struct gasket_dev *gasket_dev = NULL;
>         const struct gasket_driver_desc *driver_desc;
>         /* Find the device desc. */
> -       mutex_lock(&g_mutex);
> +       __must_hold(&g_mutex);

And what exactly ensures that mutex is held here? Yes, we are holding
the mutex when we unload the driver, but PCI hot-unplug or unbinding
the device though sysfs do not go through module unload code path, so
you'll end up here without holding the mutex.

>         internal_desc = lookup_internal_desc(pci_dev);
> -       if (!internal_desc) {
> -               mutex_unlock(&g_mutex);
> +       if (!internal_desc)
>                 return;
> -       }
> -       mutex_unlock(&g_mutex);
>
>         driver_desc = internal_desc->driver_desc;

Thanks,
Dmitry
