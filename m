Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDYHQo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:16:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750929AbeDYHQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:16:40 -0400
Date: Wed, 25 Apr 2018 09:16:35 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Ahern <dsa@cumulusnetworks.com>, brouer@redhat.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: Boot failures with net-next after rebase to v4.17.0-rc1
Message-ID: <20180425091635.7e8a7ffd@redhat.com>
In-Reply-To: <CA+55aFx-V8L602X-EHgrJPNA49v_ZiBZW=+v=tcSQK5QZOXYJw@mail.gmail.com>
References: <20180424215429.1de8b1b3@redhat.com>
        <CA+55aFx-V8L602X-EHgrJPNA49v_ZiBZW=+v=tcSQK5QZOXYJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 13:04:23 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Apr 24, 2018 at 12:54 PM, Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> > Hi all,
> >
> > I'm experiencing boot failures with net-next git-tree after it got
> > rebased/merged with Linus'es tree at v4.17.0-rc1.  
> 
> I suspect it's the global bit stuff that came in very late in the
> merge window, and had been developed and tested for a while before,
> but showed some problems under some configs.
> 
> The fix is currently in the x86/pti tree in -tip, see:
> 
>    x86/pti: Fix boot problems from Global-bit setting
> 
> and I expect it will percolate upstream soon.
> 
> In the meantime, it would be good to verify that merging that x86/pti
> branch fixes it for you?

Thanks for spotting this so quickly!
I have verified that this DOES solve the issue for me :-)))

If others are hit by this, and cannot wait for Linus to pull the tip
tree, this is the pull command:

 git pull git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti


> There is another candidate for boot problems - do you happen to have
> CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled? That can under certain
> circumstances get a percpu setup page fault because memory hadn't been
> initialized sufficiently.

CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set

> The fix there is to move the mm_init() call one step earlier in
> init_main(): start_kernel() (to before trap_init()).
> 
> And if it's neither of the above, I think you'll need to help bisect it.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
