Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D577205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZUt8Y6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D577205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeHaAmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:42:10 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:34012 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaAmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:42:10 -0400
Received: by mail-ua1-f52.google.com with SMTP id r15-v6so6609307uao.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SA4MdS6wVA5+R3mah7FdJJcHLQQWBsDw+bb43/kmAak=;
        b=mZUt8Y6ueRllyEl2aPEcsWbwMlBs8lvpEN2/E6xJs+DQcEeVsDmoPYgGpUJLCPL3hF
         gaJTskz4XMVuCaIz6kF1scwf191+Gu7B4F4ijBGoyTqzbjjeaRCpHYSs7qUSZWVXsh85
         Aapz2tOq8HATfwcmpRwBmjc0c1mynuyoBSifM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SA4MdS6wVA5+R3mah7FdJJcHLQQWBsDw+bb43/kmAak=;
        b=lmkqvegeFvCgeZ3e/MVZ7tvq/SsCI5ATUE/7L/eEDjr/FxoURijsqHg4nqZ5nMWt+l
         xBtFs++eu7zyiGvzYjXp5ZjSAU1jxPxUy6NaNkcVRnBmh4vgcZECS+Mfk4VDEY9GFW10
         etNXboZamxX2PE4ruB7Y+fvIGPwq/nCc09SggNXXP19hdvhzfTi28gEdgx1QZViYeEKm
         uGR04CJuQoGexS0lvE+prW8tPMK8YklU0F1vtL0WLWSjZZJ1HAnYh5ip+ohF8upqpk3l
         lpQJYhjBtIDwJ+6GAJrNLKNIQya2rb/0FTgZv/cb7YXiSE3pl0g75bVdq8ujoVqh8JWP
         WJXw==
X-Gm-Message-State: APzg51DziNXlCEuQOtAnO/AF9Jm51eGZ1AAkWvx2a00UZvwLR0RSo/8Z
        Unu2qtyOkq1hnlIcu9lCGyxI4SfCdPBL8w==
X-Google-Smtp-Source: ANB0VdbZiaqD0Apv84MK3wosysY3oU1awj9P7jnOOZIPnqMZBOLlw2bUp7viz3KAccSDfLq9gqGTuw==
X-Received: by 2002:ab0:7558:: with SMTP id k24-v6mr7646201uaq.170.1535661491840;
        Thu, 30 Aug 2018 13:38:11 -0700 (PDT)
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com. [209.85.213.54])
        by smtp.gmail.com with ESMTPSA id 36-v6sm1905348uas.43.2018.08.30.13.38.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:38:11 -0700 (PDT)
Received: by mail-vk0-f54.google.com with SMTP id s17-v6so4727468vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:38:10 -0700 (PDT)
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr7798823vkd.132.1535661490536;
 Thu, 30 Aug 2018 13:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-4-hcutts@chromium.org>
 <CAO-hwJ+rR8ft96AGjoEApr1ZkythKfcxjVzdULzgpRy-aRv_vg@mail.gmail.com>
 <CA+jURcvguwXAVnpQ9+84QQOaJG74oeV8U4zzM1X0UabaY5DJBQ@mail.gmail.com> <CAO-hwJ+tb6XdEM76r0jxBfCx2r_PqQp9T5=A2ALociyHOKUeMg@mail.gmail.com>
In-Reply-To: <CAO-hwJ+tb6XdEM76r0jxBfCx2r_PqQp9T5=A2ALociyHOKUeMg@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 30 Aug 2018 13:37:58 -0700
X-Gmail-Original-Message-ID: <CA+jURcsDJbL_3aF7wE0MQ_6ZSVV3Aba-tUDX-f=1+y+LBhqmng@mail.gmail.com>
Message-ID: <CA+jURcsDJbL_3aF7wE0MQ_6ZSVV3Aba-tUDX-f=1+y+LBhqmng@mail.gmail.com>
Subject: Re: [PATCH 3/3] Enable high-resolution scrolling on Logitech mice
To:     benjamin.tissoires@redhat.com
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, 30 Aug 2018 at 00:18, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>> On Thu, Aug 30, 2018 at 1:06 AM Harry Cutts <hcutts@chromium.org> wrote:
> > > The conversion input_report_rel(... REL_WHEEL,...) to
> > > hid_scroll_counter_handle_scroll() should be dealt in a separate
> > > patch.
> >
> > OK, I'll do that in v2, but might I ask why? I don't see how this
> > particular hunk is special.
>
> I tend to consider that existing code rewrite need to be in their
> special commit, especially if the change isn't supposed to change the
> behaviour. This is my personal taste in case something goes wrong and
> (in this case) a m560 suddenly starts complaining about an issue with
> this mouse.
> I wouldn't mind too much if you rather keep the
> hid_scroll_counter_handle_scroll() introduction to this commit though.

Yes, I see the reasoning for that, but this hunk is pretty tied to the
main change in that scrolling on the M560 would be 8x too fast without
it. I'll keep it in the same one, if you don't mind.

> > [snip]
> > Yes, it seems to work fine without it (at least for the MX Master 2S).
> > Unfortunately, while testing this I encountered a bug with high-res
> > scrolling over Bluetooth. (It seems that if you turn off the MX Master
> > 2S while it's connected over Bluetooth, we don't detect that and
> > remove the input device, meaning that when it reconnects the driver
> > thinks it's in high-res mode but the mouse is in low-res.) I'm
> > investigating, but in the meantime I'll remove the Bluetooth support
> > from v2 and add it back in later.
>
> As far as I can see, the MX Master 2S is connected over BLE. Bluez
> keeps the uhid node opened (and thus the existing bluetooth HID
> device) to be able to reconnect faster.
> I would suppose you should get notified in the connect event of a
> reconnection, but it doesn't seem to be the case.
>
> Nestor, is there any event emitted by the mouse when it gets
> reconnected over BLE or is that a bluez issue?

Ah, interesting. The MX Master 2S is indeed using BLE, and testing
with another Logitech BLE mouse (the M585) also leaves the input
device around. I think this is something Logitech-specific, though, as
the Microsoft Surface Precision mouse (also BLE) does have its input
device removed when it turns off. I notice that btmon does show
"device disconnected" and "device connected" events when I turn the
M585 on and off; maybe we need to plumb those through to the driver.
We've decided to delay Bluetooth support for high-res scrolling until
the Chrome OS Bluetooth stack is more stable.

Harry Cutts
Chrome OS Touch/Input team
