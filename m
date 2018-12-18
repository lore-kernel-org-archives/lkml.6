Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD8A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLRKME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:12:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44898 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:12:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so17458237qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JedgdVHsWAypASpBfwEba8/iQH/2X5t/wCOQ8m85dQU=;
        b=PHUNaeZw+4LV4c32JGrcHYdZgPY64m66II2etaFfIrhR+AAt6vcAApBfX/Lbg0+gn/
         G67iAkxcYwQVLC9tSBlVIdXVdZUYz80mh9JcqkuCTuK3J76/dweUeiQ89jhGg7tsrY5y
         iU0mmCsosJ3HOwEZiwJkIxw0rf2IQ9NK/1m1RuB4na+bGaC1gU+OMXHGpLxql7jIwaId
         rAkc2ThJPvqEVNEMvb7IEy5fhpWRXOqUPYwn4qG7rdmmlC/2mu0PkeGaBHkU+neVk0Tb
         Q1GgELM8wgJHzxST2egpwLkfFnOTcAx0DoKtEQ8NvgCgCVulDIk4NAubDzvr1fusHjny
         +5GA==
X-Gm-Message-State: AA+aEWbu2N/JlPlWhQVdsmwvvo6o7OxuTAweJvCr83IPTSQlquYEvB9f
        TJ7reU2AiiD/hlTE9b8VtPw2SpoLrr9PrzzAXtVuHA==
X-Google-Smtp-Source: AFSGD/XIoVORJPslbefox2AXWdm4UdwBPGIkLFGJpaDbGWkLiVwRfBSjYmylaPQJopMo0SX2c2Jh4rXrTygYHneniXo=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr16454996qtl.343.1545127921535;
 Tue, 18 Dec 2018 02:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
 <20180907103450.13890-7-benjamin.tissoires@redhat.com> <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
In-Reply-To: <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 18 Dec 2018 11:11:50 +0100
Message-ID: <CAO-hwJKpLVyGBkopZZdePEXEo51HHqEOfzvX3BtxEt1YPhF9xg@mail.gmail.com>
Subject: Re: [PATCH 6/7] HID: logitech-hidpp: support the G700 over wireless
To:     hcutts@chromium.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

[now that the series has been reverted and re-inserted, I am starting
to have a look at this again]

On Fri, Sep 7, 2018 at 7:33 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Hi Benjamin,
>
> On Fri, 7 Sep 2018 at 03:35, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The G700 is using a non unifying receiver, so it's easy to add its support
> > in hid-logitech-hidpp now.
> > [snip]
> > @@ -3671,6 +3671,9 @@ static const struct hid_device_id hidpp_devices[] = {
> >         { /* Solar Keyboard Logitech K750 */
> >           LDJ_DEVICE(0x4002),
> >           .driver_data = HIDPP_QUIRK_CLASS_K750 },
> > +       { /* G700 over Wireless */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
> > +         .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
>
> As someone who's new to the codebase, it seems rather confusing to me
> that HIDPP_QUIRK_UNIFYING would be present here for a device that
> doesn't use a Unifying receiver. Am I misunderstanding, or should we
> consider renaming the quirk or adding some clarifying comment?
> (Similarly for the G900 in the next patch.)

The initial reason is that the gaming receivers are Unifying but that
are not normally allowed to connect to more that one device at a time.
The reason is that those receiver are using a higher frequency and
need all of the bandwidth to operate (so they can't multiplex the
devices).

But as I re-read the series, it is clear that HIDPP_QUIRK_RECEIVER and
HIDPP_QUIRK_UNIFYING are never used separately, so it doesn't make
sense to have 2 quirks. We should probably rename UNIFYING into
RECEIVER for consistency and we will be good.

Cheers,
Benjamin

>
> >
> >         { LDJ_DEVICE(HID_ANY_ID) },
> >
> > --
> > 2.14.3
> >
>
> Thanks,
>
> Harry Cutts
> Chrome OS Touch/Input team
