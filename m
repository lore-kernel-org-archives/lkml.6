Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8AFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DAA206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DAA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeLCMBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:01:38 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59805 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeLCMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:01:37 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 092ef13845e76dbe; Mon, 3 Dec 2018 13:00:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
Date:   Mon, 03 Dec 2018 13:00:41 +0100
Message-ID: <6573018.UI13nD0mEW@aspire.rjw.lan>
In-Reply-To: <20181203074700.GA21240@gmail.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com> <20181203074700.GA21240@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 3, 2018 8:47:00 AM CET Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > The patch stats this week look a little bit more normal than last tim,
> > probably simply because it's also a normal-sized rc4 rather than the
> > unusually small rc3.
> 
> So there's a new regression in v4.20-rc4, my desktop produces this 
> lockdep splat:
> 
> [ 1772.588771] WARNING: pkexec/4633 still has locks held!
> [ 1772.588773] 4.20.0-rc4-custom-00213-g93a49841322b #1 Not tainted
> [ 1772.588775] ------------------------------------
> [ 1772.588776] 1 lock held by pkexec/4633:
> [ 1772.588778]  #0: 00000000ed85fbf8 (&sig->cred_guard_mutex){+.+.}, at: prepare_bprm_creds+0x2a/0x70
> [ 1772.588786] stack backtrace:
> [ 1772.588789] CPU: 7 PID: 4633 Comm: pkexec Not tainted 4.20.0-rc4-custom-00213-g93a49841322b #1
> [ 1772.588792] Call Trace:
> [ 1772.588800]  dump_stack+0x85/0xcb
> [ 1772.588803]  flush_old_exec+0x116/0x890
> [ 1772.588807]  ? load_elf_phdrs+0x72/0xb0
> [ 1772.588809]  load_elf_binary+0x291/0x1620
> [ 1772.588815]  ? sched_clock+0x5/0x10
> [ 1772.588817]  ? search_binary_handler+0x6d/0x240
> [ 1772.588820]  search_binary_handler+0x80/0x240
> [ 1772.588823]  load_script+0x201/0x220
> [ 1772.588825]  search_binary_handler+0x80/0x240
> [ 1772.588828]  __do_execve_file.isra.32+0x7d2/0xa60
> [ 1772.588832]  ? strncpy_from_user+0x40/0x180
> [ 1772.588835]  __x64_sys_execve+0x34/0x40
> [ 1772.588838]  do_syscall_64+0x60/0x1c0
> 
> The warning gets triggered by an ancient lockdep check in the freezer:
> 
> (gdb) list *0xffffffff812ece06
> 0xffffffff812ece06 is in flush_old_exec (./include/linux/freezer.h:57).
> 52	 * DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION
> 53	 * If try_to_freeze causes a lockdep warning it means the caller may deadlock
> 54	 */
> 55	static inline bool try_to_freeze_unsafe(void)
> 56	{
> 57		might_sleep();
> 58		if (likely(!freezing(current)))
> 59			return false;
> 60		return __refrigerator(false);
> 61	}
> 
> I reviewed the ->cred_guard_mutex code, and the mutex is held across all 
> of exec() - and we always did this.
> 
> But there's this recent -rc4 commit:
> 
> > Chanho Min (1):
> >       exec: make de_thread() freezable
> 
>   c22397888f1e: exec: make de_thread() freezable
> 
> I believe this commit is bogus, you cannot call try_to_freeze() from 
> de_thread(), because it's holding the ->cred_guard_mutex.
> 
> Also, I'm 3 times grumpy:

Well, sorry about that.

>  #1: I think this commit was never tested with lockdep turned on, as I 
>      think splat this should trigger 100% of the time with the ELF 
>      binfmt loader.

It has been there in my local builds/tests, so I must have overlooked the
splat.

>  #2: Less than 4 days passed between the commit on Nov 19 and it being 
>      upstream by Nov 23. *Please* give it more testing if you change 
>      something as central as fs/exec.c ...

It has been under review for quite a bit more time though and I had hoped
that there would be some reports from linux-next coverage if there were
problems with it, but nothig has been reported till now.

>  #3  Also, please also proof-read changelogs before committing them:

I do that as a rule and I tend to fix up such things in changelogs.

Not sure why I didn't do that this time.  Because of travel perhaps.

>      >>  The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
>      >>  [...]
>      >>
>      >>  In our machine, it causes freeze timeout as bellows.
> 
>      That's *three* typos in a single commit:
> 
>         s/casue/cause
>         s/In our/On our
>         s/bellows/below
> 
>      ...
> 
> Grump! :-)
> 
> Note that I haven't tested the revert yet, but the code and the breakage 
> looks pretty obvious. (I'll boot the revert, will follow up if that 
> didn't solve the problem.)

I can queue up a revert unless anyone beats me to that.

Thanks,
Rafael

