Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC065C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE42205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE42205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ3X2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:28:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42799 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3X2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:28:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id u68so3400063qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sDRN6IPWQ3x7HrGoo2fr8elXUd6LLxUE4O0TljxdAc=;
        b=C2aWaU984rFSmUZQ1Dw4DELER6HEfEQqIppteB7SNorGk0Z0H+4uVFdgrlD8sale2P
         8KZ3/rRa9siD1n/VOOwLwZDfiBXycDtlMqSItCcbXy8Fd53vOTfR592FO7tGD8J6zBus
         xwLg+cFhv3uRyYldL0VvXjurfd0hku423n00WAMpQgL4Q1D4W5WtRZS1f1PofYV9tqcL
         G277QLYknUoB+ysF9T7g9cCmYiMTI6n51t7DRclI12NFjao9HTYwe6RSaXmQwaXlWsJl
         4L+ExJ+DUvZMAoffxnTHjNmz0d20O/etjcYfncnLWf0Nkb2eSQTSXhkHzXcNYDDgC/cu
         VAuA==
X-Gm-Message-State: AGRZ1gK6/V9EOtVlOX6DQkUeQPVs1IN5L+kiGxbwp3TzpZEg5OwUGr2Z
        2fbaJP3li1agBdIJgO1vYVesPnl1pBnwdmhP8VXjS/fT
X-Google-Smtp-Source: AJdET5emfthXdVfDI3qBvqqrLRYT2Q9CSvCgxo3mp8wXFy9hZI3yeYfcmXFVeKclXugE1z+rTJawqmjn5XMHBlWD5Ow=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr639438qkm.343.1540910103230;
 Tue, 30 Oct 2018 07:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com> <20181028223116.GJ1882@kunai>
 <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com> <20181030115120.GI16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181030115120.GI16508@imbe.wolfsonmicro.main>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 30 Oct 2018 15:34:51 +0100
Message-ID: <CAO-hwJ+B5iUpbUamsCfNKGwxJMM9fNBUnrb2-csn1VpNG58KBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
To:     ckeepax@opensource.cirrus.com
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:51 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Mon, Oct 29, 2018 at 11:15:47AM +0100, Benjamin Tissoires wrote:
> > On Sun, Oct 28, 2018 at 11:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > > On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > > > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > > > i2c_device_remove does not clear this. When rebinding an I2C device,
> > > > whos IRQ provider has also been rebound this means that an IRQ mapping
> > > > will never be created, causing the I2C device to fail to acquire its
> > > > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > > > forcing i2c_device_probe to lookup the mapping again.
> > > >
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > >
> > > Adding Benjamin here again. Also, should there be a Fixes: tag?
> >
> > Not sure if the circumstances are preventing me to think straight, but
> > how can you reprobe the i2c_device?
>
> You just head into /sys/bus/i2c/drivers/<the_driver> and use the
> unbind file to remove the driver. You can then probe the driver
> again using the bind file.

Right... not sure why I haven't seen that one yesterday

>
> > And in all cases, for the Host notify part, having the IRQ already set
> > shouldn't be an issue.
>
> To be clear this isn't a theoretical issue this is something I
> can replicate very easily. The problem comes in when you unbind
> both the I2C device and the device that is providing its IRQ. In
> my case the I2C device is a speaker amp and the device providing
> IRQs is an audio CODEC.
>
> When the device providing the IRQ is unbound it will delete the
> IRQ mapping. For the I2C device to acquire its IRQ something
> needs to recreate that mapping, this would normally happen (in a
> DT system) as a result of the of_irq_get/_by_name. But as
> client->irq is already set this doesn't happen, causing the I2C
> device to fail probe because it couldn't locate its IRQ.

Right. I completely missed the fact that the driver of the IRQ could
be reset during the period the device is unbound.
That's a pretty strong case for this patch.

>
> I can provide some stack traces or something if that would help
> to clarify the issue?

No, that's fine. Now I get this, and I totally agree with the approach:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
