Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE23C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045232147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XxkP2qhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045232147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeKVCqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:46:50 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42022 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbeKVCqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:46:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so3561131vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTb3lq8QDiKUVgl+MQwLs3ZwKp/WHbduRJ5iDsV0Nyc=;
        b=XxkP2qhNRa4K8ZuB7YRS9yk/pkAHKkca6EztRylclrklpUpHOMRE3a7W63j1O6kZX+
         p0FVFzprXypQzdUkUO5LtxsZM8df9VhXP6ZFWuXMH3YeVKdmiuTncTf8zFB9ctn8GXwK
         9Myt+i3C6LOsBMP9/qcCrWTDhmcXu8vjQoTPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTb3lq8QDiKUVgl+MQwLs3ZwKp/WHbduRJ5iDsV0Nyc=;
        b=sY1sZyEZe6TGjXcSqQuHX5cgBXZaostqOLcg4JhcpZn5Us7b5sVfN0WhbWSXAI+RNM
         9k2VzblHkP+PVuH2yq2OLi6Yl3iU3/vC/ZM3kBW5OukBtjsWDEtvst+gI0FvWgTZtBvF
         7rZMrz2TaSUch+syZi5zj/YsLkt+JlHfSff/zRIuLZnsuSKvVBYuIP6Wxu1ki3cNsI6s
         ttQf3IcFi9Tw8F/4bdO9l0mThIYNrnkkHyJrdaLi/Fs1xq6Hftg1E9S1NjX1a1QSjhOy
         d9NMlz/4fK0xcnbhDDE3CH88B7wgwzlx5x6Li0XFmB/XRiVnt1dDN+foxgw0TPe/aXwY
         hZrQ==
X-Gm-Message-State: AGRZ1gIOX3/FPY4Ey0U2R+cJzxwp9HbJpL6czepdxYJJDSdjXMBIOJoy
        3g0GqC0ilzggNUU+TisjyeNE3pGapUo=
X-Google-Smtp-Source: AJdET5elsLT36gbJwYp2Pr6QPt80eUT3WOdFSCg3BedfJW0k7eRBm5LcB0Q7qCmfeLvsjkKQTtTp5w==
X-Received: by 2002:a67:e214:: with SMTP id g20mr3016607vsa.162.1542816704519;
        Wed, 21 Nov 2018 08:11:44 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id t10sm13874682ual.13.2018.11.21.08.11.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 08:11:44 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id v24so2087566uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:11:43 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr2953391uaj.126.1542816702786;
 Wed, 21 Nov 2018 08:11:42 -0800 (PST)
MIME-Version: 1.0
References: <153655347149.19910.4781444209586693527.stgit@Rincon.localdomain>
 <CAD=FV=Vau3KL=hqbu-jx19VvGZ5FZug+C-sxxdw2hiAtCXgBtg@mail.gmail.com> <410670D7E743164D87FA6160E7907A56013A7A9610@am04wembxa.internal.synopsys.com>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7A9610@am04wembxa.internal.synopsys.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Nov 2018 08:11:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UpPv3fWFjhrRRj1JjLPecbtzVYptVBkRaFHUgEm=isXw@mail.gmail.com>
Message-ID: <CAD=FV=UpPv3fWFjhrRRj1JjLPecbtzVYptVBkRaFHUgEm=isXw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc2: host: use hrtimer for NAK retries
To:     minas.harutyunyan@synopsys.com, Terin Stock <terin@terinstock.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe,

On Tue, Nov 20, 2018 at 11:16 PM Minas Harutyunyan
<minas.harutyunyan@synopsys.com> wrote:
>
> On 11/14/2018 3:30 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, Sep 9, 2018 at 9:24 PM Terin Stock <terin@terinstock.com> wrote:
> >>
> >> Modify the wait delay utilize the high resolution timer API to allow for
> >> more precisely scheduled callbacks.
> >>
> >> A previous commit added a 1ms retry delay after multiple consecutive
> >> NAKed transactions using jiffies. On systems with a low timer interrupt
> >> frequency, this delay may be significantly longer than specified,
> >> resulting in misbehavior with some USB devices.
> >>
> >> This scenario was reached on a Raspberry Pi 3B with a Macally FDD-USB
> >> floppy drive (identified as 0424:0fdc Standard Microsystems Corp.
> >> Floppy, based on the USB97CFDC USB FDC). With the relay delay, the drive
> >> would be unable to mount a disk, replying with NAKs until the device was
> >> reset.
> >>
> >> Using ktime, the delta between starting the timer (in dwc2_hcd_qh_add)
> >> and the callback function can be determined. With the original delay
> >> implementation, this value was consistently approximately 12ms. (output
> >> in us).
> >>
> >>      <idle>-0     [000] ..s.  1600.559974: dwc2_wait_timer_fn: wait_timer delta: 11976
> >>      <idle>-0     [000] ..s.  1600.571974: dwc2_wait_timer_fn: wait_timer delta: 11977
> >>      <idle>-0     [000] ..s.  1600.583974: dwc2_wait_timer_fn: wait_timer delta: 11976
> >>      <idle>-0     [000] ..s.  1600.595974: dwc2_wait_timer_fn: wait_timer delta: 11977
> >>
> >> After converting the relay delay to using a higher resolution timer, the
> >> delay was much closer to 1ms.
> >>
> >>      <idle>-0     [000] d.h.  1956.553017: dwc2_wait_timer_fn: wait_timer delta: 1002
> >>      <idle>-0     [000] d.h.  1956.554114: dwc2_wait_timer_fn: wait_timer delta: 1002
> >>      <idle>-0     [000] d.h.  1957.542660: dwc2_wait_timer_fn: wait_timer delta: 1004
> >>      <idle>-0     [000] d.h.  1957.543701: dwc2_wait_timer_fn: wait_timer delta: 1002
> >>
> >> The floppy drive operates properly with delays up to approximately 5ms,
> >> and sends NAKs for any delays that are longer.
> >>
> >> Fixes: 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")
> >> Signed-off-by: Terin Stock <terin@terinstock.com>
> >> ---
> >>   drivers/usb/dwc2/hcd.h       |    2 +-
> >>   drivers/usb/dwc2/hcd_queue.c |   19 ++++++++++++-------
> >>   2 files changed, 13 insertions(+), 8 deletions(-)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Cc: stable@vger.kernel.org
> >
> Acked-by: Minas Harutyunyan <hminas@synopsys.com>

It looks like Terin missed CCing you on the original patch.  I assume
you are still picking up dwc2 changes like this?  If so, should he
resend the patch targeting you (and including Minas and my tags) or do
you want to pick it up from one of the mailing lists he CCed?

Thanks!

-Doug
