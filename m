Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE46218D2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545642754;
	bh=pQjqvUtDJG09nQuRoxB+uv9hek/Oz7J9fXOnFvPnE3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WvNORd05Hav54TonjP7l3XcLhVupgbGPwHcRzQqxC7aYtAQVAFBhNJgLkVA+vudZN
	 c/MUuHM6nM0KKfV9zaY/mTMbgDmkzCxOSXwjpKyKP/sAxAIlA5VBM+8CXIqG5lqeh5
	 z8iVN/IE3tdTPA/vFy0HnxrLtrAYo5iXemWqGF0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbeLXJMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbeLXJMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:12:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6852173C;
        Mon, 24 Dec 2018 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545642752;
        bh=pQjqvUtDJG09nQuRoxB+uv9hek/Oz7J9fXOnFvPnE3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghTGNWINEibrGoFvjYMxWgdRnuX73XJRI7gwuN4fY9CfEqpzgDPg6XEdkARCEt+2z
         jVU8JW6AjHesHhPC8H6JniSrAIraVjK43o/blKqB1mxzp/9YhhD5NCnoHmc81ksP+X
         3OItBsr1lgvemCv01bQRFbcOS9syPEhs6GOKXRyc=
Date:   Mon, 24 Dec 2018 10:12:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcus Meissner <meissner@suse.de>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224091229.GA26796@kroah.com>
References: <20181223164954.hib4lbchftspidsd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223164954.hib4lbchftspidsd@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> Hi,
> 
> I am the maintainer of libmtp and libgphoto2
> 
> Some months ago I was made aware of this bug:
> 	https://bugs.kde.org/show_bug.cgi?id=387454
> 
> This was fallout identified to come from this kernel commit:
> 
> 	commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> 	Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 	Date:   Wed Jul 19 17:24:30 2017 -0700
> 
> If distributions would be using libmtp and libgphoto2 udev rules
> that just triggered on "add" events, and not the new "bind" events,
> the missing "attribute tagging" of the "bind" events would confused the
> KDE Solid device detection and make the devices no longer detected.
> 
> This did not affect distributions that rely on the newer "hwdb"
> device detection method.
> 
> I have released fixed libmtp and libgphoto2 versions in November, so
> this is under control, but wanted to bring this up as a "kernel caused
> userland breakage".

This is complex, sorry.  When this first commit was merged, we did get
some reports of problems, so we reverted it.  Dmitry worked through the
issues and then we added it back again.

That was back in July of 2017, and since then, we had not heard of any
problems that happened until this month, a very long time.

So I really don't understand the root problem here, all of the distros
that have been shipping kernels with this code for over a year didn't
seem to have any issues.  My systems never had any issues, and so I
can't figure out what suddenly changed to cause problems.

Was it the fact that we all are using distros that use hwdb?  Who does
_not_ use hwdb these days?  Heck, I would have expected Debian to report
problems as they are the ones that are known to use old userspace code
with kernel developers using new kernels.

So what changed to cause the problem recently?

confused,

greg k-h
