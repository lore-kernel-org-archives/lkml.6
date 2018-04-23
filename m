Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeDWKch (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:32:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40897 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754442AbeDWKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:32:34 -0400
Date: Mon, 23 Apr 2018 12:32:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
References: <20180416014729.GB1034@jagdpanzerIV>
 <20180416042553.GA555@jagdpanzerIV>
 <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
 <20180420021511.GB6397@jagdpanzerIV>
 <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
 <20180420080428.622a8e7f@gandalf.local.home>
 <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
 <20180420101751.6c1c70e8@gandalf.local.home>
 <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
 <20180420111307.44008fc7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420111307.44008fc7@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-20 11:13:07, Steven Rostedt wrote:
> On Fri, 20 Apr 2018 16:57:20 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> 
> > No, call_console_drivers() is done with interrupts disabled:
> > 
> > 		console_lock_spinning_enable();
> > 
> > 		stop_critical_timings();	/* don't trace print latency */
> >  ---->		call_console_drivers(ext_text, ext_len, text, len);  
> > 		start_critical_timings();
> > 
> > 		if (console_lock_spinning_disable_and_check()) {
> >  ---->			printk_safe_exit_irqrestore(flags);  
> > 			goto out;
> > 		}
> > 
> >  ---->		printk_safe_exit_irqrestore(flags);  
> > 
> > They were called with interrupts disabled for ages, long before
> > printk_safe. In fact, it was all the time in the git kernel history.
> > 
> > Therefore only NMIs are in the game. And they should be solved
> > by the above change.
> > 
> 
> Really?
> 
> 
>   console_trylock_spinning(); /* console_owner now equals current */

No, console_trylock_spinning() does not modify console_owner. The
handshake is done using console_waiter variable.

console_owner is really set only between:

    console_lock_spinning_enable()
    console_lock_spinning_disable_and_check()

and this entire section is called with interrupts disabled.

Best Regards,
Petr
