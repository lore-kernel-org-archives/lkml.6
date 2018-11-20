Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18139C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27A920685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27A920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeKUE7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:59:11 -0500
Received: from foss.arm.com ([217.140.101.70]:59416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbeKUE7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:59:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6205028AC;
        Tue, 20 Nov 2018 10:28:40 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31E043F5AF;
        Tue, 20 Nov 2018 10:28:40 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 92AAC1AE07D8; Tue, 20 Nov 2018 18:28:55 +0000 (GMT)
Date:   Tue, 20 Nov 2018 18:28:55 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <Jan.Glauber@cavium.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181120182854.GC28838@arm.com>
References: <20181109143744.GA12128@hc>
 <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110111656.GA16667@hc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:17:03AM +0000, Jan Glauber wrote:
> On Fri, Nov 09, 2018 at 03:58:56PM +0000, Will Deacon wrote:
> > On Fri, Nov 09, 2018 at 02:37:51PM +0000, Jan Glauber wrote:
> > > I'm seeing the following oops reproducible with upstream kernel on arm64
> > > (ThunderX2):
> > 
> > [...]
> > 
> > > It happens after 1-3 hours of running 'stress-ng --dev 128'. This testcase
> > > does a scandir of /dev and then calls random stuff like ioctl, lseek,
> > > open/close etc. on the entries. I assume no files are deleted under /dev
> > > during the testcase.
> > >
> > > The NULL pointer is the inode pointer of next. The next dentry->d_flags is
> > > DCACHE_RCUACCESS when this happens.
> > >
> > > Any hints on how to further debug this?
> > 
> > Can you reproduce the issue with vanilla -rc1 and do you have a "known good"
> > kernel?
> 
> I can try out -rc1, but IIRC this wasn't bisectible as the bug was present at
> least back to 4.14. I need to double check that as there were other issues
> that are resolved now so I may confuse things here. I've defintely seen
> the same bug with 4.18.
> 
> Unfortunately I lost access to the machine as our data center seems to be
> moving currently so it might take some days until I can try -rc1.

Ok, I've just managed to reproduce this in a KVM guest running v4.20-rc3 on
both the host and the guest, so if anybody has any ideas of things to try then
I'm happy to give them a shot. In the meantime, I'll try again with a bunch of
debug checks enabled.

Interestingly, I see many CPUs crashing one after the other in the same place
with *0x40, which indicates that the underlying data structure is corrupted
somehow. The final crash was in a different place with *0x10, which I've also
included below.

Will

--->8

[  353.086276] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
[  353.088334] Mem abort info:
[  353.088501]   ESR = 0x96000004
[  353.123277]   Exception class = DABT (current EL), IL = 32 bits
[  353.126126]   SET = 0, FnV = 0
[  353.127064]   EA = 0, S1PTW = 0
[  353.127917] Data abort info:
[  353.130869]   ISV = 0, ISS = 0x00000004
[  353.131793]   CM = 0, WnR = 0
[  353.133998] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000344077db
[  353.135410] [0000000000000040] pgd=0000000000000000
[  353.137903] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  353.139146] Modules linked in:
[  353.140232] CPU: 41 PID: 2514 Comm: stress-ng-dev Not tainted 4.20.0-rc3-00012-g40b114779944 #1
[  353.140367] Hardware name: linux,dummy-virt (DT)
[  353.190775] pstate: 40400005 (nZcv daif +PAN -UAO)
[  353.191833] pc : dcache_readdir+0xd0/0x170
[  353.193058] lr : dcache_readdir+0x108/0x170
[  353.194075] sp : ffff00000e17bd70
[  353.195027] x29: ffff00000e17bd70 x28: ffff8003cbe60000 
[  353.196232] x27: 0000000000000000 x26: 0000000000000000 
[  353.196334] x25: 0000000056000000 x24: ffff80037e3a9200 
[  353.255951] x23: 0000000000000000 x22: ffff8003d692ae40 
[  353.257708] x21: ffff8003d692aee0 x20: ffff00000e17be40 
[  353.259044] x19: ffff80037d875b00 x18: 0000000000000000 
[  353.259210] x17: 0000000000000000 x16: 0000000000000000 
[  353.259354] x15: 0000000000000000 x14: 0000000000000000 
[  353.259469] x13: 0000000000000000 x12: 0000000000000000 
[  353.259610] x11: 0000000000000000 x10: 0000000000000000 
[  353.259746] x9 : 0000ffffffffffff x8 : 0000ffffffffffff 
[  353.422637] x7 : 0000000000000005 x6 : ffff000008245768 
[  353.422639] x5 : 0000000000000000 x4 : 0000000000002000 
[  353.422640] x3 : 0000000000000002 x2 : 0000000000000001 
[  353.422642] x1 : ffff80037d875b38 x0 : ffff00000e17be40 
[  353.422646] Process stress-ng-dev (pid: 2514, stack limit = 0x000000006721788f)
[  353.422647] Call trace:
[  353.422654]  dcache_readdir+0xd0/0x170
[  353.422664]  iterate_dir+0x13c/0x190
[  353.429254]  ksys_getdents64+0x88/0x168
[  353.429256]  __arm64_sys_getdents64+0x1c/0x28
[  353.429260]  el0_svc_common+0x84/0xd8
[  353.429261]  el0_svc_handler+0x2c/0x80
[  353.429264]  el0_svc+0x8/0xc
[  353.429267] Code: a9429661 aa1403e0 a9400e86 b9402662 (f94020a4) 
[  353.429272] ---[ end trace 7bc53f0d6caaf0d1 ]---

[ 1770.346163] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[ 1770.364229] Mem abort info:
[ 1770.364411]   ESR = 0x96000004
[ 1770.364419]   Exception class = DABT (current EL), IL = 32 bits
[ 1770.364434]   SET = 0, FnV = 0
[ 1770.364441]   EA = 0, S1PTW = 0
[ 1770.364442] Data abort info:
[ 1770.364443]   ISV = 0, ISS = 0x00000004
[ 1770.364444]   CM = 0, WnR = 0
[ 1770.364480] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000d05dfa48
[ 1770.364491] [0000000000000010] pgd=0000000000000000
[ 1770.364537] Internal error: Oops: 96000004 [#34] PREEMPT SMP
[ 1770.364586] Modules linked in:
[ 1770.364592] CPU: 2 PID: 2491 Comm: stress-ng-dev Tainted: G      D           4.20.0-rc3-00012-g40b114779944 #1
[ 1770.364594] Hardware name: linux,dummy-virt (DT)
[ 1770.364596] pstate: 60400005 (nZCv daif +PAN -UAO)
[ 1770.364665] pc : n_tty_ioctl+0x128/0x1a0
[ 1770.364668] lr : n_tty_ioctl+0xac/0x1a0
[ 1770.364669] sp : ffff00000e723ca0
[ 1770.364691] x29: ffff00000e723ca0 x28: ffff8003d2a94f80 
[ 1770.485270] x27: 0000000000000000 x26: 0000000000000000 
[ 1770.485343] x25: ffff8003955a9780 x24: 0000fffff3c025f0 
[ 1770.485346] x23: ffff80038ad46100 x22: ffff800394c1c0c0 
[ 1770.496821] x21: 0000000000000000 x20: ffff800394c1c000 
[ 1770.496824] x19: 0000fffff3c025f0 x18: 0000000000000000 
[ 1770.496825] x17: 0000000000000000 x16: 0000000000000000 
[ 1770.496827] x15: 0000000000000000 x14: 0000000000000000 
[ 1770.496828] x13: 0000000000000000 x12: 0000000000000000 
[ 1770.496829] x11: 0000000000000000 x10: 0000000000000000 
[ 1770.496830] x9 : 0000000000000000 x8 : 0000000000000000 
[ 1770.496831] x7 : 0000000000000000 x6 : 0000000000000000 
[ 1770.496833] x5 : 000000000000541b x4 : ffff0000085b4780 
[ 1770.496834] x3 : 0000fffff3c025f0 x2 : 000000000000541b 
[ 1770.496835] x1 : ffffffff00000001 x0 : 0000000000000002 
[ 1770.496839] Process stress-ng-dev (pid: 2491, stack limit = 0x000000001177919b)
[ 1770.496840] Call trace:
[ 1770.496845]  n_tty_ioctl+0x128/0x1a0
[ 1770.496847]  tty_ioctl+0x2fc/0xb70
[ 1770.496851]  do_vfs_ioctl+0xb8/0x890
[ 1770.496853]  ksys_ioctl+0x78/0xa8
[ 1770.496854]  __arm64_sys_ioctl+0x1c/0x28
[ 1770.496858]  el0_svc_common+0x84/0xd8
[ 1770.496860]  el0_svc_handler+0x2c/0x80
[ 1770.496863]  el0_svc+0x8/0xc
[ 1770.496865] Code: a94153f3 a9425bf5 a8c37bfd d65f03c0 (f9400aa4) 
[ 1770.496869] ---[ end trace 7bc53f0d6caaf0f2 ]---

