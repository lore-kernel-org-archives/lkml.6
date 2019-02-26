Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76904C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E39121871
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551208778;
	bh=g2aqHnKjESaiPVl4yfwZjezm81bcXZ0hnyEWRD3hPow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTZfl5kIzt13p8bS/DY/91jv/R4fdYMBmG6I9UUOk5EL+MYqPSHw4TgmcuD67gDR2
	 4E3+X/5D+gDriJuWhfrkkHpFxwZz8pddGfJmWau3t0hAvvGOeiNcknce68KlEhpNRd
	 BTuG0ua7Nc8WS1tZvL10dm759cgjESC53PWDx7I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfBZTTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfBZTTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:19:36 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C7C21850;
        Tue, 26 Feb 2019 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551208775;
        bh=g2aqHnKjESaiPVl4yfwZjezm81bcXZ0hnyEWRD3hPow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVIiQL7Hy29Da5DBqhnyvumgU8FoKv2S8ZFb9wUxBbvUQRokmyhSPAh39SR/QB3iS
         25e2GIRwBP7UGXd3TAPJelmgLTE7L9KxaS9NVrmmwVUQkfh3C0dJdNYuEtEJAyaPpu
         zxhkePOCwvFJzgCHDlSsEDSIt+0FbB3Hpwwfd8gw=
Date:   Tue, 26 Feb 2019 11:19:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kvm@vger.kernel.org
Cc:     syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: general protection fault in __dentry_path
Message-ID: <20190226191932.GB218103@gmail.com>
References: <0000000000007e10c50580aa7684@google.com>
 <0000000000006164d205825fb497@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006164d205825fb497@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:14:03PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    2137397c92ae Merge tag 'sound-5.0' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1270bf78c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=7857962b4d45e602b8ad
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150bee14c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f401d4c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 12576 Comm: syz-executor696 Not tainted 5.0.0-rc7+ #81
> kobject: 'kvm' (00000000985ff3e6): kobject_uevent_env
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__dentry_path+0x49e/0x7c0 fs/d_path.c:344
> Code: 89 fc 41 83 e4 01 44 89 e6 e8 fe e4 b2 ff 45 84 e4 0f 85 04 02 00 00
> e8 b0 e3 b2 ff 48 8b 85 18 ff ff ff 44 89 bd 40 ff ff ff <80> 38 00 0f 85 f9
> 02 00 00 48 8b 85 38 ff ff ff 41 83 e7 01 44 89
> kobject: 'kvm' (00000000985ff3e6): fill_kobj_path: path =
> '/devices/virtual/misc/kvm'
> RSP: 0018:ffff888096127c58 EFLAGS: 00010293
> RAX: dffffc0000000005 RBX: 0000000000000000 RCX: ffffffff81bcfdc2
> RDX: 0000000000000000 RSI: ffffffff81bcfdd0 RDI: 0000000000000001
> RBP: ffff888096127d48 R08: ffff88809b17c540 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff888096127d20 R14: ffff888092473afe R15: 0000000000014e78
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0063) knlGS:00000000f7fe4b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000080fb028 CR3: 000000009de68000 CR4: 00000000001426f0
> kobject: 'kvm' (00000000985ff3e6): kobject_uevent_env
> Call Trace:
> kobject: 'kvm' (00000000985ff3e6): fill_kobj_path: path =
> '/devices/virtual/misc/kvm'
>  dentry_path_raw+0x26/0x30 fs/d_path.c:371
>  kvm_uevent_notify_change.part.0+0x213/0x440
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:4051
>  kvm_uevent_notify_change arch/x86/kvm/../../../virt/kvm/kvm_main.c:4018
> [inline]
>  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3356
> [inline]
>  kvm_dev_ioctl+0x1132/0x1750 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3378
>  __do_compat_sys_ioctl fs/compat_ioctl.c:1052 [inline]
>  __se_compat_sys_ioctl fs/compat_ioctl.c:998 [inline]
>  __ia32_compat_sys_ioctl+0x197/0x620 fs/compat_ioctl.c:998
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fe8869
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90
> 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f7fe41fc EFLAGS: 00000293 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000ae01
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000003d0f00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 4fe494385b47fe74 ]---
> kobject: 'kvm' (00000000985ff3e6): kobject_uevent_env
> RIP: 0010:__dentry_path+0x49e/0x7c0 fs/d_path.c:344
> Code: 89 fc 41 83 e4 01 44 89 e6 e8 fe e4 b2 ff 45 84 e4 0f 85 04 02 00 00
> e8 b0 e3 b2 ff 48 8b 85 18 ff ff ff 44 89 bd 40 ff ff ff <80> 38 00 0f 85 f9
> 02 00 00 48 8b 85 38 ff ff ff 41 83 e7 01 44 89
> RSP: 0018:ffff888096127c58 EFLAGS: 00010293
> RAX: dffffc0000000005 RBX: 0000000000000000 RCX: ffffffff81bcfdc2
> RDX: 0000000000000000 RSI: ffffffff81bcfdd0 RDI: 0000000000000001
> RBP: ffff888096127d48 R08: ffff88809b17c540 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff888096127d20 R14: ffff888092473afe R15: 0000000000014e78
> kobject: 'kvm' (00000000985ff3e6): fill_kobj_path: path =
> '/devices/virtual/misc/kvm'
> FS:  0000000000000000(0000) GS:ffff8880ae800000(0063) knlGS:00000000f7fe4b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000080fb038 CR3: 000000009de68000 CR4: 00000000001426f0
> 

Hi Greg, this started happening with:

	commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b (HEAD)
	Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
	Date:   Wed Jan 23 11:28:14 2019 +0100

	    debugfs: return error values, not NULL

But virt/kvm/kvm_main.c still checks for NULL:

        if (kvm->debugfs_dentry) {
                char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);

                if (p) {
                        tmp = dentry_path_raw(kvm->debugfs_dentry, p, PATH_MAX);
                        if (!IS_ERR(tmp))
                                add_uevent_var(env, "STATS_PATH=%s", tmp);
                        kfree(p);
                }
        }

... and sometimes kvm->debugfs_dentry = ERR_PTR(-EEXIST).

- Eric
