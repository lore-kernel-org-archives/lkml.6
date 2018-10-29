Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05DFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648D320824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BGz0yKKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648D320824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJ3Gda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:33:30 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46853 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeJ3Gda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:33:30 -0400
Received: by mail-ed1-f50.google.com with SMTP id v18-v6so8668850edq.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbRB6Qt/mFqkheWmWKwC5+fpTqzRBevU9KCWKLXWBJU=;
        b=BGz0yKKrDIUL856n5CBCNpbdomDgKQLNCwOAXKRLpBq6R85QyMQUJnL5K1ch0NPYT8
         fqLaFxQnB/LPFWWzl21O6IkQYzATkIwDoFHsQ9fkTI2TaK8MivYie63IDcLtSF2JT2qz
         R0sHPmsPWah9U2VmUaZd0LmVDn42nI8asLHgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbRB6Qt/mFqkheWmWKwC5+fpTqzRBevU9KCWKLXWBJU=;
        b=QMdkClVoBqvLPUhQ9Eyup2oNmORzVFlbnL/15dPRnd0OpPfCgounZuaKzyXi/UWctV
         2IoY/Y+hkZqHdQ6H5nlcKavtjN0+uHh/TPChOroyxIzBMk0p1EG9bfTHAzLDTp7ngKkn
         eOjaD4InnjekG9eV1+uHU0wobdHEpcx2bXCvaQi91VSXkjF5ACLmoKgeDJ/TD0oQY1gP
         ZKHHJ8SFk2TprVFmKBnnyQeg8cLeqVK/vfYOsVqmc7qMDcfGf42DJgr3bVW3glEM2dIS
         nkYPpnpVhcTnns01gc9wrdahBVIm5iR5THvvm4HvumPep9ewbxIvqGC66JCPeAxm1rtP
         QJWA==
X-Gm-Message-State: AGRZ1gKix/7awOdpzA8uirED1oAh+P0QM0nzvjQOjvMsfuwdMZpSFocd
        TJRi4h5JmL+SRGV65hd6YnWP5nvx6Ro=
X-Google-Smtp-Source: AJdET5dC/4wZsTCYG6Kh8mVp+U/G7H4vn+JTHiCWH19jmi841H24pVLEjBUtn0ztBoU2PxNX2CKgUw==
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr5561345ejq.19.1540849376517;
        Mon, 29 Oct 2018 14:42:56 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3901360ejf.27.2018.10.29.14.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:42:55 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id y144-v6so9398753wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:42:54 -0700 (PDT)
X-Received: by 2002:a1c:7818:: with SMTP id t24-v6mr5911577wmc.99.1540849374463;
 Mon, 29 Oct 2018 14:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com> <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
In-Reply-To: <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Mon, 29 Oct 2018 14:42:42 -0700
X-Gmail-Original-Message-ID: <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
Message-ID: <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
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

On Mon, 29 Oct 2018 at 14:12, Linus Torvalds <torvalds@linux-foundation.org>
> So what the half-multiplier did, assuming a multiplier of 8 (which is
> what my MX Anywhere 2S reports) would be:
>
>  - remainder starts at 3
>  - high-res is +1
>  - now remainder is 3+1, and it triggers the >= half logic
>  - 4/8 is 0, but then the code added 1 because high-res was positive,
> so the code decides to add 1
>  - the code does a wheel update of 1, and updates remainder with -8,
> so now it's -4
>
> Next time around, if the high-res update is 0 or -1, it will go the
> other direction. And then it will oscillate.
>
> Notice how tiny movements of +1/-1 in the *high-res* count can
> translate into +1/-1 in the regular wheel movement.

Ah, I see what you mean. So, if we move the threshold to (multiplier -
1)/multiplier (7/8) in this case, I think the equivalent scenario
would be:

- remainder starts at 7
- high-res is +1
- remainder is now 7+1, triggering a low-res update
- 7/8 is 0, but we add one to the remainder in the check making it (7+1)/8 == 1
- we update remainder to -1

This way we're still at least 7/8ths of a notch from the threshold in
either direction, so we shouldn't get the oscillation problem. Does
that sound reasonable, or do you think I've missed something?

> I do not believe that you actually ever *used* that code, or if you
> did, you only did so with applications that were high-res aware and
> ignored the regular wheel entirely because you were testing in an
> environment with other changes than just the kernel.

I tested these changes with 5 different Logitech mice (see the
Logitech high-res support patch [0] for details), and did so mainly
with applications that were *not* high-res aware, using a mix of
clicky and smooth modes. Admittedly the MX Anywhere 2S was not one of
my test devices; I had assumed that its behaviour would be
sufficiently similar to that of the MX Anywhere 2 and the MX Master
2S.

Harry Cutts
Chrome OS Touch/Input team

[0]: https://patchwork.kernel.org/patch/10582935/
