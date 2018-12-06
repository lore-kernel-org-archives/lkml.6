Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB71C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0304C20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0304C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeLFAkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:40:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57960 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:40:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gUhiY-00059Q-6c; Thu, 06 Dec 2018 00:40:38 +0000
Date:   Thu, 6 Dec 2018 00:40:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>,
        Jann Horn <jannh@google.com>, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2] binder: fix use-after-free due to fdget() optimization
Message-ID: <20181206004037.GY2217@ZenIV.linux.org.uk>
References: <20181205211601.75856-1-tkjos@google.com>
 <20181205220035.GX2217@ZenIV.linux.org.uk>
 <CAHRSSEwpYw312kBU4WGHs_P+xqx8cP+iripYVHxpV6pJBbH9Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSEwpYw312kBU4WGHs_P+xqx8cP+iripYVHxpV6pJBbH9Mw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:21:55PM -0800, Todd Kjos wrote:

> > How about grabbing the references to all victims (*before* screwing with
> > ksys_close()), sticking them into a structure with embedded callback_head
> > and using task_work_add() on it, the callback doing those fput()?
> >
> > The callback would trigger before the return to userland, so observable
> > timing of the final close wouldn't be changed.  And it would avoid the
> > kludges like this.
> 
> I'll rework it according to your suggestion. I had hoped to do this in a way
> that doesn't require adding calls to non-exported functions since we are
> trying to clean up binder (I hear you snickering) to be a better citizen and
> not rely on internal functions that drivers shouldn't be using. I presume
> there are no plans to export task_work_add()...

Er...  Your variant critically depends upon binder being non-modular; if it
*was* built as a module, you could
	* lose the timeslice just after your fput()
	* have another process hit the final fput() *and* close the struct file
	* now that module refcount is not pinned by anything, get rmmod remove
your module
	* have the process in binder_ioctl() regain the timeslice and find the
code under it gone.

That's one of the reasons why such kludges are brittle as hell - normally you
are guaranteed that once fdget() has succeeded, the final fput() won't happen
until fdput().  With everything that guarantees in terms of code/data not going
away under you.  This patch relies upon the lack of accesses to anything
sensitive after that fput() added into binder_ioctl().  Which is actually
true, but only because the driver is not modular...

At least this variant (task_work_add()-based) doesn't depend on anything
subtle - the lack of exports is the only problem there (IOW, it would've
worked in a module if not for that).
