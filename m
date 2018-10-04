Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C8420877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C8420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeJDTPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:15:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39354 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeJDTPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:15:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id w21-v6so6614842lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqRB+w/AR0vyqUU5bmUPsy7aaI2NxAAOv6Ilc+DdOqw=;
        b=XWVTLPP934uKWnPCT/udWTtkxL5JIOZ96alHhKHeibSlD/6lxfa5354yGNM2SRwJ50
         xSZ2GITBlct+IDMCM5dHLG5HlzroshQdDZS6Sv4Jk2OdXkjYxtt+WqBIFw2p7MCnYK8W
         cnFzUJQUv0pOgBwr7UA52EJQm4OtP24Qr/h0TmlHCPwVbsvK6aSMZ+jj/0fflXoTRdlY
         /B67z5LeNZPJpOkas22ea65KKfyK02u3c4LL7uEXdMrdJ0iJiAu+b9LrJLvDzVLAjMR/
         B1r2IDiXq61NOu6i8R/+JDAfWK5jYtqu6Jis2ib/2PmBEycyzCLiFcTfc1Qbk1I+glM6
         azGA==
X-Gm-Message-State: ABuFfojXpu+rlFCdyOLj9bTisUpZiuUETveeCb6obof7WkIu1rXXA2mS
        Ql0xRvALHUScnYoM2zHgjMO9ozdJE+iqyWRnv1Jeng==
X-Google-Smtp-Source: ACcGV610hMvj4SXVmb7oEzd1Hh292+0I7mjBndzhZt31quXVBcHfBv5CbPa/XMV6pSCbEGrcmBmXdnTuhsY/mskIzWY=
X-Received: by 2002:a19:d3c4:: with SMTP id k187-v6mr3872203lfg.101.1538655764688;
 Thu, 04 Oct 2018 05:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180907085115.30242-1-benjamin.tissoires@gmail.com> <20180908014442.GA16029@jelly>
In-Reply-To: <20180908014442.GA16029@jelly>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 4 Oct 2018 14:22:33 +0200
Message-ID: <CAO-hwJLpf0-aFRG1yhfSxJA20bw5_HTH+LcwQ9+ys4UE1YVNRw@mail.gmail.com>
Subject: Re: [PATCH] Input: reserve 2 events code because of HID
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, hcutts@chromium.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, looks like this one fell through the cracks.

On Sat, Sep 8, 2018 at 3:44 AM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> On Fri, Sep 07, 2018 at 10:51:15AM +0200, Benjamin Tissoires wrote:
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> > a duplicate is found") from the v4.18 kernel, HID used to shift the
> > event codes if a duplicate usage was found. This ended up in a situation
> > where a device would export a ton of ABS_MISC+n event codes, or a ton
> > of REL_MISC+n event codes.
> >
> > This is now fixed, however userspace needs to detect those situation.
> > Fortunately, ABS_MISC+1 was never assigned a code, and so libinput
> > can detect fake multitouch devices from genuine ones by checking is
> > ABS_MISC+1 is set.
>
> sorry, this isn't quite correct. we use ABS_MT_SLOT - 1 (0x2e) for the
> detection of fake MT devices, i.e.
>   if (ABS_MT_SLOT and not ABS_MT_SLOT-1) then multitouch

Will send a v2 ASAP.

>
> That gives you up to ABS_MISC + 6 for legitimate usage. this is handled by
> libevdev, not libinput directly. libevdev adjusts the various bits on "is
> this device an MT device" based on whether ABS_MT_SLOT-1 is set.
>
> I can change this to also check for (ABS_MISC and not ABS_MISC+1) but that
> obviously will depend on updated libraries then. Though I guess it won't
> really be an issue until we fill up the other codes up to including 0x2e
> with real values and expect userspace to handle those.

Nah, better changing the value here.

>
> None of the bits I maintain have special code for REL_MISC+n so that bit
> works fine, IMO.
>
> One request though: instead of just having the value reserved, can we make
> it REL_RESERVED and ABS_RESERVED please? Or ABS_CANARY :) Much easier than
> hardcoding the numeric value.

My first thoughts were that ABS_CANARY has the inconvenient of being
too tempting to be used as a real value.
OTOH, REL_RESERVED and ABS_RESERVED should be fine.

I'll send out a v2 with those changes.

Cheers,
Benjamin

>
> Cheers,
>    Peter
>
>
> > Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> > true high res mice from some other device in a pre-v4.18 kernel.
> >
> > Set in stone that the ABS_MISC+1 and REL_MISC+1 are reserved and should not
> > be used so userspace can properly work around those old kernels.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >
> > Hi,
> >
> > while reviewing my local tree, I realize that we might want to be able
> > to differentiate older kernels from new ones that export REL_WHEEL_HI_RES.
> >
> > I know Dmitry was against adding several REL_MISC, so I hope just moving
> > REL_WHEEL_HI_RES by one and reserving the faulty event codes would be good
> > this time.
> >
> > This patch applies on top of the branch for-4.20/logitech-highres from
> > Jiri's tree. It should go through Jiri's tree as well.
> >
> > Cheers,
> > Benjamin
> >
> >  include/uapi/linux/input-event-codes.h | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > index 29fb891ea337..30149939249a 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -708,7 +708,12 @@
> >  #define REL_DIAL             0x07
> >  #define REL_WHEEL            0x08
> >  #define REL_MISC             0x09
> > -#define REL_WHEEL_HI_RES     0x0a
> > +/*
> > + * 0x0a is reserved and should not be used.
> > + * It was used by HID as REL_MISC+1 and usersapce needs to detect if
> > + * the next REL_* event is correct or is just REL_MISC + n.
> > + */
> > +#define REL_WHEEL_HI_RES     0x0b
> >  #define REL_MAX                      0x0f
> >  #define REL_CNT                      (REL_MAX+1)
> >
> > @@ -745,6 +750,12 @@
> >
> >  #define ABS_MISC             0x28
> >
> > +/*
> > + * 0x29 is reserved and should not be used.
> > + * It was used by HID as ABS_MISC+1 and usersapce needs to detect if
> > + * the next ABS_* event is correct or is just ABS_MISC + n.
> > + */
> > +
> >  #define ABS_MT_SLOT          0x2f    /* MT slot being modified */
> >  #define ABS_MT_TOUCH_MAJOR   0x30    /* Major axis of touching ellipse */
> >  #define ABS_MT_TOUCH_MINOR   0x31    /* Minor axis (omit if circular) */
> > --
> > 2.14.3
> >
