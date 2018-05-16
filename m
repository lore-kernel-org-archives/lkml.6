Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEPVlB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:41:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51121 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbeEPVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:40:58 -0400
X-ME-Proxy: <xmx:aaX8WunqwH5hH_VpUeiPjfx096PZjoxMtSCs8fDUOvk6b3TSdFl2MA>
X-ME-Proxy: <xmx:aaX8Wv7NV-cS61SNdes6CvdD1lXRYt74335LfVU0EvjXgNeleAlQQg>
X-ME-Proxy: <xmx:aaX8WrsE2fHiYSTNrnBv-WC4ZwGY2eus-fbhbW4Wa3-aS5NEYkttog>
X-ME-Proxy: <xmx:aaX8Wqt4di8lD8xsizSRCltgJCiBpyAx6rOVSoF7ua0VyEcX8kUmQg>
X-ME-Proxy: <xmx:aaX8Wo6GazSt78x2Q5v2da4ZbpkMnjSHylvezBTXcM_oaDN1XtqEzQ>
X-ME-Proxy: <xmx:aaX8WggdItAHA3VgD6QK111NkPjf8elWG7pI1iKDWXmbuRJHIKvZgw>
X-ME-Sender: <xms:aaX8Wi-TXyJmF8BhCK4vXAwRpThSBBSXElcwSAHcIFZpHBCvgLKCoQ>
Date: Thu, 17 May 2018 07:40:53 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] vsprintf: Replace memory barrier with static_key for
 random_ptr_key update
Message-ID: <20180516214053.GA25268@eros>
References: <20180516091241.2ea940d1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516091241.2ea940d1@gandalf.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 09:12:41AM -0400, Steven Rostedt wrote:
> 
> Linus,
> 
> The memory barrier usage in updating the random ptr hash for %p in
> vsprintf is incorrect. Instead of adding the read memory barrier
> into vsprintf() which will cause a slight degradation to a commonly
> used function in the kernel just to solve a very unlikely race
> condition that can only happen at boot up, change the code from
> using a variable branch to a static_branch. Not only does this solve
> the race condition, it actually will improve the performance of
> vsprintf() by removing the conditional branch that is only needed
> at boot.
> 
> 
> Please pull the latest trace-v4.17-rc5-vsprintf tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v4.17-rc5-vsprintf
> 
> Tag SHA1: 3e2a2dfc8987e9a2b4e185b65a9b48c374c80791
> Head SHA1: 85f4f12d51397f1648e1f4350f77e24039b82d61
> 
> 
> Steven Rostedt (VMware) (1):
>       vsprintf: Replace memory barrier with static_key for random_ptr_key update
> 
> ----
>  lib/vsprintf.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> ---------------------------
> commit 85f4f12d51397f1648e1f4350f77e24039b82d61
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Tue May 15 22:24:52 2018 -0400
> 
>     vsprintf: Replace memory barrier with static_key for random_ptr_key update
>     
>     Reviewing Tobin's patches for getting pointers out early before
>     entropy has been established, I noticed that there's a lone smp_mb() in
>     the code. As with most lone memory barriers, this one appears to be
>     incorrectly used.
>     
>     We currently basically have this:
>     
>             get_random_bytes(&ptr_key, sizeof(ptr_key));
>             /*
>              * have_filled_random_ptr_key==true is dependent on get_random_bytes().
>              * ptr_to_id() needs to see have_filled_random_ptr_key==true
>              * after get_random_bytes() returns.
>              */
>             smp_mb();
>             WRITE_ONCE(have_filled_random_ptr_key, true);
>     
>     And later we have:
>     
>             if (unlikely(!have_filled_random_ptr_key))
>                     return string(buf, end, "(ptrval)", spec);
>     
>     /* Missing memory barrier here. */
>     
>             hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
>     
>     As the CPU can perform speculative loads, we could have a situation
>     with the following:
>     
>             CPU0                            CPU1
>             ----                            ----
>                                        load ptr_key = 0
>        store ptr_key = random
>        smp_mb()
>        store have_filled_random_ptr_key
>     
>                                        load have_filled_random_ptr_key = true
>     
>                                         BAD BAD BAD! (you're so bad!)

The additional clarification in this line, added for the pull request, is pure gold.


	Tobin
