Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69A2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfAJKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:03:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:35496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727780AbfAJKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:03:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97673ACD1;
        Thu, 10 Jan 2019 10:03:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 11:03:51 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 09/15] epoll: introduce stand-alone helpers for
 polling from userspace
In-Reply-To: <CAHk-=whD=pjn4myRysuyeAiNOxv49XVQuJaE7Xd6ZBEMf6eXtA@mail.gmail.com>
References: <20190109164025.24554-1-rpenyaev@suse.de>
 <20190109164025.24554-10-rpenyaev@suse.de>
 <CAHk-=whD=pjn4myRysuyeAiNOxv49XVQuJaE7Xd6ZBEMf6eXtA@mail.gmail.com>
Message-ID: <6f86fe7564d3bb088c2c73f8d699bc71@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 18:29, Linus Torvalds wrote:
> On Wed, Jan 9, 2019 at 8:40 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>> 
>> ep_vrealloc*()
>>     realloc user header, user index or bitmap memory
> 
> What? No.
> 
> This is wrong, it's much too complicated. And because your
> 'vrealloc()' doesn't follow the normal realloc rules, it looks both
> confusing and buggy, and people have to remember that "oh, vrealloc()
> isn't actually vrealloc(), it's really vdupalloc()".
> 
> Your other patch to allow users to apparently also do mremap of these
> things seems entirely wrongheaded too. Especially when you then have
> magical rules for vm_pgoff, which is one of the things that unmapping
> parts of a mmap will touch.
> 
> So I say no, no, no. This is all *much* too complicated, and the
> interfaces are mis-designed to be overly generous to people doing odd
> and pointless things.
> 
> If you can't have a fixed-size user buffer that stays in one place,
> don't even bother.

I agree that set of "rules" for this interface is indeed complicated.
The goal was to solve the problem with a constantly changing set of
items (which can be increased / decreased from another thread) without
adding new ctl calls or any limitations.

To fix the size of a user buffer is seems easy to do.  One way is still
to support expand with, say, epoll_ctl(EPOLL_CTL_EXPAND) call and user
has to react explicitly on ENOSPC from epoll_ctl(EPOLL_CTL_ADD).  Thus
reallocation happens, but by user request.

Another way seems much simpler but has a limitation: user has to specify
expected max limit passing the value to a new epoll_create syscall, e.g.
epoll_create2(EPOLL_USERPOLL, 1000). Further attempt to add 1001 
descriptor
will end with ENOSPC. Period. No magic under the hood. Another 1001
descriptor can be added to a new epoll, which can be nested then (what
is forbidden for "polled from user" descriptors in current 
implementation,
but should not be difficult to allow). Then yes, no remapping / 
reallocating.
But this epoll nesting thing ... Which personally I do not like.

What do you think?

--
Roman
