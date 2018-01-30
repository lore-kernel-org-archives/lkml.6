Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeA3IOl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:14:41 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:40482 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751822AbeA3IOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:14:39 -0500
Date: Tue, 30 Jan 2018 09:11:27 +0100
From: Florian Westphal <fw@strlen.de>
To: Michal Hocko <mhocko@kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, davem@davemloft.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, aarcange@redhat.com, yang.s@alibaba-inc.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, linux-mm@kvack.org, rientjes@google.com,
        akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [netfilter-core] kernel panic: Out of memory and no killable
 processes... (2)
Message-ID: <20180130081127.GH5906@breakpoint.cc>
References: <001a1144b0caee2e8c0563d9de0a@google.com>
 <201801290020.w0T0KK8V015938@www262.sakura.ne.jp>
 <20180129072357.GD5906@breakpoint.cc>
 <20180129082649.sysf57wlp7i7ltb2@node.shutemov.name>
 <20180129165722.GF5906@breakpoint.cc>
 <20180129182811.fze4vrb5zd5cojmr@node.shutemov.name>
 <20180129223522.GG5906@breakpoint.cc>
 <20180130075226.GL21609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180130075226.GL21609@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 29-01-18 23:35:22, Florian Westphal wrote:
> > Kirill A. Shutemov <kirill@shutemov.name> wrote:
> [...]
> > > I hate what I'm saying, but I guess we need some tunable here.
> > > Not sure what exactly.
> > 
> > Would memcg help?
> 
> That really depends. I would have to check whether vmalloc path obeys
> __GFP_ACCOUNT (I suspect it does except for page tables allocations but
> that shouldn't be a big deal). But then the other potential problem is
> the life time of the xt_table_info (or other potentially large) data
> structures. Are they bound to any process life time.

No.

> Because if they are
> not then the OOM killer will not help. The OOM panic earlier in this
> thread suggests it doesn't because the test case managed to eat all the
> available memory and killed all the eligible tasks which didn't help.

Yes, which is why we do not want any OOM killer invocation in first
place...

> So in some sense the memcg would help to stop the excessive allocation,
> but it wouldn't resolve it other than kill all tasks in the affected
> memcg/container. Whether this is sufficient or not, I dunno. It sounds
> quite suboptimal to me. But it is true this would be less tricky then
> adding a global knob...

Global knob doesn't really help at all, I can add multiple large
iptables rulesets (so we would have to account), and we have same issue
in virtually all of networking, so we need limits for interface count,
tunnel count, ipsec policies/SAs, nftables, tc, etc etc.
