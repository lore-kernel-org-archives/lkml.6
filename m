Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFEEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09E920873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpXVYTif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbeL1Mso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:48:44 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:33959 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbeL1Msn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:48:43 -0500
Received: by mail-lj1-f176.google.com with SMTP id u89-v6so18656139lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TB9wd4V1lU8rUWRSA3Zy0k9okpjm28MYCb8GMqiX3ZI=;
        b=UpXVYTif9qGUlbxNsDp7j8a2AYFaxKukSwnsFrvAwKQ/a9v1cPWSN4Faj/Wu0BLWbS
         Gh2oCNc5DQ63aLtyKCPQqLNKDpt0rWpKI5w6Zyo4lSnKOQslVpSzN98OEC/bXrXXcWov
         Q/9NzdqBt4vpYQCoxWgaCDUqL01Y0R1X+NtrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TB9wd4V1lU8rUWRSA3Zy0k9okpjm28MYCb8GMqiX3ZI=;
        b=AsK5gSPYQSRh6FojtEinVATLetJ6iJzp68s3y9W8DcI3Un/UrYizFb0wUy93P85GsN
         Q/o907aA2QrptJNL4AzUhjCsPQpA6gparC64/NZM6OBz6SmZR67ccviEWYmGL4Tsa++z
         7crgjvjREHdZYopT0Y2eXyGhLbPAOR/ToQwL8KW94KUYCvUJO8bcB04aRFmtv+sRH2Lm
         rffSjszGucTeBIJ+z/LYZaU2DYERAe4Q5OreeuyYpG7UIeSBikxRQzwhhe8cQf1TIMU5
         Cv2DdurcdzvrapUKr32RACm2hKwuZd/7SVm0Nz7gHcSk0xOyvtNERwS8T9i+oqlvrhfU
         Be2w==
X-Gm-Message-State: AJcUukdsDrYDaf+FNzShRSmpz+I0I2NLObO97If8iTDeicukVPIAxx/q
        48/xJsMsfpOD8UrOxRmW/aMJO77rcqMmmbwRimqk9g==
X-Google-Smtp-Source: ALg8bN6eyxe/cSRx4wcL79zouY/8C04rEZ8Y9PxGaLVRo0OjSOtSN/oHZfI8+VtITN5csA1Irm5U/3F1iV++5f0pzsg=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr10895366ljj.120.1546001321639;
 Fri, 28 Dec 2018 04:48:41 -0800 (PST)
MIME-Version: 1.0
References: <4085fc648ff5086bd6e6237d74d2a11e945a617b.camel@gmail.com>
In-Reply-To: <4085fc648ff5086bd6e6237d74d2a11e945a617b.camel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Dec 2018 13:48:29 +0100
Message-ID: <CACRpkdaDT9xZe6r3pJvYqubrvHh4+PkV8D38yYMEbv8fhdHMKQ@mail.gmail.com>
Subject: Re: Interrupt storm from pinctrl-amd on Acer AN515-42
To:     Leonard Crestez <cdleonard@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Daniel Drake <drake@endlessm.com>,
        Nitesh Kumar Agrawal <Nitesh-kumar.Agrawal@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:02 AM Leonard Crestez <cdleonard@gmail.com> wrote:

> Digging a little deeper it seems the touchpad interrupt is active on
> boot and since it's configured as "level" and no touchpad driver is
> available yet there does not seem to be any way to clear it.

I think these are called "spurious interrupts".

> I don't know how this should be handled, booting with an active enabled but
> unclearable interrupt seems like a platform bug to me. There is even an
> option to set touchpad to "basic" which does some sort of ps2 emulation
> but the IRQ issue still happens!
>
> One workaround is to explicitly disable the interrupt from the handler
> if no mapping is found; this will keep it disabled until
> amd_gpio_irq_set_type is called later.

I don't know how x86 and ACPI systems usually deal with this stuff
so I'm kind of lost. On the embedded systems that I develop on,
I would just disable all interrupts on probe() (usually writing 0x0 in
some interrupt enable register) and then they will get enabled
once consumers need them.

But I have come to understand that maybe ACPI systems are
not so happy about drivers doing things like that?

Yours,
Linus Walleij
