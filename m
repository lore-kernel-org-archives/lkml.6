Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B252CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585B5208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJumkcX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585B5208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeGOKPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:15:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43150 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeGOKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:15:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so2224955edt.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgrugwOwyoY56WQp208Xwr17ST0En17/+ZBuCRyokes=;
        b=PJumkcX9A4lGd6E0+02L5SH7G0cyUPth61Z+5oHVlFJkoClanH4IVNUlJeHcsG0nHD
         ATAVf7jIHLIv+ogzMwjECpdBNsQzhqffZU6AuBHbYKikLIkT0iRR2Bi0W5L8SfnQM05k
         +egD9l4Sgwogl8dYJypJNPTntKZcTjgU3MpA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgrugwOwyoY56WQp208Xwr17ST0En17/+ZBuCRyokes=;
        b=XQI8ETVecDo1/2A83iQ3X1NF5vLvZYrmU0uhZZXoQJtpX7I9rSDffPu6WPv9Meqazc
         U+Os3K/V8kxHR36TtLt29ZeW5/YJfUlgUZA6jTGQaNYsycfZBFi/cIxLuBsIP1+LHMkJ
         /fQm1ucJQJ/wC+zB+WJfoI9ljqn/P3IewZqLJPLpdPs+KJtIXWuR2Yfe664F8ozJ2JBO
         IpPoiPlI0KeUj5i5Hbbc5gzmNPnLLuINY1kaKRnzppnIKqSJiG+vdAaf/LKc9hbaTWGW
         etaL6x6QBbMsD/yNAB7UpXoDY/3rPFV0xFsTovejo9QJfrLkRrftu6tfyCwd4UXmSRIP
         4c9A==
X-Gm-Message-State: AOUpUlEs2wLCdZ2g12a3RP+x1sNl8Wcg9BVe6Da03udCeOf9dVUBox20
        herNmkJLyiV9UA27PncXOQ6BxeQkID0=
X-Google-Smtp-Source: AAOMgpdHhHJO1lWqewHXjFYoSQsRG3WxTr712q5qjbULgpIrG7G/H1T+RUNyeP1dEPgvdr6YldMECw==
X-Received: by 2002:a50:cd07:: with SMTP id z7-v6mr13607792edi.60.1531648404407;
        Sun, 15 Jul 2018 02:53:24 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o2-v6sm13061106edd.84.2018.07.15.02.53.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 02:53:23 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r16-v6so29000008wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 02:53:23 -0700 (PDT)
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr9084484wrd.67.1531648402720;
 Sun, 15 Jul 2018 02:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-12-toddpoynor@gmail.com>
 <20180715090544.GC23333@kroah.com> <CAE_wzQ_YosCJro46uuF1v6TQhVaTaXLdiLVD7gb94BwQx00SuQ@mail.gmail.com>
 <20180715093216.GA16003@kroah.com>
In-Reply-To: <20180715093216.GA16003@kroah.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sun, 15 Jul 2018 12:53:09 +0300
X-Gmail-Original-Message-ID: <CAE_wzQ9rsw14EbFpt4kdt8bRJYyjDVvMrf45u3-y4Dzs4NKwRg@mail.gmail.com>
Message-ID: <CAE_wzQ9rsw14EbFpt4kdt8bRJYyjDVvMrf45u3-y4Dzs4NKwRg@mail.gmail.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, toddpoynor@gmail.com,
        frankhu@chromium.org, jnjoseph@google.com,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>, rspringer@google.com,
        Guenter Roeck <groeck@chromium.org>, toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 12:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 15, 2018 at 12:11:47PM +0300, Dmitry Torokhov wrote:
> > On Sun, Jul 15, 2018 at 12:05 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Jul 13, 2018 at 10:58:09PM -0700, Todd Poynor wrote:
> > > > From: Todd Poynor <toddpoynor@google.com>
> > > >
> > > > Always allow root to open device for writing.
> > > >
> > > > Drop special-casing of ioctl permissions for root vs. owner.
> > > >
> > > > Reported-by: Dmitry Torokhov <dtor@chromium.org>
> > > > Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> > > > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > > > ---
> > > >  drivers/staging/gasket/apex_driver.c  |  9 +++------
> > > >  drivers/staging/gasket/gasket_core.c  |  8 +++++---
> > > >  drivers/staging/gasket/gasket_ioctl.c | 15 ++++++---------
> > > >  3 files changed, 14 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> > > > index b1318482ba65..ffe11d8168ea 100644
> > > > --- a/drivers/staging/gasket/apex_driver.c
> > > > +++ b/drivers/staging/gasket/apex_driver.c
> > > > @@ -644,13 +644,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
> > > >  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
> > > >  {
> > > >       struct gasket_dev *gasket_dev = filp->private_data;
> > > > -     int root = capable(CAP_SYS_ADMIN);
> > > > -     int is_owner = gasket_dev->dev_info.ownership.is_owned &&
> > > > -                    current->tgid == gasket_dev->dev_info.ownership.owner;
> > > > +     fmode_t write;
> > > >
> > > > -     if (root || is_owner)
> > > > -             return 1;
> > > > -     return 0;
> > > > +     write = filp->f_mode & FMODE_WRITE;
> > >
> > > Ok, this is insane.  You don't change, or check, the permissions on a
> > > file handle while it is already open, as you only check the permissions
> > > on OPEN, not on WRITE.  See the recent rant from Linus on the linux-api
> > > list for yet-another-long-threaad in which he explains this.
> > >
> > > So this whole ioctl can just be removed, it is totally crazy and wrong
> > > and should just be removed.
> >
> > No, the code checks whether the requested ioctl command is compatible
> > with the mode the file handle was open with. There are some ioctls
> > that are allowed on file handle opened for read and others that
> > require file handle to be opened for write. That is all. It does not
> > change permissions past open.
>
> That's really not obvious here :)
>
> And is odd on a whole other set of "crazy design", but ok, let's let it
> live for now.

Are you talking about ioctl still or something else? Because such
ioctl handling is quite common, take a look at blkdev for example,
where disacrd ioctl is only allowed when device is open for writing.

>
> I can't wait for people to just realize this whole "new" subsystem can
> be replaced with UIO, but that's a topic for a different thread...

Yes, that is true and that is why I am not sure why we are going
through all this staging exercise.

As far as I understand we'd still need to have quite a bit of kernel
code so that we can safely program DMA controller (it does not look
like uio_dmem_genirq.c is sufficient as is for gasket needs), but that
should be solvable.

Thanks,
Dmitry
