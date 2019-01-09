Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF9D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfAIOnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:43:01 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:35498 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbfAIOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:43:00 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ghF4L-000572-SP; Wed, 09 Jan 2019 15:42:57 +0100
Date:   Wed, 9 Jan 2019 15:42:57 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Mike Galbraith <efault@gmx.de>
Cc:     kvm <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 5.0-rc1 KVM inspired "BUG: Bad page state in process" spew
Message-ID: <20190109144257.erwh52326ucgc5tw@angband.pl>
References: <1547012338.4926.11.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547012338.4926.11.camel@gmx.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:38:58AM +0100, Mike Galbraith wrote:
> KVM seems to be busted in master ATM.  All I have to do to have host
> start screaming and maybe exploding (if the guest doesn't do so first)
> is to try to install a (obese in this case) kernel over nfs mount of
> the host in a guest.
> 
> Kernel producing the spew below is 3bd6e94, config attached.

I get same, except that the BUGs were preceded by a bunch of warnings,

> homer: # grep BUG: /netconsole.log
> [ 1531.909703] BUG: Bad page state in process X  pfn:100491
> [ 1531.958141] BUG: Bad page state in process systemd-journal  pfn:100412
> [ 1532.662359] BUG: Bad page state in process X  pfn:10043f
> [ 1532.664033] BUG: Bad page state in process X  pfn:10044d
> [ 1532.686433] BUG: Bad page state in process systemd-journal  pfn:1027b0

the first one being:

Jan  9 00:41:22 umbar kernel: [74122.790461] WARNING: CPU: 2 PID: 26769 at arch/x86/kvm/mmu.c:830 mmu_spte_clear_track_bits+0x7e/0x100
Jan  9 00:41:22 umbar kernel: [74122.799676] Modules linked in: tun dm_mod cdc_acm rndis_wlan rndis_host cdc_ether usbnet sha256_generic cfg80211 rfkill mii nfnetlink snd_usb_audio snd_usbmidi_lib cp210x usbserial radeon ttm pcc_cpufreq
Jan  9 00:41:22 umbar kernel: [74122.817764] CPU: 2 PID: 26769 Comm: qemu-system-x86 Not tainted 5.0.0-rc1-debug-00035-gdce22716f1b4 #1
Jan  9 00:41:22 umbar kernel: [74122.827069] Hardware name: System manufacturer System Product Name/M4A77T, BIOS 2401    05/18/2011
Jan  9 00:41:22 umbar kernel: [74122.836025] RIP: 0010:mmu_spte_clear_track_bits+0x7e/0x100
Jan  9 00:41:22 umbar kernel: [74122.841528] Code: 48 89 e8 48 ba 00 00 00 00 00 ea ff ff 48 c1 e0 06 48 01 d0 48 8b 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 8b 40 34 85 c0 75 02 <0f> 0b 48 0f ba e3 3e 73 34 48 85 1d d2 32 26 01 75 5a 48 d1 eb 83
Jan  9 00:41:22 umbar kernel: [74122.860290] RSP: 0018:ffffc900028634d0 EFLAGS: 00010246
Jan  9 00:41:22 umbar kernel: [74122.865516] RAX: 0000000000000000 RBX: 000000010198bc67 RCX: dead0000000000ff
Jan  9 00:41:22 umbar kernel: [74122.872649] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea00040662c0
Jan  9 00:41:22 umbar kernel: [74122.879790] RBP: 000000000010198b R08: 28f5c28f5c28f5c3 R09: ffff8882264dd000
Jan  9 00:41:22 umbar kernel: [74122.886912] R10: ffff88822fffa000 R11: ffff88822fffa000 R12: 0000000000000000
Jan  9 00:41:22 umbar kernel: [74122.894046] R13: ffffc90002863580 R14: 0000000000000000 R15: ffffc90002863580
Jan  9 00:41:22 umbar kernel: [74122.901170] FS:  00007f19b9953700(0000) GS:ffff888227a80000(0000) knlGS:0000000000000000
Jan  9 00:41:22 umbar kernel: [74122.909249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan  9 00:41:22 umbar kernel: [74122.914994] CR2: 00000000102630e4 CR3: 00000001c80ee000 CR4: 00000000000006e0
Jan  9 00:41:22 umbar kernel: [74122.922135] Call Trace:
Jan  9 00:41:22 umbar kernel: [74122.924590]  drop_spte+0x1b/0xc0
Jan  9 00:41:22 umbar kernel: [74122.927822]  mmu_page_zap_pte+0xb2/0xe0
Jan  9 00:41:22 umbar kernel: [74122.931661]  kvm_mmu_prepare_zap_page+0x4f/0x2b0
Jan  9 00:41:22 umbar kernel: [74122.936297]  mmu_shrink_scan+0x199/0x240
Jan  9 00:41:22 umbar kernel: [74122.940223]  do_shrink_slab+0x11e/0x1a0
Jan  9 00:41:22 umbar kernel: [74122.944054]  shrink_slab+0x220/0x2b0
Jan  9 00:41:22 umbar kernel: [74122.947632]  shrink_node+0x168/0x460
Jan  9 00:41:22 umbar kernel: [74122.951203]  do_try_to_free_pages+0xc1/0x370
Jan  9 00:41:22 umbar kernel: [74122.955467]  try_to_free_pages+0xb0/0xe0
Jan  9 00:41:22 umbar kernel: [74122.959385]  __alloc_pages_slowpath+0x37d/0xb60
Jan  9 00:41:22 umbar kernel: [74122.963917]  __alloc_pages_nodemask+0x255/0x270
Jan  9 00:41:22 umbar kernel: [74122.968441]  do_huge_pmd_anonymous_page+0x13c/0x5d0
Jan  9 00:41:22 umbar kernel: [74122.973322]  __handle_mm_fault+0x984/0xfb0
Jan  9 00:41:22 umbar kernel: [74122.977438]  handle_mm_fault+0xc2/0x200
Jan  9 00:41:22 umbar kernel: [74122.981278]  __get_user_pages+0x258/0x6c0
Jan  9 00:41:22 umbar kernel: [74122.985290]  get_user_pages_unlocked+0x153/0x1d0
Jan  9 00:41:22 umbar kernel: [74122.989954]  __gfn_to_pfn_memslot+0x149/0x410
Jan  9 00:41:22 umbar kernel: [74122.994320]  try_async_pf+0x96/0x1b0
Jan  9 00:41:22 umbar kernel: [74122.997900]  ? kvm_host_page_size+0x81/0xa0
Jan  9 00:41:22 umbar kernel: [74123.002093]  tdp_page_fault+0x168/0x2b0
Jan  9 00:41:22 umbar kernel: [74123.005927]  ? svm_vcpu_run+0x294/0x680
Jan  9 00:41:22 umbar kernel: [74123.009765]  kvm_mmu_page_fault+0x89/0x3f0
Jan  9 00:41:22 umbar kernel: [74123.013865]  ? kvm_set_cr8.part.87+0xa/0x30
Jan  9 00:41:22 umbar kernel: [74123.018049]  ? svm_vcpu_run+0x4fd/0x680
Jan  9 00:41:22 umbar kernel: [74123.021888]  ? kvm_fast_pio+0x140/0x190
Jan  9 00:41:22 umbar kernel: [74123.025729]  kvm_arch_vcpu_ioctl_run+0x59e/0x19c0
Jan  9 00:41:22 umbar kernel: [74123.030435]  ? _copy_to_user+0x26/0x30
Jan  9 00:41:22 umbar kernel: [74123.034187]  ? kvm_vm_ioctl+0x69a/0x950
Jan  9 00:41:22 umbar kernel: [74123.038018]  kvm_vcpu_ioctl+0x26d/0x5b0
Jan  9 00:41:22 umbar kernel: [74123.041858]  ? __switch_to_asm+0x34/0x70
Jan  9 00:41:22 umbar kernel: [74123.045792]  ? wake_up_q+0x70/0x70
Jan  9 00:41:22 umbar kernel: [74123.049198]  do_vfs_ioctl+0xb0/0x650
Jan  9 00:41:22 umbar kernel: [74123.052769]  ? __x64_sys_futex+0x151/0x1b0
Jan  9 00:41:22 umbar kernel: [74123.056860]  ksys_ioctl+0x7d/0xa0
Jan  9 00:41:22 umbar kernel: [74123.060186]  __x64_sys_ioctl+0x11/0x20
Jan  9 00:41:22 umbar kernel: [74123.063931]  do_syscall_64+0x4a/0xf0
Jan  9 00:41:22 umbar kernel: [74123.067509]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  9 00:41:22 umbar kernel: [74123.072564] RIP: 0033:0x7f19be5087f7
Jan  9 00:41:22 umbar kernel: [74123.076143] Code: 00 00 90 48 8b 05 99 a6 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 a6 0c 00 f7 d8 64 89 01 48
Jan  9 00:41:22 umbar kernel: [74123.094905] RSP: 002b:00007f19b9952578 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jan  9 00:41:22 umbar kernel: [74123.102496] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f19be5087f7
Jan  9 00:41:22 umbar kernel: [74123.109629] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000010
Jan  9 00:41:22 umbar kernel: [74123.116764] RBP: 0000000000000000 R08: 0000561da63a2c50 R09: 00000000000000ff
Jan  9 00:41:22 umbar kernel: [74123.123904] R10: 0000000000000001 R11: 0000000000000246 R12: 0000561da74bd4f0
Jan  9 00:41:22 umbar kernel: [74123.131046] R13: 00007f19c0268000 R14: 0000000000000000 R15: 0000561da74bd4f0
Jan  9 00:41:22 umbar kernel: [74123.138178] ---[ end trace d25bca6c6bf22c09 ]---


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Hans 1 was born and raised in Johannesburg, then moved to Boston,
⣾⠁⢠⠒⠀⣿⡁ and has just became a naturalized citizen.  Hans 2's grandparents
⢿⡄⠘⠷⠚⠋⠀ came from Melanesia to Düsseldorf, and he hasn't ever been outside
⠈⠳⣄⠀⠀⠀⠀ Germany until yesterday.  Which one is an African-American?
