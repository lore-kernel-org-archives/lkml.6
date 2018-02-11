Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeBKNjp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 08:39:45 -0500
Received: from torres.zugschlus.de ([85.214.131.164]:36062 "EHLO
        torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeBKNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 08:39:43 -0500
Date: Sun, 11 Feb 2018 14:39:41 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "KVM-ML (kvm@vger.kernel.org)" <kvm@vger.kernel.org>
Subject: Re: VMs freezing when host is running 4.14
Message-ID: <20180211133941.gayg52r3bqbtptvm@torres.zugschlus.de>
References: <20171121161821.b6k3hdl3wgia5f5q@torres.zugschlus.de>
 <20171122093945.5afa2di2g7qhf4eb@torres.zugschlus.de>
 <CAD9gYJK7TOnfp+fnAyisYRQf--_TQv8J7h+kWH6KL98xNUH0bA@mail.gmail.com>
 <20171201144358.7yffztjhylfxxytn@torres.zugschlus.de>
 <20180108091025.2sup55jlpzbouo3d@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180108091025.2sup55jlpzbouo3d@torres.zugschlus.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after in total nine weeks of bisecting, broken filesystems, service
outages (thankfully on unportant systems), 4.15 seems to have fixed the
issue. After going to 4.15, the crashes never happened again.

They have, however, happened with each and every 4.14 release I tried,
which I stopped doing with 4.14.15 on Jan 28.

This means, for me, that the issue is fixed and that I have just wasted
nine weeks of time.

For you, this means that you have a crippling, data-eating issue in the
current long-term releae kernel. I do sincerely hope that I never have
to lay my eye on any 4.14 kernel and hope that no major distribution
will release with this version.

Greetings
Marc


On Mon, Jan 08, 2018 at 10:10:25AM +0100, Marc Haber wrote:
> it's been five weeks since I gave you the last information about this
> issue. Alas, I don't have a solution yet, only reports:
> 
> - The bisect between 4.13 and 4.14 ended up on a one-character fix in a
>   comment, so that was a total waste.
> - The issue is present in all recent kernels up to 4.15-rc5, I didn't
>   try any newer 4.15 version yet.
> - 4.13-rc4 seems good
> - 4.13-rc5 is the earliest kernel that shows the issue. I am at a loss
>   to understand why a bug introduced during the 4.13 RC phase could
>   _not_ be present in the 4.13 release but reappear in 4.14. I didn't
>   try any 4.14 rc versions but suspect that those are all bad as well.
> 
> I will now start bisecting between 4.13-rc4 and 4.13-rc5, which is
> "roughly 7 steps"; a kernel is "good" if it survived at least 72 hours
> (as I found out that 24 hours might not be long enough).
> 
> I am still open to any suggestions that might help in identifying this
> issue which now affects five of my six systems that to KVM
> virtualization one way or the other. I have in the mean time experienced
> file system corruption and data loss (and do have backups).
> 
> Greetings
> Marc
> 
> On Fri, Dec 01, 2017 at 03:43:58PM +0100, Marc Haber wrote:
> > On Wed, Nov 22, 2017 at 04:04:42PM +0100, 王金浦 wrote:
> > > +cc kvm
> > > 
> > > 2017-11-22 10:39 GMT+01:00 Marc Haber <mh+linux-kernel@zugschlus.de>:
> > > > On Tue, Nov 21, 2017 at 05:18:21PM +0100, Marc Haber wrote:
> > > >> On the affected host, VMs freeze at a rate about two or three per day.
> > > >> They just stop dead in their tracks, console and serial console become
> > > >> unresponsive, ping stops, they don't react to virsh shutdown, only to
> > > >> virsh destroy.
> > > >
> > > > I was able to obtain a log of a VM before it became unresponsive. here
> > > > we go:
> > > >
> > > > Nov 22 08:19:01 weave kernel: double fault: 0000 [#1] PREEMPT SMP
> > > > Nov 22 08:19:01 weave kernel: Modules linked in: crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc sg aesni_intel aes_x86_64 crypto_simd glue_helper cryptd input_leds virtio_balloon virtio_console led_class qemu_fw_cfg ip_tables x_tables autofs4 ext4 mbcache jbd2 fscrypto usbhid sr_mod cdrom virtio_blk virtio_net ata_generic crc32c_intel ehci_pci ehci_hcd usbcore usb_common floppy i2c_piix4 virtio_pci virtio_ring virtio ata_piix i2c_core libata
> > > > Nov 22 08:19:01 weave kernel: CPU: 1 PID: 8795 Comm: debsecan Not tainted 4.14.1-zgsrv20080 #3
> > > > Nov 22 08:19:01 weave kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > > Nov 22 08:19:01 weave kernel: task: ffff88001ef0adc0 task.stack: ffffc900001fc000
> > > > Nov 22 08:19:01 weave kernel: RIP: 0010:kvm_async_pf_task_wait+0x167/0x200
> > > > Nov 22 08:19:01 weave kernel: RSP: 0000:ffffc900001ffa10 EFLAGS: 00000202
> > > > Nov 22 08:19:01 weave kernel: RAX: ffff88001fd11cc0 RBX: ffffc900001ffa30 RCX: 0000000000000002
> > > > Nov 22 08:19:01 weave kernel: RDX: 0140000000000000 RSI: ffffffff8173514b RDI: ffffffff819bdd80
> > > > Nov 22 08:19:01 weave kernel: RBP: ffffc900001ffaa0 R08: 0000000000193fc0 R09: ffff880000000000
> > > > Nov 22 08:19:01 weave kernel: R10: ffffc900001ffac0 R11: 0000000000000000 R12: ffffc900001ffa40
> > > > Nov 22 08:19:01 weave kernel: R13: 0000000000000be8 R14: ffffffff819bdd80 R15: ffffea0000193f80
> > > > Nov 22 08:19:01 weave kernel: FS:  00007f97e25dd700(0000) GS:ffff88001fd00000(0000) knlGS:0000000000000000
> > > > Nov 22 08:19:01 weave kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > Nov 22 08:19:01 weave kernel: CR2: 0000000000483001 CR3: 0000000015df7000 CR4: 00000000000406e0
> > > > Nov 22 08:19:01 weave kernel: Call Trace:
> > > > Nov 22 08:19:01 weave kernel: do_async_page_fault+0x6b/0x70
> > > > Nov 22 08:19:01 weave kernel: ? do_async_page_fault+0x6b/0x70
> > > > Nov 22 08:19:01 weave kernel: async_page_fault+0x22/0x30
> > > > Nov 22 08:19:01 weave kernel: RIP: 0010:clear_page_rep+0x7/0x10
> > > > Nov 22 08:19:01 weave kernel: RSP: 0000:ffffc900001ffb88 EFLAGS: 00010246
> > > > Nov 22 08:19:01 weave kernel: RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000200
> > > > Nov 22 08:19:01 weave kernel: RDX: ffff88001ef0adc0 RSI: 0000000000193f80 RDI: ffff8800064fe000
> > > > Nov 22 08:19:01 weave kernel: RBP: ffffc900001ffc50 R08: 0000000000193fc0 R09: ffff880000000000
> > > > Nov 22 08:19:01 weave kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000020
> > > > Nov 22 08:19:01 weave kernel: R13: ffff88001ffd5500 R14: ffffc900001ffce8 R15: ffffea0000193f80
> > > > Nov 22 08:19:01 weave kernel: ? get_page_from_freelist+0x8c3/0xaf0
> > > > Nov 22 08:19:01 weave kernel: ? __mem_cgroup_threshold+0x8a/0x130
> > > > Nov 22 08:19:01 weave kernel: ? free_pcppages_bulk+0x3f6/0x410
> > > > Nov 22 08:19:01 weave kernel: __alloc_pages_nodemask+0xe4/0xe20
> > > > Nov 22 08:19:01 weave kernel: ? free_hot_cold_page_list+0x2b/0x50
> > > > Nov 22 08:19:01 weave kernel: ? release_pages+0x2b7/0x360
> > > > Nov 22 08:19:01 weave kernel: ? mem_cgroup_commit_charge+0x7a/0x520
> > > > Nov 22 08:19:01 weave kernel: ? account_entity_enqueue+0x95/0xc0
> > > > Nov 22 08:19:01 weave kernel: alloc_pages_vma+0x7f/0x1e0
> > > > Nov 22 08:19:01 weave kernel: __handle_mm_fault+0x9cb/0xf20
> > > > Nov 22 08:19:01 weave kernel: handle_mm_fault+0xb2/0x1f0
> > > > Nov 22 08:19:01 weave kernel: __do_page_fault+0x1f2/0x440
> > > > Nov 22 08:19:01 weave kernel: do_page_fault+0x22/0x30
> > > > Nov 22 08:19:01 weave kernel: do_async_page_fault+0x4c/0x70
> > > > Nov 22 08:19:01 weave kernel: async_page_fault+0x22/0x30
> > > > Nov 22 08:19:01 weave kernel: RIP: 0033:0x56434ef679d8
> > > > Nov 22 08:19:01 weave kernel: RSP: 002b:00007ffd6b48ad80 EFLAGS: 00010206
> > > > Nov 22 08:19:01 weave kernel: RAX: 00000000000000eb RBX: 000000000000001d RCX: aaaaaaaaaaaaaaab
> > > > Nov 22 08:19:01 weave kernel: RDX: 000056434f5eb300 RSI: 000000000000000f RDI: 000056434f3ca6c0
> > > > Nov 22 08:19:01 weave kernel: RBP: 00000000000000ec R08: 00007f97e2453000 R09: 000056434f5eb3ea
> > > > Nov 22 08:19:01 weave kernel: R10: 000056434f5eb3eb R11: 000056434f4510a0 R12: 000000000000003a
> > > > Nov 22 08:19:01 weave kernel: R13: 000056434f3ca500 R14: 000056434f451240 R15: 00007f97e1024750
> > > > Nov 22 08:19:01 weave kernel: Code: f7 49 89 9d a0 d1 9b 81 48 89 55 98 4c 8d 63 10 e8 4f 02 53 00 eb 20 48 83 7d 98 00 74 3a e8 21 6e 06 00 80 7d c0 00 74 3f fb f4 <fa> 66 66 90 66 66 90 e8 7d 6f 06 00 80 7d c0 00 75 da 48 8d b5
> > > > Nov 22 08:19:01 weave kernel: RIP: kvm_async_pf_task_wait+0x167/0x200 RSP: ffffc900001ffa10
> > > > Nov 22 08:19:01 weave kernel: ---[ end trace 4701012ee256be25 ]---
> > > >
> > > > Does that help?
> > > >
> > > So all guest kernels are 4.14, or also other older kernel?
> > > 
> > > > Greetings
> > > > Marc
> > > 
> > > Regards,
> > > Jack
> > > 
> > > >
> > > > --
> > > > -----------------------------------------------------------------------------
> > > > Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
> > > > Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
> > > > Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
> > 
> > -- 
> > -----------------------------------------------------------------------------
> > Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
> > Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
> > Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
> 
> -- 
> -----------------------------------------------------------------------------
> Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
> Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
> Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
