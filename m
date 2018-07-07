Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA311C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EB920844
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EB920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeGGQsp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:48:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932575AbeGGQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:48:43 -0400
Received: from localhost (unknown [37.170.108.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D2DE86D;
        Sat,  7 Jul 2018 16:48:41 +0000 (UTC)
Date:   Sat, 7 Jul 2018 18:48:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
Message-ID: <20180707164838.GC16279@kroah.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
 <CA+55aFwg+j60ZFi7t7kVXbobCT4XHoiZP_w6+Cbm+AeU1ytfNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwg+j60ZFi7t7kVXbobCT4XHoiZP_w6+Cbm+AeU1ytfNQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:45:21PM -0700, Linus Torvalds wrote:
> On Thu, Jun 28, 2018 at 7:21 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > Under some circumstances (such as when using kobject debugging)
> > a gluedir whose kref is 0 might remain in the class kset for
> > a long time. The reason is that we don't actively remove glue
> > dirs when they become empty, but instead rely on the implicit
> > removal done by kobject_release(), which can happen some amount
> > of time after the last kobject_put().
> >
> > Using such a dead object is a bad idea and will lead to warnings
> > and crashes.
> 
> So with the other patch in mind, here's my comments on this one. Pick
> one of two scenarios:
> 
>  (a) it's obviously correct.
> 
>      We obviously can *not* take an object with a zero refcount,
> because it is already been scheduled for kobject_cleanup(), and
> incrementing the refcount is simply fundamentally wrong, because
> incrementing the refcount won't unschedule the deletion of the object.
> 
>  (b) the patch is wrong, and our "kobject_get()" should cancel the
> kobject_cleanup() instead.
> 
> There are problems with both of the above cases.
> 
> The "patch is obviously correct" case leads to another issue: why
> would kobject_get() _ever_ succeed on an object wioth a zero refcount?
> IOW, why do we have kobject_get() vs kobject_get_unless_zero() in the
> first place? It is *never* ok to get an kobject with a zero refcount
> because of the above "it's already scheduled for deletion" issue.
> 
> The (b) case sounds nice, and would actually fix the problem that
> patch 2/2 was tryihng to address, and would make
> CONFIG_DEBUG_KOBJECT_RELEASE work.
> 
> HOWEVER. It's completely untenable in reality - it's a nightmare from
> a locking standpoint, because kref_put() literally depends not on
> locking, but on the exclusive "went to zero".
> 
> So I think (b) is practically not acceptable. Which means that (a) is
> the right reaction, and "kobject_get()" on an object with a zero
> refcount is _always_ wrong.
> 
> But that says that "yes, the patch is obviously correct", but it also
> says "the patch should be pointless, because kobject_get() should just
> _always_ have the semantics of "kobject_get_unless_zero()", and the
> latter shouldn't even exist.
> 
> Greg? When would it possibly be valid to do "kobject_get()" on a zero
> refcount object? I don't see it. But this is all very much your code.

No, kobject_get() should never happen on a 0 refcount object.  That
being said, the code does allow it, so if things are messed up, it will
happen.  I think that change happened when the switch to refcount_t
occured, before then we would WARN_ON() if that ever happened.  I should
go fix that up, and restore that old behavior, so that syzbot starts
complaining loudly when stuff like that hits.

So I hate using kobject_get_unless_zero(), and resisted ever adding it
to the tree as it shows a bad locking/tree situation as you point out
here.  But for some reason, the block developers seemed to insist they
needed it, and so it is in the tree for them.  I don't want it to spread
if at all possible, which makes me want to reject this patch as this
should be "a case that can never be hit".

thanks,

greg k-h
