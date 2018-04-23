Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755194AbeDWMpF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:45:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755184AbeDWMpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:45:04 -0400
Date: Mon, 23 Apr 2018 14:45:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180423124502.423fb57thvbf3zet@pathway.suse.cz>
References: <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
 <20180420021511.GB6397@jagdpanzerIV>
 <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
 <20180420080428.622a8e7f@gandalf.local.home>
 <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
 <20180420101751.6c1c70e8@gandalf.local.home>
 <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
 <20180420111307.44008fc7@gandalf.local.home>
 <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
 <20180423073603.6b3294ba@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423073603.6b3294ba@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-23 07:36:03, Steven Rostedt wrote:
> On Mon, 23 Apr 2018 12:32:32 +0200
> Ug, you're right. Somehow when I looked at where console_owner was set
> "console_lock_spinning_enabled" I saw it as "console_trylock_spinning".
> 
> This is what I get when I'm trying to follow three threads at the same
> time :-/

They are not easy to follow :-/

> > console_owner is really set only between:
> > 
> >     console_lock_spinning_enable()
> >     console_lock_spinning_disable_and_check()
> > 
> > and this entire section is called with interrupts disabled.
> 
> OK, I agree with you now. Although, one hour may still be too long.

I am not sure how slow are the slowest consoles. If I take that
everything should be faster than 1200 bauds. Then 10 minutes
should be enough for 1000 lines and 80 characters per-line:

   1000*80*8/1200/60 = 8.8888888


Alternatively, it seems that we are going to call console drivers
outside printk_safe context => the messages will appear in the main
log buffer immediately => only small risk of a ping-pong with printk
safe buffers. We might reset the counter when all messages are handled
in console_unlock(). It will be more complex patch than when using
ratelimiting but it still should be sane.

Neither solution is perfect. But I think that the recursion is not
worth any too complex solution.

Best Regards,
Petr
