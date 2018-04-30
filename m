Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755563AbeD3X7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753530AbeD3X7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:59:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E2C22D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 30 Apr 2018 19:58:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mhocko@suse.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        fengguang.wu@intel.com, dennisszhou@gmail.com
Subject: Re: [PATCH v2] mm: access to uninitialized struct page
Message-ID: <20180430195858.5242373c@gandalf.local.home>
In-Reply-To: <20180430162658.598dd5dcdd0c67e36953281c@linux-foundation.org>
References: <20180426202619.2768-1-pasha.tatashin@oracle.com>
        <20180430162658.598dd5dcdd0c67e36953281c@linux-foundation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 16:26:58 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 26 Apr 2018 16:26:19 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> 
> > The following two bugs were reported by Fengguang Wu:
> > 
> > kernel reboot-without-warning in early-boot stage, last printk:
> > early console in setup code
> > 
> > http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com
> > 
> > ...
> >
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -585,8 +585,8 @@ asmlinkage __visible void __init start_kernel(void)
> >  	setup_log_buf(0);
> >  	vfs_caches_init_early();
> >  	sort_main_extable();
> > -	trap_init();
> >  	mm_init();
> > +	trap_init();
> >  
> >  	ftrace_init();  
> 
> Gulp.  Let's hope that nothing in mm_init() requires that trap_init()
> has been run.  What happens if something goes wrong during mm_init()
> and the architecture attempts to raise a software exception, hits a bus
> error, div-by-zero, etc, etc?  Might there be hard-to-discover
> dependencies in such a case?

I mentioned the same thing.

-- Steve
