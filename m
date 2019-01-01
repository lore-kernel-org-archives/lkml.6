Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C3BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FCA21019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546376754;
	bh=HxafoQotF2cIMVG51f/0m2d5J4ndNTK3YOJOuXEc8rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eqAOnN200LFeog4QhM1m4vsdhB053SfvD20hE9oiY+icNplY1ETiE0gW3+0PljRpF
	 rLnR9/hgKLyhe3NASHHMEcgzgEDe0bPI2vtjO2X2zKl7ZRAdgxC5oG5KhAr24S5jRf
	 +JOoQDzNgKQ5cbxw/hXG7AB8Qy2kn71Sh5swlEZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAAVFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:05:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44500 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfAAVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:05:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id m6so23814129oig.11;
        Tue, 01 Jan 2019 13:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chPUBP5+13zC0ibytLsgVHSdsy/G5zWKYsnfBc3V3EY=;
        b=KCk71JpZ5ryhMRoaz+vq/fFPHls4vfRwnMmuP+JVjg+3VLmbS86W274JtpsrOpDvfb
         CU4Y1elTpHbOEb1OqII23sFkLa1XVz558BsRCC+ne/lw4zsvzVR8xcPPaF0Mwt8wdHP8
         i606QmrvSc0lMGM80Hswt/YBBcBR9aTpRq2VulYlKjRab/Y4Dg5XKB39qmYS6RQpJBTT
         f54rSF+Vsue8oUQu630jgITxgFTCSUkXhTglt1b8yrddeH5xa7YIq9hk9oMa88vaXsAc
         p/Vngj5N39DzVL1rui9mgDIz4+pWXPmB+BqcdkknqkJHImrHtwa3jnmNlUCouFId9xFY
         9kPA==
X-Gm-Message-State: AJcUukeTL0IK8WAl3nI9kYh94pBvbrhAgHGKZFA2k5n+7E4H9YQO+Aef
        0M3aFofSNLu6CLu1VuHbnZLbz8T7IpD+VDuvp1BUjw==
X-Google-Smtp-Source: ALg8bN4NILKUrlNn+3UNNkLeFJYh2j5WeSkAqyZpfGnUHI9W3/WOpjTRDa/7XvsWZ/kELsbXNUHZWmuUA/8FPo1+xw4=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr28138257oic.33.1546376750802;
 Tue, 01 Jan 2019 13:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20181226024700.72318-1-kjlu@umn.edu> <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
 <20181231172556.GA14092@amd> <CAJZ5v0hOKXkZbpchv9+23uTgZyeq_3oQHznPKR3-+X43JakGeg@mail.gmail.com>
 <20190101202119.GA13097@amd>
In-Reply-To: <20190101202119.GA13097@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Jan 2019 22:05:39 +0100
Message-ID: <CAJZ5v0iJCaCju7sgCF9u7PYxmHF0jQDy95_QEVt8q+R2NX5zAA@mail.gmail.com>
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

On Tue, Jan 1, 2019 at 9:21 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Tue 2019-01-01 21:13:01, Rafael J. Wysocki wrote:
> > On Mon, Dec 31, 2018 at 6:25 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Wed 2018-12-26 10:37:54, Rafael J. Wysocki wrote:
> > > > On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
> > > > >
> > > > > clk_prepare() could fail, so let's check its status, and if it fails,
> > > > > issue an error message.
> > > > >
> > > > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > > > ---
> > > > >  drivers/base/power/clock_ops.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > > > > index 5a42ae4078c2..cb6144fb24e2 100644
> > > > > --- a/drivers/base/power/clock_ops.c
> > > > > +++ b/drivers/base/power/clock_ops.c
> > > > > @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
> > > > >         if (IS_ERR(ce->clk)) {
> > > > >                 ce->status = PCE_STATUS_ERROR;
> > > > >         } else {
> > > > > -               clk_prepare(ce->clk);
> > > > > +               if (clk_prepare(ce->clk))
> > > > > +                       dev_err(dev, "clk_prepare failed.\n");
> > > >
> > > > I'm not sure that this is useful.  The code continues regardless of
> > > > the error anyway and it should at least set ce->status to
> > > > PCE_STATUS_ERROR in the failing case.
> > >
> > > Maybe this is not complete fix, but dev_err() is preferable to silent
> > > failure.
> >
> > Preferable to you I suppose?
>
> Preferable to the poor person trying to figure out why his machine
> does not work?

Not really, unless that person knows what the message means.

Honestly, what would you do if you saw that message?
