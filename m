Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8495C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB882089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550699138;
	bh=tYzmQ+rvgmVXljQGVzkjxngpoYpjn9oGpeXS69Zk4ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JB5MxLuGD+SoWe61/Qm7qWm9LuvYapN6+GCVL8ixLW/29Is4owhvKsmxUMkQp+9C4
	 B3rFrgpk7yf1gVzE1/QzoJNr64DxZj79O/FYYL7uzeRnmkBpJNVNpi2LSRGFK8V0dz
	 1/xD7QwRre0vgCbhrUVzQ9Ey0/whKE+3drlqKgwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfBTVph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:45:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36454 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTVpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:45:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so33985791otb.3;
        Wed, 20 Feb 2019 13:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtWqwxrh7CslkxN6+sxq7HIdQgCE7jo4WinV+vjvvVc=;
        b=BLi0witLL2yCLXgRQIkue0sEzQ6Y5hgLxBikOLH8Q7+VP0atKx2XIlEaY6H7141oxW
         A7+dQNdSQ4ii4oV1uow0N8a0osVj1KJspPvzxWmUJozgPVupFoHezP7cmAd11wz36q63
         bB5ZIWP2GVAUIqFJHnRqy+OluO7if7JpCLgi52Sgkut1Jvnive6pVrd1+OiK2evMaRvx
         NmYxJpjJE7O3KS1YOvfxjUONUuZdqHTEXwuiR7EqWrcsZkY4g17Pyg2sZ+okmuJ4yRMR
         D3TSAOoIinbPNxC5Rn8j4djH3XN9+k3RB7XIp/UNE+0/nA9JTjRVgiRNX2tdeZthhdmb
         ypZw==
X-Gm-Message-State: AHQUAuZMCsmC3teuqNgTEQD8QV5p4UR4gQoakHBxQSfQFrhu3GN89ZGB
        uVgzi2eTl39jncVp7M3kbBFEDn24PXybzQLYdrQ=
X-Google-Smtp-Source: AHgI3IZB+rNteCcsqZ+I6GP8S63zS9+BHIlj2gY9ds9UTtpgPjfyey7BWo+bEAkVEi7eG1PQgNY7xa9LSJp4R636LxA=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr6352238otl.244.1550699135895;
 Wed, 20 Feb 2019 13:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20190206154214.576-1-harry.pan@intel.com> <20190214111543.22137-1-harry.pan@intel.com>
 <2819109.DzhZvocLkm@aspire.rjw.lan> <cf6926800899354808143bd48b4f943629c8cbe7.camel@intel.com>
In-Reply-To: <cf6926800899354808143bd48b4f943629c8cbe7.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 22:45:24 +0100
Message-ID: <CAJZ5v0gmFz8aK5_+0a36RwEiPScU=Z8BhD8pR50V1GRcmbXFgA@mail.gmail.com>
Subject: Re: [PATCH v3] PM / suspend: measure the time of filesystem syncing
To:     "Pan, Harry" <harry.pan@intel.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 5:44 PM Pan, Harry <harry.pan@intel.com> wrote:
>
> Thanks for comments.
>
> > > +   if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
> > > +           ktime_t start;
> > > +           unsigned int elapsed_msecs;
> > > +
> > > +           trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> > > +           pr_info("Syncing filesystems ... ");
> > > +           start = ktime_get();
> > > +           ksys_sync();
> > > +           elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(),
> > > start));
> > > +           pr_cont("(elapsed %d.%03d seconds) done.\n",
> > > +                   elapsed_msecs / MSEC_PER_SEC,
> > > +                   elapsed_msecs % MSEC_PER_SEC);
> >
> > One more nit.
> >
> > Since you are printing the sync time anyway, there is a little sense
> > to
> > split the message using pr_cont() that may be messed up with by any
> > intervening messages, so why don't you just print a one-line
> > pr_info("Filesystems sync: %d.%03d seconds\n", ...) message?
> >
> Yes, I agree.
> In practical, I did see intervening messages (between pr_info and
> pr_cont) when it came to long sync in kernel.
> I was hesitated in this considering not fully understanding the
> backdrop of split messages using pr_info() then pr_cont().
>
> > Also, if you change it here, I guess it would be consistent to make
> > an analogous change for hibernation.
>
> One potential last-mile need your wisdom, which is about the switch
> case of SNAPSHOT_FREEZE of the userspace interface you wrote.
> I am yet to touch it, nor understand how to validate it.

Why don't you add a "sync" helper function in main.c with the timing
and message that will be called from hibernate.c, user.c and suspend.c
(in the last one conditional on
!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC))?

That would reduce some code duplication nicely.
