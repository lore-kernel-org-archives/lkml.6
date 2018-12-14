Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01137C43177
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF71E206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544795662;
	bh=wBZqVnn0WTakeveexYJmIdK86FMFoZHd7QAbOV89T50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xgpX3rjZNi75RDdNLgcfag1IKFHYi5sNJhHYeHn3ow9qGrHdRt6flZMMN9PTcbC5I
	 j387DjZwsuAaAXZisZdEEDL8wsnVYHPSTPLbK8PAEoaQ6SOUG0TeAWbFCrVQqu695+
	 tuG/XiHLQIW5ZQi/wj9zEVoRp3PUjOGO0NrgUryA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeLNNyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:54:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:57164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729698AbeLNNyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3342BAE4D;
        Fri, 14 Dec 2018 13:54:20 +0000 (UTC)
Date:   Fri, 14 Dec 2018 14:54:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        rafael.j.wysocki@intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vkuznets@redhat.com, Linux-MM <linux-mm@kvack.org>
Subject: Re: general protection fault in watchdog
Message-ID: <20181214135419.GG5343@dhcp22.suse.cz>
References: <0000000000004ea80b057cfae21e@google.com>
 <CACT4Y+Z+AhQxf6=ecOkX1bOU5h7kMHYnR6CAhBv9eO5jQVeG3g@mail.gmail.com>
 <20181214132836.GE5343@dhcp22.suse.cz>
 <CACT4Y+aXFXnObgC-7NVe87-1bbqs2oNBBXe2mrfshLKnFqkTGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aXFXnObgC-7NVe87-1bbqs2oNBBXe2mrfshLKnFqkTGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-12-18 14:42:33, Dmitry Vyukov wrote:
> On Fri, Dec 14, 2018 at 2:28 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 14-12-18 14:11:05, Dmitry Vyukov wrote:
> > > On Fri, Dec 14, 2018 at 1:51 PM syzbot
> > > <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16aca143400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7713f3aa67be76b1552c
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1131381b400000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bae593400000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
> > >
> > > +linux-mm for memcg question
> > >
> > > What the repro does is effectively just
> > > setsockopt(EBT_SO_SET_ENTRIES). This eats all machine memory and
> > > causes OOMs. Somehow it also caused the GPF in watchdog when it
> > > iterates over task list, perhaps some scheduler code leaves a dangling
> > > pointer on OOM failures.
> > >
> > > But what bothers me is a different thing. syzkaller test processes are
> > > sandboxed with a restrictive memcg which should prevent them from
> > > eating all memory. do_replace_finish calls vmalloc, which uses
> > > GFP_KERNEL, which does not include GFP_ACCOUNT (GFP_KERNEL_ACCOUNT
> > > does). And page alloc seems to change memory against memcg iff
> > > GFP_ACCOUNT is provided.
> > > Am I missing something or vmalloc is indeed not accounted (DoS)? I see
> > > some explicit uses of GFP_KERNEL_ACCOUNT, e.g. the one below, but they
> > > seem to be very sparse.
> > >
> > > static void *seq_buf_alloc(unsigned long size)
> > > {
> > >      return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> > > }
> > >
> > > Now looking at the code I also don't see how kmalloc(GFP_KERNEL) is
> > > accounted... Which makes me think I am still missing something.
> >
> > You are not missing anything. We do not account all allocations and you
> > have to explicitly opt-in by __GFP_ACCOUNT. This is a deliberate
> > decision. If the allocation is directly controlable by an untrusted user
> > and the memory is associated with a process life time then this looks
> > like a good usecase for __GFP_ACCOUNT. If an allocation outlives a
> > process then there the flag should be considered with a great care
> > because oom killer is not able to resolve the memcg pressure and so the
> > limit enforcement is not effective.
> 
> Interesting.
> I understand that namespaces, memcg's and processes (maybe even
> threads) can have arbitrary overlapping. But I naively thought that in
> canonical hierarchical cases it should all somehow work.
> Question 1: is there some other, stricter sandboxing mechanism?

I do not think so

> We try
> to sandbox syzkaller processes with everything available , because
> these OOMs usually leads either to dead machines or hang/stall false
> positives, which are nasty.

Which is a useful test on its own. If you are able to trigger the global
OOM from a restricted environment then you have a good candidate to
consider a new __GFP_ACCOUNT user.

> Question 2: this is a simple DoS vector, right? If I put a container
> into a 1MB memcg, it can still eat arbitrary amount of non-pagable
> kernel memory?

As I've said. If there is a direct vector to allocated an unbounded
amount of memory from the userspace (trusted users aside) then yes this
sounds like a DoS to me.

-- 
Michal Hocko
SUSE Labs
