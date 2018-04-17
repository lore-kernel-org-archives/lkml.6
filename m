Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeDQRGj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeDQRGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:06:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591EF2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 14:06:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417170624.GC7775@kernel.org>
References: <20180417115440.2145f7f5@gandalf.local.home>
 <20180417163527.GA7775@kernel.org>
 <20180417124019.1e4350d5@gandalf.local.home>
 <20180417125723.6506e1d1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417125723.6506e1d1@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 12:57:23PM -0400, Steven Rostedt escreveu:
> On Tue, 17 Apr 2018 12:40:19 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 17 Apr 2018 13:35:27 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > 
> > > [root@jouet ~]# perf test openat
> > >  2: Detect openat syscall event                           : Ok
> > >  3: Detect openat syscall event on all cpus               : Ok
> > > 15: syscalls:sys_enter_openat event fields                : Ok
> > > [root@jouet ~]#
> > > 
> > > [root@jouet ~]# perf trace -e nanosleep,syscalls:*nanosleep sleep 1
> > >      0.000 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffd9f737950, rmtp: 0x00000000
> > >      0.009 (         ): sleep/7905 nanosleep(rqtp: 0x7ffd9f737950                                        ) ...
> > >   1000.204 (         ): syscalls:sys_exit_nanosleep:0x0
> > >      0.009 (1000.217 ms): sleep/7905  ... [continued]: nanosleep()) = 0
> > > [root@jouet ~]#
> > > 
> > > Works, so the regression seems to be fixed, without looking at the code
> > > that much:
> > > 
> > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>  
> > 
> > But does this still work on x86_32? I'll test that out. Thanks for
> > testing, but I may have another patch soon.
> 
> OK, it's still broken there with this patch. I got this:
> 
> # ls /sys/kernel/tracing/events/syscalls
> enable
> filter
> sys_enter_nanosleep
> sys_exit_nanosleep
> 
> But with this:
> 
> 	return !strcmp(sym + 9, name + 3) || !strcmp(sym + 3, name + 3);
> 
> I get all the syscalls back. I'll make another patch.

[root@jouet ~]# ls -lad /e/syscalls/sys_enter_* | wc -l
299
[root@jouet ~]# ls -lad /e/syscalls/sys_* | wc -l
598
[root@jouet ~]# uname -a
Linux jouet 4.17.0-rc1-00025-g69dd313cd795 #11 SMP Tue Apr 17 13:18:44 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]#

With your first patch, I'll change to the above...

- Arnaldo
