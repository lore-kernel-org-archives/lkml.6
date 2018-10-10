Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C633CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D377214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkmO2rPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D377214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJJWZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJWZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:25:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D5A4214DA;
        Wed, 10 Oct 2018 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539183803;
        bh=2hG9aVvcWYInC/ChccG4pHYdZ7l11atjqWe2xtNCyXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkmO2rPTAjDH/QCzFuERq+VmPUv3HjkfYqrplfLNeb5m9Q/japI5K3shKD2aJoXlY
         AbFAyF3qz6IiIPDNUFpIsqk2pFaZgNwSyu8GXjBcchG20WZS7fUwwT3W3wurpSwx5N
         S0xrgYVvdreiVVLzAtexTMSW+07zqnZDMZ0NmKVs=
Date:   Wed, 10 Oct 2018 17:03:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts
 to prevent latching
Message-ID: <20181010150320.GA7945@kroah.com>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox>
 <CACRpkdZVWMAQxrX7CS-JtA9sRYqeNE+8X39yqfCNtYLmN=XDHw@mail.gmail.com>
 <20181010075337.GA13524@localhost>
 <CACRpkdZN4q_gZ27rjD-Yrw5PqsJPRDW2n4u3VaoqBFfwrmhHcA@mail.gmail.com>
 <20181010124509.GA30716@kroah.com>
 <20181010143959.GG32006@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010143959.GG32006@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:39:59AM -0400, Sasha Levin wrote:
> On Wed, Oct 10, 2018 at 02:45:09PM +0200, Greg KH wrote:
> > On Wed, Oct 10, 2018 at 02:12:01PM +0200, Linus Walleij wrote:
> > > On Wed, Oct 10, 2018 at 9:53 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > > On Wed, Oct 10, 2018 at 09:12:58AM +0200, Linus Walleij wrote:
> > > > > On Tue, Oct 9, 2018 at 8:33 AM Nathan Chancellor
> > > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > > Sigh, sorry, I caught this after I sent my initial all good email but
> > > > > > this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> > > > > > apps that want to use it ask to enable it). I can't say why, I'm more
> > > > > > than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> > > > > > done out of tree. I'll leave it up to you how to proceed given that I
> > > > > > can't run mainline :(
> > > > >
> > > > > Which NFC driver is this?
> > > > > Just want to make sure it looks sane.
> > > > >
> > > > > Yours,
> > > > > Linus Walleij
> > > >
> > > > Hi Linus and Bjorn,
> > > >
> > > > These two files should be it I believe:
> > > > https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/nq-nci.c
> > > > https://android.googlesource.com/kernel/msm/+/android-9.0.0_r0.22/drivers/nfc/ese/pn81a.c
> > > >
> > > > Sorry I didn't get around to digging into this further today, I will try
> > > > to get to it in the morning.
> > > 
> > > I'm confused. These are not in the mainline kernel and presumably
> > > not in the stable kernel either.
> > > 
> > > So when you say "this commit breaks NFC on my Pixel 2 XL" you
> > > mean that when you apply this commit to the android msm kernel,
> > > which has a few other stable fixes backported, it breaks?
> > 
> > If these drivers are obviously broken, I have no objection to merging
> > patches like this and telling qcom to fix their code.  But if the issue
> > is more subtle, like change in behavior that is unanticipated, then I am
> > a bit more reluctant to take patches that break working systems.
> 
> I think that this is a dangerous precedent where we won't take a patch
> that actually fixes in-tree code because it breaks out-of-tree code.

Sorry, I don't mean for it to look that way at all.  That's not what I
was meaning to imply.

> I understand your concern: it's possible that this patch is actually
> broken, and we only see the breakage, by chance, with out-of-tree code.
> We also don't want to subtly break out-of-tree users for no good reason.
> 
> Maybe a better solution is to give a courtesy heads-up to Qualcomm and
> queue this patch to the next release (or maybe the one after the next).
> If they can show that the patch is broken we can go ahead and revert/fix
> it, but if it's not - it won't be indefinitely stuck out of the stable
> tree while we try debugging Qualcomm's out-of-tree code.

I would like to see what the developers here can find out first about
the out-of-tree code to see where the fault lies.  I have no problem
breaking out-of-tree code if it is obviously wrong, but the interaction
with the pinctl subsytem and various older drivers is very touchy at
times, and we have had to revert things to keep everyone happy.

So there is some history here, and I want to make sure who is to blame
first.  I lay odds on the msm out of tree driver :)

thanks,

gre k-h
