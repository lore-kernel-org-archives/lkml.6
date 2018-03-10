Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbeCJEPP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 23:15:15 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43915 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeCJEPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 23:15:14 -0500
X-Google-Smtp-Source: AG47ELvrkgAQdT+JkuSnpJS4zwdf29rrYxanqyJBfOb8hvSfa8xmIJkWcyag9I0p8NuSFT+CAH8Rdg==
Date: Fri, 9 Mar 2018 20:15:05 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bacbe5d8791f30c9cee5@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        James Morse <james.morse@arm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Ingo Molnar <mingo@kernel.org>, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in get_user_pages_unlocked
Message-ID: <20180310041505.GA598@zzz.localdomain>
References: <001a113f6344393d89056430347d@google.com>
 <20180202045020.GF30522@ZenIV.linux.org.uk>
 <20180202053502.GB949@zzz.localdomain>
 <20180202054626.GG30522@ZenIV.linux.org.uk>
 <20180202062037.GH30522@ZenIV.linux.org.uk>
 <CACT4Y+bDU00aQpJOUK8eB+Kv4HycNwKA=kShUe9kSd0FUqO+FQ@mail.gmail.com>
 <20180210013640.GN30522@ZenIV.linux.org.uk>
 <20180210031925.GA1041@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210031925.GA1041@zzz.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 07:19:25PM -0800, Eric Biggers wrote:
> Hi Al,
> 
> On Sat, Feb 10, 2018 at 01:36:40AM +0000, Al Viro wrote:
> > On Fri, Feb 02, 2018 at 09:57:27AM +0100, Dmitry Vyukov wrote:
> > 
> > > syzbot tests for up to 5 minutes. However, if there is a race involved
> > > then you may need more time because the crash is probabilistic.
> > > But from what I see most of the time, if one can't reproduce it
> > > easily, it's usually due to some differences in setup that just don't
> > > allow the crash to happen at all.
> > > FWIW syzbot re-runs each reproducer on a freshly booted dedicated VM
> > > and what it provided is the kernel output it got during run of the
> > > provided program. So we have reasonably high assurance that this
> > > reproducer worked in at least one setup.
> > 
> > Could you guys check if the following fixes the reproducer?
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 61015793f952..058a9a8e4e2e 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -861,6 +861,9 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
> >  		BUG_ON(*locked != 1);
> >  	}
> >  
> > +	if (flags & FOLL_NOWAIT)
> > +		locked = NULL;
> > +
> >  	if (pages)
> >  		flags |= FOLL_GET;
> >  
> 
> Yes that fixes the reproducer for me.
> 

Just to follow up on this: it seems that Al's suggested fix didn't go anywhere,
but someone else eventually ran into this bug (which was a real deadlock) and a
slightly different fix was merged, commit 96312e61282ae.  It fixes the
reproducer for me too.  Telling syzbot so that it can close the bug:

#syz fix: mm/gup.c: teach get_user_pages_unlocked to handle FOLL_NOWAIT

- Eric
