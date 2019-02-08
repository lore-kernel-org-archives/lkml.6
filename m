Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B229121924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549608692;
	bh=40A43kSQFVoPioyu8Kn4Eatqr9VwVAn8NigU4ZtnySg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KcG4rQztWYfX+xrr0r8H6BtX9D1R9ufGCWgtItMtMJCBuHmQjDhMcGf1mGOq8Uua2
	 gbkEhz+JkTEtIJqGufPmH2owbhFXQArTzYWpCJ22XkF+MGLeQaCSunC3ObSQjO+8zb
	 SVi8ovBQUzPQUAaVfhAzf30kVr4HTQ//2UyCgBzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBHGvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfBHGva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:51:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736FD21920;
        Fri,  8 Feb 2019 06:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549608689;
        bh=40A43kSQFVoPioyu8Kn4Eatqr9VwVAn8NigU4ZtnySg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pA7sEJ+7nbZ5jGRTsoc3t6PkvsE7H94CfMp3oXhsgBZzFaeRGtEmpzOls+1L1A1q3
         TlZjbjD7oiTj1X0JvG5e814AEAqAIjmidDYgpdZUSJWCjJej6FIipK8j2O1e+sEd3S
         YtNwKdZ0yEfIOBjS1axZ4SfMYCzmsXxhIArS3lqg=
Date:   Fri, 8 Feb 2019 07:51:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
Message-ID: <20190208065127.GA27770@kroah.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
 <20190205184355.GC22198@kroah.com>
 <CAGngYiUMuM_ZxHKVWRihDHZcMncvTwR6Sz1zGNJLrGpyhhT1uQ@mail.gmail.com>
 <20190206164657.GC8466@kroah.com>
 <CAKdAkRQbCj59_Cw2RqpyDEU2zzn4ajOjXF44NE2LJ7QB8-DLtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRQbCj59_Cw2RqpyDEU2zzn4ajOjXF44NE2LJ7QB8-DLtw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:30:29AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 6, 2019 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 05, 2019 at 02:12:31PM -0500, Sven Van Asbroeck wrote:
> > > On Tue, Feb 5, 2019 at 1:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >
> > > > It really should happen when the device is removed (if it is a driver
> > > > that binds to a device.)
> > >
> > > Absolutely. That's why I'm advocating adding a devm_init_work(),
> > > which will take care of this automatically.
> > >
> > > But it's of course not universally applicable. Not all drivers use devm.
> >
> > Ick, no, watch out for devm() calls.  Odds are this is _NOT_ what you
> > want to do for a device.  Remember when devm calls get freed (hint, not
> > at driver unbind/unload, but at device structure removal.
> 
> 
> ??? We unwind devm on probe() failure and after remove() is called.
> The device can live on.

{sigh} you are right, I don't know what I was thinking.  Then why were
the DRM developers so upset that they didn't see this happening
recently?  Anyway, all should be fine here, nevermind...

thanks,

greg k-h
