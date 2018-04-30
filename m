Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeD3C4T (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 22:56:19 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:60182 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeD3C4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 22:56:18 -0400
Date: Sun, 29 Apr 2018 22:56:16 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>
Subject: fscache kasan splat on v4.17-rc3
Message-ID: <20180430025616.jzgmye22c4tsd5ey@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[   46.333213] ==================================================================
[   46.336298] BUG: KASAN: slab-out-of-bounds in fscache_alloc_cookie+0x129/0x310
[   46.338208] Read of size 4 at addr ffff8803ea90261c by task mount.nfs/839

[   46.342780] CPU: 2 PID: 839 Comm: mount.nfs Not tainted 4.17.0-rc3-backup-debug+ #1
[   46.342783] Hardware name: ASUS All Series/Z97-DELUXE, BIOS 2602 08/18/2015
[   46.342784] Call Trace:
[   46.342790]  dump_stack+0x74/0xbb
[   46.342795]  print_address_description+0x9b/0x2b0
[   46.342797]  kasan_report+0x258/0x380
[   46.355407]  ? fscache_alloc_cookie+0x129/0x310
[   46.355410]  fscache_alloc_cookie+0x129/0x310
[   46.355413]  __fscache_acquire_cookie+0xd2/0x570
[   46.355417]  nfs_fscache_get_client_cookie+0x206/0x220
[   46.355419]  ? nfs_readpage_from_fscache_complete+0xa0/0xa0
[   46.355422]  ? rcu_read_lock_sched_held+0x8a/0xa0
[   46.355426]  ? memcpy+0x34/0x50
[   46.355428]  nfs_alloc_client+0x1d9/0x1f0
[   46.371854]  nfs4_alloc_client+0x22/0x420
[   46.371857]  nfs_get_client+0x47d/0x8f0
[   46.371860]  ? pcpu_alloc+0x599/0xaf0
[   46.371862]  nfs4_set_client+0x155/0x1e0
[   46.371865]  ? nfs4_check_serverowner_major_id+0x50/0x50
[   46.371867]  nfs4_create_server+0x261/0x4e0
[   46.371870]  ? nfs4_set_ds_client+0x200/0x200
[   46.371872]  ? alloc_vfsmnt+0xa6/0x360
[   46.371875]  ? __lockdep_init_map+0xaa/0x290
[   46.371878]  nfs4_remote_mount+0x31/0x60
[   46.371880]  mount_fs+0x2f/0xd0
[   46.371884]  vfs_kern_mount+0x68/0x200
[   46.396948]  nfs_do_root_mount+0x7f/0xc0
[   46.396952]  ? do_raw_spin_unlock+0xa2/0x130
[   46.396954]  nfs4_try_mount+0x7f/0x110
[   46.396957]  nfs_fs_mount+0xca5/0x1450
[   46.396960]  ? pcpu_alloc+0x599/0xaf0
[   46.396962]  ? nfs_remount+0x8a0/0x8a0
[   46.396964]  ? mark_held_locks+0x1c/0xb0
[   46.396967]  ? __raw_spin_lock_init+0x1c/0x70
[   46.412631]  ? trace_hardirqs_on_caller+0x187/0x260
[   46.412633]  ? nfs_clone_super+0x150/0x150
[   46.412635]  ? nfs_destroy_inode+0x20/0x20
[   46.412637]  ? __lockdep_init_map+0xaa/0x290
[   46.412639]  ? __lockdep_init_map+0xaa/0x290
[   46.412641]  ? mount_fs+0x2f/0xd0
[   46.412642]  mount_fs+0x2f/0xd0
[   46.412645]  vfs_kern_mount+0x68/0x200
[   46.412648]  ? do_raw_read_unlock+0x28/0x50
[   46.412651]  do_mount+0x2ac/0x14f0
[   46.412653]  ? copy_mount_string+0x20/0x20
[   46.431590]  ? copy_mount_options+0xe6/0x1b0
[   46.431592]  ? copy_mount_options+0x100/0x1b0
[   46.431594]  ? copy_mount_options+0xe6/0x1b0
[   46.431596]  ksys_mount+0x7e/0xd0
[   46.431599]  __x64_sys_mount+0x62/0x70
[   46.431601]  do_syscall_64+0xc7/0x8a0
[   46.431603]  ? syscall_return_slowpath+0x3c0/0x3c0
[   46.431605]  ? mark_held_locks+0x1c/0xb0
[   46.431609]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[   46.431611]  ? trace_hardirqs_off_caller+0xc2/0x110
[   46.431613]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   46.431615]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   46.431617] RIP: 0033:0x7f546ceb97fa
[   46.431619] RSP: 002b:00007ffdf1c9d078 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[   46.431622] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f546ceb97fa
[   46.431623] RDX: 000055decf202b20 RSI: 000055decf202b40 RDI: 000055decf204850
[   46.431625] RBP: 00007ffdf1c9d1d0 R08: 000055decf206680 R09: 62353a303036343a
[   46.431626] R10: 0000000000000c00 R11: 0000000000000206 R12: 00007ffdf1c9d1d0
[   46.431627] R13: 000055decf205870 R14: 000000000000001c R15: 00007ffdf1c9d0e0

[   46.431631] Allocated by task 839:
[   46.431634]  kasan_kmalloc+0xa0/0xd0
[   46.431636]  __kmalloc+0x156/0x350
[   46.431639]  fscache_alloc_cookie+0x2e4/0x310
[   46.431640]  __fscache_acquire_cookie+0xd2/0x570
[   46.431643]  nfs_fscache_get_client_cookie+0x206/0x220
[   46.431645]  nfs_alloc_client+0x1d9/0x1f0
[   46.431648]  nfs4_alloc_client+0x22/0x420
[   46.431650]  nfs_get_client+0x47d/0x8f0
[   46.431652]  nfs4_set_client+0x155/0x1e0
[   46.431653]  nfs4_create_server+0x261/0x4e0
[   46.431655]  nfs4_remote_mount+0x31/0x60
[   46.431657]  mount_fs+0x2f/0xd0
[   46.431659]  vfs_kern_mount+0x68/0x200
[   46.431662]  nfs_do_root_mount+0x7f/0xc0
[   46.484441]  nfs4_try_mount+0x7f/0x110
[   46.484443]  nfs_fs_mount+0xca5/0x1450
[   46.484445]  mount_fs+0x2f/0xd0
[   46.484447]  vfs_kern_mount+0x68/0x200
[   46.484449]  do_mount+0x2ac/0x14f0
[   46.484451]  ksys_mount+0x7e/0xd0
[   46.484452]  __x64_sys_mount+0x62/0x70
[   46.484455]  do_syscall_64+0xc7/0x8a0
[   46.484458]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   46.484461] Freed by task 407:
[   46.499159]  __kasan_slab_free+0x11d/0x160
[   46.499161]  kfree+0xe5/0x320
[   46.499163]  kobject_uevent_env+0x1ab/0x760
[   46.499165]  kobject_synth_uevent+0x470/0x4e0
[   46.499168]  uevent_store+0x1c/0x40
[   46.499171]  kernfs_fop_write+0x196/0x230
[   46.499174]  __vfs_write+0xc5/0x310
[   46.499175]  vfs_write+0xfb/0x250
[   46.499177]  ksys_write+0xa7/0x130
[   46.499180]  do_syscall_64+0xc7/0x8a0
[   46.512915]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   46.512921] The buggy address belongs to the object at ffff8803ea902608
                which belongs to the cache kmalloc-32 of size 32
[   46.512924] The buggy address is located 20 bytes inside of
                32-byte region [ffff8803ea902608, ffff8803ea902628)
[   46.512926] The buggy address belongs to the page:
[   46.512930] page:ffffea000faa4080 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
[   46.522527] flags: 0x8000000000008100(slab|head)
[   46.522530] raw: 8000000000008100 0000000000000000 0000000000000000 0000000100150015
[   46.522532] raw: ffffea000facb320 ffffea000fac8520 ffff880107c0c5c0 0000000000000000
[   46.522534] page dumped because: kasan: bad access detected

[   46.522535] Memory state around the buggy address:
[   46.522537]  ffff8803ea902500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.522539]  ffff8803ea902580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.522541] >ffff8803ea902600: fc 00 00 06 fc fc fc fc fc fc fc fc fc fc fc fc
[   46.522542]                             ^
[   46.522543]  ffff8803ea902680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.522545]  ffff8803ea902700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.522547] ==================================================================
