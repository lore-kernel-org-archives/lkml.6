Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2987C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81962087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xYJbBY2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81962087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJJUHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeJJUHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:07:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C5B2087A;
        Wed, 10 Oct 2018 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539175511;
        bh=/lfJ5wMgtMpe2VbHIIjmHKJEmmaJdbO6W2ZDDbMKG6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xYJbBY2Y6xqoHaqEcYqAU5CqwhHHep4YIb7md3OmutT8K94F5Kfwln3Nv5AExeH7Q
         jhH0eH81vmXOp/6xFQB0eK3cmkY3ucAQIjpMzBaeaKmt1GWbJ23HUJaHvy/TDJ4agW
         lfGcDd62rHov5i+DJYJkP8E2I9k327+DUl63ZhZk=
Date:   Wed, 10 Oct 2018 14:45:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts
 to prevent latching
Message-ID: <20181010124509.GA30716@kroah.com>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox>
 <CACRpkdZVWMAQxrX7CS-JtA9sRYqeNE+8X39yqfCNtYLmN=XDHw@mail.gmail.com>
 <20181010075337.GA13524@localhost>
 <CACRpkdZN4q_gZ27rjD-Yrw5PqsJPRDW2n4u3VaoqBFfwrmhHcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZN4q_gZ27rjD-Yrw5PqsJPRDW2n4u3VaoqBFfwrmhHcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:12:01PM +0200, Linus Walleij wrote:
> On Wed, Oct 10, 2018 at 9:53 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, Oct 10, 2018 at 09:12:58AM +0200, Linus Walleij wrote:
> > > On Tue, Oct 9, 2018 at 8:33 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > >
> > > > Sigh, sorry, I caught this after I sent my initial all good email but
> > > > this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> > > > apps that want to use it ask to enable it). I can't say why, I'm more
> > > > than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> > > > done out of tree. I'll leave it up to you how to proceed given that I
> > > > can't run mainline :(
> > >
> > > Which NFC driver is this?
> > > Just want to make sure it looks sane.
> > >
> > > Yours,
> > > Linus Walleij
> >
> > Hi Linus and Bjorn,
> >
> > These two files should be it I believe:
> > https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/nq-nci.c
> > https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/ese/pn81a.c
> >
> > Sorry I didn't get around to digging into this further today, I will try
> > to get to it in the morning.
> 
> I'm confused. These are not in the mainline kernel and presumably
> not in the stable kernel either.
> 
> So when you say "this commit breaks NFC on my Pixel 2 XL" you
> mean that when you apply this commit to the android msm kernel,
> which has a few other stable fixes backported, it breaks?

If these drivers are obviously broken, I have no objection to merging
patches like this and telling qcom to fix their code.  But if the issue
is more subtle, like change in behavior that is unanticipated, then I am
a bit more reluctant to take patches that break working systems.

It would be nice to figure out what is going wrong here as I think the
drivers above are being submitted upstream right now, correct?

thanks,

greg k-h
