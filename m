Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ACDC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BA92081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BA92081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKDH3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:29:12 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44559 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbeKDH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:29:12 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so605731uaq.11;
        Sat, 03 Nov 2018 15:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHO6yM3vyvxZHMc6M2PdIvxMJPLqngUDGlFeemuZ/hU=;
        b=Ik9GdzVQD9DW3b2ndOpIAn/0VuOJ+l4ciocitflga/7wQGhF4I5v5pPXkXaRsG23qh
         zhXZaJdhaUPNUqAo2upNkkvjYfNb36egKA2s07F/spvGaAOFEn/UsnPjDRnE+x9RE0rp
         fs5bbJw5pZsBMdq5x00pM+92U7oDmA1QxmU8VFQ6YoX0uVVQQjT959vPELuINHxHfsdF
         LTMD0wtIN2gF9232CU+3E+DyIY857o1JbExlLoPrx1rom15rn7iGM1E+GfA6+H+3DhAY
         582nsOUk5ahuKP21s/pV8kAacrxEB8CyHf/Tdv++ncAz4WEIVO1zGrE22IN86d7Zin5H
         7eVg==
X-Gm-Message-State: AGRZ1gKgmUegvzR1opQ1dYsR2ZRCilY+o4baAYblpYopV6W8F9IETZjj
        imfnzd2xc4nAuPKFKzc/YO7yXnSABEqkIdwFPvk=
X-Google-Smtp-Source: AJdET5cBEMfU5oTwaqLC9iMjf6KIBgxZggxvjJsKfsUX68O6EsuF6g+rZakJ3ANNViBDJvp8x5A2tk8+JVbMKsOJ6LQ=
X-Received: by 2002:ab0:13ee:: with SMTP id n43mr7805030uae.20.1541283395084;
 Sat, 03 Nov 2018 15:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181102151443.758229-1-arnd@arndb.de>
In-Reply-To: <20181102151443.758229-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 3 Nov 2018 23:16:23 +0100
Message-ID: <CAMuHMdXHQSk08KMsbEQVd+wxWAqudHZuejUeBo9C-dtKEkT0PA@mail.gmail.com>
Subject: Re: [PATCH] HID: asus: fix build warning wiht CONFIG_ASUS_WMI disabled
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        Hans de Goede <hdegoede@redhat.com>,
        Colin King <colin.king@canonical.com>,
        peter.hutterer@who-t.net, mustafakuscu@gmail.com,
        Daniel Drake <drake@endlessm.com>, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 4:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> asus_wmi_evaluate_method() is an empty dummy function when CONFIG_ASUS_WMI
> is disabled, or not reachable from a built-in device driver. This leads to
> a theoretical evaluation of an uninitialized variable that the compiler
> complains about, failing to check that the hardcoded return value makes
> this an unreachable code path:
>
> In file included from include/linux/printk.h:336,
>                  from include/linux/kernel.h:14,
>                  from include/linux/list.h:9,
>                  from include/linux/dmi.h:5,
>                  from drivers/hid/hid-asus.c:29:
> drivers/hid/hid-asus.c: In function 'asus_input_configured':
> include/linux/dynamic_debug.h:135:3: error: 'value' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>    ^~~~~~~~~~~~~~~~~
> drivers/hid/hid-asus.c:359:6: note: 'value' was declared here
>   u32 value;
>       ^~~~~
>
> With an extra IS_ENABLED() check, the warning goes away.
>
> Fixes: 3b692c55e58d ("HID: asus: only support backlight when it's not driven by WMI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
