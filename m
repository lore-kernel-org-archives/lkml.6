Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755667AbeEAABt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:01:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753530AbeEAABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:01:47 -0400
Date: Mon, 30 Apr 2018 17:01:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mhocko@suse.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        fengguang.wu@intel.com, dennisszhou@gmail.com
Subject: Re: [PATCH v2] mm: access to uninitialized struct page
Message-Id: <20180430170145.544342905604331c0e1b95d9@linux-foundation.org>
In-Reply-To: <20180430195858.5242373c@gandalf.local.home>
References: <20180426202619.2768-1-pasha.tatashin@oracle.com>
        <20180430162658.598dd5dcdd0c67e36953281c@linux-foundation.org>
        <20180430195858.5242373c@gandalf.local.home>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 19:58:58 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Apr 2018 16:26:58 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Thu, 26 Apr 2018 16:26:19 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> > 
> > > The following two bugs were reported by Fengguang Wu:
> > > 
> > > kernel reboot-without-warning in early-boot stage, last printk:
> > > early console in setup code
> > > 
> > > http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com
> > > 
> > > ...
> > >
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -585,8 +585,8 @@ asmlinkage __visible void __init start_kernel(void)
> > >  	setup_log_buf(0);
> > >  	vfs_caches_init_early();
> > >  	sort_main_extable();
> > > -	trap_init();
> > >  	mm_init();
> > > +	trap_init();
> > >  
> > >  	ftrace_init();  
> > 
> > Gulp.  Let's hope that nothing in mm_init() requires that trap_init()
> > has been run.  What happens if something goes wrong during mm_init()
> > and the architecture attempts to raise a software exception, hits a bus
> > error, div-by-zero, etc, etc?  Might there be hard-to-discover
> > dependencies in such a case?
> 
> I mentioned the same thing.
> 

I guess the same concern applies to all the code which we've always run
before trap_init(), and that's quite a lot of stuff.  So we should be
OK.  But don't quote me ;)
