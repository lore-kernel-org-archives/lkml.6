Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE625218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548960422;
	bh=n4OH3bRij5ltuKAEmL/RDpI/YZJUlfwOzRlEgrdeqL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2BTZoKqbIgO85QLRevh8J9GTPJVMfE0qiX58g5pTCWtu0HPUgYYLsGhGPFpJgsdxr
	 pLA+jdJn4604CI4cOFLEvcHAx1/C0buxMuIfUoYmWvSBXctV6g1eD893x/8xnD8A0d
	 7qlGrFHI/nmpCpZYS/9ble4ex2Lp6BJkkIZXeLl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfAaSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfAaSrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386BD218AC;
        Thu, 31 Jan 2019 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548960419;
        bh=n4OH3bRij5ltuKAEmL/RDpI/YZJUlfwOzRlEgrdeqL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qax9TlStRv6uKeqyTzUN2RFftljny0wWHBo4S7368BLKURPHDzm9R0p5WeZp7LxNg
         4gIEBfLf/0lCzk/iq/rQJ9s1LAsqBhPzQXPyJ0P7ydYsfb+7pxcjUionYf1SUsx5ZY
         j2AUaygz3kTspiqairkru1o3WfqjUliF+vksLCmQ=
Date:   Thu, 31 Jan 2019 19:46:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in relay_open_buf
Message-ID: <20190131184657.GA5338@kroah.com>
References: <00000000000074cbc30580b16bc3@google.com>
 <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com>
 <CAGXu5jLzMdar2d7pmHvzCNdP+5wuEqPk4k7C+aU8ZKzSVxci=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLzMdar2d7pmHvzCNdP+5wuEqPk4k7C+aU8ZKzSVxci=A@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:31:48AM +1300, Kees Cook wrote:
> On Thu, Jan 31, 2019 at 11:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > Can you test the patch below?
> >
> > thanks,
> >
> > greg k-h
> >
> > --------------
> >
> > diff --git a/kernel/relay.c b/kernel/relay.c
> > index 04f248644e06..9e0f52375487 100644
> > --- a/kernel/relay.c
> > +++ b/kernel/relay.c
> > @@ -428,6 +428,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
> >         dentry = chan->cb->create_buf_file(tmpname, chan->parent,
> >                                            S_IRUSR, buf,
> >                                            &chan->is_global);
> > +       if (IS_ERR(dentry))
> > +               dentry = NULL;
> >
> >         kfree(tmpname);
> >
> > @@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
> >                 dentry = chan->cb->create_buf_file(NULL, NULL,
> >                                                    S_IRUSR, buf,
> >                                                    &chan->is_global);
> > -               if (WARN_ON(dentry))
> > +               if (IS_ERR_OR_NULL(dentry))
> >                         goto free_buf;
> >         }
> >
> 
> Thanks! (Can we find other cases of this with static analysis?)

Probably.  I have over 100 patches to help clean up a lot of the debugfs
mess.  But it is very rare that someone actually tries to use the result
of a debugfs call as a "real" dentry, except to pass it back into
another debugfs call.  I "think" I have now caught all of those cases,
and if you can come up with some kind of rule for this, that would be
great.

But note, the create_buf_file() callback is the one that does the
debugfs call, so trying to figure out where that is coming from, what it
does, and what the dentry is later used for, spans lots of different
subsystems and files.  I don't think we have tools to do that, other
than grep :)

greg k-h
