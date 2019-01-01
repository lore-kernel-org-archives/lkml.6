Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E054C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACAA21019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546373598;
	bh=7k46XR5VbHiCPMtS7kdUxtQxGjg39Y5zNvsFjC3CnbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aj3aOce9jHZmHToznsPwjpaJ17g7iCxSGz7r5jCmB3mswFz5yOAQsu9eXdV7inyvP
	 9uH72tUpK5AbNCtlRJGHDJaERWn7saWIs4DVt4lxWKXPUkpFJc2FsB/MM39Svqb1sv
	 HnSfYL7Lu2dbhoZOXnDD2QbICadPTm9a7pFpU7SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfAAUNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:13:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44633 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAAUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:13:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so25366062otl.11;
        Tue, 01 Jan 2019 12:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yra9KnGSGMh/RN8dTvs9CqbXxqLS/s5lvXvp7EeaHrk=;
        b=M2q73/UVAMCrp1mIel/uuOExo0JTUmQjdIv+PjV+yXKXzJPPM/n8W46xbeYZdj+mar
         TjjFAEBPRTJJSDw/yDT/TZl899W49IvuDuMkwzljqabw5Z8O5TUslasTXcJun+9XyKZf
         lW7NKu7WzRNR4FjRIAr1lOYS8FfsEHa9BRXwrGbj6vROWuw6277LCgUA+aXlJoHqAqnx
         Ip2Pql/NZ5km891U0jNpJh6u8tu8xlTnM7hdN7n3jiqnPN3zbzUteQhnZvIOCHuyvtfi
         tjumop292CQCdeDjFZrDd7ukXstgihLtxGDRMjEZFAdcldyWxbfRPgGicYZOeyQvgaA7
         2Q/g==
X-Gm-Message-State: AJcUukfvddVTPlRV6mhbNMF9IjsBXoRdor8foP4g99v6ggWb43N5y/C6
        x6wdgxQER1IvhsRgqlniHA77BmgW5zjsE8HjPKc=
X-Google-Smtp-Source: ALg8bN5/gaIhkuFK4hBdMmSOq1Tz0rS0OULqJenjj3Ti/bHJKLc169gZAAcjEdqqA+H3mSF7n/634WBTuX4oKxw0c9A=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr27201195ota.244.1546373595688;
 Tue, 01 Jan 2019 12:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20181226024700.72318-1-kjlu@umn.edu> <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
 <20181231172556.GA14092@amd>
In-Reply-To: <20181231172556.GA14092@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Jan 2019 21:13:01 +0100
Message-ID: <CAJZ5v0hOKXkZbpchv9+23uTgZyeq_3oQHznPKR3-+X43JakGeg@mail.gmail.com>
Subject: Re: [PATCH] base: fix a missing check of clk_prepare
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kjlu@umn.edu,
        pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 6:25 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-12-26 10:37:54, Rafael J. Wysocki wrote:
> > On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
> > >
> > > clk_prepare() could fail, so let's check its status, and if it fails,
> > > issue an error message.
> > >
> > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > ---
> > >  drivers/base/power/clock_ops.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > > index 5a42ae4078c2..cb6144fb24e2 100644
> > > --- a/drivers/base/power/clock_ops.c
> > > +++ b/drivers/base/power/clock_ops.c
> > > @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
> > >         if (IS_ERR(ce->clk)) {
> > >                 ce->status = PCE_STATUS_ERROR;
> > >         } else {
> > > -               clk_prepare(ce->clk);
> > > +               if (clk_prepare(ce->clk))
> > > +                       dev_err(dev, "clk_prepare failed.\n");
> >
> > I'm not sure that this is useful.  The code continues regardless of
> > the error anyway and it should at least set ce->status to
> > PCE_STATUS_ERROR in the failing case.
>
> Maybe this is not complete fix, but dev_err() is preferable to silent
> failure.

Preferable to you I suppose?
