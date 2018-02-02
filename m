Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeBBGUy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:20:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48420 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeBBGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:20:48 -0500
Date: Fri, 2 Feb 2018 06:20:37 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: syzbot <syzbot+bacbe5d8791f30c9cee5@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        dan.j.williams@intel.com, james.morse@arm.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in get_user_pages_unlocked
Message-ID: <20180202062037.GH30522@ZenIV.linux.org.uk>
References: <001a113f6344393d89056430347d@google.com>
 <20180202045020.GF30522@ZenIV.linux.org.uk>
 <20180202053502.GB949@zzz.localdomain>
 <20180202054626.GG30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202054626.GG30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 05:46:26AM +0000, Al Viro wrote:
> On Thu, Feb 01, 2018 at 09:35:02PM -0800, Eric Biggers wrote:
> 
> > Try starting up multiple instances of the program; that sometimes helps with
> > these races that are hard to hit (since you may e.g. have a different number of
> > CPUs than syzbot used).  If I start up 4 instances I see the lockdep splat after
> > around 2-5 seconds.
> 
> 5 instances in parallel, 10 minutes into the run...
> 
> >  This is on latest Linus tree (4bf772b1467).  Also note the
> > reproducer uses KVM, so if you're running it in a VM it will only work if you've
> > enabled nested virtualization on the host (kvm_intel.nested=1).
> 
> cat /sys/module/kvm_amd/parameters/nested 
> 1
> 
> on host
> 
> > Also it appears to go away if I revert ce53053ce378c21 ("kvm: switch
> > get_user_page_nowait() to get_user_pages_unlocked()").
> 
> That simply prevents this reproducer hitting get_user_pages_unlocked()
> instead of grab mmap_sem/get_user_pages/drop mmap_sem.  I.e. does not
> allow __get_user_pages_locked() to drop/regain ->mmap_sem.
> 
> The bug may be in the way we call get_user_pages_unlocked() in that
> commit, but it might easily be a bug in __get_user_pages_locked()
> exposed by that reproducer somehow.

I think I understand what's going on.  FOLL_NOWAIT handling is a serious
mess ;-/  I'll probably have something to test tomorrow - I still can't
reproduce it here, unfortunately.
