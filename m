Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737D124DE2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737D124DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933536AbeGCIQE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:16:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41762 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933013AbeGCIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:16:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id y20-v6so818105qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w0Hk1efeEbNyru1ZbH88RMPRNQqUWfrRs5O2hrfBIQk=;
        b=hbtPS9D52rYkITLQLDCqB+S+W7gACWrWjxC0Vs+Kyjr5CR9mKILIhaI1CR8ctJMMnB
         MOM/wuRjMfxOcWMCZGbUCDNx2D619GJiv33plAlBS4qnAJa6IOyTtgSTG+S0xds+XDe3
         celuFdHMCOXSjaQDR/Ep5BebXTo3TFhcfLrj8t9R+p5FCrm7qGiqpvNPx4Cld6uaR7K9
         gI4NQISnkbjBDQrO3PL29+zGSCTRWdj1rd32I1chN9jSeeqFjBGYyKjY1N9VKoB/BGEG
         n1TPA5UsksUJVu9XL67zY8zYoDTGWaI/eN3OwfN4WjJ7hNlPL7+E3mp16f8lIMDAOyE/
         Beog==
X-Gm-Message-State: APt69E2OyMx/utMsn40KX0e7u0F38m5rH2ZhdCEIwDIRbRUgW/J7sCZ7
        doD72LVnFwirabnTY4vUTvcjGO1oFI8jUOKb1SGdiA==
X-Google-Smtp-Source: AAOMgpfulP4Qi2pY0hD96pKu9O7WKxcH5pypCKquetLuxP5mYRfdEHC/oxFivvJRHHjgiSas9xxgCX6QkAGBf59JOGU=
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr23317213qta.178.1530605762020;
 Tue, 03 Jul 2018 01:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2fca:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 01:16:01 -0700 (PDT)
In-Reply-To: <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 3 Jul 2018 10:16:01 +0200
Message-ID: <CAO-hwJJpAfvvP+s9Cqmi8v7pHsEw3tKTrySQaEg8TUzPTFcQfA@mail.gmail.com>
Subject: Re: [PATCH 2/4] HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8
 for serial protocol
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> The HID_GROUP_MULTITOUCH_WIN_8 group never needs to check for the serial
> protocol, so avoid setting `td->serial_maybe = true;` in order to avoid
> an unnecessary mt_post_parse_default_settings() call
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index a793076139d7d0db9b..c0654db0b736543ca0 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1460,11 +1460,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (!td->fields) {
>                 dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
>                 return -ENOMEM;
>         }
>
> -       if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
> +       if (id->vendor == HID_ANY_ID
> +                       && id->product == HID_ANY_ID
> +                       && id->group != HID_GROUP_MULTITOUCH_WIN_8)

There is a tiny difference between the HID group (this device looks
like it is used as a Win 8 device) and the device class (this is
effectively a Win8 device)

It makes sense to remove this check for Win8 devices, but I don't
think it should be done for all devices.

All in all, it won't change much.

Cheers,
Benjamin

>                 td->serial_maybe = true;
>
>         /* This allows the driver to correctly support devices
>          * that emit events over several HID messages.
>          */
> --
> 2.18.0
>
