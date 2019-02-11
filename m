Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73568C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549926322;
	bh=xuKzeid/pan86Wn15wLRKBOL5DgNNXmOo3cjlMl6TR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lTT9v0LD70yd//83xhupK4h+M6PkLkQqL4VHnik6NZXR5PEse2MYakxYo1fpA6nDb
	 ivFwUlPuN6OJkxVLiusaaBjYCJHVZyqXITJRzqKOPj4197QYqHu5vfgcSGKzBSskpg
	 jnVkD50D7nWlbuOVYEj1g3ndjfz62qKi7qUf1YiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBKXFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:05:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41537 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBKXFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:05:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so1139953otk.8;
        Mon, 11 Feb 2019 15:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuKzeid/pan86Wn15wLRKBOL5DgNNXmOo3cjlMl6TR4=;
        b=cJbmwVMhKHZi5sgq2F531Y1GbIdvqjwE7DUJ0JBde2nUbUtblBEV9lBxVAyORrmxGQ
         Ocv4efOPrPT2CXRI4ARKac/pVNotgJqParKlzUjQ94LOnQlZ41mXbn05u5/mk/1HxSIF
         REuZKYcsZO4+uexw0X9wOJ8f+WgQ4ptjcucoENGRUU55HgdLTko2s8HEpPlT9ELK/KyU
         mMpG9r7FAfUESD+vrBUyUAE02kk1OkgkoUwlpmC0x1cqAZP02oMMD4mBHwYryeGYE3Af
         FSFViLGCHhBEeL7uQkYu02TBPfz9Zcv9Il4uGNFaAUPnw6zPaB5oMvMjse6969xnS9dm
         RbcQ==
X-Gm-Message-State: AHQUAubLjcrg0GVJOEajCHdO3K/xWPZugWwz4l8dKtH41ndJrn7eDODB
        Q5LOcEhh7UcaX503gVCBtQZw/WEVltCz1+n3C0Gn7jen
X-Google-Smtp-Source: AHgI3IanTjHL+Tdm4AH/xK1l8oOX8fEMcPKj1XbIIRAU3QoFJP2aOjj2mesrTQqQCgaI7p3cssbM+XPxwhmijktKwh8=
X-Received: by 2002:a05:6830:2005:: with SMTP id e5mr695111otp.258.1549926319217;
 Mon, 11 Feb 2019 15:05:19 -0800 (PST)
MIME-Version: 1.0
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
 <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com> <CAPDyKFqnWgjZ1icajdzbaQ_HW-2ec0-npEU_nAWvSVEpZMzSRA@mail.gmail.com>
In-Reply-To: <CAPDyKFqnWgjZ1icajdzbaQ_HW-2ec0-npEU_nAWvSVEpZMzSRA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 00:05:07 +0100
Message-ID: <CAJZ5v0hV-G_U=XV1N=rpEv1LMgB+jjB3kVEoHKUasd2p3QP5Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 11 Feb 2019 at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 7 Feb 2019 at 19:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If the target device has any suppliers, as reflected by device links
> > > to them, __pm_runtime_set_status() does not take them into account,
> > > which is not consistent with the other parts of the PM-runtime
> > > framework and may lead to programming mistakes.
> > >
> > > Modify __pm_runtime_set_status() to take suppliers into account by
> > > activating them upfront if the new status is RPM_ACTIVE and
> > > deactivating them on exit if the new status is RPM_SUSPENDED.
> > >
> > > If the activation of one of the suppliers fails, the new status
> > > will be RPM_SUSPENDED and the (remaining) suppliers will be
> > > deactivated on exit (the child count of the device's parent
> > > will be dropped too then).
> > >
> > > Of course, adding device links locking to __pm_runtime_set_status()
> > > means that it cannot be run fron interrupt context, so make it use
> > > spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
> > > and spin_unlock_irqrestore(), respectively.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Rafael, thanks for working on this!
> >
> > I am running some tests at my side, but still not achieving the
> > behavior I expect to. Will let you know when I have more details, but
> > first some comments below.
>
> Alright, this is what I found.
>
> When I call pm_runtime_set_suspended(), in the ->probe() error path of
> my RPM test driver (I am removing the device link afterwards), then my
> expectation was that this should allow the supplier to become runtime
> suspended (sooner or later). This isn't the case, as it turns out the
> runtime PM usage count of the supplier, still remains 1 after the
> probe failure.
>
> My observation is that with $subject patch, the link->rpm_active count
> is now reaching 1, before it stayed at 2 - so one step forward. :-)
>
> However, the reason to why the runtime PM usage count never reaches 0,
> is because of the call to pm_runtime_get_noresume(supplier) in
> device_link_rpm_prepare(), which is called from device_link_add().

That was there previously, I've just moved it to device_link_rpm_prepare().

But good catch!

> To solve the problem, it seems like we need to call
> pm_runtime_put(supplier), in case the device link is deleted while the
> consumer is still probing.

I'd rather change the way pm_runtime_get/put_suppliers() work, so that
they use the rpm_active refcount, but pm_runtime_put_suppliers() only
drops it by one - unless it is one already.

Then, when adding a new link with DL_FLAG_RPM_ACTIVE,
device_link_add() only needs to increment its rpm_active *twice*
(instead of doing that once as to does now), so it will stay above one
after the subsequent pm_runtime_put_suppliers() - and if it goes away
in the meantime, then it will be cleaned up by the removal.

In turn, if a link is created without DL_FLAG_RPM_ACTIVE, its
rpm_active is one and then pm_runtime_put_suppliers() will just skip
it.

A patch will follow. :-)
