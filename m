Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeEKC5G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:57:06 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:51660 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751099AbeEKC5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:57:05 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3353:3622:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:6238:10004:10400:10848:11026:11232:11658:11914:12043:12438:12555:12740:12760:12895:12986:13439:13870:13904:14659:14721:21080:21324:21451:21611:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: fog70_3d9f24425992e
X-Filterd-Recvd-Size: 2986
Message-ID: <bd86d9c85d3d1ff4bb0bb6ca4d7e76d168362ab8.camel@perches.com>
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
From: Joe Perches <joe@perches.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 19:57:01 -0700
In-Reply-To: <20180511024144.GA416@jagdpanzerIV>
References: <20180511022314.GA491@jagdpanzerIV>
         <5b898d97466c512049493c26d5fd4bf8123ed7c7.camel@perches.com>
         <20180511024144.GA416@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-11 at 11:41 +0900, Sergey Senozhatsky wrote:
> On (05/10/18 19:33), Joe Perches wrote:
> > > 
> > > [   28.420519] generic: RSP: 0018:ffffa01dc062bda8 EFLAGS: 00010282
> > > [   28.420522] generic: RAX: ffffffff8317612f RBX: ffffffffffffffea RCX: ffffa01dc062bdc8
> > > [   28.420523] generic: RDX: 000055a6a3f03110 RSI: 0000000000000001 RDI: ffffffff83e31540
> > > [   28.420525] generic: RBP: 0000000000000001 R08: ffffa01dc062bec0 R09: 0000000000000004
> > > [   28.420526] generic: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> > > [   28.420528] generic: R13: ffffffff83e31540 R14: ffffa01dc062bec0 R15: 0000000000000002
> > > [   28.420547] generic: ? rcu_read_lock_sched_held+0x5d/0x63
> > > [   28.420549] generic: ? rcu_sync_lockdep_assert+0x2e/0x54
> > > [   28.420551] generic: ? __sb_start_write+0xeb/0x1a3
> > > 
> > > Correct?
> > 
> > No, that stack dump comes from arch/x86/kernel/dumpstack.c
> > and that uses printk(KERN_DEFAULT ... and generic printk(
> > which is not prefixed at all.
> 
> That's platform specific. Right?

yes, it seems so.

> Most of platforms [probably most of them]
> use plain printk("... %pS"). But some use pr_emerg("[<%p>] %s%pS\n") or
> pr_info("PC: [<%08lx>] %pS\n"), and so on.
> 
> In case of x86, I think we will have some changes as well. Looking
> at generic __warn(): pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n")
> and pr_warn("WARNING: CPU: %d PID: %d at %pS\n") and probably some
> others will change now:
> 
> Instead of
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at blah-blah-blah
> 
> we will have
> [    0.000000] panic: ------------[ cut here ]------------
> [    0.000000] panic: WARNING: CPU: 0 PID: 0 at blah-blah-blah

right.

So far, I've made no attempt to update arch/...

It's almost certain that some additions of
	#define pr_fmt(fmt) fmt
will need to be made for some arch/... files.
