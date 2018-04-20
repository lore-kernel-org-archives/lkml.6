Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeDTPNL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755291AbeDTPNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:13:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000C82178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 11:13:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180420111307.44008fc7@gandalf.local.home>
In-Reply-To: <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
References: <20180413101233.0792ebf0@gandalf.local.home>
        <20180414023516.GA17806@tigerII.localdomain>
        <20180416014729.GB1034@jagdpanzerIV>
        <20180416042553.GA555@jagdpanzerIV>
        <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
        <20180420021511.GB6397@jagdpanzerIV>
        <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
        <20180420080428.622a8e7f@gandalf.local.home>
        <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
        <20180420101751.6c1c70e8@gandalf.local.home>
        <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 16:57:20 +0200
Petr Mladek <pmladek@suse.com> wrote:


> No, call_console_drivers() is done with interrupts disabled:
> 
> 		console_lock_spinning_enable();
> 
> 		stop_critical_timings();	/* don't trace print latency */
>  ---->		call_console_drivers(ext_text, ext_len, text, len);  
> 		start_critical_timings();
> 
> 		if (console_lock_spinning_disable_and_check()) {
>  ---->			printk_safe_exit_irqrestore(flags);  
> 			goto out;
> 		}
> 
>  ---->		printk_safe_exit_irqrestore(flags);  
> 
> They were called with interrupts disabled for ages, long before
> printk_safe. In fact, it was all the time in the git kernel history.
> 
> Therefore only NMIs are in the game. And they should be solved
> by the above change.
> 

Really?


  console_trylock_spinning(); /* console_owner now equals current */
  console_unlock() {

---> take interrupt here:

					vprintk() {
					   vprintk_func() {
					      if (console_owner == current && !__ratelimit(&ratelimit_console))

				[ RATE LIMIT HERE!!!! ]


	for (;;) {
		printk_safe_enter_irqsave(flags);

-- Steve
