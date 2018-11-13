Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9FDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A182175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekcDmAoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A182175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbeKNJbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:31:13 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41247 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbeKNJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:31:12 -0500
Received: by mail-ua1-f68.google.com with SMTP id z24so5024813ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSl08CpHqyNl9HgnaeTlJH+PYcieMmMfFHyS+B+vW3A=;
        b=ekcDmAozpGbnYjyPtbfmYi9u9No814D1bCxSFqLNV7nXmpZqksi9+Jz7WED1ung+wZ
         2g/fYfXpNPtjemZhoB+l+upk2K5Btdw38zvu2CWh4LLsr2LWHx1zHVhOPrFTauk6ygX1
         YaYaqbzMrnN/7ZmD8D2RC4/Vh4CzKOrda07dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSl08CpHqyNl9HgnaeTlJH+PYcieMmMfFHyS+B+vW3A=;
        b=cUIqAg8DHTnc8ciTgs0aqEmBKW++eTW/9WdhWx0mXkxRuB9sWeYE4blPEwhqyR0Z2D
         tNC7CG4DxOxGZXkd6IjlSonKEctK/Jci3yJ/MtKji22Kn0CCLq0PK1sXXqZCUZ04iTEh
         v/RUbQkw87chxQPMmedTtpzHYqqtlwAH54oZmaxXpHG+36fQ4b2af4hIE2Kzdmd6OIrZ
         qfQbTNZIYyRcnSlV64tjohTXIsnP4GliS06VrfTpNQiG3OApUtP2cSy85AyIaIuz/MD5
         XRt1+RM3+gs7mxqwFvhU8OQ9ca5XGjGTfSQsWPwr/UJW3o7IMzmKInRk4LCA7J0a9m+K
         mg6g==
X-Gm-Message-State: AGRZ1gKlmOt6gubiRyUMbr3Oj7Olho376NoJwrv/rkx4HmH3JP2DziwY
        HhrJU39Ytiha3co18MV5SAkIinPTGD0=
X-Google-Smtp-Source: AJdET5fgG4hD7HojYMuOzIXEQxpybJltfJWc2TfOyLkb6cm7D6KjPK27Ypc4fYZ1mKtCYgyxGiRZ4w==
X-Received: by 2002:ab0:2314:: with SMTP id a20mr3367019uao.130.1542151837710;
        Tue, 13 Nov 2018 15:30:37 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id j25sm2300190uag.8.2018.11.13.15.30.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 15:30:36 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id g68so8410963vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:30:36 -0800 (PST)
X-Received: by 2002:a67:7993:: with SMTP id u141mr3413984vsc.119.1542151836080;
 Tue, 13 Nov 2018 15:30:36 -0800 (PST)
MIME-Version: 1.0
References: <153655347149.19910.4781444209586693527.stgit@Rincon.localdomain>
In-Reply-To: <153655347149.19910.4781444209586693527.stgit@Rincon.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Nov 2018 15:30:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vau3KL=hqbu-jx19VvGZ5FZug+C-sxxdw2hiAtCXgBtg@mail.gmail.com>
Message-ID: <CAD=FV=Vau3KL=hqbu-jx19VvGZ5FZug+C-sxxdw2hiAtCXgBtg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc2: host: use hrtimer for NAK retries
To:     Terin Stock <terin@terinstock.com>
Cc:     linux-usb@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 9, 2018 at 9:24 PM Terin Stock <terin@terinstock.com> wrote:
>
> Modify the wait delay utilize the high resolution timer API to allow for
> more precisely scheduled callbacks.
>
> A previous commit added a 1ms retry delay after multiple consecutive
> NAKed transactions using jiffies. On systems with a low timer interrupt
> frequency, this delay may be significantly longer than specified,
> resulting in misbehavior with some USB devices.
>
> This scenario was reached on a Raspberry Pi 3B with a Macally FDD-USB
> floppy drive (identified as 0424:0fdc Standard Microsystems Corp.
> Floppy, based on the USB97CFDC USB FDC). With the relay delay, the drive
> would be unable to mount a disk, replying with NAKs until the device was
> reset.
>
> Using ktime, the delta between starting the timer (in dwc2_hcd_qh_add)
> and the callback function can be determined. With the original delay
> implementation, this value was consistently approximately 12ms. (output
> in us).
>
>     <idle>-0     [000] ..s.  1600.559974: dwc2_wait_timer_fn: wait_timer delta: 11976
>     <idle>-0     [000] ..s.  1600.571974: dwc2_wait_timer_fn: wait_timer delta: 11977
>     <idle>-0     [000] ..s.  1600.583974: dwc2_wait_timer_fn: wait_timer delta: 11976
>     <idle>-0     [000] ..s.  1600.595974: dwc2_wait_timer_fn: wait_timer delta: 11977
>
> After converting the relay delay to using a higher resolution timer, the
> delay was much closer to 1ms.
>
>     <idle>-0     [000] d.h.  1956.553017: dwc2_wait_timer_fn: wait_timer delta: 1002
>     <idle>-0     [000] d.h.  1956.554114: dwc2_wait_timer_fn: wait_timer delta: 1002
>     <idle>-0     [000] d.h.  1957.542660: dwc2_wait_timer_fn: wait_timer delta: 1004
>     <idle>-0     [000] d.h.  1957.543701: dwc2_wait_timer_fn: wait_timer delta: 1002
>
> The floppy drive operates properly with delays up to approximately 5ms,
> and sends NAKs for any delays that are longer.
>
> Fixes: 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")
> Signed-off-by: Terin Stock <terin@terinstock.com>
> ---
>  drivers/usb/dwc2/hcd.h       |    2 +-
>  drivers/usb/dwc2/hcd_queue.c |   19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org
