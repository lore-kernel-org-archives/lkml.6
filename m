Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E7DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D242220818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549471624;
	bh=vfbZaUIj9koDm+NdubUYBHlXHtqfbk9FbL0dkj+CTjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mAIHIDlVz1amtYPLntwZxOwiguWIKTSAmS++Fy9qMNezbSoDkB14kNefv+j3tM8VN
	 q3ebsFCuOAneOS7Dx4eNtG+0z/CB2b+4o+UEi+wBKs5mBKh9x3TL/Zaw/SO8yUanRj
	 WYful1Q6A0f7EJgDplrx0e91iKhjcAYUwYeHy9bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfBFQrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfBFQrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:47:03 -0500
Received: from localhost (mobile-107-92-61-93.mycingular.net [107.92.61.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A161220818;
        Wed,  6 Feb 2019 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549471622;
        bh=vfbZaUIj9koDm+NdubUYBHlXHtqfbk9FbL0dkj+CTjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2y2TNHrl5c6Fs+ExRYepZbaR46jdbl9P/cjvTqgW9bVo8aSbnT9lrMlBPX5mtdU5
         rxspeOweU8G8kTo5092CclfcKFqTVACQb5HXIh2cIfyVyLMMHBJ/DMVafLHvtyzbat
         WmvfWl1S7fr//S3LWUDyps1A64SRdUDnvdMHDH0A=
Date:   Wed, 6 Feb 2019 17:46:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
Message-ID: <20190206164657.GC8466@kroah.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
 <20190205184355.GC22198@kroah.com>
 <CAGngYiUMuM_ZxHKVWRihDHZcMncvTwR6Sz1zGNJLrGpyhhT1uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUMuM_ZxHKVWRihDHZcMncvTwR6Sz1zGNJLrGpyhhT1uQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:12:31PM -0500, Sven Van Asbroeck wrote:
> On Tue, Feb 5, 2019 at 1:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> >
> > It really should happen when the device is removed (if it is a driver
> > that binds to a device.)
> 
> Absolutely. That's why I'm advocating adding a devm_init_work(),
> which will take care of this automatically.
> 
> But it's of course not universally applicable. Not all drivers use devm.

Ick, no, watch out for devm() calls.  Odds are this is _NOT_ what you
want to do for a device.  Remember when devm calls get freed (hint, not
at driver unbind/unload, but at device structure removal.

By creating a work queue, you are suddenly tying module code to a device
memory structure lifespan, both of which are totally independant.

It's the same issue with the devm irq call, that has been nothing but a
nightmare as everyone gets it wrong.  Try to learn from our past
mistakes please :)

thanks,

greg k-h
