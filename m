Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E53EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002B020827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002B020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeJ2TEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:04:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32888 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeJ2TEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:04:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id i15-v6so8510354qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrptKfDyU25gGei8hDekoqMLYF7ix+QkUL+h8ja2Erg=;
        b=lXfKkiOox9xsiOOhnEVk+PRRxhfiBGjScz2hFCQdD3Wq+4k+hf3efb8GsFIy01v6BT
         mk1eEeUxibMdPAK36KmyAn803BaDNs/iosOa1+N9D55iX+Zqrly7VuhtOzEtNuZ11okO
         pZRIKWqgmAo1SnDs+dPsszMX6R6sJr40QgXIr0cyRWHiJGiCeuRVrxJuPXPbqE8huiLJ
         yyJFOsqfiHvJHsoB8H+dNpfE8Z8ojDvv3ewvbmrkaKjhjuFa9kALQ6Jlaw6vbe/KUh3g
         hGm9JMP/mylR1U/2jZWZEpz6A0eEwj3Epmn7qFmcufEekGxN2Yck5QUTQRO5Z60GOm69
         1XzQ==
X-Gm-Message-State: AGRZ1gJ6+MMTw62ii11wAB5WlgGYQCj05VdYlUhmtMYdCzL6JKup3VsY
        0TEegZTwBI3YQJpabshaIgLREszoxiXaSpbjz+5n8Rwj
X-Google-Smtp-Source: AJdET5cnI9y1M4/3knzn54aAlU+ylaggfx7Vh+mf6e0xAr3HQpTk7qwfaUAi1quYYC6RPbJcMyM80UemuTiTG+wxCww=
X-Received: by 2002:a0c:9927:: with SMTP id h36mr1056341qvd.171.1540808158833;
 Mon, 29 Oct 2018 03:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com> <20181028223116.GJ1882@kunai>
In-Reply-To: <20181028223116.GJ1882@kunai>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Oct 2018 11:15:47 +0100
Message-ID: <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     ckeepax@opensource.cirrus.com,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 11:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > i2c_device_remove does not clear this. When rebinding an I2C device,
> > whos IRQ provider has also been rebound this means that an IRQ mapping
> > will never be created, causing the I2C device to fail to acquire its
> > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > forcing i2c_device_probe to lookup the mapping again.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Adding Benjamin here again. Also, should there be a Fixes: tag?

Not sure if the circumstances are preventing me to think straight, but
how can you reprobe the i2c_device?
And in all cases, for the Host notify part, having the IRQ already set
shouldn't be an issue.

So for the host notify case, this patch is fine, not entirely sure
about the acpi or OF part of it.

Cheers,
Benjamin

>
> > ---
> >  drivers/i2c/i2c-core-base.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 656f0a6fe3adf..28460f6a60cc1 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -430,6 +430,8 @@ static int i2c_device_remove(struct device *dev)
> >       dev_pm_clear_wake_irq(&client->dev);
> >       device_init_wakeup(&client->dev, false);
> >
> > +     client->irq = 0;
> > +
> >       return status;
> >  }
> >
> > --
> > 2.11.0
> >
