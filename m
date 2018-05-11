Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeEKClv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:41:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45358 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:41:49 -0400
X-Google-Smtp-Source: AB8JxZpNxBBoPXcgUxVlyzAgsawcNb87GONyv/lOaMFUrE7OKQ3O4aMN2xN+UTY14HdFVZz6b3smrw==
Date: Fri, 11 May 2018 11:41:44 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
Message-ID: <20180511024144.GA416@jagdpanzerIV>
References: <20180511022314.GA491@jagdpanzerIV>
 <5b898d97466c512049493c26d5fd4bf8123ed7c7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b898d97466c512049493c26d5fd4bf8123ed7c7.camel@perches.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/18 19:33), Joe Perches wrote:
> > 
> > [   28.420519] generic: RSP: 0018:ffffa01dc062bda8 EFLAGS: 00010282
> > [   28.420522] generic: RAX: ffffffff8317612f RBX: ffffffffffffffea RCX: ffffa01dc062bdc8
> > [   28.420523] generic: RDX: 000055a6a3f03110 RSI: 0000000000000001 RDI: ffffffff83e31540
> > [   28.420525] generic: RBP: 0000000000000001 R08: ffffa01dc062bec0 R09: 0000000000000004
> > [   28.420526] generic: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> > [   28.420528] generic: R13: ffffffff83e31540 R14: ffffa01dc062bec0 R15: 0000000000000002
> > [   28.420547] generic: ? rcu_read_lock_sched_held+0x5d/0x63
> > [   28.420549] generic: ? rcu_sync_lockdep_assert+0x2e/0x54
> > [   28.420551] generic: ? __sb_start_write+0xeb/0x1a3
> > 
> > Correct?
> 
> No, that stack dump comes from arch/x86/kernel/dumpstack.c
> and that uses printk(KERN_DEFAULT ... and generic printk(
> which is not prefixed at all.

That's platform specific. Right? Most of platforms [probably most of them]
use plain printk("... %pS"). But some use pr_emerg("[<%p>] %s%pS\n") or
pr_info("PC: [<%08lx>] %pS\n"), and so on.

In case of x86, I think we will have some changes as well. Looking
at generic __warn(): pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n")
and pr_warn("WARNING: CPU: %d PID: %d at %pS\n") and probably some
others will change now:

Instead of

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at blah-blah-blah

we will have
[    0.000000] panic: ------------[ cut here ]------------
[    0.000000] panic: WARNING: CPU: 0 PID: 0 at blah-blah-blah

	-ss
