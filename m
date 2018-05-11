Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeEKCeB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:34:01 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:59739 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751209AbeEKCd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:33:59 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2693:2828:2897:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3874:4250:4321:5007:6117:6119:6238:7514:8957:10004:10400:10848:11026:11232:11658:11914:12043:12438:12555:12740:12760:12895:12986:13161:13229:13439:13870:13904:14181:14659:14721:21080:21324:21451:21611:21627:30054:30055:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: kiss14_55e1b5630c31
X-Filterd-Recvd-Size: 3502
Message-ID: <5b898d97466c512049493c26d5fd4bf8123ed7c7.camel@perches.com>
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
From: Joe Perches <joe@perches.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 19:33:55 -0700
In-Reply-To: <20180511022314.GA491@jagdpanzerIV>
References: <20180511022314.GA491@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-11 at 11:23 +0900, Sergey Senozhatsky wrote:
> On (05/11/18 10:51), Sergey Senozhatsky wrote:
> > In general, the idea looks OK to me, so FWIW
> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Looking at dmesg,
> 
> Base:
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [...]
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 00E0000000 mask 7FE0000000 uncachable
> [    0.000000]   1 disabled
> [    0.000000]   2 disabled
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [..]
> 
> Patched:
> [    0.000000] common: KERNEL supported cpus:
> [    0.000000] common:   Intel GenuineIntel
> [...]
> [    0.000000] generic: MTRR default type: write-back
> [    0.000000] generic: MTRR fixed ranges enabled:
> [    0.000000] generic:   00000-9FFFF write-back
> [    0.000000] generic:   A0000-BFFFF uncachable
> [    0.000000] generic:   C0000-FFFFF write-protect
> [    0.000000] generic: MTRR variable ranges enabled:
> [    0.000000] generic:   0 base 00E0000000 mask 7FE0000000 uncachable
> [    0.000000] generic:   1 disabled
> [    0.000000] generic:   2 disabled
> [    0.000000] generic:   3 disabled
> [    0.000000] generic:   4 disabled
> [..]
> 
> Is it correct that WARN_ON() from "generic: " will now also be prefixed?
> In other words, we will have something like this
> 
> [   28.420519] generic: RSP: 0018:ffffa01dc062bda8 EFLAGS: 00010282
> [   28.420522] generic: RAX: ffffffff8317612f RBX: ffffffffffffffea RCX: ffffa01dc062bdc8
> [   28.420523] generic: RDX: 000055a6a3f03110 RSI: 0000000000000001 RDI: ffffffff83e31540
> [   28.420525] generic: RBP: 0000000000000001 R08: ffffa01dc062bec0 R09: 0000000000000004
> [   28.420526] generic: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> [   28.420528] generic: R13: ffffffff83e31540 R14: ffffa01dc062bec0 R15: 0000000000000002
> [   28.420547] generic: ? rcu_read_lock_sched_held+0x5d/0x63
> [   28.420549] generic: ? rcu_sync_lockdep_assert+0x2e/0x54
> [   28.420551] generic: ? __sb_start_write+0xeb/0x1a3
> 
> Correct?

No, that stack dump comes from arch/x86/kernel/dumpstack.c
and that uses printk(KERN_DEFAULT ... and generic printk(
which is not prefixed at all.

And it's likely that there should be more files, if
the desired output is not prefixed, that should add

#define pr_fmt(fmt) fmt

to remove prefixes like "generic: "
