Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeFBKra (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:47:30 -0400
Received: from srv2.anyservers.com ([77.79.239.202]:44134 "EHLO
        srv2.anyservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeFBKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:47:26 -0400
Date: Sat, 2 Jun 2018 11:56:24 +0200
From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= <amade@asmblr.net>
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: "Jason Cai (Xiang Feng)" <jason.cai@linux.alibaba.com>
Subject: bisected 4.17-rc - BUG: Bad page state in process qemu-system-x86
 pfn:7178f3
Message-ID: <20180602115624.55c727a9@milkyway.zone>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv2.anyservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - asmblr.net
X-Get-Message-Sender-Via: srv2.anyservers.com: authenticated_id: amade@asmblr.net
X-Authenticated-Sender: srv2.anyservers.com: amade@asmblr.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

so I've been getting system instability problems after shutting down
virtual machine with GPU pass-through in 4.17-rc series and I finally
got around to bisecting it.

Seems to be caused by 356e88ebe4473a3663cf3d14727ce293a4526d34
and problem seems to be gone after reverting it.

trce from /varlog/messages:

Jun  1 22:47:23 milkyway kernel: BUG: Bad page state in process qemu-system-x86  pfn:7178f3
Jun  1 22:47:23 milkyway kernel: page:fffffbfddc5e3cc0 count:0 mapcount:1 mapping:0000000000000000 index:0x1
Jun  1 22:47:23 milkyway kernel: flags: 0x200000000000000()
Jun  1 22:47:23 milkyway kernel: raw: 0200000000000000 0000000000000000 0000000000000001 0000000000000000
Jun  1 22:47:23 milkyway kernel: raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
Jun  1 22:47:23 milkyway kernel: page dumped because: nonzero mapcount
Jun  1 22:47:23 milkyway kernel: Modules linked in: x86_pkg_temp_thermal coretemp crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc aesni_intel eeepc_wmi asus_wmi wmi_bmof aes_x86_64 crypto_simd cryptd wmi glue_helper
Jun  1 22:47:23 milkyway kernel: CPU: 4 PID: 4303 Comm: qemu-system-x86 Not tainted 4.16.0+ #26
Jun  1 22:47:23 milkyway kernel: Hardware name: ASUS All Series/SABERTOOTH Z97 MARK 2, BIOS 3503 04/18/2018
Jun  1 22:47:23 milkyway kernel: Call Trace:
Jun  1 22:47:23 milkyway kernel:  dump_stack+0x46/0x5b
Jun  1 22:47:23 milkyway kernel:  bad_page+0xbf/0x120
Jun  1 22:47:23 milkyway kernel:  free_pcppages_bulk+0x434/0x500
Jun  1 22:47:23 milkyway kernel:  free_unref_page+0x33/0x40
Jun  1 22:47:23 milkyway kernel:  dma_free_pagelist+0x27/0x40
Jun  1 22:47:23 milkyway kernel:  intel_iommu_unmap+0x114/0x150
Jun  1 22:47:23 milkyway kernel:  __iommu_unmap+0xe4/0x130
Jun  1 22:47:23 milkyway kernel:  vfio_unmap_unpin+0x13f/0x330
Jun  1 22:47:23 milkyway kernel:  vfio_remove_dma+0x12/0x40
Jun  1 22:47:23 milkyway kernel:  vfio_iommu_unmap_unpin_all+0x16/0x30
Jun  1 22:47:23 milkyway kernel:  vfio_iommu_type1_detach_group+0x2b3/0x2c0
Jun  1 22:47:23 milkyway kernel:  __vfio_group_unset_container+0x4d/0x180
Jun  1 22:47:23 milkyway kernel:  vfio_group_put_external_user+0x9/0x20
Jun  1 22:47:23 milkyway kernel:  kvm_vfio_group_put_external_user+0x1d/0x30
Jun  1 22:47:23 milkyway kernel:  kvm_vfio_destroy+0x4a/0xc0
Jun  1 22:47:23 milkyway kernel:  kvm_put_kvm+0x1a1/0x290
Jun  1 22:47:23 milkyway kernel:  kvm_vm_release+0x18/0x20
Jun  1 22:47:23 milkyway kernel:  __fput+0xcd/0x1f0
Jun  1 22:47:23 milkyway kernel:  task_work_run+0x8d/0xb0
Jun  1 22:47:23 milkyway kernel:  do_exit+0x2d9/0xbe0
Jun  1 22:47:23 milkyway kernel:  ? hrtimer_init+0x10/0x10
Jun  1 22:47:23 milkyway kernel:  do_group_exit+0x31/0xb0
Jun  1 22:47:23 milkyway kernel:  get_signal+0x12d/0x570
Jun  1 22:47:23 milkyway kernel:  do_signal+0x3e/0x5d0
Jun  1 22:47:23 milkyway kernel:  exit_to_usermode_loop+0x46/0x80
Jun  1 22:47:23 milkyway kernel:  do_syscall_64+0xe0/0xf0
Jun  1 22:47:23 milkyway kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Jun  1 22:47:23 milkyway kernel: RIP: 0033:0x7e7c7512750f
Jun  1 22:47:23 milkyway kernel: RSP: 002b:00007e77df3f29d0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
Jun  1 22:47:23 milkyway kernel: RAX: fffffffffffffdfc RBX: 0000000000000189 RCX: 00007e7c7512750f
Jun  1 22:47:23 milkyway kernel: RDX: 0000000000000000 RSI: 0000000000000189 RDI: 000057066f99c0a8
Jun  1 22:47:23 milkyway kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
Jun  1 22:47:23 milkyway kernel: R10: 00007e77df3f2a80 R11: 0000000000000246 R12: 00007e77df3f2a80
Jun  1 22:47:23 milkyway kernel: R13: 000057066f99c0a8 R14: 00007e77df3f2a80 R15: 00007fff7e253a30
Jun  1 22:47:23 milkyway kernel: Disabling lock debugging due to kernel taint



git bisect log

git bisect start
# good: [0adb32858b0bddf4ada5f364a84ed60b196dbcda] Linux 4.16
git bisect good 0adb32858b0bddf4ada5f364a84ed60b196dbcda
# bad: [60cc43fc888428bb2f18f08997432d426a243338] Linux 4.17-rc1
git bisect bad 60cc43fc888428bb2f18f08997432d426a243338
# good: [ac9053d2dcb9e8c3fa35ce458dfca8fddc141680] Merge tag 'usb-4.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good ac9053d2dcb9e8c3fa35ce458dfca8fddc141680
# good: [38c23685b273cfb4ccf31a199feccce3bdcb5d83] Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 38c23685b273cfb4ccf31a199feccce3bdcb5d83
# bad: [fbe173e3ffbd897b5a859020d714c0eaf4af2a1a] Merge tag 'rtc-4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect bad fbe173e3ffbd897b5a859020d714c0eaf4af2a1a
# bad: [299f89d53e61c0b17479cc7d6f3b5382d5e83f28] Merge tag 'leaks-4.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks
git bisect bad 299f89d53e61c0b17479cc7d6f3b5382d5e83f28
# good: [28da7be5ebc096ada5e6bc526c623bdd8c47800a] Merge tag 'mailbox-v4.17' of git://git.linaro.org/landing-teams/working/fujitsu/integration
git bisect good 28da7be5ebc096ada5e6bc526c623bdd8c47800a
# good: [19fd08b85bc7e0502b55cd726f466df82ee7e777] Merge tag 'for-linus-unmerged' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good 19fd08b85bc7e0502b55cd726f466df82ee7e777
# good: [14d8d776aeda8e367a9354b6cb6a0696671630c9] Merge branch 'lorenzo/pci/endpoint'
git bisect good 14d8d776aeda8e367a9354b6cb6a0696671630c9
# bad: [f605ba97fb80522656c7dce9825a908f1e765b57] Merge tag 'vfio-v4.17-rc1' of git://github.com/awilliam/linux-vfio
git bisect bad f605ba97fb80522656c7dce9825a908f1e765b57
# good: [d2f48c5d7fd791104f3227d8e6b55fca892eb2ba] Merge branch 'lorenzo/pci/xgene'
git bisect good d2f48c5d7fd791104f3227d8e6b55fca892eb2ba
# good: [dc32bb678e103afbcfa4d814489af0566307f528] vhost: add vsock compat ioctl
git bisect good dc32bb678e103afbcfa4d814489af0566307f528
# bad: [da9147140fe3de5a3a3fe5fe7f69739d4f39bea1] MAINTAINERS: vfio/platform: Update sub-maintainer
git bisect bad da9147140fe3de5a3a3fe5fe7f69739d4f39bea1
# bad: [356e88ebe4473a3663cf3d14727ce293a4526d34] vfio/type1: Improve memory pinning process for raw PFN mapping
git bisect bad 356e88ebe4473a3663cf3d14727ce293a4526d34
# good: [c9f89c3f87cfc026d88c08054710902dd52a7772] vfio-mdev/samples: change RDI interrupt condition
git bisect good c9f89c3f87cfc026d88c08054710902dd52a7772
# first bad commit: [356e88ebe4473a3663cf3d14727ce293a4526d34] vfio/type1: Improve memory pinning process for raw PFN mapping


Cheers,
Amadeusz
