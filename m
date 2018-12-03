Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C263206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C263206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLCL4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:56:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCL4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:56:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2D6B83F4C;
        Mon,  3 Dec 2018 11:56:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54CE2272C6;
        Mon,  3 Dec 2018 11:56:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  3 Dec 2018 12:56:04 +0100 (CET)
Date:   Mon, 3 Dec 2018 12:56:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Pavel Machek <pavel@ucw.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203115601.GA31795@redhat.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203074700.GA21240@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 03 Dec 2018 11:56:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Ingo Molnar wrote:
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

My fault.

Michal didn't like this patch, but I managed to confuse him ;)

I even mentioned that freezable_schedule() is obviously not right with
->cred_guard_mutex held, but I somehow I thought that this patch "doesn't
make things worse".

> I reviewed the ->cred_guard_mutex code, and the mutex is held across all
> of exec() - and we always did this.

Yes, and this was always wrong. For example, this test-case hangs:

	#include <unistd.h>
	#include <signal.h>
	#include <sys/ptrace.h>
	#include <pthread.h>

	void *thread(void *arg)
	{
		ptrace(PTRACE_TRACEME, 0,0,0);
		return NULL;
	}

	int main(void)
	{
		int pid = fork();

		if (!pid) {
			pthread_t pt;
			pthread_create(&pt, NULL, thread, NULL);
			pthread_join(pt, NULL);
			execlp("echo", "echo", "passed", NULL);
		}

		sleep(1);
		// or anything else which needs ->cred_guard_mutex,
		// say open(/proc/$pid/mem)
		ptrace(PTRACE_ATTACH, pid, 0,0);
		kill(pid, SIGCONT);

		return 0;
	}

we really need to narrow the (huge) scope of ->cred_guard_mutex in exec paths.

my attempt to fix this was nacked, and nobody suggested a better solution so far.

> This reverts commit c22397888f1eed98cd59f0a88f2a5f6925f80e15.

Thanks.

> ---
>  fs/exec.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index acc3a5536384..fc281b738a98 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -62,7 +62,6 @@
>  #include <linux/oom.h>
>  #include <linux/compat.h>
>  #include <linux/vmalloc.h>
> -#include <linux/freezer.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -1084,7 +1083,7 @@ static int de_thread(struct task_struct *tsk)
>  	while (sig->notify_count) {
>  		__set_current_state(TASK_KILLABLE);
>  		spin_unlock_irq(lock);
> -		freezable_schedule();
> +		schedule();
>  		if (unlikely(__fatal_signal_pending(tsk)))
>  			goto killed;
>  		spin_lock_irq(lock);
> @@ -1112,7 +1111,7 @@ static int de_thread(struct task_struct *tsk)
>  			__set_current_state(TASK_KILLABLE);
>  			write_unlock_irq(&tasklist_lock);
>  			cgroup_threadgroup_change_end(tsk);
> -			freezable_schedule();
> +			schedule();
>  			if (unlikely(__fatal_signal_pending(tsk)))
>  				goto killed;
>  		}

