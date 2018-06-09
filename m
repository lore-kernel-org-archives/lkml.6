Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 75ZGEDrfG1tNSQAAmS7hNA
	; Sat, 09 Jun 2018 14:07:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 18E0B608B8; Sat,  9 Jun 2018 14:07:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqDx4mS8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66989601D2;
	Sat,  9 Jun 2018 14:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66989601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeFIOHv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbeFIOHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:07:50 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259B42075E;
        Sat,  9 Jun 2018 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528553269;
        bh=XrohN0RAeOWsB0StJW07mIdDFhku6U0J0woB6pFzJY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqDx4mS8Pv12llhz4jVT4lzqwmePKwU1Cu+a1KCLwxUcUzAWEnqzUDeVwzpX20i4z
         MhdwM5lgZVUbslN/MqAUpDcYM7xaBTdcWOkKdD/OJXZO5Btmqq/bgH6/wTsYzVxuzI
         wBT7BaoIevCYpOidw70PY8MYumeAFnn3JnfKxYns=
Date: Sat, 9 Jun 2018 16:07:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mlen@mlen.pl, bugzilla-daemon@bugzilla.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Bug 199965] New: Memory management: BUG in kernel_restart
Message-ID: <20180609140726.GE28854@kroah.com>
References: <bug-199965-27@https.bugzilla.kernel.org/>
 <20180608151508.d0c250db2a0900d4ebb2b115@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608151508.d0c250db2a0900d4ebb2b115@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:15:08PM -0700, Andrew Morton wrote:
> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Thu, 07 Jun 2018 18:21:24 +0000 bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=199965
> > 
> >             Bug ID: 199965
> >            Summary: Memory management: BUG in kernel_restart
> >            Product: Memory Management
> >            Version: 2.5
> >     Kernel Version: 4.17.0
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Other
> >           Assignee: akpm@linux-foundation.org
> >           Reporter: mlen@mlen.pl
> >         Regression: No
> > 
> > Reboot randomly fails on 4.17.0 due to memory management issues. Worked fine on
> > 4.16.13
> 
> Oh gee, there isn't much to go on here.  Unknown kobject on
> devices_kset() is in a crappy state during kernel restart.  Greg, is
> there something we can do to make that kobject_get() warning more
> informative?  Probably not.
> 
> 
> > <4>[21100.397182] ------------[ cut here ]------------
> > <4>[21100.397185] kobject: '(null)' (0000000047d32b91): is not initialized, yet
> > kobject_get() is being called.

I don't know how to get any more informative that this :)


> > <4>[21100.397209] WARNING: CPU: 1 PID: 25848 at lib/kobject.c:593
> > kobject_get+0x21/0x32
> > <4>[21100.397211] Modules linked in:
> > <4>[21100.397215] CPU: 1 PID: 25848 Comm: reboot Not tainted 4.17.0-gentoo #2
> > <4>[21100.397217] Hardware name: ASUSTeK COMPUTER INC. Z10PE-D16 WS/Z10PE-D16
> > WS, BIOS 3407 03/10/2017
> > <4>[21100.397219] RIP: 0010:kobject_get+0x21/0x32
> > <4>[21100.397220] RSP: 0018:ffffa6c6cd9d3db0 EFLAGS: 00010296
> > <4>[21100.397223] RAX: 0000000000000000 RBX: ffff8d6af5012da8 RCX:
> > 0000000000000002
> > <4>[21100.397225] RDX: 0000000000000003 RSI: 0000000000000003 RDI:
> > 00000000ffffffff
> > <4>[21100.397227] RBP: ffff8d6af3dc9800 R08: 0000baada7db872a R09:
> > ffff8d69a1bc5cd8
> > <4>[21100.397228] R10: ffffa6c6cd9d3ce8 R11: ffffffffa7264f7d R12:
> > ffff8d6af50099a0
> > <4>[21100.397230] R13: ffffffffa57dfb43 R14: ffff8d6af3dc8060 R15:
> > 0000000000000000
> > <4>[21100.397232] FS:  00007efef9e42500(0000) GS:ffff8d6afd800000(0000)
> > knlGS:0000000000000000
> > <4>[21100.397233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[21100.397235] CR2: 0000561f1e29c4d8 CR3: 00000010277fc005 CR4:
> > 00000000003606e0
> > <4>[21100.397237] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > <4>[21100.397238] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > <4>[21100.397240] Call Trace:
> > <4>[21100.397246]  get_device+0x16/0x1b
> > <4>[21100.397249]  device_shutdown+0x48/0x1a3
> > <4>[21100.397256]  kernel_restart+0xe/0x4d
> > <4>[21100.397259]  __do_sys_reboot+0x168/0x1c5
> > <4>[21100.397264]  ? sched_clock_cpu+0x10/0xb4
> > <4>[21100.397266]  ? sched_clock_cpu+0x10/0xb4
> > <4>[21100.397270]  ? cycles_2_ns+0x55/0x75
> > <4>[21100.397276]  ? task_work_run+0x63/0x8a
> > <4>[21100.397284]  ? _raw_spin_unlock_irq+0x2f/0x41
> > <4>[21100.397287]  ? task_work_run+0x63/0x8a
> > <4>[21100.397292]  do_syscall_64+0x5e/0x6c
> > <4>[21100.397295]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Here's the full callstack, but yeah, it's not very obvious as to what
device is having the problem, which isn't good.  I don't know what to
suggest here.

Does 'git bisect' help out to narrow down the problem?

thanks,

greg k-h
