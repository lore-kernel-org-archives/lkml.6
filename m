Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A5720863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A5720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441134AbeKXEu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:50:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395316AbeKXEu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:50:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9425235FF;
        Fri, 23 Nov 2018 10:05:09 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 640883F5CF;
        Fri, 23 Nov 2018 10:05:09 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D0C2A1AE1019; Fri, 23 Nov 2018 18:05:25 +0000 (GMT)
Date:   Fri, 23 Nov 2018 18:05:25 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <Jan.Glauber@cavium.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, jslaby@suse.com
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181123180525.GA21017@arm.com>
References: <20181109143744.GA12128@hc>
 <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc>
 <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com>
 <20181121131900.GA18931@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121131900.GA18931@hc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've now managed to reproduce this on x86 (log below) but I'm out of my
depth with this one. Looping in Greg and Jiri because I fear this is
specific to the pty code. Rest of the thread is here:

http://lkml.kernel.org/r/20181109143744.GA12128@hc

On Wed, Nov 21, 2018 at 01:19:06PM +0000, Jan Glauber wrote:
> On Tue, Nov 20, 2018 at 07:03:17PM +0000, Will Deacon wrote:
> > On Tue, Nov 20, 2018 at 06:28:54PM +0000, Will Deacon wrote:
> > > On Sat, Nov 10, 2018 at 11:17:03AM +0000, Jan Glauber wrote:
> > > > On Fri, Nov 09, 2018 at 03:58:56PM +0000, Will Deacon wrote:
> > > > > On Fri, Nov 09, 2018 at 02:37:51PM +0000, Jan Glauber wrote:
> > > > > > I'm seeing the following oops reproducible with upstream kernel on arm64
> > > > > > (ThunderX2):
> > > > >
> > > > > [...]
> > > > >
> > > > > > It happens after 1-3 hours of running 'stress-ng --dev 128'. This testcase
> > > > > > does a scandir of /dev and then calls random stuff like ioctl, lseek,
> > > > > > open/close etc. on the entries. I assume no files are deleted under /dev
> > > > > > during the testcase.
> > > > > >
> > > > > > The NULL pointer is the inode pointer of next. The next dentry->d_flags is
> > > > > > DCACHE_RCUACCESS when this happens.
> > > > > >
> > > > > > Any hints on how to further debug this?
> > > > >
> > > > > Can you reproduce the issue with vanilla -rc1 and do you have a "known good"
> > > > > kernel?
> > > >
> > > > I can try out -rc1, but IIRC this wasn't bisectible as the bug was present at
> > > > least back to 4.14. I need to double check that as there were other issues
> > > > that are resolved now so I may confuse things here. I've defintely seen
> > > > the same bug with 4.18.
> > > >
> > > > Unfortunately I lost access to the machine as our data center seems to be
> > > > moving currently so it might take some days until I can try -rc1.
> > >
> > > Ok, I've just managed to reproduce this in a KVM guest running v4.20-rc3 on
> > > both the host and the guest, so if anybody has any ideas of things to try then
> > > I'm happy to give them a shot. In the meantime, I'll try again with a bunch of
> > > debug checks enabled.
> 
> good that you can reproduce the issue. I've verified that the issue is
> indeed reproducible with 4.14.
> 
> > 
> > Weee, I eventually hit a use-after-free from KASAN. See below.
> 
> I ran KASAN (and all the other debug stuff) but didn't trigger anything
> in the host.

Doing some more debugging, it looks like the usual failure case is where
one CPU clears the inode field in the dentry via:

	devpts_pty_kill()
		-> d_delete()	// dentry->d_lockref.count == 1
			-> dentry_unlink_inode()

whilst another CPU gets a pointer to the dentry via:

	sys_getdents64()
		-> iterate_dir()
			-> dcache_readdir()
				-> next_positive()

and explodes on the subsequent inode dereference when trying to pass the
inode number to dir_emit():

	if (!dir_emit(..., d_inode(next)->i_ino, ...))

Indeed, the hack below triggers a warning, indicating that the inode
is being cleared concurrently.

I can't work out whether the getdents64() path should hold a refcount
to stop d_delete() in its tracks, or whether devpts_pty_kill() shouldn't
be calling d_delete() like this at all.

Any help debugging this would be really appreciated.

Will

--->8

diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..fe3f72c5cf72 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -117,6 +117,7 @@ static struct dentry *next_positive(struct dentry *parent,
                if (unlikely(*seq != n))
                        goto retry;
        }
+       WARN_ON(res && !d_inode(res));
        return res;
 }
 
--->8

[  410.560885] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  410.561458] PGD 0 P4D 0 
[  410.561458] Oops: 0000 [#1] PREEMPT SMP PTI
[  410.561458] CPU: 1 PID: 983 Comm: stress-ng-dev Not tainted 4.20.0-rc3 #1
[  410.561458] RIP: 0010:dcache_readdir+0xd6/0x160
[  410.561458] Code: 7d 48 c7 43 08 02 00 00 00 4d 8d a5 a0 00 00 00 45 31 f6 eb 41 48 8b 45 30 48 8b 4b 08 48 89 df 8b 55 24 48 8b 75 28 4c 8b 13 <44> 0f b7 08 4c 8b 40 40 66 41 c1 e9 0c 41 83 e1 0f e8 24 5e c1 00
[  410.565432] RSP: 0018:ffffb0a2004e7e48 EFLAGS: 00010286
[  410.565432] RAX: 0000000000000000 RBX: ffffb0a2004e7ec0 RCX: 0000000000000002
[  410.565432] RDX: 0000000000000001 RSI: ffff9ccef8396938 RDI: ffffb0a2004e7ec0
[  410.565432] RBP: ffff9ccef8396900 R08: 0000000000000001 R09: 0000000000000000
[  410.565432] R10: ffffffff947d7070 R11: 0000000000000000 R12: ffff9ccefcc23e20
[  410.565432] R13: ffff9ccefcc23d80 R14: 0000000000000000 R15: ffff9ccef7c1c0c0
[  410.565432] FS:  00007f1883901740(0000) GS:ffff9ccefd700000(0000) knlGS:0000000000000000
[  410.565432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  410.565432] CR2: 0000000000000000 CR3: 000000007b840004 CR4: 0000000000360ea0
[  410.565432] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  410.573446] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  410.573446] Call Trace:
[  410.573446]  iterate_dir+0x90/0x180
[  410.573446]  __x64_sys_getdents+0xa6/0x130
[  410.573446]  ? __ia32_compat_sys_getdents+0x130/0x130
[  410.573446]  ? do_syscall_64+0x43/0xf0
[  410.573446]  ? __ia32_sys_getdents+0x130/0x130
[  410.573446]  do_syscall_64+0x43/0xf0
[  410.573446]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  410.577435] RIP: 0033:0x7f1881d8a0a8
[  410.577435] Code: e9 0d d8 fb ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 57 41 56 b8 4e 00 00 00 41 55 41 54 55 53 48 89 f3 48 83 ec 08 0f 05 <48> 3d 00 f0 ff ff 77 58 4c 8d 2c 06 49 89 c4 4c 39 ee 73 36 0f 1f
[  410.577435] RSP: 002b:00007ffd64877580 EFLAGS: 00000202 ORIG_RAX: 000000000000004e
[  410.577435] RAX: ffffffffffffffda RBX: 00005586c709eb30 RCX: 00007f1881d8a0a8
[  410.577435] RDX: 0000000000008000 RSI: 00005586c709eb30 RDI: 0000000000000006
[  410.577435] RBP: 00005586c709eb30 R08: 0000000000000078 R09: 0000000000000000
[  410.577435] R10: 00005586c709c010 R11: 0000000000000202 R12: ffffffffffffff78
[  410.585529] R13: 0000000000000000 R14: ffffffffffffff78 R15: 00005586c709eb00
[  410.585529] Modules linked in:
[  410.585529] CR2: 0000000000000000
[  410.585529] ---[ end trace aece97fc2fce9ace ]---
