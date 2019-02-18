Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377B6218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550479096;
	bh=j72gNl+8g9U7oOvSEbPyV8m6zEc4McI6fiEkJht/K0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fqb/Y989l/sIPrtZDCTxD6y+APgU5OkQ7I2oC7px4nHRUOKZZrtWMVIuwoQRrlq9a
	 WRks2BgRdmKSzB2y0sOYIj8j3StFkMXwB8+N+1MHhEjDsEo7f+s/PXRY6Ld7FDIEQW
	 LdH4downInjEJupwx39b1jw7jjGmrLk59CIvW9kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfBRIiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBRIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:38:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665B62184E;
        Mon, 18 Feb 2019 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550479092;
        bh=j72gNl+8g9U7oOvSEbPyV8m6zEc4McI6fiEkJht/K0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ol04XPokjlgqT0WiGaG56CuGkTAnE/ieYKCFREO36d7FvCHhkjW/zICwi3M3bN/vS
         XOylx5y+FkF9Wy8565MzigFzto9TM6fClKaGG/GvSAgfC1+IOhE56c3QfOPoKHPsHj
         FgAJJz0OAx73RpJI6brtfbDk81mYO5/xFiD2nEsI=
Date:   Mon, 18 Feb 2019 09:38:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergei Trofimovich <slyfox@inbox.ru>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: 5.0.0-rc6+: Oops at boot: RIP: 0010:__memmove+0x81/0x1a0 /
 vt_do_kdgkb_ioctl+0x34d/0x440 (race at reenter?)
Message-ID: <20190218083810.GA24924@kroah.com>
References: <20190217233957.2a38d0af@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217233957.2a38d0af@sf>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 11:39:57PM +0000, Sergei Trofimovich wrote:
> [ Copying as is from https://bugzilla.kernel.org/show_bug.cgi?id=202605
>   and sending to LKML. Greg, Jiri, can you clarify mailing
>   list im  MAINTAINERS as well?
>       https://github.com/torvalds/linux/blob/master/MAINTAINERS#L15527
>   mentions no list for tty/vt/. ]
> 
> Kernel Oops
>   [   38.739241] Oops: 0003 [#1] PREEMPT SMP
>   [   38.739243] CPU: 6 PID: 388 Comm: loadkeys Tainted: G         C        5.0.0-rc6-00153-g5ded5871030e #91
>   [   38.739244] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M-D3H, BIOS F12 11/14/2013
>   [   38.739249] RIP: 0010:__memmove+0x81/0x1a0
> happes on a fresh vanilla master kernel roughly at boot
> (before tty login prompt):
>   $ uname -r
>   5.0.0-rc6-00153-g5ded5871030e
> 
> The kernel page fault happens at 'loadkeys start'.
> I suspect some kind of race at reenter of vt_do_kdgkb_ioctl(KDSKBSENT):
>     https://github.com/torvalds/linux/blob/master/drivers/tty/vt/keyboard.c#L1986
> 
> The oops trace looks similar to the following reports (no details besides Oops)
>     https://bugzilla.kernel.org/show_bug.cgi?id=194589
>     https://bugzilla.kernel.org/show_bug.cgi?id=202111
> 
> [   38.044921] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
> [   38.533196] usb 1-1.2: r8712u: CustomerID = 0x0000
> [   38.533200] usb 1-1.2: r8712u: MAC Address from efuse = 00:0d:81:a9:09:90
> [   38.533203] usb 1-1.2: r8712u: Loading firmware from "rtlwifi/rtl8712u.bin"
> [   38.533331] usbcore: registered new interface driver r8712u
> [   38.736178] BUG: unable to handle kernel paging request at ffff9c8735448000
> [   38.737215] #PF error: [PROT] [WRITE]
> [   38.737216] PGD 288a05067 P4D 288a05067 PUD 288a07067 PMD 7f60c2063 PTE 80000007f5448161
> [   38.739241] Oops: 0003 [#1] PREEMPT SMP
> [   38.739243] CPU: 6 PID: 388 Comm: loadkeys Tainted: G         C        5.0.0-rc6-00153-g5ded5871030e #91
> [   38.739244] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M-D3H, BIOS F12 11/14/2013
> [   38.739249] RIP: 0010:__memmove+0x81/0x1a0
> [   38.739251] Code: 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2 20 e9 a2 00 00 00 66 90 48 89 d1 4c 8b 5c 16 f8 4c 8d 54 17 f8 48 c1 e9 03 <f3> 48 a5 4d 89 1a e9 0c 01 00 00 0f 1f 40 00 48 89 d1 4c 8b 1e 49
> [   38.739252] RSP: 0018:ffffa1b9002d7d08 EFLAGS: 00010203
> [   38.745857] RAX: ffff9c873541af43 RBX: ffff9c873541af43 RCX: 00000c6f105cd6bf
> [   38.745858] RDX: 0000637882e986b6 RSI: ffff9c8735447ffb RDI: ffff9c8735447ffb
> [   38.745859] RBP: ffff9c8739cd3800 R08: ffff9c873b802f00 R09: 00000000fffff73b
> [   38.745860] R10: ffffffffb82b35f1 R11: 00505b1b004d5b1b R12: 0000000000000000
> [   38.745861] R13: ffff9c873541af3d R14: 000000000000000b R15: 000000000000000c
> [   38.745862] FS:  00007f450c390580(0000) GS:ffff9c873f180000(0000) knlGS:0000000000000000
> [   38.745863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.745864] CR2: ffff9c8735448000 CR3: 00000007e213c002 CR4: 00000000000606e0
> [   38.745865] Call Trace:
> [   38.745871]  vt_do_kdgkb_ioctl+0x34d/0x440
> [   38.745875]  vt_ioctl+0xba3/0x1190
> [   38.745879]  ? __bpf_prog_run32+0x39/0x60
> [   38.745882]  ? mem_cgroup_commit_charge+0x7b/0x4e0
> [   38.762583]  tty_ioctl+0x23f/0x920
> [   38.762586]  ? preempt_count_sub+0x98/0xe0
> [   38.762590]  ? __seccomp_filter+0x67/0x600
> [   38.762594]  do_vfs_ioctl+0xa2/0x6a0
> [   38.762597]  ? syscall_trace_enter+0x192/0x2d0
> [   38.762599]  ksys_ioctl+0x3a/0x70
> [   38.762601]  __x64_sys_ioctl+0x16/0x20
> [   38.762604]  do_syscall_64+0x54/0xe0
> [   38.772513]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   38.772515] RIP: 0033:0x7f450c2bb427
> [   38.772517] Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3 e8 8d d2 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 da 0c 00 f7 d8 64 89 01 48
> [   38.772518] RSP: 002b:00007fffbcedd348 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   38.772519] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f450c2bb427
> [   38.772520] RDX: 00007fffbcedd360 RSI: 0000000000004b49 RDI: 0000000000000003
> [   38.772521] RBP: 00007fffbcedd361 R08: 00007f450c389c40 R09: 000055cbef2494a0
> [   38.772522] R10: 0000000000000000 R11: 0000000000000246 R12: 000055cbef2412b0
> [   38.772522] R13: 00007fffbcedd360 R14: 000000000000000b R15: 0000000000000003
> [   38.772525] Modules linked in: snd_hda_codec_hdmi bridge r8712u(C) stp llc snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_hda_codec x86_pkg_temp_thermal dummy kvm_intel snd_hwdep snd_hda_core snd_pcm snd_timer kvm snd atl1c soundcore irqbypass xfs tun nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 loop fuse binfmt_misc ipv6
> [   38.779196] r8712u 1-1.2:1.0 wl0: renamed from wlan0
> [   38.779240] CR2: ffff9c8735448000
> [   38.790894] ---[ end trace 8116e48ba19076a0 ]---
> [   38.790897] RIP: 0010:__memmove+0x81/0x1a0
> [   38.790898] Code: 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2 20 e9 a2 00 00 00 66 90 48 89 d1 4c 8b 5c 16 f8 4c 8d 54 17 f8 48 c1 e9 03 <f3> 48 a5 4d 89 1a e9 0c 01 00 00 0f 1f 40 00 48 89 d1 4c 8b 1e 49
> [   38.790899] RSP: 0018:ffffa1b9002d7d08 EFLAGS: 00010203
> [   38.790900] RAX: ffff9c873541af43 RBX: ffff9c873541af43 RCX: 00000c6f105cd6bf
> [   38.790901] RDX: 0000637882e986b6 RSI: ffff9c8735447ffb RDI: ffff9c8735447ffb
> [   38.790902] RBP: ffff9c8739cd3800 R08: ffff9c873b802f00 R09: 00000000fffff73b
> [   38.790903] R10: ffffffffb82b35f1 R11: 00505b1b004d5b1b R12: 0000000000000000
> [   38.790904] R13: ffff9c873541af3d R14: 000000000000000b R15: 000000000000000c
> [   38.790905] FS:  00007f450c390580(0000) GS:ffff9c873f180000(0000) knlGS:0000000000000000
> [   38.790906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.790907] CR2: ffff9c8735448000 CR3: 00000007e213c002 CR4: 00000000000606e0
> [   38.790908] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:34
> [   38.790909] in_atomic(): 0, irqs_disabled(): 1, pid: 388, name: loadkeys
> [   38.790911] CPU: 6 PID: 388 Comm: loadkeys Tainted: G      D  C        5.0.0-rc6-00153-g5ded5871030e #91
> [   38.790911] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M-D3H, BIOS F12 11/14/2013
> [   38.790912] Call Trace:
> [   38.790917]  dump_stack+0x67/0x90
> [   38.822550]  ? wake_up_klogd+0x10/0x70
> [   38.822553]  ___might_sleep.cold.17+0xd4/0xe4
> [   38.822556]  exit_signals+0x1c/0x200
> [   38.822558]  do_exit+0xa8/0xb90
> [   38.822560]  ? ksys_ioctl+0x3a/0x70
> [   38.822562]  rewind_stack_do_exit+0x17/0x20
> 
> I suspect my system runs multiple loadkeys instances in parallel
> and that triggers an Oops.
> 
> I noticed that vt_do_kdgkb_ioctl() uses global variable to optimise
> func_table re-allocation. Even comment hints at lack of locking:
> 
>     /* FIXME: This one needs untangling and locking */
>     int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
> 
>     https://github.com/torvalds/linux/blob/master/drivers/tty/vt/keyboard.c#L2084
> 
> Could that be it?

That could be it, care to add a lock to handle this?

And why does your system run loadkeys in parallel?

thanks,

greg k-h
