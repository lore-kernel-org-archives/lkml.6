Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeCOGqh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:46:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:53122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbeCOGqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:46:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="34046752"
Date: Thu, 15 Mar 2018 14:37:23 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: linux-kernel@vger.kernel.org
Cc: changbin.du@intel.com
Subject: [Q] How does linux kernel lockdep record lock-class dependency?
Message-ID: <20180315063723.liagayoxeltgzow6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,
I got a warning as below which is a AB-BA deadlock issue. But I don't understand
how the 'existing dependency' happened.

It looks like: kvm_read_guest() held (&mm->mmap_sem), then reading userspace memory
(which is not ready yet) caused page_fault() invoked, then in i915_gem_fault()
it tries to hold (&dev->struct_mutex).

But this sequence must haven't happened. Otherwise, double-lock already happed,
since intel_vgpu_create_workload() has held (&dev->struct_mutex) already:

  (&dev->struct_mutex)->(&mm->mmap_sem)->(&dev->struct_mutex)

So how could lockdep find such 'existing dependency'? Thanks!

[  163.179109] ======================================================
[  163.185306] WARNING: possible circular locking dependency detected
[  163.191504] 4.16.0-rc5+ #44 Tainted: G     U
[  163.196655] ------------------------------------------------------
[  163.202854] qemu-system-x86/4514 is trying to acquire lock:
[  163.208443]  (&mm->mmap_sem){++++}, at: [<00000000bca68632>] __might_fault+0x36/0x80
[  163.216230]
               but task is already holding lock:
[  163.222090]  (&dev->struct_mutex){+.+.}, at: [<00000000a6b81a24>] copy_gma_to_hva+0xe5/0x140 [i915]
[  163.231205]
               which lock already depends on the new lock.

[  163.239421]
               the existing dependency chain (in reverse order) is:
[  163.246925]
               -> #1 (&dev->struct_mutex){+.+.}:
[  163.252792]        i915_mutex_lock_interruptible+0x66/0x170 [i915]
[  163.259005]        i915_gem_fault+0x1e0/0x630 [i915]
[  163.263985]        __do_fault+0x19/0xed
[  163.267830]        __handle_mm_fault+0x9fa/0x1140
[  163.272550]        handle_mm_fault+0x1a7/0x390
[  163.277006]        __do_page_fault+0x286/0x530
[  163.281462]        page_fault+0x45/0x50
[  163.285307]
               -> #0 (&mm->mmap_sem){++++}:
[  163.290722]        __might_fault+0x60/0x80
[  163.294839]        __kvm_read_guest_page+0x3d/0x80 [kvm]
[  163.300173]        kvm_read_guest+0x47/0x80 [kvm]
[  163.304891]        kvmgt_rw_gpa+0x9d/0x110 [kvmgt]
[  163.309714]        intel_gvt_scan_and_shadow_workload+0x1be/0x480 [i915]
[  163.316448]        intel_vgpu_create_workload+0x3d9/0x550 [i915]
[  163.322488]        intel_vgpu_submit_execlist+0xc0/0x2a0 [i915]
[  163.328440]        elsp_mmio_write+0xcb/0x140 [i915]
[  163.333448]        intel_vgpu_mmio_reg_rw+0x250/0x4f0 [i915]
[  163.339138]        intel_vgpu_emulate_mmio_write+0xaa/0x240 [i915]
[  163.345337]        intel_vgpu_rw+0x200/0x250 [kvmgt]
[  163.350319]        intel_vgpu_write+0x164/0x1f0 [kvmgt]
[  163.355558]        __vfs_write+0x33/0x170
[  163.359580]        vfs_write+0xc5/0x1c0
[  163.363427]        SyS_pwrite64+0x90/0xb0
[  163.367447]        do_syscall_64+0x70/0x1c0
[  163.371642]        entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  163.377230]
               other info that might help us debug this:

[  163.385258]  Possible unsafe locking scenario:

[  163.391196]        CPU0                    CPU1
[  163.395737]        ----                    ----
[  163.400280]   lock(&dev->struct_mutex);
[  163.404125]                                lock(&mm->mmap_sem);
[  163.410062]                                lock(&dev->struct_mutex);
[  163.416436]   lock(&mm->mmap_sem);
[  163.419846]
                *** DEADLOCK ***

[  163.425780] 3 locks held by qemu-system-x86/4514:
[  163.430496]  #0:  (&gvt->lock){+.+.}, at: [<00000000d313c2c5>] intel_vgpu_emulate_mmio_write+0x64/0x240 [i915]
[  163.440544]  #1:  (&dev->struct_mutex){+.+.}, at: [<00000000a6b81a24>] copy_gma_to_hva+0xe5/0x140 [i915]
[  163.450068]  #2:  (&kvm->srcu){....}, at: [<00000000db73c4fc>] kvmgt_rw_gpa+0x4c/0x110 [kvmgt]
[  163.458721]
               stack backtrace:
[  163.463097] CPU: 0 PID: 4514 Comm: qemu-system-x86 Tainted: G     U           4.16.0-rc5+ #44
[  163.471663] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
[  163.479093] Call Trace:
[  163.481547]  dump_stack+0x7c/0xbe
[  163.484872]  print_circular_bug.isra.33+0x21b/0x228
[  163.489765]  __lock_acquire+0xf7d/0x1470
[  163.493700]  ? lock_acquire+0xec/0x1e0
[  163.497459]  lock_acquire+0xec/0x1e0
[  163.501046]  ? __might_fault+0x36/0x80
[  163.504805]  __might_fault+0x60/0x80
[  163.508389]  ? __might_fault+0x36/0x80
[  163.512155]  __kvm_read_guest_page+0x3d/0x80 [kvm]
[  163.516966]  kvm_read_guest+0x47/0x80 [kvm]
[  163.521161]  kvmgt_rw_gpa+0x9d/0x110 [kvmgt]
[  163.525459]  intel_gvt_scan_and_shadow_workload+0x1be/0x480 [i915]
[  163.531675]  intel_vgpu_create_workload+0x3d9/0x550 [i915]
[  163.537192]  intel_vgpu_submit_execlist+0xc0/0x2a0 [i915]
[  163.542621]  elsp_mmio_write+0xcb/0x140 [i915]
[  163.547093]  intel_vgpu_mmio_reg_rw+0x250/0x4f0 [i915]
[  163.552261]  intel_vgpu_emulate_mmio_write+0xaa/0x240 [i915]
[  163.557938]  intel_vgpu_rw+0x200/0x250 [kvmgt]
[  163.562396]  intel_vgpu_write+0x164/0x1f0 [kvmgt]
[  163.567114]  __vfs_write+0x33/0x170
[  163.570614]  ? common_file_perm+0x68/0x250
[  163.574723]  ? security_file_permission+0x36/0xb0
[  163.579440]  vfs_write+0xc5/0x1c0
[  163.582765]  SyS_pwrite64+0x90/0xb0
[  163.586261]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  163.590980]  do_syscall_64+0x70/0x1c0
[  163.594653]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  163.599720] RIP: 0033:0x7f88649bcda3
[  163.603303] RSP: 002b:00007f8854d5c6c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
[  163.610896] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f88649bcda3
[  163.618051] RDX: 0000000000000004 RSI: 00007f8854d5c6f0 RDI: 0000000000000019
[  163.625206] RBP: 00007f8854d5c710 R08: 0000000000000004 R09: 00000000ffffffff
[  163.632363] R10: 0000000000002230 R11: 0000000000000293 R12: 0000000000000000
[  163.639518] R13: 00007ffcc49b9a3f R14: 00007f8854d5d9c0 R15: 0000000000000000

-- 
Thanks,
Changbin Du
