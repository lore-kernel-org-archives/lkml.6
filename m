Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeDHNTC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 09:19:02 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:36832 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeDHNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 09:19:00 -0400
X-Google-Smtp-Source: AIpwx4+WkHem2Vmuojlk32Bngff5HFW2mwNO4eXduJNcmmlGGs97860hvRVmGJRoxTEc9NgS4aKRoT3TtqkPnCa48og=
MIME-Version: 1.0
In-Reply-To: <20180408063114.GB9720@thunk.org>
References: <001a1148578c10e4700568e814eb@google.com> <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org> <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org> <20180405223226.GA729@dastard>
 <20180406001325.GA133204@google.com> <20180406013741.GA7345@thunk.org> <20180408063114.GB9720@thunk.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 8 Apr 2018 15:18:39 +0200
Message-ID: <CACT4Y+Ynbn9qAmk3jVBs6pUjDAz6gJMD5YHM4+EyzEuwBj+4-Q@mail.gmail.com>
Subject: Re: Running syzkaller repros using kvm-xfstests
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 8:31 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, Apr 05, 2018 at 09:37:41PM -0400, Theodore Y. Ts'o wrote:
>> Note that I haven't just been complaining about it.  I've been working
>> on ways so that the gce-xfstests and kvm-xfstests test appliances can
>> more easily be used to work on Syzbot reports.  If I can make myself
>> more efficient, or help other people be more efficient, that's
>> arguably more important than trying to fix some of the 174 currently
>> open Syzbot issues --- unless you can tell me that certain ones are
>> super urgent because they (for example) result in CVSS score > 8.
>
> I've got an initial version of this working for kvm-xfstests.  To try
> it out, grab the latest version of xfstests-bld from [1], and the
> kvm-xfstests image from [2].  For people who have never tried using
> kvm-xfstests, see [3].
>
> [1] https://github.com/tytso/xfstests-bld
> [2] https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/testing/root_fs.img.x86_64
> [3] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>
> If you're interested, please try it out, and send me comments.
>
> Sample usage:
>
> kvm-xfstest syz <path/to/repro.{c,syz}>
> kvm-xfstest syz <URL to repro.{c,syz}>
>
> Example run:
>
> % kvm-xfstests syz https://syzkaller.appspot.com/x/repro.syz?id=5709211904245760

/\/\/\/\/\/\/\/\

Nice!

But note that syzkaller is under active development, so pre-canned
binaries may not always work. Mismatching binary may not understand
all syscalls, fail to parse program, interpret arguments differently,
execute program differently, setup a different environment for the
test, etc. Now a C program captures all of this, because code that
transforms syzkaller programs into C is versioned along with the rest
of the system.
Strictly saying, for syzkaller reproducers one needs to use the exact
syzkaller revision listed along with the reproducer, see for example:
https://syzkaller.appspot.com/bug?id=3fb9c4777053e79a6d2a65ac3738664c87629a21
The "#syz test" syzbot command does this. Using a different syzkaller
revision may or may not work.



>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  Upload   Total   Spent    Left  Speed
>   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0100   533  100   533    0     0   2157      0 --:--:-- --:--:-- --:--:--  2157
> Saved downloaded copy at /tmp/tytso-downloaded-repro.syz
> Networking disabled.
> KERNEL: kernel  4.16.0-xfstests-09576-g38c23685b273 #134 SMP Sun Apr 8 01:36:01 EDT 2018 x86_64
> FSTESTVER: e2fsprogs    v1.43.6-85-g7595699d0 (Wed, 6 Sep 2017 22:04:14 -0400)
> FSTESTVER: fio          fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
> FSTESTVER: quota                59b280e (Mon, 5 Feb 2018 16:48:22 +0100)
> FSTESTVER: stress-ng    977ae35 (Wed, 6 Sep 2017 23:45:03 -0400)
> FSTESTVER: syzkaller            66f22a7f (Sat, 7 Apr 2018 14:02:03 +0200)
> FSTESTVER: xfsprogs     v4.15.1 (Mon, 26 Feb 2018 19:50:56 -0600)
> FSTESTVER: xfstests-bld 3be913e (Sun, 8 Apr 2018 01:19:21 -0400)
> FSTESTVER: xfstests     linux-v3.8-1925-g62cc6d02 (Fri, 23 Mar 2018 22:26:41 -0400)
> FSTESTCFG: "all"
> FSTESTSET: "syz/001"
> FSTESTEXC: ""
> FSTESTOPT: "aex"
> MNTOPTS: ""
> CPUS: "2"
> MEM: "1684.65"
>               total        used        free      shared  buff/cache   available
> Mem:           1684         140        1479           8          65        1507
> Swap:             0           0           0
> BEGIN TEST 4k (1 test): Ext4 4k block Sun Apr  8 01:49:02 EDT 2018
> DEVICE: /dev/vdd
> EXT_MKFS_OPTIONS: -b 4096
> EXT_MOUNT_OPTIONS: -o block_validity
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 kvm-xfstests 4.16.0-xfstests-09576-g38c23685b273
> MKFS_OPTIONS  -- -b 4096 /dev/vdc
> MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc
>
> syz/001         [01:49:04][   22.859794] run fstests syz/001 at 2018-04-08 01:49:04
> [   23.385195] EXT4-fs (vdc): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity
> [   23.797611] EXT4-fs (vda): shut down requested (0)
> [   23.855759] ------------[ cut here ]------------
> [   23.860823] DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
> [   23.860881] WARNING: CPU: 1 PID: 1332 at /usr/projects/linux/ext4/kernel/locking/rwsem.c:133 up_write+0x113/0x150
> [   23.876121] CPU: 1 PID: 1332 Comm: syz-executor0 Not tainted 4.16.0-xfstests-09576-g38c23685b273 #134
> [   23.880836] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   23.884080] RIP: 0010:up_write+0x113/0x150
> [   23.885873] RSP: 0018:ffff88005e0b7a68 EFLAGS: 00010286
> [   23.887902] RAX: dffffc0000000008 RBX: ffff880066069038 RCX: ffffffff9002f2ce
> [   23.890392] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000293
> [   23.892200] RBP: ffff8800660690a0 R08: fffffbfff245d71d R09: fffffbfff245d71d
> [   23.894877] R10: ffff88007ffca050 R11: fffffbfff245d71c R12: ffff880066068ce0
> [   23.897244] R13: ffff880066068a30 R14: ffff8800660691e0 R15: ffffffff902fe397
> [   23.899597] FS:  000000000275c940(0000) GS:ffff88006d600000(0000) knlGS:0000000000000000
> [   23.902104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.903808] CR2: 00000000006dbb18 CR3: 0000000067c7c000 CR4: 00000000000006e0
> [   23.905954] Call Trace:
> [   23.906721]  percpu_up_write+0x4c/0x60
> [   23.907868]  thaw_super+0x1c4/0x250
> [   23.908943]  thaw_bdev+0x14a/0x170
> [   23.909996]  ext4_ioctl+0x1fd8/0x39a0
> [   23.911114]  ? alloc_set_pte+0x66d/0xe50
> [   23.912318]  ? ext4_ioctl_setflags+0x600/0x600
> [   23.913672]  ? drop_futex_key_refs.isra.3+0x65/0xb0
> [   23.915106]  ? futex_wake+0x14a/0x400
> [   23.916242]  ? futex_wait_restart+0x1e0/0x1e0
> [   23.917589]  ? lock_contended+0xd30/0xd30
> [   23.918805]  ? alloc_set_pte+0x330/0xe50
> [   23.920025]  ? kvm_sched_clock_read+0x21/0x30
> [   23.921369]  ? sched_clock+0x5/0x10
> [   23.922442]  ? sched_clock_cpu+0x18/0x180
> [   23.923691]  ? do_futex+0x3ab/0xa90
> [   23.924783]  ? exit_robust_list+0x240/0x240
> [   23.926076]  ? do_raw_spin_unlock+0x54/0x220
> [   23.927388]  ? ext4_ioctl_setflags+0x600/0x600
> [   23.928758]  do_vfs_ioctl+0x18b/0xfb0
> [   23.929893]  ? ioctl_preallocate+0x1a0/0x1a0
> [   23.931204]  ? SyS_futex+0x1c9/0x270
> [   23.932304]  ? SyS_futex+0x1d2/0x270
> [   23.933412]  ? do_futex+0xa90/0xa90
> [   23.934502]  ? up_read+0x1c/0x110
> [   23.935532]  ksys_ioctl+0x42/0x80
> [   23.936564]  SyS_ioctl+0x23/0x30
> [   23.937567]  ? ksys_ioctl+0x80/0x80
> [   23.938649]  do_syscall_64+0x1a0/0x640
> [   23.939813]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [   23.941360] RIP: 0033:0x455289
> [   23.942298] RSP: 002b:00007ffea24780d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   23.944588] RAX: ffffffffffffffda RBX: 000000000070bea0 RCX: 0000000000455289
> [   23.946762] RDX: 0000000020000100 RSI: 000000008004587d RDI: 0000000000000003
> [   23.948924] RBP: 000000000275c914 R08: 0000000000000000 R09: 0000000000000000
> [   23.951102] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> [   23.953287] R13: 00000000000001c5 R14: 00000000006dbb18 R15: 00000000006d90a0
> [   23.955435] Code: 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 48 8b 05 14 d0 c2 03 85 c0 75 86 48 c7 c6 60 2c c6 91 48 c7 c7 20 2c c6 91 e8 ad da f1 ff <0f> 0b e9 6c ff ff ff e8 01 a1 2d 00 e9 2a ff ff ff 48 89 ef e8
> [   23.960064] ---[ end trace f542ead798faa3a9 ]---
>     ....
