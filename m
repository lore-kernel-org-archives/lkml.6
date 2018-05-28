Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeE1P4R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:56:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44507 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425272AbeE1PyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:54:20 -0400
Date: Mon, 28 May 2018 14:27:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180528122732.shvdlvc3pmg5k5rj@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180517143903.19339-1-pmladek@suse.com>
 <20180522174320.10ced885@gandalf.local.home>
 <20180523020107.GA8465@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523020107.GA8465@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-05-23 11:01:07, Sergey Senozhatsky wrote:
> On (05/22/18 17:43), Steven Rostedt wrote:
> > > CPU0			CPU1			CPU2
> > > 
> > > printk()
> > >   vprintk_emit()
> > >     spin_lock(&logbuf_lock)
> > > 
> > > 						trigger_all_cpu_backtrace()
> > > 						  raise()
> > > 
> > > 			nmi_enter()
> > > 			  printk_nmi_enter()
> > > 			    if (this_cpu_read(printk_context)
> > > 			      & PRINTK_SAFE_CONTEXT_MASK)
> > > 			      // false
> > > 			    else
> > > 			      // looks safe to use printk_deferred()
> > > 			      this_cpu_or(printk_context,
> > > 				PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> > > 
> > > 			  nmi_cpu_backtrace()
> > > 			    arch_spin_lock(&lock);
> > 
> > What branch is this based on, because I can't find the
> > "arch_spin_lock()" you are talking about here.
> 
> This arch_spin_lock() is in lib/nmi_backtrace.c
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/nmi_backtrace.c?h=v4.17-rc6#n94

JFYI, I have pushed the patch into printk.git, for-4.18 branch, see
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.18&id=42f139d887cbb2c396dd61f4f13d4facfde5739e

Best Regards,
Petr
