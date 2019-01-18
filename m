Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37922087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547795877;
	bh=k53VbQQboS0cOMnK5hdtGl8IMPbKmIiqg76sKvLNXUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sVg1pDlrHpO8WBSawHfI1Uui90fWSEJhS03Dur1ZyKqoKSxkE3bhG6LtD7HH/UpUy
	 uRwdi61fh+gzN7NiCy6NLcQOQvGtq8HxhYFdK0WFbBONxrs2EDHtQqK5MlgQZRzy9H
	 5QABp9Y+oGJIDMN7QrNPnBgfn+n05OUzpU9Fke2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfARHRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfARHRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:17:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E7A20855;
        Fri, 18 Jan 2019 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547795875;
        bh=k53VbQQboS0cOMnK5hdtGl8IMPbKmIiqg76sKvLNXUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1sj9enjst+XOPRguBL5aedJRqDDvL+2dSRTMqZK9KG7oARRI7xyYr0ITWtk8kakqk
         b3yZ8tyF9eZ2QMbZHw9liAsknnZRoOU6WZmLSEgKyfALGqwx+yo1KqVkGnlTelZlbX
         y/hzLidVkQmjyAiJoDt5pSi4mu3hNIbeyWGoLKoo=
Date:   Fri, 18 Jan 2019 08:17:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Hartman <ghartman@google.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Alistair Strachan <strachan@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190118071752.GG11050@kroah.com>
References: <20190117224135.GC8100@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117224135.GC8100@hle-laptop.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:41:35PM +0100, Hugo Lefeuvre wrote:
> introduce wait_event_freezable_hrtimeout, an interruptible and freezable
> version of wait_event_hrtimeout.
> 
> simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using this
> newly added helper and remove useless includes.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
>  drivers/staging/android/vsoc.c | 69 +++++-----------------------------
>  include/linux/wait.h           | 25 ++++++++++--

code in drivers/staging/ should be self-contained, and not, if at all
possible, ever force additional changes on "core" kernel code.

Are you sure that the vsoc code can't use one of the current wait
macros?  Why is it so special and unique that no one else in the kernel
has ever needed this before it came along?

thanks,

greg k-h
