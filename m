Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966513AbeBNCEt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:04:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966424AbeBNCEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:04:46 -0500
Date: Tue, 13 Feb 2018 20:04:45 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "KVM-ML (kvm@vger.kernel.org)" <kvm@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VMs freezing when host is running 4.14
Message-ID: <20180214020445.ebu4fhnmogqehunb@treble>
References: <20171121161821.b6k3hdl3wgia5f5q@torres.zugschlus.de>
 <20171122093945.5afa2di2g7qhf4eb@torres.zugschlus.de>
 <CAD9gYJK7TOnfp+fnAyisYRQf--_TQv8J7h+kWH6KL98xNUH0bA@mail.gmail.com>
 <20171201144358.7yffztjhylfxxytn@torres.zugschlus.de>
 <20180108091025.2sup55jlpzbouo3d@torres.zugschlus.de>
 <20180211133941.gayg52r3bqbtptvm@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180211133941.gayg52r3bqbtptvm@torres.zugschlus.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 02:39:41PM +0100, Marc Haber wrote:
> Hi,
> 
> after in total nine weeks of bisecting, broken filesystems, service
> outages (thankfully on unportant systems), 4.15 seems to have fixed the
> issue. After going to 4.15, the crashes never happened again.
> 
> They have, however, happened with each and every 4.14 release I tried,
> which I stopped doing with 4.14.15 on Jan 28.
> 
> This means, for me, that the issue is fixed and that I have just wasted
> nine weeks of time.
> 
> For you, this means that you have a crippling, data-eating issue in the
> current long-term releae kernel. I do sincerely hope that I never have
> to lay my eye on any 4.14 kernel and hope that no major distribution
> will release with this version.

I saw something similar today, also in kvm_async_pf_task_wait().  I had
-tip in the guest (based on 4.16.0-rc1) and Fedora
4.14.16-300.fc27.x86_64 on the host.

In my case the double fault seemed to be caused by a corrupt CR3.  The
#DF hit when trying to call schedule() with the bad CR3, immediately
after enabling interrupts.  So there could be something in the interrupt
path which is corrupting CR3, but I audited that path in the guest
kernel (which had PTI enabled) and it looks straightforward.

The reason I think CR3 was corrupt is because some earlier stack traces
(which I forced as part of my unwinder testing) showed a kernel CR3
value of 0x130ada005, but the #DF output showed it as 0x2212006.  And
that also explains why a call instruction would result in a #DF.  But I
have no clue *how* it got corrupted.

I don't know if the bug is in the host (4.14) or the guest (4.16).

[ 4031.436692] PANIC: double fault, error_code: 0x0
[ 4031.439937] CPU: 1 PID: 1227 Comm: kworker/1:1 Not tainted 4.16.0-rc1+ #12
[ 4031.440632] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
[ 4031.441475] Workqueue: events netstamp_clear
[ 4031.441897] RIP: 0010:kvm_async_pf_task_wait+0x19d/0x250
[ 4031.442411] RSP: 0000:ffffc90000f5fbc0 EFLAGS: 00000202
[ 4031.442916] RAX: ffff880136048000 RBX: ffffc90000f5fbe0 RCX: 0000000000000006
[ 4031.443601] RDX: 0000000000000006 RSI: ffff880136048a40 RDI: ffff880136048000
[ 4031.444285] RBP: ffffc90000f5fc90 R08: 000005212156f5cf R09: 0000000000000000
[ 4031.444966] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000f5fbf0
[ 4031.445650] R13: 0000000000002e88 R14: ffffffff82ad6360 R15: 0000000000000000
[ 4031.446335] FS:  0000000000000000(0000) GS:ffff88013a800000(0000) knlGS:0000000000000000
[ 4031.447104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4031.447659] CR2: 0000000000006001 CR3: 0000000002212006 CR4: 00000000001606e0
[ 4031.448354] Call Trace:
[ 4031.448602]  ? kvm_clock_read+0x1f/0x30
[ 4031.448985]  ? prepare_to_swait+0x1d/0x70
[ 4031.449384]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 4031.449845]  ? do_async_page_fault+0x67/0x90
[ 4031.450283]  do_async_page_fault+0x67/0x90
[ 4031.450684]  async_page_fault+0x25/0x50
[ 4031.451067] RIP: 0010:text_poke+0x60/0x250
[ 4031.451528] RSP: 0000:ffffc90000f5fd78 EFLAGS: 00010286
[ 4031.452082] RAX: ffffea0000000000 RBX: ffffea000005f200 RCX: ffffffff817c88e9
[ 4031.452843] RDX: 0000000000000001 RSI: ffffc90000f5fdbf RDI: ffffffff817c88e4
[ 4031.453568] RBP: ffffffff817c88e4 R08: 0000000000000000 R09: 0000000000000001
[ 4031.454283] R10: ffffc90000f5fdf0 R11: 104eab8665f42bc7 R12: 0000000000000001
[ 4031.455010] R13: ffffc90000f5fdbf R14: ffffffff817c98e4 R15: 0000000000000000
[ 4031.455719]  ? dev_gro_receive+0x3f4/0x6f0
[ 4031.456123]  ? netif_receive_skb_internal+0x24/0x380
[ 4031.456641]  ? netif_receive_skb_internal+0x29/0x380
[ 4031.457202]  ? netif_receive_skb_internal+0x24/0x380
[ 4031.457743]  ? text_poke+0x28/0x250
[ 4031.458084]  ? netif_receive_skb_internal+0x24/0x380
[ 4031.458567]  ? netif_receive_skb_internal+0x25/0x380
[ 4031.459046]  text_poke_bp+0x55/0xe0
[ 4031.459393]  arch_jump_label_transform+0x90/0xf0
[ 4031.459842]  __jump_label_update+0x63/0x70
[ 4031.460243]  static_key_enable_cpuslocked+0x54/0x80
[ 4031.460713]  static_key_enable+0x16/0x20
[ 4031.461096]  process_one_work+0x266/0x6d0
[ 4031.461506]  worker_thread+0x3a/0x390
[ 4031.462328]  ? process_one_work+0x6d0/0x6d0
[ 4031.463299]  kthread+0x121/0x140
[ 4031.464122]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 4031.465070]  ret_from_fork+0x3a/0x50
[ 4031.465859] Code: 89 58 08 4c 89 f7 49 89 9d 20 35 ad 82 48 89 95 58 ff ff ff 4c 8d 63 10 e8 61 e4 8d 00 eb 22 e8 7a d7 0b 00 fb 66 0f 1f 44 00 00 <e8> be 64 8d 00 fa 66 0f 1f 44 00 00 e8 12 a0 0b 00 e8 cd 7a 0e 
[ 4031.468817] Kernel panic - not syncing: Machine halted.

-- 
Josh
