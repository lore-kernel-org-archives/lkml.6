Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C498C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D772E21726
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545644103;
	bh=t+WDLbrLyOiOq6bDJp5Vj/GByhEAPNXBbbme97FBQ80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2sXs9rdhK2muosW/y5obOp5xsAZuxwDCkScRmiNQuNuupBe1/8xCCYKd5fORKjhHD
	 CsuxYc4ehr4p0aLeQgfckmVavC78LTG7elnX0pmi1VHUL2+VCkea1KiOYCEgN1fGWi
	 hE8h/Js8UEyfGzEgfnDErb2jSlbP65NAeRtBH/3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeLXJfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbeLXJfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:35:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1911F21726;
        Mon, 24 Dec 2018 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545644100;
        bh=t+WDLbrLyOiOq6bDJp5Vj/GByhEAPNXBbbme97FBQ80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlXGDImOJI93Oc5x72Gm16WAZGFLH7e5vDwJP/tW3V5MDfoE5C52rlZRMoOJgPUOT
         6P5awY7I0thef8fDo5Kg4JFxSXx5UcyCrS7nHIyfdQI+Or85yF8ONwPrK6rAKradEN
         WrE3F8OxrtGdxlZqUQPUJZ6IT5twm5xBQ/2JhmjA=
Date:   Mon, 24 Dec 2018 10:34:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224093458.GA28717@kroah.com>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181224091229.GA26796@kroah.com>
 <20181224092257.GB122208@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224092257.GB122208@dtor-ws>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 01:22:57AM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 24, 2018 at 10:12:29AM +0100, Greg KH wrote:
> > On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > > Hi,
> > > 
> > > I am the maintainer of libmtp and libgphoto2
> > > 
> > > Some months ago I was made aware of this bug:
> > > 	https://bugs.kde.org/show_bug.cgi?id=387454
> > > 
> > > This was fallout identified to come from this kernel commit:
> > > 
> > > 	commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > > 	Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 	Date:   Wed Jul 19 17:24:30 2017 -0700
> > > 
> > > If distributions would be using libmtp and libgphoto2 udev rules
> > > that just triggered on "add" events, and not the new "bind" events,
> > > the missing "attribute tagging" of the "bind" events would confused the
> > > KDE Solid device detection and make the devices no longer detected.
> > > 
> > > This did not affect distributions that rely on the newer "hwdb"
> > > device detection method.
> > > 
> > > I have released fixed libmtp and libgphoto2 versions in November, so
> > > this is under control, but wanted to bring this up as a "kernel caused
> > > userland breakage".
> > 
> > This is complex, sorry.  When this first commit was merged, we did get
> > some reports of problems, so we reverted it.  Dmitry worked through the
> > issues and then we added it back again.
> > 
> > That was back in July of 2017, and since then, we had not heard of any
> > problems that happened until this month, a very long time.
> > 
> > So I really don't understand the root problem here, all of the distros
> > that have been shipping kernels with this code for over a year didn't
> > seem to have any issues.  My systems never had any issues, and so I
> > can't figure out what suddenly changed to cause problems.
> > 
> > Was it the fact that we all are using distros that use hwdb?  Who does
> > _not_ use hwdb these days?  Heck, I would have expected Debian to report
> > problems as they are the ones that are known to use old userspace code
> > with kernel developers using new kernels.
> > 
> > So what changed to cause the problem recently?
> 
> I think this is new systemd that had my patch to handle bind/unbind
> instead of ignoring them is catching up in distros. So:
> 
> - old systemd with old kernels OK
> - old systemd with new kernels OK
> - new systemd with old kernels OK
> - new systemd with new kernels - NOT OK - losing tags on bind
> 
> Systemd folks merged my patch to disable bind/unbind again until we
> teach it to no longer flush entire device state on each new uevent and
> it should be well now.

Ah, thanks, that makes more sense now.  So all should be good, thanks
for confirming this.

greg k-h
