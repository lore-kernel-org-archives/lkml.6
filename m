Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeA3Hwd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 02:52:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:54491 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeA3Hwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 02:52:30 -0500
Date: Tue, 30 Jan 2018 08:52:26 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, davem@davemloft.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, aarcange@redhat.com, yang.s@alibaba-inc.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, linux-mm@kvack.org, rientjes@google.com,
        akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [netfilter-core] kernel panic: Out of memory and no killable
 processes... (2)
Message-ID: <20180130075226.GL21609@dhcp22.suse.cz>
References: <001a1144b0caee2e8c0563d9de0a@google.com>
 <201801290020.w0T0KK8V015938@www262.sakura.ne.jp>
 <20180129072357.GD5906@breakpoint.cc>
 <20180129082649.sysf57wlp7i7ltb2@node.shutemov.name>
 <20180129165722.GF5906@breakpoint.cc>
 <20180129182811.fze4vrb5zd5cojmr@node.shutemov.name>
 <20180129223522.GG5906@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129223522.GG5906@breakpoint.cc>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-01-18 23:35:22, Florian Westphal wrote:
> Kirill A. Shutemov <kirill@shutemov.name> wrote:
[...]
> > I hate what I'm saying, but I guess we need some tunable here.
> > Not sure what exactly.
> 
> Would memcg help?

That really depends. I would have to check whether vmalloc path obeys
__GFP_ACCOUNT (I suspect it does except for page tables allocations but
that shouldn't be a big deal). But then the other potential problem is
the life time of the xt_table_info (or other potentially large) data
structures. Are they bound to any process life time. Because if they are
not then the OOM killer will not help. The OOM panic earlier in this
thread suggests it doesn't because the test case managed to eat all the
available memory and killed all the eligible tasks which didn't help.

So in some sense the memcg would help to stop the excessive allocation,
but it wouldn't resolve it other than kill all tasks in the affected
memcg/container. Whether this is sufficient or not, I dunno. It sounds
quite suboptimal to me. But it is true this would be less tricky then
adding a global knob...
-- 
Michal Hocko
SUSE Labs
