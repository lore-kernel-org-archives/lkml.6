Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeBBFfO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:35:14 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35947 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeBBFfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:35:05 -0500
X-Google-Smtp-Source: AH8x226XvHRXDWaYKfcarGpjDoIPyANk5KcV5Az2IoaG4jIlMotHP86QBIJSZ29R9XMDqCcbbIWFgQ==
Date: Thu, 1 Feb 2018 21:35:02 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: syzbot <syzbot+bacbe5d8791f30c9cee5@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        dan.j.williams@intel.com, james.morse@arm.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in get_user_pages_unlocked
Message-ID: <20180202053502.GB949@zzz.localdomain>
References: <001a113f6344393d89056430347d@google.com>
 <20180202045020.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202045020.GF30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 04:50:20AM +0000, Al Viro wrote:
> On Thu, Feb 01, 2018 at 04:58:00PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot hit the following crash on upstream commit
> > 7109a04eae81c41ed529da9f3c48c3655ccea741 (Thu Feb 1 17:37:30 2018 +0000)
> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
> > 
> > So far this crash happened 2 times on upstream.
> > C reproducer is attached.
> 
> Umm...  How reproducible that is?
> 
> > syzkaller reproducer is attached.
> > Raw console output is attached.
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached.
> 
> Can't reproduce with gcc 5.4.1 (same .config, same C reproducer).
> 
> It looks like __get_user_pages_locked() returning with *locked zeroed,
> but ->mmap_sem not dropped.  I don't see what could've lead to it and
> attempts to reproduce had not succeeded so far...
> 
> How long does it normally take for lockdep splat to trigger?
> 

Try starting up multiple instances of the program; that sometimes helps with
these races that are hard to hit (since you may e.g. have a different number of
CPUs than syzbot used).  If I start up 4 instances I see the lockdep splat after
around 2-5 seconds.  This is on latest Linus tree (4bf772b1467).  Also note the
reproducer uses KVM, so if you're running it in a VM it will only work if you've
enabled nested virtualization on the host (kvm_intel.nested=1).

Also it appears to go away if I revert ce53053ce378c21 ("kvm: switch
get_user_page_nowait() to get_user_pages_unlocked()").

- Eric
