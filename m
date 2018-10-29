Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F53C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73122080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mE3giW1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73122080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbeJ3EH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:07:29 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43506 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJ3EH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:07:29 -0400
Received: by mail-ed1-f48.google.com with SMTP id y20-v6so8338203eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZnP8R4xBH4YY0qsa5R+ZxHVpJTmCXgjqcES8jMRwBo=;
        b=mE3giW1xXnXtw6XDhYjjWMYIRDwG/vVpJDwBj8LzSdFR2uKWAjk9zzsHoUAb4wgep2
         3ZSLGH06DGJEYIN+m6tFTXmXpX26AS/XUAM2HfikUdG5EFLG4+3U1FZQmfCuAlIvBTAB
         JZMT+CyzkuNn5zlGUlg89t+UIWWtZKPcDmslU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZnP8R4xBH4YY0qsa5R+ZxHVpJTmCXgjqcES8jMRwBo=;
        b=lHUma4lx3ytS+YHp8ZkrC2pPtjkXx2zqPtj2G+uSq7j2Z/D4yC5UxAu3fCHa8GyKgn
         63qmro4oHXd49+0Hf03Ah4HJfE4bKm5uxD+/v/r+Pb9x5KTgw32pV43SVFjIw+88CVCz
         diGLQ9XQXVFlUAj0Qn1XHddoeI0TdyA9Q4RMsg0x48MDfRyG141JOufsb+2VwQfnCnFI
         Bda3+YMaRHKxwCZOHubLYgzB/F6gbNBWg8U2fbnIcDt7Qv4m59MAB7Voobv8wolhKSr1
         lF6svrLrpx0V5fjnK3XDWdHscgCpYvvgNDZ6BIvfxarFwyiwCOJ3kOlVqUhNMkDTB7Rc
         SUZg==
X-Gm-Message-State: AGRZ1gJQr5yHJ4PNeBdYqZr5kRirgSD9Hp+3XfmeqdxE6XwIh27mRxgs
        YnEFUvdxxzWXIcwjnG8cMw9DT5XV1CI=
X-Google-Smtp-Source: AJdET5dKdPGK0a3tElOZKWaYBpXcJlXcnxIMIlsamZG68fb5RsDD2iWtPMkRH9IdWpPFajNcd2mJcQ==
X-Received: by 2002:a17:906:5249:: with SMTP id y9-v6mr11589771ejm.139.1540840646665;
        Mon, 29 Oct 2018 12:17:26 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id i33-v6sm1550216edc.81.2018.10.29.12.17.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:17:25 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id u1-v6so9988825wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:17:25 -0700 (PDT)
X-Received: by 2002:adf:f1cd:: with SMTP id z13-v6mr9014958wro.79.1540840644664;
 Mon, 29 Oct 2018 12:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
In-Reply-To: <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Mon, 29 Oct 2018 12:17:12 -0700
X-Gmail-Original-Message-ID: <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
Message-ID: <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     torvalds@linux-foundation.org
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I explained in the comments, the reason for triggering at the half
multiplier point and then setting a negative remainder is to cater for
wheels that sometimes rest just before they complete a whole "notch"
in clicky mode. On those mice, setting the threshold at a full notch
means that you frequently have to move the wheel a little past its
resting point to trigger the low-res scroll event.

I don't really understand why the half-multiplier thing would cause
the instability; there's still a low-res threshold every 8 high-res
units whichever way you do it, it's just that with the half-multiplier
method it's 4 closer to the point where the wheel was when the device
was connected. Once you've scrolled around a bit in smooth mode that
should be irrelevant, unless you're somehow managing to move the wheel
in whole-notch increments without the help of the ratchet.

Maybe the long-term solution is to use more than just the value of the
current scroll event when deciding whether to send a low-res event. In
the meantime, I'll write a patch putting the threshold at 7/8ths of a
notch, to see if that can solve both issues.

Thanks,

Harry Cutts
Chrome OS Touch/Input team
Harry Cutts
Chrome OS Touch/Input team


On Mon, 29 Oct 2018 at 11:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 29, 2018 at 8:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Patch I'm using attached. I'm inclined to just commit it, but if
> > somebody has a better idea, I can test alternatives too.
>
> I committed my patch, as it at least makes the scroll wheel usable.
>
> I'm more than open to further improvements, but I wasn't willing to
> live with the status quo, and carrying this around in my tree as a
> patch kept confusing me while doing merges whenever a conflict
> happened (because the "git diff" that I use to see the conflicts
> obviously also showed my own local modifications).
>
>                  Linus
