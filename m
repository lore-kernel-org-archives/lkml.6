Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C5CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0BB2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H2G8bSQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0BB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeJ3HzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:55:06 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45544 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeJ3HzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:55:06 -0400
Received: by mail-ed1-f48.google.com with SMTP id t10-v6so8815156eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3m/fSXR2Zkns6alYVE7F3IVUX1dOWWtPIrRzAjMQdo=;
        b=H2G8bSQG5y5wH6TwDIbEFYvgHbm9W9VWT4xITkA3AMcaK7Z3sW8a6qdL0w0WXH6SRy
         PJ4g8sc7bWIecBFstbQ4ZfXZoTgrHZyuZ0TYSEnJU6pCi2Veyuz/omQ8NuyB533eJg4k
         oI2oJq7AOxa/ddDlveRPAXHI/BWpLwHRBIq6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3m/fSXR2Zkns6alYVE7F3IVUX1dOWWtPIrRzAjMQdo=;
        b=WflL/ch6aFEtYMtRfset4bx44M5SH89Zzhdqq4iWdacNBrNjNeLiWTFHWNCYpnomWK
         YUwJFF4AjOCYQmpuou/4JUuprWId8UNylIXEC7mEjN+U0YAa5hXtOYxCPj0X2trKE7Ln
         0QliNZ92u+I+eXRYj2Dch4vlAwGWdaIprswboH/d9P4uf79T2UoYTyf2+vL3qUPVLzY9
         lB3CWpX1Nskw9AuUHvlrT9BAxdgFAY+o8jmpKSX9GgSNPpZhv1BgPW2m1wBkmNNOJUj4
         iU162ErZ6zAZJ1IGWpec0wUQ0qctzboHEEYmeKphsvtAVj2FM/HaMjXlM8jGwCpd+fa+
         E0KA==
X-Gm-Message-State: AGRZ1gIfRgKVEeaE16yTAsH7uBLLmUT40qInU2URb9XUV9vWsbhBa426
        5vMwng+lBREiZ3/xCNZJlk/8hD63/uc=
X-Google-Smtp-Source: AJdET5fjcsO1UNC6q9fajCHE2KpL8C3Fc+ZkEcIsWFU4utovsBWbjk9pJ4Ec+oQqlXeIdXQlMLTlVw==
X-Received: by 2002:a50:a844:: with SMTP id j62-v6mr734958edc.71.1540854248973;
        Mon, 29 Oct 2018 16:04:08 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id v19-v6sm351683edr.65.2018.10.29.16.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:04:07 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id f1-v6so10597377wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:04:07 -0700 (PDT)
X-Received: by 2002:a1c:3c82:: with SMTP id j124-v6mr14282107wma.62.1540854246929;
 Mon, 29 Oct 2018 16:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com> <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
In-Reply-To: <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Mon, 29 Oct 2018 16:03:54 -0700
X-Gmail-Original-Message-ID: <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
Message-ID: <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
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

On Mon, 29 Oct 2018 at 15:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> That would work, yes.

OK, I'll write a patch for this. (It may be next week, though, as I
have a deadline on a separate project this week.)

> Except I think you *do* want the "reset on direction change" logic,
> because otherwise we still end up having the:
>
> > - we update remainder to -1
>
> where it now gets easier to next time go the wrong way, for no good
> reason.  So now you only need another 6/8ths the other way to get to
> within 7/8ths of -8 and scroll back.
>
> In other words, the whole "round partial scrolling" also causes that
> whole "now the other direction is closer" issue.
>
> At 7/8's it is less obviously a problem than it was at 1/2, but I
> still think it's a sign of an unstable algorithm, where changes get
> triggered too easily in the non-highres world.
>
> Also, honestly, I'm not sure I see the point. *IF* you actually scroll
> more in one direction, it doesn't matter one whit whether you pick
> 1/2, 7/8, or whole multipliers: the *next* step is still always going
> to be one whole multiplier away.
>
> So I think the whole rounding is actually misguided. I think it may
> come from the very fact that you did *not* reset the remainder on
> direction changes, so you could scroll in one direction to -3, and
> then you change direction and go a "whole" tick the other way, but now
> it's just at +5, so you think you need to round up.
>
> With the whole "reset when changing direction", I don't think the
> rounding is necessary, and I don't think it makes sense.

Resetting on direction change would certainly make complete sense in
smooth mode. The reason that I'm reluctant to do it is for clicky
mode, where we think it's important that the low-res event happen at a
consistent point in the movement between notches (the resting
positions of the wheel). For example, imagine the following scenario
with a wheel multiplier of 8 and the threshold initially at 7/8ths of
a notch:

- I scroll one notch down. The low-res event occurs just before the
wheel settles in to its notch, leaving a -1/8th remainder, and then
(on most wheels) the ratchet mechanism settles the wheel 1/8th further
into its resting position, eliminating the remainder.
- I move the wheel 3/8ths further down, then change my mind and start
scrolling upwards.

If we reset on direction change at this point, then the "zero point"
will have moved, so that we trigger the low-res movement at -4/8ths
(at the peak of resistance between the two notches) instead of at
7/8ths. If we don't reset but allow the 3/8ths remainder to be
cleared, the trigger point stays at 7/8ths. It's a minor thing, to be
sure, but we think that keeping the on-screen response consistent with
the tactile feel of the wheel is important for the user experience.

Harry Cutts
Chrome OS Touch/Input team
