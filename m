Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAD22086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lUaRnymp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAD22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeK1KeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:34:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40618 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeK1KeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:34:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so17912936lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u8Qa23mst4Sz38+h7zjLaZoJ85hMOoBaV9mNX30Wyk=;
        b=lUaRnymp13YkyPwA3Z7qECqAfMHOiVjgyotjnY7JYVVixs+WcYwkGf5I1SlVVQ6rLG
         aCsXZXLESsaEAlOkQJXDJjs+H7srnphipZY6GJhYtODaxsJHmREBVZEgcLfVbNKvn5PU
         JvjZNBurn94I3Pl3/f17id8YcDYCsgz3necn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u8Qa23mst4Sz38+h7zjLaZoJ85hMOoBaV9mNX30Wyk=;
        b=aNalzSaTnyMXa96Gk1fgOP/hk0rx9fkY3xtITh2VQ3ZytZC+4TrT2+xN/sginoSf4M
         puRW3DOqV1ZEnn4Js7I4vg/zm+S+yAQYqzur9W8wHS0w16s5G389/Mguxtz238Ckj1Oy
         +3KZIfPi7fFWlAkGs/lP8641L176paGzDWn3J3/xYQuJ5GSRZIdDFRb7qIJYILxBn+8t
         XTvmZjbubw83ebYr4WzdQaHr0u/wh005UR7KF/U5XwV+i54grSh1LARBqTWqB3pOcPPH
         1NMfKECD1AZcQUjBI9OdHzKH2yUOlSSQyO8+V7mONyRmpACxBsVtPZh+tXSXNtWCeIaD
         kTmA==
X-Gm-Message-State: AGRZ1gJkTLQO4abpVJ0EwjtjHb0VYtpdgM34CmAoFe7HAFr31G/PyQBx
        94OflkqO0lFlRs2IeSuTrl9xSyIWZrU=
X-Google-Smtp-Source: AJdET5dOGje6roIK9gkSWAujIZPceTrnBEI45LTHzVm7FXssaKMAe8gNNXvYqwVwfC2ZoaqQAwGKvQ==
X-Received: by 2002:a19:978c:: with SMTP id z134mr21413791lfd.109.1543361681943;
        Tue, 27 Nov 2018 15:34:41 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v5-v6sm850025lje.78.2018.11.27.15.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 15:34:41 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id s5-v6so21674242ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:34:40 -0800 (PST)
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr20802649lji.167.1543361680426;
 Tue, 27 Nov 2018 15:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
 <CAE=gft5XZD-GQYwcv4YWHrDSWRqT7SDpWXzv7c6MKAAH7uGr2Q@mail.gmail.com> <CACVXFVN63UDefvBnYTQ==tWwYqGJbCS_HK==-1jVa5sVc=-Upw@mail.gmail.com>
In-Reply-To: <CACVXFVN63UDefvBnYTQ==tWwYqGJbCS_HK==-1jVa5sVc=-Upw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 27 Nov 2018 15:34:04 -0800
X-Gmail-Original-Message-ID: <CAE=gft55MVc7JGJw427VByihrgw1yYDFYCxuqUOh4xm5P4ZoAA@mail.gmail.com>
Message-ID: <CAE=gft55MVc7JGJw427VByihrgw1yYDFYCxuqUOh4xm5P4ZoAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     tom.leiming@gmail.com
Cc:     axboe@kernel.dk, Gwendal Grignou <gwendal@chromium.org>,
        asavery@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Mon, Nov 26, 2018 at 6:55 PM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Tue, Nov 27, 2018 at 2:55 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Tue, Oct 30, 2018 at 4:06 PM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > If the backing device for a loop device is a block device,
>
> This shouldn't be a very common use case wrt. loop.

Yeah, I'm starting to gather that. Or maybe I'm just the first one to
mention it on the kernel lists ;) We've used this in our Chrome OS
installer, I believe for many years. Gwendal piped in with a few
reasons we do it this way on the cover letter, but in general I think
it allows us to have a unified set of functions to install to a file,
disk, or prepare an image that may have a different block size than
those on the running system.

>
> > > then mirror the discard properties of the underlying block
> > > device into the loop device. While in there, differentiate
> > > between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> > > different for block devices, but which the loop device had
> > > just been lumping together.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > Any thoughts on this patch? This fixes issues for us when using a loop
> > device backed by a block device, where we see many logs like:
> >
> > [  372.767286] print_req_error: I/O error, dev loop5, sector 88125696
>
> Seems not see any explanation about this IO error and the fix in your patch.
> Could you describe it a bit more?

Sure, I probably should have included more context with the series.

The loop device always reports that it supports discard, by setting up
the max_discard_sectors and max_write_zeroes_sectors in the blk queue.
When the loop device gets a discard or write-zeroes request, it turns
around and calls fallocate on the underlying device with the
PUNCH_HOLE flag. This makes sense when you're backed by a file and
hoping to just deallocate the space, but may fail when you're backed
by a block device that doesn't support discard, or doesn't write
zeroes to discarded sectors. Weirdly, lo_discard already had some code
for preserving EOPNOTSUPP, but then later the error is smashed into
EIO. Patch 1 pipes out EOPNOTSUPP properly, so it doesn't get squashed
into EIO.

Patch 2 reflects the discard characteristics of the underlying device
into the loop device. That way, if you're backed by a file or a block
device that does support discard, everything works great, and user
mode can even see and use the correct discard and write zero
granularities. If you're backed by a block device that does not
support discard, this is exposed to user mode, which then usually
avoids calling fallocate, and doesn't feel betrayed that their
requests are unexpectedly failing.

-Evan
