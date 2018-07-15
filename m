Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F27ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB657208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TLJuNZE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB657208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeGOJeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:34:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38118 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeGOJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:34:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so13117695edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSBnDiceuphajKkOdZe19NThWzJG3pFQi9p8mSPx53k=;
        b=TLJuNZE82IeE0cX0FYcsWlu3P5BmxtJDP+oBCGqAUz6QvJE1waRkMExq2k5iXQ3Ase
         rQpNtyVdsFAegBiA4soouerLhOmaCTniLj0cI3cLiLs+9Y75/5AnJJPqLoB1FGVsLQGn
         3Ig6w0OjhihegM4RELTkwaiLtOs8f3nt9j4Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSBnDiceuphajKkOdZe19NThWzJG3pFQi9p8mSPx53k=;
        b=nlPJznGMmcDKU9ZIkHzCTi9mQOHOPkfEnW5DWHtxyXqfRTQ/PO/9TifSEiPWQB7JpO
         8/wPieVrLBjJdoSVgY4YSwFe8hwkg2jE3EgcV7w9tzYyQAaagdb2zHJ/4j9OtICMizMS
         vs1OhBO18vNoS4dOEiszmk7WfeGmUvH3trjNyIcr9V566dhVqqrCMspq7xysWVm9dVau
         AEk5VhhkpuNO0SSR6xq/pLnOAUUypy2Q5dCxEB8XiahBPZawQL/ETol4jWsfwz+u+CPK
         4BlXjTJAdlEWWVP37IWqOgFJ+vcbBUBYdHqMnvHU/W5vPpPBqRfgHkKXiZtazGBjU4cz
         ltPw==
X-Gm-Message-State: AOUpUlG5QgoFxJSsP91qwOV5ytMSvpmTAjNeDOhv4K8BGf1TX1LibbVY
        p26F/T5tHP/s5q0ILppxK6EWNwveNE4=
X-Google-Smtp-Source: AAOMgpch0IsP/VJrDlkyCe9HzbOGed7pu9VbStm+mTFOBLD1+BSvCtrrDloqCYdX56NDu80wEOYZrg==
X-Received: by 2002:a50:f577:: with SMTP id w52-v6mr13645674edm.230.1531645924025;
        Sun, 15 Jul 2018 02:12:04 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id k15-v6sm11672826edr.3.2018.07.15.02.12.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 02:12:02 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id a9-v6so6101350wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 02:12:02 -0700 (PDT)
X-Received: by 2002:a1c:3e92:: with SMTP id l140-v6mr7193674wma.134.1531645921964;
 Sun, 15 Jul 2018 02:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-12-toddpoynor@gmail.com>
 <20180715090544.GC23333@kroah.com>
In-Reply-To: <20180715090544.GC23333@kroah.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sun, 15 Jul 2018 12:11:47 +0300
X-Gmail-Original-Message-ID: <CAE_wzQ_YosCJro46uuF1v6TQhVaTaXLdiLVD7gb94BwQx00SuQ@mail.gmail.com>
Message-ID: <CAE_wzQ_YosCJro46uuF1v6TQhVaTaXLdiLVD7gb94BwQx00SuQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     toddpoynor@gmail.com, rspringer@google.com, jnjoseph@google.com,
        benchan@chromium.org, devel@driverdev.osuosl.org,
        frankhu@chromium.org, lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 12:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 13, 2018 at 10:58:09PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Always allow root to open device for writing.
> >
> > Drop special-casing of ioctl permissions for root vs. owner.
> >
> > Reported-by: Dmitry Torokhov <dtor@chromium.org>
> > Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > ---
> >  drivers/staging/gasket/apex_driver.c  |  9 +++------
> >  drivers/staging/gasket/gasket_core.c  |  8 +++++---
> >  drivers/staging/gasket/gasket_ioctl.c | 15 ++++++---------
> >  3 files changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> > index b1318482ba65..ffe11d8168ea 100644
> > --- a/drivers/staging/gasket/apex_driver.c
> > +++ b/drivers/staging/gasket/apex_driver.c
> > @@ -644,13 +644,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
> >  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
> >  {
> >       struct gasket_dev *gasket_dev = filp->private_data;
> > -     int root = capable(CAP_SYS_ADMIN);
> > -     int is_owner = gasket_dev->dev_info.ownership.is_owned &&
> > -                    current->tgid == gasket_dev->dev_info.ownership.owner;
> > +     fmode_t write;
> >
> > -     if (root || is_owner)
> > -             return 1;
> > -     return 0;
> > +     write = filp->f_mode & FMODE_WRITE;
>
> Ok, this is insane.  You don't change, or check, the permissions on a
> file handle while it is already open, as you only check the permissions
> on OPEN, not on WRITE.  See the recent rant from Linus on the linux-api
> list for yet-another-long-threaad in which he explains this.
>
> So this whole ioctl can just be removed, it is totally crazy and wrong
> and should just be removed.

No, the code checks whether the requested ioctl command is compatible
with the mode the file handle was open with. There are some ioctls
that are allowed on file handle opened for read and others that
require file handle to be opened for write. That is all. It does not
change permissions past open.

Thanks,
Dmitry
