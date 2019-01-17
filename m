Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F91C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9334320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfAQIGX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:06:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41161 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfAQIGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:06:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so10369780qtf.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qmIHC5eao7Ug/guLsv7lcO5haNnntIRBhCPpoyV5/g8=;
        b=RxgIq09NlZOIgmO+FLexODW+mc9qC5bTc1xHwRY8QL+HT1biqzESHPeXjBQi+enqqb
         yCriHcD7Ww3fmmhHgqqPChP6eSdGLQE6Dj6klqfSuctQEsDmhCKqWNqs5htMl5EkX1JX
         CrWQPf/sYtrmY699Gx+VFrtTcfx4c+XsBEPItt8lRUW4qstjNsuuHP4RM5BMuou3IkZj
         khLkycHMPEE3rQFFOmmwuhH8++5iZC4U/MUoMXTURixY+kUOIOU5q0MyoYOz5O/Tg5Ed
         v7hYCHecBMpQRgyqUe7OlU6h5vK5DH0YqMOI2i+YFEIPr9Qerv/ZeLrWK0jgJL5R+gn7
         yqVA==
X-Gm-Message-State: AJcUukdBRFXhcrVcJe97GLjXvrV+kT+NJpEg5MwHOLpTl8bdNPoHwzoz
        XO6ed/L90jf060ZSpzG6OnyjIQbKLkamBmGb/k3Bog==
X-Google-Smtp-Source: ALg8bN5Nw25QGKW0A1c/h4k3WwQXcO3YHa/+9wYMlYog95TBY/Bg4VzLVIw3v6m6NYdngTnwOlC+wEBvAoOvASV65QM=
X-Received: by 2002:ac8:1a08:: with SMTP id v8mr10160840qtj.362.1547712379448;
 Thu, 17 Jan 2019 00:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm> <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
 <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
In-Reply-To: <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 17 Jan 2019 09:06:07 +0100
Message-ID: <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 6:02 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Jan 16, 2019, at 16:21, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> >
> >
> >> On Jan 14, 2019, at 19:18, Jiri Kosina <jikos@kernel.org> wrote:
> >>
> >> On Mon, 14 Jan 2019, Kai-Heng Feng wrote:
> >>
> >>> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
> >>> but there's no input event from HID subsystem.
> >>>
> >>> Turns out it reports some invalid data:
> >>> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
> >>>
> >>> After some trial and error, it's another device that doesn't work well
> >>> with ON/SLEEP commands. Disable runtime PM to fix the issue.
> >>
> >> Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am
> >> wondering though we are we seeing these at all - do other OSes not do the
> >> runtime PM on i2c at all?
> >
> > According to the vendor, Windows does use ON/SLEEP, but infrequently.
> >
> > We can use pm_runtime_use_autosuspend() to reduce the frequency of
> > ON/SLEEP commands, but it’s just papering over the touchpad firmware
> > bug.
>
> Goodix says the firmware needs at least 60ms to fully respond ON and
> SLEEP command.

I was about to say that this is not conformant to the specification.
But looking at 7.2.8 SET_POWER of
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)

They say:
"The DEVICE must ensure that it transitions to the HOST specified
Power State in under 1 second. "
But in the RESPONSE paragraph: "The DEVICE shall not respond back
after receiving the command. The DEVICE is mandated to enter that
power state imminently."

My interpretation was always that the device has to be in a ready
state for new commands "immediately".
However, the first sentence may suggest that the driver would block
any command to the device before the 1 second timestamp.

>
> I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
> touchpanels.

We already have a I2C_HID_QUIRK_DELAY_AFTER_SLEEP quirk that delay
operations after sleep by 20ms. Maybe we can keep the runtime PM but
use the same timers to not confuse the hardware.

Cheers,
Benjamin
